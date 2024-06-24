Return-Path: <linux-fsdevel+bounces-22233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 128CE9149AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 14:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73ED5B209AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 12:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC9313BACB;
	Mon, 24 Jun 2024 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="BZzQie7w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E74776A;
	Mon, 24 Jun 2024 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231589; cv=none; b=Sg2Om7AA2SsqxeaMsOGggQuv7cntMpDXVSqnxhxYuAMJWb5Igd3qC+aBivlj3gTk73p9WQv7b6jn392kNPrHaGuvJ6aSYow42GUhwdnTxHwKSexjYZHrSHrPyAWHYErAZxxx8oIEblzBT+bsflrBVkexSLT62jlXBGl/ZUGyZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231589; c=relaxed/simple;
	bh=c6fJHiLFxyHf/F2gL1N8M/PRrwGCHjFJaJ3bTOGiUGU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qCeyJOPcdVCIyOF7g9DEAxxtpr8r8tVqe7ojBOpT3M6igFeDxxUdCpSxrHPSraZ32+IFPDvtIAdxJ0YsAZbBva/9cENqD6vod7MVgOy8RpydMVBskVQ7Ny3mUINcUwH93JSe/aVKRBabMtAO4DIFYgOM7Zw294pssvTxw+ySS+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=BZzQie7w; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1719231580;
	bh=c6fJHiLFxyHf/F2gL1N8M/PRrwGCHjFJaJ3bTOGiUGU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BZzQie7w1Pj6MR3+WeApxClpW5sMn5UJ5ak9L9c8JNahbSiH/xT6mI0/0ivl970m3
	 IHTXZOdqO0KtxIpWDrImJ8IBrbiWOC3pePHjiFnZ9lLl4yi04cDF6nDi5OR5SXb8MI
	 KvgzUmBaz+M/lmEwwBB1veZNcaT6g20Fov3x7slU=
Received: from [192.168.124.13] (unknown [113.200.174.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 39A9E675C3;
	Mon, 24 Jun 2024 08:19:36 -0400 (EDT)
Message-ID: <b635271e73b35487a06cf17176243e6ce4cfcd58.camel@xry111.site>
Subject: Re: [PATCH v2] vfs: Shortcut AT_EMPTY_PATH early for statx, and add
 AT_NO_PATH for statx and fstatat
From: Xi Ruoyao <xry111@xry111.site>
To: Mateusz Guzik <mjguzik@gmail.com>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro
	 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Alejandro Colomar
	 <alx@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen
	 <chenhuacai@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang
	 <jiaxun.yang@flygoat.com>, Icenowy Zheng <uwu@icenowy.me>, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 20:19:33 +0800
In-Reply-To: <e2lv3qamggymdjqzujvyhsd2q34jy5tryniac7d446tlaebqwy@5x4zn7z4d3xz>
References: <20240624085037.33442-2-xry111@xry111.site>
	 <e2lv3qamggymdjqzujvyhsd2q34jy5tryniac7d446tlaebqwy@5x4zn7z4d3xz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 11:04 +0200, Mateusz Guzik wrote:
> Below is a diff which compiles but is untested. It adds AT_EMPTY_PATH +
> NULL as suggsted by Linus, but it can be adjusted for AT_NO_PATH (which
> would be my preffered option, or better yet not do that and add fstatx).
>=20
> It does not do the hack to 0-check if a pointer was passed along with
> AT_EMPTY_PATH but that again is an easy addition.
>=20
> Feel free to take without attribution:

I'd still like to make it Co-developed-by: or just From: you.  Could you
give a S-o-b?

And with this change AT_FDCWD with AT_EMPTY_PATH and NULL path does not
work.  For consistency it'd be better to make it work too:

diff --git a/fs/stat.c b/fs/stat.c
index b0a4db7b90df..d04f7ba46645 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -752,10 +752,14 @@ SYSCALL_DEFINE5(statx,
 	int ret;
 	struct filename *name;
=20
-	if (filename =3D=3D NULL && (flags & AT_EMPTY_PATH))
-		return do_statx_fd(dfd, flags, mask, buffer);
+	if (filename =3D=3D NULL && (flags & AT_EMPTY_PATH)) {
+		if (dfd >=3D 0)
+			return do_statx_fd(dfd, flags, mask, buffer);
+		else
+			name =3D getname_kernel("");
+	} else
+		name =3D getname_flags(filename, getname_statx_lookup_flags(flags));
=20
-	name =3D getname_flags(filename, getname_statx_lookup_flags(flags));
 	ret =3D do_statx(dfd, name, flags, mask, buffer);
 	putname(name);
=20
And should we do it for fstatat() as well?

Let's wait for comment from Linus anyway.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

