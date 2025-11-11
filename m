Return-Path: <linux-fsdevel+bounces-67796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55562C4B9A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038E13B8CBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 06:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2E028FFF6;
	Tue, 11 Nov 2025 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="PBklgNLp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RRd2jIN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA23283FEE;
	Tue, 11 Nov 2025 06:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841113; cv=none; b=IRzek6gF3BJoKOGBixcYOhc80YY12cigMjdLMXytG6L4elhhb/JSOo9T1OQ5LYXdJ3rWHmxj/mKRE91VNhkcyi8S9C3JBOMXe6nPSevguTjGd9K/7lPDNMv7yPDmK5HYHeyg8LMiCqnunAXhpScVHpPEiAMKz7BIkAKBHDWhTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841113; c=relaxed/simple;
	bh=B9m/VXqbYZim/G+h5KCtqRPqkvqUC8x5yp46HoOXbro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7uuIwHfUumVJ43kzG+RgJye6UpdFVx0W8lruGa8HS0ra080mAjaGwqkEVTUpN4sqyvcAB1DD9IlpYj+f43KtRJotMOKBVSC188bLoOTuLJe1srMBLMcArSbsT+hQrLFNQNpURL9DKTzoH/SIE/RvaboGPUTh1hfxthO1nfB+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=PBklgNLp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RRd2jIN8; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 26D177A0140;
	Tue, 11 Nov 2025 01:05:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 11 Nov 2025 01:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1762841110; x=1762927510; bh=VzyPul6AR40EXjw9Y3xnM
	PDCMpoTSNeUOveN/qaFP40=; b=PBklgNLps+cYsnXEWCku65sIz4N/Qgi+qW3pl
	0sHgwMl8+OKv9kl/X7cE4aa7wlgCde0hVXTxeT///zTrZwV3qAYjqywqyk8UUG1u
	7BbHKlDqC+oLLCGBZ46F90udxt/ZQSl4ftDvhx79t9Ec85k6nNcm78GR99SCs577
	n6lLn+bfYuE7Hb8kPjNo+hevaLUeIHqJdWwbPDTvPau/0zg7R5mdxVz1G4H3FSLy
	BCbAlE1a/W0k0bR4XB5raPrTnd+9zLCUQKVteZBepII1sFR7DMxGQlmd9+ppiYIK
	WbrFfH9Ucy5oClFfG3lGCXbbC91Ep0Za0WRpfOFe2FsUHTmoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762841110; x=1762927510; bh=VzyPul6AR40EXjw9Y3xnMPDCMpoTSNeUOve
	N/qaFP40=; b=RRd2jIN80KZyRvnLCtjs2YWr42NZWkZEKLRYw+24jJl5oYT4Avk
	+b6aosh6lWqBP8BS9hjn4qIxW1C3eOPrlXkqNx5v54z7+60ClIKR86o+8/q2L+R3
	K+xdBMbt4lFLJDIkitL6Bga5meEH9Mnfy/m5Nk9cjTqS6DrcAwJiqIoPWM0SGyW8
	H6McGE661N7TMEJuASoBCvOssov1JNEIOKEdGzFGy3w8p0EdPpXxkjhn3gRbEqzN
	6FfBkn4MOU1BDXyfqKGfMo15l2wClMLBXV7zIEj8piq0dE0fKnEImKIBSN4rCAGD
	aCT2K2QAllZwgvmOW896ZKcvfDQSzBPgqLA==
X-ME-Sender: <xms:FdISaV4fm4zzHPaCt3kmCeS2IA_kG5c3reBZMFpC-nKJKnqoVMI0vg>
    <xme:FdISaTk9kjlj_FGzjz-wCw2dmGXvzI7xNZ5e6mJUSc-L6uJkepWdhEdopbVFgYSSn
    ND7qf1jYJ6whm-_ijo-OS4IFhW2cZyaQVsnuyVe6LNWHVmm>
X-ME-Received: <xmr:FdISaaobhgwo4rtTckAeRtOCnVT6deISrYSalSmIao5mNNqs5-1odpbHJlmXcfgO_FtNUz0q7R6rIY5EHBsPiGaZzsEFgqd2n9vl1sQ3IYaMjBXggk8Fj_NP0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddtgeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:FdISaSvj-RCCevA-Zvzt_EIdu-JYIjtqbQYvdt6yVJv1cNcBRl_oxg>
    <xmx:FdISafG2_OXEAPxSzZiQqNqQvbZoakjrT_2LAgsP4b90gg7zPGEPqg>
    <xmx:FdISabZliysHRdXMOEGLPG3ZuX9kvHHMHNh48g8ZngVrjEnpP9FzZw>
    <xmx:FdISaXWQEPO7T8Wu-LlSvkvIXkECXbLav7ddKYwdiIuCTUUjDY-13A>
    <xmx:FdISabIoKMFCWLWB16yRDoMiCWp8_qx4oCZeHgk4g1XKpqeOuRSmcgu6>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 01:05:07 -0500 (EST)
From: Ian Kent <raven@themaw.net>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Ian Kent <raven@themaw.net>
Subject: [PATCH 0/2] autofs: fairly minor fixes
Date: Tue, 11 Nov 2025 14:04:37 +0800
Message-ID: <20251111060439.19593-1-raven@themaw.net>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are a couple of fixes for autofs.
The first is fixing an incorrect log message.
The second is a bit more interesting.
When people want to use a global instance of automount in a container
they bind mount in the container as a propagation slave mount so the
automounted mounts propagate to the container (actually really only
useful for indirect mounts). But there are other cases, for example,
using ushare(1) results in propagation private mount present in the
cloned file system mounts. I'm not sure about excluding such mounts
in these cases as that would prevent a "mount --make-slave" or the like
which would reduce flexability or possibly cause a regression. So I've
elected to simply check and return a permission denied error. Note some
action is needed becuase if the kernel sends a mount request the daemon
will mount it in the init mount namespace which we also don't want in
this case.

Ian Kent (2):
  autofs: fix per-dentry timeout warning
  autofs: dont trigger mount if it cant succeed

 fs/autofs/autofs_i.h  |  4 ++++
 fs/autofs/dev-ioctl.c | 22 ++++++++++++----------
 fs/autofs/inode.c     |  1 +
 fs/autofs/root.c      |  8 ++++++++
 fs/namespace.c        |  6 ++++++
 include/linux/fs.h    |  1 +
 6 files changed, 32 insertions(+), 10 deletions(-)

-- 
2.51.1


