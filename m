Return-Path: <linux-fsdevel+bounces-30317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8279896EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 20:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E5E1F212C7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 18:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4D17346F;
	Sun, 29 Sep 2024 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fr9kzvy9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B108018EAB;
	Sun, 29 Sep 2024 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727636106; cv=none; b=jwpCGMKHWVQQ+//KsTgRLJnfF0Xx5l/ch3HBg15IyZPX1OHLNPY8W6K9zSAp0CuqnaCES00m0VkO++FAfOZanmfz1BzhRE8vRwAvHs7ugoNHCRktLTYlC41RVDd3mtf2CB0UbiJUzrAznx8++Zx5kF6f3ybRoqw5nAzYZZxY0NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727636106; c=relaxed/simple;
	bh=jAulFupwHSoaUi/6sQaBbxwLwD4EQjNV6hWdaK3VMeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5Xw1GjtGlV34dEH1ZMSjiD/oC01mMGBsnTQ6YaWlOPIJ2+rS5FrsbOSgMxQ5TSQUuTYf6Ixk/bmrUT+XRRedOSjGtsmZzTLa0E8ZKl2huGdf079s8PwhQWzIOpE2IxB4nBhINxUBu9i6ojiBFwSokYFQwKeaCQcwx2odvPYPvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fr9kzvy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75091C4CEC7;
	Sun, 29 Sep 2024 18:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727636106;
	bh=jAulFupwHSoaUi/6sQaBbxwLwD4EQjNV6hWdaK3VMeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fr9kzvy9ZvXrAyv2UllxHifNu6IjR55if6yiVZdFsqEDWM8KeUI0i2OOazz1sJWgv
	 C7FEhIX+Kv8rKL4HR2qbLhRniIw90m53J/xKlPjSUHTvLxQzmeHsOQfGpPe7zNPydx
	 igiQKwOCunehcDRZ98DPEJvFwnQX6F+64GRE+zGIQbZUCsERuI8uzf7wQWQyYH/LgQ
	 IYBhLr3Up0Y5MYZrivJNKR+oquf3PaSy3JHujxIAywf0gC6wdBK0Vp5oFNxKDhmmaA
	 kX0Ijo0JsbL2WuHZ8K+T60FaR2mcFykzg5maIOHz5Do5MOUwczMMHqH9pe8OEFonhF
	 Rq5ezJWx1L3ug==
Date: Sun, 29 Sep 2024 21:55:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>,
	David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Manu Bretelle <chantr4@gmail.com>, asmadeus@codewreck.org,
	ceph-devel@vger.kernel.org, christian@brauner.io, ericvh@kernel.org,
	hsiangkao@linux.alibaba.com, idryomov@gmail.com, jlayton@kernel.org,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, marc.dionne@auristor.com,
	netdev@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com,
	smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com,
	v9fs@lists.linux.dev, willy@infradead.org
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Message-ID: <20240929185501.GA218692@unreal>
References: <20240925103118.GE967758@unreal>
 <20240923183432.1876750-1-chantr4@gmail.com>
 <20240814203850.2240469-20-dhowells@redhat.com>
 <1279816.1727220013@warthog.procyon.org.uk>
 <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
 <2808175.1727601153@warthog.procyon.org.uk>
 <c688c115af578e6b6ae18d0eabe4aded9db2aad9.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c688c115af578e6b6ae18d0eabe4aded9db2aad9.camel@gmail.com>

On Sun, Sep 29, 2024 at 02:37:44AM -0700, Eduard Zingerman wrote:
> On Sun, 2024-09-29 at 10:12 +0100, David Howells wrote:
> > Can you try the attached?  I've also put it on my branch here:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/l=
og/?h=3Dnetfs-fixes
>=20
> Used your branch:
> fc22830c5a07 ("9p: Don't revert the I/O iterator after reading")
>=20
> dmesg is here:
> https://gist.github.com/eddyz87/4cd50c2cf01323641999dc386e2d41eb
>=20
> Still see null-ptr-deref.

I tried it too and I can confirm that the issue is still there.

Thanks

>=20
> [...]
>=20

