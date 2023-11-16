Return-Path: <linux-fsdevel+bounces-2974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7889D7EE64F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 19:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C7A1F25447
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 18:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAFC46550;
	Thu, 16 Nov 2023 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGth4ze2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA7F18D
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 10:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700157637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N8jO9uVCVvhZ4+F5Z/aAV+bkiow5OoBo+Ba5OJ/kTx4=;
	b=BGth4ze29auo2SBRCFnPXh/jzhAIpQyNUDhITRP9XoXduAGk6KIt3wx6dkUu3JuAy7CooE
	Tvd5Gcda3PWF+fzsAYMsSOCBRwWy7uKNNwfIP0STBmyKZrdJo9WD7wvtpNnDmgHTdG8TsM
	3OPmw7386jBMKSbTmJZUdMCBpVDdWYw=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-TV7gMCdLPQ6s2GkX_6edcA-1; Thu, 16 Nov 2023 13:00:35 -0500
X-MC-Unique: TV7gMCdLPQ6s2GkX_6edcA-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7b9f985f88aso94219241.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 10:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700157635; x=1700762435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8jO9uVCVvhZ4+F5Z/aAV+bkiow5OoBo+Ba5OJ/kTx4=;
        b=cmXnuJ5T8EvTtrPByA96wQesMLldS5r5PBNEFOuhX2+201hr91m8rM84T7OBcGLwDl
         k/+E+p0W5udUcyIoX+1PYCxLX5k9ojwyh1vJRgHI/PpFFzZTExwWUj4ECm7G+H+QEF30
         aiMTQh3PXmRGYWm1gGrlq9gk0NMcMwQKVYh4vREqJC16l0rTlcKq6K1Cu0HIZMU1/eaM
         Cns5RgKWzURILKfc8jJw7Yq2w9Iz+j6tijA5NQOHaA3d+Nvbc88iqvAYSaPDBDe2RZYI
         FKz7wXF1IGgTjLffKiiMtKNK/a+pGiboPrV7cEp+94vwbj12YBoFTy+QG5OHiCW9Spzz
         h+mw==
X-Gm-Message-State: AOJu0YxpolDaSe9eeMwzpjMLERKKDu6vmWP5eUrP/q3dqS2TOnJ+a74X
	n0+H87sbLGrJi/e1U/1on0uDgVbnTCc7Dvrd42E/3A0v1fq8JXg+NQ8qNSJD/XhW1fs2qh9i13x
	oWWafgUQUNy9T6RyjNCkgPe3iyw==
X-Received: by 2002:a05:6102:829:b0:45d:980e:3ed3 with SMTP id k9-20020a056102082900b0045d980e3ed3mr9153566vsb.2.1700157634879;
        Thu, 16 Nov 2023 10:00:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjlx2i9Ecbtzr2CDgQi1gmLu8Y3djYZNYe6HZLBLTwmeOV8N9LjfNDVhKt20y4veYCOA4sOw==
X-Received: by 2002:a05:6102:829:b0:45d:980e:3ed3 with SMTP id k9-20020a056102082900b0045d980e3ed3mr9153205vsb.2.1700157632968;
        Thu, 16 Nov 2023 10:00:32 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id jy8-20020a0562142b4800b0065d0d0c752csm1529026qvb.116.2023.11.16.10.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:00:32 -0800 (PST)
Date: Thu, 16 Nov 2023 13:00:30 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	syzbot <syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
	wangkefeng.wang@huawei.com
Subject: Re: [syzbot] [mm?] WARNING in unmap_page_range (2)
Message-ID: <ZVZYvleasZddv-TD@x1n>
References: <000000000000b0e576060a30ee3b@google.com>
 <20231115140006.cc7de06f89b1f885f4583af0@linux-foundation.org>
 <a8349273-c512-4d23-bf85-5812d2a007d1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8349273-c512-4d23-bf85-5812d2a007d1@redhat.com>

On Thu, Nov 16, 2023 at 10:19:13AM +0100, David Hildenbrand wrote:
> On 15.11.23 23:00, Andrew Morton wrote:
> > On Wed, 15 Nov 2023 05:32:19 -0800 syzbot <syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com> wrote:
> > 
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    ac347a0655db Merge tag 'arm64-fixes' of git://git.kernel.o..
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=15ff3057680000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=287570229f5c0a7c
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=7ca4b2719dc742b8d0a4
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162a25ff680000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d62338e80000
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/00e30e1a5133/disk-ac347a06.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/07c43bc37935/vmlinux-ac347a06.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/c6690c715398/bzImage-ac347a06.xz
> > > 
> > > The issue was bisected to:
> > > 
> > > commit 12f6b01a0bcbeeab8cc9305673314adb3adf80f7
> > > Author: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > > Date:   Mon Aug 21 14:15:15 2023 +0000
> > > 
> > >      fs/proc/task_mmu: add fast paths to get/clear PAGE_IS_WRITTEN flag
> > 
> > Thanks.  The bisection is surprising, but the mentioned patch does
> > mess with pagemap.
> > 
> > How about we add this?
> > 
> > From: Andrew Morton <akpm@linux-foundation.org>
> > Subject: mm/memory.c:zap_pte_range() print bad swap entry
> > Date: Wed Nov 15 01:54:18 PM PST 2023
> > 
> > We have a report of this WARN() triggering.  Let's print the offending
> > swp_entry_t to help diagnosis.
> > 
> > Link: https://lkml.kernel.org/r/000000000000b0e576060a30ee3b@google.com
> > Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > 
> >   mm/memory.c |    1 +
> >   1 file changed, 1 insertion(+)
> > 
> > --- a/mm/memory.c~a
> > +++ a/mm/memory.c
> > @@ -1521,6 +1521,7 @@ static unsigned long zap_pte_range(struc
> >   				continue;
> >   		} else {
> >   			/* We should have covered all the swap entry types */
> > +			pr_alert("unrecognized swap entry 0x%lx\n", entry.val);
> >   			WARN_ON_ONCE(1);
> >   		}
> >   		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> > _
> > 
> 
> I'm curious if
> 
> 1) make_uffd_wp_pte() won't end up overwriting existing pte markers, for
>    example, if PTE_MARKER_POISONED is set. [unrelated to this bug]

It should be fine, as:

static void make_uffd_wp_pte(struct vm_area_struct *vma,
			     unsigned long addr, pte_t *pte)
{
	pte_t ptent = ptep_get(pte);

#ifndef CONFIG_USERFAULTFD_

	if (pte_present(ptent)) {
		pte_t old_pte;

		old_pte = ptep_modify_prot_start(vma, addr, pte);
		ptent = pte_mkuffd_wp(ptent);
		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
	} else if (is_swap_pte(ptent)) {
		ptent = pte_swp_mkuffd_wp(ptent);
		set_pte_at(vma->vm_mm, addr, pte, ptent);
	} else {                                      <----------------- this must be pte_none() already
		set_pte_at(vma->vm_mm, addr, pte,
			   make_pte_marker(PTE_MARKER_UFFD_WP));
	}
}

> 
> 2) We get the error on arm64, which does *not* support uffd-wp. Do we
>    maybe end up calling make_uffd_wp_pte() and place a pte marker, even
>    though we don't have CONFIG_PTE_MARKER_UFFD_WP?
> 
> 
> static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
> {
> #ifdef CONFIG_PTE_MARKER_UFFD_WP
> 	return is_pte_marker_entry(entry) &&
> 	    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
> #else
> 	return false;
> #endif
> }
> 
> Will always return false without CONFIG_PTE_MARKER_UFFD_WP.
> 
> But make_uffd_wp_pte() might just happily place an entry. Hm.
> 
> 
> The following might fix the problem:
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 51e0ec658457..ae1cf19918d3 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1830,8 +1830,10 @@ static void make_uffd_wp_pte(struct vm_area_struct
> *vma,
>                 ptent = pte_swp_mkuffd_wp(ptent);
>                 set_pte_at(vma->vm_mm, addr, pte, ptent);
>         } else {
> +#ifdef CONFIG_PTE_MARKER_UFFD_WP
>                 set_pte_at(vma->vm_mm, addr, pte,
>                            make_pte_marker(PTE_MARKER_UFFD_WP));
> +#endif
>         }
>  }

I'd like to double check with Muhammad (as I didn't actually follow his
work in the latest versions.. quite a lot changed), but I _think_
fundamentally we missed something important in the fast path, and I think
it applies even to archs that support uffd..

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e91085d79926..3b81baabd22a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2171,7 +2171,8 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
                return 0;
        }

-       if (!p->vec_out) {
+       if (!p->vec_out &&
+           (p->arg.flags & PM_SCAN_WP_MATCHING))
                /* Fast path for performing exclusive WP */
                for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
                        if (pte_uffd_wp(ptep_get(pte)))

There's yet another report in fs list that triggers other issues:

https://lore.kernel.org/all/000000000000773fa7060a31e2cc@google.com/

I'll think over that and I plan to prepare a small patchset to fix all I
saw.

Thanks,

-- 
Peter Xu


