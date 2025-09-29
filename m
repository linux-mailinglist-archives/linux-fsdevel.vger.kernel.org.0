Return-Path: <linux-fsdevel+bounces-62962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB005BA7AAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB9E3B889B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCB321770C;
	Mon, 29 Sep 2025 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gQBi0rde"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F621F8723
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107821; cv=none; b=TFEAyE8GCZFfnn3cnnURo1zvVqPDB6mOSl9bdm2aqqAuWdWQM8F7cqsF0BP3qe1TdyMrlxiCl41MOPACEa2tShMxosDYRD/6zdEOQ4BUCNZjLJkiq5EV9p05hwRD7vK+FgAA17PRASgXtgl4j1Spcxz7ZqIpmyNt6DO7hnaD79k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107821; c=relaxed/simple;
	bh=H863SX6t2g0rcimmk1vD/Y1fEaIHCkBYP8Gf6AaW1Ug=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5gSE53FEvX5tR+ye8v5CILpssRTt5RIkj3wuSLdT+2zN/YByS9swDTaxzJURefBtX7T+3FXGBDrhrJuslFaNK72GxDDHw2RDNnbsHEYfuIOCYMhMxz2+qz3DjN+wO3UEzCNDWjUG14RSZbjlFt+1zXAulMp++KF3KcBpw6reTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=gQBi0rde; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b109c6b9fcso39354241cf.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107819; x=1759712619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=seHRxlr9qoYmGWxME4ah/Rh2okXUsVbz/ndLeC4LCP8=;
        b=gQBi0rdeGswziM8BkntC20uIOSiGooee+q/B2q41M6BgoZqgGeP5Bv8MuJEEWEkBUP
         +ZlZbzmEr4DRc+6zcNJezEjKAPSmoJRJzY/dRqGal2hAQjzTp+0G7hPw28GxMf9S5eiT
         kBioqI4KApASRB1+H4OudFm8ghWw4zPrbE9lHh1ZH2QSAQIJgsVriCjcp3y0rL8Sj2Gf
         p17+6MivXXOaxB8FxwvJJwHCkSWAhlVN9wcUg1cAun9FY0yON7xeTnJE2ZJxBU/raEZ/
         F0Qq0uii5j4tPPWUADLs6IyfkBjRIrTrG5WrxYxQLH5aoLutzCpUFKSpMEmxHkHKZkam
         TuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107819; x=1759712619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seHRxlr9qoYmGWxME4ah/Rh2okXUsVbz/ndLeC4LCP8=;
        b=IM/M8m3QhbWdq1BJCrzRKFyexiSjeBuPWZXXFQoF7cy4bUjhOY5j7QTG9IOyxBUSlF
         /BXiPBPZZn7s/cKJpYDooxBo2xS1VpciHgxfQ8D3vm/F0EmvApHYAw4x1dmCHspgU/xj
         fbvugZ32s8Q0avty+ji0+xxgTY9htHzy2GFto6AnFOfic50P+6LuxeiY/xeeo/1Z/Kd7
         xRjyMVcLC+uHPEra6OKO9DKA/DJT+REWIe5ftfGUl8LAH2h5aoxbxQx6ECtImAzKvthN
         FDF5XU/RXXSb3dzFOTcQa4Ks0UwFVpnLx4zh0BiYBJ+tw4LTkoAVmrjm2M7llPBYpMAL
         Gxjg==
X-Forwarded-Encrypted: i=1; AJvYcCWch0klHvTEArhxwg1532LXGnnGFeVsthmUzFdlBWDM8/WP8EL7lftXvVfwkv5yElj/lgP5AfIZtPtwSArk@vger.kernel.org
X-Gm-Message-State: AOJu0YxB7mEibdmnaWb4/2rge6Siu/UsVLOA+yuCgfR4zelLU+Tpjklp
	r465We3D3d98a91gLhkQrp++/OmtYqSbafRky+dm/8soZ6FLZ5Yq7uXjqufeVkzFtrE=
X-Gm-Gg: ASbGncvbbFGWjjrlNF8hu0p4dOgaQga3SLlov/6bn8X9jJ1dvwBEASBjG7wX7kwEQp8
	wt2jGdwqn9LupaopFGbAFGlEjyf5kCsqzmndnvEkkNQ3kg//qsy6zgNuhAu04c9eCx/6e2m+LeU
	vyekmClAJx23RBsWTejg52eDdh7tRju/Uk0Tcnz2YfURaE2wFax451ISVuPg2xjRlMqft9k9KQp
	C7n1sg4sqGLEvdjptl4/4JaR2FGrqGDuyuGutGheA/7y6OSHcAZ4Vqf7hk1cAO0EB66LD23ZfNF
	VP17ZIg14TA0Xf6xukJ3JhOaDE6IxartJatzukJgCe1qFMzmFfvyp9WaBCOoTOk0EYI7DjKytA1
	4F0EQN05YzW2qGA8tnB7NVIuz+vDRtIuDemXQGQY0cXpFvnqKiQwx7zV9kMsJWmV8MVoFZ7U5dj
	0H24KUDds=
X-Google-Smtp-Source: AGHT+IGWluQyWGzOMAK6ELVmstmCfELrwzvUE/VJRxrRrDSk2QQU4Sd30xTz+Cb2R/+uvVNJIiSTzA==
X-Received: by 2002:a05:622a:4012:b0:4b3:4f82:2b2a with SMTP id d75a77b69052e-4da4744e220mr214493921cf.4.1759107818629;
        Sun, 28 Sep 2025 18:03:38 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:03:38 -0700 (PDT)
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
Subject: [PATCH v4 05/30] kho: don't unpreserve memory during abort
Date: Mon, 29 Sep 2025 01:02:56 +0000
Message-ID: <20250929010321.3462457-6-pasha.tatashin@soleen.com>
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

KHO allows clients to preserve memory regions at any point before the
KHO state is finalized. The finalization process itself involves KHO
performing its own actions, such as serializing the overall
preserved memory map.

If this finalization process is aborted, the current implementation
destroys KHO's internal memory tracking structures
(`kho_out.ser.track.orders`). This behavior effectively unpreserves
all memory from KHO's perspective, regardless of whether those
preservations were made by clients before the finalization attempt
or by KHO itself during finalization.

This premature unpreservation is incorrect. An abort of the
finalization process should only undo actions taken by KHO as part of
that specific finalization attempt. Individual memory regions
preserved by clients prior to finalization should remain preserved,
as their lifecycle is managed by the clients themselves. These
clients might still need to call kho_unpreserve_folio() or
kho_unpreserve_phys() based on their own logic, even after a KHO
finalization attempt is aborted.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_handover.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 26e035eb1314..61b31cfc75f2 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1083,31 +1083,12 @@ EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
 static int __kho_abort(void)
 {
-	int err = 0;
-	unsigned long order;
-	struct kho_mem_phys *physxa;
-
-	xa_for_each(&kho_out.track.orders, order, physxa) {
-		struct kho_mem_phys_bits *bits;
-		unsigned long phys;
-
-		xa_for_each(&physxa->phys_bits, phys, bits)
-			kfree(bits);
-
-		xa_destroy(&physxa->phys_bits);
-		kfree(physxa);
-	}
-	xa_destroy(&kho_out.track.orders);
-
 	if (kho_out.preserved_mem_map) {
 		kho_mem_ser_free(kho_out.preserved_mem_map);
 		kho_out.preserved_mem_map = NULL;
 	}
 
-	if (err)
-		pr_err("Failed to abort KHO finalization: %d\n", err);
-
-	return err;
+	return 0;
 }
 
 int kho_abort(void)
-- 
2.51.0.536.g15c5d4f767-goog


