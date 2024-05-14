Return-Path: <linux-fsdevel+bounces-19410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A968C4F4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 12:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D8A281B91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 10:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3031F13E89D;
	Tue, 14 May 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q8ykKTC6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA113E88D;
	Tue, 14 May 2024 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681616; cv=none; b=Exz7ZIm+N5XQ553W7AoWotSeOUBWWCJk+Pu6bb7JbChCPyBvUjvmocFQaMrtjBwQBxyDFKFVq3NBsRlaZa6VOzT+YBW9cbJ0lpkR7VB1BPE78ND62l48yOCTuOSN6ZkL9hVc1nHzibrE+QET37lSDdGW1TqQfPEzso8GlgBEZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681616; c=relaxed/simple;
	bh=yL094DOWhtq62H4wWeSvXEnUMe22E6zd1a/lZ+40r6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVAHnsa7O8xJv+106dv2daz97DnM+GMn4YUDz6IEsXxA25xPFwPuRjhkFhn6LWLrSr4qk9LshHTdgFS2HaONNeNrfiwT9SkdyMZCKKHC++AaROlxWeF8XmlyBzgBQfIiSZe709pvfA1cIu3S6vCZR3pqq1a/NBewluWN3C/CE+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q8ykKTC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078A4C32781;
	Tue, 14 May 2024 10:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715681616;
	bh=yL094DOWhtq62H4wWeSvXEnUMe22E6zd1a/lZ+40r6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q8ykKTC6Q/q8G3qa3pg2fb+B9a/DuSZOqO+hJNM3esnSaoWWcFnVvqP/DxFn3SRBT
	 lxzE83qxLmwZbYuM6kANJr2FsLUvZnVmxNUw9OVV4ZOI5iOUrLeFnwfiGJJlhhB0PS
	 TGSyqPt7qHZ4iFzzih4BNmFm+SKQT9QxcRzf9Nc8=
Date: Tue, 14 May 2024 12:12:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: syzbot <syzbot+9dfe490c8176301c1d06@syzkaller.appspotmail.com>
Cc: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] KASAN: slab-out-of-bounds Read in ea_get (2)
Message-ID: <2024051411-malt-purse-7444@gregkh>
References: <00000000000059b4d50617913536@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000059b4d50617913536@google.com>

On Fri, May 03, 2024 at 11:51:33AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6a71d2909427 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=17374a40980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fca646cf17cc616b
> dashboard link: https://syzkaller.appspot.com/bug?extid=9dfe490c8176301c1d06
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f9a8a7180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f932a0980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c77d21fa1405/disk-6a71d290.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/429fcd369816/vmlinux-6a71d290.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d3d8a4b85112/Image-6a71d290.gz.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/ba0e4fef7b4b/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9dfe490c8176301c1d06@syzkaller.appspotmail.com

Proposed fix sent here:
	https://lore.kernel.org/r/2024051433-slider-cloning-98f9@gregkh


