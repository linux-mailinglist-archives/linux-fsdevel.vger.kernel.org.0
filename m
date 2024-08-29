Return-Path: <linux-fsdevel+bounces-27789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B012C964084
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 11:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C7BEB21749
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 09:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C6A18DF6D;
	Thu, 29 Aug 2024 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="CGUJEOXp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Orpmas84"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC5148FF2
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924984; cv=none; b=GrbnimFtUmyqKviJARDaN5RZt2G5eao5sbnCdkHxFl+5L82HyxhxdIxd9wbZ+V/G+M9/UuYQiUhIy8yubS+RbvXHsEQW+Ala6sj8U17iN+6Nci8Ph8P9kJi64jt6FnnpOqcYAp7piBjf4WZmkn6AaLA1gR3rc+WyPP+gWlFKdkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924984; c=relaxed/simple;
	bh=+kYfoOFxM8O9BXRsL+ZUQgPZVCaeHuT/oa1HWjlIo7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uenc6Yez49sPPglJWVZ/x4GP3hCj/8IhTqYUXbmdfCVsFiudMsFej23pzsiAZAOX5o9S9WBP1hoYMT/h0S2aDkhK1qxOUYyuCZZI0AkwyqFPQEFE78xrwzOR1TzIpiYRK0u9FpJyaF8D7UlkRzWD3wcIoLqG3Xi+4M2+CuX1mMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=CGUJEOXp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Orpmas84; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 63AE31151C00;
	Thu, 29 Aug 2024 05:49:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 29 Aug 2024 05:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1724924981;
	 x=1725011381; bh=HeHift2BYC4X4UUYSnmoYk3MTX1Cv8O1uxt+++btpcA=; b=
	CGUJEOXpmR2CkF46PuZgWU7Af2Yk90f3V3wrEqTTiu9Xw2K4AySqWC9SGo7009Lg
	aLoNaxAqEMkJl7fkDRJRx+SUm5jkxDy/C+SEJoJvGHcaXeIbpkoGJkkMJNoFf2kN
	doLA6fi4g0LfV7/gnjaxSUkNlbMemDfn+ERH0EpiIb/wnqrJitMGEuhGwwrToAxB
	G/JRqhQXi+7ML4BZp8OeowMPx1wUCEbl5PIDwA1NkQMXDZG+AuU/MNWhWcrsHT0s
	b+DpK2IJQ8XKQR6f2oxa7OwPe++gYfAAcg1FoYrtNOZugbmB8fwrFr96azvCQ5/E
	NPAsxpaeF+O79ueqiwRy6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724924981; x=
	1725011381; bh=HeHift2BYC4X4UUYSnmoYk3MTX1Cv8O1uxt+++btpcA=; b=O
	rpmas84gze8j8GimaF80pgY2vQSF22VziNXa0HfOKuxdvfWMFVs67qgJjqDFTKbG
	+8Lmcx++VzgJI4P9RQcYXqYZgozCt2dgFLnddCufcOpE9/zrG3/Gk4S8GokjaEnL
	y9X1NyrLu1G8CZrsKZXLtk4Au+oHALBiB0QUjKu37P+Q1+ZlOOc/+b0Q6aXb4ycV
	aQGMBgJE+X+rZUaYteCNbmyRQk8zp01faD7xRkCkB6UKc58dS05RxYS4fncolbyJ
	e8M2OQWiAliGsnCizVi0ZzpWtyRdNgHXCW7inpOJEu/jfhV4iRtxfHthgToSW++p
	NqFtBARkohBvAExaaIERg==
X-ME-Sender: <xms:NUTQZo98IZraGWQ-ZJpYoSARiZjd88wPa2l25mvC9eGjJKy4LmZLyg>
    <xme:NUTQZguf9NMRwUzsKfJTuGlFNIqTWoREa8J-mQpzFj_dZKjR9IiNGglAQK284ncRE
    88a6v2Xx46wTu-N>
X-ME-Received: <xmr:NUTQZuDxjyUpwvNoZkbJCANbhk-FYEhMIdhJjNuDVGxvKJ77he7fu2auQFWfupo5jXot1QQTb3dVAsR0spNVdsaVgAEyil4iO1LLfg7V27WLsyhxtfyz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnheptddugefgjeefkedt
    gefhheegvddtfeejheehueeufffhfeelfeeuheetfedutdeinecuffhomhgrihhnpehgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdpnhgspg
    hrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhikhhlohhs
    sehsiigvrhgvughirdhhuhdprhgtphhtthhopehsthhsphdvseihrghnuggvgidrrhhupd
    hrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegurghvvghmrghrtghhvghvshhkhiesfhgsrdgtohhmpdhrtghpth
    htohepmhhsiigvrhgvughisehrvgguhhgrthdrtghomhdprhgtphhtthhopehluhhtohes
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NUTQZoeo_NC7S7v5BodfNDaN4KtZ0bil1Tt2ZFX9wkdzZkhUZRvQ4A>
    <xmx:NUTQZtPPtKX9JllKm51AzXGVUQaA4NULfWvnKes_THrwfwNlSrZ2mA>
    <xmx:NUTQZimrHhIyHnJxIDbJsy_l3nmPgBRya_CeqaoxTQKg85JzPkVDng>
    <xmx:NUTQZvtHPw8hYMfJ325ruuce1-HjVPXYgPMZ7gjrZDVmxF8E4xGo6A>
    <xmx:NUTQZpAjsyHlKsMJwS5d_uOiwkrECACpLLMUnATsPT452zTSkNXw77Yo>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:49:40 -0400 (EDT)
Message-ID: <28f37d0d-6262-4620-af89-b70ab982f592@fastmail.fm>
Date: Thu, 29 Aug 2024 11:49:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: permission problems with fuse
To: Miklos Szeredi <miklos@szeredi.hu>, stsp <stsp2@yandex.ru>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Dave Marchevsky <davemarchevsky@fb.com>, Miklos Szeredi
 <mszeredi@redhat.com>, Andy Lutomirski <luto@kernel.org>
References: <9fb28d29-d566-4d96-a491-8f0fbe2e853b@yandex.ru>
 <CAJfpegsbZScBZbN+iaydOD2SKPgfnfj4t=EJz8KyMBX5X3yJWQ@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegsbZScBZbN+iaydOD2SKPgfnfj4t=EJz8KyMBX5X3yJWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/29/24 11:38, Miklos Szeredi wrote:
> On Wed, 10 Jul 2024 at 21:55, stsp <stsp2@yandex.ru> wrote:
>>
>> Hi guys!
>>
>> I started to try my app with fuse, and
>> faced 2 problems that are not present
>> with other FSes.
>>
>> 1. fuse insists on saved-UID to match owner UID.
>> In fact, fuse_permissible_uidgid() in fs/fuse/dir.c
>> checks everything but fsuid, whereas other
>> FSes seem to check fsuid.
>> Can fuse change that and allow saved-UID
>> to mismatch? Perhaps by just checking fsuid
>> instead?
> 
> Use the "allow_other" mount option.
> 

Yeah, we had a long discussion here
https://github.com/libfuse/libfuse/discussions/991

