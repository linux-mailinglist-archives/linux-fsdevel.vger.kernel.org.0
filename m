Return-Path: <linux-fsdevel+bounces-8999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E26E183CB5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 19:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6501C23060
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 18:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46F01350E8;
	Thu, 25 Jan 2024 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJO2T0t1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068661758C;
	Thu, 25 Jan 2024 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208243; cv=none; b=UvEKOGXB3KWUOpxc/VeRVH1tGgybi1HAEN+CueCS+Yvi30jHrcaj6x3+dvtTOILvi81sltyP9KBbR9rq3pJmZuKUUr1J6rngoET/bF99AH8ahn7qYb9ZZRyt56IGcMy9ZLi6/SQdWIRIeAecccNMcVLi5929jAJ9/lZnV29X8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208243; c=relaxed/simple;
	bh=R+zdl8Rbvfn3XwhywHxnZHDY+Le4DTtVRLSN2sCUJaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c0E5qCWxdcqVecxdLyomBpDJ7bKYEOVuUUSk7YegryV6ldZyG7/SIlx+09cBxi94lAFc4YmhxOLLUxIdhgVk0VjF29WZ0AXufvwF3BI+MpNR1fJScKGv0uvf6zBS/et0za4z+A0cSCEnAKcFiBOKjy/mG9YDy0t88ETtzBvkDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJO2T0t1; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so1587338a12.3;
        Thu, 25 Jan 2024 10:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706208241; x=1706813041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzGhMbeDHhADN16eti5ZGSWn33ZQML077ijAcKWfxyI=;
        b=GJO2T0t14MC+4SpyJQNtD14qXCdZjx85Kklp6yx5yz8P4RIFbVnmILivCzJ9S2Khue
         3w66LWneNoTs+fe2xRRyKWqKpTHDREmJ1K/nb+1FLAQ8q2F/Lin5Z41Lz/ZtTAd64eSV
         6QqgpLbQwV98JpGwWn5qFEf16IKIlRKo2BosAJcphz/vrtGFybvPLTzQVRtOEKH9nYLb
         nJwwik1LrzFkNJU8bRvEEFEBm+/j5TsGOs64LSl+RMJJ5E6jFM5QXrShzMqtua6OkNgW
         JEnoSKt1pOT0jixYl0qgpU6q+d8lXHhDwTxOETWTn4l0XFjBPD7iH5RLmWYk0/lumLqs
         Kk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706208241; x=1706813041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzGhMbeDHhADN16eti5ZGSWn33ZQML077ijAcKWfxyI=;
        b=O3vuRouOG/Ce/GxoOYCP6TRJn0m8x/luJZOYUXQ1owJe2asvMrmrThgM9lbv754Ohn
         Lf4g+IOjQUTgLmYX6QkcHlGpp8ql4VtQorSFqJAwb2KVNe8Z7uQtl9dUrPUa+Lu6IWmL
         FuSS/dPejeV42ssiuQpX2eH2GxZqHsE95NO5hXVjKmStoSc5U4aG8xP52YdVjpGAwxKi
         4NY/V9hpaGYciy0mxag6ou9aSnalLIyEXTZjOuQG76zn1v8qSRuV6IQGdl4d2yjHH89e
         Wsq312u2awcwFdgf86Iou6KaWJCGzQPTGihq3x7zWM+NUx1KaOI3GlZjN9XM01CQZWaw
         xlRg==
X-Gm-Message-State: AOJu0Ywqa5IiWRI7/K73B0tNxVrLxrNfwa2zQbzOA+FJKpLx37Xa2Edn
	nDVzr0LOsuYfTN5SkuS1nGfjg81fSIBW2MHhnE19SyTyG8oTioc=
X-Google-Smtp-Source: AGHT+IEcH1Tk+08R16sVhPM8oB55q9tIFfKiHt4xwLriTagfM09GAnko6cUAoLV1xiWOuP2rG1zkBg==
X-Received: by 2002:a05:6a20:1e52:b0:194:f8dd:4277 with SMTP id cy18-20020a056a201e5200b00194f8dd4277mr81192pzb.106.1706208241161;
        Thu, 25 Jan 2024 10:44:01 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7860e000000b006ddcf56fb78sm1815070pfn.62.2024.01.25.10.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 10:44:00 -0800 (PST)
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
Subject: [PATCH v3 2/4] mm/mempolicy: refactor a read-once mechanism into a function for re-use
Date: Thu, 25 Jan 2024 13:43:43 -0500
Message-Id: <20240125184345.47074-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240125184345.47074-1-gregory.price@memverge.com>
References: <20240125184345.47074-1-gregory.price@memverge.com>
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
index f1627d45b0c8..b13c45a0bfcb 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1894,6 +1894,20 @@ unsigned int mempolicy_slab_node(void)
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
@@ -1901,20 +1915,12 @@ unsigned int mempolicy_slab_node(void)
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


