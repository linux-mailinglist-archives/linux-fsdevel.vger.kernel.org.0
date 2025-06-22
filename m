Return-Path: <linux-fsdevel+bounces-52400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBF7AE30E6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 19:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A623AF8E3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 17:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9DC198E8C;
	Sun, 22 Jun 2025 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="mJx1TQri";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L6PMuuKy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761921E4A4;
	Sun, 22 Jun 2025 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750611853; cv=none; b=iG93it+U1y1WCJj0QTz7UreSX4k2PpwwhqYVeq9D80D7ofkwsFjKn+LW+TqrY4Du748slICfFS2WJZoCvdfV4VGQMwQDtHe7Zh6FqcI4ZfLczp7rXs+SyxpIVPmWwb7c9DUZlKP/dRUf+RMbrVDBNS5MFLVU4Hor7HOEBXoRpjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750611853; c=relaxed/simple;
	bh=U+hW+7O5VUUEZoHnUj9aZblDTxsYOEy7mpifuaeGZ00=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=k951e11VQ69GYc4N/Nuk5As1gjpBcYeEHxGHQS5zJZ+ZTRNXqpw373qYOaMAtTbL4F+1iMYb/qvUeKX9LKXPamL740oiDSCGG7+NheF7/xmidwrvKZ0RnDCdeSNdAEavlo3++DjNzK+5v9Cs0r2ypUjVVIWHzEbH+BbOogRoKnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=mJx1TQri; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L6PMuuKy; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 32D06114010B;
	Sun, 22 Jun 2025 13:04:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 22 Jun 2025 13:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750611850;
	 x=1750698250; bh=4Oz8BVlocdpl9en13acAbqS/GUdquFUEZid+eG0OkBU=; b=
	mJx1TQri8ox2LcVJZ14GImiXHURepaYJLoK5Qas2gSXS56fz5gpV7fupUQITpQ/T
	X8ILrsp+woeSxhy3qbHfMwuuMSAdAUSfELECshYmUCUykH3cvVuaihkJGmd3QeLq
	/+SA0kJNjsE+U6qaUNgSSne6R+sjUv3hUWUG4NHVEsZ0ALg2jM7QFE7sZIjK/AC2
	g3qwRoVTpgyzqF0VvQDoNGhMVwFAuObLAbKGQTbNN8iMUq4oTDZFMhNp+djfK37u
	qmI+qg7ZfdBbmqytP4dQXmxZJW/2fHFzkJNKD5x/z2elMMwnQiY4VsGY5zyQQDfl
	gamWsl+goiyIrsmONtOZww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750611850; x=
	1750698250; bh=4Oz8BVlocdpl9en13acAbqS/GUdquFUEZid+eG0OkBU=; b=L
	6PMuuKy1khpwkaWN+y6a3ypY6Sva+TS6TYgzmQ7v9x6clr5uwrIVQRaF9pGDF96b
	N0ze1RlNRClYMGs1r8GMaRryf6pNyZfys/9PNOXaDgh1S3IumwFKdOaTruDYrhhN
	cMXoYYqg4LTv6eYxpzZNB2flHXoaskAR9zVjxJ+ygn1Z9dkRdd0ESzip0Nrg/5XY
	xELJ72qCXap2Sc/mj6tWI8px6BjzbflJxvUHzNkDjDG0Hv3dBJk9W9AMp6AkMrJR
	QFlzAp5VPo89YmWn1KOIg/jkrSuxd4Fzw9vijN5pkDq7sfWIcKv6REeDg/kmuGnV
	329AMkA44LT3cp9OQfpIQ==
X-ME-Sender: <xms:iTdYaFsQE20p60OfKXhDaYgslnJxZBXf2tolYPVeVRJdbcgVuS3nIQ>
    <xme:iTdYaOfUqdc3Q-FF1GS7ZxOiwzBjLdR0OsfGmtuDR7DliUyX8IEzTbWTwvVytD_kh
    BVOJ99QhKKuc98TSz0>
X-ME-Received: <xmr:iTdYaIyI6_a5a7mibCZDf1YZzI87Ojcf0dKhHYKD-z036tdxIRa9EyeX66TrV09F8v7-H-AT2vtXWmONJ-xk0Nef>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddugeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffhvfevfhgjtgfgsehtjeertd
    dtvdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhr
    gheqnecuggftrfgrthhtvghrnhepheffleegkedtueefleduueehueevffduheejudduve
    evtdevkeelkedtudfhvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhr
    tghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iTdYaMNX6kySZxg-A8Ssav01AaSwFPgtcUjVxrQe4i82dGSXXI9kRg>
    <xmx:iTdYaF9UqIj6Jhhq_EWRI_aMz9WAW_VqMCoJzT2guh7DahRhXpsPkA>
    <xmx:iTdYaMXi8xXbD435vNEEUyHd4OnyLkmK0LJJHOs7PzxV0wjZb8xdtw>
    <xmx:iTdYaGcdzszr7AMGVL88lwD6wnpMEx47FsShIIqGE8Vw7IlG9rwZPA>
    <xmx:ijdYaKitizEBzW1WpOEe80KntZxmt90uHgmcPjzrU8L9P7Wfs2cPcW3H>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Jun 2025 13:04:09 -0400 (EDT)
Message-ID: <7667bda1-6055-4b91-b904-0b8d49e990c5@maowtm.org>
Date: Sun, 22 Jun 2025 18:04:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/landlock: Add tests for access through
 disconnected paths
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org>
 <20250619.yohT8thouf5J@digikod.net>
 <973a4725-4744-43ba-89aa-e9c39dce4d96@maowtm.org>
Content-Language: en-US
In-Reply-To: <973a4725-4744-43ba-89aa-e9c39dce4d96@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/25 16:42, Tingmao Wang wrote:
> +	/* This layer only handles LANDLOCK_ACCESS_FS_READ_FILE only. */
                                                               ^^^^^ sorry remove this

