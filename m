Return-Path: <linux-fsdevel+bounces-13300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F9D86E57F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0953DB250BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C7F70AD7;
	Fri,  1 Mar 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JTaTPEGd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T3A7wMC6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40DE70CD6;
	Fri,  1 Mar 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310317; cv=none; b=MtfmQGarCyWzWNtRaQ2xDi9sNZrLuHF5CaRwVyGWRayULiMRclG7p1NxevGsJ2xkiLS8LUlSII6vA1ghwn5dPbGdQsCZxWlhyKrCfImeQHJtK3/w5y7VYA8sIITD41hhs+QRE8uJ+XVULCkBthYxMxqEJTgmOnwKtBXgIenfs08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310317; c=relaxed/simple;
	bh=zdsoxAR0u7xZLMsoRTLV6upy9dWOwlfCW97GbZy8Jj0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ocnRp3CFVQXrTjJJaTxZZ2NcHk7Kg9Ea8LumfSSsf/3vU3FIyOZDRo/RG0MIeyFWnZ3p7Cf/rVtvtafDxWAGIyTY5FPothynpE+1eVBFLoXU1cQBfzF35OPnOCxtWrqbDhWfBIPCCc0TbgfFrorb+8keuwkhMa0M5CDTZHmUQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JTaTPEGd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T3A7wMC6; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id D7B561C000B4;
	Fri,  1 Mar 2024 11:25:13 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 01 Mar 2024 11:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709310313;
	 x=1709396713; bh=7FYsnNa7S2BwzvJdh3JiwcDDRSJ5qjwZbMWiux8ez0E=; b=
	JTaTPEGdPvMcmn4JZ7PRdjtR1/DefYt9W4EUZ/ZfVIC5/XxAJFJKiqNJaJozVmFU
	+tczDSxEZCtVqUO8nWB4iWUt8c8FpIsbLxPDuaJj28CKWlgVCF7pO26+8yza2Mhe
	nB8ZFWk5IhcLboUcM5d3mxAjzXO9dbE9G2p0GwgzWtU6te3VJ1xOvKiila+HLw3X
	8q4HSLB2UMzOCk6OrsXZokQG0+1KJTqv8beTStneqStpsqTZ09c0tGm6uzzCyM/R
	FE/5CACMmSUZPnr/4KJ4UwLJQI/PnNKx2IwqCrttBeMScZQ5iJJ8jVd5X644J+BG
	4irP5F1tJAptPi7k+25Uig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709310313; x=
	1709396713; bh=7FYsnNa7S2BwzvJdh3JiwcDDRSJ5qjwZbMWiux8ez0E=; b=T
	3A7wMC6gBEgSsx7ASIYyPzitavzzibvKMUp4BYW+K8DEwbSadGC2mcI7rceyX4Jv
	KyZWod8HCWSFmw25PB5so4uwfLUKj2TUsx0+Zqf1Wo7GEsupE5sLLQCoRTPEV/US
	jW/h4vESuoi1vOzf2T5SNX/VYipZKBupR8GsdSNHeQ9QUtbuDyqmAn4ZpS1lkyV8
	9y8YlIaErwoqjEaXtdO7TrsKKeFSkV5mzoM5d7NxM7aBKwkDtNNKmX4zCRxvcnll
	8H5mlVABxCXnNq3gWixZqO/qiU71fo892dqahLJSGbICIa5T91bBfFC6fidERFo2
	9q1A6VuqlvUjFzZp7ofpQ==
X-ME-Sender: <xms:aAHiZQSw4Jqmk12Krg7c8iNxAIBLNp-1OsF97EgpKYx1XK1xWraUPg>
    <xme:aAHiZdyldNOsE-lfAVkvi9GAOnARUB0cthgZtupyB5kK7n9JO4T9QNETcEj47UNUy
    EV_FPMZQD1VjuODcF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrhedugdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:aAHiZd2e3ntFLAHv-ZtQ2IZwGJ78XWs1GCrxPeKEC_WbGg47I29A_g>
    <xmx:aAHiZUCeIx_O1lT3cUu8DW76yjwD8bHMVCyekYUpvYoCidWPwzgRNQ>
    <xmx:aAHiZZilm-EH_fF_dls8Pso70y1Ix_g9HP1a2oiI61ttJ2Zcw7Xusg>
    <xmx:aQHiZUpXOKQfPDmmleSqr-2n4RQJnds8zyFi3wBmpCx0QIv0QhoFM6MBVOc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A48C2B6008F; Fri,  1 Mar 2024 11:25:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-205-g4dbcac4545-fm-20240301.001-g4dbcac45
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0d532558-0c47-4d1c-8b33-b1ff8f4846a5@app.fastmail.com>
In-Reply-To: <20240219183539.2926165-1-mic@digikod.net>
References: <20240219.chu4Yeegh3oo@digikod.net>
 <20240219183539.2926165-1-mic@digikod.net>
Date: Fri, 01 Mar 2024 17:24:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 "Christian Brauner" <brauner@kernel.org>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: "Allen Webb" <allenwebb@google.com>, "Dmitry Torokhov" <dtor@google.com>,
 "Jeff Xu" <jeffxu@google.com>, "Jorge Lucangeli Obes" <jorgelo@chromium.org>,
 "Konstantin Meskhidze" <konstantin.meskhidze@huawei.com>,
 "Matt Bobrowski" <repnop@google.com>, "Paul Moore" <paul@paul-moore.com>,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024, at 19:35, Micka=C3=ABl Sala=C3=BCn wrote:
> vfs_masks_device_ioctl() and vfs_masks_device_ioctl_compat() are useful
> to differenciate between device driver IOCTL implementations and
> filesystem ones.  The goal is to be able to filter well-defined IOCTLs
> from per-device (i.e. namespaced) IOCTLs and control such access.
>
> Add a new ioctl_compat() helper, similar to vfs_ioctl(), to wrap
> compat_ioctl() calls and handle error conversions.

I'm still a bit confused by what your goal is here. I see
the code getting more complex but don't see the payoff in this
patch.

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>

I assume the missing Signed-off-by is intentional while you are
still gathering feedback?

> +/*
> + * Safeguard to maintain a list of valid IOCTLs handled by=20
> do_vfs_ioctl()
> + * instead of def_blk_fops or def_chr_fops (see init_special_inode).
> + */
> +__attribute_const__ bool vfs_masked_device_ioctl(const unsigned int=20
> cmd)
> +{
> +	switch (cmd) {
> +	case FIOCLEX:
> +	case FIONCLEX:
> +	case FIONBIO:
> +	case FIOASYNC:
> +	case FIOQSIZE:
> +	case FIFREEZE:
> +	case FITHAW:
> +	case FS_IOC_FIEMAP:
> +	case FIGETBSZ:
> +	case FICLONE:
> +	case FICLONERANGE:
> +	case FIDEDUPERANGE:
> +	/* FIONREAD is forwarded to device implementations. */
> +	case FS_IOC_GETFLAGS:
> +	case FS_IOC_SETFLAGS:
> +	case FS_IOC_FSGETXATTR:
> +	case FS_IOC_FSSETXATTR:
> +	/* file_ioctl()'s IOCTLs are forwarded to device implementations. */
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +EXPORT_SYMBOL(vfs_masked_device_ioctl);

It looks like this gets added into the hot path of every
ioctl command, which is not ideal, especially when this
no longer gets inlined into the caller.

> +	inode =3D file_inode(f.file);
> +	is_device =3D S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode);
> +	if (is_device && !vfs_masked_device_ioctl(cmd)) {
> +		error =3D vfs_ioctl(f.file, cmd, arg);
> +		goto out;
> +	}

The S_ISBLK() || S_ISCHR() check here looks like it changes
behavior, at least for sockets. If that is intentional,
it should probably be a separate patch with a detailed
explanation.

>  	error =3D do_vfs_ioctl(f.file, fd, cmd, arg);
> -	if (error =3D=3D -ENOIOCTLCMD)
> +	if (error =3D=3D -ENOIOCTLCMD) {
> +		WARN_ON_ONCE(is_device);
>  		error =3D vfs_ioctl(f.file, cmd, arg);
> +	}

The WARN_ON_ONCE() looks like it can be triggered from
userspace, which is generally a bad idea.
=20
> +extern __attribute_const__ bool vfs_masked_device_ioctl(const unsigne=
d=20
> int cmd);
> +#ifdef CONFIG_COMPAT
> +extern __attribute_const__ bool
> +vfs_masked_device_ioctl_compat(const unsigned int cmd);
> +#else /* CONFIG_COMPAT */
> +static inline __attribute_const__ bool
> +vfs_masked_device_ioctl_compat(const unsigned int cmd)
> +{
> +	return vfs_masked_device_ioctl(cmd);
> +}
> +#endif /* CONFIG_COMPAT */

I don't understand the purpose of the #else path here,
this should not be needed.

      Arnd

