Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1A52B95E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 16:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgKSPOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 10:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgKSPOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:14:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34925C0613CF;
        Thu, 19 Nov 2020 07:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aI9mH0dq7mTuWpujo4T+CjmE2gbvb95KnVfM843FQ84=; b=NQxl2LUeXdxB2yfG38WXbOdZDF
        4m3yXl2LUAYY4UoHaaLjO55fQMRmjPGQ3+B+xj1A4lwNOqB+KRFQoIk1nbaMMuKB/WnQRRcUmsRbV
        R2K9qIjBs0hPN6TTWcG6BAmilJQG1snUXu5nywrLj8Cz/xFJxvZUmVOZATxF0u8B82LwZZSJWb1hl
        RGyLJC+B2H7/mLhmvZRyTkib7wsKGqq179e8VAUmByqV2VbOMsqMaYFdiiZ3EUGK3Uw1hPAA3usoO
        WlHH4d0KOLmy0/ejtH1mtQgmdWJPaNlHqDfX4UPUMcxUgftU+j2y1V0nrwb5yjBJnF9f3J8T+0xqW
        MLlqYaTw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kflcb-0002ed-15; Thu, 19 Nov 2020 15:13:17 +0000
Date:   Thu, 19 Nov 2020 15:13:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20201119151316.GH29991@casper.infradead.org>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118084800.2339180-18-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 09:47:57AM +0100, Christoph Hellwig wrote:
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

Bit messy.  I'd do:

	struct address_space *mapping = vmf->vma->vm_file->f_mapping;

	sb_start_pagefault(mapping->host->i_sb);

	if (page->mapping != mapping)

	sb_end_pagefault(mapping->host->i_sb);

