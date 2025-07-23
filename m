Return-Path: <linux-fsdevel+bounces-55848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909A6B0F5DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 836EA7B7420
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84BB2FC007;
	Wed, 23 Jul 2025 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="YYcyprev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757EA2F5C2A
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282038; cv=none; b=gFnmEqtPvigq1X7GKF0iudlpbi7ziZMmpTSMw2yP2uv/DhpHBxT2hPQcmDA5nRK7Yawdh3gBFIb4SdzoTQ5RxbBKQqjMP+EzodgxpsCI/BzElMDcHcnM0hrDgjKETm4tmnrtEZkmSir3s0mGpbfgVqxWxO5tbqaizBRFJ4A13uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282038; c=relaxed/simple;
	bh=bjMsn0d+DdHq5tKORAnt+APd2ow312ZieXyXxxJ1EAQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1Cfy7LNhT83khQuAnf7QcY23Lgic16XJZbVOYqHuR6nqkUpUj/O7vDTnA/UauAXD9WHZgFsAnB/V+kRKzappFZy4WWxTfwQMRRj84dOc0JDFTwCaFg7ez/8io4IV5dV6jbZPyFkyKCSSQhRY4OKJ2GaxX8nA8YWs14r6dELFQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=YYcyprev; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e23e9aeefso46936167b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282031; x=1753886831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrgbtdA3RdwzYLcpgmSOZtyyO0wlzXdBbkaeyV0ZrEA=;
        b=YYcyprevxnCTmOixqqXr0d0w+E5s0nacz+jBpdJYKq5vD8DBF+iD0jDNrxvUK4GBdj
         E9hFw2AL/N97+sHtKgmWbxH+I9LEXxcPRvqGJ/qBFUW9qJr1SgC6hep1fRvLNyPoWH4e
         q0HEm/CLU48eT6ECu2ZFjj30PQvcd5tBiuImceL7YnQ16Bwkpyo+nQ2uAHSt5lJKddKg
         XIJurFPyNr+LZOLswiqxm4/6KTEnXXHnjzPSJST94ihrIGjAolTTysgZDjDEIvXCDYC+
         ge5Ar/LhWdLH7dU7rBGZT8vlR5sce3mgZNeFB4GFr70I+c59+HPtI85u+gL6aPmJEd/a
         W3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282031; x=1753886831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrgbtdA3RdwzYLcpgmSOZtyyO0wlzXdBbkaeyV0ZrEA=;
        b=MHbzpEC6atEquVsjiKKexfpXQ7LZ3g8T5oiGQer6AbKBE/O6NNUXvg8SGLFLCiYjzM
         UwHd83gj1mGyqzCKphVwnhr7WOY0XeUFy8iJ6qAq7S6kl4EI/91z31tCzF4R6iu/aYrM
         6bEbVxVzNP8RxfCPqzjV1udEWlbb09KFhl6R2CMe1YbUFEpyp4c7LGzG1c/a+1HUNeDL
         mZkpHcw9q2VocDSJ36DYdgRgR5izS/5KUqcdvEB7sEcmxgEvmhJ2Tb+O1RS5i3tbn6Av
         ZQhmXZHpVZebVuog7nU0HlX52JFGt5RHcO08MBSPKCLwXqsyu5mzJrZpttT0FY+fa4sb
         Sa5g==
X-Forwarded-Encrypted: i=1; AJvYcCWP3e7a9X9u3Wr1PkKrZI3PUNV0g5XoO2eUYo3800WtLT0F508BGWjoAukmo5OhhT//iFFGodO3XFWhdJ63@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+UgBDrVa6hdhQN2650xyaYDESW42LBblpfSs61J2jmFhmNNm
	ZCAXW6dK7ZWnKoZnQo126Nk/Si05m6N1Pz41nLjeygcm+pQy6sWx3cZY00lSW+pD/Gw=
X-Gm-Gg: ASbGncvsOqQw8UZYIHkgsORkZhHOJUKh5xodTeFUDZIE2s2ftUITRyzdM5Tb4GctK0u
	s3YDzXI8t+hpw9Apq/GiKJ7PswWsxkl9X+42jjEZ+V1Kgk0aD5bMJO9Mo2JNrKTVFmEDITMnnC0
	aFSMqQ2ysXTZ+D5yiKvPM3rTiJvxC5+TZUM6joEBxwazU4Z95sYjR5Y7WGJkqvaxylYubsE92kL
	wWGoiEWOiEjKf8Wm3iuKgU9tr9z78Br+Y4QBfpjuiyWbnIYP/hxoQ5ogt0mpjcIkh5Outy4a94Q
	91FhXDsop4VTMUOmlKcAMu+4z8aruGb2jemJLaq48KTkQQPCe35yQ1jCIGQUAccrHieSgdpdCWH
	zSlY1vOwoQL0jyXf90WzVQonpFxggKdQjzpgdRiY2h+tz9KDhYXJ1LJLxjAwSk6fH9xFiauEAJb
	4LxfdKgi2xBGx1+Q==
X-Google-Smtp-Source: AGHT+IEtHo37LGPot/hXX3d5/RxjiZTetvWjVt3dWuTs4pORFq/5bZ2tCgRCgkPbneoKEGKAmSRK9g==
X-Received: by 2002:a05:690c:f8e:b0:718:3b9f:f1f0 with SMTP id 00721157ae682-719b42e0146mr44064387b3.26.1753282030545;
        Wed, 23 Jul 2025 07:47:10 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:09 -0700 (PDT)
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
Subject: [PATCH v2 08/32] kho: don't unpreserve memory during abort
Date: Wed, 23 Jul 2025 14:46:21 +0000
Message-ID: <20250723144649.1696299-9-pasha.tatashin@soleen.com>
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
index 26ad926912a7..7908886170f0 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -778,31 +778,12 @@ EXPORT_SYMBOL_GPL(kho_unpreserve_phys);
 
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
2.50.0.727.gbf7dc18ff4-goog


