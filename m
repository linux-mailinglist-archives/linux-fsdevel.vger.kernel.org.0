Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB70D304989
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbhAZF1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731267AbhAZBzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:55:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F71C061224;
        Mon, 25 Jan 2021 17:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I4QtGGdUD49OQbpnA/+iW6hZGEJcEQdxNTE3QJXFu+k=; b=th6+D7onHmuxEzk677tybiCqfY
        hhGc9w/VT61khYhuxx2E1kXIsOZGSF8+E1JP2Cvik6UBR/5b9Nw1Gin/GJ/RDDPaHQuwd8aX3Z5R6
        LuJpCUqsZxHBgVXAyJOFwvagUUVKqq/2tD0/zQ5NLUIocvQ3sFd+r65lKsnAv70oMOdY65n7/vmc0
        5u4hBE/tFpodrVaPe+lRr8QseonmbE9ty/7mie8ThsqBBqlrcHJgYHdXAyo8VhXZYJeq+djp+RU1Z
        bkG5n7D1xoNHEi6ZrSR5P+ndK11HLCtkbsp86N94CxpjEcmp6tYmalu5GJ74rGgTmoQ4gK9HCOanm
        TCWQ7O8g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4DH9-004uVe-DU; Tue, 26 Jan 2021 01:36:32 +0000
Date:   Tue, 26 Jan 2021 01:36:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 32/32] NFS: Convert readpage to readahead and use
 netfs_readahead for fscache
Message-ID: <20210126013611.GI308988@casper.infradead.org>
References: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
 <161161064956.2537118.3354798147866150631.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161161064956.2537118.3354798147866150631.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


For Subject: s/readpage/readpages/

On Mon, Jan 25, 2021 at 09:37:29PM +0000, David Howells wrote:
> +int __nfs_readahead_from_fscache(struct nfs_readdesc *desc,
> +				 struct readahead_control *rac)

I thought you wanted it called ractl instead of rac?  That's what I've
been using in new code.

> -	dfprintk(FSCACHE, "NFS: nfs_getpages_from_fscache (0x%p/%u/0x%p)\n",
> -		 nfs_i_fscache(inode), npages, inode);
> +	dfprintk(FSCACHE, "NFS: nfs_readahead_from_fscache (0x%p/0x%p)\n",
> +		 nfs_i_fscache(inode), inode);

We do have readahead_count() if this is useful information to be logging.

> +static inline int nfs_readahead_from_fscache(struct nfs_readdesc *desc,
> +					     struct readahead_control *rac)
>  {
> -	if (NFS_I(inode)->fscache)
> -		return __nfs_readpages_from_fscache(ctx, inode, mapping, pages,
> -						    nr_pages);
> +	if (NFS_I(rac->mapping->host)->fscache)
> +		return __nfs_readahead_from_fscache(desc, rac);
>  	return -ENOBUFS;
>  }

Not entirely sure that it's worth having the two functions separated any more.

>  	/* attempt to read as many of the pages as possible from the cache
>  	 * - this returns -ENOBUFS immediately if the cookie is negative
>  	 */
> -	ret = nfs_readpages_from_fscache(desc.ctx, inode, mapping,
> -					 pages, &nr_pages);
> +	ret = nfs_readahead_from_fscache(&desc, rac);
>  	if (ret == 0)
>  		goto read_complete; /* all pages were read */
>  
>  	nfs_pageio_init_read(&desc.pgio, inode, false,
>  			     &nfs_async_read_completion_ops);
>  
> -	ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
> +	while ((page = readahead_page(rac))) {
> +		ret = readpage_async_filler(&desc, page);
> +		put_page(page);
> +	}

I thought with the new API we didn't need to do this kind of thing
any more?  ie no matter whether fscache is configured in or not, it'll
submit the I/Os.
