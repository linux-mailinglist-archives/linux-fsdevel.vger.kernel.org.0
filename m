Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFEA56279
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 08:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfFZGka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 02:40:30 -0400
Received: from verein.lst.de ([213.95.11.211]:40546 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfFZGk3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:40:29 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id AB0EC68B05; Wed, 26 Jun 2019 08:39:57 +0200 (CEST)
Date:   Wed, 26 Jun 2019 08:39:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        david@fromorbit.com
Subject: Re: [PATCH 1/6] iomap: Use a IOMAP_COW/srcmap for a
 read-modify-write I/O
Message-ID: <20190626063957.GA24201@lst.de>
References: <20190621192828.28900-1-rgoldwyn@suse.de> <20190621192828.28900-2-rgoldwyn@suse.de> <20190624070734.GB3675@lst.de> <20190625191442.m27cwx5o6jtu2qch@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625191442.m27cwx5o6jtu2qch@fiona>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 02:14:42PM -0500, Goldwyn Rodrigues wrote:
> > I can't say I'm a huge fan of this two iomaps in one method call
> > approach.  I always though two separate iomap iterations would be nicer,
> > but compared to that even the older hack with just the additional
> > src_addr seems a little better.
> 
> I am just expanding on your idea of using multiple iterations for the Cow case
> in the hope we can come out of a good design:
> 
> 1. iomap_file_buffered_write calls iomap_apply with IOMAP_WRITE flag.
>    which calls iomap_begin() for the respective filesystem.
> 2. btrfs_iomap_begin() sets up iomap->type as IOMAP_COW and fills iomap
>    struct with read addr information.
> 3. iomap_apply() conditionally for IOMAP_COW calls do_cow(new function)
>    and calls ops->iomap_begin() with flag IOMAP_COW_READ_DONE(new flag).
> 4. btrfs_iomap_begin() fills up iomap structure with write information.
> 
> Step 3 seems out of place because iomap_apply should be iomap.type agnostic.
> Right?
> Should we be adding another flag IOMAP_COW_DONE, just to figure out that
> this is the "real" write for iomap_begin to fill iomap?
> 
> If this is not how you imagined, could you elaborate on the dual iteration
> sequence?

Here are my thoughts from dealing with this from a while ago, all
XFS based of course.

If iomap_file_buffered_write is called on a page that is inside a COW
extent we have the following options:

 a) the page is updatodate or entirely overwritten.  We cn just allocate
    new COW blocks and return them, and we are done
 b) the page is not/partially uptodate and not entirely overwritten.

The latter case is the interesting one.  My thought was that iff the
IOMAP_F_SHARED flag is set __iomap_write_begin / iomap_read_page_sync
will then have to retreive the source information in some form.

My original plan was to just do a nested iomap_apply call, which would
need a special nested flag to not duplicate any locking the file
system might be holding between ->iomap_begin and ->iomap_end.

The upside here is that there is no additional overhead for the non-COW
path and the architecture looks relatively clean.  The downside is that
at least for XFS we usually have to look up the source information
anyway before allocating the COW destination extent, so we'd have to
cache that information somewhere or redo it, which would be rather
pointless.  At that point the idea of a srcaddr in the iomap becomes
interesting again - while it looks a little ugly from the architectural
POV it actually ends up having very practical benefits.
> 
> 
> -- 
> Goldwyn
---end quoted text---
