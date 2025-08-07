Return-Path: <linux-fsdevel+bounces-56926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892DFB1D038
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 03:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9389F567104
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 01:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37B61DB546;
	Thu,  7 Aug 2025 01:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="QlrF3A+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB031AC88A
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 01:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531093; cv=none; b=NssVJOMpEuw1e9wN2aX6kJXU2iZKxG3Z6kdNgz0RjT3AyFACdR5M2xIPphYuTbn58XymQIfKLJ6+ZQxs6zp8JyMDVIjZo7AboAwvH+xcHyCpZPBYQjOG8VLOYSlS/HNu3OJol2R09CDYnaLWlLJGoICHCyPkZSulpSsnv7yw/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531093; c=relaxed/simple;
	bh=pChmRpJN5MN0Cs/ZXsmC3YUcAo70fIcDoe+NxtZQw38=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=du5ypzG7he/CyDbW7Qghu+ymP1Kag3KP0/8HNL7RfjycHj+P24N+6TIKNt97vQBgCYaZmxLRvQ0i4MSh6qTOP11/SRWOvlS7fhXl3SGKnEbpC7Gw7ZJWPO8/ddFmsPs1fFT8hQKFM6/0lZQs7axQIianUA2p8uUKvUThysjJdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=QlrF3A+u; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-7074a74248dso5526816d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 18:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531090; x=1755135890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zshHU08ID0A8NXQB//otilnse1ea1iiCCRjsJeEREns=;
        b=QlrF3A+uEzNnSQi2J7vty3/Y4wlh/0cIoKk/9rMBFZEHy914iBlmF27s4ofmq8T7tt
         QheOd0sep4xtkcdyX/BEbSBEon8bBb5ZmIIkwQLbaOxoqYOJlUsmS7Gn5+BErFnRDcdJ
         FGX9oTxOEPyj/NqH+exQJhtCnXo1nzwvuo0CIBHYElttWCEULT+9h92p5eo2w5Gq3jhc
         lkV0JASIgu7B5PPYp7hqV+W50FfGZK3gHl3ZFOEKNZuOvMZbEw2Q5QGDSXE1r0BDbpjP
         vxI8DHS6+p4T0usbknEWcC6noOtLj7GGd6tHyRhq6gRKkf8Xg/7loXSgfJLX9hju3hgK
         fByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531090; x=1755135890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zshHU08ID0A8NXQB//otilnse1ea1iiCCRjsJeEREns=;
        b=rArom+S5mRwbOrBFrYwtN1YpHRDL4/JRxocsTKzO9kciDmAvv84S05uTtxHa/GJuKM
         mjM6cgRCDCVxSXwQw+d+LrGNtSmKw6b+PPt0HTw1Q4qoI2O/a+WZZYYSXCTErqGM9gNn
         yBpg4jDXUlDiWvf/XnQmHcazdBGTvUpoM3gdTp+LtiDdXwOtlitPlSx/GbA9Vy/afCBE
         l+jLaK/u726BlubZB4czkkj3vbBynM5cYgnBiaXRevBXmFn+69Zubt2kydttVaHYGS8c
         9nJgWH/uyKdyhFeXQYnM7A3ZJFRoh2wOz1vYm8kSq+s2AjECAT4abEcn26Riqb0yB1UK
         2W1A==
X-Forwarded-Encrypted: i=1; AJvYcCW6Sor49/1eMMnJmX6nLusCVPwNDJ158yN4wHJ+hDDRJ1yInkPScXZGxec4alOJDV7XnrqeQ5mkbv5nKzLX@vger.kernel.org
X-Gm-Message-State: AOJu0YwGYmtDP6u9w66xUADy3ydOAJNafv1gS74a8dYzNuaoNirEqEeq
	2qfnaIh145QxtMepm1HXdsvMmdMp61edPu4cZuvpHl7feWsgJ+qRDrXIR6fGFRwbuJk=
X-Gm-Gg: ASbGnctbuQjEFcuJVnmbx5dAH2zYmOyU1MlJ/ujBQTfAD+/njqq2QnQ5VibsELmgIi4
	krEThkcQlU4RsXUVbYfapwkr3yBKYJo/Q132FMHOscXmvebX2ujadc/k45FTUZupn4W5IXl2nqs
	cs/2fIscG2eWewlEQNUOHyV53+KJjc32OQarcebefvVVk6ngaXUaaVV/UXSxgtSGjHzsuU94ry3
	WLB8yrRlYNDtVK6ByMcMJuokOvWjphxFYABvHSokWeFLHcBBZHsJfEu9IdVO6fAxVm8X3R88mR+
	MgK0mDnVPiNSCf4neHZpODXkpupw1CF1xUzraxD8ZZVLdrojwnl0oYeSNYtoUcG7LYxwNmEaRNY
	w2zvlJ6ZuRfoqvZJrBnL77RWCw4meRO3YyeHjSp9J8N4/jU68BAj1PQUdoVA6z4BX8gAdh+tHhk
	ub+hfEU/Lrq73R
X-Google-Smtp-Source: AGHT+IHnmZoVOKyFNNYjLIT5+3p7MrntTaDtd4zF5EXEXaUvK/PtJPkVc+qy8Wy9N2jknjRUu/0o0g==
X-Received: by 2002:a05:6214:300f:b0:707:29f9:3bd1 with SMTP id 6a1803df08f44-7097964ce99mr76335266d6.46.1754531090257;
        Wed, 06 Aug 2025 18:44:50 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:44:49 -0700 (PDT)
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
Subject: [PATCH v3 02/30] kho: mm: Don't allow deferred struct page with KHO
Date: Thu,  7 Aug 2025 01:44:08 +0000
Message-ID: <20250807014442.3829950-3-pasha.tatashin@soleen.com>
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

KHO uses struct pages for the preserved memory early in boot, however,
with deferred struct page initialization, only a small portion of
memory has properly initialized struct pages.

This problem was detected where vmemmap is poisoned, and illegal flag
combinations are detected.

Don't allow them to be enabled together, and later we will have to
teach KHO to work properly with deferred struct page init kernel
feature.

Fixes: 990a950fe8fd ("kexec: add config option for KHO")

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/Kconfig.kexec | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 2ee603a98813..1224dd937df0 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -97,6 +97,7 @@ config KEXEC_JUMP
 config KEXEC_HANDOVER
 	bool "kexec handover"
 	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
+	depends on !DEFERRED_STRUCT_PAGE_INIT
 	select MEMBLOCK_KHO_SCRATCH
 	select KEXEC_FILE
 	select DEBUG_FS
-- 
2.50.1.565.gc32cd1483b-goog


