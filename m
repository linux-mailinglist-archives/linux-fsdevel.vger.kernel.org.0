Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC233EA7C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 17:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbhHLPmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 11:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238175AbhHLPmH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:42:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD31FC0617A8;
        Thu, 12 Aug 2021 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rRRInWTXt88iInQrUMslw6/dDmJVHBRbB2u0EULf5Hg=; b=Yw+Dh/oM1oO5pq6qyI7FNo3t6Q
        gx5MdI+3AKoBLfLsXvV7hSsdpymjB+4rVyaoCBxbggUtS1dXiiIkxKYLtAzpxHz8ozQU6o15snaU3
        g/YPrBRrNCj6lMSLi+nqago1irdlmXakhi+FcbIoG42INTBaWENjp2LHhYlaIr7Egfk91IAfElT/m
        5KgDUhy2mv3CYLXkudaTbyYYA0sCBDGG6jWyRU3proN98MFmItee6ftH3yAeDixXfgHs7lNhanbBc
        7KCjjcQwDIXgN+JXH8G+s0MayKXCVykM0HIw3mPAtULVEOvTqJaOSTNd4ke1enrddQTaShxQ/SagD
        EvIXleCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mECo0-00EikE-Vo; Thu, 12 Aug 2021 15:39:47 +0000
Date:   Thu, 12 Aug 2021 16:39:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, trond.myklebust@primarydata.com,
        darrick.wong@oracle.com, jlayton@kernel.org, sfrench@samba.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make swap_readpage() for SWP_FS_OPS use
 ->direct_IO() not ->readpage()
Message-ID: <YRVAvKPn8SjczqrD@casper.infradead.org>
References: <20210812122104.GB18532@lst.de>
 <162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk>
 <162876947840.3068428.12591293664586646085.stgit@warthog.procyon.org.uk>
 <3085432.1628773025@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3085432.1628773025@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 01:57:05PM +0100, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Thu, Aug 12, 2021 at 12:57:58PM +0100, David Howells wrote:
> > > Make swap_readpage(), when accessing a swap file (SWP_FS_OPS) use
> > > the ->direct_IO() method on the filesystem rather then ->readpage().
> > 
> > ->direct_IO is just a helper for ->read_iter and ->write_iter, so please
> > don't call it directly.  It actually is slowly on its way out, with at
> > at least all of the iomap implementations not using it, as well as various
> > other file systems.
> 
> [Note that __swap_writepage() uses ->direct_IO().]
> 
> Calling ->write_iter is probably a bad idea here.  Imagine that it goes
> through, say, generic_file_write_iter(), then __generic_file_write_iter() and
> then generic_file_direct_write().  It adds a number of delays into the system,
> including:
> 
> 	- Taking the inode lock
> 	- Removing file privs
> 	- Cranking mtime, ctime, file version
> 	  - Doing mnt_want_write
> 	  - Setting the inode dirty
> 	- Waiting on pages in the range that are being written 
> 	- Walking over the pagecache to invalidate the range
> 	- Redoing the invalidation (can't be skipped since page 0 is pinned)
> 
> that we might want to skip as they'll end up being done for every page swapped
> out.

I agree with David; we want something lower-level for swap to call into.
I'd suggest aops->swap_rw and an implementation might well look
something like:

static ssize_t ext4_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
{
	return iomap_dio_rw(iocb, iter, &ext4_iomap_ops, NULL, 0);
}
