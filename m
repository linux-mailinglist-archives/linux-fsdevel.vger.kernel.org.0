Return-Path: <linux-fsdevel+bounces-68818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 817F4C670CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 03:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F0A334E147
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 02:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECD22D6620;
	Tue, 18 Nov 2025 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="QOOtUwZz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0yJagyFE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B117984039;
	Tue, 18 Nov 2025 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434008; cv=none; b=I6jc6PIb4HsaT3Krix9NjSlrwEUiTgL2M85NcJo4XSjmrLM7YBsL8Tlm1b/V3IBGZIfjFv4ZrpKg7VK0Mw4s0MoZc6No28lDHRyY8Edx1BGQDwT8hvQF8bulWO9B1h4+HDLTgj8Ulief9WkU/maRHBAT9kMFlkAgXLLH+fm75S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434008; c=relaxed/simple;
	bh=veNcfffk57g2enV+nUBefmRrr2ED9YivK4cm2H0fdwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fy589EfanKiZN0SQuaa7ioj9PSx9MWRDOAX984I8+z1pp4jmiVcn/u98rIJ9DMr7DR87dWsqPP4iGIdVptVF0S6CImMjeF4T8vxEdqmB/cRqPq48eQrVLFh4Gigx9sWoCUCqyRZZ2MQi1kblaT6WeoeoN7z1A3+Npsvjo8Li2aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=QOOtUwZz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0yJagyFE; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A7A7B7A003F;
	Mon, 17 Nov 2025 21:46:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 17 Nov 2025 21:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1763434004; x=1763520404; bh=Tdg03enBNBA6ryFkaZR++
	lhcLf3yrycAQK2K9l0n/iI=; b=QOOtUwZzV1IxwklEmlxFL9j5e9Wv8ycQgC5hX
	7Rh+0djW9+cPeYNhxLwmbFsglOYoCkdVk7pb6NUN8x9/SBrzNaZ68pVM6FNPMakc
	pL3pXYUlqXKkgOKMSeEgANGTHOmBk9XvohMCostRxxBl7DofT8kPgyVog4kq3DMF
	ClouO4OvEF7K7znnRf5krfoYB1qT1f91M9qoND86PAXCJCwf7fliba2a1pS8ovc6
	2zqNhaRttGNlmVtIAwbLOaVh9e3dy5B/aPLFopP0co81MN2IVLLSD6+ApeMoVTYJ
	pibvFqb5W7bvxVGLD/A73si2UiUa4g2w7wQyibqq8IwMiccOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763434004; x=1763520404; bh=Tdg03enBNBA6ryFkaZR++lhcLf3yrycAQK2
	K9l0n/iI=; b=0yJagyFEa/Mgucf761VK9cLDt3vPa7cPr++80YNbky2YYTlkNlH
	EXqGXlhkm0qyjp8fMPuPSaPgUPEffeO5u7nUHAQDYzs9CIEIZyAVi1e0LAPat7i5
	s9M7PN4TH/0NGGG/WtJqXRu5z1t+JJuCKbsaGyqjAUBI4qk3YZr/A/aP0jHR9QvB
	N91R7egxtziZg5ii69zTx6bb018AH0Ji1B8yIwdTDbuWV6NRaJ+Nd6ooL7/gdLw1
	u5ExldN6eyLd7E5lUPhxGq5X0UkgsUmzZoF8wRHKzggvcJhXFfm5301m01MY65up
	ItGFn6/N674egYADg89MIJT6rmSvKkDzFrQ==
X-ME-Sender: <xms:FN4baawjcUxoF3Gslnw-DWnsV1Z4VAIk7-ctd1z1TgnQlLmi3lNLjg>
    <xme:FN4baW8meMtZsRHHLxxTwkTKV4rTeJgMcB90Qh6IjIkdm0TUeWr1R0_3Ym6xKE58J
    4B-wh8RD4nHWNsx-qlNyKOkqU6t8_m0u6msaFNwZEd6DNKz>
X-ME-Received: <xmr:FN4baajruIxq7R4Eg_yzHVuMQSuBL5w_7AXFNs-IHDHB-g6IGm49bJRwuUZ1to1BirV8gKiRh0kGXT3rs-erjG63QzY3-w66kX5xQRVDhjZcmH33NcTfnNasJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgvnhht
    uceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedutdfhve
    ehuefhjefgffegieduhefhtdejkefhvdekteeihfehtddtgffgheduleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmh
    grfidrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhose
    iivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegruhhtohhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrvhgvnhesthhhvghmrg
    ifrdhnvght
X-ME-Proxy: <xmx:FN4baVGmok8qn_ujwAcXIi9lvK-uteFkzYQSyyJj25PqqbIvEJo5Ew>
    <xmx:FN4baR_yMw5jMavzI29VC1KGyW_9ddoyEOATv1wd6MCwZle-vFrALg>
    <xmx:FN4baUzsolznYcOGpNoMF6_NJWZav05Kzyv4UPFXdP4s3C3Ut5I0XQ>
    <xmx:FN4baVOiRyPx9YHVQZpXeynPcj4okJ8iZJb-SMXI9BobbSlOCR0Jig>
    <xmx:FN4baY7UodRLj_Td0a4VDTx8FlCruiJO7xf2cfyAZNFkN2bXqVAJWCPt>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 21:46:41 -0500 (EST)
From: Ian Kent <raven@themaw.net>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Ian Kent <raven@themaw.net>
Subject: [PATCH 0/1] Updated patch for "autofs: dont trigger mount if it can't succeed"
Date: Tue, 18 Nov 2025 10:46:30 +0800
Message-ID: <20251118024631.10854-1-raven@themaw.net>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have finally been able to build and install upstream 6.18.0-rc5.
I did my tests and they worked as expected.

So I think this patch is good.

Ian

Ian Kent (1):
  autofs: dont trigger mount if it cant succeed

 fs/autofs/autofs_i.h  | 5 +++++
 fs/autofs/dev-ioctl.c | 1 +
 fs/autofs/inode.c     | 1 +
 fs/autofs/root.c      | 8 ++++++++
 fs/namespace.c        | 6 ++++++
 include/linux/fs.h    | 1 +
 6 files changed, 22 insertions(+)

-- 
2.51.1

