Return-Path: <linux-fsdevel+bounces-72125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 590CBCDF45A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 05:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F365E300E14E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 04:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2A01F4262;
	Sat, 27 Dec 2025 04:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BjqGS3Op";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ixOxAC2C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7507E199E89;
	Sat, 27 Dec 2025 04:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766810715; cv=none; b=HMC0+hTXv+KbeWJSpD7Nw9BP1L/4y7X3RO7DktI9Tg+AzvVWtrU1gMEgZ/AiYd7ILRirPcGD1lZYt3ryfe0kdO0TUlYDo3DDhVp/Sjvxg2NcH0DT0xgSsxiYjq/ykMAaOIWdQi1eZHAeCpjVMQRv7X2USnXhYYGslqRtCOPSPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766810715; c=relaxed/simple;
	bh=5cYyPKKufrrIMYhelZziE0xdv4szxBax7YnXZPejygg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=dl5Td/Bnzz8GZfhjenoox/IApG9DaN8MKpGGmv9Q7yU8TpYYsJN73UiVuJZ1d9+40894hmrpQucu56ME3WbSYMZXEmxz3dlgi1mNTtSqBY1lQc6RhDDNJxaqt4vMBIWebIgitdFR+WH0PPRDi7UMAtpcD/YZwHw7g0/ODu2yrbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BjqGS3Op; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixOxAC2C; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 478941D0006C;
	Fri, 26 Dec 2025 23:45:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 26 Dec 2025 23:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1766810711; x=1766897111; bh=pMaRZPnQk+6ceSaEGN3UhiAG8o8DbrmjmSE
	turKEqMw=; b=BjqGS3OpqP1rwBBpyBcBVuz2pvaWoEY3EL7suVal9DeRb0y7eUn
	EWoRTGYbVCV3vfLjX828NAqiza03RcoCzR89FundC0GlpkFvlJJxEPcwhmtgi8ab
	3RgndMxN+N/HN4Pb/qDns2xhlTzCU+2pzX3SE9RhpHfD8WgSLpKFjyi5thHc3JxC
	TMJI7XLsQAlgwwKb2hsTYNOUhokZBC77LTz2rhaQIN+w9zGMFxNY4VBySLWB55On
	qz3iCTqiCBeNurhILwKDQ8mPErjT9KT2oBlqs/H8NVTFtXadleiNBdLxavZ9J2Uu
	BkZOIdzH/+2NGffVOeFPQMfI9BVyWi34GIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766810711; x=
	1766897111; bh=pMaRZPnQk+6ceSaEGN3UhiAG8o8DbrmjmSEturKEqMw=; b=i
	xOxAC2Cw7DibC6GrBubOfyYdZpOQaQLs5I0SaducCILBuQB2TXgN1PHJPqFWk+l1
	nLz0FBmrPOdPEkNuA4dj2PUyzh84gY2Bv1kbvu5VOypwMuppZd42oaICYsv0NNFn
	0uMn8ayaGSg5hQ5UDpIun6D0+0Bc8wzno0smidL2+pWSqJ5T1hP0SmqOCYTvICSO
	C3CAwZkV2ITx3IHlL+H9tq/KoxikQL/r1goQc+Y5j1KAHejNk9L9je36hvn/hEI/
	dLWmhmsN3x9akuM7Sprxp8CdKx/l3+/K0ZWD6/W7EK91v8uHlV1rt2PKxR8Q6cr3
	Y8DtMrM01Vp55yNNG1zyQ==
X-ME-Sender: <xms:VmRPaSx7VwbXudX6EkAv4gFoIM5sC5mUQOwFRTlYuiTM_X-awtouhA>
    <xme:VmRPaa3gRHieFligWxr33fy6PR4qV8hvIamgX9KGZuWDGKfd0popEb-MRhGtzmu5e
    2okDfvQcngqqFSaAFxx6MP8_VAIMtHyMSHxs5cYiWN2fzAAvA>
X-ME-Received: <xmr:VmRPaYxQUbDExqzChEU7twN7gPEf1sLKHhH4-D2gH75ICcTecSARUaIS2_w83bPIoSQKZS9KZxjm3_JaWa_DkaqaG7J2Sxjhq3cFeGs72Lyq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejtdegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhn
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehmjhhguhiiihhksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    sggrghgrshguohhtmhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghmihhrjeefih
    hlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:VmRPafUUgvqR1WW7efDKHT5yk0q2WPy87Ot6vz-bDUS4S7su3PZfeA>
    <xmx:VmRPaU_iMKwdRkG966m82wulaItAmrcrRtBh8VDvmz9ABFrCFxXeFw>
    <xmx:VmRPaSvN-TeCWM74sWFkhdoPus-5ZFJXt441XNRvExr-MZ4TWRiT7w>
    <xmx:VmRPaU1mFUVpFvAZqtUa8fw-VCilyuqSPo8QAkeweFxL76v37IFgKA>
    <xmx:V2RPaeu26t7w_t3ZE-lvbd3rdMDnwHJH60QOTjJKTFzN6YRmYNuaEgEb>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Dec 2025 23:45:07 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Bagas Sanjaya" <bagasdotme@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "Linux Filesystems Development" <linux-fsdevel@vger.kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Mateusz Guzik" <mjguzik@gmail.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Bagas Sanjaya" <bagasdotme@gmail.com>
Subject: Re: [PATCH 2/2] VFS: fix __start_dirop() kernel-doc warnings
In-reply-to: <20251219024620.22880-3-bagasdotme@gmail.com>
References: <20251219024620.22880-1-bagasdotme@gmail.com>,
 <20251219024620.22880-3-bagasdotme@gmail.com>
Date: Sat, 27 Dec 2025 15:45:03 +1100
Message-id: <176681070372.16766.3882354586761538831@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 19 Dec 2025, Bagas Sanjaya wrote:
> Sphinx report kernel-doc warnings:
>=20
> WARNING: ./fs/namei.c:2853 function parameter 'state' not described in '__s=
tart_dirop'
> WARNING: ./fs/namei.c:2853 expecting prototype for start_dirop(). Prototype=
 was for __start_dirop() instead
>=20
> Fix them up.
>=20
> Fixes: ff7c4ea11a05c8 ("VFS: add start_creating_killable() and start_removi=
ng_killable()")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  fs/namei.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index bf0f66f0e9b92c..91fd3a786704e2 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2836,10 +2836,11 @@ static int filename_parentat(int dfd, struct filena=
me *name,
>  }
> =20
>  /**
> - * start_dirop - begin a create or remove dirop, performing locking and lo=
okup
> + * __start_dirop - begin a create or remove dirop, performing locking and =
lookup
>   * @parent:       the dentry of the parent in which the operation will occ=
ur
>   * @name:         a qstr holding the name within that parent
>   * @lookup_flags: intent and other lookup flags.
> + * @state:        task state bitmask

I would really rather the doco comment was moved to be before
start_dirop(), and left unchanged.

Otherwise we would really need to actually docoument "@state", not just
add vague words to shut the checker up.

There was already been a patch posted to do this.

NeilBrown


>   *
>   * The lookup is performed and necessary locks are taken so that, on succe=
ss,
>   * the returned dentry can be operated on safely.
> --=20
> An old man doll... just what I always wanted! - Clara
>=20
>=20


