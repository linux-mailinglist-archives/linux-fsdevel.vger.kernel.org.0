Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A82680F97
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 02:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfHEAXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Aug 2019 20:23:31 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:51967 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbfHEAXb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Aug 2019 20:23:31 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6625D2AD0E8;
        Mon,  5 Aug 2019 10:23:28 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1huQai-0004yg-0N; Mon, 05 Aug 2019 10:11:08 +1000
Date:   Mon, 5 Aug 2019 10:11:07 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, darrick.wong@oracle.com, ruansy.fnst@cn.fujitsu.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/13] btrfs: Add a simple buffered iomap write
Message-ID: <20190805001107.GF7689@dread.disaster.area>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-5-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802220048.16142-5-rgoldwyn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=iox4zFpeAAAA:8 a=7-415B0cAAAA:8 a=ywC-tYdIaJM7w0WYXF8A:9
        a=CjuIK1q_8ugA:10 a=igBNqPyMv6gA:10 a=WzC6qhA0u3u7Ye7llzcV:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 05:00:39PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Introduce a new btrfs_iomap structure which contains information
> about the filesystem between the iomap_begin() and iomap_end() calls.
> This contains information about reservations and extent locking.
> 
> This one is a long patch. Most of the code is "inspired" by
> fs/btrfs/file.c. To keep the size small, all removals are in
> following patches.

I can't comment on the btrfs code but this:

> +size_t btrfs_buffered_iomap_write(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	ssize_t written;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	written = iomap_file_buffered_write(iocb, from, &btrfs_buffered_iomap_ops);
> +	if (written > 0)
> +		iocb->ki_pos += written;
> +	if (iocb->ki_pos > i_size_read(inode))
> +		i_size_write(inode, iocb->ki_pos);
> +	return written;

Looks like it fails to handle O_[D]SYNC writes.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
