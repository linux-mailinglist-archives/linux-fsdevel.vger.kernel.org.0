Return-Path: <linux-fsdevel+bounces-38621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46A5A04F95
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 02:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC9A3A1EDC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 01:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4EE19F13B;
	Wed,  8 Jan 2025 01:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b="LZl3c0Y4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qL0mhawL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889871FE477
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jan 2025 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299385; cv=none; b=C2e/AHDiPPklHBECTWZG9MLZBP2SgvOwcdEOEQBCZYLpmE3Ermrv4OhJH67m7+xjnH+tnprobewVpDlS7eNVWL+0QRQmLlVBJkxb9e5UoRdZ/6pBG0schaRRZ9WYRVoe24aDC7IlVZ7MUcXj59wP8NuXFt/kyugsPaTdk9UoNs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299385; c=relaxed/simple;
	bh=nQgD3e8V0oVBD+ie6xuiSg3E05whcXEnl3zWwjThT7E=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=sX8w5c/tyFhANF5RWL7bSDARpPbsNMa7zqIMfQn0wQWyYKdGpNSFdXXj3P3a7f28HIoy3nEkwIcQ9zjZFdnkSB8Jo/teKgkpfEt+o4uBaKRxnW/LBlR3UcR54eUGiIe6/62N5zIODg35SkrnZoQhoBJha2c4Oq1+7aZaW/HmXlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io; spf=pass smtp.mailfrom=devkernel.io; dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b=LZl3c0Y4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qL0mhawL; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devkernel.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 80EC81140136;
	Tue,  7 Jan 2025 20:23:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 07 Jan 2025 20:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736299381; x=1736385781; bh=jxbz0UX4ZC
	weTB9tOgdu2tF0VYN93uv1f7RUFPTNieM=; b=LZl3c0Y43nd8yBiy6SJLd3GSH3
	FqRlApq57M78EjWppiKJuIDpLwoXN6pEeDPotuOdjDOPrRWEr4+2PAjle3BU/EWg
	dN3QEY+DqSGEVkOFMYh9Xtu3Pkh09JlBYk4CKl3w9X3QPATed1OV16/fLeDhL2qE
	LMUdGBnsUIbrRfLQmP59xgbiC7GGWUkNrHvuyQ1TrijX8MweHKN9rLlr2oS/ciX0
	avv3giWUJhVHKQVbsLujHMpgqmDIG/3BgZfzF8InDH7DuVfYECqrC04r0VtCY8Mg
	UP1xW7AuHew0WDa8Ox2VOxvbKZ1/CLfJAePVj23DlRatVcuW6T9PtyL3EBPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736299381; x=1736385781; bh=jxbz0UX4ZCweTB9tOgdu2tF0VYN93uv1f7R
	UFPTNieM=; b=qL0mhawLn0SpBiERJ5nax1kxLEvSS0OdxsymuxLgYGYUoecFmnj
	9TbVf1xGszkfteAg26UeCYPLW95A+cy8+378k2+p9qrxxj35+cZMj2qf6trCiodA
	b+MA/86cDnlSM+JdFeokg0wsgQNA+jYYAOJsZN4n4uRkWgjnZuwI+Smx70eiw2Zh
	pEX5P9adwrUNPW1stNunQp+YYZQhb9NlH6rw/YOFkTiegqR11Wuu1JTvJl0R3au3
	ca82Vu4WeFFQ0AgWfqPQ7T4WsR8fvtbJBQ7biEDtUm1u30srM6DQgE8OjzTZULwz
	cYDLUI/xHIVT987ConnRP5Ng7Nxjo/lEfNg==
X-ME-Sender: <xms:dNN9Z3OZge3sFE9L-m2Iwq2r_Mfif_hpo_Yr-chzB35xk-WWKhEdHQ>
    <xme:dNN9Zx_EBQgtXFqlMiqCFqGmaDYjwHftAkMBpDtpc3oIOJfduhWQi0jvvUWd-8AR1
    lB-K-PyugWP-oA1CKI>
X-ME-Received: <xmr:dNN9Z2SznD5-W7-TaxOf3iHMVnKFe4pIH22eCJg93Qp_AyM1_rLxDiOqT6vv5TkKH1AWG-J_nidu8mD6mTv7QhuP-dwQTyaKLPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegfedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfhgfhffvvefuffgjkfggtgesthdtredttdertden
    ucfhrhhomhepufhtvghfrghnucftohgvshgthhcuoehshhhrseguvghvkhgvrhhnvghlrd
    hioheqnecuggftrfgrthhtvghrnhephffgjeevudduhedvudevgfduvdfffefghfeiuedu
    feduhffhieejfeejffehledvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshhhrseguvghv
    khgvrhhnvghlrdhiohdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhope
    grkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepiiii
    qhhqtddutdefrdhhvgihsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlhiesih
    hnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtgho
    mh
X-ME-Proxy: <xmx:dNN9Z7ul9842gZ1EZVUImXj5bT7BVXynNaiV4BDf2FVPpg-rsZklJQ>
    <xmx:dNN9Z_dW_8wkVpctJw_aWTou66B0naQlP41e82e1y4Lp-QbUOGuGZw>
    <xmx:dNN9Z32NdI8STpjDC-PIQmaI-qCy3HYoBw7nHWpEBW1PArLlLdUnAg>
    <xmx:dNN9Z78dmBPYYHjEwHaxA3Z5_Iq_DbC-Dnua_f5VI2uk28tjHdxYhA>
    <xmx:ddN9Z3RBpKRztbI8ZYrdcuxUA0Brx_3Oj4909hiluf9xOcnmLPYfnAPZ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 20:22:57 -0500 (EST)
References: <20250104012037.159386-1-shr@devkernel.io>
 <2339600b-ebd5-49f3-a0be-414bc400a858@redhat.com>
User-agent: mu4e 1.10.3; emacs 29.4
From: Stefan Roesch <shr@devkernel.io>
To: David Hildenbrand <david@redhat.com>
Cc: willy@infradead.org, zzqq0103.hey@gmail.com, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] mm: fix div by zero in bdi_ratio_from_pages
Date: Tue, 07 Jan 2025 17:22:07 -0800
In-reply-to: <2339600b-ebd5-49f3-a0be-414bc400a858@redhat.com>
Message-ID: <87o70i5cb6.fsf@devkernel.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


David Hildenbrand <david@redhat.com> writes:

> On 04.01.25 02:20, Stefan Roesch wrote:
>> During testing it has been detected, that it is possible to get div by
>> zero error in bdi_set_min_bytes. The error is caused by the function
>> bdi_ratio_from_pages(). bdi_ratio_from_pages() calls
>> global_dirty_limits. If the dirty threshold is 0, the div by zero is
>> raised. This can happen if the root user is setting:
>> echo 0 > /proc/sys/vm/dirty_ration.
>> The following is a test case:
>> echo 0 > /proc/sys/vm/dirty_ratio
>> cd /sys/class/bdi/<device>
>> echo 1 > strict_limit
>> echo 8192 > min_bytes
>> ==> error is raised.
>> The problem is addressed by returning -EINVAL if dirty_ratio or
>> dirty_bytes is set to 0.
>> Reported-by: cheung wall <zzqq0103.hey@gmail.com>
>> Closes: https://lore.kernel.org/linux-mm/87pll35yd0.fsf@devkernel.io/T/#t
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>> ---
>>   mm/page-writeback.c | 2 ++
>>   1 file changed, 2 insertions(+)
>> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
>> index d213ead95675..91aa7a5c0078 100644
>> --- a/mm/page-writeback.c
>> +++ b/mm/page-writeback.c
>> @@ -692,6 +692,8 @@ static unsigned long bdi_ratio_from_pages(unsigned long pages)
>>   	unsigned long ratio;
>>     	global_dirty_limits(&background_thresh, &dirty_thresh);
>> +	if (!dirty_thresh)
>> +		return -EINVAL;
>>   	ratio = div64_u64(pages * 100ULL * BDI_RATIO_SCALE, dirty_thresh);
>>     	return ratio;
>
> bdi_set_min_bytes() calls bdi_ratio_from_pages() and passes the result to
> __bdi_set_min_ratio().
>
> __bdi_set_min_ratio() expects an "unsigned int min_ratio". I assume this will
> work because "max_ratio > 100 * BDI_RATIO_SCALE", but it is rather confusing ...
>
> Maybe we want something like:
>
> /* Use 101% to indicate "invalid" */
> #define BDI_RATIO_INVALID (101 * BDI_RATIO_SCALE)
>
> Or alternatively, just handle it in the callers of bdi_ratio_from_pages(),
> checking for -EINVAL manually.

David, I prefer the second option, its a bit easier to follow.


