Return-Path: <linux-fsdevel+bounces-44174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE31DA64369
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 08:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8927A244A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 07:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC91219A76;
	Mon, 17 Mar 2025 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pRws42oh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CZz7qpwC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pRws42oh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CZz7qpwC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B82927701
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196132; cv=none; b=vGdOzqsWFDg1SnfYL0OsZ648zqL1bRPfZrXVCjZlhZiq4UPlXfggNUUsdHeQDcNs+1zy3YDKJ1bvVUFzaXZsSvQkptAyer6jZbDIVTFHJ8mNCtA2cTl+ejWp05iWw2rDjf/en7iHQKyfG4MC8OOc87/JxoTwxa+udu5v/JAcp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196132; c=relaxed/simple;
	bh=na5iEzdgMbdZx6uh00aocPoh6Q/aB/Toamhgrca8pOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVH2f0JSpm3B3VkDmzWGIntNmz0VDEbil9CVHDo80pXiPIvVVUxIMpyf3zjrieVU9PdoqyPlPjw2GKiVPZ8m9uQId7DHNmpsTqx7BbWDTbhnLZrc4ajh0lzHPs6LskR4t74/Q+CAWkgzfUTPekfIslkz1OlJybMvR0WdI46Hd60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pRws42oh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CZz7qpwC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pRws42oh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CZz7qpwC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A0EE1F7BA;
	Mon, 17 Mar 2025 07:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742196127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=na5iEzdgMbdZx6uh00aocPoh6Q/aB/Toamhgrca8pOA=;
	b=pRws42ohfs0XKP22s00aWNq7zNX/9MvjAZ77EdhALkPbK7jvhgyS2+HK3cUHH8OUDDRtci
	rTMGiQh72mtfoHyZLIJulRbnkMoW0MYAwjNKgIWliRicohUpDTrKm57IWFmVWcHeCeBJTh
	c+BioPRGYF+a82wZJ6loQCzRYhGtUIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742196127;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=na5iEzdgMbdZx6uh00aocPoh6Q/aB/Toamhgrca8pOA=;
	b=CZz7qpwCr/CtvdJG+p0TRBIQt+ux6t7fZDGy4NOqPImTlyPs5WWHcHhxH7oDUDaHL/gsm4
	Cs0Jl2RSCJ30gVBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pRws42oh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CZz7qpwC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742196127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=na5iEzdgMbdZx6uh00aocPoh6Q/aB/Toamhgrca8pOA=;
	b=pRws42ohfs0XKP22s00aWNq7zNX/9MvjAZ77EdhALkPbK7jvhgyS2+HK3cUHH8OUDDRtci
	rTMGiQh72mtfoHyZLIJulRbnkMoW0MYAwjNKgIWliRicohUpDTrKm57IWFmVWcHeCeBJTh
	c+BioPRGYF+a82wZJ6loQCzRYhGtUIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742196127;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=na5iEzdgMbdZx6uh00aocPoh6Q/aB/Toamhgrca8pOA=;
	b=CZz7qpwCr/CtvdJG+p0TRBIQt+ux6t7fZDGy4NOqPImTlyPs5WWHcHhxH7oDUDaHL/gsm4
	Cs0Jl2RSCJ30gVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 897BB132CF;
	Mon, 17 Mar 2025 07:22:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RgsaD5zN12d7ZgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 17 Mar 2025 07:22:04 +0000
Date: Mon, 17 Mar 2025 18:21:57 +1100
From: David Disseldorp <ddiss@suse.de>
To: Stephen Eta Zhou <stephen.eta.zhou@outlook.com>
Cc: "jsperbeck@google.com" <jsperbeck@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "lukas@wunner.de" <lukas@wunner.de>, "wufan@linux.microsoft.com"
 <wufan@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] initramfs: Add size validation to prevent tmpfs
 exhaustion
Message-ID: <20250317182157.7adbc168.ddiss@suse.de>
In-Reply-To: <BYAPR12MB3205F96E780AA2F00EAD16E8D5D22@BYAPR12MB3205.namprd12.prod.outlook.com>
References: <BYAPR12MB3205F96E780AA2F00EAD16E8D5D22@BYAPR12MB3205.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9A0EE1F7BA
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[cc'ing fsdevel]

Hi,

On Fri, 14 Mar 2025 05:04:58 +0000, Stephen Eta Zhou wrote:

> From 3499daeb5caf934f08a485027b5411f9ef82d6be Mon Sep 17 00:00:00 2001
> From: Stephen Eta Zhou <stephen.eta.zhou@outlook.com>
> Date: Fri, 14 Mar 2025 12:32:59 +0800
> Subject: [PATCH] initramfs: Add size validation to prevent tmpfs exhausti=
on
>=20
> When initramfs is loaded into a small memory environment, if its size
> exceeds the tmpfs max blocks limit, the loading will fail. Additionally,
> if the required blocks are close to the tmpfs max blocks boundary,
> subsequent drivers or subsystems using tmpfs may fail to initialize.
>=20
> To prevent this, the size limit is set to half of tmpfs max blocks.
> This ensures that initramfs can complete its mission without exhausting
> tmpfs resources, as user-space programs may also rely on tmpfs after boot.
>
> This patch adds a validation mechanism to check the decompressed size
> of initramfs based on its compression type and ratio. If the required
> blocks exceed half of the tmpfs max blocks limit, the loading will be
> aborted with an appropriate error message, exposing the issue early
> and preventing further escalation.

This behaviour appears fragile and quite arbitrary. I don't think
initramfs should be responsible for making any of these decisions.

Why can't the init binary make the decision of whether or not the amount
of free memory remaining is sufficient for user-space, instead of this
magic 50% limit?

What are you trying to achieve by failing in this way before initramfs
extraction instead of during / after?

> Signed-off-by: Stephen Eta Zhou <stephen.eta.zhou@outlook.com>
> ---
> =C2=A0init/initramfs.c | 162 ++++++++++++++++++++++++++++++++++++++++++++=
+++
> =C2=A01 file changed, 162 insertions(+)
>=20
> diff --git a/init/initramfs.c b/init/initramfs.c
> index b2f7583bb1f5..dadda0a42b48 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -497,6 +497,157 @@ static unsigned long my_inptr __initdata; /* index =
of next byte to be processed
> =C2=A0
> =C2=A0#include <linux/decompress/generic.h>
> =C2=A0
> +#ifdef CONFIG_TMPFS
> +/*
> + * struct compress_info - Describes a compression method.
> + *
> + * @magic: Magic numbers to identify the compression method (e.g., GZIP,=
 XZ, etc.).
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 Each magic number is a byte array of maxi=
mum length 256.
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 The first dimension (2) represents the nu=
mber of possible magic numbers.
> + * @rate: Compression ratio, calculated as R =3D (compressed size / orig=
inal size) * 100.
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0The value is in percentage (0-100).
> + * @mark: Name of the compression scheme (e.g., "GZIP", "XZ").
> + * @len: Length of each magic byte array. Used for comparison with memcm=
p.
> + * =C2=A0 =C2=A0 =C2=A0 The first dimension (2) corresponds to the numbe=
r of magic numbers.
> + * @magic_max: Maximum number of magic numbers supported (used when mult=
iple magics are possible).
> + */
> +struct compress_info {
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82unsigned char magic[2][256];
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82unsigned long rate;
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82char *mark;
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82size_t len[2];
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82size_t magic_max;
> +};

initramfs doesn't have much knowledge of underlying compression details.
This seems like a pretty significant layering violation...

> +
> +static struct compress_info cfm[] __initdata =3D {
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82{
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.mark =3D "Gzip",
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.magic =3D { { 0x1F, 0x8B } },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.len =3D { 2 },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.rate =3D 43,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.magic_max =3D 1,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82},
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82{
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.mark =3D "Bzip2",
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.magic =3D { { 0x42, 0x5A, 0x68 } },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.len =3D { 3 },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.rate =3D 22,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.magic_max =3D 1,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82},
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82{
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.mark =3D "LZMA",
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.magic =3D { { 0x5D, 0x00, 0x00 }, { 0xFF, 0x5D,=
 0x00 } },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.len =3D { 3, 3 },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.rate =3D 5,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.magic_max =3D 2,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82},
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82{
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.mark =3D "XZ",
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.magic =3D { { 0xFD, 0x37, 0x7A, 0x58, 0x5A, 0x0=
0 } },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.len =3D { 6 },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.rate =3D 7,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.magic_max =3D 1,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82},
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82{
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.mark =3D "LZO",
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.magic =3D { { 0x89, 0x4C, 0x5A, 0x4F, 0x00, 0x0=
D, 0x0A, 0x1A, 0x0A } },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.len =3D { 9 },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.rate =3D 47,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.magic_max =3D 1,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82},
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82{
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.mark =3D "LZ4",
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.magic =3D {
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82{ 0x04, 0x22, 0x4D, 0x18 },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82{ 0x02, 0x21, 0x4C, 0x18 }
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.len =3D { 4 },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.rate =3D 52,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.magic_max =3D 2,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82},
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82{
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.mark =3D "ZSTD",
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.magic =3D { { 0x28, 0xB5, 0x2F, 0xFD } },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.len =3D { 4 },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.rate =3D 7,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.magic_max =3D 1,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82},
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82{
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.mark =3D "None",
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.magic =3D {
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82{ 0x30, 0x37, 0x30, 0x37, 0x30, 0x31=
 },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82{ 0x30, 0x37, 0x30, 0x37, 0x30, 0x32=
 }
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.len =3D { 6, 6 },
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.rate =3D 0,

This will trigger a divide by zero below.

> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82.magic_max =3D 2,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82},
> +};
> +
> +static int __init validate_rootfs_size(char *buf, unsigned long len)
> +{
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82unsigned long i, j, result,=
 quotient, half_tmpfs_blocks;
> +
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82/*
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * Calculate how many block=
s are needed to decompress
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * and check if they are wi=
thin a reasonable range.
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 */
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82for (i =3D 0; i < ARRAY_SIZ=
E(cfm); ++i) {
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82for (j =3D 0; j < cfm[i].magic_max; ++j) {
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82if (memcmp(buf, cfm[i].magic[j], cfm[i].len[j]) =3D=3D 0) {
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82pr_debug("Compr=
ession method: %\n", cfm[i].mark);
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82/*
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * The calculat=
ion is divided into three steps:
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * 1. Calculate=
 the decompressed size based on the ratio.
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * 2. Check for=
 potential overflow risks and ensure that
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * =C2=A0 =C2=
=A0the temporary decompressed
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * =C2=A0 =C2=
=A0initramfs does not exceed the maximum range of 2^(32/64),
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * =C2=A0 =C2=
=A0ensuring that the initramfs size does not approach the
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * =C2=A0 =C2=
=A0memory addressing limit (this cannot be fully guaranteed).
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * 3. Determine=
 whether the required page size exceeds 1/4 of
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * =C2=A0 =C2=
=A0the total memory pages, restricting it from using excessively
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * =C2=A0 =C2=
=A0large amounts of memory pages.
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 *
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * Note1: Here,=
 `len` cannot be directly multiplied by 100,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * =C2=A0 =C2=
=A0 =C2=A0 =C2=A0as it may cause overflow.
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Dividing by `rate` first and then multiplying by 100
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * =C2=A0 =C2=
=A0 =C2=A0 =C2=A0can effectively reduce the risk of overflow.
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 *
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * Note2: Due t=
o integer division and rounding,
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * =C2=A0 =C2=
=A0 =C2=A0 =C2=A0the calculated size may deviate by a few MB.
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 */
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82quotient =3D le=
n / cfm[i].rate;
> +
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82if (quotient > =
ULONG_MAX / 100)
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82goto err_overflow;
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82else
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82result =3D (quotient * 100) / PAGE_S=
IZE;
> +
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82/*
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 * totalram_pag=
es() / 2 =3D tmpfs max blocks
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 */
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82half_tmpfs_bloc=
ks =3D (totalram_pages() / 2) / 2;
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82if (result > ha=
lf_tmpfs_blocks)
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82goto err_nomem;

See Documentation/driver-api/early-userspace/buffer-format.rst .
Initramfs images can be made up of several concatenated cpio archives,
which would throw off these calculations.

> +
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82return 0;
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82}
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82}
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82}
> +
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82pr_err("This compression fo=
rmat is not supported.\n");
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82return -EOPNOTSUPP;
> +
> +err_overflow:
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82pr_err("Decompressed size o=
verflow!\n");
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82return -ERANGE;
> +err_nomem:
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82pr_err("Decompressed size e=
xceeds tmpfs max blocks limit!\n");
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82return -ENOMEM;
> +
> +}
> +#endif
> +
> =C2=A0static char * __init unpack_to_rootfs(char *buf, unsigned long len)
> =C2=A0{
> =C2=A0=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82long written;
> @@ -504,6 +655,17 @@ static char * __init unpack_to_rootfs(char *buf, uns=
igned long len)
> =C2=A0=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82const char *compress_n=
ame;
> =C2=A0=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82static __initdata char=
 msg_buf[64];
> =C2=A0
> +#ifdef CONFIG_TMPFS
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82int ret =3D validate_rootfs=
_size(buf, len);
> +
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82if (ret) {
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82snprintf(msg_buf, sizeof(msg_buf),
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82"Rootfs does no=
t comply with the rules, error code: %d", ret);
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82message =3D msg_buf;
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82return message;
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82}
> +#endif
> +
> =C2=A0=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82header_buf =3D kmalloc=
(110, GFP_KERNEL);
> =C2=A0=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82symlink_buf =3D kmallo=
c(PATH_MAX + N_ALIGN(PATH_MAX) + 1, GFP_KERNEL);
> =C2=A0=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82name_buf =3D kmalloc(N=
_ALIGN(PATH_MAX), GFP_KERNEL);
> --=C2=A0
> 2.25.1
>=20


