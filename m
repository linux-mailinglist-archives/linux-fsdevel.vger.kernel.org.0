Return-Path: <linux-fsdevel+bounces-16196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3043899ED4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 15:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFB91C20FAC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB4A16DEBD;
	Fri,  5 Apr 2024 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu1Pf1wO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E43516D9CB;
	Fri,  5 Apr 2024 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325293; cv=none; b=ghr+CF9bC3Xgr4Zt2alw0XALIBHCvEGxqM580Z81IInD3k4FajpxJSMJC6UKCxZRLpThNxqBJCj4VJpdBbi4RGjxBTi4qrp6qgI4+GWafZQB2HxpPqulwaIT/YiGH1eGIvsmgF7JBgpG4OKIf1e0V2UV5QM9o2db6ob1vgFH0VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325293; c=relaxed/simple;
	bh=auqYIT6CKrJk1miqnfnD/XjuOj0mNFgJY6WwtPr4ehA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihBK9p6aHREZ79cajnYs8aRIb3oYnujQvDdflch9mqCbNklhBx4oryEoyAsZSZ/MnnJgkfaWEXVLQhkLk8mo/8NEHNvQPppbCFH2k+MF+zbQu775GI4tZu8QyGCGbwDjTQVLmwTZHnHySZrMt33YhDS40wrlmzRti91DY7jQK10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu1Pf1wO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4F5C433C7;
	Fri,  5 Apr 2024 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712325292;
	bh=auqYIT6CKrJk1miqnfnD/XjuOj0mNFgJY6WwtPr4ehA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bu1Pf1wOnc823fLRL6sQDcsdT/WCudFpnGAuJD+CaM6nA7iC+RzHWyWEkX7lgHY+M
	 BMIlKrSEaF6ebufBZ0w7WJFekSj9OK2Waz83b0m7P8yEIZHMGXLGvN/ITFCUsvo0W/
	 Uq7AWfg/8a/JtinNndb/+NxavNoycut30UszEXdgoPyBjGaOXdTBFQ+dmJIAMw3yKQ
	 RpECJ9B5//8An80sJlO9Lj/lYIWWPiyg8NO/hXssxmNlUaM5PyOk5U4DZbPLTDbyrq
	 QUpdQdw/wEuu+XLoNR0s0UUKirBcbcSXARcZ5RHSjJorkbEwiw7j+VrGi7ezFzn7TC
	 7MlqdiyWSVHLA==
Date: Fri, 5 Apr 2024 15:54:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, gregkh@linuxfoundation.org, 
	konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [nilfs?] KASAN: slab-out-of-bounds Read in wb_writeback
Message-ID: <20240405-leuchtdioden-wettrennen-7e8aa52e80f7@brauner>
References: <000000000000fd0f2a061506cc93@google.com>
 <00000000000003b8c406151e0fd1@google.com>
 <20240403094717.zex45tc2kpkfelny@quack3>
 <20240405-heilbad-eisbrecher-cd0cbc27f36f@brauner>
 <20240405132346.bid7gibby3lxxhez@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240405132346.bid7gibby3lxxhez@quack3>

On Fri, Apr 05, 2024 at 03:23:46PM +0200, Jan Kara wrote:
> On Fri 05-04-24 13:05:59, Christian Brauner wrote:
> > On Wed, Apr 03, 2024 at 11:47:17AM +0200, Jan Kara wrote:
> > > On Tue 02-04-24 07:38:25, syzbot wrote:
> > > > syzbot has found a reproducer for the following issue on:
> > > > 
> > > > HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
> > > > git tree:       linux-next
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=14af7dd9180000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=7b219b86935220db6dd8
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1729f003180000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fa4341180000
> > > > 
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz
> > > > mounted in repro: https://storage.googleapis.com/syzbot-assets/9760c52a227c/mount_0.gz
> > > > 
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+7b219b86935220db6dd8@syzkaller.appspotmail.com
> > > > 
> > > > ==================================================================
> > > > BUG: KASAN: slab-out-of-bounds in __lock_acquire+0x78/0x1fd0 kernel/locking/lockdep.c:5005
> > > > Read of size 8 at addr ffff888020485fa8 by task kworker/u8:2/35
> > > 
> > > Looks like the writeback cleanups are causing some use-after-free issues.
> > > The code KASAN is complaining about is:
> > > 
> > > 		/*
> > > 		 * Nothing written. Wait for some inode to
> > > 		 * become available for writeback. Otherwise
> > > 		 * we'll just busyloop.
> > > 		 */
> > > 		trace_writeback_wait(wb, work);
> > > 		inode = wb_inode(wb->b_more_io.prev);
> > > >>>>>		spin_lock(&inode->i_lock); <<<<<<
> > > 		spin_unlock(&wb->list_lock);
> > > 		/* This function drops i_lock... */
> > > 		inode_sleep_on_writeback(inode);
> > > 
> > > in wb_writeback(). Now looking at the changes indeed the commit
> > > 167d6693deb ("fs/writeback: bail out if there is no more inodes for IO and
> > > queued once") is buggy because it will result in trying to fetch 'inode'
> > > from empty b_more_io list and thus we'll corrupt memory. I think instead of
> > > modifying the condition:
> > > 
> > > 		if (list_empty(&wb->b_more_io)) {
> > > 
> > > we should do:
> > > 
> > > -		if (progress) {
> > > +		if (progress || !queued) {
> > >                         spin_unlock(&wb->list_lock);
> > >                         continue;
> > >                 }
> > > 
> > > Kemeng?
> > 
> > Fwiw, I observed this on xfstest too the last few days and tracked it
> > down to this series. Here's the splat I got in case it helps:
> 
> OK, since this is apparently causing more issues and Kemeng didn't reply
> yet, here's a fix in the form of the patch. It has passed some basic
> testing. Feel free to fold it into Kemeng's patch so that we don't keep
> linux-next broken longer than necessary. Thanks!

Thanks! Folded and I mentioned that I folded a fix from you into the
commit with a link to this patch.

