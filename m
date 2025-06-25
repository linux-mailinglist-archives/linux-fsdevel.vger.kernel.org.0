Return-Path: <linux-fsdevel+bounces-52998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADDDAE9223
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A60116BE78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469B42F5315;
	Wed, 25 Jun 2025 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="VxWLPP8s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A182F363E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893528; cv=none; b=TZgRLoEXaF1oaMBtKjxySEQ4DqQF8udS2Wz9zxqr5+j0y0clu6VUAt5vnskl8WjnIn9of0bSL3auefKte10S3V+bWdQv2D12/0JSMEF6LQt1QIa1maSoiPaPNG6FSsJqh8ZF4UQ5r7Vps0xb7gzZ2rjbe5TDA5g6zXCMY/XW9DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893528; c=relaxed/simple;
	bh=f+GDZMWDZJ+VR9AGii24ODCbYkbiXkpxGsAaLIJVFdg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyHd2w8330gfgaGsOSfhehQfLOleipUmd0efvZBqwx8ROKPLQ1UIihrj+i77lx1/j2CxibGuE/ew/RgYVk7fg/KH/jVyrRPNwIIjCjewuArEwD++GuSbU76Qth9r4476nzcfp6kA2nBPDHGU39/qxKngEVgjUZXyKNqvNKa9rYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=VxWLPP8s; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8601ce24c9so272524276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893525; x=1751498325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=inB1PU3JWa0vbtTol7UPnIAGavYFixpKMP3Mnwcd84A=;
        b=VxWLPP8sdoTqx1NZa+ByQnknb19kCXNJc4kTPASmEGQM14/7IXnhVO9f18/4xNfefP
         QZddIfROvU2MphkpTgwoBEcd2kNeO9Dhv7WT7xF4M2hBlbXhWDdkYpO4QaiTPpFGm2xM
         tYHh+DF5DTv10A22NQ8DzI+365/RBXspAo+Uygo9VjGYCtXRYTGbd4kGCU+2WX9DDUvq
         g2pDlhY/TdfTCGZVy2PegTcp1vVwrlVUyrXYHzFknl0iM1RJWUVBYYXeHnu5F3feqrVL
         fZPN2DnwYsX3hL4MAcjiMA2a2k1cvBHUWB5rWV1KWKSbrB7xaIQPuEs5+BYfaaYY9DTB
         cXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893525; x=1751498325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inB1PU3JWa0vbtTol7UPnIAGavYFixpKMP3Mnwcd84A=;
        b=d8hi+yfH2OaHk0K0z5qAAKCNQWMbPkTkNdILW1ej+aWBxqVAh62hQ+3XEf9YABjrkH
         Q/7ntnuC8WR/bvzi2EekZp83BkYZGYwcH4k12cfuD0cAB55JGqaYHqAu4uOoyZKMjUZn
         gun2/Fkmep2jFTOEiSbZpBn2xOmaCMfifsrKnOCjXKvTxhfbTBwBXSF4f8G8sjdvYRQr
         YIbdUJ67qClx069G4xMG9uGJcWM8ub2a7Zxlkudfcta773y4HMQ+ZJqpSy0MVA+o+ZSN
         VfNwx5FlylkqsZzFRDwkySXnTLSHZCUr6buGP7wpKrpafVMAzkFWfekF/YhQu0ak9Zh3
         x6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEwxkOjugA+bsWszGPdMe/yel0GcKR7sUNkhowv8AuoCKugtK52ef7pVNrfA0qpLmcJVjXBKwc9KpcW6Pt@vger.kernel.org
X-Gm-Message-State: AOJu0YxHzBctg0v89KD9bZLq/yq2jyTPUbHvl2AFBfSHT+pvc9hFwiMx
	yelSQSUyI9FwK3vQx0oXxXC5WAP72J9HdMHlEL8gvE1cKWuFdCYDSE+0j4hCQfQIIIo=
X-Gm-Gg: ASbGncsAKZskaCE1l6WbqUZca0IiPDYQIVzH2iWfJ0NzJUK45J7zwxctnzIJVXz4sxL
	gb/bPkn8zkcjH9QdXyWnkyCX7g5JkgQHAXLqp3ljrAafkd0DpJynwkmzvLGF1Ft66lgFxYWCVPj
	7JNHkpAVRaDRMZHgqVZRRDuE+7KIT8EZjOI1U0e3uaFKdGva6oyG6Tx+JQXt509rmguNT/o7H8I
	HZ6AQaNohwdCAOsUQzSxFckS+KU0JjyIla/kg4fNqwQK4yroC45uYKOju5/FAHjHHSp3kxzHwlA
	WtbN+7f32TzNkDEZZqu/0dqmyNUV7/+ID1hD9v8T/0nswFVfSuMOM45NkFvdxA6IsGU2fWAcdkX
	XGKDB96spn47qtAGzhntbjB+pCnQ+2IhEsBvIqOW/jEzjxwYeykVBDLOaV1TlO+s=
X-Google-Smtp-Source: AGHT+IHRsJtLlwzyJUd/Ox/O3krs7IL9puzl8GoqWoWuzYibrteq8e0xpTf2XL0zflmCtIomZsxpVQ==
X-Received: by 2002:a05:6902:10cf:b0:e81:e333:fc38 with SMTP id 3f1490d57ef6-e8601762c25mr6548852276.19.1750893525010;
        Wed, 25 Jun 2025 16:18:45 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:18:44 -0700 (PDT)
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
Subject: [PATCH v1 01/32] kho: init new_physxa->phys_bits to fix lockdep
Date: Wed, 25 Jun 2025 23:17:48 +0000
Message-ID: <20250625231838.1897085-2-pasha.tatashin@soleen.com>
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

Lockdep shows the following warning:

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.

[<ffffffff810133a6>] dump_stack_lvl+0x66/0xa0
[<ffffffff8136012c>] assign_lock_key+0x10c/0x120
[<ffffffff81358bb4>] register_lock_class+0xf4/0x2f0
[<ffffffff813597ff>] __lock_acquire+0x7f/0x2c40
[<ffffffff81360cb0>] ? __pfx_hlock_conflict+0x10/0x10
[<ffffffff811707be>] ? native_flush_tlb_global+0x8e/0xa0
[<ffffffff8117096e>] ? __flush_tlb_all+0x4e/0xa0
[<ffffffff81172fc2>] ? __kernel_map_pages+0x112/0x140
[<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
[<ffffffff81359556>] lock_acquire+0xe6/0x280
[<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
[<ffffffff8100b9e0>] _raw_spin_lock+0x30/0x40
[<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
[<ffffffff813ec327>] xa_load_or_alloc+0x67/0xe0
[<ffffffff813eb4c0>] kho_preserve_folio+0x90/0x100
[<ffffffff813ebb7f>] __kho_finalize+0xcf/0x400
[<ffffffff813ebef4>] kho_finalize+0x34/0x70

This is becase xa has its own lock, that is not initialized in
xa_load_or_alloc.

Modifiy __kho_preserve_order(), to properly call
xa_init(&new_physxa->phys_bits);

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_handover.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 5a21dbe17950..1ff6b242f98c 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -144,14 +144,35 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 				unsigned int order)
 {
 	struct kho_mem_phys_bits *bits;
-	struct kho_mem_phys *physxa;
+	struct kho_mem_phys *physxa, *new_physxa;
 	const unsigned long pfn_high = pfn >> order;
 
 	might_sleep();
 
-	physxa = xa_load_or_alloc(&track->orders, order, sizeof(*physxa));
-	if (IS_ERR(physxa))
-		return PTR_ERR(physxa);
+	physxa = xa_load(&track->orders, order);
+	if (!physxa) {
+		new_physxa = kzalloc(sizeof(*physxa), GFP_KERNEL);
+		if (!new_physxa)
+			return -ENOMEM;
+
+		xa_init(&new_physxa->phys_bits);
+		physxa = xa_cmpxchg(&track->orders, order, NULL, new_physxa,
+				    GFP_KERNEL);
+		if (xa_is_err(physxa)) {
+			int err_ret = xa_err(physxa);
+
+			xa_destroy(&new_physxa->phys_bits);
+			kfree(new_physxa);
+
+			return err_ret;
+		}
+		if (physxa) {
+			xa_destroy(&new_physxa->phys_bits);
+			kfree(new_physxa);
+		} else {
+			physxa = new_physxa;
+		}
+	}
 
 	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
 				sizeof(*bits));
-- 
2.50.0.727.gbf7dc18ff4-goog


