Return-Path: <linux-fsdevel+bounces-62958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 813E5BA7A8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40DAE7A3AC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867EC1E885A;
	Mon, 29 Sep 2025 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FXHMpFhK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2D7082D
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107816; cv=none; b=Ms0VX+rArFBU5KBCIhkk94ya1W6BgrGYlkKQB1qgF+2g5cu5YoUUNanKFD0HhTPJZuXD9khx5e90H8gK1FZ4gzCbz2GqMZsBe1OMOHbqRwdZ0q36rVE/BAD+9MDcHgULuJT480bIXghWMDWd/yMdQqzxbCSJfO+ZS8DL6sVkqTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107816; c=relaxed/simple;
	bh=H9bVmk4XNEIhyUuYBpnqxQGGI4EN7gtWE5L1w0h2bJI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6sShw071/MTkGOpCZtHFGGcXR1lqznrmnxVYanjyC4KO5WZBTbPItAA0zOfiZG1OWaBjGOLt8vqp6MDsagloEmlGzxf9bmhyc/+T8qDO2cR1Gcv4nxqEl3oWcOD8yOIQtdXl06vccjUPVmhSDK5OxgX6Y0DWQ1bo561HaKfT6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=FXHMpFhK; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-856222505eeso447325785a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107813; x=1759712613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RU4szgNN13WysJ6xhtBfiTDK+ejkMnCmbQOqkk33H88=;
        b=FXHMpFhK55fIeMK2ud2Rt4xuVS/+SwhFg2c12I3fXTAYYDZ4ZrC3kU1ecCpYWlgRz3
         BTPAsEhL1G/2oNODFHozE/EK2WTnPwqYy5URo5NSNhwCDuwA8o5ytL1kXfNAQijshBFS
         OdCBzt3LVy9ThgVez0fNbQM5Y+geFwOWozGDWS7SVzXvz+2f6IEgEDuWvX+Fq9D5kVp+
         7Dj5HlNilSGZ/amqU0hjc0QpyrElswpH/OFrx0uhRcdB4VbFMJ2vCXNNSbzzm7ZuEFyS
         jXG5Inw7pi+unnWtP0KAEr67QmnxGtu+Mn0e5hj9eM+85f/7AQExL7hiuJcBVDP/dnij
         c3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107813; x=1759712613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RU4szgNN13WysJ6xhtBfiTDK+ejkMnCmbQOqkk33H88=;
        b=B2QZIkeiGi/LmYoMexv/slJt4j6jX4tQW1Omvk1GMWKS92GtynYIiPytI3vvYtwWuS
         CF9HjcodR/u3PXjJMY6BirRvgPmpdCYqGCBifXpohOfhetMacCkIyqNAfkMRtQh+23R9
         F9Hiy4xH+G3QAGiVr9eKWqxm2yaiJkJWw7Shis0UAUpPWOdZZ1gnnQ+eWaGwRk+lL4OM
         Na761Tiqz4QSn30HUUkOEJmekUG8ApA4caUCmqdH/t4+LQ8G5+RxGF+WLw16l+kB2M4e
         5Vuaow85RNASYE4OwE7hAzEsexK7QrYEXSGY7p0MTBpD7Bg3mpyQvOh5u57sLDJX9Mx7
         CPtA==
X-Forwarded-Encrypted: i=1; AJvYcCVse4L3lyjEYLqcKfhI2UkGyfeuav6k6T1YxWc7cQgYAOedvAPS1kVftQye1Y1SJQ/fm04l5NtCXTPcmVXm@vger.kernel.org
X-Gm-Message-State: AOJu0YzzETE63epjSgbQH3ny2jaZeYt8W5JTFbCa3jv+e1DyuwuMl5Bk
	GL3TLhMmLHs88CRYlyT+XTinkcOkhd2Hcx/fkq7bidh5GCWn2GMrwDzB6mS97K/gYaA=
X-Gm-Gg: ASbGnctT2KdzKj1OWs1iYtFqpgXrCrsd17vvCPBjBnbborTsXRcot2TCiJ9STwIKaum
	Of8Hlj+3DiIMTYvlVUjsfmOriYR/pnNJg2KMyevYmOnjrxhaHNbo/pZMz5St7XhaT7AZJ5gNrw/
	hMa/LsNs514WWflqed4Zd92aPUFEuwtFqUsESPL9JfYe5UOWUnhIupM+fX20uuZSThWjjk6u4Fb
	fsLJhFVW3UqLHZn6Xi/DcuR5Sa4ZLdWTpuWTnWaizmYIcPm0a5ZsFgOFaLvBxI2MdWTT1Nn27m+
	wpmD0vuOQq6tswArgdpFViD2bxZp++dyVRKymKXw0laDE/BDGAeB/hed/AL1dETzUNstU1NpVQA
	wbIoTuq3+7buctt/0JdIQiAb6+jsUqKSDXQXmL9waa+LNSFf7WQ+TSPfWqbigSOMSSrP4p7EliU
	vmVo1OlRMJwh5JE4zPpg==
X-Google-Smtp-Source: AGHT+IEzNLDCIUEBf9S5DRDPsrWxtgBORWz8LvfpibpwyTvuEl9/0gmUqA9ZfzRNolrGZ8uq0mC63A==
X-Received: by 2002:a05:620a:1a90:b0:84f:110c:b6e7 with SMTP id af79cd13be357-85adf7bb783mr2147257785a.6.1759107812795;
        Sun, 28 Sep 2025 18:03:32 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:03:32 -0700 (PDT)
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
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 01/30] kho: allow to drive kho from within kernel
Date: Mon, 29 Sep 2025 01:02:52 +0000
Message-ID: <20250929010321.3462457-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
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
index 25042c1d8d54..04d0108db98e 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -67,6 +67,10 @@ void kho_memory_init(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
 		  u64 scratch_len);
+
+int kho_finalize(void);
+int kho_abort(void);
+
 #else
 static inline bool kho_is_enabled(void)
 {
@@ -139,6 +143,17 @@ static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
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
index 76f0940fb485..0ba5a2dbae28 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1067,7 +1067,7 @@ static int kho_out_update_debugfs_fdt(void)
 	return err;
 }
 
-static int kho_abort(void)
+static int __kho_abort(void)
 {
 	int err;
 	unsigned long order;
@@ -1100,7 +1100,33 @@ static int kho_abort(void)
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
@@ -1149,6 +1175,32 @@ static int kho_finalize(void)
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
2.51.0.536.g15c5d4f767-goog


