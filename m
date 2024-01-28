Return-Path: <linux-fsdevel+bounces-9249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F2083F946
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 20:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD3B1C214B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 19:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B2C31A66;
	Sun, 28 Jan 2024 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="nM6Mquts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F672EB10
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706469113; cv=none; b=Tpmx2pSF5fBYp7pcQ4QfH/KnpI9+Ib6hPzbiMylDWWjRQjztZzaJR7mxJgZZseauaaQathzVRgRnGcecIARIcAYhb1IjCCPXGSPZMckMCNKXxbj9T21uRyzbb2kNx70Ml194BVwsZnkypGOeJyQFWHZ8+2khg8vKS17Suf1GoTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706469113; c=relaxed/simple;
	bh=C0VMPD5bNTyUEMTxxgcJg72uFvKVRw3kF1rZkjkLq9A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9moIvKBSL04J27iwloQRl8yI1ny2/un9G49h+3FSFMNxZ4ewuaixMgMYg3G06LCcdbqahKjvkwtPxMKWbUQCfPA/UoyEMUFHYTXDhApedVRaN/JnyIARKxLrL4SXtYyxvh7lKggqygzZx8+r9i5MLtqMcO9vHFisGMW9fqeAeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=nM6Mquts; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail3; t=1706469107; x=1706728307;
	bh=C0VMPD5bNTyUEMTxxgcJg72uFvKVRw3kF1rZkjkLq9A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nM6MqutsjeLXhaCO+OeU+ICpZCP1Czums6lJT093fmUbCDJtCzAaTPPQVvTbHHgEK
	 T74/C078SkdeY4OMLPRxnVuWqw0gkowwLUJuNi77fO8SeQ2aEWlaRnkk6WJ4iArEEH
	 QkXpzFcJZaIp/hkmBPqnlQyIOFmc8ySaNPFo/iPbLEADBMjqpAja2+3mQJHBuQOTbY
	 JOiJPcB3GpvGPPUutnb+3UbgTg+jdAuYB9bLM8B+2QCVJ1E8h6vlmhE+zYCL1ldYGD
	 KvNhav4zuPEj+A9cstddOJLeVIstC633FLPIyGhE2VkzZgycZXySSu75qchwZA9J60
	 iRCoietN2Q+xA==
Date: Sun, 28 Jan 2024 19:11:22 +0000
To: Amir Goldstein <amir73il@gmail.com>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: fuse-devel <fuse-devel@lists.sourceforge.net>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [fuse-devel] FICLONE / FICLONERANGE support
Message-ID: <27NkIxkEKMyKyuD7OJPXRpExu4ql7TuTLUxlsI8XTPPuOhEwtiXDJOvSakmxAYai54ekNlmxZt8YvZ3ASPnIce-pK-vZobOZfVBTXhSuSKw=@spawn.link>
In-Reply-To: <CAOQ4uxgoJkotsP6MVuPmO91VSG3kKWdUqXAtp37rxc0ehOSfEw@mail.gmail.com>
References: <1fb83b2a-38cf-4b70-8c9e-ac1c77db7080@spawn.link> <CAOQ4uxgoJkotsP6MVuPmO91VSG3kKWdUqXAtp37rxc0ehOSfEw@mail.gmail.com>
Feedback-ID: 55718373:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, January 28th, 2024 at 4:07 AM, Amir Goldstein <amir73il@gmail.co=
m> wrote:

>=20
>=20
> On Sun, Jan 28, 2024 at 2:31=E2=80=AFAM Antonio SJ Musumeci trapexit@spaw=
n.link wrote:
>=20
> > Hello,
> >=20
> > Has anyone investigated adding support for FICLONE and FICLONERANGE? I'=
m
> > not seeing any references to either on the mailinglist. I've got a
> > passthrough filesystem and with more users taking advantage of btrfs an=
d
> > xfs w/ reflinks there has been some demand for the ability to support i=
t.
>=20
>=20
> [CC fsdevel because my answer's scope is wider than just FUSE]
>=20
> FWIW, the kernel implementation of copy_file_range() calls remap_file_ran=
ge()
> (a.k.a. clone_file_range()) for both xfs and btrfs, so if your users cont=
rol the
> application they are using, calling copy_file_range() will propagate via =
your
> fuse filesystem correctly to underlying xfs/btrfs and will effectively re=
sult in
> clone_file_range().
>=20
> Thus using tools like cp --reflink, on your passthrough filesystem should=
 yield
> the expected result.
>=20
> For a more practical example see:
> https://bugzilla.samba.org/show_bug.cgi?id=3D12033
> Since Samba 4.1, server-side-copy is implemented as copy_file_range()
>=20
> API-wise, there are two main differences between copy_file_range() and
> FICLONERANGE:
> 1. copy_file_range() can result in partial copy
> 2. copy_file_range() can results in more used disk space
>=20
> Other API differences are minor, but the fact that copy_file_range()
> is a syscall with a @flags argument makes it a candidate for being
> a super-set of both functionalities.
>=20
> The question is, for your users, are you actually looking for
> clone_file_range() support? or is best-effort copy_file_range() with
> clone_file_range() fallback enough?
>=20
> If your users are looking for the atomic clone_file_range() behavior,
> then a single flag in fuse_copy_file_range_in::flags is enough to
> indicate to the server that the "atomic clone" behavior is wanted.
>=20
> Note that the @flags argument to copy_file_range() syscall does not
> support any flags at all at the moment.
>=20
> The only flag defined in the kernel COPY_FILE_SPLICE is for
> internal use only.
>=20
> We can define a flag COPY_FILE_CLONE to use either only
> internally in kernel and in FUSE protocol or even also in
> copy_file_range() syscall.
>=20
> Sure, we can also add a new FUSE protocol command for
> FUSE_CLONE_FILE_RANGE, but I don't think that is
> necessary.
> It is certainly not necessary if there is agreement to extend the
> copy_file_range() syscall to support COPY_FILE_CLONE flag.
>=20
> What do folks think about this possible API extension?
>=20
> Thanks,
> Amir.

cp --reflink calls FICLONE. It received a EOPNOTSUPP and falls back to copy=
ing normally (if set to auto mode). It appears it still does this: https://=
github.com/coreutils/coreutils/blob/master/src/copy.c#L1509

My users don't control the software they are running. They are using random=
 tooling that happen to support FICLONE such as cp --reflink. In the most r=
ecent case using it for some rsnapshot like backup strategy I believe.

