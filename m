Return-Path: <linux-fsdevel+bounces-19548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 498368C6B2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 19:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7204B20CCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 17:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E269C4CB4B;
	Wed, 15 May 2024 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AV47vfLA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A6D3EA7B;
	Wed, 15 May 2024 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792462; cv=none; b=O4KUZN4VOo8aX4/yZOQK6tL+OSQ3OPo8iw4k/fxyRmcFPVRYZv68O78wstIhKEo37NkR8w/gTUSbHJvYshBs+o4FlNPMfYcDjKBswdHEMlJK4n9+IGgqnd27NCHdS+uSAbXHXXt+mnY3vJZStJ8V0gpymXlL+iubFK2/mSevQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792462; c=relaxed/simple;
	bh=qTwEfXEQkbdljZmqzyD0H6JnsIFFB6dqdWoQSfOqF5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMZs5xAzDo4WfZMaIoXGlS3cwyoHnTX0Sn2GaHo9/AxO7+jg0f7plX+22pm3ifo7XVs31Ddyuk4fh88lizMmeB3rZKb4mhvkF8h9L+cbFXQ4HP+19UNgoAmmzzYU5X35+e/F3nSB7tAz7MZjQSG/tpuYoDuDrJBQAXZdfJ6dnK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AV47vfLA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ttzeKH24OIro/tgZ6ld9F7CNMTsJylUB18DEAt6MCa4=; b=AV47vfLA6Cr/IppjyZ58oP/Dej
	upA1qpiOEjFBTQIwlNrixMmUJM8PaBsuOVJCb8Kfo1hSZbadeKG6o0fs/X4A/riHZ1Sfp15JYvFiL
	q5J5denqStItH1y6qkykUI9al8bSbq+F17N1VbODIJJXcvIAxnUJotH9xYKRGvoJsaa6IFNgXEJVC
	qZKMPYKAH/IZZ10MHiM89/Nj/1BfM7T4XSjo5bfUGT40Sl460Nl7uP/lWfzI329cFTMVzGeTaGCQA
	s4Lt+2CwJuO4DXsoBHPcpgtAKf6Nz/fj30mfHo0Ztf/ZJIcefUK9DQoy4iXKHGvuU1oG9+V66QJZO
	eBqGP3RA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s7Hzq-007ZN9-30;
	Wed, 15 May 2024 17:00:55 +0000
Date: Wed, 15 May 2024 18:00:54 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Sterba <dsterba@suse.cz>
Cc: syzbot <syzbot+c92c93d1f1aaaacdb9db@syzkaller.appspotmail.com>,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, maz@kernel.org, oleg@redhat.com,
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at fs/inode.c:LINE! (2)
Message-ID: <20240515170054.GM2118490@ZenIV>
References: <000000000000c8fcd905adefe24b@google.com>
 <20240515161314.GO4449@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515161314.GO4449@twin.jikos.cz>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 15, 2024 at 06:13:14PM +0200, David Sterba wrote:
> On Fri, Aug 28, 2020 at 06:18:17AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    d012a719 Linux 5.9-rc2
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15aa650e900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
> > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ecb939900000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140a19a9900000
> > 
> > The issue was bisected to:
> > 
> > commit a9ed4a6560b8562b7e2e2bed9527e88001f7b682
> > Author: Marc Zyngier <maz@kernel.org>
> > Date:   Wed Aug 19 16:12:17 2020 +0000
> > 
> >     epoll: Keep a reference on files added to the check list
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a50519900000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a50519900000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11a50519900000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+c92c93d1f1aaaacdb9db@syzkaller.appspotmail.com
> > Fixes: a9ed4a6560b8 ("epoll: Keep a reference on files added to the check list")
> > 
> > ------------[ cut here ]------------
> > kernel BUG at fs/inode.c:1668!
> 
> #syz set subsystem: fs
> 
> This has been among btrfs bugs but this is is 'fs' and probably with a
> fix but I was not able to identify it among all the changes in
> eventpoll.c

It has nothing to do with btrfs, and there's a good chance it had been
fixed as a side effect of 319c15174757 "epoll: take epitem list out of struct file"
merge at 1a825a6a0e7e in 5.10 merge window; IOW, it should be in 5.11-rc1.

