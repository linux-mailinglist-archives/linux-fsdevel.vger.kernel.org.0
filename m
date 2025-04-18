Return-Path: <linux-fsdevel+bounces-46657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B47A92FDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 04:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7AA48A5324
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 02:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97760267B0C;
	Fri, 18 Apr 2025 02:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="rVMv6hky"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CAC17C219;
	Fri, 18 Apr 2025 02:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942694; cv=pass; b=jaccyuMVLT8rYtQa1vdMoWM2BAT2lOeinV+zRrwQOf39KYI7KQRjh4FOoELtst6l3oB4xhdrKUOARU6FrhnP2m0iYmyk31NuxoO0OaQn3lJWgD2+tAzSDknLfA8WRfeler/jXESKfp2HqM/rcCH4fvayTWeTavFrKYM90mHufR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942694; c=relaxed/simple;
	bh=jyXbNiWiNzC1XA8NQAfHnyWbLLVvpyxgxF7Bk5HV70Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CiTZXGVcOHPRV+qtOe/LJ/sUys5K3Uw7KjrqEoC6EPfONwLL1PI01si0Sg5f66+n5o0I+QmEOovKjFmWDpaNPUpVQ4okvFHFKNO2qCN+zHiDyF3KLpVmrhI0mUKQx/CoVhFRlgTk2arTfQTGxjMfkuYmb59FIE6f6mHdjO5T3p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=rVMv6hky; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8B71B161484;
	Fri, 18 Apr 2025 01:59:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a285.dreamhost.com (100-110-156-188.trex-nlb.outbound.svc.cluster.local [100.110.156.188])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2CB7C160603;
	Fri, 18 Apr 2025 01:59:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744941575; a=rsa-sha256;
	cv=none;
	b=XEJ9RA6KXmvwd8Gv0JYxXK/2m8CMqF+ePjPwTGMLUzMz0j6HKa6IZd8kFeqWHU2tGSs3ZB
	OhvDqJenIZ1AiPf2Vpk91oIYz+LuLvgwnpI+p5Lob7HJm4s1LlvD3DYnwKVJrXI5f6e0N9
	4bqRKKdAS/3rNFsCU7t+5fJujJrfhpqEdVL3xsxLd+3TJvegZsKU2Xy7o0OIUN6R4e5Xjd
	L7auihzUfaC1haRiHhXxljcIp8ff5nFsezK2xWys/pVzNAJgmDnxsGNq7Q7drDgKHqZGBc
	U5oOdELnHT26Nw8JNCYOlLW8TaViw2+7hOYCMchBwH8X6IycAChP+oxmIsjiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744941575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=QC8hcWca1VUOV1taXWQ6Z+juBzwnD0z3CPqsdXKoeHc=;
	b=QtTD6whjx7vCKobg2CP6G6o4rVJjrcemVTTLgOmR5LP764Uq9Dz5ypB8gPh3GPt1sDu1Ym
	mb4vv4HctY5noKB9S8WQ037BQwF60dxU5wfDJmSug+ntW4+jxVCwKGOmLLsJ9NXBlugzWE
	3z3AIT+pWXuGza29hY9IXr+Nq19voXucVh8XWdkfNRTBHNmtNcMOw/58fWgWkqFpUbn7Hy
	sENDMMQJqFOBoQYsRox5xbMhf8eHDlvNHxVee57ho7n3Pcrz7mvpOUhHhquphUNn9SXK4c
	luMhp06KyTZyzVuh3eztZxtF4UAOJQyWp66EwRmPHWVIUX0LshayfGPtl/UzUg==
ARC-Authentication-Results: i=1;
	rspamd-7bd9ff6c58-mgflk;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Decisive-Army: 3982c68142220f2a_1744941575469_4289484740
X-MC-Loop-Signature: 1744941575469:2260933014
X-MC-Ingress-Time: 1744941575469
Received: from pdx1-sub0-mail-a285.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.156.188 (trex/7.0.3);
	Fri, 18 Apr 2025 01:59:35 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a285.dreamhost.com (Postfix) with ESMTPSA id 4Zdyck2WMxzGH;
	Thu, 17 Apr 2025 18:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744941575;
	bh=QC8hcWca1VUOV1taXWQ6Z+juBzwnD0z3CPqsdXKoeHc=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=rVMv6hkyQa8fjuM+QBSGVYfPcfqeaqnpMwAxt9TghL4tIonvCkNMrl3airJqMqno/
	 wHLVbaSLotbWqcLsLKDL/mKjWoqAZlXuDgrKX+V5PE+9p0ikWFnCVhdhlcljyjSa6n
	 cUD48qMK7+cl7r9xVOVJu8JCcigSk43mJM5KRnmYSlX8nOoPyhInwuEF/mUklsEVSR
	 I8atEIoU7HMJ5tRNS27jOvaQSBTugEYp2CydV1eGPgAIMYho8wPgjuOpwgW4lTnj3g
	 gSFU75/nvsKqRJVjMAYbbxtI6oaiAQ3zSIrR/zcD0qJg/Dbc3jCt2GCobDHWWdl3o/
	 wVOMZDjdFOhlg==
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
Subject: [PATCH 2/7] fs/buffer: introduce sleeping flavors for pagecache lookups
Date: Thu, 17 Apr 2025 18:59:16 -0700
Message-Id: <20250418015921.132400-3-dave@stgolabs.net>
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

Add __find_get_block_nonatomic() and sb_find_get_block_nonatomic()
calls for which users will be converted where safe. These versions
will take the folio lock instead of the mapping's private_lock.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/buffer.c                 | 9 +++++++++
 include/linux/buffer_head.h | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index f8fcffdbe5d9..5b1d74c818e9 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1414,6 +1414,15 @@ __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
 }
 EXPORT_SYMBOL(__find_get_block);
 
+/* same as __find_get_block() but allows sleeping contexts */
+struct buffer_head *
+__find_get_block_nonatomic(struct block_device *bdev, sector_t block,
+			   unsigned size)
+{
+	return find_get_block_common(bdev, block, size, false);
+}
+EXPORT_SYMBOL(__find_get_block_nonatomic);
+
 /**
  * bdev_getblk - Get a buffer_head in a block device's buffer cache.
  * @bdev: The block device.
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index f0a4ad7839b6..c791aa9a08da 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -222,6 +222,8 @@ void __wait_on_buffer(struct buffer_head *);
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
 struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block,
 			unsigned size);
+struct buffer_head *__find_get_block_nonatomic(struct block_device *bdev,
+			sector_t block, unsigned size);
 struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
 		unsigned size, gfp_t gfp);
 void __brelse(struct buffer_head *);
@@ -397,6 +399,12 @@ sb_find_get_block(struct super_block *sb, sector_t block)
 	return __find_get_block(sb->s_bdev, block, sb->s_blocksize);
 }
 
+static inline struct buffer_head *
+sb_find_get_block_nonatomic(struct super_block *sb, sector_t block)
+{
+	return __find_get_block_nonatomic(sb->s_bdev, block, sb->s_blocksize);
+}
+
 static inline void
 map_bh(struct buffer_head *bh, struct super_block *sb, sector_t block)
 {
-- 
2.39.5


