Return-Path: <linux-fsdevel+bounces-38707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B40A06E55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 07:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5967D167952
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 06:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0492D201018;
	Thu,  9 Jan 2025 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b="JvkfvkAm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cse9jzVa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD7E19CC14
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2025 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736404458; cv=none; b=i82WXhYgXKzByJPDC5f6Oq2o9MWMM+Cb23e1yTONN3ysJx13xhuJ3M6I2Rm9SI7wltbuvdas3MRvT81m5Jk6vRrf6P8ZO8zQq4E+IPrbqLLABY2bqz6+yyqGqEaE2YZJfHVq2eG++3h2xuq4IznrPguoA6CrNOhfpdq9K2PPPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736404458; c=relaxed/simple;
	bh=CMKoChQyFzWA073qohuea95FUzn5CpbGVY/JgZr4SNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qD1n0g8yNDuvS/t9Zl1elma4G+O7S6NelXKapJUjpmJK27ptQ66MytMJhoZezc2B2xr6WGnFzLKMuokFA/dugisN3XYcb2cTOkGMThN1yRFQ/X0PZH95+tqhYm/Kuudu+izL23ycPCUg4Wu1dCTAYCyAkSPYujQY4hgesqExBOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io; spf=pass smtp.mailfrom=devkernel.io; dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b=JvkfvkAm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cse9jzVa; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devkernel.io
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id D65C01140169;
	Thu,  9 Jan 2025 01:34:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 09 Jan 2025 01:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1736404454; x=1736490854; bh=trX5EeQwImb16/yYuWr2d
	bMrpJFC9z272st4xwQ6DGU=; b=JvkfvkAmdj1pPxj25+v49pCLQ9aQr4DXdcAPF
	XyNl8UD3i/jyp10phsg0gLxQn0Nb9e9Njz19c5jVFByltj/6ZxudDkjLLuA1sf/o
	zD3YPp6jrAT+/sKQtpu7nlrwZ9fFUw6+FW3t7GwDF039JCtDjgYRwPml5146fnjb
	Fe3okDUwol21VW/BBEm7tYbDmpLTAGfuAtu0x3pFO/lt8soIA+s5OcEIlTqd4MEl
	sU+5ugQPxnH1S4z/R7h4UhuvudPjRd98O15rPaIk9yu7uP4JnqAWmlNjRl8kxvml
	U1YoAZtADONm8GT5tBsIG4L4KLo8H1Yxd5yl1Z7nB7jGA2F8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736404454; x=1736490854; bh=trX5EeQwImb16/yYuWr2dbMrpJFC9z272st
	4xwQ6DGU=; b=Cse9jzVaPEhsCYsbq2vmry7XAR+O/yqaXj14kXKUJrmyKPoJFIK
	8esyk9O2FK1WO2kJhPtLxqOXPlSKKybZ92FbSQBw4/f5PQKo6FrzJtt770RiFdLC
	hu+WQmzxq/eF7Al8ZhPjr/p35vG5RrlCuuLJjiyLagpRGC3zxW3L9Q/r5LcM9aPc
	XkTgxVvMhDO1viuHvZs6RKwCeLdEZ4iHb7r8TdwSvm5PyRL3PUGe/fjuoWdADLku
	bKSxX/LgeOZ4vOxnJhtqkO85pHnWszDnVYiVIwudntBx4dpyKpMAQMbbTnotj+EJ
	kabOIcAkaBLgcVgiUDOVK/h61VESPCwr+fw==
X-ME-Sender: <xms:5m1_Z4poRMXg7hU44ktUHkr6kDXSOul2GGgIbBjqGEZrIY2cHmNNFQ>
    <xme:5m1_Z-qaOser0_CiD468Vs1ACG4xKztMZCqeNl9lVXu82Vm0DoB35sD8rjkIpe6IL
    sKrorC7RJHCe1l7Mz0>
X-ME-Received: <xmr:5m1_Z9OJOi4oDK2i04da5QMNTQ8BW-qbOL2FtDacllX50BFoXqOEhIyrlZ4lHoWVJ34Cz3xx0903Y_vr0SZMJQLImCi7PBrblVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeghedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvfhgrnhcutfhovghstghhuceo
    shhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrghtthgvrhhnpeevieegfeffhf
    ekudeuieelgfeljeekgedthfeiveeltedukeegfeeuvdelvdejueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihhopdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtg
    homhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    ohepiiiiqhhqtddutdefrdhhvgihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghkph
    hmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhrhesuggvvhhkvghrnhgv
    lhdrihho
X-ME-Proxy: <xmx:5m1_Z_6sJ5ShQFh2jSj2pjDJVpuPG2SIQfcpu3iibHQRBTrc0prBIA>
    <xmx:5m1_Z36gvLQuJ06AlNsqxqNTMZLb-w3LSrNEhZI_g0_EF2EoEjLcUw>
    <xmx:5m1_Z_glkCVKto5WWcTb1uQiNFEwxjsS3PWAUe05-VmKKsO1-XQAZw>
    <xmx:5m1_Zx6MugPN8CXgDZFh51t-eO06MFFqJbDE6EeHvADAPilc1ae73w>
    <xmx:5m1_Z6aziO-9w_748h_11uF-RglSME43POLxsRL8IMWMeBMYUaDyiEWS>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 01:34:13 -0500 (EST)
From: Stefan Roesch <shr@devkernel.io>
To: david@redhat.com,
	willy@infradead.org,
	zzqq0103.hey@gmail.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: shr@devkernel.io
Subject: [PATCH v3] mm: fix div by zero in bdi_ratio_from_pages
Date: Wed,  8 Jan 2025 22:34:11 -0800
Message-ID: <20250109063411.6591-1-shr@devkernel.io>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During testing it has been detected, that it is possible to get div by
zero error in bdi_set_min_bytes. The error is caused by the function
bdi_ratio_from_pages(). bdi_ratio_from_pages() calls
global_dirty_limits. If the dirty threshold is 0, the div by zero is
raised. This can happen if the root user is setting:

echo 0 > /proc/sys/vm/dirty_ratio

The following is a test case:

echo 0 > /proc/sys/vm/dirty_ratio
cd /sys/class/bdi/<device>
echo 1 > strict_limit
echo 8192 > min_bytes

==> error is raised.

The problem is addressed by returning -EINVAL if dirty_ratio or
dirty_bytes is set to 0.

Reported-by: cheung wall <zzqq0103.hey@gmail.com>
Closes: https://lore.kernel.org/linux-mm/87pll35yd0.fsf@devkernel.io/T/#t
Signed-off-by: Stefan Roesch <shr@devkernel.io>

---
Changes in V3:
- Used long instead of unsigned long for min_ratio / max_ratio

Changes in V2:
- check for -EINVAL in bdi_set_min_bytes()
- check for -EINVAL in bdi_set_max_bytes()
---
 mm/page-writeback.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d213ead95675..d9861e42b2bd 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -692,6 +692,8 @@ static unsigned long bdi_ratio_from_pages(unsigned long pages)
 	unsigned long ratio;
 
 	global_dirty_limits(&background_thresh, &dirty_thresh);
+	if (!dirty_thresh)
+		return -EINVAL;
 	ratio = div64_u64(pages * 100ULL * BDI_RATIO_SCALE, dirty_thresh);
 
 	return ratio;
@@ -790,13 +792,15 @@ int bdi_set_min_bytes(struct backing_dev_info *bdi, u64 min_bytes)
 {
 	int ret;
 	unsigned long pages = min_bytes >> PAGE_SHIFT;
-	unsigned long min_ratio;
+	long min_ratio;
 
 	ret = bdi_check_pages_limit(pages);
 	if (ret)
 		return ret;
 
 	min_ratio = bdi_ratio_from_pages(pages);
+	if (min_ratio < 0)
+		return min_ratio;
 	return __bdi_set_min_ratio(bdi, min_ratio);
 }
 
@@ -809,13 +813,15 @@ int bdi_set_max_bytes(struct backing_dev_info *bdi, u64 max_bytes)
 {
 	int ret;
 	unsigned long pages = max_bytes >> PAGE_SHIFT;
-	unsigned long max_ratio;
+	long max_ratio;
 
 	ret = bdi_check_pages_limit(pages);
 	if (ret)
 		return ret;
 
 	max_ratio = bdi_ratio_from_pages(pages);
+	if (max_ratio < 0)
+		return max_ratio;
 	return __bdi_set_max_ratio(bdi, max_ratio);
 }
 

base-commit: fbfd64d25c7af3b8695201ebc85efe90be28c5a3
-- 
2.47.1


