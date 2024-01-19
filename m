Return-Path: <linux-fsdevel+bounces-8323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851B8832E7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 18:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30C51F24BE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 17:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A855732E;
	Fri, 19 Jan 2024 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSxh3Si6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE69256B82;
	Fri, 19 Jan 2024 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687067; cv=none; b=iix220sIkczb9xWLW8Y6TH1cJw48nqZk3Rc0FstQoOya6yw2GX9tNWyoOToV4JJGRxnf+eUav4NrcRcgr640eKxd4LY0pjzC1660TrE7jQrLHNYobME2/hiGtsNxFYD/hZ3aIxpIis+oiwZ3a1iriNXbyqSiNw80ZkUmDM5JX20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687067; c=relaxed/simple;
	bh=3r6Ps27Llc8wvo+sl0Ydqk4JTC25uYydeBnhWmriC5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLmORX5qHF9A/w8TlZftW/n9bmFyLn8K9Hwqa8kOGx5H8JWqG0B/oEMTju6zQVrU4SjL6Bdz2cgAc4XPcQtjn0kyLvBS2mNqfbBLZawtlywfo4WasWK9KlTsH88P1wM5SyOsSV26sWB88EQ8WfUVKYJbPy04e2NAywcbNBxWkog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSxh3Si6; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2904e0d4c8dso663413a91.2;
        Fri, 19 Jan 2024 09:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705687065; x=1706291865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1I2P4swbcnd5P0eOoEyOlsfsVHIrwVgHFoyaM+P28Q=;
        b=NSxh3Si6mI6xwqShVr4ZNNZRAizFAZ78zbYxhXyoEbBIlsFJRDK9nTQMPwUamUs8AN
         5RSj21iCNCThx1t+wqJ6OdrIvRgEke39us6Ryfvs4x9JfhqZ6n3Qtmo80r40T2W7NdOf
         QcE99dtt7gQ6JKk5Agh/Qp6S/1EZvlkHkRx2uzK0Ibn0iAdxXcXQG6IJa/4QX8+rzNDE
         FBia38EFyWkiWiu9nBx0QGLDdpgwyc7r0uR2wiRsns96mnDneKHeS0occlrqrn5QHfMd
         tqkWmXBYziVbBHNduDhzQprQUntM0N6Hxmmq8M9rNfYyap2GP6XQpe8sFZc+gHhAbuf6
         PkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705687065; x=1706291865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1I2P4swbcnd5P0eOoEyOlsfsVHIrwVgHFoyaM+P28Q=;
        b=OtLNZewJy/8zcBO5Y9AkDKSebneW5ZFydg9fAC9h4yowu45Hsed5R39lmST9k4VGDK
         glGPrNczRnZ2JexAZwFAjyweCnE637H6BVRS4qWg5xHUDDw5qyW1yF+/shH17JsPCsTH
         CbDpWH8pMVVoskoLrG1smM52c6Bs4/DhMKe0gMpvWf4YiHpMei5njHkGXSCZhdI292+h
         Bo9VCZCembjD8aRxg1PilkOk0GArDggwRLVOd5qNjNyGV7HyuBXb7AxhogCf0T3Uf/wl
         s7IaqSYvcgLPKem5GO6JM5UmSOuQZL3to21+b782xleK9bCKyzCF51Ix1euV6nPC9RFt
         SL+Q==
X-Gm-Message-State: AOJu0YyqOJkFnX9BLg7MM3KqDlVvpJi47bJKJcJ9LbkI6xxQ8Wj3OTmF
	u4zt8ZCD3FSuXjMOoOKfffsf6TJmfqMSKR4AC4++63n4WFPQ120=
X-Google-Smtp-Source: AGHT+IGETO7vPXwpAB7/1ilhLgPkyDpKVIPod3/k8tQVATWjs2tASZ/4s1dh39hp1W1Mr1yBWeb+Cw==
X-Received: by 2002:a17:90a:800c:b0:290:11a4:ec4b with SMTP id b12-20020a17090a800c00b0029011a4ec4bmr140830pjn.61.1705687065008;
        Fri, 19 Jan 2024 09:57:45 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id sh18-20020a17090b525200b002901ded7356sm4202670pjb.2.2024.01.19.09.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 09:57:44 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	gregory.price@memverge.com,
	honggyu.kim@sk.com,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	mhocko@kernel.org,
	ying.huang@intel.com,
	vtavarespetr@micron.com,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com
Subject: [PATCH v2 2/3] mm/mempolicy: refactor a read-once mechanism into a function for re-use
Date: Fri, 19 Jan 2024 12:57:29 -0500
Message-Id: <20240119175730.15484-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240119175730.15484-1-gregory.price@memverge.com>
References: <20240119175730.15484-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move the use of barrier() to force policy->nodemask onto the stack into
a function `read_once_policy_nodemask` so that it may be re-used.

Suggested-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ae925216798f..427bddf115df 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1893,6 +1893,20 @@ unsigned int mempolicy_slab_node(void)
 	}
 }
 
+static unsigned int read_once_policy_nodemask(struct mempolicy *pol,
+					      nodemask_t *mask)
+{
+	/*
+	 * barrier stabilizes the nodemask locally so that it can be iterated
+	 * over safely without concern for changes. Allocators validate node
+	 * selection does not violate mems_allowed, so this is safe.
+	 */
+	barrier();
+	memcpy(mask, &pol->nodes, sizeof(nodemask_t));
+	barrier();
+	return nodes_weight(*mask);
+}
+
 /*
  * Do static interleaving for interleave index @ilx.  Returns the ilx'th
  * node in pol->nodes (starting from ilx=0), wrapping around if ilx
@@ -1900,20 +1914,12 @@ unsigned int mempolicy_slab_node(void)
  */
 static unsigned int interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 {
-	nodemask_t nodemask = pol->nodes;
+	nodemask_t nodemask;
 	unsigned int target, nnodes;
 	int i;
 	int nid;
-	/*
-	 * The barrier will stabilize the nodemask in a register or on
-	 * the stack so that it will stop changing under the code.
-	 *
-	 * Between first_node() and next_node(), pol->nodes could be changed
-	 * by other threads. So we put pol->nodes in a local stack.
-	 */
-	barrier();
 
-	nnodes = nodes_weight(nodemask);
+	nnodes = read_once_policy_nodemask(pol, &nodemask);
 	if (!nnodes)
 		return numa_node_id();
 	target = ilx % nnodes;
-- 
2.39.1


