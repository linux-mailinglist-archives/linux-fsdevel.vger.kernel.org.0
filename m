Return-Path: <linux-fsdevel+bounces-9048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC11783D779
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 11:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478212954FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 10:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0751F61D;
	Fri, 26 Jan 2024 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6alyyyx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0572B1F5E4;
	Fri, 26 Jan 2024 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261334; cv=none; b=Uu5CsBN3wF5CtUkl9E46TEhJfjL6L7p2EaFZ52wbmesj8UAij6G0f0e1kY6WminSYZfN5nM/6rGto21hH7IBd3WiP5Ov1urtNsLXbW+9SLApVsiG9RWKS5wMjrbXN3hs0CL2Z/1u9mfW/KH+yXL1xFRICM8LM+j+KkMbu0UmSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261334; c=relaxed/simple;
	bh=wGO52oyeTkXKOb5JwngA3efCMaB6GRi1DOXpxN9TR6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5CX8ODemr91Sua1c0NO9ailWdf5kE560HlTkMp4FwuxIVT5YTfcwfGYmlnUDPFKOVyQJ2hDTjeRilOMBZv5fvqNEVyICT3EYyoobi9UCKD5zRIpOyPlBRZN4Rf3u6gsOfI60dNoD2Dz4VIdeqGCoPmGw4HqL16Qga5jeUVL2k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6alyyyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28614C433F1;
	Fri, 26 Jan 2024 09:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706261333;
	bh=wGO52oyeTkXKOb5JwngA3efCMaB6GRi1DOXpxN9TR6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6alyyyxzl7eMrv3u5oVM5ZRImB72L+US1+QQ/YREwjFcum7MuoFI4ENoW6XxjaqP
	 OnrSryPio5bFBBn515HKi9fW0fZOQmMGjwr4AUCdr9Cm0Ih0Pz1rqrPFKOQ/tpfeg2
	 +w/r1I2c7iE+9g0HfYz7Gy4gcPyYtXpAPqt4lrEWwI6KTwjNeN+RLPvvelw8lkjMsi
	 AA+t8yZ+ed1refFaxA6JcnTUFZjiPnTfcjr5buZ3N5AlDtfxPWAagGRJ/s0udkkOKv
	 cc3MaUeRDyAzXsbmtdMVju4qweLmqJwVqwPwUUx+k2LWDkRH7AhBn41lMjFLVr8X2c
	 bGs5hf2gPSd/w==
Date: Fri, 26 Jan 2024 10:28:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, 
	syzbot <syzbot+fb337a5ea8454f5f1e3f@syzkaller.appspotmail.com>, hdanton@sina.com, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] INFO: task hung in path_mount (2)
Message-ID: <20240126-ferkel-verkraften-c13bc68f6c88@brauner>
References: <00000000000083513f060340d472@google.com>
 <000000000000e5e71a060fc3e747@google.com>
 <20240125-legten-zugleich-21a988d80b45@brauner>
 <11868eb4-0528-4298-b8bc-2621fd1aac83@kernel.dk>
 <20240125-addition-audienz-c955ab3c8435@brauner>
 <CANp29Y69y5Ctmcrf4SFFrMAD1hzsx+GYriDaa9q=3aexRspaxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y69y5Ctmcrf4SFFrMAD1hzsx+GYriDaa9q=3aexRspaxw@mail.gmail.com>

On Thu, Jan 25, 2024 at 07:24:01PM +0100, Aleksandr Nogikh wrote:
> On Thu, Jan 25, 2024 at 5:47 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Jan 25, 2024 at 09:11:34AM -0700, Jens Axboe wrote:
> > > On Thu, Jan 25, 2024 at 9:08?AM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Thu, Jan 25, 2024 at 03:59:03AM -0800, syzbot wrote:
> > > > > syzbot suspects this issue was fixed by commit:
> > > > >
> > > > > commit 6f861765464f43a71462d52026fbddfc858239a5
> > > > > Author: Jan Kara <jack@suse.cz>
> > > > > Date:   Wed Nov 1 17:43:10 2023 +0000
> > > > >
> > > > >     fs: Block writes to mounted block devices
> > > > >
> > > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13175a53e80000
> > > > > start commit:   2ccdd1b13c59 Linux 6.5-rc6
> > > > > git tree:       upstream
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=fb337a5ea8454f5f1e3f
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ba5d53a80000
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14265373a80000
> > > > >
> > > > > If the result looks correct, please mark the issue as fixed by replying with:
> > > >
> > > > #syz fix: fs: Block writes to mounted block devices
> > >
> > > Like Dave replied a few days ago, I'm kind of skeptical on all of these
> > > bugs being closed by this change. I'm guessing that they are all
> > > resolved now because a) the block writes while mounted option was set to
> > > Y, and b) the actual bug is just masked by that.
> 
> Yes, that's true. For a) there are also two sub-reasons:
> 1) The bug itself is indeed no longer reproducible because of this new
> kernel option.
> 2) The bug is not reproducible because the change broke the way
> syzkaller did the mounts -- we used to hold an fd to the loop device
> while doing the mount. That was fixed[1] soon after the commit reached
> torvalds, but for bisections syzbot has to build syzkaller exactly at
> the revision when the reproducer was found (otherwise it may parse the
> syz reproducer incorrectly). So this kernel commit becomes exactly the
> point where the reproducer stops working.
> 
> For most of the recently closed fs bugs (2) should not be the primary
> reason though -- these fix bisections are done only when syzbot
> stopped seeing crashes with the corresponding titles, which was very
> likely caused by (1) in the first place.
> 
> [1] https://github.com/google/syzkaller/commit/551587c192ecb4df26fcdab775ed145ee69c07d4
> 
> > >
> > > Maybe this is fine, but it does seem a bit... sketchy? The bugs aren't
> > > really fixed, and what happens if someone doesn't turn on that option?
> > > If it's required, perhaps it should not be an option at all? Though
> > > that'd seem to be likely to break some funky use cases, whether they are
> > > valid or not.
> >
> > We have no way of actually testing or verifying this stuff and a lot of
> > these have been around for a long time. For example, this report here
> > has a C reproducer but following the actual dashboard link that
> > reproducer is striked-through which supposedly means that it isn't valid
> > or reliable. And no other reproducer ever showed up.
> >
> > As far as I can see we should just close reports such as. If this is a
> > real bug that is separate from the ability to mount to writed block
> > devices then one should hope that syzbot finds another reproducer that
> > let's us really analyze the bug?
> 
> Yes, if the ability to write to the block device is not really
> necessary to trigger the bug, syzbot should find it again in some
> time.
> 
> >
> > A separate issue is that syzbot keeps suggesting as all of these being
> > closable because of this. So how serious can we take this and how much
> > time can/should we spend given that we got ~20 or more of these mails in
> > the last two weeks or so.
> 
> I can add the "fs: Block writes to mounted block devices" commit to
> the black list for syzbot bisections -- it will stop sending such
> emails then.

No, I think it's helpful. I was just saying that we can't be expected to
spend hours per report to check whether this makes sense or not. I
wasn't complaining about this per se.

