Return-Path: <linux-fsdevel+bounces-12054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE34285AC88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 20:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A6B2B24090
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 19:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A963535AF;
	Mon, 19 Feb 2024 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="MNOg0jEV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE5451037
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372472; cv=none; b=KA9XPSCq+UHfhz2JHpt65IiytDjQYhworsufGkPVOczjuVF1bFnYtA9Ter9KIh16txq2owtskL9rQG6qcBg6M0Im936hWhphzBLIaihbIyQKtk3mukD1x2ncB3yFQC/r5OdRq3ftRNiBVaP8OM3B9ATI61GV2MZfmamsiGlaaC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372472; c=relaxed/simple;
	bh=/4j+jQDpNKpBVpwkV6DfSXBy/Lf71+itJc6sOl1ptdE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzPayRUji0MR5iRLTj2eXo2CPGEDjmC3m8m3bn6ILPaxmas+xEc6WBZ3opN/NzxF4PHgGNMnwh2Ng71H1MCd86wiWWwKLi8ZXNThfSa6YBXN7p/D9s011W9gXfe1nV28O7NEJCOIve3wlpd8iVWji1iW7TfRc9RJt/v5b0/bXP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=MNOg0jEV; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail3; t=1708372461; x=1708631661;
	bh=J3XM/6WgtKeR1IY9BPGcBpSOih5jcbJyTvRHjPtvLXo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MNOg0jEVJxX7hQCXerQr9LX6+VUbE5fS8wpePC3l9/JaiPCU+y6s1m2AkK1T+Kgyf
	 jHHzTbwGmW1BsdAg/YTfFfPEvWhMOKRK3k2x+9UwW6l6dB03S4Ha3R9ifxLqT6eK0E
	 VS15dHpXTakfKCw+z8m+18TFj9uzGIjP0mFAw/vtMQDYCHWK7rRl6Cd/60eT+S5Ze4
	 6p5Q8ySRxe60AYS71H5Ibn9o6yjHjF3LGgxxqH6NzMszL4w7gCFoZZ/A4DW3LOW1i+
	 zStsvGp7NLg+mTCst6+0TC4CI1084euE+VHQH2OX/rLvFFQpK7WkBeOwPOiCbAFSB5
	 wFgNni5lkpmmg==
Date: Mon, 19 Feb 2024 19:54:13 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fuse-devel <fuse-devel@lists.sourceforge.net>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
Message-ID: <5b7139d5-52fd-4fd0-8fa0-df0a38d96a33@spawn.link>
In-Reply-To: <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com>
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link> <CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com> <b9cec6b7-0973-4d61-9bef-120e3c4654d7@spawn.link> <CAOQ4uxgZR4OtCkdrpcDGCK-MqZEHcrx+RY4G94saqaXVkL4cKA@mail.gmail.com> <23a6120a-e417-4ba8-9988-19304d4bd229@spawn.link> <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm> <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link> <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com>
Feedback-ID: 55718373:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/19/24 13:38, Miklos Szeredi wrote:
> On Mon, 19 Feb 2024 at 20:05, Antonio SJ Musumeci <trapexit@spawn.link> w=
rote:
>=20
>> This is what I see from the kernel:
>>
>> lookup(nodeid=3D3, name=3D.);
>> lookup(nodeid=3D3, name=3D..);
>> lookup(nodeid=3D1, name=3Ddir2);
>> lookup(nodeid=3D1, name=3D..);
>> forget(nodeid=3D3);
>> forget(nodeid=3D1);
>=20
> This is really weird.  It's a kernel bug, no arguments, because kernel
> should never send a forget against the root inode.   But that
> lookup(nodeid=3D1, name=3D..); already looks bogus.
>=20
> Will try to untangle this by code review, but instructions to
> reproduce could be a big help.
>=20
> Thanks,
> Miklos

Thank you.

I'll try to build something bespoke against current libfuse.

That forget(nodeid=3D1) is coming in after my code detects that=20
lookup(nodeid=3D1, name=3D"..") and returns -ENOENT. Which in a way makes=
=20
sense. Though it seems to happen no matter what I return. Returning the=20
same as lookup(nodeid=3D1, name=3D".") results in the same behavior. I've=
=20
not tried creating a fake node with a new nodeid/generation though.


