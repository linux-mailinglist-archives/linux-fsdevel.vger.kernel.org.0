Return-Path: <linux-fsdevel+bounces-16195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DBF899EB6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 15:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262021F243EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 13:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B01D16D9B3;
	Fri,  5 Apr 2024 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTPdHpmG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B7916131A;
	Fri,  5 Apr 2024 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324907; cv=none; b=faQqLyQPt9eKve0ImXbzQlgD0HMaTkLTkBhyTBWZEaDgIHwUsB9Xpc5jPy9L5DctrSAgn73/avCoJdHkhDD/+xoAMLNhOmwoorWmhZ1u8OA//udTsDyDavSentJBzDhP0KU2nqzUZ+6QWElHvzoEW68ADY1/wnndJgjFMw63t5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324907; c=relaxed/simple;
	bh=joolmc4LtKTv8gZerkw3rQ+TPn8Z4H7XsFQKjvP3UV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMvHBYNAu0QEIz2z7Aa7bYvhHjaSNuHlmOGQsgtlShMPDK7hWLw8is96Odxm06cR07Tb5HJ7XhfLta4RQbaxSg2J6UE44GpgnK9SHRp8r9inlO2OUQNdw54uvEBfbgfyNQWX84Kua9RlqbbxZEwVPcjBSfVbwSsVgC+BqtGx2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTPdHpmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAEFC433F1;
	Fri,  5 Apr 2024 13:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712324907;
	bh=joolmc4LtKTv8gZerkw3rQ+TPn8Z4H7XsFQKjvP3UV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tTPdHpmGUxHtdEjhVn5pMRejA0anBNCardSo/ZWe8tPR2tv6L1mdV05eI/4faBQ8m
	 b0/BIVbYCUHuAZ14XFnfBorEI2IZZWj9J/zYqoQmXDrKL8vVgANzfe6n/ptuewqDXb
	 JnDVfp6fGfPwceh5ALURhg3pS3P5RqcEgVE8Q36AiUU7Ep7xArDKb0CBIDy5Aa//fl
	 rAXDL8z+JvzrhydoheDU4p829mc/GkZ85mdelO3hFnmy6weXgxe+C2vimt9Lz0bsqd
	 PbhAwCqCnbUDunX5wPhd3TCVVAwuMqr0YflibS5mRgtrZlJDta16LPPnJvDcx6LE7t
	 BpB6drS+Mk+CA==
Date: Fri, 5 Apr 2024 15:48:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Amir Goldstein <amir73il@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	valesini@yandex-team.ru, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <20240405-liebschaft-effekt-ca71fb6e7699@brauner>
References: <00000000000098f75506153551a1@google.com>
 <0000000000002f2066061539e54b@google.com>
 <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
 <20240404081122.GQ538574@ZenIV>
 <20240404082110.GR538574@ZenIV>
 <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com>
 <20240405065135.GA3959@lst.de>
 <20240405-ozonwerte-hungrig-326d97c62e65@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240405-ozonwerte-hungrig-326d97c62e65@brauner>

On Fri, Apr 05, 2024 at 01:19:35PM +0200, Christian Brauner wrote:
> On Fri, Apr 05, 2024 at 08:51:35AM +0200, Christoph Hellwig wrote:
> > On Thu, Apr 04, 2024 at 12:33:40PM +0300, Amir Goldstein wrote:
> > > I don't follow what you are saying.
> > > Which code is in non-starter violation?
> > > kernfs for calling lookup_bdev() with internal of->mutex held?
> > 
> > That is a huge problem, and has been causing endless annoying lockdep
> > chains in the block layer for us.  If we have some way to kill this
> > the whole block layer would benefit.
> 
> Why not just try and add a better resume api that forces resume to not
> use a path argument neither for resume_file nor for writes to
> /sys/power/resume. IOW, extend the protocol what can get written to
> /sys/power/resume and then phase out the path argument. It'll take a
> while but it's a possibly clean solution.

In fact, just looking at this code with a naive set of eyes for a second:

* There's early_lookup_bdev() which deals with PARTUUID,
  PARTLABEL, raw device number, and lookup based on /dev. No actual path
  lookup involved in that.

* So the only interesting case is lookup_bdev() for /sys/power/suspend.
  That one takes arbitrary paths. But being realistic for a moment...
  How many people will specify a device path that's _not_ some variant
  of /dev/...? IOW, how many people will specify a device path that's
  not on devtmpfs or a symlink on devtmpfs? Probably almost no one.

  Containers come to mind ofc. But they can't mount devtmpfs so usually
  what they do is that they create a tmpfs mount at /dev and then
  bind-mount device nodes they need into there. But unprivileged
  containers cannot use suspend because that requires init_user_ns
  capabilities. And privileged containers that are allowed to hibernate
  and use custom paths seem extremly unlikely as well.

So really, _naively_ it seems to me that one could factor out the /dev/*
part of the device number parsing logic in early_lookup_bdev() and port
resume_store() to use that first and only if that fails fall back to
full lookup_bdev(). (Possibly combined with some sort of logging that the
user should use /dev/... paths or at least a way to recognize that this
arbitrary path stuff is actually used.)

And citing from a chat with the hibernation maintainer in systemd:

<brauner> So /sys/power/resume does systemd ever write anything other than a /dev/* path in to there?
<maintainer> Hmm? You never do that? It only accepts devno.

So that takes away one of the main users of this api. So I really
suspect that arbitrary device path is unused in practice. Maybe I'm all
wrong though.

