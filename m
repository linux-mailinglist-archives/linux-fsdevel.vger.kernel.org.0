Return-Path: <linux-fsdevel+bounces-8979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EF883C8EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85FF296D45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3068C1386B3;
	Thu, 25 Jan 2024 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6rmiGnG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9261A1386AD;
	Thu, 25 Jan 2024 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201246; cv=none; b=IDcHIjquQokO/eDeCz7DXVugTFIu85/GO6ntBcNg8Smj9V/WjmLwKpY/HSrouh7TC8EpIgR9gnKgP+gsYgNUl3aR97QbbNTSN6vL66YCiiV0/Nxttx4P0mrBJG9kGMO6tv4Dg6j9ivJm9yJ2mp8+ZeZbyjyg9SQBKlq2lX9kHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201246; c=relaxed/simple;
	bh=YftANLU4vv1DKrmQ7rhoS3AB+ju9sPZ5HuQVKVso5tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ez/HmvCcj20xBJrJGBtNq4z3ZmlUJLmzQnA/oM8HcYEc3RYtvUPvNLHks9SGjZAz8w9dNNojXHLmU0SIT5RurGsvyxnJtg3vhC2PP1aXjL1nl1+gIZABV+VXV83TwXuCFTgMaj1JRNShsUNFaphfv1hJxASk4lstKtI1IZA5d7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6rmiGnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0E2C41612;
	Thu, 25 Jan 2024 16:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706201246;
	bh=YftANLU4vv1DKrmQ7rhoS3AB+ju9sPZ5HuQVKVso5tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6rmiGnGS3StI/AkZtPr7HFJDisYiAw9Es1vYshMTNs8s4kf3gomFnnXQ3nSe//yE
	 RPNgoSfEXQ+UTTvwIbRAR0afzOQLAWiJ5F7IGkQH0Rv/lKVFWnNbYJrQ+Drm35xfjW
	 RjIoR/G0z3fpYqNmxKNdjSLBnV0+2Mo0lLGQxrOLdifjO1v5NLPgEpeDoMZ/3IMuFC
	 WnU5u+GMRTgLReWdPjFyVO/Ri/dml7/68I+Y8qVLP+PcVyGfaOIB5NPpgv65eY5gIu
	 oXN9+Ulnp+z1A0HXllKlrwjGwi2mYH9V+nZAw2tFVZc6lnuMqbzJzn1ouG6WLR2iMb
	 9QOBBhaOKYvOw==
Date: Thu, 25 Jan 2024 17:47:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: syzbot <syzbot+fb337a5ea8454f5f1e3f@syzkaller.appspotmail.com>, 
	hdanton@sina.com, jack@suse.cz, jfs-discussion@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] INFO: task hung in path_mount (2)
Message-ID: <20240125-addition-audienz-c955ab3c8435@brauner>
References: <00000000000083513f060340d472@google.com>
 <000000000000e5e71a060fc3e747@google.com>
 <20240125-legten-zugleich-21a988d80b45@brauner>
 <11868eb4-0528-4298-b8bc-2621fd1aac83@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11868eb4-0528-4298-b8bc-2621fd1aac83@kernel.dk>

On Thu, Jan 25, 2024 at 09:11:34AM -0700, Jens Axboe wrote:
> On Thu, Jan 25, 2024 at 9:08?AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Jan 25, 2024 at 03:59:03AM -0800, syzbot wrote:
> > > syzbot suspects this issue was fixed by commit:
> > >
> > > commit 6f861765464f43a71462d52026fbddfc858239a5
> > > Author: Jan Kara <jack@suse.cz>
> > > Date:   Wed Nov 1 17:43:10 2023 +0000
> > >
> > >     fs: Block writes to mounted block devices
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13175a53e80000
> > > start commit:   2ccdd1b13c59 Linux 6.5-rc6
> > > git tree:       upstream
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=fb337a5ea8454f5f1e3f
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ba5d53a80000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14265373a80000
> > >
> > > If the result looks correct, please mark the issue as fixed by replying with:
> >
> > #syz fix: fs: Block writes to mounted block devices
> 
> Like Dave replied a few days ago, I'm kind of skeptical on all of these
> bugs being closed by this change. I'm guessing that they are all
> resolved now because a) the block writes while mounted option was set to
> Y, and b) the actual bug is just masked by that.
> 
> Maybe this is fine, but it does seem a bit... sketchy? The bugs aren't
> really fixed, and what happens if someone doesn't turn on that option?
> If it's required, perhaps it should not be an option at all? Though
> that'd seem to be likely to break some funky use cases, whether they are
> valid or not.

We have no way of actually testing or verifying this stuff and a lot of
these have been around for a long time. For example, this report here
has a C reproducer but following the actual dashboard link that
reproducer is striked-through which supposedly means that it isn't valid
or reliable. And no other reproducer ever showed up.

As far as I can see we should just close reports such as. If this is a
real bug that is separate from the ability to mount to writed block
devices then one should hope that syzbot finds another reproducer that
let's us really analyze the bug?

A separate issue is that syzbot keeps suggesting as all of these being
closable because of this. So how serious can we take this and how much
time can/should we spend given that we got ~20 or more of these mails in
the last two weeks or so.

I have no better answers than this tbh. And fwiw, apart from this one I
haven't closed a single bug based on this.

And yes, ideally the ability to write to mounted block devices should be
turned off. But we'll have to let it trickle into the individual
distributions first and make remaining userspace tools that rely on this
move to alternate apis before we can make any serious effort.

