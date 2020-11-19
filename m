Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7282B958B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 15:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgKSOxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 09:53:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:54410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbgKSOxF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:53:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A44DAC2F;
        Thu, 19 Nov 2020 14:53:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BD7681E130B; Thu, 19 Nov 2020 15:53:03 +0100 (CET)
Date:   Thu, 19 Nov 2020 15:53:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 17/20] filemap: consistently use ->f_mapping over
 ->i_mapping
Message-ID: <20201119145303.GZ1981@quack2.suse.cz>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118084800.2339180-18-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 18-11-20 09:47:57, Christoph Hellwig wrote:
> Use file->f_mapping in all remaining places that have a struct file
> available to properly handle the case where inode->i_mapping !=
> file_inode(file)->i_mapping.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d5e7c2029d16b4..3e3531a757f8db 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2887,13 +2887,13 @@ EXPORT_SYMBOL(filemap_map_pages);
>  vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
>  {
>  	struct page *page = vmf->page;
> -	struct inode *inode = file_inode(vmf->vma->vm_file);
> +	struct inode *inode = vmf->vma->vm_file->f_mapping->host;
>  	vm_fault_t ret = VM_FAULT_LOCKED;
>  
>  	sb_start_pagefault(inode->i_sb);
>  	file_update_time(vmf->vma->vm_file);
>  	lock_page(page);
> -	if (page->mapping != inode->i_mapping) {
> +	if (page->mapping != vmf->vma->vm_file->f_mapping) {
>  		unlock_page(page);
>  		ret = VM_FAULT_NOPAGE;
>  		goto out;
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
