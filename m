Return-Path: <linux-fsdevel+bounces-60241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3ABB431D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 07:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92784581422
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 05:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D815242D66;
	Thu,  4 Sep 2025 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="I2EYX8Jv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2321D6DA9
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756965319; cv=none; b=fxU7RCY4z9wEMn/hROagJ1TGGSM7ZsZiRvwpqZPqrKpQfs09MzsEHNH9UowLAwQaYHr4V77s7rjley8eOq0/9fD0gIkT4rYvFpjc2kmlZJzaS9JO2hU5etPtnB5LfPJz9lRPvhCEHCjQI+kCL3q3h6FmtHEX8znMBwaag7cn8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756965319; c=relaxed/simple;
	bh=w+tsHjUndrZG0c5my0GNfOtZO5MlrVZB4J83dg3OmDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/N9n8rEgvGrFzDTmD8hFJGaTJstZW13KOIdnPqnaj1VggZMrsqIw2blzsoDVPXgWy3tsy0zGgSqyLVMNJaWaWTYl/uSCbJ/wVdZnf/f3Xp97fgfYU1EpDXStFFQ8uVRYkUSqtnZDV5jxtMdIUkMaZH0EVq8TfeH1AVHnmiOKZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=I2EYX8Jv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=itqNjTNBmqvGxtNvlRCKi+ALTok5ZvtcMkHDoWd2kec=; b=I2EYX8Jv0mvRLb9MpinFw4jHBW
	GLzqzXP/UwQ2zavlKc632wtDWh9oGaADlNUZufPqFdWuUrtEK/KV1ojn23g6RJoJusZR3aeKlb1hj
	GJ8MZnfXKhiVC4ffPP0wWedfKaAHbWPxek0+e6+KXQDJzVrv4LCVnIiPLpEaSL1TtqQv59WqB2VTI
	/nIagOWQtdwJ97Veol2cCSf/FyqVP4ZUEDr5PiAz9Hq3zJs+7wF3alke8TFynUvNsHVbJcCn4oFsK
	gv4OirnNr9eg8G3bMAHtiTos97WzWZas237y5kUREFeeufHKbx1nuCc4hEZ3r58UISjnAVI9xZCBY
	4n/eI8xw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu2wE-0000000DUhg-20Ca;
	Thu, 04 Sep 2025 05:55:14 +0000
Date: Thu, 4 Sep 2025 06:55:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dave Chinner <david@fromorbit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHES v3][RFC][CFT] mount-related stuff
Message-ID: <20250904055514.GA3194878@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250828230706.GA3340273@ZenIV>
 <20250903045432.GH39973@ZenIV>
 <CAHk-=wgXnEyXQ4ENAbMNyFxTfJ=bo4wawdx8s0dBBHVxhfZDCQ@mail.gmail.com>
 <20250903181429.GL39973@ZenIV>
 <aLjamdL8M7T-ZFOS@dread.disaster.area>
 <20250904032024.GN39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904032024.GN39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Sep 04, 2025 at 04:20:24AM +0100, Al Viro wrote:
> On Thu, Sep 04, 2025 at 10:17:29AM +1000, Dave Chinner wrote:
> 
> > > I'm doing
> > > a bisection between v6.12 and v6.10 at the moment, will post when I get
> > > something more useful...
> > 
> > check-parallel is relatively new so, unfortunately, I don't have any
> > idea when this behaviour might have been introduced.
> > 
> > FWIW, 'udevadm wait' is relatively new behaviour for both udev and
> > fstests. It was introduced into fstests for check-parallel to
> > replace 'udevadm settle'. i.e. wait for the specific device to
> > change to a particular state rather than waiting for the entire udev
> > queue to drain.  Check-parallel uses hundreds of block devices and
> > filesystems at the same time resulting in multiple mount/unmount
> > occurring every second. Hence waiting on the udev queue to drain
> > can take a -long- time, but maybe waiting on the device node state
> > chang itself is racy (i.e. might be a udevadm or DM bug) and PREEMPT
> > is opening up that window.
> 
> FWIW, right now it's down to two likely merges, both in 6.12-rc1 window:
> sched and vfs_blocksize (the latter - with iomap and xfs branches in
> it).  There's the third merge in that range, but it's ext4, so I'm
> pretty sure that the next one will be git bisect bad, leaving these
> two.

Bugger...  Either I've got false 'good' at several points, or it's something
brought in by commit 2004cef11ea0 "Merge tag 'sched-core-2024-09-19' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip" - bisection has
converged to something within the first 48 commits of the branch in question.

Which is not impossible, but then the underlying race could've been there
for years before that, only to be exposed by timing changes ;-/

Anyway, I'll get the bisection to the end, but it looks like the end result
won't be particularly useful...

