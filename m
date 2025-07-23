Return-Path: <linux-fsdevel+bounces-55860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C501DB0F62D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C0E1CC5285
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7C82FD87E;
	Wed, 23 Jul 2025 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="XB4uIIXV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C101F2FC3B7
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282062; cv=none; b=j/XB+r72aPvQ3krWg4KxyCz5kgLg+9s5DuqA1vbAh749wLDioXAhl91ig5wbTQVRCsV4Qvek3jEn2jzPfOmL2gUKU1IFsmvkPPBjpB8WAM8rS4J9S5mZR6nODh1jHetidDo5ZDP6a/UJyaQahUv9MFdRPAvzW1OCUUAdR/Y+PIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282062; c=relaxed/simple;
	bh=0K/tRVmbaZ0VX6fH8M8cdhr3USMmOz4iPh58HsL+dDs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YprVlm16RBAEfagipfvIJmd0YCgu+KNBoyDe/fQ4nNwDbUmdDxGt21vlxZOtnU+iGf+d0h8oiTzHRvH7IKMor8PVRj2hDdoT/ajN0n1ddYALgIJVveNoHkHVMyG+e2T6hVf5yXzRHWTsVwne4CDnk4b9ELelWvd8BrKmhfjjze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=XB4uIIXV; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e8d96ff2dfaso3533824276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282055; x=1753886855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZJDnzlkjFdal2Rjq5d+u9z1RQAbXbOPFvsyuVPVQrw=;
        b=XB4uIIXVxAgp3MXXqcxtclS+QlBo1mLspvyfzGbSvVFh+GHYyLNz1SwbqG/ytQEcY2
         1uI+4xsyIxny4daZZil6Fk2YLl5b2T35jMwudWOY+tlb3MwYk2JJ6J/u/a5GxW38dc6S
         9nZrxs9olyr3opgLKdlqpTdGWyoaVsoHNY39fIO70reHcJl3TgND7hL78dZqsTYaDQKl
         y+kRVsAZ9+Jo8Elk9zUs4Xi+m23ZgPB7shObD65vLHkjZfBPs/toeb28MSINYLmfUKX3
         PdCM+bpADjJCSQzRde3rfdkTwXDLX4CzuCgBFpzsq5ax+BOT6uKsJFrht7gghAzgO8R3
         troQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282055; x=1753886855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZJDnzlkjFdal2Rjq5d+u9z1RQAbXbOPFvsyuVPVQrw=;
        b=GcNIpFG2KT1cCAsp9W9KjXQP82704Ldxm2Y+upAI+FRI7UY9nQ4gtM2lAjuOHq/w+T
         TW89mNQuO+2vny6s8nEG6CwWfEX2V4aYGZPtVLp1vicj917AGsbo4WhMd+pSJmQZ/nEK
         91oM1Hj7gk1SgTbuh4SHv0ianZju8YXeyB5Yyn2JLylG4vBUw5X/F9U0WL88w+lolZMu
         XznmY13odkUUfLgVdeMMrLA8XTvdAJWFEQy6CvD8cbnCOiVxDMOIY1x2V5W8c8fKZz8o
         +8qDN/oJMCWTRRdX7DXSTXukkwgxlA8yBJusSBLkMict/8fOsqD1qEBHDqoeBfhHj87w
         H3GA==
X-Forwarded-Encrypted: i=1; AJvYcCXTWhzxmDxbEdL0kKyiKP6YHMjfRpShdXQKZ/Jw3yLaJpKeG5FT/xdtWAcexavx9oXO9Go/8QvXNhkl162w@vger.kernel.org
X-Gm-Message-State: AOJu0YwayO5cmYkHnSBu9mbyLyI9Ed2mu3j973kRlc3hVaT6K33uWcjJ
	tlcQrozeCjpTzdfgDA0nzWsHks+ikQnLIaOeff7evmnIRB6YTgTbUYWdJuJWjtNNDFE=
X-Gm-Gg: ASbGnct/jKpDg+ZAA0IHQHfaDs+uY01MABY0Xc+U7R+xBKLzSGxBqCyTmVWjSyra0zy
	k3IHEXiskYDp/ibHGpg7VlXKspOeJ3M0LdKKF5NLybCBaS4mo9J/Fh2FZcmEOLjLk3s1/W8ERQ1
	MWmH47QCXD5KEY3VLLrZ3pihWd9yEQCoA5RHmDjq+EKWLSRMD7/sV5BdKIWv+et4o0crI6TVBO6
	ppA3BjAgFAMC5TGQL4ltxrXjUc14euqPiH/uMNaJr9zOEaNO+TxjEKnMMbubvRXQhH7BqwLMLk0
	dTGBwQN+4FpF7aBkLkbOosOL0kT8cIHdXpl2cuqJwkfIskeFMOM3BzIGWVT3QeSWT/ph96p0n22
	+F41fve3ULewX0nlb2dkH4QNlvfBrHGarjd4L33fA30DPxUJ+EIbafv/ZYvnWSaIoDIpKZhUGWP
	jQLMAByyB6e3H/+g==
X-Google-Smtp-Source: AGHT+IHlIrN5M9MAslsUdLs3lHTAX0ZWx0BjoPEfQHGEOchWYmIsSv7ekgCGt5Hg7CwZYoZ1gLsHVQ==
X-Received: by 2002:a05:690c:3804:b0:70e:7638:a3a9 with SMTP id 00721157ae682-719b4200595mr38740617b3.18.1753282055367;
        Wed, 23 Jul 2025 07:47:35 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:34 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v2 20/32] kho: move kho debugfs directory to liveupdate
Date: Wed, 23 Jul 2025 14:46:33 +0000
Message-ID: <20250723144649.1696299-21-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, that LUO and KHO both live under kernel/liveupdate, it makes
sense to also move the kho debugfs files to liveupdate/

The old names:
/sys/kernel/debug/kho/out/
/sys/kernel/debug/kho/in/

The new names:
/sys/kernel/debug/liveupdate/kho_out/
/sys/kernel/debug/liveupdate/kho_in/

Also, export the liveupdate_debufs_root, so LUO selftests could use
it as well.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover_debug.c | 11 ++++++-----
 kernel/liveupdate/luo_internal.h         |  4 ++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
index af4bad225630..f06d6cdfeab3 100644
--- a/kernel/liveupdate/kexec_handover_debug.c
+++ b/kernel/liveupdate/kexec_handover_debug.c
@@ -14,8 +14,9 @@
 #include <linux/libfdt.h>
 #include <linux/mm.h>
 #include "kexec_handover_internal.h"
+#include "luo_internal.h"
 
-static struct dentry *debugfs_root;
+struct dentry *liveupdate_debugfs_root;
 
 struct fdt_debugfs {
 	struct list_head list;
@@ -120,7 +121,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
-	dir = debugfs_create_dir("in", debugfs_root);
+	dir = debugfs_create_dir("in", liveupdate_debugfs_root);
 	if (IS_ERR(dir)) {
 		err = PTR_ERR(dir);
 		goto err_out;
@@ -180,7 +181,7 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
-	dir = debugfs_create_dir("out", debugfs_root);
+	dir = debugfs_create_dir("out", liveupdate_debugfs_root);
 	if (IS_ERR(dir))
 		return -ENOMEM;
 
@@ -214,8 +215,8 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
 __init int kho_debugfs_init(void)
 {
-	debugfs_root = debugfs_create_dir("kho", NULL);
-	if (IS_ERR(debugfs_root))
+	liveupdate_debugfs_root = debugfs_create_dir("liveupdate", NULL);
+	if (IS_ERR(liveupdate_debugfs_root))
 		return -ENOENT;
 	return 0;
 }
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 8fef414e7e3e..fbb9c6642d19 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -40,4 +40,8 @@ void luo_sysfs_notify(void);
 static inline void luo_sysfs_notify(void) {}
 #endif
 
+#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
+extern struct dentry *liveupdate_debugfs_root;
+#endif
+
 #endif /* _LINUX_LUO_INTERNAL_H */
-- 
2.50.0.727.gbf7dc18ff4-goog


