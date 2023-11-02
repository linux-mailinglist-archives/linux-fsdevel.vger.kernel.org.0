Return-Path: <linux-fsdevel+bounces-1837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010657DF563
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0AC01C20970
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 14:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6041B292;
	Thu,  2 Nov 2023 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mS0qn/iB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B01A282
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 14:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C746C433C7;
	Thu,  2 Nov 2023 14:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698936893;
	bh=BJTFD/V8NhF9xL2Vb2JI1wzz0obRMSgyun4+k7Ugw9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mS0qn/iBxKZEKvGGrtnVqbeXoKkNJRh2yX+sjN9sp80EPCvEYbFaQJfaCMKEdHZ+1
	 /eVzZ6+rIhVkuedaouV9kmdWnlIc6RtzmvHhbMo81QuRbZfYjYOB1Q4tp2BATbjZSr
	 9ll8LVHjc+8hUhcpJZjOqCRtf7t60o891zB3PpcWsZzGxeQbts68ySyE3ghCoU9V1o
	 qpjNuDyDuvTarMA8beLpXWEZCNYFxm5FUo2lLGzus8Pt6X27M3MM0z0Rk1bAmjVSs0
	 h6NQNekzzERttZHnIIzjRc4H+bK2fhUPbE0RGxNI83ST1NiqFwfVWunvI34pSdS/Gh
	 QTiOf36cX8mWQ==
Date: Thu, 2 Nov 2023 15:54:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chandan Babu R <chandanbabu@kernel.org>, Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: viro@zeniv.linux.org.uk, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org,
	linux-xfs@vger.kernel.org, dchinner@fromorbit.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [BUG REPORT] next-20231102: generic/311 fails on XFS with
 external log
Message-ID: <20231102-teich-absender-47a27e86e78f@brauner>
References: <87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64>

On Thu, Nov 02, 2023 at 06:06:10PM +0530, Chandan Babu R wrote:
> Hi,
> 
> generic/311 consistently fails when executing on a kernel built from
> next-20231102.
> 
> The following is the fstests config file that was used during testing.
> 
> export FSTYP=xfs
> 
> export TEST_DEV=/dev/loop0
> export TEST_DIR=/mnt/test
> export TEST_LOGDEV=/dev/loop2
> 
> export SCRATCH_DEV=/dev/loop1
> export SCRATCH_MNT=/mnt/scratch
> export SCRATCH_LOGDEV=/dev/loop3

Thanks for the report. So dm flakey sets up:

/dev/dm-0 over /dev/loop0
/dev/dm-1 over /dev/loop2

and then we mount an xfs filesystem with:

/dev/loop2 as logdev and /dev/loop0 as the main device.

So on current kernels what happens is that if you freeze the main
device you end up:

bdev_freeze(dm-0)
-> get_super(dm-0) # finds xfs sb
   -> freeze_super(sb)

if you also freeze the log device afterwards via:

bdev_freeze(dm-1)
-> get_super(dm-1) # doesn't find xfs sb because freezing only works for
                   # main device

What's currently in -next allows you to roughly do the following:

bdev_freeze(dm-0)
-> fs_bdev_freeze(dm-0->sb)
   -> freeze_super(dm-0->sb) # returns 0

bdev_freeze(dm-1)
-> fs_bdev_freeze(dm-1->sb)
   -> freeze_super(dm-1->sb) # returns -EBUSY

So you'll see EBUSY because the superblock was already frozen when the
main block device was frozen. I was somewhat expecting that we may run
into such issues.

I think we just need to figure out what we want to do in cases the
superblock is frozen via multiple devices. It would probably be correct
to keep it frozen as long as any of the devices is frozen?

