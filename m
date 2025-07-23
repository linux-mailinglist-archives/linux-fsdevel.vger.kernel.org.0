Return-Path: <linux-fsdevel+bounces-55842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BA7B0F5CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B089586126
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B35B2F5C5F;
	Wed, 23 Jul 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="lLeh4OIW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2BB2F548C
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282022; cv=none; b=sRRSu5PZ0+XAz3Bvh8gaVmINLol0BM5BTbO7lvYq1Tj9zOrI+3XaFXzta/+t0zKz4AfAOZ0Bn7gAMlARx77PNWCRXOX6HbbVJf/PM3W+wIKNY/XSJwL7v52R6bXC5ULZCFxh9uQinfpLk0kMEY+fWEvwV4u8AO8CcYt9LWUVSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282022; c=relaxed/simple;
	bh=sJLDn8ryoW/ov6UjZZGTTudXv5WHl8/v2Z5ZbPyJ1x4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CF1x9J5qQ6zUljD+DP4ZF3qNVX5tAiuj26C+rHEK+3CrhEiHmCr8u04HVSNzDXNqOuhIiCpgtehcqm72LmNLIa3PNxYO/XlRmXHQV4tNA+SPrceeYCn3mlAd73yDgLVp7cui6EwPzlAR1YRKZkzNxi1wkEjBlwSuirt4gdo3120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=lLeh4OIW; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7180bb37846so54184607b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282019; x=1753886819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7cl1P/nffEHtPrwqwqBj2n/TmbnAXjnzD/OU22eOOo=;
        b=lLeh4OIWCBKjqs1N2TriFDuB+ubYYiseni13/mb49rqAEhv2jLPKXb3Q/Mt4rf8D+Z
         7yJwP/iH0iEperDTE1UJelAthrHwmUaZj5cFcEBvnG0IGsmcnsZ4WAvZv7geAbLGv4vE
         fmMj/N8K1oy3jNEltDSq/BUyPW75NEC+xgiUamE4ezJO2QZFp/l1vZOkUu96jPBefpci
         x/ghPi6RS0ioS+uuVxBn1m0yOsq9yXXNmipUz9VUSxh1x2ahltuhH9zXtrxah945fb6q
         9soOx0N9pwYeBRyFHMoAuRsRWpIIyt7NidN7JD7l97y2oc7p4deeBVm17WMsi+ciOXrt
         8etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282019; x=1753886819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7cl1P/nffEHtPrwqwqBj2n/TmbnAXjnzD/OU22eOOo=;
        b=g/XkgH/1J7tFywKoMjgZsogE6ci+LJn1FqpCpiXbIbf63dvOndYQAF00IKTkvIfPm7
         +qm7XevZDzPxuUuZhF4GpIyr+Xep4RwwfTG+nVUxpQ7PemZX7+kphVi7o5k8IVcWmAym
         0tvyJCE6xXp7rgZcig4FfOAGQBZ6LpeEQf1BGa3+d9t/oeMpAqyYCoOYoIx2B3Kg5JPT
         2H21KP7EAUwT6kPVRCExE6AvFOjveucEaNJc8HbSvx/lNJzTXlLeoeIsn1o+2OjXWOQB
         LJdG0q/D+7HF9nCmaQEx8ueq6/IuRDeipfGEc89eYPxuU2YDdhLJQoPBPSxPf52yZ6WK
         1qfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx7OgvDxNdwT6iBeyJzrPOcJ4d36IhD5/4jpn0i0VP/dy0bR8JKTCUN0lcRwFrm3/WemRIIVMkdobpy2z+@vger.kernel.org
X-Gm-Message-State: AOJu0YxdwoB3as41MJ2UiYwNj6Pzzx729Bn+IdBLrfvpsQQZlZqdR1OP
	K3PNq09FUWRveJyFXmNo+SSLs0zpogu6ffWlCiLYUFpGLD1Fuw5s83LaUleSrqLrzeM=
X-Gm-Gg: ASbGnctH5NZyFQGFmanmy+W0oIzZj7ws2dIVGCgqEXUbiA+4rt6jmbKAHxfJFgFae7i
	2msO3x2nDBEkj5z5gjHlvZSs3GxQSVSRAO2gNU9vkRdHT/zticfZBhi1u6fmnlGW/bl25oPfsYn
	DXKPFlef6b89LAqloC57BrHlFwN4vVstpGEhOUty9e+vIBm00nUyDhEtAgZd9trDg3OwajV0epZ
	DqYj4l2/v+mNSgqpPvWe6tNwZUEVgNHFG8YoCCtiDzkBlahp73JI06Cv7VvvTlySAdsr+d1tj2E
	iqsgWVmKJ0WTv3rwwayx4pgpZKTa5POkld7tEZV662seoTvVQCGtUyXCfqmRsOfadO8KHxnfVBE
	jg1TQ+viDbNteD9MZbIJJj4heXqROcbmTS4qp/WM/hKEbHRGVpjHoWOMyFzceJUlnVAJzuTkjbJ
	0e3GJRayonq3kwLQ==
X-Google-Smtp-Source: AGHT+IE6ehQOayyo1lb2cZBdo6W6rK2fNueePB1JRBmEV6kcBUnmTmWNn0MIzxo8F5fZ2uNGvf14yw==
X-Received: by 2002:a05:690c:490b:b0:719:4c68:a6f8 with SMTP id 00721157ae682-719b4258512mr43723377b3.32.1753282018494;
        Wed, 23 Jul 2025 07:46:58 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:46:57 -0700 (PDT)
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
Subject: [PATCH v2 02/32] kho: mm: Don't allow deferred struct page with KHO
Date: Wed, 23 Jul 2025 14:46:15 +0000
Message-ID: <20250723144649.1696299-3-pasha.tatashin@soleen.com>
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
2.50.0.727.gbf7dc18ff4-goog


