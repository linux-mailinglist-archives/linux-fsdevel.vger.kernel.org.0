Return-Path: <linux-fsdevel+bounces-5074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7977807D53
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 01:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F982812F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB7C539E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaagYva7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D6218D;
	Wed,  6 Dec 2023 16:28:16 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5d3efc071e2so1014707b3.0;
        Wed, 06 Dec 2023 16:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701908895; x=1702513695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Flml1UNmBLLzB1/s7Z9Ivu1nW91eSQVCRu4FPg3vOUU=;
        b=aaagYva7WvXvsbKwPcvWHVGHH97ACRu2dViRmx1tzqPuLq/mY+A7UQx5N7Usinn14B
         3NeyMlOHJq5xFph0EDzD1oe0uC4qYEFTIsdQOS5nhDgLRXJJgwUy9d/5b1/kGRmfHqg/
         1N5nWVVlxo6dj9esIHLuCCWyo0t6aHrgHC9g048/jDY6IVKaILhlKpIlbky5Zvq90iY5
         687QYQtdnHI46dmwi57y13TsoAxeion80wy5WwjAqmFyXVBj891TujYEJdRt9n3SDPC0
         n2TjYW4io2ES9ga8BAbmykU7/Ck3whlRF1h5foVBK/y8/5NqGihfqZUaOmXKcs5Yc1d6
         iHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701908895; x=1702513695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Flml1UNmBLLzB1/s7Z9Ivu1nW91eSQVCRu4FPg3vOUU=;
        b=M1umy21Z0Zq4Wf6KFsrbpwSs49gjD4FVeypIKjxZg+v4Jv+/JffxB/Wr5k25SLfMPc
         xABuyeKotoa/DASBSvEO98lZtnhADLn9I9nKD4qXlMja/wWIas6Z1foLCxLIYw6aVJl3
         q2d5Gh2fxG1cBI/m1zMjMECriF629i9USceU3Pqec4/A838Wuc3RRo28DpaTN3Di9WgY
         uXIEfrZOSPRLPJn+cqk+XO8asg+7ou3bMvLRnNa/S7CrQtXJjvkEDwRHWzPEfVUJ2i7y
         9CyaoWxgKmcKjzBDp3faYmnGdz4BP4khd/yrUvdhqcilfsz9uKj1wl+n4bRQlsc8xna6
         PlhQ==
X-Gm-Message-State: AOJu0YxJkFSxyPKoSmSszdg6fTmuCU54bWOb+nE8P004mhjKSs99epMk
	WGZ+7JJ0BjeF++6P69tj2Q==
X-Google-Smtp-Source: AGHT+IE51TPShPAvD20Fk8hXysJ2a1fAapf0M/BF9W0GPAFus7ZCfhCYhR2w/eyZazXAbFkHfg63dQ==
X-Received: by 2002:a05:690c:fc3:b0:5d3:9f2d:658c with SMTP id dg3-20020a05690c0fc300b005d39f2d658cmr1911791ywb.24.1701908895635;
        Wed, 06 Dec 2023 16:28:15 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id x145-20020a81a097000000b005d82fc8cc92sm19539ywg.105.2023.12.06.16.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:28:15 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com
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
	gregory.price@memverge.com,
	corbet@lwn.net,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	honggyu.kim@sk.com,
	vtavarespetr@micron.com,
	peterz@infradead.org
Subject: [RFC PATCH 03/11] mm/mempolicy: refactor sanitize_mpol_flags for reuse
Date: Wed,  6 Dec 2023 19:27:51 -0500
Message-Id: <20231207002759.51418-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231207002759.51418-1-gregory.price@memverge.com>
References: <20231207002759.51418-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

split sanitize_mpol_flags into sanitize and validate.

Sanitize is used by set_mempolicy to split (int mode) into mode
and mode_flags, and then validates them.

Validate validates already split flags.

Validate will be reused for new syscalls that accept already
split mode and mode_flags.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 65e0334a1a18..eec807d0c6a1 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1466,24 +1466,39 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
 }
 
-/* Basic parameter sanity check used by both mbind() and set_mempolicy() */
-static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
+/*
+ * Basic parameter sanity check used by mbind/set_mempolicy
+ * May modify flags to include internal flags (e.g. MPOL_F_MOF/F_MORON)
+ */
+static inline int validate_mpol_flags(unsigned short mode, unsigned short *flags)
 {
-	*flags = *mode & MPOL_MODE_FLAGS;
-	*mode &= ~MPOL_MODE_FLAGS;
-
-	if ((unsigned int)(*mode) >=  MPOL_MAX)
+	if ((unsigned int)(mode) >= MPOL_MAX)
 		return -EINVAL;
 	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
 		return -EINVAL;
 	if (*flags & MPOL_F_NUMA_BALANCING) {
-		if (*mode != MPOL_BIND)
+		if (mode != MPOL_BIND)
 			return -EINVAL;
 		*flags |= (MPOL_F_MOF | MPOL_F_MORON);
 	}
 	return 0;
 }
 
+/*
+ * Used by mbind/set_memplicy to split and validate mode/flags
+ * set_mempolicy combines (mode | flags), split them out into separate
+ * fields and return just the mode in mode_arg and flags in flags.
+ */
+static inline int sanitize_mpol_flags(int *mode_arg, unsigned short *flags)
+{
+	unsigned short mode = (*mode_arg & ~MPOL_MODE_FLAGS);
+
+	*flags = *mode_arg & MPOL_MODE_FLAGS;
+	*mode_arg = mode;
+
+	return validate_mpol_flags(mode, flags);
+}
+
 static long kernel_mbind(unsigned long start, unsigned long len,
 			 unsigned long mode, const unsigned long __user *nmask,
 			 unsigned long maxnode, unsigned int flags)
-- 
2.39.1


