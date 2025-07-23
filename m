Return-Path: <linux-fsdevel+bounces-55843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10581B0F5DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD4F965380
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDBC2F85D6;
	Wed, 23 Jul 2025 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="KL4Num2E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A492F5C2A
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282024; cv=none; b=B6U0yRV6yqSQJXcDXuqjEaqu1PAL3e3yLPrMWg07gPCVzidrPv4hinfVJnos3fgiT6Q7ZHLqlECla4JP5hg1gYK+3noNs/9/+9Z8L8DcpG/QRXXVbblv8mjWp5M65RFmzo3oz/+HGpYWztaM26XeVt+C/f43IITJ+6/uq1KYShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282024; c=relaxed/simple;
	bh=kan5N6v9h+6HDmaXzRrpPnNHjduBvdwtdSKyvQ1qoHI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOWo9Wtjm8pDqDBFDEXzKURKOnzq5/nY0Vv9OX2Fmy3eeEtSOewLXMa9fbolTXixJTzLUuKX8qASKkf16S7BjQK3TQXT4mW9mExA4t4iyszJHYMuO8dR84yHp7M/98Ptpxeqzcmd0EQbs0vEIOjEiTGa4R2hrEsKsZHF+Tv2nU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=KL4Num2E; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e4043c5b7so57109927b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282020; x=1753886820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gy3J9QeC6eXj3cGR0pgjxNs/6APC+1lztNiCJckBgPA=;
        b=KL4Num2ErMDjSve2Ap/UeK84q8BVWlgZScO0wXfZKdHj0BoY/3vpaaEdSO67uTDl0N
         EK+9w26CgCTEG3g4ZZovf6HJlIZvbRroRps3D+HI5DUKgFzXZM9v8Eq4dHlaGBr5iN+q
         uWUiQdMER9jsseUMjfid2gZ61FAjv3HbuJrTeAXbXe9RqB+4DPKuTl9FOQpdXXDx4W/M
         iIJmCFgAbbCNbxiRDbC8sa1dbiUHM6u9TQTOQZgm94jDXnK9D5YifpVCN2jSO+HJbVfA
         DdZuLjPg7krOtEVrVPmqLqlPSeSdzNj7RhlMtOIBTI02bBIkS6pcDsfAl+4TgsDl0iHM
         To5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282020; x=1753886820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gy3J9QeC6eXj3cGR0pgjxNs/6APC+1lztNiCJckBgPA=;
        b=ksR5g0nQ0T4NQJhub6UgIrlcdsCResgK70Dm2SzH5THIByNyOeGa4SzOP5Mdd6Add3
         r8wTtJ98b5C48uHGHICLtgTYFFEyX/T8sEwiFWVfCbPZksLqEN+YbwRSVYKYU+eEoRds
         gsHYL3BmoejoDyAQTng/PekLLelIV/craWJfqSVelkeDm+Fwrv340Xj/ow4MbukH3SZ+
         jyg2VehZwFAs+Wf5N8Y4UyAp8pZOUsAvNbKWQnhY/MdnqR2mpcJl7J5MeuryNq7Yu1BA
         5hBSfaBJMeUjLnXrYvfG+NXtlvtHIF/KIH316WSi8SQ0AMPdQgWxe6lmsPz87c1dNBKx
         AUqw==
X-Forwarded-Encrypted: i=1; AJvYcCWvhNEVus2qc/WvOQS7QkCUrea8ck35hiC5tXWRt8XQDqiLW82nwmDtRf/UdkJM1fN4ejMeN2mizAEklQ9O@vger.kernel.org
X-Gm-Message-State: AOJu0YzbnMKKC0sm2sPRi16qNFV6/rVP4LDA79SNvHjpxa855jKb1PxL
	/Zdsy7RuVS0ik6haMKAz+8/NXSjDRthaeitc702ab12eyt8dc81d82b0JLmxpJLwkXw=
X-Gm-Gg: ASbGncsbnyqgfCfO8dJseIyQWKB341g2Ty5vD0oeL7tW5N/SzSIAPfdemrw5r80jTAu
	HRP/JMDVfdDCWA59ztJNtGun3C3Ax2Z2v8Q4/4IoSxsyGCm0tCugfC+m7xKcoarcuFiqijm8Tz5
	tRPzNEC5Rjux018T9PhBJm/q/euo2FTapw/A7mCf+kXFo1ubmMttWT6i2tuziO7uUKDAGzhU8bj
	/WhhPvbI30mnnAOlVvQ/28ZyF0+khY53XN4E8mUeE6Mlyg+waqtKoXtx0FOo3HNqo1SonGY+6WG
	rd7d4KKe3YWG/ZNtd1lzovjI/Z0TmrlN8mIvnFlTbfVsig+Z1nbYPe6NhpgdnaUnAjIc3m+V5a8
	fpyWYYKYOXKFjJ0HVxbS5PFkZr/W3Ligt+yvZtAuUaDvT3EyHEvm+kkTuybHc5aD2EVXBzRXe1j
	bXcFh3awtMUI+wyg==
X-Google-Smtp-Source: AGHT+IE8V9tRE54MK48zflOS7PSA4HAhDqRjtC0UhDc7I1+H3UGz76R3OVDEkrrQ9nCRF167WfSdiw==
X-Received: by 2002:a05:690c:74c3:b0:710:f1da:1b5f with SMTP id 00721157ae682-719b424d284mr43181487b3.34.1753282020293;
        Wed, 23 Jul 2025 07:47:00 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:46:59 -0700 (PDT)
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
Subject: [PATCH v2 03/32] kho: warn if KHO is disabled due to an error
Date: Wed, 23 Jul 2025 14:46:16 +0000
Message-ID: <20250723144649.1696299-4-pasha.tatashin@soleen.com>
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

During boot scratch area is allocated based on command line
parameters or auto calculated. However, scratch area may fail
to allocate, and in that case KHO is disabled. Currently,
no warning is printed that KHO is disabled, which makes it
confusing for the end user to figure out why KHO is not
available. Add the missing warning message.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_handover.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 1ff6b242f98c..368e23db0a17 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -565,6 +565,7 @@ static void __init kho_reserve_scratch(void)
 err_free_scratch_desc:
 	memblock_free(kho_scratch, kho_scratch_cnt * sizeof(*kho_scratch));
 err_disable_kho:
+	pr_warn("Failed to reserve scratch area, disabling kexec handover\n");
 	kho_enable = false;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


