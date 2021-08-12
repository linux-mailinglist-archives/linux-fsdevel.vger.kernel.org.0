Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22A53EA9BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 19:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbhHLRso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 13:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229851AbhHLRso (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:48:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D119E60FED;
        Thu, 12 Aug 2021 17:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628790498;
        bh=hP/339ZqVkiXxXmDbT5cZGbifJvy2J+ZAv1wWKZbOxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLRzb+hJIJSjc0JuOvlwwrJKSPEFw0kNkvr8cfkpZTBB0+g5+8+8oIhoQABfsbKHt
         iJKgd/3hgOKnVM3XM8zy8ldDGeC7+JYcU+k0zDezfEOU9ofQjNUSwS2+jUI23nDwoQ
         2WLN+HqxStGNfA2W/Zf/jM1M/cuH/Xq2xasj4gVLee5uOsVwZVyT/heAVoUweEw5lb
         QgZuWiXcrXolxVmtmWqYYokOtI9F5Xq4N7ke0DmgZ4JroYfHKVxV1u4jb69/v8XIRn
         NIJ0sMb02DvqjLUP7qrnTQtOXJjkss/p1+Cfx0sd2Fo8gNAozACXfhcScN1Fa1JTCr
         l1ZsdJ1CaGQLQ==
Date:   Thu, 12 Aug 2021 10:48:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        trond.myklebust@primarydata.com, darrick.wong@oracle.com,
        jlayton@kernel.org, sfrench@samba.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make swap_readpage() for SWP_FS_OPS use
 ->direct_IO() not ->readpage()
Message-ID: <20210812174818.GK3601405@magnolia>
References: <20210812122104.GB18532@lst.de>
 <162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk>
 <162876947840.3068428.12591293664586646085.stgit@warthog.procyon.org.uk>
 <3085432.1628773025@warthog.procyon.org.uk>
 <YRVAvKPn8SjczqrD@casper.infradead.org>
 <20210812170233.GA4987@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812170233.GA4987@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 07:02:33PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 12, 2021 at 04:39:40PM +0100, Matthew Wilcox wrote:
> > I agree with David; we want something lower-level for swap to call into.
> > I'd suggest aops->swap_rw and an implementation might well look
> > something like:
> > 
> > static ssize_t ext4_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
> > {
> > 	return iomap_dio_rw(iocb, iter, &ext4_iomap_ops, NULL, 0);
> > }
> 
> Yes, that might make sense and would also replace the awkward IOCB_SWAP
> flag for the write side.
> 
> For file systems like ext4 and xfs that have an in-memory block mapping
> tree this would be way better than the current version and also support
> swap on say multi-device file systems properly.  We'd just need to be
> careful to read the extent information in at extent_activate time,
> by doing xfs_iread_extents for XFS or the equivalents in other file
> systems.

You'd still want to walk the extent map at activation time to reject
swapfiles with holes, shared extents, etc., right?

--D
