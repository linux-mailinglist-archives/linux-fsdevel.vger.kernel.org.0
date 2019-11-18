Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0F61008BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 16:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfKRPyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 10:54:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:59716 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727310AbfKRPyP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 10:54:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D481ABB1;
        Mon, 18 Nov 2019 15:54:13 +0000 (UTC)
Date:   Mon, 18 Nov 2019 09:54:10 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com
Subject: Re: [PATCH 4/7] btrfs: Use iomap_dio_rw() for direct I/O
Message-ID: <20191118155410.qet6imaflm3opaxk@fiona>
References: <20191115161700.12305-1-rgoldwyn@suse.de>
 <20191115161700.12305-5-rgoldwyn@suse.de>
 <20191115170655.GF26016@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115170655.GF26016@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On  9:06 15/11, Christoph Hellwig wrote:
> On Fri, Nov 15, 2019 at 10:16:57AM -0600, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > This is the main patch to switch call from
> > __blockdev_direct_IO() to iomap_dio_rw(). In this patch:
> > 
> > Removed buffer_head references
> > Removed inode_dio_begin() and inode_dio_end() functions since
> > they are called in iomap_dio_rw().
> > Renamed btrfs_get_blocks_direct() to direct_iomap_begin() and
> > used it as iomap_begin()
> > address_space.direct_IO now is a noop since direct_IO is called
> > from __btrfs_write_direct().
> > 
> > Removed flags parameter used for __blockdev_direct_IO(). iomap is
> > capable of direct I/O reads from a hole, so we don't need to
> > return -ENOENT.
> 
> There isn't really any need to describe the low-level changes,
> but more what this changes at a high level, and more importantly
> the reasons for that.
> 
> >  static int btrfs_get_blocks_direct_write(struct extent_map **map,
> > -					 struct buffer_head *bh_result,
> >  					 struct inode *inode,
> >  					 struct btrfs_dio_data *dio_data,
> >  					 u64 start, u64 len)
> 
> Should this function be renamed as well? btrfs_iomap_begin_write?
> 
> > +static int direct_iomap_begin(struct inode *inode, loff_t start,
> > +		loff_t length, unsigned flags, struct iomap *iomap,
> > +		struct iomap *srcmap)
> 
> This needs a btrfs_ prefix.
> 
> > +	if ((em->block_start == EXTENT_MAP_HOLE) ||
> 
> No need for the inner braces.
> 
> > -	dio_end_io(dio_bio);
> 
> You removed the only users of dio_end_io and the submit hook in the
> old dio code.  Please add a patch to remove those at the end of the
> series.

The submit hook is used by f2fs. I will remove the dio_end_io()
function.

-- 
Goldwyn
