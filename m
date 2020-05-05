Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A231F1C53D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 13:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgEELED (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 07:04:03 -0400
Received: from verein.lst.de ([213.95.11.211]:34717 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgEELED (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 07:04:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 11E5F68C4E; Tue,  5 May 2020 13:03:59 +0200 (CEST)
Date:   Tue, 5 May 2020 13:03:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 4/5] binfmt_elf, binfmt_elf_fdpic: Use a VMA list
 snapshot
Message-ID: <20200505110358.GC17400@lst.de>
References: <20200429214954.44866-1-jannh@google.com> <20200429214954.44866-5-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429214954.44866-5-jannh@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 11:49:53PM +0200, Jann Horn wrote:
> In both binfmt_elf and binfmt_elf_fdpic, use a new helper
> dump_vma_snapshot() to take a snapshot of the VMA list (including the gate
> VMA, if we have one) while protected by the mmap_sem, and then use that
> snapshot instead of walking the VMA list without locking.
> 
> An alternative approach would be to keep the mmap_sem held across the
> entire core dumping operation; however, keeping the mmap_sem locked while
> we may be blocked for an unbounded amount of time (e.g. because we're
> dumping to a FUSE filesystem or so) isn't really optimal; the mmap_sem
> blocks things like the ->release handler of userfaultfd, and we don't
> really want critical system daemons to grind to a halt just because someone
> "gifted" them SCM_RIGHTS to an eternally-locked userfaultfd, or something
> like that.
> 
> Since both the normal ELF code and the FDPIC ELF code need this
> functionality (and if any other binfmt wants to add coredump support in the
> future, they'd probably need it, too), implement this with a common helper
> in fs/coredump.c.
> 
> A downside of this approach is that we now need a bigger amount of kernel
> memory per userspace VMA in the normal ELF case, and that we need O(n)
> kernel memory in the FDPIC ELF case at all; but 40 bytes per VMA shouldn't
> be terribly bad.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  fs/binfmt_elf.c          | 152 +++++++++++++--------------------------
>  fs/binfmt_elf_fdpic.c    |  86 ++++++++++------------
>  fs/coredump.c            |  68 ++++++++++++++++++
>  include/linux/coredump.h |  10 +++
>  4 files changed, 168 insertions(+), 148 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index fb36469848323..dffe9dc8497ca 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1292,8 +1292,12 @@ static bool always_dump_vma(struct vm_area_struct *vma)
>  	return false;
>  }
>  
> +#define DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER 1
> +
>  /*
>   * Decide what to dump of a segment, part, all or none.
> + * The result must be fixed up via vma_dump_size_fixup() once we're in a context
> + * that's allowed to sleep arbitrarily long.
>   */
>  static unsigned long vma_dump_size(struct vm_area_struct *vma,
>  				   unsigned long mm_flags)
> @@ -1348,30 +1352,15 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
>  
>  	/*
>  	 * If this looks like the beginning of a DSO or executable mapping,
> -	 * check for an ELF header.  If we find one, dump the first page to
> -	 * aid in determining what was mapped here.
> +	 * we'll check for an ELF header. If we find one, we'll dump the first
> +	 * page to aid in determining what was mapped here.
> +	 * However, we shouldn't sleep on userspace reads while holding the
> +	 * mmap_sem, so we just return a placeholder for now that will be fixed
> +	 * up later in vma_dump_size_fixup().
>  	 */
>  	if (FILTER(ELF_HEADERS) &&
> -	    vma->vm_pgoff == 0 && (vma->vm_flags & VM_READ)) {
> -		u32 __user *header = (u32 __user *) vma->vm_start;
> -		u32 word;
> -		/*
> -		 * Doing it this way gets the constant folded by GCC.
> -		 */
> -		union {
> -			u32 cmp;
> -			char elfmag[SELFMAG];
> -		} magic;
> -		BUILD_BUG_ON(SELFMAG != sizeof word);
> -		magic.elfmag[EI_MAG0] = ELFMAG0;
> -		magic.elfmag[EI_MAG1] = ELFMAG1;
> -		magic.elfmag[EI_MAG2] = ELFMAG2;
> -		magic.elfmag[EI_MAG3] = ELFMAG3;
> -		if (unlikely(get_user(word, header)))
> -			word = 0;
> -		if (word == magic.cmp)
> -			return PAGE_SIZE;
> -	}
> +	    vma->vm_pgoff == 0 && (vma->vm_flags & VM_READ))
> +		return DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER;
>  
>  #undef	FILTER
>  
> @@ -1381,6 +1370,22 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
>  	return vma->vm_end - vma->vm_start;
>  }
>  
> +/* Fix up the result from vma_dump_size(), now that we're allowed to sleep. */
> +static void vma_dump_size_fixup(struct core_vma_metadata *meta)
> +{
> +	char elfmag[SELFMAG];
> +
> +	if (meta->dump_size != DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER)
> +		return;
> +
> +	if (copy_from_user(elfmag, (void __user *)meta->start, SELFMAG)) {
> +		meta->dump_size = 0;
> +		return;
> +	}
> +	meta->dump_size =
> +		(memcmp(elfmag, ELFMAG, SELFMAG) == 0) ? PAGE_SIZE : 0;
> +}

While this code looks entirely correct, it took me way too long to
follow.  I'd take te DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER into the caller,
and then have a simple function like this:

static void vma_dump_size_fixup(struct core_vma_metadata *meta)
{
	char elfmag[SELFMAG];

	if (copy_from_user(elfmag, (void __user *)meta->start, SELFMAG) ||
	    memcmp(elfmag, ELFMAG, sizeof(elfmag)) != 0)
		meta->dump_size = 0;
	else
		meta->dump_size = PAGE_SIZE;
}

Also a few comments explaining why we do this fixup would help readers
of the code.

> -		if (vma->vm_flags & VM_WRITE)
> -			phdr.p_flags |= PF_W;
> -		if (vma->vm_flags & VM_EXEC)
> -			phdr.p_flags |= PF_X;
> +		phdr.p_flags = meta->flags & VM_READ ? PF_R : 0;
> +		phdr.p_flags |= meta->flags & VM_WRITE ? PF_W : 0;
> +		phdr.p_flags |= meta->flags & VM_EXEC ? PF_X : 0;

Sorry for another nitpick, but I find the spelled out version with the
if a lot easier to read.

> +int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
> +	struct core_vma_metadata **vma_meta,
> +	unsigned long (*dump_size_cb)(struct vm_area_struct *, unsigned long))

Plase don't use single tabs for indentating parameter continuations
(we actually have two styles - either two tabs or aligned after the
opening brace, pick your poison :))

> +	*vma_meta = kvmalloc_array(*vma_count, sizeof(**vma_meta), GFP_KERNEL);
> +	if (!*vma_meta) {
> +		up_read(&mm->mmap_sem);
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
> +			vma = next_vma(vma, gate_vma)) {
> +		(*vma_meta)[i++] = (struct core_vma_metadata) {
> +			.start = vma->vm_start,
> +			.end = vma->vm_end,
> +			.flags = vma->vm_flags,
> +			.dump_size = dump_size_cb(vma, cprm->mm_flags)
> +		};

This looks a little weird.  Why not kcalloc + just initialize the four
fields we actually fill out here?
