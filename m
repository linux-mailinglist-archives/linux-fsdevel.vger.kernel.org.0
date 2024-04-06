Return-Path: <linux-fsdevel+bounces-16298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D1589ACC5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 21:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CAA28205A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 19:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3C44CE17;
	Sat,  6 Apr 2024 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ETQbf6Np"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084AF2E419;
	Sat,  6 Apr 2024 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712432545; cv=none; b=q9KWAM9m8X3kkADkQ973a4EpvNm/d39ideu9Jheog2XA+NbZN/ktlXriBkcaWgGSmI4dxSRsWacN6bpSh7o5q7Y/Lwq5QYn45b4svASvLu5wGKd9UEgJbVjcAi6CC1rJiWcEBIfkajO23jdwsmHHF+XUJc0QTWvbbrvforiO0H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712432545; c=relaxed/simple;
	bh=FQOx6neNfjf28as4+qdgLiKcxs8a3QWN1kgr8cW+bt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzDhwsiAHZHecYxIg0A4h0bfrrN4/zoA/+IEuBdCCBkQmaYJBm3YKrjkMET33g5EJYZw5EJ98HatL6VctTKrt06XOALiwqAPmllU67q4ioMLrMbx2l4LXeLcSC/PXuMsOLP29phHqN5K8/KchNtHCzm443Hly0g0kjt6U5JdFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ETQbf6Np; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=12s9IqCzKg6mDwJlnb73Nn/9S6R6dU8UO0E4IWBh+L0=; b=ETQbf6NpzsfS+4sfGBNEXD88O6
	K7R0EVgl/2uQdUQpxH5phxJkEcCWpb2cU4rTZ87ttLSlaBTCB7krUuXnoQ2+uFtR26JxsSl9frFww
	ViimFAF5598Unu5bSYuouJkMOYX+MLkLZtZ0J0GI/OM0GzvjT8tXTqPOANL+HSunZSMWTHvNivJuy
	r6MEA4kf42rbT+K1XSl8XhOmkFedwg3zXT0styV/qtzoR/vm+iu2Z9WY5JTtnQjnaY/An7etszz3K
	83BvP7YVoHbH/WKlPlBYfWjzJNlFZLAi4bUAsuNqO8Ekf4MUHak8jZOHKKrtXWB4svpUoYHJ7A0za
	+l3ZQgwQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rtBvS-007MrB-1m;
	Sat, 06 Apr 2024 19:42:06 +0000
Date: Sat, 6 Apr 2024 20:42:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240406194206.GC538574@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-23-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406090930.2252838-23-yukuai1@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 06, 2024 at 05:09:26PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> So that iomap and bffer_head can convert to use bdev_file in following
> patches.

Let me see if I got it straight.  You introduce dummy struct file instances
(no methods, nothing).  The *ONLY* purpose they serve is to correspond to
opened instances of struct bdev.  No other use is possible.

You shove them into ->i_private of bdevfs inodes.  Lifetime rules are...
odd.

In bdev_open() you arrange for such beast to be present.  You never
return it anywhere, they only get accessed via ->i_private, exposing
it at least to fs/buffer.c.  Reference to those suckers get stored
(without grabbing refcount) into buffer_head instances.

And all of that is for... what, exactly?

