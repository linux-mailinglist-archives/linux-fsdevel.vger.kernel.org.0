Return-Path: <linux-fsdevel+bounces-13920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B474B8757D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 21:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 443DDB23C7A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 20:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4EE137C5F;
	Thu,  7 Mar 2024 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8bw2KnL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F5E12DDB6;
	Thu,  7 Mar 2024 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841827; cv=none; b=jCR481fY9o7botmaouL+1ztmHHLo8SyMmY/xYCYbiU3lAcCt7FDAVQw87P3XD8PBuRRObfI1m8OBWJeDSUb7HZzY+P3rSfHIjBGP445G6Mv6jXsafvqoRFiwd51IgLT5xVj35ojGmUAfBI7SfilX/FwF7FNU9SauyLq+bviWNGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841827; c=relaxed/simple;
	bh=or5Zvybbh12HQg7S8mcZwU/rF56iK4Dh3wM0cLoYlEc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=SLC9XMzFRp0ZfLutpXD+ROoL6zJJ/XIV+M6KRZgWC5NvbtMXaawxQyvYhPBHJO5d0idWvpQcZQOBOmoP4tjw25ZF+I2k8QyjPWGz6QRjN4fOzCp0CM47cac0lmPuCOkeaIoIZqAl3H8XNdTA7RSrG6cHgivLjj8L3yjic1YUQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8bw2KnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B744C433C7;
	Thu,  7 Mar 2024 20:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709841826;
	bh=or5Zvybbh12HQg7S8mcZwU/rF56iK4Dh3wM0cLoYlEc=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=Z8bw2KnL9h2VF5BY9Of5RtEtKlkqKBMS/rtPkIOoggVHTD/QPBHl0whGqJ6IKsIJr
	 1uprv6G470KbGQlskspYIjACQCx4/e1za0UZtLhKBh60tffrLdoXArrf5cKMH3vAfP
	 VVCWLds0z/cn8d4PVjSsiiQ2Ai2lDQ/SsydQ4rJJu7+QMxo9duUnTl0uHtumkesK6J
	 3BU50J6Rrt0y4zG62zoer1d/BdJCq4StnlKo+74DYvBZ0MjZ09q8CT1n29uG/t09qd
	 9f1urCjZuJRsUF8GzAmc69qg2Y1AXj5bKZ8ea2MI+ICGhbDJzudgmavWNaNwuKmu5m
	 MCBA6FXGb6iMw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 22:03:43 +0200
Message-Id: <CZNSC9QUG8LK.372GE869GH81Q@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Christian Brauner"
 <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>
Cc: "Seth Forshee" <sforshee@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] xattr: restrict vfs_getxattr_alloc() allocation size
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240305-effekt-luftzug-51913178f6cd@brauner>
 <CZNSASBASJBK.R8MZW6X5VKMF@kernel.org>
In-Reply-To: <CZNSASBASJBK.R8MZW6X5VKMF@kernel.org>

On Thu Mar 7, 2024 at 10:01 PM EET, Jarkko Sakkinen wrote:
> On Tue Mar 5, 2024 at 2:27 PM EET, Christian Brauner wrote:
> > The vfs_getxattr_alloc() interface is a special-purpose in-kernel api
> > that does a racy query-size+allocate-buffer+retrieve-data. It is used b=
y
> > EVM, IMA, and fscaps to retrieve xattrs. Recently, we've seen issues
> > where 9p returned values that amount to allocating about 8000GB worth o=
f
> > memory (cf. [1]). That's now fixed in 9p. But vfs_getxattr_alloc() has
> > no reason to allow getting xattr values that are larger than
> > XATTR_MAX_SIZE as that's the limit we use for setting and getting xattr
> > values and nothing currently goes beyond that limit afaict. Let it chec=
k
> > for that and reject requests that are larger than that.
> >
> > Link: https://lore.kernel.org/r/ZeXcQmHWcYvfCR93@do-x1extreme [1]
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/xattr.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 09d927603433..a53c930e3018 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -395,6 +395,9 @@ vfs_getxattr_alloc(struct mnt_idmap *idmap, struct =
dentry *dentry,
> >  	if (error < 0)
> >  		return error;
> > =20
> > +	if (error > XATTR_SIZE_MAX)
> > +		return -E2BIG;
> > +
> >  	if (!value || (error > xattr_size)) {
> >  		value =3D krealloc(*xattr_value, error + 1, flags);
> >  		if (!value)
>
> I wonder if this should even categorized as a bug fix and get
> backported. Good catch!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

