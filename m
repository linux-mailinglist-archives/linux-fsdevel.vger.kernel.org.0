Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BA6570E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 20:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfFZSmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 14:42:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:42380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbfFZSmx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:42:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CFED6AE12;
        Wed, 26 Jun 2019 18:42:51 +0000 (UTC)
Date:   Wed, 26 Jun 2019 13:42:49 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com
Subject: Re: [PATCH 1/6] iomap: Use a IOMAP_COW/srcmap for a
 read-modify-write I/O
Message-ID: <20190626184249.n24wffrqxa2sdrc7@fiona>
References: <20190621192828.28900-1-rgoldwyn@suse.de>
 <20190621192828.28900-2-rgoldwyn@suse.de>
 <20190624070734.GB3675@lst.de>
 <20190625191442.m27cwx5o6jtu2qch@fiona>
 <20190626180005.GB5164@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626180005.GB5164@magnolia>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11:00 26/06, Darrick J. Wong wrote:
> On Tue, Jun 25, 2019 at 02:14:42PM -0500, Goldwyn Rodrigues wrote:
> > On  9:07 24/06, Christoph Hellwig wrote:
> > > xfs will need to be updated to fill in the additional iomap for the
> > > COW case.  Has this series been tested on xfs?
> > > 
> > 
> > No, I have not tested this, or make xfs set IOMAP_COW. I will try to do
> > it in the next iteration.
> 
> AFAICT even if you did absolutely nothing XFS would continue to work
> properly because iomap_write_begin doesn't actually care if it's going
> to be a COW write because the only IO it does from the mapping is to
> read in the non-uptodate parts of the page if the write offset/len
> aren't page-aligned.
> 
> > > I can't say I'm a huge fan of this two iomaps in one method call
> > > approach.  I always though two separate iomap iterations would be nicer,
> > > but compared to that even the older hack with just the additional
> > > src_addr seems a little better.
> > 
> > I am just expanding on your idea of using multiple iterations for the Cow case
> > in the hope we can come out of a good design:
> > 
> > 1. iomap_file_buffered_write calls iomap_apply with IOMAP_WRITE flag.
> >    which calls iomap_begin() for the respective filesystem.
> > 2. btrfs_iomap_begin() sets up iomap->type as IOMAP_COW and fills iomap
> >    struct with read addr information.
> > 3. iomap_apply() conditionally for IOMAP_COW calls do_cow(new function)
> >    and calls ops->iomap_begin() with flag IOMAP_COW_READ_DONE(new flag).
> 
> Unless I'm misreading this, you don't need a do_cow() or
> IOMAP_COW_READ_DONE because the page state tracks that for you:
> 
> iomap_write_begin calls ->iomap_begin to learn from where it should read
> data if the write is not aligned to a page and the page isn't uptodate.
> If it's IOMAP_COW then we learn from *srcmap instead of *iomap.
> 

We were discussing the single iomap structure (without srcmap), but
with two iterations, the first to get the read information and the second
to get the write information for CoW.

> (The write actor then dirties the page)
> 
> fsync() or whatever
> 
> The mm calls ->writepage.  The filesystem grabs the new COW mapping,
> constructs a bio with the new mapping and dirty pages, and submits the
> bio.  pagesize >= blocksize so we're always writing full blocks.
> 
> The writeback bio completes and calls ->bio_endio, which is the
> filesystem's trigger to make the mapping changes permanent, update
> ondisk file size, etc.
> 
> For direct writes that are not block-aligned, we just bounce the write
> to the page cache...
> 
> ...so it's only dax_iomap_rw where we're going to have to do the COW
> ourselves.  That's simple -- map both addresses, copy the regions before
> offset and after offset+len, then proceed with writing whatever
> userspace sent us.  No need for the iomap code itself to get involved.

Yes, this is how the latest patch series is working, with two iomap
structures in iomap_begin() function parameters.

-- 
Goldwyn
