Return-Path: <linux-fsdevel+bounces-1940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE167E0700
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 17:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6C3281EFB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 16:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C41D553;
	Fri,  3 Nov 2023 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocxeumlY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A4A2D62F
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 16:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73257C433C9;
	Fri,  3 Nov 2023 16:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699030162;
	bh=b0byzkvqEAZ2ZhmQjRA79il18erGEBkgKeMViE1iJYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ocxeumlYDlw5XpdUbvgLPWl8QX5ctyGOH0S3gqdub9egu2M58yHzTts9TUeLsT7HI
	 WDgXeBlEBscKKcRZQx4R//W8yQZQh4wzlwJRjmJRVHXsELxaJ3BdPLm1Io3SAD3EUq
	 Ui9+WmR+ZzQs6F+KyggmDx0tYZq8P7NW5I+E99sPK0oknmZSLweboLRUZ1hUP7AqPU
	 AZIA91UvjrWsHucYvoFltMqWb/cxaBkZZ+iEfK3lXXpY9IXhwhM284HKsvYWBMJYwz
	 rdd3spAuiVKFHYcg9K8S7+FmdnD5LnfQYvVn2ydaBACL2GC6O6hVA70kmuWz0mV+Id
	 Etj+XvKS9p5+g==
Date: Fri, 3 Nov 2023 17:49:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: Re: [PATCH] fs: handle freezing from multiple devices
Message-ID: <20231103-herzform-fabelhaft-3a46cbe7de83@brauner>
References: <87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20231103-vfs-multi-device-freeze-v1-1-fe922b30bfb6@kernel.org>
 <20231103141940.GA3732@lst.de>
 <20231103-leiht-funkverkehr-48ed8d425fd9@brauner>
 <20231103154352.2iz6rqhsjkvcxpyk@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231103154352.2iz6rqhsjkvcxpyk@quack3>

On Fri, Nov 03, 2023 at 04:43:52PM +0100, Jan Kara wrote:
> On Fri 03-11-23 16:10:10, Christian Brauner wrote:
> > On Fri, Nov 03, 2023 at 03:19:40PM +0100, Christoph Hellwig wrote:
> > > On Fri, Nov 03, 2023 at 02:52:27PM +0100, Christian Brauner wrote:
> > > > Fix this by counting the number of block devices that requested the
> > > > filesystem to be frozen in @bdev_count in struct sb_writers and only
> > > > unfreeze once the @bdev_count hits zero. Survives fstests and blktests
> > > > and makes the reproducer succeed.
> > > 
> > > Is there a good reason to not just refcount the freezes in general?
> > 
> > If we start counting freezes in general we break userspace as
> > freeze_super() is called from ioctl_fsfreeze() and that expects to
> > return EBUSY on an already frozen filesystem. xfs scrub might be another
> > user that might break if we change that.
> 
> I guess Christoph meant that we'd count all the sb freezes into the
> refcount (what is now bdev_count) but without HOLDER_BDEV flag we will

Ah, sorry I didn't get that from the message.

> return EBUSY if the refcount is > 0 instead of incrementing it.

Yeah, that should work. I'm playing with this rn.

> There would be a subtle behavioral difference that now if you freeze the fs
> with ioctl_fsfreeze() and then try to freeze through the blockdev, you'll
> get EBUSY while with the new method the bdev freeze will succeed but I
> don't think that can do any harm. It even kind of makes more sense.

Yeah, though afaict that change is independent of whether we count all
freeze_super() calls or only such with HOLDER_BDEV. I've had the same
reaction as you.

