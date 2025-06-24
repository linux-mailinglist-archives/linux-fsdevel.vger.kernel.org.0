Return-Path: <linux-fsdevel+bounces-52730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8294AAE60C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171D2174A64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2D27C844;
	Tue, 24 Jun 2025 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIDnlRSB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F427C152;
	Tue, 24 Jun 2025 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757043; cv=none; b=RaX4K8D7nzxq8h34PzhpCBTp5SbJXkVFao8+Hy0EeR2KHfj6zbxrHRcQBJqbnnKzim9M4CSgDYSkb0ngQJSCwmIyJd+uwbxaFJJ0YEkJJV7K9ash9rlzQndG+z2HwGT8quWgefwwVkE1lZeXX0icD5VE18iPqfO8TiodiNVkXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757043; c=relaxed/simple;
	bh=QYAwKGaMyRPFds2JikA1ZeUtbx6W3TfSyn793IrFJDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJZHR3AV2qJP4xOSJ3S9ufOG6cFBT725I3FnnFBIjejFHu6kvTQZNqGwi7G/Kd8txfargpuzhRBVEtUnW3sF0kDaKylFlUPJb1s5tX3X2tpBnQvYytu8ZH8p0xX9Je6D+gcTpXXlYsCP3Gk+C6H58i8pKdOBRx2zuTfutvDkY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIDnlRSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0DFC4CEE3;
	Tue, 24 Jun 2025 09:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750757043;
	bh=QYAwKGaMyRPFds2JikA1ZeUtbx6W3TfSyn793IrFJDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIDnlRSBQp/raYM1lA1Si36UfKygBLzdWycLUtBa1MIAl1xaHD3D+aMu0MwwN/j3H
	 1KbxtXhu8BgDfURSFCKEuszkpGY4xL5Uot7m9VpMsNodSc/81unp9AmCOJ1J12KnNX
	 ++lepZ8/1jA4e5BMhd+AbZYLUhvCPONHmRf3x2qfyGm/sMLvM4EGY2DrC1aMXIaJcF
	 rslT5S44I/cTX++h/g8ao+weNoa8AOB10d02yMAuD+BRMnZ+7rnFIm8fD+tqXHW8DG
	 ominQx6dYkZ+YuOJEazB3zO0s4aryCqiuys9COOT/6H8sTvK0aRPhMTltuHVEEUctk
	 P101oRNGEnpCw==
Date: Tue, 24 Jun 2025 11:23:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+25317a459958aec47bfa@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] general protection fault in pidfs_free_pid
Message-ID: <20250624-volldampf-brotscheiben-70bed5ac4dba@brauner>
References: <20250624-serienweise-bezeugen-0f2a5ecd5d76@brauner>
 <685a65af.050a0220.2303ee.0008.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <685a65af.050a0220.2303ee.0008.GAE@google.com>

On Tue, Jun 24, 2025 at 01:45:35AM -0700, syzbot wrote:
> > On Mon, Jun 23, 2025 at 11:27:26AM -0700, syzbot wrote:
> >> Hello,
> >> 
> >> syzbot found the following issue on:
> >> 
> >> HEAD commit:    5d4809e25903 Add linux-next specific files for 20250620
> >> git tree:       linux-next
> >> console+strace: https://syzkaller.appspot.com/x/log.txt?x=150ef30c580000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=58afc4b78b52b7e3
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=25317a459958aec47bfa
> >> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a5330c580000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c9f6bc580000
> >> 
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/16492bf6b788/disk-5d4809e2.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/7be284ded1de/vmlinux-5d4809e2.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/467d717f0d9c/bzImage-5d4809e2.xz
> >> 
> >> The issue was bisected to:
> >> 
> >> commit fb0b3e2b2d7f213cb4fde623706f9ed6d748a373
> >> Author: Christian Brauner <brauner@kernel.org>
> >> Date:   Wed Jun 18 20:53:46 2025 +0000
> >> 
> >>     pidfs: support xattrs on pidfds
> >> 
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a1b370580000
> >> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17a1b370580000
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=13a1b370580000
> >> 
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+25317a459958aec47bfa@syzkaller.appspotmail.com
> >> Fixes: fb0b3e2b2d7f ("pidfs: support xattrs on pidfds")
> >
> > #syz test: 
> >
> > #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.17.pidfs
> 
> Command #1:
> want either no args or 2 args (repo, branch), got 4

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.17.pidfs

