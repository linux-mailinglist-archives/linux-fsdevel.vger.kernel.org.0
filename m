Return-Path: <linux-fsdevel+bounces-16302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA22289ADC6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 02:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4451C21021
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 00:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00A01103;
	Sun,  7 Apr 2024 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Z1QbZtqo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98391A35;
	Sun,  7 Apr 2024 00:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712451071; cv=none; b=YQccbH91P0BLSybNp4hvVj0eFDRz8zmkjpKmiIe91/gbB3xMA/fwx8gDfdxdQ4DhcCHKC4FAFON/cEHPW+/UFkv5u3NVOdmXMFS2xNufiFl8AM+cq+sgeDVoGLAWsWHhTMGIIaIRYfHFUJ/wggdKvdNmYu0jongaWo1uY4D4RE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712451071; c=relaxed/simple;
	bh=1ZxpeyKixQaUi5V1W3haBzOsBTo2Xa4YcSab6U9GhAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btOpcCVIqo4zozjCzp1p7GkjVFvYr7eajVsaApPWsx5YOh0QE/CZq6+ayMoEdKe5gAdcqNP0ULXilC63am+U+pW+tHOIZxnnD1sQMRnB6HpCFxnR5vqnazW6cZuzFLpKEx5Rw8XtqlEgR3Be7cLXtGEl7y/qT0a+AhRD2n9uusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Z1QbZtqo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=rHCNsgeb3aMSQ1dyancnN3q1ZGkC+Y40YNFbfooBqn4=; b=Z1QbZtqomM3AMmM75/mCXuGz6e
	57Do3IXKrAkbHTxgXnTR2HPu1ICt47XpcAMg+H8m6baMCT3ziynM+Yg8E73LGYFmLkDyA0HuSQf2v
	1oiOGDdcaat8hIlQTQ2ozVraRFXMtQzh2Do+lhc3RdKVJUwDIynn87WSInecvxuScK6yUgK3bajj9
	0Jlr8DzOOfW2Cv7hxsH5YwrRLHq/vifAEE6z+1lo04ZZ9S0FPdCrST5gW6HVGmGeUWexLHcfgvFpM
	feaze9l4ZeSJP7IPlH7sNPixmbvoSpRhxn6lMEin/cldA4vr+YaNnWcsah6QOibycSuR9WvZE2OqB
	Ma4btB1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rtGkK-007VIi-30;
	Sun, 07 Apr 2024 00:50:57 +0000
Date: Sun, 7 Apr 2024 01:50:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>,
	brauner@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, miklos@szeredi.hu,
	syzkaller-bugs@googlegroups.com, tj@kernel.org,
	valesini@yandex-team.ru, Hillf Danton <hdanton@sina.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <20240407005056.GF538574@ZenIV>
References: <CAOQ4uxgJ5URyDG26Ny5Cmg7DceOeG-exNt9N346pq9U0TmcYtg@mail.gmail.com>
 <000000000000107743061568319c@google.com>
 <20240406071130.GB538574@ZenIV>
 <CAOQ4uxhpXGuDy4VRE4Xj9iJpR0MUh9tKYF3TegT8NQJwanHQ8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhpXGuDy4VRE4Xj9iJpR0MUh9tKYF3TegT8NQJwanHQ8g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 06, 2024 at 11:57:11AM +0300, Amir Goldstein wrote:
> On Sat, Apr 6, 2024 at 10:11 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Sat, Apr 06, 2024 at 12:05:04AM -0700, syzbot wrote:
> >
> > > commit:         3398bf34 kernfs: annotate different lockdep class for ..
> > > git tree:       https://github.com/amir73il/linux/ vfs-fixes
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c5cda112a8438056
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=9a5b0ced8b1bfb238b56
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > >
> > > Note: no patches were applied.
> >
> 
> Looks like it fixes the problem:
> https://lore.kernel.org/lkml/000000000000a386f2061562ba6a@google.com/
> 
> Al,
> 
> Are you ok with going with your solution?
> Do you want to pick it up through your tree?
> Or shall I post it and ask Christian or Greg to pick it up?

Umm...  I can grab it into #fixes.  Would be nice to get the result of
that test both on current mainline and mainline + patch, though - looks
like the same test keeps hitting some unrelated shite in virtio_scsi.

