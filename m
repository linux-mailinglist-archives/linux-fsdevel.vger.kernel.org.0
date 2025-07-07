Return-Path: <linux-fsdevel+bounces-54037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DFCAFA897
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 02:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177FA1899F7E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 00:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3606913AA3C;
	Mon,  7 Jul 2025 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="a3TszfeV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JdzQBPx6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5011686323;
	Mon,  7 Jul 2025 00:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751847770; cv=none; b=BnN6UA945LrRXzCMU7SAxFXfgUj18JKZibWPNr57DHS5WjUUweix8pKuAEIru0IpfFUnPHhXUSw4WHgrS5gzKOHpuhV8c+0gcuP7sZ5UnnZOnRlNXUweIS4oapLioAKLiQJOGTPzqUDKVvPo29rBxNj20m+3uGqKx41CBIx5HRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751847770; c=relaxed/simple;
	bh=cipJ0KCrIje7o3/t7yOXFjrP6U5yHzE2snzdzfqCobA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bo+hUleP2nYr8nzPj1S/45nndb1YCAb0Z45Jw9RajfTpWFR/d86XGx/ApP/HFAZEqA6EHy3mIQ2FW6o0HDnWk4Qr9VieRKFB1AtosmwG+AbnS8MePYj3zUcsKEH0G7StVjRbfxKtzy5yTAzQoncoqiozZ2hkiNYnW9pBiI8BQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=a3TszfeV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JdzQBPx6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 545091400829;
	Sun,  6 Jul 2025 20:22:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 06 Jul 2025 20:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751847767;
	 x=1751934167; bh=J9DivzcVSYj+k8VRSR4PWtuUtf2p7TIqKRYqQWeu/Vk=; b=
	a3TszfeV1/mmauhpSJbjBWOu1KtkZObpoigLooriEXAiz+r6GV3WXtflhnlMbULb
	O0e2ex7DSFoptmoVscj6MCb4rZTkvPCi93UFe9bgkZbyM9aqtSn0A5VRxg/u90LF
	MJwvL7Ei5glvG6qEwDp9klSHoExaRwJiaci72GhknfOSmjstYEVi8nEqGUPfm9g2
	lPmvW0giZYyNPu6Geqg5hyLedaq7Q9Hq2Y+djIy1D25MD6cLYjp4/co4H2oxay0v
	Z8XkfhrZxWp8tVlK16RFN4JF5wvNZI2kqSEbyPvOUKC3QX+oHcFGo7dWqnVXwOmU
	4xW9WBSwtATu9KdJzTSiMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751847767; x=
	1751934167; bh=J9DivzcVSYj+k8VRSR4PWtuUtf2p7TIqKRYqQWeu/Vk=; b=J
	dzQBPx6psxGkA0k+JuB/HgsYjDQnG8L63980Ixzeue5IF0KjkbLNZcgbZ+d4yRDk
	f65EYZHNSWZhna6JzlMO/MX9a5/oqxpDnaPIfvN/V1ek3DdRyI9R6p235QPRO5s3
	dE3WwN3bFz6KJTEkLlFXmnOI9SO0Uo74bQ1170e8KxAf6XP+likaTBtR0WxVUgDC
	Y2JyWVM4/KDrws2atOEDx2PjLUKKJf0ME7JOd/Q0TS3UVF8mJo7kejH0vC7Fep6s
	5lWh4KR2GzEdCnqCotg7/9qVMxu0HURmqx7NEp6vfj7xRJ4OkyJl6bBki5h51L0k
	msChsU2mArcCh0ykQ4QJQ==
X-ME-Sender: <xms:VhNraGywfA1RtXY3sBWsv1vnRe6y4MKzac02ykLP5gKv1EqB0PuBZw>
    <xme:VhNraCRCHlgORcPeQROthDisF8QxnuN9G_0snnKLRa-jkGcmsLdDJ7O_vUV_SOd-e
    Aa_57hPzFdOrX-CgVk>
X-ME-Received: <xmr:VhNraIXZ3txCzZisB5_Q1fKVnIAn1yGaWSy4dCTaNJCGc4Wh6Zp9hoVpbEkufUpLt_e2rhwn6YE_wevoMEuM5uE4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeftdefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduke
    evhfegvedvveeihedvvdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughu
    lhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsug
    gvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghilhessghr
    ohifnhdrnhgrmhgvpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphht
    thhopehjvghffhiguhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghkhhhnrgesgh
    hoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:VhNraMiHz2NNN2luLOHbC-DvlwnI7V5l1u9aWc14n6ETa7H1VKKMmA>
    <xmx:VhNraIBE_suvF_8zgsXcGhNcQ1Xiw_aWY068FoxUTtnV5rO36w0zrQ>
    <xmx:VhNraNLGtPP0hSjs3HeY2P8gmgWMp-qHw4EeuLUSQ_dGdMB9rbR8NA>
    <xmx:VhNraPDkzgYVdd98Yom2zK8fqnQojmQw7Bo9XIAe2lVYAZTn7_Nneg>
    <xmx:VxNraOJjeVWqOxnOkwXKmUrWFAZ_E19D00l_ZXwEjW8xzGBZLxO-Sjaj>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jul 2025 20:22:44 -0400 (EDT)
Message-ID: <5a100a50-e74a-4318-8836-ae9695661a89@maowtm.org>
Date: Mon, 7 Jul 2025 01:22:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/2] selftests/landlock: Add layout4_disconnected
 test suite
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Jeff Xu <jeffxu@google.com>,
 Ben Scarlato <akhna@google.com>, Paul Moore <paul@paul-moore.com>,
 Daniel Burgener <dburgener@linux.microsoft.com>, Song Liu <song@kernel.org>,
 Jann Horn <jannh@google.com>
References: <20250701183812.3201231-1-mic@digikod.net>
 <20250701183812.3201231-2-mic@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250701183812.3201231-2-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/1/25 19:38, Mickaël Salaün wrote:
> [...]
> Tingmao, I initially started from your patch [1] (it changed a lot), and
> I'll probably squash with [2], at which point you'll be co-developer if
> that's OK with you.

Sounds good to me.  I've not had a chance yet but I will try to give this
a read and reply if I have any questions.

(Added Jann to Cc per request.)

