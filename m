Return-Path: <linux-fsdevel+bounces-25313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1792D94AA75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67176B28766
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4664B82C63;
	Wed,  7 Aug 2024 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETRb7TJ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF3F82862;
	Wed,  7 Aug 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041426; cv=none; b=ffRjW59/t2ZR5On7vFmA4UiuUhNPsxEv5FdqEtwsp5jY+VlcglEyOqTm2aXNsKWfYGtqS/RfPihy242vPkQ7LA/JMAwNKYPqQ6VfhkZfyiefVerb4ivzIGQKoGxPM3aFqqMTYyRgmwMugyJrJG610zc5ndH+Y8yqOtv5VgnsgMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041426; c=relaxed/simple;
	bh=yglhBzKi3NcaNGNFvbg8JxrI+mqUfjwDOqRUe/qh52k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RYT8CdASyQozv19lQ4az/t+bw/il1Xi7gprye37YtowTvqH8aqxgX6aZK1ImES4aqXIbp2iBrvmMXmG2tbYPRqu+Qm64xpF58+UMETnJI5qVcC+VPqu0gN1e1JpWBRKDqVnNddbvApKFepHvzNZIDpvEQYe3/T5ValP7UwkZk8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETRb7TJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56210C4AF19;
	Wed,  7 Aug 2024 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723041426;
	bh=yglhBzKi3NcaNGNFvbg8JxrI+mqUfjwDOqRUe/qh52k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ETRb7TJ+h08Hf+sfFv3QS+DAyOIYGB+YBdE4R3ZhjQLaG+naqvrcnWCfNmMElRvi3
	 zIBsE1vyGeG0V8YsNojSK7KimkPEqn/m1VYhPRIMnhkNFgyiQKTjYsDBJsxyh4cwSu
	 /xFgWRu+jo75cCpFr6RGzLViXcnLZZGgkyeqKYJnU74PAwBIxNHBfIZl2+LK0K88xP
	 zRiFgHzF5u5xF4gdFYNScPWfanJhzb+ynR5dVy29IFd5HhSE9XWx/IFV7zm72znrvr
	 /FEfz6+Qu41bF3RM3slDJwOZXxTcNtrVMptvHftQgSim9OAr7kYFqm5dLwzbHMh+Ic
	 yBBmzWXBS2JCA==
Message-ID: <d682e7c2749f8e8c74ea43b8893a17bd6e9a0007.camel@kernel.org>
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, Mateusz Guzik
 <mjguzik@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 07 Aug 2024 10:36:58 -0400
In-Reply-To: <20240807-erledigen-antworten-6219caebedc0@brauner>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
	 <20240807-erledigen-antworten-6219caebedc0@brauner>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxw
 n8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1Wv
 egyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqV
 T2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm
 0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtV
 YrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8sn
 VluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQ
 cDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQf
 CBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sE
 LZH+yWr9LQZEwARAQABtCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIg
 UCWe8u6AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1
 oJVAE37uW308UpVSD2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOT
 tmOdz4ZN2tdvNgozzuxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+
 9eiVUNpxF4SiU4i9JDfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPc
 og7xvR5ENPH19ojRDCHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/
 WprhsIM7U9pse1f1gYy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EB
 ny71CZrOgD6kJwPVVAaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9
 KXE6fF7HzKxKuZMJOaEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTi
 CThbqsB20VrbMjlhpf8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XR
 MJBAB/UYb6FyC7S+mQZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-07 at 16:26 +0200, Christian Brauner wrote:
> > +static struct dentry *lookup_fast_for_open(struct nameidata *nd, int o=
pen_flag)
> > +{
> > +	struct dentry *dentry;
> > +
> > +	if (open_flag & O_CREAT) {
> > +		/* Don't bother on an O_EXCL create */
> > +		if (open_flag & O_EXCL)
> > +			return NULL;
> > +
> > +		/*
> > +		 * FIXME: If auditing is enabled, then we'll have to unlazy to
> > +		 * use the dentry. For now, don't do this, since it shifts
> > +		 * contention from parent's i_rwsem to its d_lockref spinlock.
> > +		 * Reconsider this once dentry refcounting handles heavy
> > +		 * contention better.
> > +		 */
> > +		if ((nd->flags & LOOKUP_RCU) && !audit_dummy_context())
> > +			return NULL;
>=20
> Hm, the audit_inode() on the parent is done independent of whether the
> file was actually created or not. But the audit_inode() on the file
> itself is only done when it was actually created. Imho, there's no need
> to do audit_inode() on the parent when we immediately find that file
> already existed. If we accept that then this makes the change a lot
> simpler.
>=20
> The inconsistency would partially remain though. When the file doesn't
> exist audit_inode() on the parent is called but by the time we've
> grabbed the inode lock someone else might already have created the file
> and then again we wouldn't audit_inode() on the file but we would have
> on the parent.
>=20
> I think that's fine. But if that's bothersome the more aggressive thing
> to do would be to pull that audit_inode() on the parent further down
> after we created the file. Imho, that should be fine?...
>=20
> See https://gitlab.com/brauner/linux/-/commits/vfs.misc.jeff/?ref_type=3D=
heads
> for a completely untested draft of what I mean.

Yeah, that's a lot simpler. That said, my experience when I've worked
with audit in the past is that people who are using it are _very_
sensitive to changes of when records get emitted or not. I don't like
this, because I think the rules here are ad-hoc and somewhat arbitrary,
but keeping everything working exactly the same has been my MO whenever
I have to work in there.

If a certain access pattern suddenly generates a different set of
records (or some are missing, as would be in this case), we might get
bug reports about this. I'm ok with simplifying this code in the way
you suggest, but we may want to do it in a patch on top of mine, to
make it simple to revert later if that becomes necessary.
--=20
Jeff Layton <jlayton@kernel.org>

