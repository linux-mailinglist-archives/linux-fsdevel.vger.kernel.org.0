Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B852636BB8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 00:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbhDZWSQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 18:18:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232116AbhDZWSL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:18:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8DE061009;
        Mon, 26 Apr 2021 22:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619475449;
        bh=ZkTO8awNTukHLk9VqklD7IV/aS8daeT3oHbCNCTlruU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tGeZmm5EISAkX2zu0COUMzxEJ48ZzogTHl+MeQEq7QGqv1YyambEOCALAMAePQQf5
         G0DjczaE/HqOaQ9IhPkbBjfsRDMUm3W87ekpMw/LpHnXugv4v/EqZRQqBwQx5sSDmR
         WcOvU7DHQFwa3ytQE9iriTQso6Sj9qNTTwXleW5p6S4MShm41eqmHIVbvwYrHCh8hO
         gq0i8WEHCOt7I7PEjW0Rafeb8jswqx2ioAJEbSXZXRfuBuqw1yvcwgds5zm/FD0Oti
         mwdib8qqn/UnLtnnntGZsYoNW0YCsN9ovXQw4zcEELP1XxMS1jDMzQMAPOvPhsKMHT
         QVCM/neQJS2pw==
Message-ID: <728b55601fa54449cd43a35195641c00fbe6c096.camel@kernel.org>
Subject: Re: [PATCH v2] netfs: Miscellaneous fixes
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, Christoph Hellwig <hch@lst.de>,
        v9fs-developer@lists.sourceforge.net, linux-mm@kvack.org,
        linux-afs@lists.infradead.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 26 Apr 2021 18:17:26 -0400
In-Reply-To: <3737237.1619472003@warthog.procyon.org.uk>
References: <20210426210939.GS235567@casper.infradead.org>
         <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
         <3726642.1619471184@warthog.procyon.org.uk>
         <3737237.1619472003@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-04-26 at 22:20 +0100, David Howells wrote:
> Okay, how about the attached, then?
> 
> David
> ---
> netfs: Miscellaneous fixes
>     
> 
> 
> 
> Fix some miscellaneous things in the new netfs lib[1]:
> 
>  (1) The kerneldoc for netfs_readpage() shouldn't say netfs_page().
> 
>  (2) netfs_readpage() can get an integer overflow on 32-bit when it
>      multiplies page_index(page) by PAGE_SIZE.  It should use
>      page_file_offset() instead.
> 
>  (3) netfs_write_begin() should use page_offset() to avoid the same
>      overflow.
> 
> Note that netfs_readpage() needs to use page_file_offset() rather than
> page_offset() as it may see swap-over-NFS.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Link: https://lore.kernel.org/r/161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk/ [1]
> ---
>  fs/netfs/read_helper.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
> index 1d3b50c5db6d..193841d03de0 100644
> --- a/fs/netfs/read_helper.c
> +++ b/fs/netfs/read_helper.c
> @@ -933,7 +933,7 @@ void netfs_readahead(struct readahead_control *ractl,
>  EXPORT_SYMBOL(netfs_readahead);
>  
> 
> 
> 
>  /**
> - * netfs_page - Helper to manage a readpage request
> + * netfs_readpage - Helper to manage a readpage request
>   * @file: The file to read from
>   * @page: The page to read
>   * @ops: The network filesystem's operations for the helper to use
> @@ -968,7 +968,7 @@ int netfs_readpage(struct file *file,
>  		return -ENOMEM;
>  	}
>  	rreq->mapping	= page_file_mapping(page);
> -	rreq->start	= page_index(page) * PAGE_SIZE;
> +	rreq->start	= page_file_offset(page);
>  	rreq->len	= thp_size(page);
>  
> 
> 
> 
>  	if (ops->begin_cache_operation) {
> @@ -1106,7 +1106,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  	if (!rreq)
>  		goto error;
>  	rreq->mapping		= page->mapping;
> -	rreq->start		= page->index * PAGE_SIZE;
> +	rreq->start		= page_offset(page);
>  	rreq->len		= thp_size(page);
>  	rreq->no_unlock_page	= page->index;
>  	__set_bit(NETFS_RREQ_NO_UNLOCK_PAGE, &rreq->flags);
> 

Reviewed-by: Jeff Layton <jlayton@kernel.org>

