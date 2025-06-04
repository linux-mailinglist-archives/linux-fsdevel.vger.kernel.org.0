Return-Path: <linux-fsdevel+bounces-50556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A548ACD501
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 03:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748D41BA2CD4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 01:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA5145323;
	Wed,  4 Jun 2025 01:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="ChEUM6jg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vq4MewWP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694814A0C;
	Wed,  4 Jun 2025 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999535; cv=none; b=F2HkItEkBFSiwDVhpq0s5H4yjerkRxtYOAR0n5lEdxuIEoP2zMwdQWkTXOt2Xy2ofD5bXd373T6XEB4HmqtOG7sVb6KwLfoyyTvTS0A39jvHFYwDNZmppDXPr6kLF/qsru9sheLNOCFSUzxcVRG0qKX6U4gDtSP7qoeJQcdxE38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999535; c=relaxed/simple;
	bh=0VOFxNV39gAOXSFbRArwKwdkkpu5VO5YitcWLUDsQVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVXGPgZ9Arb8xx0QBmM+F+ZWvZNP0oXitTrDe4Xn+EpJMsCbZIHgDJ7yvmjLObYauLgTuIxfdGvGm9u8prTzKfUN6TuxgO0YatXOfr591O8yXIZT2hyADyk69gD3U9uEjvHe8PbVB7kJ150pIOTCXuWF7/Fvcq12xQnfAKsEAzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=ChEUM6jg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vq4MewWP; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 51D0B114010E;
	Tue,  3 Jun 2025 21:12:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Jun 2025 21:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748999533;
	 x=1749085933; bh=JwE9EUAZRYNGjrpGdW2v2Z70Ve5xQUflll9IjRgBDzk=; b=
	ChEUM6jgN4PKKFILYz3KL5b9Caoqz3oVu8PUFrxnIIgo7vtahmhZMU2hJHZ0ROBc
	NEHBKZ0zdrjkEMAHMxXTqkEa5ohgnZLoOrOnFa7rGtPgszrg7S7k1gF/R2Zys3c1
	9mExMPQEvmggPvsOUZNdGf5SFciiROKshlETOKaKuzkZuYa/W9O4l/h0knX5GYOw
	u9KmBNfOXNIk1ofT17MxopMhvrrEC4bMOLUKwuCAmRXN3JRuRV+u6nDhfSmPUkIj
	cR8vXnuYrVAdiwnkZDAHF53k2taI1Q+tZev3Y2qOdThmiPA8Kcwth3IQLE/K9N7s
	Kt647EMf2Af4mLTTQ9EEhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748999533; x=
	1749085933; bh=JwE9EUAZRYNGjrpGdW2v2Z70Ve5xQUflll9IjRgBDzk=; b=V
	q4MewWP183G3eTR5bie/he3v8xbsLyplEQRvvJr3El+rKu65p+zHC+rEB4bYPW46
	dQXG4EbcVqkuhr0co4xK9xUzPcMa4Mjhcnn5rwnJf48MQ38h2xCKWvbXH8X8mJUe
	+YQJIHZuWiq1VIe6f6GdYXoN6qsuC0ye7uwoBToopm1k//kuPi0+Uasphe32KrE3
	aAOL+TlhuqGA+YFcL94JS3uZaZFjkSNraWPS1vGGGJwK0eBFVlntxsuQoYAOqS9X
	jokdmIGZydO9dIiMfR0VUt+DqHGWMct17kjq68Xqm2Npr+Xf4OfWQoXxktQzhqcJ
	5SQ9IGeCgWhloxrRv3t6Q==
X-ME-Sender: <xms:bJ0_aK0WDNCIzLjOcyoeedojom5QVZR9jmrgUWkMmopKBDqZmvDUAg>
    <xme:bJ0_aNEx96Yh03_JhyQma31vjAf-wNeyZ9byXT6vpBm11WzqDKvKIV_93ZkBFkIT9
    3zY1tBYuoblF7LuB_g>
X-ME-Received: <xmr:bJ0_aC5UDlDaHYfCkbYAt7L0hlOr-trg4L8XMU_ICSZeOCyKSZGjJDKCsiEnBLX9uNFP-TwYkAQi_50V2SJ_8fsn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqne
    cuggftrfgrthhtvghrnhepfedvheeluedthfelgfevvdfgkeelgfelkeegtddvhedvgfdt
    feeilefhudetgfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrgh
    druhhkpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehs
    ohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvg
    drtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopegrlhgv
    gigvihdrshhtrghrohhvohhithhovhesghhmrghilhdrtghomhdprhgtphhtthhopegsrh
    gruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhr
    ihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bZ0_aL2XBrl6G1HC2rzHo0DnpvabArMEH10sSls-tt8Z0hLc9V2VkA>
    <xmx:bZ0_aNEtorjPe70lUoDAhqhMcqvgIaSV3tilAiACAQFUstemT53Z-Q>
    <xmx:bZ0_aE_kyU29Q6nShxBG8ap2FYpFkyyHkl6yIivGgjj3JaWHWbyRcQ>
    <xmx:bZ0_aCnBhu-8ceOEWosEi8YLoK9jLccG8eCf6mC6-LWPgygHOwxkVA>
    <xmx:bZ0_aF4eVhJFzgsMskZetMOHeV6iNS4o-4Wh2ruQgrh6kf9sruDNSq11>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 21:12:11 -0400 (EDT)
Message-ID: <9245d92c-9d23-4d10-9f2d-7383b1a1d9a9@maowtm.org>
Date: Wed, 4 Jun 2025 02:12:11 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] Restart pathwalk on rename seqcount change
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Song Liu <song@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, Jan Kara <jack@suse.cz>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Christian Brauner <brauner@kernel.org>,
 linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1748997840.git.m@maowtm.org>
 <7452abd023a695a7cb87d0a30536e9afecae0e9a.1748997840.git.m@maowtm.org>
 <20250604005546.GE299672@ZenIV>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250604005546.GE299672@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/25 01:55, Al Viro wrote:
> On Wed, Jun 04, 2025 at 01:45:45AM +0100, Tingmao Wang wrote:
>> +		rename_seqcount = read_seqbegin(&rename_lock);
>> +		if (rename_seqcount % 2 == 1) {
> 
> Please, describe the condition when that can happen, preferably
> along with a reproducer.

My understanding is that when a rename is in progress the seqcount is odd,
is that correct?

If that's the case, then the fs_race_test in patch 2 should act as a
reproducer, since it's constantly moving the directory.

I can add a comment to explain this, thanks for pointing out.

