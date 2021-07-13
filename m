Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABF53C707D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 14:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhGMMik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 08:38:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33706 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbhGMMij (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 08:38:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 83C3D22075;
        Tue, 13 Jul 2021 12:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626179748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nlezZmaJGKsn3wThAAqUns1S5039quPyWkLk1BLMszA=;
        b=L0Ik4SGLKPMprCMpIDZu5I9SJkk6iVnXbqXSILIKOJ1tUsAz+3nm9Fiv2/sQhIhFL9aOmi
        Xdd54ETzCRoMIv/6ptRzy+K8vp6P0oCs0DxP7fFszUwp7i+yxHOadd6Ea9UosE6mdaj5+9
        3H6ZtOh5KYeEBpKjmeYcIikKLdDRKL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626179748;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nlezZmaJGKsn3wThAAqUns1S5039quPyWkLk1BLMszA=;
        b=k26gwy3dwwIlQyBP4N54gjqPfnfyayfHxU0JZPsEVY6lWzaQ34iMd6jTvkatBxRCs6Y6HK
        8UfNH2RVTEz7qqDg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 6FB26A3BBB;
        Tue, 13 Jul 2021 12:35:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4DCC31E0BBC; Tue, 13 Jul 2021 14:35:48 +0200 (CEST)
Date:   Tue, 13 Jul 2021 14:35:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Ted Tso <tytso@mit.edu>, Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/14] mm: Protect operations adding pages to page cache
 with invalidate_lock
Message-ID: <20210713123548.GA24271@quack2.suse.cz>
References: <20210712163901.29514-1-jack@suse.cz>
 <20210712165609.13215-3-jack@suse.cz>
 <YO0xwY+q7d8rQE3f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO0xwY+q7d8rQE3f@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 13-07-21 07:25:05, Christoph Hellwig wrote:
> Still looks good.  That being said the additional conditional locking in
> filemap_fault makes it fall over the readbility cliff for me.  Something
> like this on top of your series would help:

Yeah, that's better. Applied, thanks. 

								Honza

> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index fd3f94d36c49..0fad08331cf4 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3040,21 +3040,23 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	 * Do we have something in the page cache already?
>  	 */
>  	page = find_get_page(mapping, offset);
> -	if (likely(page) && !(vmf->flags & FAULT_FLAG_TRIED)) {
> +	if (likely(page)) {
>  		/*
> -		 * We found the page, so try async readahead before
> -		 * waiting for the lock.
> +		 * We found the page, so try async readahead before waiting for
> +		 * the lock.
>  		 */
> -		fpin = do_async_mmap_readahead(vmf, page);
> -	} else if (!page) {
> +		if (!(vmf->flags & FAULT_FLAG_TRIED))
> +			fpin = do_async_mmap_readahead(vmf, page);
> +		if (unlikely(!PageUptodate(page))) {
> +			filemap_invalidate_lock_shared(mapping);
> +			mapping_locked = true;
> +		}
> +	} else {
>  		/* No page in the page cache at all */
>  		count_vm_event(PGMAJFAULT);
>  		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
>  		ret = VM_FAULT_MAJOR;
>  		fpin = do_sync_mmap_readahead(vmf);
> -	}
> -
> -	if (!page) {
>  retry_find:
>  		/*
>  		 * See comment in filemap_create_page() why we need
> @@ -3073,9 +3075,6 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  			filemap_invalidate_unlock_shared(mapping);
>  			return VM_FAULT_OOM;
>  		}
> -	} else if (unlikely(!PageUptodate(page))) {
> -		filemap_invalidate_lock_shared(mapping);
> -		mapping_locked = true;
>  	}
>  
>  	if (!lock_page_maybe_drop_mmap(vmf, page, &fpin))
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
