Return-Path: <linux-fsdevel+bounces-22319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9D591658C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EB6285B26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C554114A4F0;
	Tue, 25 Jun 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="epDGYfTv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7711487C8;
	Tue, 25 Jun 2024 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312689; cv=none; b=kIiOKVvj79LRLBl7gdKvwEYm9ZGtB+D1f2YUD9oNGh1nd7d6sfgw6Q+KAxcVgOeXd6mXhAs5O6Ktl4EMdoiT+MPdvst3h8aP7LJzmtHmLQMHrfMM0l/ZjUjz0d2rUiOpS2L6IsPmI5Fw7etJI3V3P44hSLE4fFlgzfW41GUBJ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312689; c=relaxed/simple;
	bh=oOPm6VbQg7r77uhF+4yKYjhxiHbj06XEQRdBHsSXNs8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RnxnDrFkrOAOH+e+pCr1FW4L6NMN6fdFb/5qxRsBmIjl8IwbDv96maBsWg6C2kZKKU7fgMi+aggBCHMYAytBsBNvXbqz7AdGxC8auEyvENXcbOucvKNq1oTj1wu7MkE2EKfeo6XxyGNcXvsaMB+Aj11H/y9lL3BRAc/muXGlwmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=epDGYfTv; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1719312685;
	bh=oOPm6VbQg7r77uhF+4yKYjhxiHbj06XEQRdBHsSXNs8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=epDGYfTvAFjd8g2n3x53oXiJuXJhowRhaTwnEI0IfBzCKWjXwWgX9Iw3LCjxU/M/M
	 QHaxQUYwoXnjMxXe+YAH8kMK/SK91fL6YBOqMTCnCSieuuftmcK7w00yWVacsejEYG
	 Y6JdgP2yip4V6RQ/76e2VXoB+ggT83tKBm9inbzI=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id B522E66D88;
	Tue, 25 Jun 2024 06:51:21 -0400 (EDT)
Message-ID: <30a5fe67500c40a4d5f9516e9b549ec796faac74.camel@xry111.site>
Subject: Re: [PATCH v2] vfs: Shortcut AT_EMPTY_PATH early for statx, and add
 AT_NO_PATH for statx and fstatat
From: Xi Ruoyao <xry111@xry111.site>
To: Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Linus
 Torvalds <torvalds@linux-foundation.org>, Alejandro Colomar
 <alx@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen
 <chenhuacai@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Icenowy Zheng <uwu@icenowy.me>,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 25 Jun 2024 18:51:19 +0800
In-Reply-To: <20240625-kindisch-ausgibt-b4feede36bab@brauner>
References: <20240624085037.33442-2-xry111@xry111.site>
	 <e2lv3qamggymdjqzujvyhsd2q34jy5tryniac7d446tlaebqwy@5x4zn7z4d3xz>
	 <20240625-kindisch-ausgibt-b4feede36bab@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-25 at 10:50 +0200, Christian Brauner wrote:
> No, let's not waste AT_* flag space in fear of some hypothetical
> breakage. Let's try it cleanly first and make AT_EMPTY_PATH work with
> NULL paths.
>=20
> Note, I started working on this (checks ...) 30th April but then some
> other work came up and I never got back to it (Sorry, Linus). I pushed
> the branch to #vfs.empty.path now. The top three commits was what I had
> started doing.
>=20
> It was based on a new vfs_empty_path() helper so we could reuse it for
> other system calls as well.

If I understand correctly, I should submit a patch against
vfs.empty.path making statx(fd, NULL, AT_EMPTY_PATH) work then?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

