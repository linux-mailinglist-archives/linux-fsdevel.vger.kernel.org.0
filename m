Return-Path: <linux-fsdevel+bounces-58659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D22B30681
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1FF660325A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A64838D7EB;
	Thu, 21 Aug 2025 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="iEQUrkg9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B438D7CA
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807651; cv=none; b=Iwp20+8+Ue4+Wu+M72Q/IZ0ZO0zwoYG8sGeAErCNrcQk9NPsPcnyqNrVN9cfqZKuu2ZsDweZOI52JJUNzWmwRisH6Agz1wgDdCLvFGGHsiM/HNev4/Lyj1853PJWXFf0i1wi9AKncbFxRgnRfBIprxXbX7IXRY7jIBvPId1Huhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807651; c=relaxed/simple;
	bh=QDCTsMl47vNCm4pEABV38JgQSqrXPVXZ8WOdWXUjr7E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmyvrNVKRpuwXWJC2MXSE2ERyYqNI+AKuTPpr11lDNlqZIRgem1ofMk1GzChN+S3SVKZCWAaoVymiTW4XU/E5lCwj/C73MQo2ZClt/WVsxcOrDip3rKx/K5wTF3DeXBEmQWUr2OcWfnF6B+1rOvbU/F80LOx01DpPYA7XeKQkK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=iEQUrkg9; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e951dd06849so65075276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807648; x=1756412448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPlcwVE6H0J7lPhjU7xhzvHl7lwTdtHL6DFVeSS7hKM=;
        b=iEQUrkg9gVl84ttehK6DWSMBd/CBNBiNqxHvlznvZ0tDZndP/QMkXPSXXrKEXe+4t4
         zqmvP022CCqJtShbRkl1f4/M9Jk/08sZ6RYtteC1tJFQrrFiBx1rsRcgiTozBLnYo6/U
         kkuXVQUO8s+YInEbMIqenJnPVcbIIILfFO2M61+lKZFi/7OnZ20nXSiuoQQMgPYdE9JT
         xoQvFxfUIvzx64OMWkRGIr1DSQO1BBeiQNYEgkqsbgCeP/bKsTMMEP0bXDMbTBQ/gT7a
         RSiKkEv3WreR1q0OjO6IxpuTfUynCJFSWK+Wx+o6gbyQBX10pFoemCVhp+fVzIVLYjMo
         i2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807648; x=1756412448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPlcwVE6H0J7lPhjU7xhzvHl7lwTdtHL6DFVeSS7hKM=;
        b=H3TrOR6mQJStk7SCoUu4JwQ+rzdX0q4ZzXBLUZXcjIf5T6Wzx6Ac7wk9gPfGSvx00l
         hnUIVOQIdGnMJEPaaJf2QBe0K7UTXr3fEk4CumtjVSXCHcRmOwQ3gIwh6rOT/ifNd1Qk
         ySbV65zAjAEkCpqL5jt9s/jcWxJ1vJgaRoi1rgeRxdutZcSPy1ZSu8YKBbloEJcWi+M+
         c/R1hZSLcUmH6nShWWHtNkbshetgiirbVAA8COcZG+XgoXvto0lbOMIMbGRLrKLjsFXC
         lukG8wuBGxd5IN4KO3CPBT8Xfl5h626AaIm0ACuT3ydCjn1rm7OnUFo1x9Wz/YQx46DH
         3fxg==
X-Gm-Message-State: AOJu0Yy3oizzcmzPXfiIDZC6+KAc59bWX1EnPEw0FCrqMqpBwLafZBJW
	38cPXyL+SCArWh6Ip//d7lpM0JQEFngnvfc9QpHsWmtt0dEvKep3LWiUjqahg67r/0MAdymhAW1
	F3yr31Iw67w==
X-Gm-Gg: ASbGncsgpQQGGQqc/U2b+r1xlaqiUaYY+tNzxXrkedjjESXnX52PCnsOWnRK47f5CDV
	sTyD90/hNzba5EmNBjrOgp2Fijxt1BxPHZKWS3D6d9qSBrV8+c/Sv1X5R55G3X6Mj7wsxC+yjib
	tKsH1y1KWZGpbEf6BMRSBHsOvsscTF8j/S+4aWi0ImSCBKe4FxLbxp7rLbG1Dxw8s8yUeod334w
	h7pRHb7+AfqSznMN1+cO1pkAgrV2i9L59XZDvydn/tseCVLADf/dYFBCVBQVxXOlH+M5wSP7Sga
	oGKKVWCLFSSgd5VKmDqkHrYJyvmBh3GAsfhuwlWGLIOrrmuPDeSSduZRHQ9lSBl2LAWENFCT7rS
	cEBn41gUn7GJvKGX1a5VKdyYGXD6YTwGAAllfSCtA/6T7KfVwJk8G20AlMgo3yaO9ah66fA==
X-Google-Smtp-Source: AGHT+IGw5PNNsEWsBJ7M5Vz46WMQ8XvSWM1DvaLtn7uGKcRIEygyel+PAyOdDJrJ1R2bbH5CNEKGeg==
X-Received: by 2002:a05:690c:6601:b0:71f:9a36:d340 with SMTP id 00721157ae682-71fdc536729mr5987577b3.50.1755807648474;
        Thu, 21 Aug 2025 13:20:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e830843e9sm35039647b3.73.2025.08.21.13.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:47 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 22/50] fs: use inode_tryget in find_inode*
Date: Thu, 21 Aug 2025 16:18:33 -0400
Message-ID: <0fca9386c2eca65e7fa5a39faca34ebf42d71cd0.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we never drop the i_count to 0 for valid objects, rework the
logic in the find_inode* helpers to use inode_tryget() to see if they
have a live inode.  If this fails we can wait for the inode to be freed
as we know it's currently being evicted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index b9122c1eee1d..893ac902268b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1109,6 +1109,7 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 }
 
 static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked);
+
 /*
  * Called with the inode lock held.
  */
@@ -1132,16 +1133,15 @@ static struct inode *find_inode(struct super_block *sb,
 		if (!test(inode, data))
 			continue;
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode, is_inode_hash_locked);
-			goto repeat;
-		}
 		if (unlikely(inode->i_state & I_CREATING)) {
 			spin_unlock(&inode->i_lock);
 			rcu_read_unlock();
 			return ERR_PTR(-ESTALE);
 		}
-		__iget(inode);
+		if (!inode_tryget(inode)) {
+			__wait_on_freeing_inode(inode, is_inode_hash_locked);
+			goto repeat;
+		}
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
@@ -1174,16 +1174,15 @@ static struct inode *find_inode_fast(struct super_block *sb,
 		if (inode->i_sb != sb)
 			continue;
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode, is_inode_hash_locked);
-			goto repeat;
-		}
 		if (unlikely(inode->i_state & I_CREATING)) {
 			spin_unlock(&inode->i_lock);
 			rcu_read_unlock();
 			return ERR_PTR(-ESTALE);
 		}
-		__iget(inode);
+		if (!inode_tryget(inode)) {
+			__wait_on_freeing_inode(inode, is_inode_hash_locked);
+			goto repeat;
+		}
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
-- 
2.49.0


