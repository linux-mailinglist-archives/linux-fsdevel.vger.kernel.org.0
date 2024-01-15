Return-Path: <linux-fsdevel+bounces-7945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A8B82DB11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 15:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C161281CDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 14:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB5D17594;
	Mon, 15 Jan 2024 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoQAIQnV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F2717586;
	Mon, 15 Jan 2024 14:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A126C433F1;
	Mon, 15 Jan 2024 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705327940;
	bh=JbRfada1ZmZnmm6CZ+M7STR4Yo8HtupiOREDSHz7wfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HoQAIQnVUrkaieCvjTqA44x3KvYr/1+26gtV9OXVs6aqezSuLVzDMRr4m2AyuoXKl
	 4ZlwqAvYlbjO38tyopBFwqXgFyLd92sbZJILkgfD2E5pTDguVkq2T1bIuLi+9q9yNf
	 QN2ZZkFJYzX0B+LV7B/CkfYeqoqTYKIiAAsElb9Vo1QpZeNyZ1SFXMIZyqYbfivbZi
	 fLloKPQw6bk7WRQnRtSwXTMCnQV7K6cAWaQtdeRREJ/E0yMo2KSazE3ZFy35cR7yX9
	 VyabkGwmxhiG03YISB2lU3myvEAbrSsXzn1w5BpbJUBU5uK4ovVGyOp4cbegIcOcaf
	 HuR/UZRA095UQ==
Date: Mon, 15 Jan 2024 15:12:14 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+c1056fdfe414463fdb33@syzkaller.appspotmail.com>, 
	axboe@kernel.dk, dave.kleikamp@oracle.com, ghandatmanas@gmail.com, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diWrite
Message-ID: <20240115-zielvereinbarungen-paarweise-89df1e25c894@brauner>
References: <00000000000027993305eb841df8@google.com>
 <000000000000c746f0060ee2b23a@google.com>
 <20240115134228.vk73b4lkk7lxkgyr@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115134228.vk73b4lkk7lxkgyr@quack3>

On Mon, Jan 15, 2024 at 02:42:28PM +0100, Jan Kara wrote:
> On Sat 13-01-24 23:18:05, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> > 
> > commit 6f861765464f43a71462d52026fbddfc858239a5
> > Author: Jan Kara <jack@suse.cz>
> > Date:   Wed Nov 1 17:43:10 2023 +0000
> > 
> >     fs: Block writes to mounted block devices
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ec162be80000
> > start commit:   493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c1056fdfe414463fdb33
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f431d2880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1208894a880000
> > 
> > If the result looks correct, please mark the issue as fixed by replying with:
> 
> Makes sense:
> 
> #syz fix: fs: Block writes to mounted block devices

I love how many things this closes. This is awesome!

