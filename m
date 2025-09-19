Return-Path: <linux-fsdevel+bounces-62205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72CFB88490
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 09:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028F67C5782
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 07:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A522EB866;
	Fri, 19 Sep 2025 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="uXIO/rdj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83272EAD13;
	Fri, 19 Sep 2025 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758268458; cv=none; b=TI+d4KsBzQPJUsGEJpG78S52e0zKE0fJtiun5CrOZTmuKOJpOrKHWL/QgxyTbiskU+qLiyZdqexaO3AMrKNGCOeLZBbwgOjl4cc2inOgH99DkZPdwDLJObc2M8D0dWhv8eKEVyZxsq8OaK8VDJlLpPdCbn9OAAPNmA5cEPqSrqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758268458; c=relaxed/simple;
	bh=75n6SNqaNnGpdqrhOoCTwrIeBO+OZXMa5XD33nnFx+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZFdGxSRUzKMAF1PoXpjOQIsRbrQ5J4d25KM92ioWI8o6Y83osSb4UE5ZqtxQk8pkwtj6mdp6SeP9wye+aED/Iu3hrP1SjCOOSDfFEW5owJ/t33xnixQ9ySdwbsAdVZEWIXB6XPmmXC7LPKn49KW9hrAX3J7LOu6E9ig9UTyvvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=uXIO/rdj; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4cSlBj6z40z9y1q;
	Fri, 19 Sep 2025 09:54:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758268446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=75n6SNqaNnGpdqrhOoCTwrIeBO+OZXMa5XD33nnFx+4=;
	b=uXIO/rdjJd8hAI4ksLQBu8+7wi4x4K7rnQG7tMImo/Eqm4WU4PrJVe5qfblfySMVQYu3gO
	MXau2mxhwiQcpDy9wY9syjmJqOzVAx7fG+/SiXj1Ug4FWNg52TJGBqiIl7c0kOteM35Xvt
	/Hha3eAScpISlafD9pxujFgjaCIXjv3M3MOygsVz628T/e77r4bjkVTDVJOxYW7BjLWVJe
	+4zVTVv6uuTGWvabcw0N8JtIVIAE/TlzIVe7M2hTi0cgncJln/fsZcmZzrx/2zS4xP5USD
	vWcl0OPdWmGQQreR0GIobMcPUGVwknJINFwa3veeegPh2FwJXJlgKkEjkU1TCw==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fuse: Use strscpy instead of strcpy
In-Reply-To: <CAJfpegvt8ydN0uKYpbWVAmzZtHJ2kg3PwffZYvB33G_4fnq7BQ@mail.gmail.com>
	(Miklos Szeredi's message of "Fri, 19 Sep 2025 08:43:22 +0200")
References: <20250917205533.214336-1-mssola@mssola.com>
	<CAJfpegvt8ydN0uKYpbWVAmzZtHJ2kg3PwffZYvB33G_4fnq7BQ@mail.gmail.com>
Date: Fri, 19 Sep 2025 09:54:03 +0200
Message-ID: <87qzw2ubc4.fsf@>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

Miklos Szeredi @ 2025-09-19 08:43 +02:

> On Wed, 17 Sept 2025 at 22:55, Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssol=
a.com> wrote:
>>
>> As pointed out in [1], strcpy() is deprecated in favor of
>> strscpy().
>>
>> Furthermore, the length of the name to be copied is well known at this
>> point since we are going to move the pointer by that much on the next
>> line. Hence, it's safe to assume 'namelen' for the length of the string
>> to be copied.
>
> By "length of a string" usually the number of non-null chars is meant
> (i.e. strlen(str)).
>
> So the variable 'namelen' is confusingly named, a better one would be nam=
esize.

That's a good point. If you want I can add a commit renaming this
variable for v2.

>
>>
>> [1] KSPP#88
>
> I don't understand this notation.

This is because it refers to an issue on Github that is tracking the
effort to move away from strcpy in favor of strscpy. I've seen many
commits tracked there that followed this notation and thus I thought
that was the right thing. Anyways, if you want I can transform this
into a Link tag:

Link: https://github.com/KSPP/linux/issues/88

Or otherwise reference it in any other way you feel is more appropiate.

>
> Patch itself looks good.
>
> Thanks,
> Miklos

Thanks,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjNDBsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZUQMD/sETJCe5/FjU3UHVw6VVqw4o/WTF3SFwH3i3akjwR3AyR57/mkry5NaBBVz
rVTKi99cGVSmozqFOzEBqOybJfRl1yFQBtVGhqnIDUK+cieZGBMrhxRJBEULoCSx
yrc3wQM70JO6EkzxEvvqO36eY5crOJe7MEfxf/ozKqhYNoSP+iJUlie/umJkBm6q
yDVwd1IL+rKhQMilxd7VhCQpzqxRKCGl4GwGS18iScTymrMFhMBwdH1Nn9EFanym
7Fi41xUBBFttNPp3rblBnW8C2fPi6cgz59hf1lhvb2mwM46P8DwUfCpLavq5zRmR
9ilRFiX75EgOE2nza5VstSr4cvVV4hQiBEvVFZg1mI8pscgOaxGSbRG0/CUz10Z3
hxeB2GSIALmzUOmMYcDe1EXLO7jUuVsWeH34vplRU5qnV+HzZlDUBTi2vA0kX5MZ
TDzzNfH2SfgYO9Bv5H9bITPntIuY+GGb4c8s0ZkOD/ZRL7RSczOA1kBo20kqnDmV
GEohj5VyEF55JVBD/He0oke7XoXjjLjBC1SaBZ9vgJQ/sJYaHYh60dc/VODQtIUl
47wRmVRPpx8Z1ifMexPrkyaBXiRFzfPvlZgg90wSpiJ2tSbmzjY8ZP6ubB5zd7SQ
SGwqpuEEMMG+nee3NKT4cc6+bmIzc8bRrg1w8sPwHRuJCju6wg==
=21PN
-----END PGP SIGNATURE-----
--=-=-=--

