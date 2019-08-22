Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183079979D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 17:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbfHVPCB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 11:02:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:33520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbfHVPCB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:02:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50044AE3F;
        Thu, 22 Aug 2019 15:02:00 +0000 (UTC)
Date:   Thu, 22 Aug 2019 10:01:58 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, darrick.wong@oracle.com, ruansy.fnst@cn.fujitsu.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 05/13] btrfs: Add CoW in iomap based writes
Message-ID: <20190822150158.5jz74zrf6aiai5kh@fiona>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-6-rgoldwyn@suse.de>
 <20190805001317.GG7689@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805001317.GG7689@dread.disaster.area>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10:13 05/08, Dave Chinner wrote:
> On Fri, Aug 02, 2019 at 05:00:40PM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Set iomap->type to IOMAP_COW and fill up the source map in case
> > the I/O is not page aligned.
> .....
> >  static void btrfs_buffered_page_done(struct inode *inode, loff_t pos,
> >  		unsigned copied, struct page *page,
> >  		struct iomap *iomap)
> > @@ -188,6 +217,7 @@ static int btrfs_buffered_iomap_begin(struct inode *inode, loff_t pos,
> >  	int ret;
> >  	size_t write_bytes = length;
> >  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > +	size_t end;
> >  	size_t sector_offset = pos & (fs_info->sectorsize - 1);
> >  	struct btrfs_iomap *bi;
> >  
> > @@ -255,6 +285,17 @@ static int btrfs_buffered_iomap_begin(struct inode *inode, loff_t pos,
> >  	iomap->private = bi;
> >  	iomap->length = round_up(write_bytes, fs_info->sectorsize);
> >  	iomap->offset = round_down(pos, fs_info->sectorsize);
> > +	end = pos + write_bytes;
> > +	/* Set IOMAP_COW if start/end is not page aligned */
> > +	if (((pos & (PAGE_SIZE - 1)) || (end & (PAGE_SIZE - 1)))) {
> > +		iomap->type = IOMAP_COW;
> > +		ret = get_iomap(inode, pos, length, srcmap);
> > +		if (ret < 0)
> > +			goto release;
> 
> I suspect you didn't test this case, because....
> 
> > +	} else {
> > +		iomap->type = IOMAP_DELALLOC;
> > +	}
> > +
> >  	iomap->addr = IOMAP_NULL_ADDR;
> >  	iomap->type = IOMAP_DELALLOC;
> 
> The iomap->type is overwritten here and so IOMAP_COW will never be
> seen by the iomap infrastructure...

Yes, thats correct. I will fix this.

-- 
Goldwyn
