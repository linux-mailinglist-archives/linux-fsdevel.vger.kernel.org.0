Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5656536BB07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 23:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbhDZVKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 17:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbhDZVKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 17:10:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB9FC061574;
        Mon, 26 Apr 2021 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NYuJwxqF2PEsmbKeVEIr3WDBGkL8MXZMkYbUVjkVNZg=; b=jY2FN+I3L5fJ3T4vBPzroyAhJJ
        bAQhEJqZkqEQRNEGHjPtFuuLn5EzUmK1P/ALmswISHmD8Q5gaA3z8qColiMthmeRnYC6k8yDvc2tz
        TCmSecVvocxM9V2FcNzjTIQh6Nxs/Pgr+/W3fRA6s5Zrq+/oD6ttj2yWTDbU+Vo3NOA+hepT0k6k4
        MSt90TIilhTf1dTORLRU8oJHV4ciX9Wk2NUG7fdw1t5RaYedTqEskKf3uWXxfVyYcZHweLVyMQdvp
        2tROOG/71JICjJ0J8/ZKE1w0th18D3hnKTlpMuEnGNvIPpwWlYxzF14iPs9z5XmNMbyu14hcoC/iU
        VAoS+SOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb8U7-0066Gp-Tn; Mon, 26 Apr 2021 21:09:41 +0000
Date:   Mon, 26 Apr 2021 22:09:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        v9fs-developer@lists.sourceforge.net, linux-mm@kvack.org,
        linux-afs@lists.infradead.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Miscellaneous fixes
Message-ID: <20210426210939.GS235567@casper.infradead.org>
References: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
 <3726642.1619471184@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3726642.1619471184@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 10:06:24PM +0100, David Howells wrote:
> @@ -968,7 +968,7 @@ int netfs_readpage(struct file *file,
>  		return -ENOMEM;
>  	}
>  	rreq->mapping	= page_file_mapping(page);
> -	rreq->start	= page_index(page) * PAGE_SIZE;
> +	rreq->start	= page_offset(page);

This one needs to use page_file_offset() because swap-over-NFS.

> @@ -1105,8 +1105,8 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  	rreq = netfs_alloc_read_request(ops, netfs_priv, file);
>  	if (!rreq)
>  		goto error;
> -	rreq->mapping		= page->mapping;
> -	rreq->start		= page->index * PAGE_SIZE;
> +	rreq->mapping		= page_file_mapping(page);

There's nothing wrong with using page->mapping here.  The swap-over-NFS
path doesn't use write_begin, it uses O_DIRECT writes.

