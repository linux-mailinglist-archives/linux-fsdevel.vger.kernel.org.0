Return-Path: <linux-fsdevel+bounces-45826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10285A7D07F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 22:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F543AE565
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 20:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EC31ACEA6;
	Sun,  6 Apr 2025 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="KTCzxLKz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lUJP7ILA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D802E1B415F;
	Sun,  6 Apr 2025 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743972366; cv=none; b=hB6aKVjtjSEeEC3+ZSjdBB2CgFhphFyFQMoQ0zhFesvu9r8sUIUuhToOR9DkB3nkdZWWn+UH6IP0WXYFeNDrPIy61dAG1xIDR5YGq+okHEje9MlRZ+o0aq0IP9tkn0Dt68JvByxKfyKzHrofzU0IpPxgnZS42sfrkMs22D4IKbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743972366; c=relaxed/simple;
	bh=WBJTNTYjycyxp1ti192OEN39iD9bsjfkFPcfWB+pqBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvciJDcd/rzGVjsYHapiBARDzCTDjJvi/jM4HJG8TxEf6nfaIvC13J8gtCPxLJu/khu5CoALYySRYM5383a/B5kYpV13gOILb+9m8KdvxtJrcQD935zGZEBQzrn+ef2gdtMMdFoyVd8HmBQeykUwQn1RV7RZSM+Fe/CoMgzHN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=KTCzxLKz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lUJP7ILA; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id EBAC1202428;
	Sun,  6 Apr 2025 16:46:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 06 Apr 2025 16:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1743972363; x=
	1743975963; bh=ygHy4tWC00SI2EYsxDY2Q33xgQ0DwhcTe1RbaWpNvdI=; b=K
	TCzxLKznBd0TKZD8GtPqhv7yuPovdwLeDrBhtgLK4X0JB8hO/sZ7PpnYEShqvOMi
	UWUfCyF626POe4hK0h+D7FAKqu76g6ZNZRzdUXERu3Z733RNcV3XlM1WgYoVk4YE
	thcE+81LnUaUechPPZ61/OiGBdT9D/rM+ScTFSk2qR6tNUZc7WqZ91xdhkWjEwld
	yGT+77BrGaEHeGxAfBg/72pOv0wHMK3Uvx5MYMOukcyjNV8k7DuXHea2sT1h2GjL
	6tX7HC4xUJP/xdLQ1zRCYDXlYPIW5bO4Zn6lgBV94N96gxm8AlIzOVUcBL4CNsQ1
	sNmZzl71jvZgeYo9hBFag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1743972363; x=1743975963; bh=y
	gHy4tWC00SI2EYsxDY2Q33xgQ0DwhcTe1RbaWpNvdI=; b=lUJP7ILAF/EgPoXAO
	Znqn6os9HnSdDtmGt+y7Mq91rFGaSSjkh4VCMCv/NnVuxSyVYxG6LDPJblO/mWNN
	5kZiXovBeGq23LynvFEdlullEyZnXRwj1M1eXDZ6F8KvkurB9sju1rwLR1pVftdC
	ZDM44lRgtTVbZGA/ewxAFupiZza5G9z+Sv4pqsl1tp13ljojHuDyswdD0/qW4U8j
	m+3Zuc26roWnG2WHIlZQdkmJz2rkYWRmA9NI67oqie8yf9OMpYjJ+uNh0kuetu4Y
	4tCu9SoQbriTgsgQ7zjioAiHcLz3v8q14ZtrCgSUjC43ICJLKofCSRS4ldlLXMpI
	+TAdA==
X-ME-Sender: <xms:C-jyZ0lkHwqyVYDt2RTpxT14yInHa8vnt503xAsRGbOaLb6f05MVjQ>
    <xme:C-jyZz1luYzY_uAKjv_a0BX5b5MAdvpX1q9z2C087G6QQuX-AcgU6MIz1LNOHRFHb
    7CJpuuewWkC9ZencCM>
X-ME-Received: <xmr:C-jyZypBga1RzRKpHSJzasX_G2b9_7d2ofp4taE-yurNEGkoM-hxhP_YUMc2kvmjJOkOIdNOHKrBDqOPJlbX0vQSnvaH7dCqHGdKdZVPkOYX8xHp8OwpTqU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleekvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddvteefffegteetueegueel
    jeefueekjeetieeuleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepudefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthht
    oheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtoheplhhinhhugigpohhssh
    estghruhguvggshihtvgdrtghomhdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdp
    rhgtphhtthhopehvlehfsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhope
    hmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:C-jyZwnnL8QVCv__5KeDJdQAX4rxOk2RDTq32-wYJL5uQTOTzYICFw>
    <xmx:C-jyZy05h5hXr_AIEdNPCAGkAyaluc4Tc2d6flWEFS1t8XbbYP71_A>
    <xmx:C-jyZ3tiVKuP_U4fy--CCCv7MjjW1cRycxblCgkTDu5Fu5-l_UGLxw>
    <xmx:C-jyZ-UBaql1_8QzSOTPPCPcrH-FFD673kzvSq6M27JQAJ38XmlbEg>
    <xmx:C-jyZ_2_aJnAvJfLe3nyGw89fSupbpqLuwZ5zIylCQ7rQ-RktC4LiGy1>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Apr 2025 16:46:02 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 6/6] fs/9p: non-.L: Refresh stale inodes on reuse
Date: Sun,  6 Apr 2025 21:43:07 +0100
Message-ID: <e9c49c3dd0359196fff8bd6321b431e9a890fe7a.1743971855.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743971855.git.m@maowtm.org>
References: <cover.1743971855.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This replicates the previous .L commit for non-.L

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 fs/9p/vfs_inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 1137a5960ac2..3f087b0bf1bf 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -498,8 +498,14 @@ static struct inode *v9fs_qid_iget(struct super_block *sb, struct p9_qid *qid,
 
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode->i_state & I_NEW)) {
+		/* See explanation in v9fs_qid_iget_dotl */
+		if (new) {
+			v9fs_stat2inode(st, inode, sb,
+				(v9ses->cache & CACHE_LOOSE) ?  V9FS_STAT2INODE_KEEP_ISIZE : 0);
+		}
 		return inode;
+	}
 	/*
 	 * initialize the inode with the stat info
 	 * FIXME!! we may need support for stale inodes
-- 
2.39.5


