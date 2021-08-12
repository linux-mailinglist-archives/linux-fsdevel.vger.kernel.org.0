Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BF33EAA11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 20:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbhHLSRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 14:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbhHLSRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:17:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEAAC061756;
        Thu, 12 Aug 2021 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5naNxWdA4pUEsoIepEdmgfKgNVWUTTPIGgMAR+lKKNg=; b=kolKpAxAcGMvgpVrawdSEEL49q
        JwEPW4xC+wT3yIFiGaBpScKIBdDvYGsBhMai8C07lBouE306orWGVk7tHNTNrS5IlPcJW/jyBQYpR
        vt0+Sw7d+hFN47KpQseJFjCTVeHbNWzzaRWQ7P3COJ8NecKhaufewkI5+YlpXKygXjEObJP1CtdAc
        iw++yeMl9tZBc4YCOqbmw5/dWdoaPK1eiZ0eKPT4F0oGDa6BY1SYC3l3upvPzQJQnNmrVwf1O0lXe
        ydSBBvZ8YoElPo2PwBJHoVqOmXAvdk6+nNcUP1Z9U44fGfGMcT3wvu0ePNesSzjdktmfP52+2eE6p
        WrSq1Nlw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEFDx-00EqyA-Vl; Thu, 12 Aug 2021 18:15:12 +0000
Date:   Thu, 12 Aug 2021 19:14:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        trond.myklebust@primarydata.com, darrick.wong@oracle.com,
        jlayton@kernel.org, sfrench@samba.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make swap_readpage() for SWP_FS_OPS use
 ->direct_IO() not ->readpage()
Message-ID: <YRVlDZRIm8zTjDIh@casper.infradead.org>
References: <20210812122104.GB18532@lst.de>
 <162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk>
 <162876947840.3068428.12591293664586646085.stgit@warthog.procyon.org.uk>
 <3085432.1628773025@warthog.procyon.org.uk>
 <YRVAvKPn8SjczqrD@casper.infradead.org>
 <20210812170233.GA4987@lst.de>
 <20210812174818.GK3601405@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812174818.GK3601405@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 10:48:18AM -0700, Darrick J. Wong wrote:
> On Thu, Aug 12, 2021 at 07:02:33PM +0200, Christoph Hellwig wrote:
> > On Thu, Aug 12, 2021 at 04:39:40PM +0100, Matthew Wilcox wrote:
> > > I agree with David; we want something lower-level for swap to call into.
> > > I'd suggest aops->swap_rw and an implementation might well look
> > > something like:
> > > 
> > > static ssize_t ext4_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
> > > {
> > > 	return iomap_dio_rw(iocb, iter, &ext4_iomap_ops, NULL, 0);
> > > }
> > 
> > Yes, that might make sense and would also replace the awkward IOCB_SWAP
> > flag for the write side.
> > 
> > For file systems like ext4 and xfs that have an in-memory block mapping
> > tree this would be way better than the current version and also support
> > swap on say multi-device file systems properly.  We'd just need to be
> > careful to read the extent information in at extent_activate time,
> > by doing xfs_iread_extents for XFS or the equivalents in other file
> > systems.
> 
> You'd still want to walk the extent map at activation time to reject
> swapfiles with holes, shared extents, etc., right?

Well ... this would actually allow the filesystem to break COWs and
allocate new blocks for holes.  Maybe you don't want to be doing that
in a low-memory situation though ;-)
