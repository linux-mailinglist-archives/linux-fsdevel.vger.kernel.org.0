Return-Path: <linux-fsdevel+bounces-50552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CF5ACD27C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 03:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874313A32DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 01:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F244254B17;
	Wed,  4 Jun 2025 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="N7s3yaoR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WvWM/zjE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ABD25485A;
	Wed,  4 Jun 2025 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998691; cv=none; b=TXGQg+8++U+KpSRDNmei1mF/kvtOKL/x5R6eyt6TNeWsnz6BJbaaUEOB14vqLcXYcvWlFbGreQXLlNmHwqJLFuQfBrMg3z03LeuMukNifI0lmrQ/nwkuQJyGuHgPEAdl2e136l32wMjhGfJaM+6TV1wn5X1V8+x1bi+OMMezb/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998691; c=relaxed/simple;
	bh=ZQ9CNQfRvQo+6IJVUxmeQ6+mpkIr0qUa3ibDfRE2WBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0KRIkNGaKsl4gx9dBK6/43M4sKWOh1n6vywK4eonrj/JjzpGwd2o2JeaO6XmozNPgf92g9/eV01W9dCWJURPHinEUFikcRcd53iczc4cu+czRf6pQ9rGAJu1u01cGpbfNrTtSMp4iG1Xq1pHA5gmko7ItJWJ2ehVnHk3dllRaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=N7s3yaoR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WvWM/zjE; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 038C91D40416;
	Tue,  3 Jun 2025 20:58:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 03 Jun 2025 20:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748998687;
	 x=1749005887; bh=OhWKvrrfWc+QCsk08otnjEC9Xd+7wrAd0UMPz7P3EeM=; b=
	N7s3yaoRhksUGYG2yK2lNlT+fD6hhqL7OGA6mlb4MN43VGVlMQoM2Y0Hh15iUnLI
	OEZvnlfrDx2LYC/xoLh8xI2mTI+JInB+oO3bhPZt42r7qEvG+/Et8FeY6CI82g6J
	KSv7vgR2pWfP9iu7exjJdonsq63YerEYGl87dNBF4qIhQfK37O3ZYMFJJHRxat+H
	XPLEszet9rrJQZFwKNGJm7T9C/YOWhcxXOZ0SkK5uiISlSbBJWDXlJiAZWIiGOPh
	SlcMtdXZkC9ImiGcWyu+r9oMjBFF1LYSVjNnOOpsNLtbtQuVIFIpXCFKh4zDKAuO
	cRKcUYtQNtgv5m8mRdYaeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748998687; x=
	1749005887; bh=OhWKvrrfWc+QCsk08otnjEC9Xd+7wrAd0UMPz7P3EeM=; b=W
	vWM/zjEGau3zExyckS/V0haI6kWuFqiNmnXo/opBI0EvR3LHbE/s77jxlqsEQaDj
	fIEM+vR6FWjlYL/5yPjhb55RokhOYem0RgbAGSycfhMUF2BfJIAuzz7vEm4xeZOL
	TZV7AworKjyInCxxXEmt+T4l+rJ8lvqqsGdV480Q0c4KfYm+rggH89XCownHAtYv
	w+KTmOdAeRUZ21LtU9zjhWWqMjjZq4uR5GBN5vCfR5DxzGJD75HGE/o4xZHEVHu5
	PirKohysoYlga8MAxQ4uY4ocOMJ1RxYXs2FKu58uWa8xu5Dsn15bNaYi8y6ef2dB
	MHa6XhIT/+mpzd+ndF9Fg==
X-ME-Sender: <xms:H5o_aNwggxiRyCrmMFj4A6z7KJNqiIadaitXhsx9cA447r_b5s3SPA>
    <xme:H5o_aNTBIJo1KIu-DAm-PyuMs_9r1JpbTCrNgSLgYCA6xX0VSSkuSKUaqLqQdLaN6
    Dg4X3cwWYwCvDvY-XE>
X-ME-Received: <xmr:H5o_aHVX54xDyW8lOQG4YR7AZ0FaDyy549m1-4d4Fq6TMagXs_fPnjkROilpTLhE7Cr0Dp6xWcWHfyPR3rwuxq10>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqne
    cuggftrfgrthhtvghrnhepgeekffegffeuhfefiedtjeetueefleelfedugeekveffvddv
    jedtvddviefhgfejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhr
    ghdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhl
    ihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtph
    htthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhmpdhrtghpthht
    oheprghnughrihhisehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:H5o_aPjG0jG7eDRCe2MFl2due67zNnb_FPaWdHIGPR8914QILxbJ_Q>
    <xmx:H5o_aPBLZU5Y7e_Nzvim6qYoFnqNrsm80JbfJKUWguBcQ7gc58fwpQ>
    <xmx:H5o_aIKRgQXSR6vqAPZzo-Ey7bK7WHcbtlcFC0KntQIAfMWX9vt2Ew>
    <xmx:H5o_aOBRWxNy8dgozc2axM3RyM5JoZRzrakbSD-oI1iDx6ZaEJM-Pw>
    <xmx:H5o_aICZLF4GkLxFnzo2YnGWeCefZB_1bDEdO16sx48yCDqrR-AAzxZk>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 20:58:04 -0400 (EDT)
Message-ID: <fab63d7c-89e2-4c30-a685-0d623a05546e@maowtm.org>
Date: Wed, 4 Jun 2025 01:58:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
To: Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kernel-team@meta.com,
 andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, brauner@kernel.org, kpsingh@kernel.org,
 mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com,
 jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, gnoack@google.com
References: <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <20250529173810.GJ2023217@ZenIV>
 <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
 <20250529183536.GL2023217@ZenIV>
 <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
 <20250529201551.GN2023217@ZenIV>
 <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
 <20250529214544.GO2023217@ZenIV>
 <CAPhsuW5oXZVEaMwNpSF74O7wZ_f2Qr_44pu9L4_=LBwdW5T9=w@mail.gmail.com>
 <20250529231018.GP2023217@ZenIV>
 <CAPhsuW6-J+NUe=jX51wGVP=nMFjETu+1LUTsWZiBa1ckwq7b+w@mail.gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <CAPhsuW6-J+NUe=jX51wGVP=nMFjETu+1LUTsWZiBa1ckwq7b+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/30/25 01:42, Song Liu wrote:
> [...]
> On Thu, May 29, 2025 at 4:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> Note, BTW, that it might be better off by doing that similar to
>> d_path.c - without arseloads of dget_parent/dput et.al.; not sure
>> how feasible it is, but if everything in it can be done under
>> rcu_read_lock(), that's something to look into.
> 
> I don't think we can do everything here inside rcu_read_lock().
> But d_path.c does have some code we can probably reuse or
> learn from.

Note that I've made an RFC patch for this as I've also been looking into
this a bit earlier:

https://lore.kernel.org/all/cover.1748997840.git.m@maowtm.org/

I've CC'd some people here but not all, in the interest of not spamming
like 20 people, but feedback from all is welcome.  Mine is also its own
separate patch that shouldn't block Song's patch here, and I can rebase it
on top of (v2 or a later version of) this series once this is merged.

