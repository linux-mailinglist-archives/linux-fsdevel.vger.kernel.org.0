Return-Path: <linux-fsdevel+bounces-43175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F09A4EE80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 21:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2501894949
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 20:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B371C84D7;
	Tue,  4 Mar 2025 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="AsYxnkhc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A511F7561
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120621; cv=none; b=jN9Z+IhdTwGmHwTP8+z0/OLzddSSMoeCwBRd9DlfReDM7NxDuXP7lZ8B7vfl1B79X6zCMP+OS9K67LY16Xt/TSkl0nZcnKuKbQ+Cm9CbUfzNexI/JeuDXYu4q+3nWaqTCJAjOjmYRnOpM2CJQho/Fy4wzw6qIABuuSSgocegeUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120621; c=relaxed/simple;
	bh=ylXDHcGiq+tE3l7CgMapVO+d5BX9Tj4+B0gqa3m5mCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvY65p1IfU9vSAtDiVo5/KWUfE7l45q6wwKBMA1N2GavHfoKQc/CItuypU/Z4fSinLaQvl2UenDU2M0coVPhmczdRcv9t37oEOrg4xOIDAIm8iR/nFe1lKfP8pgKD9JcNKdYfEHZ0qgH2SXVviYOMgpu4I5D5U2hTpWZvLHg+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=AsYxnkhc; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c3d1664ed5so115520085a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 12:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1741120619; x=1741725419; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ajQNjB8mdedYx2LlwHnzClYRQdUqzI1pUD1k+HxZ7oQ=;
        b=AsYxnkhcLSWOq5KKB+3imrFbu7bS1VcTH1z2Us1LICT4JALeDoU90IY4NytcVaBGOj
         n7bVZ0q0HaOnoU/P3gEdNXDCSHUnV8HEOvFB4/kIL2PfYxRifBdLfYni4llIH58c1dA6
         ii4oGqF73gCdYLXDD/JTD4nd8lzSEH4gpzY+ijy0vos7oC9i+phlGmD3q7QQfe0555O7
         xduT6W7zi3vqL1xFNl+trZnuusDnqT58cW+EIzzFew7pLnA2HMCsjLIAPVsbcrHOxScJ
         5yhikHTW357BjiCelu2ABCrIRYaVDGW7xB3Cpru1D8WlYtC2po+Qx3RbZjaVZIkJUHeW
         YpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741120619; x=1741725419;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajQNjB8mdedYx2LlwHnzClYRQdUqzI1pUD1k+HxZ7oQ=;
        b=K08US62UFM8Ct4BT14iE8z4mBqLV0x9qusG03vLP7/b3u/27rZ6lzljFGNvWjp7J/Q
         RnGUKA02k1cC8e0pP+zu/S+vRAFRlhyrqR959iVz+JgMb1chnCIyE02AeBpBLbisVsWn
         l9gR8mkPibZbvKcCNfelBCzNlr3sw0dVe/YDUVmbuyZYpLu+sKyqB9ZGkuuP41XRVv1S
         Z59aOOgLrwJIP2tEZWJmgqPPYnE4rxdrbH+OjKnnr+W2rcjjZxrzecNfzmrdEl/EWNs7
         l5lQ02pIRPR2pcai+XEK4WmPO31IdPO71QkQ95mVTem+ersJPtSU+L0OWIvejYg9r6Tr
         Pqgw==
X-Forwarded-Encrypted: i=1; AJvYcCUP8o3U4Zc9dUnCxffqCr8jDpd5c0NMq1B+2S0Qr5vwxBi9H9415VGKBZ+ROLaFwx7/A3JCpz+xDc+CqdD/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9TCNz3koWGeIvZs26vbLwe2kL6ZAuZ5EN4E4fEAyEKUeG8t6N
	A88lCiRceqB5mZa/XcnnpqN6gp12V2u7KmfVmo3x+gzJgocTtX8OsFJWwKGKE3g=
X-Gm-Gg: ASbGncuMPsObTh7FAncnMUauKegh/cQUJeXtxhrofHJyPzAS2EWTiNvQ9JDIUQEbf+X
	iYcohFVx+RNrJ+MjKpAt/o9x3SOoTMq3bk+dIYLVuGJDb9s14pyB/g8thSuwK18hoieaaTjajwu
	DPwcxHR3oysK8BskkL7kg0QVhrZQnkwM6UkkmEm5+Y36IMKNtpaCUaqJZSTL7Md9ynuMMAztw5V
	oXWSGqN37PaShjqw0pzerBKVpIhJf434MYzydXUMF2RCZbbIoar7X5EULTKUZL27QZcpom1vIFc
	eRdiueWmumsYJQ6MRL8/aspJpPgPtY5AIwQLZk7wB/dhzgwMXxH/8XDZxeya1wDimrXYNLBLcyW
	enIkERw==
X-Google-Smtp-Source: AGHT+IGN8GLNVXAgiOiVnkab7Lf8kpIiyiCI+E2wOU2Xu9jt2bq8RbpAyG8danZh0oP6vJsQHUFI8w==
X-Received: by 2002:a05:620a:8908:b0:7c0:b103:f252 with SMTP id af79cd13be357-7c3d8e15ea4mr142233885a.8.1741120619086;
        Tue, 04 Mar 2025 12:36:59 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3cd20e6bdsm155346885a.23.2025.03.04.12.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 12:36:58 -0800 (PST)
Date: Tue, 4 Mar 2025 15:36:57 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	syzbot <syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
	cem@kernel.org, chandan.babu@oracle.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING in fsnotify_file_area_perm
Message-ID: <20250304203657.GA4063187@perftesting>
References: <67a487f7.050a0220.19061f.05fc.GAE@google.com>
 <67c4881e.050a0220.1dee4d.0054.GAE@google.com>
 <7ehxrhbvehlrjwvrduoxsao5k3x4aw275patsb3krkwuq573yv@o2hskrfawbnc>
 <CAOQ4uxjf5H_vj-swF7wEvUkPobEuxs2q6jfO9jFsx4pqxtJMMg@mail.gmail.com>
 <20250304161509.GA4047943@perftesting>
 <CAOQ4uxj0cN-sUN=EE0+9tRhMFFrWLQ0T_i0fprwNRr92Hire6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj0cN-sUN=EE0+9tRhMFFrWLQ0T_i0fprwNRr92Hire6Q@mail.gmail.com>

On Tue, Mar 04, 2025 at 09:27:20PM +0100, Amir Goldstein wrote:
> On Tue, Mar 4, 2025 at 5:15 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Tue, Mar 04, 2025 at 04:09:16PM +0100, Amir Goldstein wrote:
> > > On Tue, Mar 4, 2025 at 12:06 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > Josef, Amir,
> > > >
> > > > this is indeed an interesting case:
> > > >
> > > > On Sun 02-03-25 08:32:30, syzbot wrote:
> > > > > syzbot has found a reproducer for the following issue on:
> > > > ...
> > > > > ------------[ cut here ]------------
> > > > > WARNING: CPU: 1 PID: 6440 at ./include/linux/fsnotify.h:145 fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> > > > > Modules linked in:
> > > > > CPU: 1 UID: 0 PID: 6440 Comm: syz-executor370 Not tainted 6.14.0-rc4-syzkaller-ge056da87c780 #0
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
> > > > > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > > pc : fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> > > > > lr : fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> > > > > sp : ffff8000a42569d0
> > > > > x29: ffff8000a42569d0 x28: ffff0000dcec1b48 x27: ffff0000d68a1708
> > > > > x26: ffff0000d68a16c0 x25: dfff800000000000 x24: 0000000000008000
> > > > > x23: 0000000000000001 x22: ffff8000a4256b00 x21: 0000000000001000
> > > > > x20: 0000000000000010 x19: ffff0000d68a16c0 x18: ffff8000a42566e0
> > > > > x17: 000000000000e388 x16: ffff800080466c24 x15: 0000000000000001
> > > > > x14: 1fffe0001b31513c x13: 0000000000000000 x12: 0000000000000000
> > > > > x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000000000
> > > > > x8 : ffff0000c6d98000 x7 : 0000000000000000 x6 : 0000000000000000
> > > > > x5 : 0000000000000020 x4 : 0000000000000000 x3 : 0000000000001000
> > > > > x2 : ffff8000a4256b00 x1 : 0000000000000001 x0 : 0000000000000000
> > > > > Call trace:
> > > > >  fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145 (P)
> > > > >  filemap_fault+0x12b0/0x1518 mm/filemap.c:3509
> > > > >  xfs_filemap_fault+0xc4/0x194 fs/xfs/xfs_file.c:1543
> > > > >  __do_fault+0xf8/0x498 mm/memory.c:4988
> > > > >  do_read_fault mm/memory.c:5403 [inline]
> > > > >  do_fault mm/memory.c:5537 [inline]
> > > > >  do_pte_missing mm/memory.c:4058 [inline]
> > > > >  handle_pte_fault+0x3504/0x57b0 mm/memory.c:5900
> > > > >  __handle_mm_fault mm/memory.c:6043 [inline]
> > > > >  handle_mm_fault+0xfa8/0x188c mm/memory.c:6212
> > > > >  do_page_fault+0x570/0x10a8 arch/arm64/mm/fault.c:690
> > > > >  do_translation_fault+0xc4/0x114 arch/arm64/mm/fault.c:783
> > > > >  do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:919
> > > > >  el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:432
> > > > >  el1h_64_sync_handler+0x60/0xcc arch/arm64/kernel/entry-common.c:510
> > > > >  el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
> > > > >  __uaccess_mask_ptr arch/arm64/include/asm/uaccess.h:169 [inline] (P)
> > > > >  fault_in_readable+0x168/0x310 mm/gup.c:2234 (P)
> > > > >  fault_in_iov_iter_readable+0x1dc/0x22c lib/iov_iter.c:94
> > > > >  iomap_write_iter fs/iomap/buffered-io.c:950 [inline]
> > > > >  iomap_file_buffered_write+0x490/0xd54 fs/iomap/buffered-io.c:1039
> > > > >  xfs_file_buffered_write+0x2dc/0xac8 fs/xfs/xfs_file.c:792
> > > > >  xfs_file_write_iter+0x2c4/0x6ac fs/xfs/xfs_file.c:881
> > > > >  new_sync_write fs/read_write.c:586 [inline]
> > > > >  vfs_write+0x704/0xa9c fs/read_write.c:679
> > > >
> > > > The backtrace actually explains it all. We had a buffered write whose
> > > > buffer was mmapped file on a filesystem with an HSM mark. Now the prefaulting
> > > > of the buffer happens already (quite deep) under the filesystem freeze
> > > > protection (obtained in vfs_write()) which breaks assumptions of HSM code
> > > > and introduces potential deadlock of HSM handler in userspace with filesystem
> > > > freezing. So we need to think how to deal with this case...
> > >
> > > Ouch. It's like the splice mess all over again.
> > > Except we do not really care to make this use case work with HSM
> > > in the sense that we do not care to have to fill in the mmaped file content
> > > in this corner case - we just need to let HSM fail the access if content is
> > > not available.
> > >
> > > If you remember, in one of my very early version of pre-content events,
> > > the pre-content event (or maybe it was FAN_ACCESS_PERM itself)
> > > carried a flag (I think it was called FAN_PRE_VFS) to communicate to
> > > HSM service if it was safe to write to fs in the context of event handling.
> > >
> > > At the moment, I cannot think of any elegant way out of this use case
> > > except annotating the event from fault_in_readable() as "unsafe-for-write".
> > > This will relax the debugging code assertion and notify the HSM service
> > > (via an event flag) that it can ALLOW/DENY, but it cannot fill the file.
> > > Maybe we can reuse the FAN_ACCESS_PERM event to communicate
> > > this case to HSM service.
> > >
> > > WDYT?
> >
> > I think that mmap was a mistake.
> 
> What do you mean?
> Isn't the fault hook required for your large executables use case?

I mean the mmap syscall was a mistake ;).

> 
> >
> > Is there a way to tell if we're currently in a path that is under fsfreeze
> > protection?
> 
> Not at the moment.
> At the moment, file_write_not_started() is not a reliable check
> (has false positives) without CONFIG_LOCKDEP.
> 
> > Just denying this case would be a simpler short term solution while
> > we come up with a long term solution. I think your solution is fine, but I'd be
> > just as happy with a simpler "this isn't allowed" solution. Thanks,
> 
> Yeh, I don't mind that, but it's a bit of an overkill considering that
> file with no content may in fact be rare.

Agreed, I'm fine with your solution.  Thanks,

Josef

