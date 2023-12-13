Return-Path: <linux-fsdevel+bounces-6008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 469E28121B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 23:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2471C20AB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 22:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5361C81E34;
	Wed, 13 Dec 2023 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfqVKAsm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA1DEA;
	Wed, 13 Dec 2023 14:41:28 -0800 (PST)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-5c85e8fdd2dso73245737b3.2;
        Wed, 13 Dec 2023 14:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507287; x=1703112087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR/U/lAWuhs3jEMZC4KyA26ezpCk8+tc9jcFDZQx9cU=;
        b=HfqVKAsmfmk5otoU0fhpOLdxeL9mc9vHjHTLJwk6xWNKgcp+1rkeJcnF8Xa5+Zbdcx
         Bo0zfUs+GCa1yXH07QNI3rdUFdS4n8ZWG3pIBXUYEbzoogM1G1ueC3MmccD1OfbnVnF4
         tTZjHosZ28GnqrKS7/E0Oz4Pa5MCBwq/0tEz5QH8L+FPoOZdibqNyWHwqCjhqNLngBHd
         0BPo+6vAOko9Li28AKH5FAtc6/7nb/TqIV+3HfdSo319HSqmG++DnIKOoy6bXjiZlWuk
         ZrT5qfZBoJKOFoIS2UzHx3RwWl3rk6OWgTaWbJ5/I2qWeq4nWq0RNvOcdPDVVxR5IaSh
         SVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507287; x=1703112087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oR/U/lAWuhs3jEMZC4KyA26ezpCk8+tc9jcFDZQx9cU=;
        b=vU1EyDFwDpIKQn6S/WroZr1wH2tuSN0DyP/9vxsiCy5NVYAQ064xwB3Adh/VmTqi0B
         GKrz2gkThh+YzuyDrsheG672IeolssAD3jEoEonkhJg+fdHNFoeuWQ2UNJI+u5scLLyn
         MZBjOR9M0D38itRWIrpLsl3rMbRq1tibvwwvCHnJIVFHc99dm+a+cPYsbUbjuC1ynHY0
         K8FRjS8CarclnhzkZL/CI5MSz3eKqIlFj5okmSY3z3YuBPGSb9asuQM6VfEuh5upHF2g
         /cJee3aRx4BOP87TiEqGOwL60jaIBGblxYvKUeJxOovPmZrTOKKig+oGJUYA81oP65vT
         NWJQ==
X-Gm-Message-State: AOJu0YwTYMPxBGU2LHjTK9PHp8BCPOVudgziGDvZpBCxl4yzOEmqw9Bk
	BnlVLhuFXJQOeE2GRqT5yw==
X-Google-Smtp-Source: AGHT+IFpEpSdMzAFUYfwPof6Y59fNnXlN60sd7WtpPgNS/71WOJgjYuTivvQkauLM7Uk+cl8cqNLow==
X-Received: by 2002:a0d:d383:0:b0:5d7:1940:dd68 with SMTP id v125-20020a0dd383000000b005d71940dd68mr6889260ywd.62.1702507287649;
        Wed, 13 Dec 2023 14:41:27 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm5050583ywf.42.2023.12.13.14.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:41:27 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
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
	peterz@infradead.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com
Subject: [PATCH v3 03/11] mm/mempolicy: refactor sanitize_mpol_flags for reuse
Date: Wed, 13 Dec 2023 17:41:10 -0500
Message-Id: <20231213224118.1949-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231213224118.1949-1-gregory.price@memverge.com>
References: <20231213224118.1949-1-gregory.price@memverge.com>
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
index bd233aed103c..e55a8fa13e45 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1463,24 +1463,39 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
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


