Return-Path: <linux-fsdevel+bounces-50935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE31AD13D3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 20:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F40AF7A4CA2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 18:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ED51D5154;
	Sun,  8 Jun 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="kMUkXmV8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SB20Qrrq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB43B1373;
	Sun,  8 Jun 2025 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749408322; cv=none; b=HDn1YDT5S4xCrGa/vcTu9wPYGUtiP5Gmwb3fwJYl+K+f4YJq6dEDg6xBrNSK7sgX2p+MQU5Kyc+ei/IX/NG4/vY0qAzxklqhuyJr8bqIgo4FfiRNUMl19BBrB7BkrL0bDFp2qxIvH+m5KJz6W6H873u/Q2xx5vQNhLe2sgkpICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749408322; c=relaxed/simple;
	bh=jpY6WF/tyt8ZsPJiNzCryKKly+ppwn8MYx1ZpTHcCgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AesIm6umFBGxn+2gH1iw5/1poIuSiPY5cY20RS9klLAsFcOnFi32mnftAqjziVTe1sBF+cIzeTrXOSIDdt+g88NSiGgsmGa+BwTLuoZYAxN4m/FsONazfHQPkWf3rxTMOP0K0QN8Rhpw/I0Jv6n9eAGSYBDcEYyt6Ei4fkV3vYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=kMUkXmV8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SB20Qrrq; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id B0C602001E3;
	Sun,  8 Jun 2025 14:45:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 08 Jun 2025 14:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749408317;
	 x=1749415517; bh=pyrxZyuzA0cB9TzK2o1GmFpNIisvskLmghcpCRapKuw=; b=
	kMUkXmV8EzPikhkBJFVGnuS2wjWadeQwnEeO8kvDsxqi1B3KOiEmaCMg8Na/AyDY
	O2WTnl0Jk2J/jEU+O+6wh0ZEaQAs/ozWfCMvy8q7QWlrbpIbG5XRgt79h5Q8ay2W
	6SxSUbcv9H8UeMJeBC4ruQXNvgtx37voEedgebrNaIgyjD+xnik2rtywBsMqf4o6
	qY26eFDPG8SMurYooUA73L3m8BPwAK3+oYwCU820KpHaaMls5gi4H1l3gTHgRgLu
	ccHRt72DxBAyGdX+yBaV5lRfOKgmtJ1jg31NJBVGmF4n2HfH/C4etpp19GF3Sk6P
	pNbKDCs/Yv26hg6/vl1s8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749408317; x=
	1749415517; bh=pyrxZyuzA0cB9TzK2o1GmFpNIisvskLmghcpCRapKuw=; b=S
	B20Qrrql1HNlKE1ptu8rl23aoSFI6mz0aVxTbs4CVsBgaDV2SohoAV+10qivzr7e
	r1O+psm6WbxtSCY1VNQYODT0sZwl20ZVKVlhAe904CgutowEqCPUayuu/0ghy06h
	dwdCRAw1wS+7BKynxI96fQfosh0UZVV4ef8PBlZFuqSMyX2V11zOdbfCUNaafUOq
	ZRbuyqSoQzB4E5NHVuzZu8oo0yAimfOITw8KwY+W4eslcF/pQhU5tTHdiZoEk5m8
	atuzBHe8bnvBFLVrUoX3Ldhr+gGMmK+KdSvtiG7HVLe8RL7NvqPdlgK6sYTkH9hw
	WjhmTD7d2mM2ty8LVvd/Q==
X-ME-Sender: <xms:PNpFaHYshTA3LU5gNz43Nj_WBEJrsG8Iwd3h7mEg3mm6WYYNOzvQpA>
    <xme:PNpFaGYOZOf4xu9iTv7sKvajyvvha3dPrAOkz7cj48MdK2tdJHDv2N_I6STGnCoZG
    nkgpBnDkp2dLA-E_GQ>
X-ME-Received: <xmr:PNpFaJ8d8htT03ZwUBUKVK6O6wK4_nm4XFMVxB1WnpY2XKYF9Berg4vzYRNx0ZaVNqVf7d5TCFRFY7ec3p2J-jfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdekvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqne
    cuggftrfgrthhtvghrnhepfedvheeluedthfelgfevvdfgkeelgfelkeegtddvhedvgfdt
    feeilefhudetgfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopedvvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepsghpfhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvtghurhhith
    ihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghr
    nhgvlhdqthgvrghmsehmvghtrgdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:PNpFaNriKuIzFK9kRzEYtsir3VqqWPxxbJAXix0gL3l9wlgw6H8p2Q>
    <xmx:PNpFaCo3Tj1OngIRGlU5jI42t42-BKAHBV1mwdF2b1mFETNrCMGd6g>
    <xmx:PNpFaDTVeydiphFBsN45HGYRHj8wYJDT_pSsmIzdor-LIQzeZtEOuw>
    <xmx:PNpFaKoQ1CeYbxcFjmLZCflVjLepySL-h7GNqXzx4sba9V5LsoSllA>
    <xmx:PdpFaJJUm4zDI-kB9H60bpmvYQeK62y7VYsXeJIBn_ZUolts2aQ6k6s6>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Jun 2025 14:45:14 -0400 (EDT)
Message-ID: <7e457120-6c9e-4318-9f92-e794223bfce6@maowtm.org>
Date: Sun, 8 Jun 2025 19:45:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 2/5] landlock: Use path_walk_parent()
To: Song Liu <song@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org,
 mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com,
 jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com
References: <20250606213015.255134-1-song@kernel.org>
 <20250606213015.255134-3-song@kernel.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250606213015.255134-3-song@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/25 22:30, Song Liu wrote:
> Use path_walk_parent() to walk a path up to its parent.
> 
> No functional changes intended.
> 
> Signed-off-by: Song Liu <song@kernel.org>

There is also path walk code in collect_domain_accesses even though that
one doesn't walk pass mount points.  Not sure if that one should be
updated to use this helper as well, or maybe fine to keep using
dget_parent.

