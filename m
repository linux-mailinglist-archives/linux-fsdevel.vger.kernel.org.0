Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2602FE679
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 10:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbhAUJgm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 04:36:42 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:51558 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728438AbhAUJgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:36:37 -0500
Received: from dread.disaster.area (pa49-180-243-77.pa.nsw.optusnet.com.au [49.180.243.77])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id B5D24114066A;
        Thu, 21 Jan 2021 20:35:49 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l2WNZ-000pA8-1m; Thu, 21 Jan 2021 20:35:49 +1100
Date:   Thu, 21 Jan 2021 20:35:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 11/11] xfs: reduce exclusive locking on unaligned dio
Message-ID: <20210121093549.GC4662@dread.disaster.area>
References: <20210121085906.322712-1-hch@lst.de>
 <20210121085906.322712-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121085906.322712-12-hch@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=juxvdbeFDU67v5YkIhU0sw==:117 a=juxvdbeFDU67v5YkIhU0sw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=20KFwNOVAAAA:8 a=in2YdIHcAAAA:8
        a=7-415B0cAAAA:8 a=OdnFOmsemsuJ_AWq354A:9 a=CjuIK1q_8ugA:10
        a=jvJaD-jWAXz1fu1h5wd8:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 09:59:06AM +0100, Christoph Hellwig wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Attempt shared locking for unaligned DIO, but only if the the
> underlying extent is already allocated and in written state. On
> failure, retry with the existing exclusive locking.
> 
> Test case is fio randrw of 512 byte IOs using AIO and an iodepth of
> 32 IOs.
> 
> Vanilla:
> 
>   READ: bw=4560KiB/s (4670kB/s), 4560KiB/s-4560KiB/s (4670kB/s-4670kB/s), io=134MiB (140MB), run=30001-30001msec
>   WRITE: bw=4567KiB/s (4676kB/s), 4567KiB/s-4567KiB/s (4676kB/s-4676kB/s), io=134MiB (140MB), run=30001-30001msec
> 
> Patched:
>    READ: bw=37.6MiB/s (39.4MB/s), 37.6MiB/s-37.6MiB/s (39.4MB/s-39.4MB/s), io=1127MiB (1182MB), run=30002-30002msec
>   WRITE: bw=37.6MiB/s (39.4MB/s), 37.6MiB/s-37.6MiB/s (39.4MB/s-39.4MB/s), io=1128MiB (1183MB), run=30002-30002msec
> 
> That's an improvement from ~18k IOPS to a ~150k IOPS, which is
> about the IOPS limit of the VM block device setup I'm testing on.
> 
> 4kB block IO comparison:
> 
>    READ: bw=296MiB/s (310MB/s), 296MiB/s-296MiB/s (310MB/s-310MB/s), io=8868MiB (9299MB), run=30002-30002msec
>   WRITE: bw=296MiB/s (310MB/s), 296MiB/s-296MiB/s (310MB/s-310MB/s), io=8878MiB (9309MB), run=30002-30002msec
> 
> Which is ~150k IOPS, same as what the test gets for sub-block
> AIO+DIO writes with this patch.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> [hch: rebased, split unaligned from nowait]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good, minor nit:

> +	/*
> +	 * For overwrite only I/O, we cannot convert unwritten extents without
> +	 * requiring sub-block zeroing.  This can only be done under an
> +	 * exclusive IOLOCK, hence return -EAGAIN if this is not a written
> +	 * extent to tell the caller to try again.
> +	 */
> +	if (flags & IOMAP_OVERWRITE_ONLY) {
> +		error = -EAGAIN;
> +		if (imap.br_state != XFS_EXT_NORM &&
> +		    ((offset & mp->m_blockmask) ||
> +		     ((offset + length) & mp->m_blockmask)))
> +			goto out_unlock;

Why not use the ((offset | length) & mp->blockmask) form of
alignment checking here?

Other than that,

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
