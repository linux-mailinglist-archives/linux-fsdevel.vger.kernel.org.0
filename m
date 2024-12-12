Return-Path: <linux-fsdevel+bounces-37139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775359EE469
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 11:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC29281B63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD9B21149C;
	Thu, 12 Dec 2024 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="a7PFC7o6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C9204C28;
	Thu, 12 Dec 2024 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000254; cv=none; b=oozGotT67tbUWf62dw8rNX3E7hMZLNZVQQgtM3WEDnZNInDAjLC6bjqghO7FNyTLz22MGZRzU99naw0k7oWP5TPd0mfHuByROj8OSNWHsGGnag8TTHVAuGDCEEmf2P6aYZOcNwzyHkzkbRGk0r7eAPDG7mIcCBZ2hyiIl8op9Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000254; c=relaxed/simple;
	bh=CFrVkfQT2FWtC5+zZrjCm6/H5WOJhaB5szdgEdMyzz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnjNFwcYR8/jZbpw8/pq9QCGR1+KtZyD9Fe9P0WvNV8ImKonk6ReAtMjadq3nOuu0RWz71XpBJLjMnfSd0pT86jfbE+8FZsRdyV/eA67eEMdUlNmHcqFyQn5iw2foEXGW3J8k7+V7wjRYuFSc1clU4wxP9nMx8OefbpOtcnXFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=a7PFC7o6; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=0pBBMlpWw78z8gxF0nm1mH/ofBxxUMEFQEaNd51NMN4=; b=a7PFC7o6hws+u+0cwhcXO7kR/b
	tB/tueVrn4mjzB3aGr1q9FSamGxeUK6RIOdsi2HA7Dd98sm6k2Cpum7T75L9f8Aon4G0TAKxytxyV
	CrfbZL4faKL4J0nzy2FNbTH9Dp3dknvDdtmQJX1xI1mVLvSr7ZqlzsWE05CxMweSppT7YcNpUW75e
	YGImZMCzoTS3oQfotCodbLml6ziYXbVI5fLgZZMWqTLwX82GaZqb70a7Gn5GkGI6CABYP2i3o4gqL
	bt1TUDkLIZF+E74BUAhGof7YHaFlTpmpm1PgqHL0Ne1Ph5bRzNnr63xOB1KEtRtpFyeZOa+PhgBll
	XXT9G7f2kGgaXNV+iIJMH5F4RmH+MRjQQj15HPcEbhgo7XtE2LG/8MXmc3vyRcog+irz3zkWVBAG6
	B6H8x4ISBFuoFNhH8biyMkGQBhufQtrWTZnGBd3q/Hpbg1wlyeUCciJ+btzobPqUSJdY7bI4igTbP
	1vrGxLLDvUZrnRDDA3t4xzeFebhjIh2KhLxiihULMlG/HfJIZfzga8YbqlLstsO2rQEvq1AQKRT8D
	/f8G7ObtJXAaSHiXVJ/MdjZMSoiK+AQL7LU9//TGSbRkieXX7pzHdef2XIFBE0MrkN4yQmvoit9AU
	VcBrSOpDNplbYcaOspPsDTnlqM7Zzm8gxee/DJVwc=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: asmadeus@codewreck.org, Leo Stone <leocstone@gmail.com>,
 syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com, ericvh@gmail.com,
 ericvh@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, lucho@ionkov.net,
 syzkaller-bugs@googlegroups.com, v9fs-developer@lists.sourceforge.net,
 v9fs@lists.linux.dev, Fedor Pchelkin <pchelkin@ispras.ru>,
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
Subject:
 Re: Alloc cap limit for 9p xattrs (Was: WARNING in
 __alloc_frozen_pages_noprof)
Date: Thu, 12 Dec 2024 11:17:06 +0100
Message-ID: <2475109.TFnaqUCzQF@silver>
In-Reply-To: <20241211225500.GH3387508@ZenIV>
References:
 <675963eb.050a0220.17f54a.0038.GAE@google.com>
 <CAHk-=wiH+FmLBGKk86ung9Qbrwd0S-7iAnEAbV9QDvX5vAjL7A@mail.gmail.com>
 <20241211225500.GH3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, December 11, 2024 11:55:00 PM CET Al Viro wrote:
> On Wed, Dec 11, 2024 at 01:32:26PM -0800, Linus Torvalds wrote:
> > On Wed, 11 Dec 2024 at 13:04, <asmadeus@codewreck.org> wrote:
> > >
> > > Christian Schoenebeck's suggestion was something like this -- I guess
> > > that's good enough for now and won't break anything (e.g. ACLs bigger
> > > than XATTR_SIZE_MAX), so shall we go with that instead?
> > 
> > Please use XATTR_SIZE_MAX. The KMALLOC_MAX_SIZE limit seems to make no
> > sense in this context.
> > 
> > Afaik the VFS layer doesn't allow getting an xattr bigger than
> > XATTR_SIZE_MAX anyway, and would return E2BIG for them later
> > regardless, so returning anything bigger wouldn't work anyway, even if
> > p9 tried to return such a thing up to some bigger limit.
> 
> E2BIG on attempt to set, quiet cap to XATTR_SIZE_MAX on attempt to get
> (i.e. never asking more than that from fs) and if filesystem complains
> about XATTR_SIZE_MAX not being enough, E2BIG it is (instead of ERANGE
> normally expected on "your buffer is too small for that").

So that cap is effective even if that xattr does not go out to user space?

I mean the concern I had was about ACLs on guest, which are often mapped with 
9p to xattr on host and can become pretty big. So these were xattr not 
directly exposed to guest's user space.

/Christian



