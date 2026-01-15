Return-Path: <linux-fsdevel+bounces-73864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B89D22183
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 03:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AEF83034187
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 02:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE88274B5F;
	Thu, 15 Jan 2026 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAZFPIJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125825FA0E
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768443078; cv=none; b=e7vbsOFX6XA990kPPPgZabeO+Qeo5e+sKYIHnIQhSSw5JJEuwq8UtsDKO0gSfWK5IC/ovWDuwrK+gQ2YsuW2s0sGBZCOsOPCSWpi/onHzK/5nISrh59uzuNr4TG3eikXc+IQJjI09qirACMf6K44daNjvvfeiuXTfvd2QeUZ47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768443078; c=relaxed/simple;
	bh=f2QVeCiI4AcBvJ/Yo8FFrUl6c3QtkngGKO6/iFCBZrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ln+mdfAkPryZit997/V+OBNV3Mq5ZouT8tebNcqS3c1uVfAW9GSG2HDX/gBlKrSzKxRhJF+BsLkwGL85izR9kJbbzNIvXEDxppxiBB9PpsN1vUId/iydXA4JZmlJuVhiAKNj4uIEj89jdaO4LJM+3ONbDtPIBHcdUY3UphXcz9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAZFPIJO; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81f42a49437so216355b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 18:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768443076; x=1769047876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Lu4KyXAr/aCUF1cDLxpvAhnKtVcWm2yDkvteqB5wj8=;
        b=nAZFPIJOE5FXHjIoGbrSAtAxZNjL3G9YrVKtqDBkmDcCC8+OI8TWLuw0bA7utGQO7Z
         jH97PLs5WfFiFQKQ+gEkn73E9HOkVdU1zYAoVgiCQurDWIF+95tDkPGCnSsZ/kVcZyx1
         CuPhHUptfSbtFAy//68LNgyE2ZGM+klQ7JpSdwRQun5KZ7ogW3ocpO57x0wNdyTxsMVv
         /iSXGX8UJvSrLqqLO4v/q58U4C4Txu5qlUKzlML6IDFpaA591w0OOnTWBVnAdwXu+Ylb
         519v/eg1x1doB6qNQHG6VsZ/IkMiNV/Y5WiSeAFTa63M9TQcQAAyg2lLWdKFSlPYEwfS
         jDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768443076; x=1769047876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Lu4KyXAr/aCUF1cDLxpvAhnKtVcWm2yDkvteqB5wj8=;
        b=DDCam0nX9eaeM+oAs5Co9z0+SzEJ9zj2D/8xSgyN4o5hYIOp8X8UDdRr5MUp5DXLZg
         OgQu3SfF1EyUBNFplYK2JXLTUyYn0uG5DFtQsLIMLQdcNUVRJoHNTLOFnS+y5sjI3Rc+
         KbU0a8A7Rg0mMdb7Omx1yeOl1tjO+EPqwBZjV/DkOeeiQD05j+6iTSI4EzhNBdl6sJKJ
         C1N7jKpgiB647kVHSn/xKR8ys7RPd4jYYLkE63ymuVpsytC4kqzE4eBsoMow7g6m4lqF
         o8WVwBdP4RFnRibwKZOa5j7zWN4tSskY2ZqmJuhcKiSx+STmjzm7KQlUnTI/G3LeiSnF
         NjVg==
X-Forwarded-Encrypted: i=1; AJvYcCX5QSdamwaoLVtQvtCbwUeiTRWiA7dxNq+vlBOIonQNQAnIlWpp8knfb3k8plWTwMIwWiu5gRFiHG/mx6xK@vger.kernel.org
X-Gm-Message-State: AOJu0YwySxMiTd1HYsHdYJ5oVj0TWorKNeI0CEzarXZ93Z9HDl7jlZ6S
	l0WTq00+Yj7ekc7nBBlq7CbwY7fnNlUqKODtchKqQID7V5Ls3M+9TJPY
X-Gm-Gg: AY/fxX7rHJa1QN4XypPAaXT4TbynAyHHuDxnlzF2khz/Dn2v7oyjk5hG3fxAv+6DEsy
	B3FFs6CzvTtZCat87r8RboaCv4AVBiqj1EM8g+n6tRdb0iwUCyWueP/R3dAU4Sa6zbdd5Pb5162
	KkAp66VOFNqyBSxZoc1REQnKy5ZlXtjjha/4qlb/ekR5HwK/jcCnEkbbCaLbnA/vtWrnzf1NXZW
	DK3mD3paupoFCvae+NzUdBORiuul3B0+OSu4r24xUu4HMrB+Xjez1NJK5m1FEAYHKdBrN0ScMHu
	75VZ8+I0vsQOVO4blEDq4Rf/UzpRMQM+HcwOnGNLYpAk6hyeodxJYdFEb/r0LbjUd1slNGjNSgz
	l99mEX3JE/pZv/EeqYww04Q8+aGPOeL+/kyLUWy1lkz0zePrf7PxAPGmJfAEEE515IwNsYnbK74
	ObvH7cmvN5R9nsOkTKX/EyzxrKdr7U
X-Received: by 2002:a05:6a00:6c81:b0:81d:e9b1:b6d9 with SMTP id d2e1a72fcca58-81f81d33b9fmr4200239b3a.15.1768443075965;
        Wed, 14 Jan 2026 18:11:15 -0800 (PST)
Received: from n232-175-066.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e65097asm806159b3a.37.2026.01.14.18.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 18:11:15 -0800 (PST)
From: guzebing <guzebing1612@gmail.com>
To: brauner@kernel.org,
	djwong@kernel.org
Cc: hch@infradead.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guzebing@bytedance.com,
	guzebing <guzebing1612@gmail.com>,
	syzbot@syzkaller.appspotmail.com,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v3] iomap: add allocation cache for iomap_dio
Date: Thu, 15 Jan 2026 10:11:08 +0800
Message-Id: <20260115021108.1913695-1-guzebing1612@gmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As implemented by the bio structure, we do the same thing on the
iomap-dio structure. Add a per-cpu cache for iomap_dio allocations,
enabling us to quickly recycle them instead of going through the slab
allocator.

By making such changes, we can reduce memory allocation on the direct
IO path, so that direct IO will not block due to insufficient system
memory. In addition, for direct IO, the read performance of io_uring
is improved by about 2.6%.

v3:
kmalloc now is called outside the get_cpu/put_cpu code section.

v2:
Factor percpu cache into common code and the iomap module uses it.

v1:
https://lore.kernel.org/all/20251121090052.384823-1-guzebing1612@gmail.com/

Tested-by: syzbot@syzkaller.appspotmail.com

Suggested-by: Fengnan Chang <changfengnan@bytedance.com>
Signed-off-by: guzebing <guzebing1612@gmail.com>
---
 fs/iomap/direct-io.c | 133 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5d5d63efbd57..4421e4ad3a8f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -56,6 +56,130 @@ struct iomap_dio {
 	};
 };
 
+#define PCPU_CACHE_IRQ_THRESHOLD	16
+#define PCPU_CACHE_ELEMENT_SIZE(pcpu_cache_list) \
+	(sizeof(struct pcpu_cache_element) + pcpu_cache_list->element_size)
+#define PCPU_CACHE_ELEMENT_GET_HEAD_FROM_PAYLOAD(payload) \
+	((struct pcpu_cache_element *)((unsigned long)(payload) - \
+				       sizeof(struct pcpu_cache_element)))
+#define PCPU_CACHE_ELEMENT_GET_PAYLOAD_FROM_HEAD(head) \
+	((void *)((unsigned long)(head) + sizeof(struct pcpu_cache_element)))
+
+struct pcpu_cache_element {
+	struct pcpu_cache_element	*next;
+	char	payload[];
+};
+struct pcpu_cache {
+	struct pcpu_cache_element	*free_list;
+	struct pcpu_cache_element	*free_list_irq;
+	int		nr;
+	int		nr_irq;
+};
+struct pcpu_cache_list {
+	struct pcpu_cache __percpu *cache;
+	size_t element_size;
+	int max_nr;
+};
+
+static struct pcpu_cache_list *pcpu_cache_list_create(int max_nr, size_t size)
+{
+	struct pcpu_cache_list *pcpu_cache_list;
+
+	pcpu_cache_list = kmalloc(sizeof(struct pcpu_cache_list), GFP_KERNEL);
+	if (!pcpu_cache_list)
+		return NULL;
+
+	pcpu_cache_list->element_size = size;
+	pcpu_cache_list->max_nr = max_nr;
+	pcpu_cache_list->cache = alloc_percpu(struct pcpu_cache);
+	if (!pcpu_cache_list->cache) {
+		kfree(pcpu_cache_list);
+		return NULL;
+	}
+	return pcpu_cache_list;
+}
+
+static void pcpu_cache_list_destroy(struct pcpu_cache_list *pcpu_cache_list)
+{
+	free_percpu(pcpu_cache_list->cache);
+	kfree(pcpu_cache_list);
+}
+
+static void irq_cache_splice(struct pcpu_cache *cache)
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
+static void *pcpu_cache_list_alloc(struct pcpu_cache_list *pcpu_cache_list)
+{
+	struct pcpu_cache *cache;
+	struct pcpu_cache_element *cache_element;
+
+	cache = per_cpu_ptr(pcpu_cache_list->cache, get_cpu());
+	if (!cache->free_list) {
+		if (READ_ONCE(cache->nr_irq) >= PCPU_CACHE_IRQ_THRESHOLD)
+			irq_cache_splice(cache);
+		if (!cache->free_list) {
+			put_cpu();
+			cache_element = kmalloc(PCPU_CACHE_ELEMENT_SIZE(pcpu_cache_list),
+									GFP_KERNEL);
+			if (!cache_element)
+				return NULL;
+			return PCPU_CACHE_ELEMENT_GET_PAYLOAD_FROM_HEAD(cache_element);
+		}
+	}
+
+	cache_element = cache->free_list;
+	cache->free_list = cache_element->next;
+	cache->nr--;
+	put_cpu();
+	return PCPU_CACHE_ELEMENT_GET_PAYLOAD_FROM_HEAD(cache_element);
+}
+
+static void pcpu_cache_list_free(void *payload, struct pcpu_cache_list *pcpu_cache_list)
+{
+	struct pcpu_cache *cache;
+	struct pcpu_cache_element *cache_element;
+
+	cache_element = PCPU_CACHE_ELEMENT_GET_HEAD_FROM_PAYLOAD(payload);
+
+	cache = per_cpu_ptr(pcpu_cache_list->cache, get_cpu());
+	if (READ_ONCE(cache->nr_irq) + cache->nr >= pcpu_cache_list->max_nr)
+		goto out_free;
+
+	if (in_task()) {
+		cache_element->next = cache->free_list;
+		cache->free_list = cache_element;
+		cache->nr++;
+	} else if (in_hardirq()) {
+		lockdep_assert_irqs_disabled();
+		cache_element->next = cache->free_list_irq;
+		cache->free_list_irq = cache_element;
+		cache->nr_irq++;
+	} else {
+		goto out_free;
+	}
+	put_cpu();
+	return;
+out_free:
+	put_cpu();
+	kfree(cache_element);
+}
+
+#define DIO_ALLOC_CACHE_MAX		256
+static struct pcpu_cache_list *dio_pcpu_cache_list;
+
 static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
 		struct iomap_dio *dio, unsigned short nr_vecs, blk_opf_t opf)
 {
@@ -135,7 +259,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 			ret += dio->done_before;
 	}
 	trace_iomap_dio_complete(iocb, dio->error, ret);
-	kfree(dio);
+	pcpu_cache_list_free(dio, dio_pcpu_cache_list);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_dio_complete);
@@ -620,7 +744,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (!iomi.len)
 		return NULL;
 
-	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
+	dio = pcpu_cache_list_alloc(dio_pcpu_cache_list);
 	if (!dio)
 		return ERR_PTR(-ENOMEM);
 
@@ -804,7 +928,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	return dio;
 
 out_free_dio:
-	kfree(dio);
+	pcpu_cache_list_free(dio, dio_pcpu_cache_list);
 	if (ret)
 		return ERR_PTR(ret);
 	return NULL;
@@ -834,6 +958,9 @@ static int __init iomap_dio_init(void)
 	if (!zero_page)
 		return -ENOMEM;
 
+	dio_pcpu_cache_list = pcpu_cache_list_create(DIO_ALLOC_CACHE_MAX, sizeof(struct iomap_dio));
+	if (!dio_pcpu_cache_list)
+		return -ENOMEM;
 	return 0;
 }
 fs_initcall(iomap_dio_init);
-- 
2.20.1


