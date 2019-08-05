Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F324F80F9A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 02:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfHEAXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Aug 2019 20:23:35 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:52259 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbfHEAXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Aug 2019 20:23:34 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B51742AD02C;
        Mon,  5 Aug 2019 10:23:32 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1huQcn-0004z2-Cd; Mon, 05 Aug 2019 10:13:17 +1000
Date:   Mon, 5 Aug 2019 10:13:17 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, darrick.wong@oracle.com, ruansy.fnst@cn.fujitsu.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 05/13] btrfs: Add CoW in iomap based writes
Message-ID: <20190805001317.GG7689@dread.disaster.area>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-6-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802220048.16142-6-rgoldwyn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=iox4zFpeAAAA:8 a=7-415B0cAAAA:8 a=xrbE8zg4DYH3kasu_qsA:9
        a=Pi3r_Vvt8M2xccad:21 a=-2u5YDMPb6Z7_WoB:21 a=CjuIK1q_8ugA:10
        a=WzC6qhA0u3u7Ye7llzcV:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 05:00:40PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Set iomap->type to IOMAP_COW and fill up the source map in case
> the I/O is not page aligned.
.....
>  static void btrfs_buffered_page_done(struct inode *inode, loff_t pos,
>  		unsigned copied, struct page *page,
>  		struct iomap *iomap)
> @@ -188,6 +217,7 @@ static int btrfs_buffered_iomap_begin(struct inode *inode, loff_t pos,
>  	int ret;
>  	size_t write_bytes = length;
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	size_t end;
>  	size_t sector_offset = pos & (fs_info->sectorsize - 1);
>  	struct btrfs_iomap *bi;
>  
> @@ -255,6 +285,17 @@ static int btrfs_buffered_iomap_begin(struct inode *inode, loff_t pos,
>  	iomap->private = bi;
>  	iomap->length = round_up(write_bytes, fs_info->sectorsize);
>  	iomap->offset = round_down(pos, fs_info->sectorsize);
> +	end = pos + write_bytes;
> +	/* Set IOMAP_COW if start/end is not page aligned */
> +	if (((pos & (PAGE_SIZE - 1)) || (end & (PAGE_SIZE - 1)))) {
> +		iomap->type = IOMAP_COW;
> +		ret = get_iomap(inode, pos, length, srcmap);
> +		if (ret < 0)
> +			goto release;

I suspect you didn't test this case, because....

> +	} else {
> +		iomap->type = IOMAP_DELALLOC;
> +	}
> +
>  	iomap->addr = IOMAP_NULL_ADDR;
>  	iomap->type = IOMAP_DELALLOC;

The iomap->type is overwritten here and so IOMAP_COW will never be
seen by the iomap infrastructure...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
