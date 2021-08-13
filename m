Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CA63EB0B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 08:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbhHMGzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 02:55:06 -0400
Received: from verein.lst.de ([213.95.11.211]:46481 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238977AbhHMGy4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 02:54:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 28DA967373; Fri, 13 Aug 2021 08:54:27 +0200 (CEST)
Date:   Fri, 13 Aug 2021 08:54:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        trond.myklebust@primarydata.com, darrick.wong@oracle.com,
        jlayton@kernel.org, sfrench@samba.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make swap_readpage() for SWP_FS_OPS use
 ->direct_IO() not ->readpage()
Message-ID: <20210813065426.GA26243@lst.de>
References: <20210812122104.GB18532@lst.de> <162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk> <162876947840.3068428.12591293664586646085.stgit@warthog.procyon.org.uk> <3085432.1628773025@warthog.procyon.org.uk> <YRVAvKPn8SjczqrD@casper.infradead.org> <20210812170233.GA4987@lst.de> <20210812174818.GK3601405@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812174818.GK3601405@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
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

Yes.  While direct I/O code could do allocation at swap I/O time that
probably is not a good idea due to the memory requirements.
