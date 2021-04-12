Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5193935D3CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 01:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbhDLXSD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 19:18:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236404AbhDLXSC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 19:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618269463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RjgkMTxmWerUbM+C2EtS/XPjyHCbWkmm0xddYj/OAJc=;
        b=W33JPKLabqarbsxy6hHL6DpNl6VzDuUqsbA0BRlN2KsEAofO78zJPW2TV23oPnZKKmXudo
        Am+iqgSejT3kFupOH4LO+sOVvyu2QrTQMQavMO4hvWPVPW6xFgDtqyRXiCJTzUpjoBcPMG
        TVVxMkvyIlVDhq07uqusMYlszCFrMC8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-ncFl7DTYM1SK3ejAPxLEvQ-1; Mon, 12 Apr 2021 19:17:41 -0400
X-MC-Unique: ncFl7DTYM1SK3ejAPxLEvQ-1
Received: by mail-qv1-f70.google.com with SMTP id dk17so4758130qvb.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 16:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RjgkMTxmWerUbM+C2EtS/XPjyHCbWkmm0xddYj/OAJc=;
        b=MY+LSJdW/K7DnMcP5yiFiQO9hzlfC0NjkfhGkF/kVuGAZInH673LVhZL68VPaGZ255
         ahS3nJIlKP0Q5WAooqfT1uqHEJl6wIRQvXK5FqCYk8sCrk4ybHKV83ImAAe7g7nRIthJ
         mtX61a6e7OrMP8JdCk27WOay7M2lSLTgi4IAbH5fpU3wT6swCYoJIA5n4byoBXNGp3cU
         pA01Asrz0FD92ssGCIcZ/WkyjyhNslH4Ddh0DTSiB5a0qjZt2lPoQOEwUJw08zCREFiV
         gfPWA2BIHwSCdsy7vyagZ5ff8Wi6TgPhyA7ViT8T3HoSYV64rl9AU5RFrlOAuv8P+WLm
         qOWg==
X-Gm-Message-State: AOAM533NXqtBJefZrlARWsa8vk5v2epJg6fd7uAaSL0Ueew6ac8jjxRl
        tnCN+YxkFW7/3stsABWDLh9+itbWk2r6HDEZBNgVPsg6UDSfC1A/cfqksJ9D6kPVBdDnU61j8C8
        e78W/WmjZIY9DzZuSYaSL3j+DUw==
X-Received: by 2002:ac8:5f10:: with SMTP id x16mr28535540qta.6.1618269461303;
        Mon, 12 Apr 2021 16:17:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzEymnMMyU8ZbJb1fPKB3SHpxb+Q5rXyQvX4BVoakOG88f052kHWo+XsASwbe/h8OtNaAWxw==
X-Received: by 2002:ac8:5f10:: with SMTP id x16mr28535500qta.6.1618269460962;
        Mon, 12 Apr 2021 16:17:40 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id j129sm9011374qkf.110.2021.04.12.16.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 16:17:40 -0700 (PDT)
Date:   Mon, 12 Apr 2021 19:17:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
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
Subject: Re: [PATCH 4/9] userfaultfd/shmem: support UFFDIO_CONTINUE for shmem
Message-ID: <20210412231736.GA1002612@xz-x1>
References: <20210408234327.624367-1-axelrasmussen@google.com>
 <20210408234327.624367-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210408234327.624367-5-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 04:43:22PM -0700, Axel Rasmussen wrote:
> +/*
> + * Install PTEs, to map dst_addr (within dst_vma) to page.
> + *
> + * This function handles MCOPY_ATOMIC_CONTINUE (which is always file-backed),
> + * whether or not dst_vma is VM_SHARED. It also handles the more general
> + * MCOPY_ATOMIC_NORMAL case, when dst_vma is *not* VM_SHARED (it may be file
> + * backed, or not).
> + *
> + * Note that MCOPY_ATOMIC_NORMAL for a VM_SHARED dst_vma is handled by
> + * shmem_mcopy_atomic_pte instead.
> + */
> +static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> +				     struct vm_area_struct *dst_vma,
> +				     unsigned long dst_addr, struct page *page,
> +				     bool newly_allocated, bool wp_copy)
> +{
> +	int ret;
> +	pte_t _dst_pte, *dst_pte;
> +	int writable;
> +	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
> +	spinlock_t *ptl;
> +	struct inode *inode;
> +	pgoff_t offset, max_off;
> +
> +	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> +	writable = dst_vma->vm_flags & VM_WRITE;
> +	/* For private, non-anon we need CoW (don't write to page cache!) */
> +	if (!vma_is_anonymous(dst_vma) && !vm_shared)
> +		writable = 0;
> +
> +	if (writable || vma_is_anonymous(dst_vma))
> +		_dst_pte = pte_mkdirty(_dst_pte);
> +	if (writable) {
> +		if (wp_copy)
> +			_dst_pte = pte_mkuffd_wp(_dst_pte);
> +		else
> +			_dst_pte = pte_mkwrite(_dst_pte);
> +	} else if (vm_shared) {
> +		/*
> +		 * Since we didn't pte_mkdirty(), mark the page dirty or it
> +		 * could be freed from under us. We could do this
> +		 * unconditionally, but doing it only if !writable is faster.
> +		 */
> +		set_page_dirty(page);
> +	}
> +
> +	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> +
> +	if (vma_is_shmem(dst_vma)) {
> +		/* The shmem MAP_PRIVATE case requires checking the i_size */

When you start to use this function in the last patch it'll be needed too even
if MAP_SHARED?

How about directly state the reason of doing this ("serialize against truncate
with the PT lock") instead of commenting about "who will need it"?

> +		inode = dst_vma->vm_file->f_inode;
> +		offset = linear_page_index(dst_vma, dst_addr);
> +		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> +		ret = -EFAULT;
> +		if (unlikely(offset >= max_off))
> +			goto out_unlock;
> +	}

[...]

> +/* Handles UFFDIO_CONTINUE for all shmem VMAs (shared or private). */
> +static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
> +				pmd_t *dst_pmd,
> +				struct vm_area_struct *dst_vma,
> +				unsigned long dst_addr,
> +				bool wp_copy)
> +{
> +	struct inode *inode = file_inode(dst_vma->vm_file);
> +	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
> +	struct page *page;
> +	int ret;
> +
> +	ret = shmem_getpage(inode, pgoff, &page, SGP_READ);

SGP_READ looks right, as we don't want page allocation.  However I noticed
there's very slight difference when the page was just fallocated:

	/* fallocated page? */
	if (page && !PageUptodate(page)) {
		if (sgp != SGP_READ)
			goto clear;
		unlock_page(page);
		put_page(page);
		page = NULL;
		hindex = index;
	}

I think it won't happen for your case since the page should be uptodate already
(the other thread should check and modify the page before CONTINUE), but still
raise this up, since if the page was allocated it smells better to still
install the fallocated page (do we need to clear the page and SetUptodate)?

-- 
Peter Xu

