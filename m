Return-Path: <linux-fsdevel+bounces-53001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D554EAE9250
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF2D7B96E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EB52FE398;
	Wed, 25 Jun 2025 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="TQD9Ylfa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3790F2F94A3
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893532; cv=none; b=gHY4iAcTO5yy6Od/ylLufUWi/RV2DFymMQHKjBCsJHpz8VycrX8EZ1VUotixhO2QKRY45M7sXa1InKqiaaR+ZlrmsvFQj8w7Bw0ZtD1cZaT4m1Xx2KFc8mBpHrgcXsN2ikk/NBUd2UGvpTR2FrRmU8R1G9UO6Co9B1oot0nBAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893532; c=relaxed/simple;
	bh=0PDOq00Vvzpi5aidwuocO/LBH8ZpH//f3Oi/CTR/VxM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khXmiv0hbzMsrFtr63Bedz55hEyu+8yYC4DGqOr8XUs2lmDGajjZz++O2zXOfhL8Eb66neazNIp+AwKHHpVm9HSK6BDFOfWl/I7180Oplf1J/ZhnCe0V7u4xcut14tsvcdKxHduy7VZcqHy5qa/kYYzILR2nnXU6EuWuaHqrEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=TQD9Ylfa; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e733cd55f9eso318308276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893530; x=1751498330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEd3hEimCm47EV0AQaiIlZfu4Iz9+2FaeBATOaJn9bU=;
        b=TQD9Ylfa9OpH6y1QUUoAcPtowHOdIvB4ASS2jV6r0te9GUxsCNjr1ZD1sa6YrOVUne
         IZqTmnQ0IaKeeYUewoWaGdx58v66xdMMR1WIriO4rmI74qqi8rSx6ncKMS7itX2dZfYP
         HySzDgRFfqNCJzfNBYg5NfM4bdOkGb4pbBEg6i2mk9Xt/dQh/eCpPYN4yBIkG4VNmT0U
         +vitfnMD/vim7ztqZPJs4T+SLHEReI7HY7P4/hXKtqOQCyC7qW4lJ1z3nSIXO2EraKFw
         hQR//pIDLNIqKTdofkzdLX+j27ZiUukmIvgIoGILX898g0baNiu/TGYUYIr2px19Gae+
         wMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893530; x=1751498330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEd3hEimCm47EV0AQaiIlZfu4Iz9+2FaeBATOaJn9bU=;
        b=nOC57bWi7I9feumam/qpYZZ5a9Yoz3Tf24biJGwYx31bl+ZsK0xS4gGxlvjg1p3dRg
         BMXtcXGi6Ezw59PvfjEynDEFLZSERW7D1DA9fE9NYxuRjymfr4QsyF7cxQR+s2AGdV9V
         SoxRI8PFUrZdIzBjm7jh9wXLOfUZkert3ewoePvEn+lyOnqQA9KhdJ3LaEgFi5Dlinn1
         uQwhWU0YMQViC5EpW9WYAMyiWKIwGCvZLVaEJ7hhfUnWESSZCjPB4XVqVg7YppIlXK8E
         81/qDeu62RuvT153VE3zStcl5iIGi6ZgOweM8L6/BbG/XBzgNZDZKuaQIs9b2/RS4bqN
         3ZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfXlZkLuWOUaF3TKnBpMcp85aQGSsPd5x8hjyvPvBau9DcV8/xYxI6ZugEiVICuAjCIASARFcjDD8Re2NZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwV8jQmvpR8aPtPj8ebZ9b+URSMn7mtChv/DKigy9GwO/uT+ZYm
	NArWPlNAllETBWV6Q3wF+ukf2BPaGEASOMfRaH+12zUKKh29Xw1FG0Oq5Qd79LxvpPs=
X-Gm-Gg: ASbGncuYysB85lBIPYs4sux66db+pqZhSn2AXSUAtnqTvVgBzSR21Ycn4AIP0sbd2NW
	KhvWERKvvIAthmLA4y/q7+yzvhcuLBljQYWLRKqdba7LDSmanLIHrUYZSXymvNh2201QvgaZGJh
	OEubOZYiKK8qrjT3k7A5DomgdAoj+BK7EeoV4nsYG0HHLZ7cj4+Gqj5dYfZcHW64JzbL415LeDL
	FFaov81rBt8jXXGVmL0bKITdLPT/chKG1MGksKWoVItsu/fhTzP3x3PcEtVU7/m0+KRmopsZ9Az
	HUfBQqC9z57UZUrF8DR57qI77H1JCQAR7fflOREtLjIoKXb1fUcmJ+VwvjUf8pW6o41qSB9QcRD
	tHVxuuPr+bmnFETaFNesowrEt1dihsAu70l1zIHLEyHcHtsGxKF3J
X-Google-Smtp-Source: AGHT+IFV+5+LiyNG0iLZB0IHiIkVDp3jbmaFTSBcfMxeDjEUTB2cISyBkSfyxmu5nuGGQBp9zewiEQ==
X-Received: by 2002:a05:6902:18c3:b0:e81:b5b8:3cc8 with SMTP id 3f1490d57ef6-e879b977913mr2507142276.41.1750893530105;
        Wed, 25 Jun 2025 16:18:50 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:18:49 -0700 (PDT)
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 04/32] kho: allow to drive kho from within kernel
Date: Wed, 25 Jun 2025 23:17:51 +0000
Message-ID: <20250625231838.1897085-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
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
 kernel/kexec_handover.c        | 58 ++++++++++++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 2 deletions(-)

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
index 069d5890841c..af6a11f48213 100644
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
@@ -790,7 +790,34 @@ static int kho_abort(void)
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
+EXPORT_SYMBOL_GPL(kho_abort);
+
+static int __kho_finalize(void)
 {
 	int err = 0;
 	u64 *preserved_mem_map;
@@ -839,6 +866,33 @@ static int kho_finalize(void)
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
+EXPORT_SYMBOL_GPL(kho_finalize);
+
 static int kho_out_finalize_get(void *data, u64 *val)
 {
 	mutex_lock(&kho_out.lock);
-- 
2.50.0.727.gbf7dc18ff4-goog


