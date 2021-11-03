Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06952444368
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 15:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhKCO2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 10:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhKCO2M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:28:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF57C061714;
        Wed,  3 Nov 2021 07:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MHA8/5DT9+P3H8EQ2DoH0Mu3SBzybKb1RrICo62RwQ4=; b=t9eJNkfzrgV+QiZqspfhcfToYC
        3Ec3SF3Q9ZLFQr4jT4+hVBAtuUAKgl1oeoJE6scE4G7P3IEjD2W/m5e99yCHLHHqSDI4E6rXc3JMg
        w4hmwDJRapYDTm+u3lLY6FNZbczw88eT0WhKs9l37aOExnpxsFT0/MIanKBtIqeteHjLCUNpHkY3t
        6V8IAR1xpI1GYombL4N7TBPf8hVo3yBjiDFh6Q6ZiaTO73ciucIzhdBOKDW+BOs+2QBbEDNk1eJ27
        55B12uY/pzWiNJcJpqjIYYeUkBZkGAu0Sd3MqWEnqhWN6VDdSlaDtEesmkfjbJgM/JJGlieavLNzj
        4sxQUXrw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miH8f-005FeW-AM; Wed, 03 Nov 2021 14:21:52 +0000
Date:   Wed, 3 Nov 2021 14:21:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] netfs, 9p, afs, ceph: Use folios
Message-ID: <YYKa3bfQZxK5/wDN@casper.infradead.org>
References: <163584174921.4023316.8927114426959755223.stgit@warthog.procyon.org.uk>
 <163584187452.4023316.500389675405550116.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163584187452.4023316.500389675405550116.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 08:31:14AM +0000, David Howells wrote:
> -static int v9fs_vfs_writepage_locked(struct page *page)
> +static int v9fs_vfs_write_folio_locked(struct folio *folio)
>  {
> -	struct inode *inode = page->mapping->host;
> +	struct inode *inode = folio_inode(folio);
>  	struct v9fs_inode *v9inode = V9FS_I(inode);
> -	loff_t start = page_offset(page);
> +	loff_t start = folio_pos(folio);
>  	loff_t size = i_size_read(inode);
>  	struct iov_iter from;
> -	int err, len;
> +	size_t gran = folio_size(folio), len;
> +	int err;
>  
> -	if (page->index == size >> PAGE_SHIFT)
> -		len = size & ~PAGE_MASK;
> -	else
> -		len = PAGE_SIZE;
> +	len = (size >= start + gran) ? gran : size - start;

This seems like the most complicated way to write this ... how about:

        size_t len = min_t(loff_t, isize - start, folio_size(folio));

> @@ -322,23 +322,24 @@ static void afs_req_issue_op(struct netfs_read_subrequest *subreq)
>  
>  static int afs_symlink_readpage(struct file *file, struct page *page)
>  {
> -	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
> +	struct afs_vnode *vnode = AFS_FS_I(page_mapping(page)->host);

How does swap end up calling readpage on a symlink?

>  	ret = afs_fetch_data(fsreq->vnode, fsreq);
> -	page_endio(page, false, ret);
> +	page_endio(&folio->page, false, ret);

We need a folio_endio() ...

>  int afs_write_end(struct file *file, struct address_space *mapping,
>  		  loff_t pos, unsigned len, unsigned copied,
> -		  struct page *page, void *fsdata)
> +		  struct page *subpage, void *fsdata)
>  {
> +	struct folio *folio = page_folio(subpage);
>  	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
>  	unsigned long priv;
> -	unsigned int f, from = pos & (thp_size(page) - 1);
> +	unsigned int f, from = pos & (folio_size(folio) - 1);

Isn't that:

	size_t from = offset_in_folio(folio, pos);

(not that i think we're getting folios larger than 4GB any time soon,
but it'd be nice to be prepared for it)

