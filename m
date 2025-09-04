Return-Path: <linux-fsdevel+bounces-60238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882BEB43062
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 05:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3E05458A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 03:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8987A274FCB;
	Thu,  4 Sep 2025 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fvBfR2gN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2652625486D
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756956030; cv=none; b=fMQcad6zyf+gNYo2qEuGZ7N5RYHkbpbvXJhzn26VAiV9FK7kJWqD3q/1tOQmrH9FWMUnNTCqurKkAhAMfyL0gsd/uvqjBLxRGqfj0qZh+K6jOCu4CnP7xgcdmCTew6YruQHqoMiVoqWjf1W+gNtuSL31ulfrydp9ozjUoMPsVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756956030; c=relaxed/simple;
	bh=nXgMvpDrV+kKvxodmt3j6XlYI9PFu4oLjT/x60gOmPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHzOK1IanwYNrW/rc5nn6NG51RVzFS4IpIYdRfPKLDuKJblwpeYdreKdj6jKreZ7xOmULYE1wdcMF+8rMrArKHZDm92F5ZVsgkidb8flKqdVmpSJTkvOyTOhtEF0akLc6XEKSc45+/u82yT2Z6e6HahBmUAH51Gb7DpwXHhWGqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fvBfR2gN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Sc1SXWl8H8OzNkxZRnJ9iHoxVOROeb9K7zDHmg1QJaI=; b=fvBfR2gN5nPQ43mDQ5VI977cjp
	l4s7CN8cliM7g4kbw8Xa8XqXSEARd5hK0cpUrVCqNcxmzfzxki2ka8YnHy1wqm7MNSzL2QC/Tv3PS
	fGdgls94bDY+1a7NzaRFkbSeQsT3geRnv1YEKLF0pHBoT7gPRhnSmtGhcOGTNycUY/H8EfyRExQL7
	XDFX5S9Zb5zgohYq2j7AS4AGZoujrv7yJFwxVCQFSmsR1RqJQ3Oh61XJ0Bl8kqbJsg0nATpTTdwq4
	j+WmqikaZM6iFxD4MzupxANtDknsKTwjvmElar7Tvu5OS2oL80OCemZwufvtNezXrYwLtiMZSMurU
	pl3MAiTg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu0WO-0000000Bbob-0zrv;
	Thu, 04 Sep 2025 03:20:24 +0000
Date: Thu, 4 Sep 2025 04:20:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dave Chinner <david@fromorbit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHES v3][RFC][CFT] mount-related stuff
Message-ID: <20250904032024.GN39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250828230706.GA3340273@ZenIV>
 <20250903045432.GH39973@ZenIV>
 <CAHk-=wgXnEyXQ4ENAbMNyFxTfJ=bo4wawdx8s0dBBHVxhfZDCQ@mail.gmail.com>
 <20250903181429.GL39973@ZenIV>
 <aLjamdL8M7T-ZFOS@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLjamdL8M7T-ZFOS@dread.disaster.area>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Sep 04, 2025 at 10:17:29AM +1000, Dave Chinner wrote:

> > I'm doing
> > a bisection between v6.12 and v6.10 at the moment, will post when I get
> > something more useful...
> 
> check-parallel is relatively new so, unfortunately, I don't have any
> idea when this behaviour might have been introduced.
> 
> FWIW, 'udevadm wait' is relatively new behaviour for both udev and
> fstests. It was introduced into fstests for check-parallel to
> replace 'udevadm settle'. i.e. wait for the specific device to
> change to a particular state rather than waiting for the entire udev
> queue to drain.  Check-parallel uses hundreds of block devices and
> filesystems at the same time resulting in multiple mount/unmount
> occurring every second. Hence waiting on the udev queue to drain
> can take a -long- time, but maybe waiting on the device node state
> chang itself is racy (i.e. might be a udevadm or DM bug) and PREEMPT
> is opening up that window.

FWIW, right now it's down to two likely merges, both in 6.12-rc1 window:
sched and vfs_blocksize (the latter - with iomap and xfs branches in
it).  There's the third merge in that range, but it's ext4, so I'm
pretty sure that the next one will be git bisect bad, leaving these
two.

