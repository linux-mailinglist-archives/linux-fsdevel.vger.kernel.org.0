Return-Path: <linux-fsdevel+bounces-27430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A025D9617A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 21:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD7F2830DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286101D2796;
	Tue, 27 Aug 2024 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="FUQz40IB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F111D175F
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785349; cv=none; b=teprYQDOM8XQHmwgUClU/0qgHZPM02UTLAi6D8lcko9vBDiSkdd/VGgZDvdvsEuKgexL4WOcX4D06BP4EGNYA3OBLzhsiQPEuv6kWEXxm66PC0pqquIF1B7Sv/XxNltcNzWjbiFEIe6KL8QcHs7WCBrLHJEP5nNGPoNltUvcLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785349; c=relaxed/simple;
	bh=G7bFIBJLiNrLVEX65b3M3cZqOVeWnONkxpxjU/kvQHY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0CSJtMDulY/y3532fVJOgnZXC8as8D4yThlf2ktC2CN/aOhN7KUutSDPoLGriDB0nkRvTIYS6vMQQPh7SpU+WatjlqCUU1psfpndfciZ9emN7ApXsyFc/ZSehQ8pEAYY13Pt+0/ZGsljLv1Ziw6Sidz8hC8hNz3D/j1dGMgNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=FUQz40IB; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail; t=1724785337; x=1725044537;
	bh=A2danaUYgw0a9odpV6Vt3/RvJixI8Zc33r3YZP2yFvc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FUQz40IBqucQps83Vua9YnPILvrkWcpv9vOf0Jzjp0+GAM1mnAOhdaBXiPkdE7QXd
	 pIqy73toVIbRKZCyJOE06j1Dd5PZavNUnWTRs4/oypU+a3FEvZ30d+hp1g1OCLabvG
	 hMycdVuh2biQ0uIuS7Iw3oMJmWBYA76l5YHQSO/bsH37ynGpnHomwBX5mcIXUOrx/i
	 5ppSEhikRawex2E4CV/Odf6ePtYlWE3C/F070v46D38go0Fx4xyAarOt/CadqlEaEj
	 l4NwssjIWpYhNVFf0diWTa3yV3mQm5EIppiRSXiFOXsaBhMdjV+c1TMZ6Iik/g5oao
	 9kDUQhPC8DDdA==
Date: Tue, 27 Aug 2024 19:02:11 +0000
To: Han-Wen Nienhuys <hanwenn@gmail.com>, Amir Goldstein <amir73il@gmail.com>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: FUSE passthrough: fd lifetime?
Message-ID: <6f03932f-906c-401f-9f48-5c20e146cd6c@spawn.link>
In-Reply-To: <CAOw_e7bMbwXzv00YeGw2NjGDfUpasaQix40iXC2EcLHk=n2wTA@mail.gmail.com>
References: <CAOw_e7bB3C_zbpq6U+FdrjbwJAOKFJk1ZLLETrR+5xqRmv44SQ@mail.gmail.com> <CAOQ4uxi=9WpKFb24=Hha_mwj9=bsj9qxiv0f0Z-FMfuBRCvdJA@mail.gmail.com> <CAOw_e7bMbwXzv00YeGw2NjGDfUpasaQix40iXC2EcLHk=n2wTA@mail.gmail.com>
Feedback-ID: 55718373:user:proton
X-Pm-Message-ID: 13ff2cc7ae2b6dc2307d9e42bcdd397628556ef1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/27/24 10:32, Han-Wen Nienhuys wrote:
> Sure. Who is the libfuse maintainer these days?

https://github.com/libfuse/libfuse/blob/master/AUTHORS is up to date


> For full transparency, I just work on the go-fuse library for fun, I
> don't have direct applications for passthrough at the moment. That
> said, I have been trying to make it go faster, and obviously bypassing
> user-space for reads/writes helps in a big way.

Keep in mind that passthrough isn't some simple feature that you enable=
=C2=A0=20
or not. There is a decent amount of subtleness to using it and it must=20
be very explicitly managed by the library user. It also will only work=20
where underlying FD is a filesystem.

And for anyone doing union filesystem like stuff, such as myself,=20
passthrough has limited use outside read/write. Even then the user will=20
have to give up certain features to enable since the FUSE server no=20
longer has control. Including errors.

> The most annoying part of the current functionality is the
> CAP_SYS_ADMIN restriction; I am not sure everyone is prepared to run
> their file systems as root. Could the ioctl check that the file was
> opened as O_RDWR, and stop checking for root?

This is a security feature ATM. And yes, it is a PITA in cases like mine=20
where you have to set{u,g}id to the calling request {u,g}id to ensure=20
proper authn/authz. In my prototyping with passthrough feature I'm=20
having to change to uid/gid, change back to root to setup passthrough,=20
then change back to uid/gid. Not the end of the world but...

> So in summary, my wishlist for passthrough (decreasing importance):
>
> 1.  get rid of cap_sys_admin requirement
> 2. allow passthrough for all file operations (fallocate, fsync, flush,
> setattr, etc.)
I'd generally agree. Having to have a singular backing fd for a node is=20
inconvenient in my usecase but I totally understand the reason. If there=20
was a way to remove the need to have a global construct to manage the=20
resource, it'd be nice, but not sure there is a good way of doing that.=20
Perhaps if certain requests, like open, could have a fh object like=20
other instructions and the kernel guaranteed there was no race condition=20
with setting it then perhaps that could be an option. Like... if lookup=20
had a fh that was attached to the node.


