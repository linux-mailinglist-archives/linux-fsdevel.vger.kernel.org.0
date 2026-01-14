Return-Path: <linux-fsdevel+bounces-73621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E255D1CE47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 906F3300B885
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DED737A4BD;
	Wed, 14 Jan 2026 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICkBm14S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C8257845
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376514; cv=none; b=K8WvdN0SAss5hieY8nwg8eTK/J6xgnoaxqhbdTvrUSFaoAneEaLP/cxlZx/memzcPTknPB9MwaU5E13/njIa66kI8q9S6qkAO/O60Mi73svFus7pJWB2OX4scxThMC7ASI0svTmet0LGcrI1PvWzgAuw55742ClbkwZKHFZgNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376514; c=relaxed/simple;
	bh=+H3aAh+H9MYWBdA3obltdIOF5BErV3p/RdjTsRHDREA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EGODWTjP0rpq+83vQK7efQf1g0PAWQFyiaWViUabQk31zKnjzFGUWpA/uQD/p29R24g9HbKZsbEa3uKbmNPRECmivFihYo/ye3kwiHn0sMS7luq6w5Hvbjn12QLV4TI7m64+Uf9zBb18NfE0jIzDiS2sSGcTmKnSq9B4w1de9qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICkBm14S; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0833b5aeeso83394285ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 23:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768376505; x=1768981305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=snBrbkipsnG2NrPPSCJsD8qwO3TtVqHYjFPmR+kbTww=;
        b=ICkBm14SWIotz6yZrsGoMpdITnqLw483a4lo4R7iflmomOVI5ibeA/69PxFJJwuq0M
         ZBYwMdF14IzJLYOfdWNrsV8wXzLHBPI5+vRvdrtvv1iwfHu/8UiBQMvQi8nRaz95W/99
         H6LA0p4EiucanWHc5Sd1tjuB95X8TrL6bZp7jHFuer0plZJabBfEVpCevxIKYBZYymoF
         WiC8pC2CqkOiDuBbADjI8ApJXno/nMgPgPArpkxM7txXvzdHOhk2Lb1VypkLhDtOxbW2
         zZ5l2MaSPivQJiD7JSfXf40doDhf6SJBEZGJOOh9gKI7uIItwpJsbF0wbEnSBvJ8EvpR
         LfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768376505; x=1768981305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snBrbkipsnG2NrPPSCJsD8qwO3TtVqHYjFPmR+kbTww=;
        b=cg7TYdYNU9rmnEIvbVE3NFZSspltw999+frnEytpddtPkRraRJnOtt5E+bHkqBWtb6
         8RpRtw4D3lFN3OJ0AjXX+Ym2+PjRlLS0FBnZ0OvKPy8Dlyz6hKqXzunS9/nKBXG55MFi
         1IJ298PSV8NbzTTPaddB3borZ1QeAVeD3fB6b5pJTt29GNejovsxr7vSXiJD/TDPuKh5
         2P22v5k1595srJV2SXHZLotswKQYX/+8a5x3ALLkHXbl+ms8OBAr5GLVrw+zYM/67zun
         FWIRGYMZdeO2a1WI/r/4S4Wusi2N4hNzOV25/xHs5f0ji72IloKWXAt3EQitkFrd4fKz
         EjJA==
X-Forwarded-Encrypted: i=1; AJvYcCX5wIKz80OoYThftyzd4X3FWgSwDbi77ahl7FFxzL4EwWoRJa1+G+wW/HTLSafEKc34UzdjhzKfpDhzU8Bt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1J+iD48+U76vXd/epnG3A+YCwG5Jd+QMiqa99AO8yvwqH4agB
	52IKuIQvDPFDYoD/h/I5IprxHSq3VuDtGQvyW7fDEZSsqDwXpSABIfkt
X-Gm-Gg: AY/fxX7s9V6e3eQUQSHrVEEH4695mT9vUP2X92CNNMTGRejnvW4GXjWd0ykIsQkrUdI
	t7snwQfblAujrpeZ+axd+DEL4uHDUUO0pWJ3Z/m2KUI5pfRzmiAPsGypRvdKJKr/v9wOK800ZVw
	Wk+zXW1yODI8nbCqfCOOOTgFqmGEY26bQsPZZdPVuoUL6bB9CaYtnWWFaGk4muew6/sE6ChDsEJ
	Mbz3KTEG5BO83WbxZPjPTo9gx8v6ExnAswzZLPwIK9scGdxfMKHVrL+svN7Bkyi1JjPOXaOZLrR
	eDY4WqFd/QSSqOH5WTpCS9YWvsLDRwpIuV9d7asQJxlVBkYcVPSgbSRYEy8dFdOQa40+3G8zlab
	cM19uw71S8OCuRStj2/o2WntbnCA2DSuoZNSAZV3CrtcAGsAiw7L3WwHzyYaMgOj/2pyiU6T43J
	t0ytBJw9efmbtN3lLDiVKSbJmNTlRo1g==
X-Received: by 2002:a17:902:d506:b0:2a5:99e9:569d with SMTP id d9443c01a7336-2a599e9579amr22476575ad.18.1768376505152;
        Tue, 13 Jan 2026 23:41:45 -0800 (PST)
Received: from n232-175-066.byted.org ([36.110.163.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2debsm221476875ad.65.2026.01.13.23.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 23:41:44 -0800 (PST)
From: guzebing <guzebing1612@gmail.com>
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guzebing <guzebing1612@gmail.com>,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v2] iomap: add allocation cache for iomap_dio
Date: Wed, 14 Jan 2026 15:41:13 +0800
Message-Id: <20260114074113.151089-1-guzebing1612@gmail.com>
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

v2:
Factor percpu cache into common code and the iomap module uses it.

v1:
https://lore.kernel.org/all/20251121090052.384823-1-guzebing1612@gmail.com/

Suggested-by: Fengnan Chang <changfengnan@bytedance.com>
Signed-off-by: guzebing <guzebing1612@gmail.com>
---
 fs/iomap/direct-io.c | 135 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5d5d63efbd57..b152fd2c7042 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -56,6 +56,132 @@ struct iomap_dio {
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
+			cache_element = kmalloc(PCPU_CACHE_ELEMENT_SIZE(pcpu_cache_list),
+									GFP_KERNEL);
+			if (!cache_element) {
+				put_cpu();
+				return NULL;
+			}
+			put_cpu();
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
@@ -135,7 +261,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 			ret += dio->done_before;
 	}
 	trace_iomap_dio_complete(iocb, dio->error, ret);
-	kfree(dio);
+	pcpu_cache_list_free(dio, dio_pcpu_cache_list);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_dio_complete);
@@ -620,7 +746,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (!iomi.len)
 		return NULL;
 
-	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
+	dio = pcpu_cache_list_alloc(dio_pcpu_cache_list);
 	if (!dio)
 		return ERR_PTR(-ENOMEM);
 
@@ -804,7 +930,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	return dio;
 
 out_free_dio:
-	kfree(dio);
+	pcpu_cache_list_free(dio, dio_pcpu_cache_list);
 	if (ret)
 		return ERR_PTR(ret);
 	return NULL;
@@ -834,6 +960,9 @@ static int __init iomap_dio_init(void)
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


