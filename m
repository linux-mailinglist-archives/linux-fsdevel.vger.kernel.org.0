Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF982BA5D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 10:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgKTJRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 04:17:21 -0500
Received: from verein.lst.de ([213.95.11.211]:42132 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgKTJRR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:17:17 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E4E0067373; Fri, 20 Nov 2020 10:17:14 +0100 (CET)
Date:   Fri, 20 Nov 2020 10:17:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 17/20] filemap: consistently use ->f_mapping over
 ->i_mapping
Message-ID: <20201120091714.GF21715@lst.de>
References: <20201118084800.2339180-1-hch@lst.de> <20201118084800.2339180-18-hch@lst.de> <20201119151316.GH29991@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119151316.GH29991@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 19, 2020 at 03:13:16PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 18, 2020 at 09:47:57AM +0100, Christoph Hellwig wrote:
> > @@ -2887,13 +2887,13 @@ EXPORT_SYMBOL(filemap_map_pages);
> >  vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
> >  {
> >  	struct page *page = vmf->page;
> > -	struct inode *inode = file_inode(vmf->vma->vm_file);
> > +	struct inode *inode = vmf->vma->vm_file->f_mapping->host;
> >  	vm_fault_t ret = VM_FAULT_LOCKED;
> >  
> >  	sb_start_pagefault(inode->i_sb);
> >  	file_update_time(vmf->vma->vm_file);
> >  	lock_page(page);
> > -	if (page->mapping != inode->i_mapping) {
> > +	if (page->mapping != vmf->vma->vm_file->f_mapping) {
> 
> Bit messy.  I'd do:
> 
> 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> 
> 	sb_start_pagefault(mapping->host->i_sb);
> 
> 	if (page->mapping != mapping)
> 
> 	sb_end_pagefault(mapping->host->i_sb);

Fine with me.
