Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3692C3FB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 13:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgKYMQq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 07:16:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:53804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbgKYMQp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:16:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E6B3AF0B;
        Wed, 25 Nov 2020 12:16:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2138A1E130F; Wed, 25 Nov 2020 13:16:44 +0100 (CET)
Date:   Wed, 25 Nov 2020 13:16:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 02/45] filemap: consistently use ->f_mapping over
 ->i_mapping
Message-ID: <20201125121644.GF16944@quack2.suse.cz>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 24-11-20 14:27:08, Christoph Hellwig wrote:
> Use file->f_mapping in all remaining places that have a struct file
> available to properly handle the case where inode->i_mapping !=
> file_inode(file)->i_mapping.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d5e7c2029d16b4..4f583489aa3c2a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2886,14 +2886,14 @@ EXPORT_SYMBOL(filemap_map_pages);
>  
>  vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
>  {
> +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
>  	struct page *page = vmf->page;
> -	struct inode *inode = file_inode(vmf->vma->vm_file);
>  	vm_fault_t ret = VM_FAULT_LOCKED;
>  
> -	sb_start_pagefault(inode->i_sb);
> +	sb_start_pagefault(mapping->host->i_sb);
>  	file_update_time(vmf->vma->vm_file);
>  	lock_page(page);
> -	if (page->mapping != inode->i_mapping) {
> +	if (page->mapping != mapping) {
>  		unlock_page(page);
>  		ret = VM_FAULT_NOPAGE;
>  		goto out;
> @@ -2906,7 +2906,7 @@ vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
>  	set_page_dirty(page);
>  	wait_for_stable_page(page);
>  out:
> -	sb_end_pagefault(inode->i_sb);
> +	sb_end_pagefault(mapping->host->i_sb);
>  	return ret;
>  }
>  
> @@ -3149,10 +3149,9 @@ void dio_warn_stale_pagecache(struct file *filp)
>  {
>  	static DEFINE_RATELIMIT_STATE(_rs, 86400 * HZ, DEFAULT_RATELIMIT_BURST);
>  	char pathname[128];
> -	struct inode *inode = file_inode(filp);
>  	char *path;
>  
> -	errseq_set(&inode->i_mapping->wb_err, -EIO);
> +	errseq_set(&filp->f_mapping->wb_err, -EIO);
>  	if (__ratelimit(&_rs)) {
>  		path = file_path(filp, pathname, sizeof(pathname));
>  		if (IS_ERR(path))
> @@ -3179,7 +3178,7 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT) {
>  		/* If there are pages to writeback, return */
> -		if (filemap_range_has_page(inode->i_mapping, pos,
> +		if (filemap_range_has_page(file->f_mapping, pos,
>  					   pos + write_len - 1))
>  			return -EAGAIN;
>  	} else {
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
