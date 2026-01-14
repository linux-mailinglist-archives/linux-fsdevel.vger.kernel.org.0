Return-Path: <linux-fsdevel+bounces-73806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB7AD2106C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 20:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 448F630B7AE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 19:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD534346E4C;
	Wed, 14 Jan 2026 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+zBZqBk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321E4346ACF
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418793; cv=none; b=CGR43InKm0pQiYmPEiZkvF/mlrayzEVW1bvg8qYVPs/gxHV0T9BxietKDJD1KI67F5TGB/I9/k7QGqj0iGcrNpMrv8NPpDr9YTxALJrd4sxbtyLi3Mbk8isopJo0E4hRKHhX0hWXVMZpJQSoKQLKipsZ5OK0zXv1+mmEQXVY4iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418793; c=relaxed/simple;
	bh=GDWhkrp0gaPcpJ/EyDLhP47UhtSCCQrjfw/rDHtBo+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nK+fDsv7zbMmCOT/JiJ55UPiI0OrEZnmwXU44y44xoszx4vL02GobK94v1j+rfV/04ZqjwSEyhZEx/F5F1BhAfpFdHN7aK/emHGIZoDCQ0OiZDwD/SCNikPbNGslhf5Z5NDFdpmXomRQNzUr6At4sonvxNnLcHyLPUGdiPgbX38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+zBZqBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0765C4CEF7;
	Wed, 14 Jan 2026 19:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768418793;
	bh=GDWhkrp0gaPcpJ/EyDLhP47UhtSCCQrjfw/rDHtBo+c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=s+zBZqBkywg1lV4rpbeYZNEOvHheCKAGTBgIgQzX7NZZjINYi3Ra837UtfQVSBng6
	 ZGRwGkH3RcI6y9WW9mOLTTvUwrmYHYxssz4vsBbzmeesaWEi+pEMBo8O3PuiVH2old
	 28AjtsApTM/6+i+lCKrXgxMtIHFrCIH4w1wrSQV9tiZ2B+gj+UpGf8qabR9jtmyD0f
	 TrbQbBXHFY8poWVRolvhr6AFP76ZzM4aZXykxDl5O0ZJTREUmYgYz9PJPNhsrsjciA
	 alP6M4araWQA2CFQqq/qqwHX2pYkvU/vOTTHc3QZHU8f0Lcj/KYS+dD8bOGoHOdrjj
	 q3I6wZzLhEN3A==
Message-ID: <8f5bb04853073dc620b5a6ebc116942a9b0a2b5c.camel@kernel.org>
Subject: Re: NFSv4 + FUSE xattr user namespace regression/change?
From: Trond Myklebust <trondmy@kernel.org>
To: Antonio SJ Musumeci <trapexit@spawn.link>, linux-fsdevel@vger.kernel.org
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Miklos
 Szeredi	 <miklos@szeredi.hu>
Date: Wed, 14 Jan 2026 14:26:31 -0500
In-Reply-To: <32Xtx4IaYj8nhPIXtt0gPimTRQy4RNjzmsqI1vQB1YBpRes0TEgu6zVzWbBEcn2U6ZxB14BD9vakmezNyhdXDt3CVGO8WYGxHSZZ1qtQVy8=@spawn.link>
References: 
	<32Xtx4IaYj8nhPIXtt0gPimTRQy4RNjzmsqI1vQB1YBpRes0TEgu6zVzWbBEcn2U6ZxB14BD9vakmezNyhdXDt3CVGO8WYGxHSZZ1qtQVy8=@spawn.link>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-14 at 19:18 +0000, Antonio SJ Musumeci wrote:
>=20
> =C2=A0
> You don't often get email from trapexit@spawn.link.=20
> Learn why this is important=20
>=20
>=20
>=20
> Forgive me but I've not had the chance to investigate this in detail
> but according to a user of mine[0] after a commit[1] between 6.15.10
> and 6.15.11 user namespaced xattr requests now return EOPNOSUPP when
> the FUSE filesystem is exported via NFS. It was replicated with other
> FUSE filesystems.
>=20
> Was this intentional? If "yes", what would be the proper way to
> support this?
>=20
> -Antonio
>=20
> [0]=C2=A0https://github.com/trapexit/mergerfs/issues/1607
> [1]=C2=A0
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/comm
> it/?id=3Da8ffee4abd8ec9d7a64d394e0306ae64ba139fd2

You should upgrade to a newer stable kernel.

This issue has already been reported and fixed by commit 31f1a960ad1a
("NFSv4: Don't clear capabilities that won't be reset").


--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

