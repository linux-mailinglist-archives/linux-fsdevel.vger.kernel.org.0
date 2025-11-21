Return-Path: <linux-fsdevel+bounces-69366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F51DC7807D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 10:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0A003606F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 09:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7206F33A6E6;
	Fri, 21 Nov 2025 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxstJKO0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E5E33B6C7
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763715662; cv=none; b=keNIqr+lBx2hjpkdndeoNLw5x3Vnr1PHReMOCjyF5e1SrFXYm4vwv34yoThs0sCYSpZLjhRzN3NVY648a0LSoSxRLZ7qSWO+XNwOaMq75H1mIUkS9RtPxWIxRjJXqHIKsLyrV9lgk9e0Klmph9fyX1kKoFt5InJHPQDinpjVynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763715662; c=relaxed/simple;
	bh=ZHoIOZsqYgxNlG+z6MWLJCh/3K8n5QbzOVNeHfh2rkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p7LCUxBoMsCR/CCTK6DWWaJUtVxTuwCtNIcWfN5u65Yu0hyh43on6jJNm85+FxRFbsak4nw+RPAI8p3ByD/FO41g48e0r0EDFI9LDOx48xBQuKjEfGf79sGcwl7gDLtvviTDH1FoSzbV2f8vvPqjVIcrWZDkF0cYQ3mwtoFlenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxstJKO0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2984dfae0acso28015015ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 01:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763715660; x=1764320460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7CEYg94xBFZCkQHBB1DCwySVM1sXv1HB/XC9eerLVQY=;
        b=ZxstJKO0XXpVtCySvxqNW0qpAZf9UZ/7bn1YxmmAuDX+FGiZrmylTLW2OA1uaq/XaT
         StGmkTU615gtCatcj2s3ZEmZVsJhCHRGD9ogEO0weoFgrcoNzSoPqQAFaGECUs8LBmCm
         I8DiEYaWN1fNnKYYABG5VryUwwDVlS1gLDemdxrq2AMwSvGVt5KLat6qtKYRUhJf+5l/
         REKMKywS+k9XYEMfbgk7Oyrs5HEdb3xfEr29Kj1pIQ3SfA+VWW/8ZC57wDoqq0c6Mz3l
         mYgVqOQ3oRiQp+Yo3k3oFqx4jIe5x2HIrvS41td5yqTZ5EO/ZA3pablPt+2XuOQcJgNi
         vLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763715660; x=1764320460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CEYg94xBFZCkQHBB1DCwySVM1sXv1HB/XC9eerLVQY=;
        b=fQOXEyhByU8LD9aJBOwWsAulmsabxOYLlfHVovpqgKUyscUSa0URoo7bu0TNBUrrQI
         3y+vAMYEwEMBvmvrd7RvMwnNn4jEtOXMd0/BkpbBR4Ulb7pau5VBg0stlTaYFgI18qfW
         7D31S7fEB3WmSqGqe97m9ZC0SxYkmDIngdjJCeG8QGM94vGmn8Df/b0HM0hYigwZXfMg
         m5Vuz+VIrdHfaTg+z96axXUSuSaFxZvgr6S/otX62g5ahnXTFvk9iOPC0LOnDJfiBPTT
         +ImkImwnDUx5PGZBi+sEX/Sg4Us7Ph5x8TArciJpHL/eCw1PtayEgNLT7yjeCL2XWWra
         Ffww==
X-Forwarded-Encrypted: i=1; AJvYcCUu1kUnBnLFmAYr+/BJT3NFIzBzUU61ir6J5T1l8YZEK2+4sXC6mXT6H+R1g1hOxPWIEnqZ6RwaZo+3AJ+Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv7nOEf+i8sO2cW5pFlbFtuWTuPIzazmufdUO/eHMUip+PW7g/
	/nqAp2MoNmxBdZJSrCZMWyVyoF965yYmTg1Mw0nqHpCJrZfOkqOa2C46
X-Gm-Gg: ASbGncvGDj/Qp8YoV3i8Tc0QjVSxWclddHIb3yRFuZRQyDdHVG2myGCCJd8c9xuaaSR
	/f7kIJbsfwx3XCnlQfBwDmkV8tecJINN8L2vTY39MKsXbJ6UrLYE1BqAxpPDEAOSdENLnwhus5X
	U/7bO8TLoSCaI+/n3Btzlf24uupO3WhDpHzsN+5YTNKKFkNU06gXtYwEP2DUA2MNVC1YuXyuGNS
	75Z0xXlb1QrGaAhQMzg8iXsheYZgINiZgUnE6prEkPoiDoEIec1KRBsc1LwUy00PjgfaX3fVyUU
	Olx2fKhQQ0x/ab8w7VCwgSIN2UN8KnTJN6eYEvOOU5DHanWE7y3HDsHuU+hLQmiuNWNgwAoqRYT
	MvtKgkh/bzyZUa9h1U5meSxzlmG4IpcXFHsD0WM4EGkiwRNciWkD0DgnRGd1mB+qH1GhZEgOOsc
	9RMe2MF7trdDRHASkHybIWNIvDXzgY
X-Google-Smtp-Source: AGHT+IE87ieZqlbUkR0VokkAR9tSsD3SSdbeKfahM6e7QiM51lcKjUC/xOt7U7NmTXamvMsyNuF7bw==
X-Received: by 2002:a17:903:2985:b0:298:1830:6ada with SMTP id d9443c01a7336-29b6bf19c83mr24848795ad.30.1763715660323;
        Fri, 21 Nov 2025 01:01:00 -0800 (PST)
Received: from n232-175-066.byted.org ([36.110.131.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e638sm50556065ad.58.2025.11.21.01.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 01:01:00 -0800 (PST)
From: guzebing <guzebing1612@gmail.com>
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guzebing <guzebing@bytedance.com>,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH] iomap: add allocation cache for iomap_dio
Date: Fri, 21 Nov 2025 17:00:52 +0800
Message-Id: <20251121090052.384823-1-guzebing1612@gmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: guzebing <guzebing@bytedance.com>

As implemented by the bio structure, we do the same thing on the
iomap-dio structure. Add a per-cpu cache for iomap_dio allocations,
enabling us to quickly recycle them instead of going through the slab
allocator.

By making such changes, we can reduce memory allocation on the direct
IO path, so that direct IO will not block due to insufficient system
memory. In addition, for direct IO, the read performance of io_uring
is improved by about 2.6%.

Suggested-by: Fengnan Chang <changfengnan@bytedance.com>
Signed-off-by: guzebing <guzebing@bytedance.com>
---
 fs/iomap/direct-io.c | 92 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5d5d63efbd57..7a5c610ded7b 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -54,8 +54,84 @@ struct iomap_dio {
 			struct work_struct	work;
 		} aio;
 	};
+	struct iomap_dio		*dio_next;	/* request queue link */
 };
 
+#define DIO_ALLOC_CACHE_THRESHOLD	16
+#define DIO_ALLOC_CACHE_MAX		256
+struct dio_alloc_cache {
+	struct iomap_dio		*free_list;
+	struct iomap_dio		*free_list_irq;
+	int		nr;
+	int		nr_irq;
+};
+
+static struct dio_alloc_cache __percpu *dio_cache;
+
+static void dio_alloc_irq_cache_splice(struct dio_alloc_cache *cache)
+{
+	unsigned long flags;
+
+	/* cache->free_list must be empty */
+	if (WARN_ON_ONCE(cache->free_list))
+		return;
+
+	local_irq_save(flags);
+	cache->free_list = cache->free_list_irq;
+	cache->free_list_irq = NULL;
+	cache->nr += cache->nr_irq;
+	cache->nr_irq = 0;
+	local_irq_restore(flags);
+}
+
+static struct iomap_dio *dio_alloc_percpu_cache(void)
+{
+	struct dio_alloc_cache *cache;
+	struct iomap_dio *dio;
+
+	cache = per_cpu_ptr(dio_cache, get_cpu());
+	if (!cache->free_list) {
+		if (READ_ONCE(cache->nr_irq) >= DIO_ALLOC_CACHE_THRESHOLD)
+			dio_alloc_irq_cache_splice(cache);
+		if (!cache->free_list) {
+			put_cpu();
+			return NULL;
+		}
+	}
+	dio = cache->free_list;
+	cache->free_list = dio->dio_next;
+	cache->nr--;
+	put_cpu();
+	return dio;
+}
+
+static void dio_put_percpu_cache(struct iomap_dio *dio)
+{
+	struct dio_alloc_cache *cache;
+
+	cache = per_cpu_ptr(dio_cache, get_cpu());
+	if (READ_ONCE(cache->nr_irq) + cache->nr > DIO_ALLOC_CACHE_MAX)
+		goto out_free;
+
+	if (in_task()) {
+		dio->dio_next = cache->free_list;
+		cache->free_list = dio;
+		cache->nr++;
+	} else if (in_hardirq()) {
+		lockdep_assert_irqs_disabled();
+		dio->dio_next = cache->free_list_irq;
+		cache->free_list_irq = dio;
+		cache->nr_irq++;
+	} else {
+		goto out_free;
+	}
+	put_cpu();
+	return;
+out_free:
+	put_cpu();
+	kfree(dio);
+}
+
 static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
 		struct iomap_dio *dio, unsigned short nr_vecs, blk_opf_t opf)
 {
@@ -135,7 +211,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 			ret += dio->done_before;
 	}
 	trace_iomap_dio_complete(iocb, dio->error, ret);
-	kfree(dio);
+	dio_put_percpu_cache(dio);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_dio_complete);
@@ -620,9 +696,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (!iomi.len)
 		return NULL;
 
-	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
-	if (!dio)
-		return ERR_PTR(-ENOMEM);
+	dio = dio_alloc_percpu_cache();
+	if (!dio) {
+		dio = kmalloc(sizeof(*dio), GFP_KERNEL);
+		if (!dio)
+			return ERR_PTR(-ENOMEM);
+	}
 
 	dio->iocb = iocb;
 	atomic_set(&dio->ref, 1);
@@ -804,7 +883,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	return dio;
 
 out_free_dio:
-	kfree(dio);
+	dio_put_percpu_cache(dio);
 	if (ret)
 		return ERR_PTR(ret);
 	return NULL;
@@ -833,6 +912,9 @@ static int __init iomap_dio_init(void)
 
 	if (!zero_page)
 		return -ENOMEM;
+	dio_cache = alloc_percpu(struct dio_alloc_cache);
+	if (!dio_cache)
+		return -ENOMEM;
 
 	return 0;
 }
-- 
2.20.1


