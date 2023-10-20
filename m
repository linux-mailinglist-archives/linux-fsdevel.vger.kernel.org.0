Return-Path: <linux-fsdevel+bounces-823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22357D0E68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 13:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32245B21483
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 11:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7EC18E29;
	Fri, 20 Oct 2023 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpzAy7Uo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726B9818
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 11:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CCDC433CC;
	Fri, 20 Oct 2023 11:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697801485;
	bh=cqB51XI0pzWC53OjeOyZk1Txgfsis0wzCpCo1xcjdLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XpzAy7UozzIiXgXHtwCr9nUk6L/0a091WSOL41pbDZFboQWvKJIIEzBGEl5kSSXEt
	 SVwTE61+2dsJeammw3EfiX6bOyJfOLyCsrOCYiX710396udNmNb+FGc+9G2rZIl+ZL
	 E9Q9cDsH3iMUJUfU8WhjG11Qtf7aTD5GKklyAkDuRHclZHECkQZPSO4ZNjIYrDWvvv
	 QgliSHOiiQ9R+U9T1HC5226YcecPFYhCpShwnF4OsiN77aZtYCDj47kLx6U9Zurtff
	 52aYwEP4zVjbliT02HS89jRXkAJpBcJfx6jLOzo1Im3urcmTVSwIjo+WNbyUVNCKZu
	 p2dSSP6XwCYdQ==
Date: Fri, 20 Oct 2023 13:31:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Avoid grabbing sb->s_umount under
 bdev->bd_holder_lock
Message-ID: <20231020-enthusiasmus-vielsagend-463a7c821bf3@brauner>
References: <20231018152924.3858-1-jack@suse.cz>
 <20231019-galopp-zeltdach-b14b7727f269@brauner>
 <ZTExy7YTFtToAOOx@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTExy7YTFtToAOOx@infradead.org>

On Thu, Oct 19, 2023 at 06:40:27AM -0700, Christoph Hellwig wrote:
> On Thu, Oct 19, 2023 at 10:33:36AM +0200, Christian Brauner wrote:
> > some device removal. I also messed around with the loop code and
> > specifically used LOOP_CHANGE_FD to force a disk_force_media_change() on
> > a filesystem.
> 
> Can you wire that up for either blktests or xfstests as well?

Yeah, I'll try to find some time to do this.

So while I was testing this I realized that the behavior of
LOOP_CHANGE_FD changed in commit 9f65c489b68d ("loop: raise media_change
event") and I'm not clear whether this is actually correct or not.

loop(4) states
              
"Switch the backing store of the loop device to the new file identified
 file descriptor specified in the (third) ioctl(2) argument, which is an
 integer.  This operation is possible only if the loop device is
 read-only and the new backing store is the same size and type as the
 old backing store."

So the original use-case for this ioctl seems to have been to silently
swap out the backing store. Specifcially it seems to have been used once
upon a time for live images together with device mapper over read-only
loop devices. Where device mapper can direct the writes to some other
location or sm.

Assuming that's correct, I think as long as you have something like
device mapper that doesn't use blk_holder_ops it would still work. But
that commit changed behavior for filesystems because we now do:

loop_change_fd()
-> disk_force_media_change()
   -> bdev_mark_dead()
      -> bdev->bd_holder_ops->mark_dead::fs_mark_dead()

So in essence if you have a filesystem on a loop device via:

truncate -s 10G img1
mkfs.xfs -f img1
LOOP_DEV=$(sudo losetup -f --read-only --show img1)

truncate -s 10G img2
sudo ./loop_change_fd $LOOP_DEV ./img2

We'll shut down that filesystem. I personally think that's correct and
it's buggy not to do that when we have the ability to inform the fs
about media removal but technically it kinda defeats the original
use-case for LOOP_CHANGE_FD.

In practice however, I don't think it matters because I think no one is
using LOOP_CHANGE_FD in that way. Right now all this is a useful for is
a bdev_mark_dead() test.

And one final question:

dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
disk_force_media_change(lo->lo_disk);
/* more stuff */
dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);

What exactly does that achieve? Does it just delay the delivery of the
uevent after the disk sequence number was changed in
disk_force_media_change()? Because it doesn't seem to actually prevent
uevent generation.

