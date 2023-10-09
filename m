Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CB47BE497
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 17:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376759AbjJIPWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 11:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376720AbjJIPWg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:22:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495C3AC;
        Mon,  9 Oct 2023 08:22:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB1E11F381;
        Mon,  9 Oct 2023 15:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696864953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eZqJTmyvE7mhkAtJX6OCEVRGyjVQ+wuvXLRQc/KygIM=;
        b=prD+g92Oe2E1hoxZeoUq4sNGzLyrkDszUl/+fYGQL/mO/ZQRXFcl+U1jQFvuyok86SUFo5
        /PbYJQUR2hD10n1xl7zoCGLi4T+1EA5DOIsuSHpxFeLmIok+4iBrvRTgRz2I+/bZpL/vdT
        tUx1XcNwQ/k98edF7nDWmJV0zeTDujc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696864953;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eZqJTmyvE7mhkAtJX6OCEVRGyjVQ+wuvXLRQc/KygIM=;
        b=QFDtSTrwRWiNzGZUGJoPHpQNX86CdoTFOnGyP+IfqorYVLvC+XzbUrfuFBOuPPKNt/DqUh
        a63Nu82yuWYme4CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C899913586;
        Mon,  9 Oct 2023 15:22:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yNRaMLkaJGXQLQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 09 Oct 2023 15:22:33 +0000
Message-ID: <6feb6f37-dfb9-0fe1-1303-2744ad2758d9@suse.cz>
Date:   Mon, 9 Oct 2023 17:22:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] mm: abstract the vma_merge()/split_vma() pattern for
 mprotect() et al.
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <cover.1696795837.git.lstoakes@gmail.com>
 <e5b228493b81d00fe3d82bd464976348df353733.1696795837.git.lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <e5b228493b81d00fe3d82bd464976348df353733.1696795837.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/23 22:23, Lorenzo Stoakes wrote:
> mprotect() and other functions which change VMA parameters over a range
> each employ a pattern of:-
> 
> 1. Attempt to merge the range with adjacent VMAs.
> 2. If this fails, and the range spans a subset of the VMA, split it
> accordingly.
> 
> This is open-coded and duplicated in each case. Also in each case most of
> the parameters passed to vma_merge() remain the same.
> 
> Create a new static function, vma_modify(), which abstracts this operation,
> accepting only those parameters which can be changed.
> 
> To avoid the mess of invoking each function call with unnecessary
> parameters, create wrapper functions for each of the modify operations,
> parameterised only by what is required to perform the action.

Nice!

> Note that the userfaultfd_release() case works even though it does not
> split VMAs - since start is set to vma->vm_start and end is set to
> vma->vm_end, the split logic does not trigger.
> 
> In addition, since we calculate pgoff to be equal to vma->vm_pgoff + (start
> - vma->vm_start) >> PAGE_SHIFT, and start - vma->vm_start will be 0 in this
> instance, this invocation will remain unchanged.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  fs/userfaultfd.c   | 53 +++++++++-----------------
>  include/linux/mm.h | 23 ++++++++++++
>  mm/madvise.c       | 25 ++++---------
>  mm/mempolicy.c     | 20 ++--------
>  mm/mlock.c         | 24 ++++--------
>  mm/mmap.c          | 93 ++++++++++++++++++++++++++++++++++++++++++++++
>  mm/mprotect.c      | 27 ++++----------
>  7 files changed, 157 insertions(+), 108 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index a7c6ef764e63..9e5232d23927 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -927,11 +927,10 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
>  			continue;
>  		}
>  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> -		prev = vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
> -				 new_flags, vma->anon_vma,
> -				 vma->vm_file, vma->vm_pgoff,
> -				 vma_policy(vma),
> -				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> +		prev = vma_modify_uffd(&vmi, prev, vma, vma->vm_start,
> +				       vma->vm_end, new_flags,
> +				       NULL_VM_UFFD_CTX);
> +
>  		if (prev) {
>  			vma = prev;
>  		} else {
> @@ -1331,7 +1330,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	unsigned long start, end, vma_end;
>  	struct vma_iterator vmi;
>  	bool wp_async = userfaultfd_wp_async_ctx(ctx);
> -	pgoff_t pgoff;
>  
>  	user_uffdio_register = (struct uffdio_register __user *) arg;
>  
> @@ -1484,26 +1482,18 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  		vma_end = min(end, vma->vm_end);
>  
>  		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> -		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> -		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, pgoff,
> -				 vma_policy(vma),
> -				 ((struct vm_userfaultfd_ctx){ ctx }),
> -				 anon_vma_name(vma));
> +		prev = vma_modify_uffd(&vmi, prev, vma, start, vma_end,
> +				       new_flags,
> +				       ((struct vm_userfaultfd_ctx){ ctx }));
>  		if (prev) {

This will hit also for IS_ERR(prev), no?

>  			/* vma_merge() invalidated the mas */
>  			vma = prev;
>  			goto next;
>  		}
> -		if (vma->vm_start < start) {
> -			ret = split_vma(&vmi, vma, start, 1);
> -			if (ret)
> -				break;
> -		}
> -		if (vma->vm_end > end) {
> -			ret = split_vma(&vmi, vma, end, 0);
> -			if (ret)
> -				break;
> +
> +		if (IS_ERR(prev)) {

So here's too late to test for it. AFAICS the other usages are like this as
well.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a7b667786cde..c069813f215f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3253,6 +3253,29 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
>  	unsigned long addr, unsigned long len, pgoff_t pgoff,
>  	bool *need_rmap_locks);
>  extern void exit_mmap(struct mm_struct *);
> +struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> +					struct vm_area_struct *prev,
> +					struct vm_area_struct *vma,
> +					unsigned long start, unsigned long end,
> +					unsigned long new_flags);
> +struct vm_area_struct *vma_modify_flags_name(struct vma_iterator *vmi,
> +					     struct vm_area_struct *prev,
> +					     struct vm_area_struct *vma,
> +					     unsigned long start,
> +					     unsigned long end,
> +					     unsigned long new_flags,
> +					     struct anon_vma_name *new_name);
> +struct vm_area_struct *vma_modify_policy(struct vma_iterator *vmi,
> +					 struct vm_area_struct *prev,
> +					 struct vm_area_struct *vma,
> +					 unsigned long start, unsigned long end,
> +					 struct mempolicy *new_pol);
> +struct vm_area_struct *vma_modify_uffd(struct vma_iterator *vmi,
> +				       struct vm_area_struct *prev,
> +				       struct vm_area_struct *vma,
> +				       unsigned long start, unsigned long end,
> +				       unsigned long new_flags,
> +				       struct vm_userfaultfd_ctx new_ctx);

Could these be instead static inline wrappers, and vma_modify exported
instead of static?

Maybe we could also move this to mm/internal.h? Which would mean
fs/userfaultfd.c would have to start including it, but as it's already so
much rooted in mm, it shouldn't be wrong?

>  
>  static inline int check_data_rlimit(unsigned long rlim,
>  				    unsigned long new,
> diff --git a/mm/madvise.c b/mm/madvise.c
> index a4a20de50494..73024693d5c8 100644

