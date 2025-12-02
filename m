Return-Path: <linux-fsdevel+bounces-70491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EB10DC9D527
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 00:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65F3434AB8A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 23:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCD32DF148;
	Tue,  2 Dec 2025 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="dleQLdAI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vTCJjLRn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B50277CAB;
	Tue,  2 Dec 2025 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764717610; cv=none; b=XSHN/Q3n1P/y0uEe9j1PGjZm3P5dov0b/hRFeBFyWM5vuaxrEcZCvDJn4viHQm+MtwepujiC9B1NbxxRJbaGRabJFVwEnZvAOyA9JH6nsLhSvmZDK8N0ZFG6somul+3nsTVoWMH4Q5nBus07FT2amW5mLP/gm8OSwOFzUZZuIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764717610; c=relaxed/simple;
	bh=edI4d9qHYzaC7A1uIs3OVxxQyZtE7XKVHXn8Hid31D0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nIiFlA71EFpbrVhvlCVDvoWRd3I043+rgnLOF7r4Jc/BQIzfwzjv138NJrmmM6iYfOBtbk4mGcexa7vj7+4KNIyY9wzZWSANleM2fUKfHhmsazYF9g0n8kmWEYBlPxNJ5QZtLeBZaO/aN8TeSCeG3Q3RlD0TutkjENKqlYs1tCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=dleQLdAI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vTCJjLRn; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C608F7A0160;
	Tue,  2 Dec 2025 18:20:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 02 Dec 2025 18:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764717606;
	 x=1764804006; bh=DcFhDwVzafijKyhytfagvSgPb5nYeOU/GhD3IJcVcAg=; b=
	dleQLdAIYGWtnXYAbrZ17+g7uRsZPLJlN6Ce6eEKHNcdxq7LUSQAw5FOXm4YCy2/
	kbjJECkAP9yXAhDXUGN059uoDurQo89z643ApriRS95uNmjP1XtpPRDhYT7kP3tV
	s5HTcCOxWXcJ6XTmhDiiV1vPFjGlFaLEZazc+ryXWEE8c4xHhoIW0wUpxH5aJ7uT
	XY8kZfGyU6M95/AY0dQPWCUkPbd6HsQreBIAeml0EC89b7ioAAQeIyCdgkX7LR4x
	9wj5nfbcESxw7DeMdNy0Vo7Z/m2z2AH8I3Dik1DI2RjwG+/xJ7gRPlNRr2lfqMGe
	WBmHbQGclQuf+gLOknPg/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1764717606; x=1764804006; bh=D
	cFhDwVzafijKyhytfagvSgPb5nYeOU/GhD3IJcVcAg=; b=vTCJjLRnTrUmFWP5u
	Klw2SVsM+wa+2CLJDIm9j7RtIs1UsUMmSHCvw5dT/0PYH9S5wGNYN9WXs1iqrv+l
	SLXMhtydcj2AebmbJu3iTziCE+HUxLBm18lK33OWcGd+Mt4G0mxWtSWaNlI3/EiY
	KA2BfELKsJ0JWl70VJ1uyidzMrgRKtxfAONPmNeCHhFdJMXesJDCnjnGlM15a/Ia
	41egXewQrUPUYsRWgv2fWb0yz6oLG6D70/E2h+bH27zb1K+rqXF23fFZdauzRUEp
	JshuzceEHXz10hxP0iTYFxkOKhswNqVPx59SCliXJKG3xTFZq7k25L4NmrqO3ubb
	8igAg==
X-ME-Sender: <xms:JnQvadkTIQVASresze7gcQn4Bh9pWOLsG4jYPCWOMQi_wahpxhjvfQ>
    <xme:JnQvaSLZ40T0aE5W_PiiyZi4Ypgpdvt10rFr_s2Y-LG9pwFKvjWpZKs1wGxbhzfQm
    qJWydzDceJ4fEFk530FGAb2DgjcjTBncj32TGmxPwVBR2QT>
X-ME-Received: <xmr:JnQvaa7O5ReneGXoQGOzH2M5JW58ukHLW7ZCTK5jEHuK7jC5niGsW075GeOoIC5CJRKOSPhadJcq70zyjDEoX3HqFZOz_4Iopwp-WYDCCDFzgV6ZdsiUgVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkfffgggfuffvfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcumfgvnhht
    uceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpeejueeute
    ffueegjeehkeetiedufeehvdehteejtdejteelleehkefgfeefuedtgfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmh
    grfidrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhose
    iivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegruhhtohhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JnQvae1yIaD4poPGBihMn_dtuUXl_M0rVncvvgu5GV3TohYl-BJK7A>
    <xmx:JnQvaYdTA8IRbDb4gIwKFoU3AcpdbykEjNxT1dNkI41sHUP9ef3xIQ>
    <xmx:JnQvacfet6kRYzZifQrQ8EVoTkRu3xIqJz9KU3ni3uy3QWfdeoGDww>
    <xmx:JnQvabyAKFL5mfm4Rvphy0qPIJulCpWgNZYtmWK6jWJ7kdvvw5eRBA>
    <xmx:JnQvaQQVdS96ku39w7-ibl2wFvnBz9wupOFjO05xxOlnF9D663ZtsIUz>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 18:20:04 -0500 (EST)
Message-ID: <ff0846cf-5226-466c-ac92-545c070fffd9@themaw.net>
Date: Wed, 3 Dec 2025 07:19:59 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] autofs: fix per-dentry timeout warning
To: Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@ZenIV.linux.org.uk>, Kernel Mailing List
 <linux-kernel@vger.kernel.org>, autofs mailing list
 <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20251111060439.19593-1-raven@themaw.net>
 <20251111060439.19593-2-raven@themaw.net>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20251111060439.19593-2-raven@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Christian,


Sorry to bother you but did this one get missed due to

the distraction of the discussion about patch 2?


Ian

On 11/11/25 14:04, Ian Kent wrote:
> The check that determines if the message that warns about the per-dentry
> timeout being greater than the super block timeout is not correct.
>
> The initial value for this field is -1 and the type of the field is
> unsigned long.
>
> I could change the type to long but the message is in the wrong place
> too, it should come after the timeout setting. So leave everything else
> as it is and move the message and check the timeout is actually set
> as an additional condition on issuing the message. Also fix the timeout
> comparison.
>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>   fs/autofs/dev-ioctl.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
> index d8dd150cbd74..8adef8caa863 100644
> --- a/fs/autofs/dev-ioctl.c
> +++ b/fs/autofs/dev-ioctl.c
> @@ -449,16 +449,6 @@ static int autofs_dev_ioctl_timeout(struct file *fp,
>   		if (!autofs_type_indirect(sbi->type))
>   			return -EINVAL;
>   
> -		/* An expire timeout greater than the superblock timeout
> -		 * could be a problem at shutdown but the super block
> -		 * timeout itself can change so all we can really do is
> -		 * warn the user.
> -		 */
> -		if (timeout >= sbi->exp_timeout)
> -			pr_warn("per-mount expire timeout is greater than "
> -				"the parent autofs mount timeout which could "
> -				"prevent shutdown\n");
> -
>   		dentry = try_lookup_noperm(&QSTR_LEN(param->path, path_len),
>   					   base);
>   		if (IS_ERR_OR_NULL(dentry))
> @@ -487,6 +477,18 @@ static int autofs_dev_ioctl_timeout(struct file *fp,
>   			ino->flags |= AUTOFS_INF_EXPIRE_SET;
>   			ino->exp_timeout = timeout * HZ;
>   		}
> +
> +		/* An expire timeout greater than the superblock timeout
> +		 * could be a problem at shutdown but the super block
> +		 * timeout itself can change so all we can really do is
> +		 * warn the user.
> +		 */
> +		if (ino->flags & AUTOFS_INF_EXPIRE_SET &&
> +		    ino->exp_timeout > sbi->exp_timeout)
> +			pr_warn("per-mount expire timeout is greater than "
> +				"the parent autofs mount timeout which could "
> +				"prevent shutdown\n");
> +
>   		dput(dentry);
>   	}
>   

