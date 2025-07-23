Return-Path: <linux-fsdevel+bounces-55844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D36BB0F5D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 287847B6BAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B432F2C56;
	Wed, 23 Jul 2025 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="0e0Sz2TA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A72F6F80
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282025; cv=none; b=E7Q1aK+fgNLg9O4o/aCNU3B1bjN5QEadj8tqCloo9HZShh0bjagRLzIgWBEQ5PPDQ0zm8/fdQoio5iziILr19+yShP4qj7Tfi//5iZSFLIhqssmIJrzbS17GCUARcRDVx9zyDlqv4F4C/oBSrKHNMQZS+bdmdvCyXyId9HMbc3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282025; c=relaxed/simple;
	bh=hEYGgJwEES9dRnVz2N9sTt0Ks0Wwq55TXM1cQALvjO4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEP9WTu7QQf+Yow1Vi/GgsuldlcAYSCJiYU352A2iEYW50mkLS5gm8ZqjqGyFZFAyKU0Vz8gx17iJ7ul3Ih0d+x/zpXKM5/GXX23h5NbQ0MBK+V0Vx2kIB5pAVb3AYYlx/C1Ng3OlYRsQfxtfOP+Aucl+UdpJSpElnOIOq06Vq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=0e0Sz2TA; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7086dcab64bso64853747b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282022; x=1753886822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XYi+jDPzWu41ED2O5U4L0RfTKyUhB75+lmsBNGCN0Q=;
        b=0e0Sz2TA42Ej2BiOtVHwZX9CtJhxBGK1FTBpRlsuVY9WTAJeo50zM/Anxkw+iOUOce
         exncFkOaeFlC4UVYO1lXxTkOxe4PshM5MJsNfwYZ8eD78M1iiz651ByqRLVzuMhjSeWd
         acRAtjAH6YAtxPFbQFLrhKKagehgM86PcDu6nuueDeTTBtM+SOexl3UK8KI0xvf8grea
         KASQqvERVBuqhybq9YzWTPYNR8W9rzCTi9kR8SFlSI3o0/7m6TwI1jsktOv2qe0+CBAr
         8VLxKxlNlQKxKZn+4v8RAeP723Stbx1W9UlbsVdEUryzyIfXC2TajOMm1KNT13tRatxJ
         2oKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282022; x=1753886822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XYi+jDPzWu41ED2O5U4L0RfTKyUhB75+lmsBNGCN0Q=;
        b=PnHMWa5R8FRN4qcvp22rkl2AtTa6T0Udp+mva6RHhJXPlGjQA0LGYFDHioVQkGQKLD
         I1CdjYwNPkMBmcak3prdf0evUDP+QXvy8N4rRd6eajdZHdDISyg7ipYjwg2iRR10qrBz
         ic12sWDUgCTYmkEv8eqi5eF0FjnptdoHh7cxBOoT2turPna2s36LzQFmcse26Ub9BI+S
         Kjksn+tQdC2s9UTd/9CVati4BB3N9WJR6KKdQQ9BJ2r3pZxrLj/zu/UNtyd7e2+2UFzX
         PKsK0959+jbFZgW52+4Mg6Z+1Deu9GUiXeBj52fa5bAiu1u7vC+lwWPk6uNbNVFBO4oE
         8+iw==
X-Forwarded-Encrypted: i=1; AJvYcCXxfNN0H1IJ5ZdYxLw7FV9SfFNDfj1uUTApAiMs8bYVSokMLiSu6reySQQtvmjvvi6hVZmOtTjoRww/FZ+T@vger.kernel.org
X-Gm-Message-State: AOJu0Yytq5x1quFi0D1iqW9H1iTjXfHQLk/mv8aSn75n3jiNZ1tzEdZU
	+CNG3P7VF7yenXOTNM2SZx1bHR5mStTdwOSCKmcgglKYeo2LK/PQ+1RnVxSHoGm0Nc8=
X-Gm-Gg: ASbGncu8hnswTD8VfPRTB+vPJFDifEJhfOnR5MbXd+GeBF44jR1LDUh4LITNeutgwBP
	oHgekyQGUf1X7P2E34ixKmRS3CP2qBDxhhksiDs8HNMye9rX/D5JRBm71ORd6huRIY58NtdVOeH
	o/P/LHla6twZHQaZYfTan8EwvLfZ7mVj7M4B/2Fn+wmzHjNc58AZO09NYUpVGtylQf/4W8GQyNC
	R2Pi3ezgGXRcLdHK7QksZHAWrPWerJSXS8ccqKIUhLqaYRWM+vcv4/Xhb7g28SL+krtjOuoiTG7
	xau36vt7hZw3XXpptPFLPFAfvRYqCd+2ssLvp85PlOQc58vGl7rnJUxI3aGnjEqj1IvzU/dQSkM
	N3ON6ZaCHbCY0Grcv9VIipPF0klHvYv3HFZ5DNbn7mI//8ClZltydkKSPzjWGJQgMYOryld8INo
	yNkUbuWXMbLVs4tQ==
X-Google-Smtp-Source: AGHT+IGIyqUWtaPvswuBOlmOuoZ6Oiu0TyqZMj4g6mxjo7nkGd2imCQgeqT6/0gbrHlbiudRcFkz0w==
X-Received: by 2002:a05:690c:4911:b0:718:38bd:5433 with SMTP id 00721157ae682-719b427d2cemr38041947b3.42.1753282022224;
        Wed, 23 Jul 2025 07:47:02 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:01 -0700 (PDT)
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
Subject: [PATCH v2 04/32] kho: allow to drive kho from within kernel
Date: Wed, 23 Jul 2025 14:46:17 +0000
Message-ID: <20250723144649.1696299-5-pasha.tatashin@soleen.com>
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
index 368e23db0a17..c6ccc8e0705d 100644
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


