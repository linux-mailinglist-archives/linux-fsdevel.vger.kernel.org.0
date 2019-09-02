Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94203A5BBB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 19:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfIBRNW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 13:13:22 -0400
Received: from verein.lst.de ([213.95.11.211]:51696 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbfIBRNW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 13:13:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 059D868AFE; Mon,  2 Sep 2019 19:13:19 +0200 (CEST)
Date:   Mon, 2 Sep 2019 19:13:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 03/15] iomap: Read page from srcmap for IOMAP_COW
Message-ID: <20190902171318.GA7102@lst.de>
References: <20190901200836.14959-1-rgoldwyn@suse.de> <20190901200836.14959-4-rgoldwyn@suse.de> <20190902163124.GC6263@lst.de> <20190902170109.GD568270@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902170109.GD568270@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 10:01:09AM -0700, Darrick J. Wong wrote:
> On Mon, Sep 02, 2019 at 06:31:24PM +0200, Christoph Hellwig wrote:
> > On Sun, Sep 01, 2019 at 03:08:24PM -0500, Goldwyn Rodrigues wrote:
> > 
> > > +		iomap_assert(!(iomap->flags & IOMAP_F_BUFFER_HEAD));
> > > +		iomap_assert(srcmap->type == IOMAP_HOLE || srcmap->addr > 0);
> > 
> > 0 can be a valid address in various file systems, so I don't think we
> > can just exclude it.  Then again COWing from a hole seems pointless,
> > doesn't it?
> 
> XFS does that if you set a cowextsize hint and a speculative cow
> preallocation ends up covering a hole.  Granted I don't think there's
> much point in reading from a COW fork extent to fill in an unaligned
> buffered write since it /should/ just end up zero-filling the pagecache
> regardless of fork... but I don't see much harm in doing that.

That assumes you'd set the iomap-level COW flag for anything that
writes to the COW fork in XFS.  Which doesn't sound right to me - the
iomap-level indicates that we actually need to read some data, which
for a hole is rather pointless as you said.
