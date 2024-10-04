Return-Path: <linux-fsdevel+bounces-31043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF07991285
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 00:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED4A284E2C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CAD14C59A;
	Fri,  4 Oct 2024 22:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ocmA6c65"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3789146000;
	Fri,  4 Oct 2024 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728082413; cv=none; b=otqrolva0HXUVHMUxtgcuOWuC9M7PyCWhoQFDPrQxb7/nXpOF5SMeEoag/Fl5CButec3UN+7+STqHImdamfIuincBak5qOeGAf8pj442g1UC21uVAmcjyHOYYscEx6QSrixIr4kHvXtZd0kScVZzC1Iu5wSESVgPudTmVwrNj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728082413; c=relaxed/simple;
	bh=nZCWvWLDoMUwOETPnWLC2ITiq2M2h0DFWKYJFLABaqo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MIH3fy18uxCo8CMN1bzSo7VvjXOiH3SxKtzBDxtNNpQR/L15H/gPjjnVFDvUgTMr7Dfeiacm02cn1n+Hvwh9YxqQ66S35Qc6DwuUZyNgnrjFhotlDp4FZhnndmoiyg7qUkSqcUGzLVcYzOrhqSna1llm44nFaAH5/z6E45hhnFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ocmA6c65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA8EC4CEC6;
	Fri,  4 Oct 2024 22:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728082413;
	bh=nZCWvWLDoMUwOETPnWLC2ITiq2M2h0DFWKYJFLABaqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ocmA6c65WA+DZkA7isFeZ8Nz0JrLz0oykPXVfgdnWxurHJxzIX7XmCMzkdplk+zyo
	 kOlA3K335aF33xBh6jnaS9a4yWX+FJRt+FVxX3cCgCiIM85vS2KLiqXudPJr2Sx9Km
	 q/ohUrWNyzvfXzTQRlK0zUUPcAHlD+wWjBij6kOI=
Date: Fri, 4 Oct 2024 15:53:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: syzbot <syzbot+ef0d7bc412553291aa86@syzkaller.appspotmail.com>,
 linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in vfat_rename2
Message-Id: <20241004155332.b2a7603be540c692e56dc71c@linux-foundation.org>
In-Reply-To: <87r08wjsnh.fsf@mail.parknet.co.jp>
References: <66ff2c95.050a0220.49194.03e9.GAE@google.com>
	<87r08wjsnh.fsf@mail.parknet.co.jp>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Oct 2024 15:20:34 +0900 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

> syzbot <syzbot+ef0d7bc412553291aa86@syzkaller.appspotmail.com> writes:
> 
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    e7ed34365879 Merge tag 'mailbox-v6.12' of git://git.kernel..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b54ea9980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=92da5062b0d65389
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ef0d7bc412553291aa86
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b7ed07980000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101dfd9f980000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/66cc3d8c5c10/disk-e7ed3436.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/c7769a88b445/vmlinux-e7ed3436.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/c1fe4c6ee436/bzImage-e7ed3436.xz
> > mounted in repro #1: https://storage.googleapis.com/syzbot-assets/2ab98c65fd49/mount_0.gz
> > mounted in repro #2: https://storage.googleapis.com/syzbot-assets/7ffc0eb73060/mount_5.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ef0d7bc412553291aa86@syzkaller.appspotmail.com
> 
> The patch fixes this bug. Please apply.
> Thanks.
> 
> 
> From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> Subject: [PATCH] fat: Fix uninitialized variable
> Date: Fri, 04 Oct 2024 15:03:49 +0900
> 
> Reported-by: syzbot+ef0d7bc412553291aa86@syzkaller.appspotmail.com
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Could we please have some description?  Seems that an IO error triggers this?



