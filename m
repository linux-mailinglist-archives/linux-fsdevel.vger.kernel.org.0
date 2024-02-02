Return-Path: <linux-fsdevel+bounces-10054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DE7847591
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740E31F275CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C734214C581;
	Fri,  2 Feb 2024 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcL/MHkO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DAA14A4CC;
	Fri,  2 Feb 2024 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893375; cv=none; b=YdtH+L5hCuIbqo/cILUIHSikrjkQsxpu4Cpoa8pH9NYvM444oqEnOtVKnqZGjYrDlTFOEqNVmvL5rCt7u89WTSXaj9L1aUcbFMsh2pfMCVw960n7Ode/EaoW7Na4iDQU4fHpa961M1XjbBMBc8rBYsKXEoxM10MeZ9l00SVwrB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893375; c=relaxed/simple;
	bh=auQoPWvfixbKGhEErYzSn6fvQh0PFU2VbL8KK5Ns2f0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KvEk5g+3zNstvYTh599oV8PC3PDRlazk/k7nHkyRlGEWA5Ix9IG9tKebpBv2cL0HA0LJfscme1faNYWdSmtb3iB8sqpj/oZ4aAcvqhmPxlUaV23N/qzHDFEEDQc2dcG22azwKXer0/Hj3lcl751bau+iiRZiH1y01ub3ZWR5e9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcL/MHkO; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-5d8b519e438so2260657a12.1;
        Fri, 02 Feb 2024 09:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706893373; x=1707498173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AF6y+MlS2Aaikvfug37kciivlA8KerG3tHxNDefUBs=;
        b=lcL/MHkOh05MtiQAg5A1r5/tG8COkihFG8FqrzZeaHzu6n3bfWAlDTrWo2J3hw/wWN
         dBThYCnz0/AcVUolKJRx5RfKBKal4APPSTRmFVWARXDNra+0feVbEiZ47M7au9Vzqv8m
         vswKICzbdmr7ROkm/pWDuLmQALd1vFPp9RuVWVrCM/AMQRsnM0BvCY+keB1DdQjG5Vqs
         +3PLcYS6Oi4Wz6lejYJSItaDiHFBr5t1khbTPjxs+8zQAB7hlSrtrPrCtE8TPyxHPn26
         RnjW7XjSoQqRngbMbtGWUZWpEt5ZhOp3yIjehDn6rGdkh8C1kCgPq1+B+T7fzG+5bC6F
         yJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893373; x=1707498173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AF6y+MlS2Aaikvfug37kciivlA8KerG3tHxNDefUBs=;
        b=V28FngkLPO6PwiJ3qQuiaQ1Spgg2DwkTYPrPPtZhxiKXLwxN2clryZVJvAZT3HmGja
         eA2HSh1hOHJRXLXYfYGMbHQcPMb+GqPD0EklmW6CfiQGoTLcE77OeArATyF2aAnj0we9
         99RMIjRvWTK3HfM4JdQPJoch7/vcTgg+vtpbUAaF9m6LGO0vuZLC0cTuaBg8YhpjRLlL
         oRFrBKWNm5NvDRmrvjCwGaatVLN9AhPm2v+zBu7vy+2enIYcUpOZTn3iA+64D3wOG9dN
         rGAKuznwScTIt1+yiT/8fibJ7jXNlFwBwIJMI/+O7ktGkJHj2oUe7mR88eUvnYHjx+gl
         k5aA==
X-Gm-Message-State: AOJu0YyxC/LTgVaqoEtGOyIyPg46WKCcVXlg2AyZ2s+EDo0AjGHCccw2
	boJLZ1YiwSqfEGUl0CQFMPpu12XWOB56Kz1Y7ix8TjH6kIm1VdU=
X-Google-Smtp-Source: AGHT+IGEuQgxleUGw2gTIz9dWiT2Ix+7OW0Ula2oMbyOkn4BnUCm750NIoGlS3+JmLjBQmBSRbQCPg==
X-Received: by 2002:a05:6a20:11a5:b0:19c:a03f:9e5b with SMTP id v37-20020a056a2011a500b0019ca03f9e5bmr5472769pze.5.1706893373148;
        Fri, 02 Feb 2024 09:02:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWxSeV0i/3cN4FkA1qBO1h6KJWwIQ3BOVFyBkzVfgpbI4zhiU+/ry+RXGd2YHfKOFGBzl679cwDxXk5cqAvgFrLqJ8O1KZXD1Q9EpnRdpm9sXcO8cisT+CHJtr5h/kDNROOF9Va7TjOLDkjaNKd3cqlWA+gy03VX/OlvH5GnHBeR1Gt8IEuBFg99qs7oWP6KwV0lu2lZAIOhl/jrWgoYjteDCd9eRR3SAXyzTTxNSidXpdoeLXuw2fYaN7t24eZGHjxJdIw3Jt/8DZvEQuRtIYRqI2CPkPFHbfeTPR/3xLlVtpPLXy+Xu6aVvWLB0fQ5U0Dxj8we/t9n9jJTkFOBwI+VcZlKD+HhZ4OLz20he5eFmQU+uwn/2HaElnr+Rbyf6+1o27Z39KUA7wphCy8EV2tylhXnl1rnPwVIskJkZ821xQmnsjd58oZDz7LH/tygJzxdoIOfpKMslnBUlBtvZ9uNS+yJiancVN5G5vUOEGuu1AAysUYar0K1cUreuu7jYnaDHcDYfLrH0x24Z/JJ9GgYh70jaKsJRu1XDCa25tYEbH+AYBkbBDh4w6Z/gIi5RkEvYlVV3BVaYTdbxs0yWEIpS5m2prUcz/8nWAigpUqhtLAlr+8EnektxAbM/I+rbmlyZ6HA1TchyHctsmFmlNHQDnLwpEBrpQUhvQHTVs=
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id z22-20020aa785d6000000b006ddddc7701fsm1866578pfn.4.2024.02.02.09.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:02:52 -0800 (PST)
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
Subject: [PATCH v5 2/4] mm/mempolicy: refactor a read-once mechanism into a function for re-use
Date: Fri,  2 Feb 2024 12:02:36 -0500
Message-Id: <20240202170238.90004-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240202170238.90004-1-gregory.price@memverge.com>
References: <20240202170238.90004-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move the use of barrier() to force policy->nodemask onto the stack into
a function `read_once_policy_nodemask` so that it may be re-used.

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/mempolicy.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 41e58c4c0d01..697f2a791c24 100644
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


