Return-Path: <linux-fsdevel+bounces-46651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4DDA92F91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 03:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359D819E6EE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 02:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41522263C8B;
	Fri, 18 Apr 2025 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="YmZSGrjf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CA2263C66;
	Fri, 18 Apr 2025 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744941584; cv=pass; b=FC4MBm/+Sibj8Rf2ZFuKtw9aTXeR/8HdWTxnhQ2V9744ivCrVf3re1AlwzrLfkATEuD3SBwwueY3cddVhLeSSiT2U+xs54kcyIwiCCTbZebfvb75JgWCJG6C6Pk7IAB365sUYCwRJnbRhHwWt8h1XjLf4fADaM0pYPIfmV+rmbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744941584; c=relaxed/simple;
	bh=S0+7Sbp02f2x/zYvgMPtdn1xflbBZmWVS7lYOfPOXUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U3Xeug8eOcw0S7mOUbQr5/8FTKzL5Xu8IpopmGA+OQqin1POzjOIxs31OwM7rD1+jd9p/aaJJrcoY200AOz673aN2r0FsbwygedjGlObRBTJz9Hk+gnBln6BUnbh99eC+0Pp6qEjqKY0uUDkmuwwRqGFUE3CxO0SfSZP7tfXdVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=YmZSGrjf; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8A71A23E1A;
	Fri, 18 Apr 2025 01:59:36 +0000 (UTC)
Received: from pdx1-sub0-mail-a285.dreamhost.com (trex-5.trex.outbound.svc.cluster.local [100.109.60.146])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2881523B7E;
	Fri, 18 Apr 2025 01:59:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744941576; a=rsa-sha256;
	cv=none;
	b=1224Yog9/g03yVNhDlBDFE/0Hyk/B+JrQKgz/ZPtCgcOUSw/CDV9MtexRW+868b5zjgUnM
	LTy3XSH61CYUMb6WQgg/Ke/nK/brvI6waRmxiPrN2S+qxqYJ7XhR9d13TYR0uGkoZHLy1z
	nsUOnxbMdwB4WCz8TvWa6BFsZbJmHqy1oU+CblYsybcfuJNWUHr8OqssZM640C9jb4Q35T
	ND/b1mVgBCtUMUJsebMmE+QMdHp2pu6MOdA2+LgG/ywhBz/0UqkS+r7Dys11cz+5xdoK/B
	WrE/GVW2E/K/CtguVgs4su7zIlgOme1vg0yh6t4lS3Z4SvZ46fhukyjHHC/SBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744941576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2JaAMscrug2FGAwbGl/h9oMw0eHDwe8tdi8SwLuHRGw=;
	b=o5TA7zJDtpQNfp3RWNv6hV+kzTVIzZ3isMynpiA9NlPpklblcMKBuPikKvukbMff4URwST
	zg9qS588GrYl699Y76HKHmZP9kOrfLSD2rw5Y9mb/Xkgr2y6gnGGsclFCrX4/pM4RMZ1Yo
	pEGWEGiA4V4svtGzAkzRrPfAJF6uvdB15E1zS0Yq+KsFGfAKjkMmE92qGt0BFD6PGsjjap
	+4QHFXaiC0dLH81KAEycwUPl3mTA2j5GcnslSPCc2ylVVS4GyRTFkwOOEAApyQ2io2qoyr
	WsasbZDgCD3q7wb2N/H5cPWLVggrPMwYq+VWJFBh+h7T6jz7G0x5vauhT5BQ5g==
ARC-Authentication-Results: i=1;
	rspamd-7bd9ff6c58-dhqhn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cold-Relation: 6c61228447797287_1744941576475_1157459792
X-MC-Loop-Signature: 1744941576475:204546122
X-MC-Ingress-Time: 1744941576475
Received: from pdx1-sub0-mail-a285.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.60.146 (trex/7.0.3);
	Fri, 18 Apr 2025 01:59:36 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a285.dreamhost.com (Postfix) with ESMTPSA id 4Zdycl1Nlyz88;
	Thu, 17 Apr 2025 18:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744941576;
	bh=2JaAMscrug2FGAwbGl/h9oMw0eHDwe8tdi8SwLuHRGw=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=YmZSGrjf8jPt/J19BQv5GZPl1g28pGIvNWKqy1j2sTGEvEThhx8B0MQ6bS284Eocs
	 lkjvhxkqZvzRRhhAGLzDpvMrnzoP/QYj2VKErCD3BP4+uSkgVOdYTPNGP8S5BaKFhy
	 ZNMI3GagZT3WXe5OXJvBeuW9pFZ1Idq/0s4wbguLzmKNFBDOsheQ/OMY69y4Xvj6nZ
	 1tuAvkf4YyroDuSAy23vswcxVMCWCX/x2f1ImKImmi5HNpZ390WS9jAZG8uujheG1s
	 qyyyyIXUGkBHGbPsAUvP58/87KZDesCzyAnOfXbwnrzgAXyFY4274gkHTOQG2k4eWm
	 h3V1Cf52hOC2Q==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	brauner@kernel.org
Cc: mcgrof@kernel.org,
	willy@infradead.org,
	hare@suse.de,
	djwong@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 3/7] fs/buffer: use sleeping version of __find_get_block()
Date: Thu, 17 Apr 2025 18:59:17 -0700
Message-Id: <20250418015921.132400-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250418015921.132400-1-dave@stgolabs.net>
References: <20250418015921.132400-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to the new nonatomic flavor to benefit from potential performance
benefits and adapt in the future vs migration such that semantics
are kept.

Convert write_boundary_block() which already takes the buffer
lock as well as bdev_getblk() depending on the respective gpf flags.
There are no changes in semantics.

Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/buffer.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 5b1d74c818e9..f8c9e5eb4685 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -658,7 +658,9 @@ EXPORT_SYMBOL(generic_buffers_fsync);
 void write_boundary_block(struct block_device *bdev,
 			sector_t bblock, unsigned blocksize)
 {
-	struct buffer_head *bh = __find_get_block(bdev, bblock + 1, blocksize);
+	struct buffer_head *bh;
+
+	bh = __find_get_block_nonatomic(bdev, bblock + 1, blocksize);
 	if (bh) {
 		if (buffer_dirty(bh))
 			write_dirty_buffer(bh, 0);
@@ -1440,7 +1442,12 @@ EXPORT_SYMBOL(__find_get_block_nonatomic);
 struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
 		unsigned size, gfp_t gfp)
 {
-	struct buffer_head *bh = __find_get_block(bdev, block, size);
+	struct buffer_head *bh;
+
+	if (gfpflags_allow_blocking(gfp))
+		bh = __find_get_block_nonatomic(bdev, block, size);
+	else
+		bh = __find_get_block(bdev, block, size);
 
 	might_alloc(gfp);
 	if (bh)
-- 
2.39.5


