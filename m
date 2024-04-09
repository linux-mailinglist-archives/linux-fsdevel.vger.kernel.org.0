Return-Path: <linux-fsdevel+bounces-16422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7685D89D543
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 11:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0890A1F2281C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 09:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD8F7F48A;
	Tue,  9 Apr 2024 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaqeQwp+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E15339A;
	Tue,  9 Apr 2024 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654339; cv=none; b=UvVijDJwDRDR9HANFnGZ3PDVe2rHiufw+0/vMVKLuVuT9YlqYLYoFtuWANwxzaFDQ8XitSWa/1Y1kxN3kKFbm9pnXZIP0ydpyqnRPWOf8IzxJoDJk8S0TgqDdYJFQsvXMT66dE6Hp2uvsqR5ZKcdrgUzkG7/iOV7QMhT1n4QR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654339; c=relaxed/simple;
	bh=QYzHyMKb2yJIs59EAroTnEg80ZuM/0QLSv4JzXfq2Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlgyW1LDrD9RNDijqJpAkWK+0aSEBGNTAEb9COroAUdunutZMeS6VzYm1kynht3UXCt2Vzq1z6NqSc7pI2KxvTabMJisGvcq9aE7lHCBGYFQPC2HV2bb9jTvSFegrNBQo+Uh0pyaxTT2xT7KrlfgldcXkpMOq0OO/1QQfjdhzPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaqeQwp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23A1C433C7;
	Tue,  9 Apr 2024 09:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654338;
	bh=QYzHyMKb2yJIs59EAroTnEg80ZuM/0QLSv4JzXfq2Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CaqeQwp+5iObgLiwPI4rskicMzbhhKIXuXL1ZgiEbWlXXhsXofqsOPRHoP8hoyMi/
	 G3+47yNcvwsVxeA+es0i9IJx80AgZFWaDXNW0DrYFhkkFniqv/i7+rI0NHrlCmKJnR
	 uBeGCez+X95zakpD6SGHLspCVWk7M24B7UWH5MSqQlmfbl178348/F7Ozhgs30Kqlc
	 71KOMJS2RhdEmw0gC+gHU3jpiCgWT5EXGuAI1IYXEH35rweHs0W6mPcnZTqgt5jX7o
	 wGmaT0Ex6j2TKA8dxcEQEjx7XfSUEh3YFA8uJX6ak9kye+z2RZBW6fUTBmhgN/0xB1
	 1j0KEaO44kmQA==
Date: Tue, 9 Apr 2024 11:18:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>, gregkh@linuxfoundation.org, hch@lst.de, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, valesini@yandex-team.ru, 
	Hillf Danton <hdanton@sina.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <20240409-mahlzeit-abhielt-071091705455@brauner>
References: <CAOQ4uxgJ5URyDG26Ny5Cmg7DceOeG-exNt9N346pq9U0TmcYtg@mail.gmail.com>
 <000000000000107743061568319c@google.com>
 <20240406071130.GB538574@ZenIV>
 <CAOQ4uxhpXGuDy4VRE4Xj9iJpR0MUh9tKYF3TegT8NQJwanHQ8g@mail.gmail.com>
 <20240407005056.GF538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240407005056.GF538574@ZenIV>

On Sun, Apr 07, 2024 at 01:50:56AM +0100, Al Viro wrote:
> On Sat, Apr 06, 2024 at 11:57:11AM +0300, Amir Goldstein wrote:
> > On Sat, Apr 6, 2024 at 10:11 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Sat, Apr 06, 2024 at 12:05:04AM -0700, syzbot wrote:
> > >
> > > > commit:         3398bf34 kernfs: annotate different lockdep class for ..
> > > > git tree:       https://github.com/amir73il/linux/ vfs-fixes
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c5cda112a8438056
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=9a5b0ced8b1bfb238b56
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > >
> > > > Note: no patches were applied.
> > >
> > 
> > Looks like it fixes the problem:
> > https://lore.kernel.org/lkml/000000000000a386f2061562ba6a@google.com/
> > 
> > Al,
> > 
> > Are you ok with going with your solution?
> > Do you want to pick it up through your tree?
> > Or shall I post it and ask Christian or Greg to pick it up?
> 
> Umm...  I can grab it into #fixes.  Would be nice to get the result of

Fine by me if you have other stuff pending for -rc4 anyway. Otherwise I
can grab it.

