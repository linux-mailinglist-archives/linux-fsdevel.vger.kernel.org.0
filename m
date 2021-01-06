Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E2B2EC669
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 23:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbhAFWwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 17:52:50 -0500
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:57278 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbhAFWwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 17:52:49 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id BA583E49CED;
        Thu,  7 Jan 2021 09:52:02 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kxHer-003ma6-W2; Thu, 07 Jan 2021 09:52:02 +1100
Date:   Thu, 7 Jan 2021 09:52:01 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Message-ID: <20210106225201.GF331610@dread.disaster.area>
References: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=gSSnLTXk-G5GmvmscTwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 29, 2020 at 10:28:19PM -0800, Andres Freund wrote:
> Hi,
> 
> For things like database journals using fallocate(0) is not sufficient,
> as writing into the the pre-allocated data with O_DIRECT | O_DSYNC
> writes requires the unwritten extents to be converted, which in turn
> requires journal operations.
> 
> The performance difference in a journalling workload (lots of
> sequential, low-iodepth, often small, writes) is quite remarkable. Even
> on quite fast devices:
> 
>     andres@awork3:/mnt/t3$ grep /mnt/t3 /proc/mounts
>     /dev/nvme1n1 /mnt/t3 xfs rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota 0 0
> 
>     andres@awork3:/mnt/t3$ fallocate -l $((1024*1024*1024)) test_file
> 
>     andres@awork3:/mnt/t3$ dd if=/dev/zero of=test_file bs=4096 conv=notrunc iflag=count_bytes count=$((1024*1024*1024)) oflag=direct,dsync
>     262144+0 records in
>     262144+0 records out
>     1073741824 bytes (1.1 GB, 1.0 GiB) copied, 117.587 s, 9.1 MB/s
> 
>     andres@awork3:/mnt/t3$ dd if=/dev/zero of=test_file bs=4096 conv=notrunc iflag=count_bytes count=$((1024*1024*1024)) oflag=direct,dsync
>     262144+0 records in
>     262144+0 records out
>     1073741824 bytes (1.1 GB, 1.0 GiB) copied, 3.69125 s, 291 MB/s
> 
>     andres@awork3:/mnt/t3$ fallocate -z -l $((1024*1024*1024)) test_file
> 
>     andres@awork3:/mnt/t3$ dd if=/dev/zero of=test_file bs=4096 conv=notrunc iflag=count_bytes count=$((1024*1024*1024)) oflag=direct,dsync
>     z262144+0 records in
>     262144+0 records out
>     1073741824 bytes (1.1 GB, 1.0 GiB) copied, 109.398 s, 9.8 MB/s
> 
>     andres@awork3:/mnt/t3$ dd if=/dev/zero of=test_file bs=4096 conv=notrunc iflag=count_bytes count=$((1024*1024*1024)) oflag=direct,dsync
>     262144+0 records in
>     262144+0 records out
>     1073741824 bytes (1.1 GB, 1.0 GiB) copied, 3.76166 s, 285 MB/s
> 
> 
> The way around that, from a database's perspective, is obviously to just
> overwrite the file "manually" after fallocate()ing it, utilizing larger
> writes, and then to recycle the file.
> 
> 
> But that's a fair bit of unnecessary IO from userspace, and it's IO that
> the kernel can do more efficiently on a number of types of block
> devices, e.g. by utilizing write-zeroes.
> 
> 
> Which brings me to $subject:
> 
> Would it make sense to add a variant of FALLOC_FL_ZERO_RANGE that
> doesn't convert extents into unwritten extents, but instead uses
> blkdev_issue_zeroout() if supported?  Mostly interested in xfs/ext4
> myself, but ...

We have explicit requests from users (think initialising large VM
images) that FALLOC_FL_ZERO_RANGE must never fall back to writing
zeroes manually.

Because those users want us to guarantee that FALLOC_FL_ZERO_RANGE
is *always* going to be faster than writing a large range of zeroes.

They also want FALLOC_FL_ZERO_RANGE to fail if it can't zero the
range by metadata manipulation and would need to write zeros,
because then they can make the choice on how to initialise the
device (e.g. at runtime, via on-demand ZERO_RANGE calls, by writing
zeroes to pad partial blocks, etc). That bird has already flown,
so we can't really do that retrospectively, but we really don't want
to make life worse for these users.

IOWs, while you might want FALLOC_FL_ZERO_RANGE to explicitly write
zeros, we have users who explicitly don't want it to do this.

Perhaps we should add want FALLOC_FL_CONVERT_RANGE, which tells the
filesystem to convert an unwritten range of zeros to a written range
by manually writing zeros. i.e. you do FALLOC_FL_ZERO_RANGE to zero
the range and fill holes using metadata manipulation, followed by
FALLOC_FL_WRITE_RANGE to then convert the "metadata zeros" to real
written zeros.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
