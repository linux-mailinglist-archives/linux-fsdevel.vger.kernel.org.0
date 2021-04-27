Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C5A36BD95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 04:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhD0C7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 22:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhD0C7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 22:59:51 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60483C061760
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 19:59:09 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id v23so6682129qkj.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 19:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IbFDaC8Buo1vCSozpF9/8vShIeKDcGpQ6TZhRKWQtpk=;
        b=p/OZAP2wW2pos3c1TaSkgF7ku6Q7o3HYN0rTeqA14Ez9VhLkSFfVFJ6t8aMVKRdP1X
         jCs2exfnGgZgzvQgNiR1wRAuAVVHnr6/dQHwC/N3LB8j4bzocHp1K03mmDmwIXYQhb9d
         i4r32Aeh2Um2THqtgUTjAkoZ2Q6HUSPOSAzg3omSULUhi+efXH+UbaCX+M6w9AAHVGMi
         YUh8j0wLKWmF2jZAumovoqwGrQVa6Q2X3XlBpGKNfZ6j7m5jFMzt2MY2YaslwfKKOhQa
         3Yo/38XK/75BrM9AWGa2HicRAa6kp1ZKSyqmrRXY9hXKlt1DCVvmenUtJ1TRkw8Kba53
         N6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IbFDaC8Buo1vCSozpF9/8vShIeKDcGpQ6TZhRKWQtpk=;
        b=j6nBmY6FEr0y9Z5o6vO+BvaHFDrQlRnjc6y8FQHlMeaIiQfsbMCjYGyz3d0c2zJOSB
         XsmOpL2szkebgD011T2ppCRFxvpOpZXfcmcR67J1dlBMXEpCDRdG6neMiJF7anherWPG
         K9VLXfQ1izKUl7YT4udDuLvQ+YssuGmGFEKpa0szfGq5odEd9uw2U1Uzl8T/JLMrpBIC
         2pllaj52DAJ3HkUczTeYiSeCs9y9PhSy68FsAC4HD7X5pg899vPi771lYvxQ5TQE4RrR
         JL1hSELgeflh3daejS8ARpZfQ670f1Mk9m/8jaDKQu1K0bSa4IYUEFYJznCiW7M2dNlI
         g9aA==
X-Gm-Message-State: AOAM531tIhBSI9lilJSBVkvkW6F3zbNvEyGfG7/9VX2MJFi51K99Ozat
        k/laJCbnDF0fVZbjL8onTt+dHA==
X-Google-Smtp-Source: ABdhPJwySG9y8XrA8jj4O3XKDMDff3AJpgG4hntUMfwbHFRSt75oMeFyOpoRwifv0r3xez8KH8xfsw==
X-Received: by 2002:a37:e06:: with SMTP id 6mr21145584qko.373.1619492347903;
        Mon, 26 Apr 2021 19:59:07 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 7sm7937758qtu.38.2021.04.26.19.59.05
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 26 Apr 2021 19:59:07 -0700 (PDT)
Date:   Mon, 26 Apr 2021 19:59:04 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 09/10] userfaultfd/shmem: modify shmem_mcopy_atomic_pte
 to use install_pte()
In-Reply-To: <20210421010205.GH4440@xz-x1>
Message-ID: <alpine.LSU.2.11.2104261927570.2998@eggly.anvils>
References: <20210420220804.486803-1-axelrasmussen@google.com> <20210420220804.486803-10-axelrasmussen@google.com> <20210421010205.GH4440@xz-x1>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 20 Apr 2021, Peter Xu wrote:
> On Tue, Apr 20, 2021 at 03:08:03PM -0700, Axel Rasmussen wrote:
> > In a previous commit, we added the mcopy_atomic_install_pte() helper.
> > This helper does the job of setting up PTEs for an existing page, to map
> > it into a given VMA. It deals with both the anon and shmem cases, as
> > well as the shared and private cases.
> > 
> > In other words, shmem_mcopy_atomic_pte() duplicates a case it already
> > handles. So, expose it, and let shmem_mcopy_atomic_pte() use it
> > directly, to reduce code duplication.
> > 
> > This requires that we refactor shmem_mcopy_atomic_pte() a bit:
> > 
> > Instead of doing accounting (shmem_recalc_inode() et al) part-way
> > through the PTE setup, do it beforehand. This frees up
> > mcopy_atomic_install_pte() from having to care about this accounting,
> > but it does mean we need to clean it up if we get a failure afterwards
> > (shmem_uncharge()).
> > 
> > We can *almost* use shmem_charge() to do this, reducing code
> > duplication. But, it does `inode->i_mapping->nrpages++`, which would
> > double-count since shmem_add_to_page_cache() also does this.
> 
> Missing to mention the lru_cache_add() replacement comment as Hugh commented on
> this?

Yes, please add that mention.

And personally, I'd much prefer this and the Doc commit,
the non-selftest commits, to be moved up before the selftests.

The selftest situation is confusing at present, since Peter's series
got dropped as [to-be-updated] from mmotm, so we're waiting for those
updates to be added back to mmotm before this series can go in.

(But akpm will be busy with merge window stuff at present:
now is not the time to be adding or re-adding a series.)

> 
> > 
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Peter raised a good point below, so no Ack from me yet.

> > ---
> >  include/linux/userfaultfd_k.h |  5 ++++
> >  mm/shmem.c                    | 53 ++++++++---------------------------
> >  mm/userfaultfd.c              | 17 ++++-------
> >  3 files changed, 22 insertions(+), 53 deletions(-)
> > 
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index 794d1538b8ba..39c094cc6641 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -53,6 +53,11 @@ enum mcopy_atomic_mode {
> >  	MCOPY_ATOMIC_CONTINUE,
> >  };
> >  
> > +extern int mcopy_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > +				    struct vm_area_struct *dst_vma,
> > +				    unsigned long dst_addr, struct page *page,
> > +				    bool newly_allocated, bool wp_copy);
> > +
> >  extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
> >  			    unsigned long src_start, unsigned long len,
> >  			    bool *mmap_changing, __u64 mode);
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 30c0bb501dc9..9bfa80fcd414 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2378,10 +2378,8 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >  	struct address_space *mapping = inode->i_mapping;
> >  	gfp_t gfp = mapping_gfp_mask(mapping);
> >  	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
> > -	spinlock_t *ptl;
> >  	void *page_kaddr;
> >  	struct page *page;
> > -	pte_t _dst_pte, *dst_pte;
> >  	int ret;
> >  	pgoff_t max_off;
> >  
> > @@ -2391,8 +2389,10 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >  
> >  	if (!*pagep) {
> >  		page = shmem_alloc_page(gfp, info, pgoff);
> > -		if (!page)
> > -			goto out_unacct_blocks;
> > +		if (!page) {
> > +			shmem_inode_unacct_blocks(inode, 1);
> > +			goto out;
> > +		}
> >  
> >  		if (!zeropage) {	/* COPY */
> >  			page_kaddr = kmap_atomic(page);
> > @@ -2432,59 +2432,28 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >  	if (ret)
> >  		goto out_release;
> >  
> > -	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> > -	if (dst_vma->vm_flags & VM_WRITE)
> > -		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
> > -	else {
> > -		/*
> > -		 * We don't set the pte dirty if the vma has no
> > -		 * VM_WRITE permission, so mark the page dirty or it
> > -		 * could be freed from under us. We could do it
> > -		 * unconditionally before unlock_page(), but doing it
> > -		 * only if VM_WRITE is not set is faster.
> > -		 */
> > -		set_page_dirty(page);
> > -	}
> > -
> > -	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> > -
> > -	ret = -EFAULT;
> > -	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > -	if (unlikely(pgoff >= max_off))
> > -		goto out_release_unlock;
> > -
> > -	ret = -EEXIST;
> > -	if (!pte_none(*dst_pte))
> > -		goto out_release_unlock;
> > -
> > -	lru_cache_add(page);
> > -
> >  	spin_lock_irq(&info->lock);
> >  	info->alloced++;
> >  	inode->i_blocks += BLOCKS_PER_PAGE;
> >  	shmem_recalc_inode(inode);
> >  	spin_unlock_irq(&info->lock);

I think it's best to move that info->locked block down to above the
new SetPageDirty(), where we know we have succeeded, because...

> >  
> > -	inc_mm_counter(dst_mm, mm_counter_file(page));
> > -	page_add_file_rmap(page, false);
> > -	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> > +	ret = mcopy_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> > +				       page, true, false);
> > +	if (ret)
> > +		goto out_release_uncharge;
> >  
> > -	/* No need to invalidate - it was non-present before */
> > -	update_mmu_cache(dst_vma, dst_addr, dst_pte);
> > -	pte_unmap_unlock(dst_pte, ptl);
> > +	SetPageDirty(page);
> >  	unlock_page(page);
> >  	ret = 0;
> >  out:
> >  	return ret;
> > -out_release_unlock:
> > -	pte_unmap_unlock(dst_pte, ptl);
> > -	ClearPageDirty(page);
> > +out_release_uncharge:
> >  	delete_from_page_cache(page);
> > +	shmem_uncharge(inode, 1);
> >  out_release:
> >  	unlock_page(page);
> >  	put_page(page);
> > -out_unacct_blocks:
> 
> Will all the "goto out_release" miss one call to shmem_inode_unacct_blocks()?

Good catch, yes.

Which is why I suggest above to move the info->locked block down:
then you can forget about using shmem_uncharge(), and just use
shmem_inode_unacct_blocks() directly in all cases that need it here.

(But I notice the commit message refers to shmem_uncharge(), so that
will need adjusting. shmem_uncharge() is more of a hack than a proper
interface, introduced to manage certain THP split/collapse cases.)

> 
> > -	shmem_inode_unacct_blocks(inode, 1);
> >  	goto out;
> >  }
> >  #endif /* CONFIG_USERFAULTFD */
