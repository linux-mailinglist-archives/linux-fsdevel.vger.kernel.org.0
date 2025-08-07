Return-Path: <linux-fsdevel+bounces-56928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88218B1D03D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 03:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09116164BF4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 01:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247101E832E;
	Thu,  7 Aug 2025 01:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hekIzqZr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D811D8A0A
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 01:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531096; cv=none; b=kewTM12Yd175SyKp8K738GzJT3URUaXwrByzkCndcNlG+AZtQmxjDjla4SkbMH4LpCiK26Vo88M4hqq3Q3bmWc41xxunvV91RwrAScc9/M6F4helGrE3HEjjQR26/g7nuESye6dh0wBf2ZwmEUKjUu2kO7qmmjMV2Eb2A1Vs46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531096; c=relaxed/simple;
	bh=9o3FtqjKn/C7E3gCLx9DaCJVqshNMO5CpPQSR//j8AM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OomZuRIUaDIT1XyPqY4cj06dUmB7CqKfjIKGQcYBRBBcxSh0F6L4m3H9bIlTXyyuviSKjQGcOx1H7ofELHexTkOCfDTbzao3DKGkw/Mmp6yaAdXpvXk6c+cH18FT/HXaIrVZgmDZkwO9Vya8nwFtVEVIRW4IOLxRh7+6rFLBTa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=hekIzqZr; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b0739c6557so7724751cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 18:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531093; x=1755135893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FY0apzV4/jiYpNtz4zaEBU41SIXIqP4k9Hjv/Z6KQLI=;
        b=hekIzqZrxOsPoxQ4uSUVxR2tdnfeo3Dz2NaEHGWaTGyIyZh13/jf5lR8H8N1Drg+8h
         BdFj9ICIq9hC5Vxuy7SjSMFqSexd2WUZNFwPlIy7HyG0jcRUQ4t9TQLzPj+V3I3SRTzM
         4l2slXZHQFkVFJ3l49wgqRArt+vKpVk8h2bSZiuZKuyQaU5nFeHiN4Zoe99gpLMOxUMJ
         vy20ho52rBMS57InEMEX0MDtgraALp5vcvZKNGuE/M9OcZuhs6Gvo3Yq0rTJ3j9zAlq+
         zP+cmlRQCE+Uc5zNz7ZfieMDIsCpXvurcCUlwPTCw+BbjlzM/vHTtffoVmS0GCtwJM3w
         1xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531093; x=1755135893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FY0apzV4/jiYpNtz4zaEBU41SIXIqP4k9Hjv/Z6KQLI=;
        b=dwNwRet8786b4uDOcbTgl5gcsBy0hduqxY7NZxPD6wSJPQ/YmlWmjnzkfS0uhSWGMj
         A7y2uVkHcZtAqeYj2ebyBQI6e8icDSUC2xf7jnTEIb5ZETS0JnJ8UGLKyNJoLaULGOHk
         Cgil2C2o6jC2cSxUFD3LSG6y5dQjsjGtnc1EIGkaMZEDDiuYwrN/bkSvdHCF9XTSt/7F
         G3T1JXeZm0O2K+srvt9UDDCNXZFbdNm9VX21XLMhg53xtr07q0OTUzbgUiFsMCZHOI36
         cA9YUEh9ep9JUBUn+PNkeWqEwRR9SsjaXo6y/5tTrZszVU7CEh7bUpIofTTWGhYlUVtA
         ZgaA==
X-Forwarded-Encrypted: i=1; AJvYcCV3WNDdxp/ESL0Dd/nJ/T0phoursXXDvxYB677n3MUvWG9AfB4bF3fuEWMNjzhcNnvg6FsOT6sSxqBZwQHF@vger.kernel.org
X-Gm-Message-State: AOJu0Yylxwhvt2QfVahOX8xE4xVoBdDx4iYO0PMgl80IFVGR3iqATWyG
	asGdSdyJPKHeo/eiDVsBGdJH2hlYRBTxXnxH95QBHf+p1d5nI3bnzRb/p9/vGtqCea8=
X-Gm-Gg: ASbGncuQa6m7j2HwkSVT9D7bv3zTNwSjiGv3cglW30N4gjnn1o7a0HafNGFZrKKgcZF
	zFdGYwBkqZEYsQ23Sn3RbEU7IMyJZi4qejZP4lFlrgBsdM5XPlZREQgDidkCaqT94u3BdaNL4pw
	tiYeTxOQHABY9fMAy2UI2bY3hbcy+VmK+wpCpGAxdeGHYX721TBOfzDsrPivta5HvC6L+rEO1Ng
	GkFf6PJXabaR3LlGRhPxGxLIM7CeeyuicRGS1FJNnmF7pLSgYz4aqtDuVqsIVfhOttFsInXDiYB
	/F1MaqgW88LqP5bQkFv1AK5zRkD4vtN0q3ow74cXoE5fZwxNvCdJb0Cfc3M4n5LnkfjJSDkEXIB
	LTbPykTwqhraRALsD0Gy7HFJ9GN1SDIru8riSB3dWvWss9xYnS0JpueY8wEdaw7JWhu2mr3Smav
	p0wdikvNMdQKoe
X-Google-Smtp-Source: AGHT+IFVnZ5D1Am418Avb76/eeCwz3uLxwOs//KfNDCrFp0xraechqxEC3xc41ENAONdARaIHNn8kA==
X-Received: by 2002:a05:622a:1494:b0:4ae:cc4b:11bb with SMTP id d75a77b69052e-4b09163a4cbmr65118341cf.57.1754531093076;
        Wed, 06 Aug 2025 18:44:53 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:44:52 -0700 (PDT)
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
Subject: [PATCH v3 04/30] kho: allow to drive kho from within kernel
Date: Thu,  7 Aug 2025 01:44:10 +0000
Message-ID: <20250807014442.3829950-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to do finalize and abort from kernel modules, so LUO could
drive the KHO sequence via its own state machine.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kexec_handover.h | 15 +++++++++
 kernel/kexec_handover.c        | 56 ++++++++++++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 348844cffb13..f98565def593 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -54,6 +54,10 @@ void kho_memory_init(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
 		  u64 scratch_len);
+
+int kho_finalize(void);
+int kho_abort(void);
+
 #else
 static inline bool kho_is_enabled(void)
 {
@@ -104,6 +108,17 @@ static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 				phys_addr_t scratch_phys, u64 scratch_len)
 {
 }
+
+static inline int kho_finalize(void)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int kho_abort(void)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_KEXEC_HANDOVER */
 
 #endif /* LINUX_KEXEC_HANDOVER_H */
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index c2b7e8b86db0..2c22a9f3b278 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -757,7 +757,7 @@ static int kho_out_update_debugfs_fdt(void)
 	return err;
 }
 
-static int kho_abort(void)
+static int __kho_abort(void)
 {
 	int err;
 	unsigned long order;
@@ -790,7 +790,33 @@ static int kho_abort(void)
 	return err;
 }
 
-static int kho_finalize(void)
+int kho_abort(void)
+{
+	int ret = 0;
+
+	if (!kho_enable)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&kho_out.lock);
+
+	if (!kho_out.finalized) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	ret = __kho_abort();
+	if (ret)
+		goto unlock;
+
+	kho_out.finalized = false;
+	ret = kho_out_update_debugfs_fdt();
+
+unlock:
+	mutex_unlock(&kho_out.lock);
+	return ret;
+}
+
+static int __kho_finalize(void)
 {
 	int err = 0;
 	u64 *preserved_mem_map;
@@ -839,6 +865,32 @@ static int kho_finalize(void)
 	return err;
 }
 
+int kho_finalize(void)
+{
+	int ret = 0;
+
+	if (!kho_enable)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&kho_out.lock);
+
+	if (kho_out.finalized) {
+		ret = -EEXIST;
+		goto unlock;
+	}
+
+	ret = __kho_finalize();
+	if (ret)
+		goto unlock;
+
+	kho_out.finalized = true;
+	ret = kho_out_update_debugfs_fdt();
+
+unlock:
+	mutex_unlock(&kho_out.lock);
+	return ret;
+}
+
 static int kho_out_finalize_get(void *data, u64 *val)
 {
 	mutex_lock(&kho_out.lock);
-- 
2.50.1.565.gc32cd1483b-goog


