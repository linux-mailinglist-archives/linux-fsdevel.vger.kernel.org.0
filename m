Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D463D63ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 18:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbhGZPxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 11:53:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44078 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239521AbhGZPxA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 11:53:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CC6FE21EE9;
        Mon, 26 Jul 2021 16:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627317206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qEm2jNaUdy3jO9cBY6Qwnggq+yqNV/Uk7peUcznnQTQ=;
        b=lcEKzgSFFJQsDxTQaaRCCycTAkpnDGSNepqcuWD/gwLPTSCSJwhN+hYr4ErgQfduVKTRnc
        sU98siteYFSnLfVN21I0t4tNJPmk/uwumPtsqZoGJ/DyTWJNwfHiYV8DDUZuLdv1TD9Oxw
        9OskcfzDmXagHmLjrVKChg1vH+UjZjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627317206;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qEm2jNaUdy3jO9cBY6Qwnggq+yqNV/Uk7peUcznnQTQ=;
        b=M15RZU5/I2SecGS5VRdg+REOyzCwn+eixG3K5sdMWOU3yBoLjeM1/lRyTw3hsa8JnMIVcd
        3Hnq1+K5lXNzSHCQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B17B5A3C0E;
        Mon, 26 Jul 2021 16:33:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8CBD81E3B13; Mon, 26 Jul 2021 18:33:26 +0200 (CEST)
Date:   Mon, 26 Jul 2021 18:33:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v3 1/7] iov_iter: Introduce fault_in_iov_iter helper
Message-ID: <20210726163326.GK20621@quack2.suse.cz>
References: <20210723205840.299280-1-agruenba@redhat.com>
 <20210723205840.299280-2-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723205840.299280-2-agruenba@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 23-07-21 22:58:34, Andreas Gruenbacher wrote:
> Introduce a new fault_in_iov_iter helper for manually faulting in an iterator.
> Other than fault_in_pages_writeable(), this function is non-destructive.
> 
> We'll use fault_in_iov_iter in gfs2 once we've determined that the iterator
> passed to .read_iter or .write_iter isn't in memory.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
...
> +unsigned long fault_in_user_pages(unsigned long start, unsigned long len,
> +				  bool write)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma = NULL;
> +	unsigned long end, nstart, nend;
> +	int locked = 0;
> +	int gup_flags;
> +
> +	/*
> +	 * FIXME: Make sure this function doesn't succeed for pages that cannot
> +	 * be accessed; otherwise we could end up in a loop trying to fault in
> +	 * and then access the pages.  (It's okay if a page gets evicted and we
> +	 * need more than one retry.)
> +	 */
> +
> +	/*
> +	 * FIXME: Are these the right FOLL_* flags?
> +	 */

How about the FIXMEs here? I guess we should answer these questions before
merging and remove the comments. Regarding the first FIXME I tend to agree
that if we cannot fault in the first page, we should return the error
rather than returning 0 as you do now. OTOH the caller can check for 0 and
understand there's something wrong going on as well. But the error would be
probably a bit clearer.

> +
> +	gup_flags = FOLL_TOUCH | FOLL_POPULATE;

I don't think FOLL_POPULATE makes sense here. It makes sense only with
FOLL_MLOCK and determines whether mlock(2) should fault in missing pages or
not.

								Honza

> +	if (write)
> +		gup_flags |= FOLL_WRITE;
> +
> +	end = PAGE_ALIGN(start + len);
> +	for (nstart = start & PAGE_MASK; nstart < end; nstart = nend) {
> +		unsigned long nr_pages;
> +		long ret;
> +
> +		if (!locked) {
> +			locked = 1;
> +			mmap_read_lock(mm);
> +			vma = find_vma(mm, nstart);
> +		} else if (nstart >= vma->vm_end)
> +			vma = vma->vm_next;
> +		if (!vma || vma->vm_start >= end)
> +			break;
> +		nend = min(end, vma->vm_end);
> +		if (vma->vm_flags & (VM_IO | VM_PFNMAP))
> +			continue;
> +		if (nstart < vma->vm_start)
> +			nstart = vma->vm_start;
> +		nr_pages = (nend - nstart) / PAGE_SIZE;
> +		ret = __get_user_pages_locked(mm, nstart, nr_pages,
> +					      NULL, NULL, &locked, gup_flags);
> +		if (ret <= 0)
> +			break;
> +		nend = nstart + ret * PAGE_SIZE;
> +	}
> +	if (locked)
> +		mmap_read_unlock(mm);
> +	if (nstart > start)
> +		return min(nstart - start, len);
> +	return 0;
> +}
> +
>  /**
>   * get_dump_page() - pin user page in memory while writing it to core dump
>   * @addr: user address
> -- 
> 2.26.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
