Return-Path: <linux-fsdevel+bounces-3485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0807F5248
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 22:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F512B20F6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCC61CA8F;
	Wed, 22 Nov 2023 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpCN+Rfz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D4BD41;
	Wed, 22 Nov 2023 13:12:30 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-6cbc8199a2aso239284b3a.1;
        Wed, 22 Nov 2023 13:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687549; x=1701292349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ytb+zLJCPBPTeP+HrayDkCJaJ1nmZr7MUC/QCQp0Rn8=;
        b=VpCN+Rfz0k6df6KdgOAJqVdlwGCL1xYt1DbAqiyLKtIAYGBNWAK15OaSgKlYHaA9Td
         td8PdKQiHXmAL06x0fNiErR4d6Szu/1UZ2+OlPyAyEhpDiZBWFDCLWX3QM3/01UHGY4U
         R6QBcTJSHgv6nzzVNcofnNXOqwnYGDEpdD8sYhCqUC8Wb0UzHFkVcwQR/TFZ7hPDMpZG
         3Va2OjxEAJcij/mAOO4qfIbtZIHjm5i7qnVgPtQ0bs/x+X2AJJKSPdi5m32l0rwAoW/f
         prtc8LNNI9ycudrLBrTUFS7ekI1M7FVgzxpHqmLQ7Z6AllzKaIVYBKBvcS0A1cOI7wQP
         qR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687549; x=1701292349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ytb+zLJCPBPTeP+HrayDkCJaJ1nmZr7MUC/QCQp0Rn8=;
        b=JMoUL41RiZlMAAb3sA77J/hR6zHnPnZ0BlcFDqnSxLUg6vaPTVN7YTX4i+XICBYRK/
         2SyDGbJZP+R62sgQzurlBUbg96Y3xB4jH3lJSbM1H83w0xz1d7e+eH+YAI37tYJVsD4I
         o9BzYUdxdmgtG5ZhT2wBHNlPtdcpxAQGPvMxEO/4J97WNna/izw/JwQuSirnwpROwisF
         bnbREmviswuwxHfFS4kQBt6eFUDS7WPOwB5NdIdSYgvzyYU8RYYyuiSolM6uFmJ6GdoQ
         236nPG6MOmMfZmuP3na4UKh/CsPa8Ge3CWi790ruhMZNHmIpdCy4baWS1ZBQ1KMwrSvv
         mFmg==
X-Gm-Message-State: AOJu0YyxjEzyfYiRI1j0aJOtfgQUQHnVfzofq2bhEURK4rVJwBjMx84p
	05p6jwPxjcukmOuQBtqkQw==
X-Google-Smtp-Source: AGHT+IFKLpnDulOr/ZPYNoDPRpcqX2G937AQ6Vr6ejSPK5ZU1d6oIX9/jtBqfVf6LI42wNWwo5Yp6w==
X-Received: by 2002:a05:6a20:3d8f:b0:18b:37b4:e4e7 with SMTP id s15-20020a056a203d8f00b0018b37b4e4e7mr3025618pzi.39.1700687549206;
        Wed, 22 Nov 2023 13:12:29 -0800 (PST)
Received: from fedora.mshome.net ([75.167.214.230])
        by smtp.gmail.com with ESMTPSA id j18-20020a635512000000b005bdbce6818esm132136pgb.30.2023.11.22.13.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:12:28 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 08/11] mm/mempolicy: export replace_mempolicy for use by procfs
Date: Wed, 22 Nov 2023 16:11:57 -0500
Message-Id: <20231122211200.31620-9-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231122211200.31620-1-gregory.price@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will be adding a /proc/pid/mempolicy entry for use in swapping
the mempolicy of a process at runtime.  Export replace_mempolicy
so that this can be used by that interface.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 include/linux/mempolicy.h | 9 +++++++++
 mm/mempolicy.c            | 5 ++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 931b118336f4..b951e96a53ce 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -177,6 +177,8 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
 
 extern bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone);
 
+extern long replace_mempolicy(struct task_struct *task, struct mempolicy *new,
+			      nodemask_t *nodes);
 #else
 
 struct mempolicy {};
@@ -297,5 +299,12 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
 	return  false;
 }
 
+static inline long replace_mempolicy(struct task_struct *task,
+				     struct mempolicy *new,
+				     nodemask_t *nodes)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_NUMA */
 #endif
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index fb295ade8ad7..e0c9127571dd 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -815,9 +815,8 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 }
 
 /* Attempt to replace mempolicy, release the old one if successful */
-static long replace_mempolicy(struct task_struct *task,
-			      struct mempolicy *new,
-			      nodemask_t *nodes)
+long replace_mempolicy(struct task_struct *task, struct mempolicy *new,
+		       nodemask_t *nodes)
 {
 	struct mempolicy *old = NULL;
 	NODEMASK_SCRATCH(scratch);
-- 
2.39.1


