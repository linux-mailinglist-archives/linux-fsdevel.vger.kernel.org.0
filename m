Return-Path: <linux-fsdevel+bounces-25538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 243AD94D2E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 17:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C56281A6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65967197A72;
	Fri,  9 Aug 2024 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbgVgRUt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C235D155A25;
	Fri,  9 Aug 2024 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215956; cv=none; b=MBSYf+9i1G6QvBadgyelNBJkQ8x7DP0zDHh6Qu5BygWXGsyrvWcyC5E8kFZPkFxIaZB+782ju25/VSkflaVSZexPHrvmVQ02BwXy25vMWn4WkDof2f2FGFMfgNE01G3NAPedMvZVORkYV1B5e+ZdV1PBops9YM+O7B+ntL6SbMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215956; c=relaxed/simple;
	bh=7qDlyyI8Jx84O+NvDkukMrDOqIIur+2yKj4WcB2YsV0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=orQtP/VA/rau3SOBC78XjLM1iq8KUETQI6gYHr/3O/OJrtMvyK6EJou4CSRQ6wb32FSJn+G8vT/POw+2ZsBn9pT9810aAq7+RZeNYvMIJL5MqE3SnswmjMTRZiZ5mHLejPISJZ051j+o6GckOmGOozotcfNr6cq2gcl2A4UhNk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbgVgRUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3366C4AF0B;
	Fri,  9 Aug 2024 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723215956;
	bh=7qDlyyI8Jx84O+NvDkukMrDOqIIur+2yKj4WcB2YsV0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QbgVgRUtZRO0Qt0o9vrmJRqL4EONm0x7Smr6jWITS6bkoGVBHsGRrRm0lmorz1vfu
	 RvRAwVGSmfYHPNJpmkJaRLZARcj3mvTp8k95YTQIIgNR/40RJw4cmxkpUfEcVaFt3+
	 Yf6T+1Mw5pc7skPTPKP7NB94RaBeY4tvsVK1RXK5ySU3GsAikg7pGyBq2q0tuJW247
	 egT36NMDrEe9YsXpPecm6JQIf/V8qmhlS43wacZcZBKaSl/RJhHnSHzejiMzPZrx9v
	 9OkxrRGonDIeiJtTnYoH6zoB+nCzdETX1cWcvd/+vVGAd9GR9heoPrs9bDZbm1BG6s
	 zWSp/Fg3slXDA==
Message-ID: <96dd05ee4ec91ea4ee25e1af395975d37893fcfc.camel@kernel.org>
Subject: Re: [PATCH] fs: don't overwrite the nsec field if I_CTIME_QUERIED
 is already set
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 09 Aug 2024 11:05:54 -0400
In-Reply-To: <20240809-ausrollen-halsschlagader-02e0126179bc@brauner>
References: <20240809-mgtime-v1-1-b2cab4f1558d@kernel.org>
	 <20240809-ausrollen-halsschlagader-02e0126179bc@brauner>
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

On Fri, 2024-08-09 at 16:55 +0200, Christian Brauner wrote:
> On Fri, Aug 09, 2024 at 09:39:43AM GMT, Jeff Layton wrote:
> > When fetching the ctime's nsec value for a stat-like operation, do
> > a
> > simple fetch first and avoid the atomic_fetch_or if the flag is
> > already
> > set.
> >=20
> > Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > I'm running tests on this now, but I don't expect any problems.
> >=20
> > This is based on top of Christian's vfs.mgtime branch. It may be
> > best to
> > squash this into 6feb43ecdd8e ("fs: add infrastructure for
> > multigrain
> > timestamps").
>=20
> Squashed it. Can you double-check that things look correct?

One minor issue in fill_mg_cmtime:

-------------8<-----------------
        if (!(stat->ctime.tv_nsec & I_CTIME_QUERIED))
                stat->ctime.tv_nsec =3D ((u32)atomic_fetch_or(I_CTIME_QUERI=
ED, pcn));
        trace_fill_mg_cmtime(inode, &stat->ctime, &stat->mtime);
        stat->ctime.tv_nsec &=3D ~I_CTIME_QUERIED;
}
-------------8<-----------------

I'd swap the last two lines of the function. We print the ctime in the
tracepoint as a timestamp, so if the QUERIED bit is present it's going
to look funny. We _know_ that it's flagged after this function, so
leaving it set is not terribly helpful.

--=20
Jeff Layton <jlayton@kernel.org>

