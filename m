Return-Path: <linux-fsdevel+bounces-9636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A00843D6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 11:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B121C21B05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 10:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F3C6D1A1;
	Wed, 31 Jan 2024 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU0fj9ro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6669DED;
	Wed, 31 Jan 2024 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698589; cv=none; b=syeUfrTlwM6ETTBvWmtD/Tsbds1OGMfU7F1evRp/dNjyan7L+VOwtwk0Lqx72dpFX32UmgfPffx0OZifqdomkN/SNnbD3QoyWIFrbxnJS07U8brpwMM5cuH/UIPpSryzbmYQPsQyvfyQuZblXdR6BZWRsOCqxiXX3KbghzBx0fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698589; c=relaxed/simple;
	bh=l1bRwvZKkzw+xTOOFxCoo6CCeXmAURsYin/7dxuYdsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVs5yj6kFja9TtJ0GOgn7H6RgoXOqP1HThPUHcz+K/bKPnmCCzZwTqKtUuV0cFx47ilIvf7lBsKDr4gclGSS+SN+GHuWVR4ZOelwp+OTRbVKBRnUYa6dkck/ZeqingqzD1w8xvS76jwGYXKguhRfadTnOiRqumOKxaOPZVznWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU0fj9ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345BAC433C7;
	Wed, 31 Jan 2024 10:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706698588;
	bh=l1bRwvZKkzw+xTOOFxCoo6CCeXmAURsYin/7dxuYdsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cU0fj9roClyOAPO4Nq+Z19JBzcgwbGCLw8+BewHcnHx76SSHZH1ui7a06+g9lHLgC
	 XATy6OwbbJyiSQ4ETWKMFmHNGAVh6n4u3XXfvgKrl0ubZJn05ch8yD6cg3e+8OcuJ5
	 nSyMUF+r5yLm8RDrUs6jhoOc+r2R2v0r3YBsv6FzUcet0RWR3Xz6rqmpm1xPqCAwyk
	 fGjWsmAM9YqqFukxtNuP9T+LII80S8BIokv8nwdMnd6zYA/yzratH+5Y6BRnenTkg/
	 lKtXSUwTKQpn0uVrPmxW3lmnsfw+M3WiiZqbPzBiqtcBESGLgmz0rZbwD23S08ruPA
	 4eG6f6QtuTppA==
Date: Wed, 31 Jan 2024 11:56:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, axboe@kernel.dk, chenzhongjin@huawei.com, dchinner@redhat.com, 
	hch@infradead.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid
 context in __getblk_gfp
Message-ID: <20240131-tapeziert-lustvoll-780b450e52c4@brauner>
References: <0000000000000ccf9a05ee84f5b0@google.com>
 <0000000000000d130006101f7e0e@google.com>
 <20240130115430.rljjwjcji3vlrgyz@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240130115430.rljjwjcji3vlrgyz@quack3>

On Tue, Jan 30, 2024 at 12:54:30PM +0100, Jan Kara wrote:
> On Mon 29-01-24 17:15:05, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> > 
> > commit 6f861765464f43a71462d52026fbddfc858239a5
> > Author: Jan Kara <jack@suse.cz>
> > Date:   Wed Nov 1 17:43:10 2023 +0000
> > 
> >     fs: Block writes to mounted block devices
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116642dfe80000
> > start commit:   d88520ad73b7 Merge tag 'pull-nfsd-fix' of git://git.kernel..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=174a257c5ae6b4fd
> > dashboard link: https://syzkaller.appspot.com/bug?extid=69b40dc5fd40f32c199f
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a77593680000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1104a593680000
> > 
> > If the result looks correct, please mark the issue as fixed by replying with:
> > 
> > #syz fix: fs: Block writes to mounted block devices
> 
> This doesn't look correct. The problem here really is that sysv is calling
> sb_bread() under a RWLOCK - pointers_lock - in get_block(). Which more or
> less shows nobody has run sysv in ages because otherwise the chances of
> sleeping in atomic context are really high? Perhaps another candidate for
> removal?

Fwiw, yes, please!

