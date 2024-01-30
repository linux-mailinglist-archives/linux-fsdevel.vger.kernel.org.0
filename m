Return-Path: <linux-fsdevel+bounces-9559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32194842B9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 19:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D991F28BCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF431586F2;
	Tue, 30 Jan 2024 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1zF+b0T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A339D1586CB;
	Tue, 30 Jan 2024 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638862; cv=none; b=udlgQV+BfFmuy3zroq0pOfpXZ6Qyg23x5MxD9tROl+VWsU0CBQZPk/iUFU01DY2yQCguwOlm7eRJC+AGAc9/fKpDbueyYl6cU3eykAqqWVTQLCmpyDspvl1bzO1VnWspXzI6JrZtReNzhXcjwkpIgzNfU0gSsVBB+qU3nyyzbT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638862; c=relaxed/simple;
	bh=Nc/Qletu6+zJXp1xkdWFc63PgpuhGv7hKfN5LGc1nlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ar9B9aRc+pft/GNrStqMNxmdaFoTUPxsV3ZsxyKkxX12EqUvwiS1va0c5H3SenQ8VgwuDfR9k74wPTLvfvyTySyl1O8/AYz7qoHGff7GsPyUyuuGsQaboylID3oH+YgtB/Ih32UauSQrTmruI3c6ooou84IXXHkAkUHGySf20qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1zF+b0T; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-6daf694b439so2012626b3a.1;
        Tue, 30 Jan 2024 10:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706638860; x=1707243660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3SsBm0r3LDCnRLkAzwTVLxQ2sFbW5+S1JsSVpdLy4I=;
        b=g1zF+b0TITRwXCU92BFOlxezeR9vbjej4YWUJpOnb1jzeUZVkj3m1YQQcpJoQ1QVTH
         eGgkD2RBKAxwmbDhtxpZmDRmb4OiuOHRKVmCMBEKZ5I3sM9YL10vDkF5EIb3OnE+hslh
         2TjbIeHDMh/KKMzwdPfGqbp3nMkKx6gfqFoz650NrY6649mh7tU7xnkFIhEqy5OHGM1h
         auwC8GZZTVEkDtgsheFCaC4V0r3MU/A5OsRGSUNKylZD7LPKVA6EipC6Mh+itIxwBb/Z
         /PwXlKu0G34g9Q6BemhWY+zRgD66/MQGh6uAlfkmpcjHabyZPvONuh1f67mgZ3vIr7Oh
         jE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706638860; x=1707243660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3SsBm0r3LDCnRLkAzwTVLxQ2sFbW5+S1JsSVpdLy4I=;
        b=StqWSVz4fVJjnZUS9nTJSJO3hR6ViBLZ+oDbQrWjyxOtNxLXJa4t4jUcuzGAIsfpBS
         aM9Zj69y6AK91nGHutwQ3sfY+S1iUkvT+gUgB3jZVvstbd3TgbeD43jdNdT3hd+50xWW
         LERpFB8ZCppone9+w7dIvrwDD5UuECEXXt4ZOuVD2b30wihXnabPXy9djbIZWHr5eEWf
         GHhoG++QLE4bBXP9kyTHy0hjRMjNEwQ4g/cB4Of0+DRhmW7yE5qvlQO1BQFGyX7znXcq
         6uQzcvtKG9X/fPV07Y4kK0u78WyMiJbgII5120a0iveFtUVreIdMgVqSOcGnYpb5BcGG
         TsmA==
X-Gm-Message-State: AOJu0YwvWa+h2e0HO9PjVd/68YnQ4g3EIAr1I0/Y4t6Lp7kBmBM7HZRW
	/twHZuBHl8g1pW0TUoV8BkjqX+lfjRNS/xUEyaIkBmWiTKz5Kt0=
X-Google-Smtp-Source: AGHT+IF658u5j+JGDTlh3pv0qgLkUrtejP5nowPywOp5J6L0lLHIY8AKt5LB2Ry3EAAY8M3F8cSZeQ==
X-Received: by 2002:a05:6a00:9390:b0:6db:de9f:5f10 with SMTP id ka16-20020a056a00939000b006dbde9f5f10mr5976134pfb.15.1706638859932;
        Tue, 30 Jan 2024 10:20:59 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id o64-20020a62cd43000000b006d9ce7d3258sm8460143pfg.204.2024.01.30.10.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:20:59 -0800 (PST)
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
Subject: [PATCH v4 2/3] mm/mempolicy: refactor a read-once mechanism into a function for re-use
Date: Tue, 30 Jan 2024 13:20:45 -0500
Message-Id: <20240130182046.74278-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240130182046.74278-1-gregory.price@memverge.com>
References: <20240130182046.74278-1-gregory.price@memverge.com>
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
index 440128a398ef..3bdfaf03b660 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1909,6 +1909,20 @@ unsigned int mempolicy_slab_node(void)
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
@@ -1916,20 +1930,12 @@ unsigned int mempolicy_slab_node(void)
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


