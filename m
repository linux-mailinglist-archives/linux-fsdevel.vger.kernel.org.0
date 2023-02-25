Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1984C6A2635
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBYBQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBYBQ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:28 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BF2136F7
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:20 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q15so779933oiw.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WowGxjzXwI7KdW98ZlrNVWxoR0YY4GE4CFG7i8zaVM0=;
        b=45kbuxv4MUgJMH9mRYfHk0HFeQk59RVEl2GTLgVZ0V4vZg+YmGvBjDc60glmvhEQZ6
         NYpMOuSNz5fdkRqd9zJcdCsMH7WP6e3qfVR/0tj9s1h2CwTMNWYXJkJbn+Opjc3qpFK6
         T3g181vCXXRGkVuC00xkAdnxV1DDdhsvrkfQwFELT/jVY9PeejKkyZiE1QpUgF86j4/9
         AJeOJCYa8NzAtLNwJFaj8Ls3BtKrsvuiq910Rl9NaJan99ra4NOOMiL+YmXNMB1jpV4G
         7MRyNKgxCXPGNjvClj3FlhYxDjcmn66JS7UmPpQgYr97EPKKnhf+i91/nduu/gcDTrZg
         lDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WowGxjzXwI7KdW98ZlrNVWxoR0YY4GE4CFG7i8zaVM0=;
        b=PYC7ZGS9e2dLBZy7/QAoi6z+rqnN79lUl0nPcCRWh5brOjTkEbOqOxie3ShP3uML8U
         ojNjR7plBNHuU02mPJ1xA3YC24czlZ52YV/Sl27tg377a3k9Qa0JH0gJpPYHduy80tvw
         GH8xK0t5bbRFN8KCYONxFWmNGY56s3F4lxob8uICNygDiKlrlpZkgAg0o+g2dji6ddOn
         ex2SzqYegjZpvMu2sDEjNG75BTHz3o5lSHmudNIsvYdawC94YxFXVg4715Ac3TfuMzAy
         NELWuXN32+e7wzgiGjO/k0cUwt9vPzzSp7ACv7ZKFfAsB8rjrCjsEJZ19UFIL14mgbIG
         HaXw==
X-Gm-Message-State: AO0yUKXBA/ZLOB2WFjx5zH8HH9bSHb49q7KpW8EeTQhA2VnLum9Cmz6I
        wIQHgkbJte02sXQ4aeqyB5tv006EFVfApsT9
X-Google-Smtp-Source: AK7set/WiH6uS/jvaXa5QHg9yJLV+DDX/fYOZ+XNITCzr0iKrKl3milLBPC/k/I8tpocF4OPTQ/9nA==
X-Received: by 2002:a05:6808:b25:b0:364:9c99:f6cc with SMTP id t5-20020a0568080b2500b003649c99f6ccmr4355279oij.22.1677287779378;
        Fri, 24 Feb 2023 17:16:19 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:18 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 21/76] ssdfs: introduce PEB container
Date:   Fri, 24 Feb 2023 17:08:32 -0800
Message-Id: <20230225010927.813929-22-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230225010927.813929-1-slava@dubeyko.com>
References: <20230225010927.813929-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SSDFS implements a migration scheme. Migration scheme is
a fundamental technique of GC overhead management. The key
responsibility of the migration scheme is to guarantee
the presence of data in the same segment for any update
operations. Generally speaking, the migration scheme’s model
is implemented on the basis of association an exhausted
"Physical" Erase Block (PEB) with a clean one. The goal such
association of two PEBs is to implement the gradual migration
of data by means of the update operations in the initial
(exhausted) PEB. As a result, the old, exhausted PEB becomes
invalidated after complete data migration and it will be
possible to apply the erase operation to convert it in the
clean state. To implement the migration scheme concept, SSDFS
introduces PEB container that includes source and destination
erase blocks. PEB container object keeps the pointers on source
and destination PEB objects during migration logic execution.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/compr_lzo.c            |  256 ++++++
 fs/ssdfs/compr_zlib.c           |  359 +++++++++
 fs/ssdfs/compression.c          |  548 +++++++++++++
 fs/ssdfs/compression.h          |  104 +++
 fs/ssdfs/peb_container.h        |  291 +++++++
 fs/ssdfs/peb_migration_scheme.c | 1302 +++++++++++++++++++++++++++++++
 6 files changed, 2860 insertions(+)
 create mode 100644 fs/ssdfs/compr_lzo.c
 create mode 100644 fs/ssdfs/compr_zlib.c
 create mode 100644 fs/ssdfs/compression.c
 create mode 100644 fs/ssdfs/compression.h
 create mode 100644 fs/ssdfs/peb_container.h
 create mode 100644 fs/ssdfs/peb_migration_scheme.c

diff --git a/fs/ssdfs/compr_lzo.c b/fs/ssdfs/compr_lzo.c
new file mode 100644
index 000000000000..c3b71b1f9842
--- /dev/null
+++ b/fs/ssdfs/compr_lzo.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/compr_lzo.c - LZO compression support.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/init.h>
+#include <linux/pagemap.h>
+#include <linux/lzo.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "compression.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_lzo_page_leaks;
+atomic64_t ssdfs_lzo_memory_leaks;
+atomic64_t ssdfs_lzo_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_lzo_cache_leaks_increment(void *kaddr)
+ * void ssdfs_lzo_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_lzo_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_lzo_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_lzo_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_lzo_kfree(void *kaddr)
+ * struct page *ssdfs_lzo_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_lzo_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_lzo_free_page(struct page *page)
+ * void ssdfs_lzo_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(lzo)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(lzo)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_lzo_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_lzo_page_leaks, 0);
+	atomic64_set(&ssdfs_lzo_memory_leaks, 0);
+	atomic64_set(&ssdfs_lzo_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_lzo_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_lzo_page_leaks) != 0) {
+		SSDFS_ERR("LZO: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_lzo_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_lzo_memory_leaks) != 0) {
+		SSDFS_ERR("LZO: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_lzo_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_lzo_cache_leaks) != 0) {
+		SSDFS_ERR("LZO: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_lzo_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static int ssdfs_lzo_compress(struct list_head *ws_ptr,
+				unsigned char *data_in,
+				unsigned char *cdata_out,
+				size_t *srclen, size_t *destlen);
+
+static int ssdfs_lzo_decompress(struct list_head *ws_ptr,
+				 unsigned char *cdata_in,
+				 unsigned char *data_out,
+				 size_t srclen, size_t destlen);
+
+static struct list_head *ssdfs_lzo_alloc_workspace(void);
+static void ssdfs_lzo_free_workspace(struct list_head *ptr);
+
+static const struct ssdfs_compress_ops ssdfs_lzo_compress_ops = {
+	.alloc_workspace = ssdfs_lzo_alloc_workspace,
+	.free_workspace = ssdfs_lzo_free_workspace,
+	.compress = ssdfs_lzo_compress,
+	.decompress = ssdfs_lzo_decompress,
+};
+
+static struct ssdfs_compressor lzo_compr = {
+	.type = SSDFS_COMPR_LZO,
+	.compr_ops = &ssdfs_lzo_compress_ops,
+	.name = "lzo",
+};
+
+struct ssdfs_lzo_workspace {
+	void *mem;
+	void *cbuf;	/* where compressed data goes */
+	struct list_head list;
+};
+
+static void ssdfs_lzo_free_workspace(struct list_head *ptr)
+{
+	struct ssdfs_lzo_workspace *workspace;
+
+	workspace = list_entry(ptr, struct ssdfs_lzo_workspace, list);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("workspace %p\n", workspace);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	vfree(workspace->cbuf);
+	vfree(workspace->mem);
+	ssdfs_lzo_kfree(workspace);
+}
+
+static struct list_head *ssdfs_lzo_alloc_workspace(void)
+{
+	struct ssdfs_lzo_workspace *workspace;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("try to allocate workspace\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	workspace = ssdfs_lzo_kzalloc(sizeof(*workspace), GFP_KERNEL);
+	if (unlikely(!workspace))
+		goto failed_alloc_workspaces;
+
+	workspace->mem = vmalloc(LZO1X_MEM_COMPRESS);
+	workspace->cbuf = vmalloc(lzo1x_worst_compress(PAGE_SIZE));
+	if (!workspace->mem || !workspace->cbuf)
+		goto failed_alloc_workspaces;
+
+	INIT_LIST_HEAD(&workspace->list);
+
+	return &workspace->list;
+
+failed_alloc_workspaces:
+	SSDFS_ERR("unable to allocate memory for workspace\n");
+	ssdfs_lzo_free_workspace(&workspace->list);
+	return ERR_PTR(-ENOMEM);
+}
+
+int ssdfs_lzo_init(void)
+{
+	return ssdfs_register_compressor(&lzo_compr);
+}
+
+void ssdfs_lzo_exit(void)
+{
+	ssdfs_unregister_compressor(&lzo_compr);
+}
+
+static int ssdfs_lzo_compress(struct list_head *ws,
+				unsigned char *data_in,
+				unsigned char *cdata_out,
+				size_t *srclen, size_t *destlen)
+{
+	struct ssdfs_lzo_workspace *workspace;
+	size_t compress_size;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ws_ptr %p, data_in %p, cdata_out %p, "
+		  "srclen ptr %p, destlen ptr %p\n",
+		  ws, data_in, cdata_out, srclen, destlen);
+
+	BUG_ON(!ws || !data_in || !cdata_out || !srclen || !destlen);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	workspace = list_entry(ws, struct ssdfs_lzo_workspace, list);
+
+	err = lzo1x_1_compress(data_in, *srclen, workspace->cbuf,
+				&compress_size, workspace->mem);
+	if (err != LZO_E_OK) {
+		SSDFS_ERR("LZO compression failed: internal err %d, "
+			  "srclen %zu, destlen %zu\n",
+			  err, *srclen, *destlen);
+		err = -EINVAL;
+		goto failed_compress;
+	}
+
+	if (compress_size > *destlen) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to compress: compress_size %zu, "
+			  "destlen %zu\n",
+			  compress_size, *destlen);
+#endif /* CONFIG_SSDFS_DEBUG */
+		err = -E2BIG;
+		goto failed_compress;
+	}
+
+	ssdfs_memcpy(cdata_out, 0, *destlen,
+		     workspace->cbuf, 0, lzo1x_worst_compress(PAGE_SIZE),
+		     compress_size);
+	*destlen = compress_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("compress has succeded: srclen %zu, destlen %zu\n",
+		    *srclen, *destlen);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+
+failed_compress:
+	return err;
+}
+
+static int ssdfs_lzo_decompress(struct list_head *ws,
+				 unsigned char *cdata_in,
+				 unsigned char *data_out,
+				 size_t srclen, size_t destlen)
+{
+	size_t dl = destlen;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ws_ptr %p, cdata_in %p, data_out %p, "
+		  "srclen %zu, destlen %zu\n",
+		  ws, cdata_in, data_out, srclen, destlen);
+
+	BUG_ON(!ws || !cdata_in || !data_out);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = lzo1x_decompress_safe(cdata_in, srclen, data_out, &dl);
+
+	if (err != LZO_E_OK || dl != destlen) {
+		SSDFS_ERR("decompression failed: LZO compressor err %d, "
+			  "srclen %zu, destlen %zu\n",
+			  err, srclen, destlen);
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/fs/ssdfs/compr_zlib.c b/fs/ssdfs/compr_zlib.c
new file mode 100644
index 000000000000..a410907dc531
--- /dev/null
+++ b/fs/ssdfs/compr_zlib.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/compr_zlib.c - ZLIB compression support.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/zlib.h>
+#include <linux/zutil.h>
+#include <linux/vmalloc.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "compression.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_zlib_page_leaks;
+atomic64_t ssdfs_zlib_memory_leaks;
+atomic64_t ssdfs_zlib_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_zlib_cache_leaks_increment(void *kaddr)
+ * void ssdfs_zlib_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_zlib_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_zlib_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_zlib_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_zlib_kfree(void *kaddr)
+ * struct page *ssdfs_zlib_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_zlib_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_zlib_free_page(struct page *page)
+ * void ssdfs_zlib_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(zlib)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(zlib)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_zlib_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_zlib_page_leaks, 0);
+	atomic64_set(&ssdfs_zlib_memory_leaks, 0);
+	atomic64_set(&ssdfs_zlib_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_zlib_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_zlib_page_leaks) != 0) {
+		SSDFS_ERR("ZLIB: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_zlib_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_zlib_memory_leaks) != 0) {
+		SSDFS_ERR("ZLIB: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_zlib_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_zlib_cache_leaks) != 0) {
+		SSDFS_ERR("ZLIB: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_zlib_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+#define COMPR_LEVEL CONFIG_SSDFS_ZLIB_COMR_LEVEL
+
+static int ssdfs_zlib_compress(struct list_head *ws_ptr,
+				unsigned char *data_in,
+				unsigned char *cdata_out,
+				size_t *srclen, size_t *destlen);
+
+static int ssdfs_zlib_decompress(struct list_head *ws_ptr,
+				 unsigned char *cdata_in,
+				 unsigned char *data_out,
+				 size_t srclen, size_t destlen);
+
+static struct list_head *ssdfs_zlib_alloc_workspace(void);
+static void ssdfs_zlib_free_workspace(struct list_head *ptr);
+
+static const struct ssdfs_compress_ops ssdfs_zlib_compress_ops = {
+	.alloc_workspace = ssdfs_zlib_alloc_workspace,
+	.free_workspace = ssdfs_zlib_free_workspace,
+	.compress = ssdfs_zlib_compress,
+	.decompress = ssdfs_zlib_decompress,
+};
+
+static struct ssdfs_compressor zlib_compr = {
+	.type = SSDFS_COMPR_ZLIB,
+	.compr_ops = &ssdfs_zlib_compress_ops,
+	.name = "zlib",
+};
+
+struct ssdfs_zlib_workspace {
+	z_stream inflate_stream;
+	z_stream deflate_stream;
+	struct list_head list;
+};
+
+static void ssdfs_zlib_free_workspace(struct list_head *ptr)
+{
+	struct ssdfs_zlib_workspace *workspace;
+
+	workspace = list_entry(ptr, struct ssdfs_zlib_workspace, list);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("workspace %p\n", workspace);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	vfree(workspace->deflate_stream.workspace);
+	vfree(workspace->inflate_stream.workspace);
+	ssdfs_zlib_kfree(workspace);
+}
+
+static struct list_head *ssdfs_zlib_alloc_workspace(void)
+{
+	struct ssdfs_zlib_workspace *workspace;
+	int deflate_size, inflate_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("try to allocate workspace\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	workspace = ssdfs_zlib_kzalloc(sizeof(*workspace), GFP_KERNEL);
+	if (unlikely(!workspace)) {
+		SSDFS_ERR("unable to allocate memory for workspace\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	deflate_size = zlib_deflate_workspacesize(MAX_WBITS, MAX_MEM_LEVEL);
+	workspace->deflate_stream.workspace = vmalloc(deflate_size);
+	if (unlikely(!workspace->deflate_stream.workspace)) {
+		SSDFS_ERR("unable to allocate memory for deflate stream\n");
+		goto failed_alloc_workspaces;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("deflate stream size %d\n", deflate_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	inflate_size = zlib_inflate_workspacesize();
+	workspace->inflate_stream.workspace = vmalloc(inflate_size);
+	if (unlikely(!workspace->inflate_stream.workspace)) {
+		SSDFS_ERR("unable to allocate memory for inflate stream\n");
+		goto failed_alloc_workspaces;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("inflate stream size %d\n", inflate_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	INIT_LIST_HEAD(&workspace->list);
+
+	return &workspace->list;
+
+failed_alloc_workspaces:
+	ssdfs_zlib_free_workspace(&workspace->list);
+	return ERR_PTR(-ENOMEM);
+}
+
+int ssdfs_zlib_init(void)
+{
+	return ssdfs_register_compressor(&zlib_compr);
+}
+
+void ssdfs_zlib_exit(void)
+{
+	ssdfs_unregister_compressor(&zlib_compr);
+}
+
+static int ssdfs_zlib_compress(struct list_head *ws,
+				unsigned char *data_in,
+				unsigned char *cdata_out,
+				size_t *srclen, size_t *destlen)
+{
+	struct ssdfs_zlib_workspace *workspace;
+	z_stream *stream;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ws || !data_in || !cdata_out || !srclen || !destlen);
+
+	SSDFS_DBG("ws_ptr %p, data_in %p, cdata_out %p, "
+		  "srclen %zu, destlen %zu\n",
+		  ws, data_in, cdata_out, *srclen, *destlen);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	workspace = list_entry(ws, struct ssdfs_zlib_workspace, list);
+	stream = &workspace->deflate_stream;
+
+	if (Z_OK != zlib_deflateInit(stream, COMPR_LEVEL)) {
+		SSDFS_ERR("zlib_deflateInit() failed\n");
+		err = -EINVAL;
+		goto failed_compress;
+	}
+
+	stream->next_in = data_in;
+	stream->avail_in = *srclen;
+	stream->total_in = 0;
+
+	stream->next_out = cdata_out;
+	stream->avail_out = *destlen;
+	stream->total_out = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("calling deflate with: "
+		  "stream->avail_in %lu, stream->total_in %lu, "
+		  "stream->avail_out %lu, stream->total_out %lu\n",
+		  (unsigned long)stream->avail_in,
+		  (unsigned long)stream->total_in,
+		  (unsigned long)stream->avail_out,
+		  (unsigned long)stream->total_out);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = zlib_deflate(stream, Z_FINISH);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("deflate returned with: "
+		  "stream->avail_in %lu, stream->total_in %lu, "
+		  "stream->avail_out %lu, stream->total_out %lu\n",
+		  (unsigned long)stream->avail_in,
+		  (unsigned long)stream->total_in,
+		  (unsigned long)stream->avail_out,
+		  (unsigned long)stream->total_out);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (err != Z_STREAM_END) {
+		if (err == Z_OK) {
+			err = -E2BIG;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to compress: "
+				  "total_in %zu, total_out %zu\n",
+				  stream->total_in, stream->total_out);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else {
+			SSDFS_ERR("ZLIB compression failed: "
+				  "internal err %d\n",
+				  err);
+		}
+		goto failed_compress;
+	}
+
+	err = zlib_deflateEnd(stream);
+	if (err != Z_OK) {
+		SSDFS_ERR("ZLIB compression failed with internal err %d\n",
+			  err);
+		goto failed_compress;
+	}
+
+	if (stream->total_out >= stream->total_in) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to compress: total_in %zu, total_out %zu\n",
+			  stream->total_in, stream->total_out);
+#endif /* CONFIG_SSDFS_DEBUG */
+		err = -E2BIG;
+		goto failed_compress;
+	}
+
+	*destlen = stream->total_out;
+	*srclen = stream->total_in;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("compress has succeded: srclen %zu, destlen %zu\n",
+		    *srclen, *destlen);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+failed_compress:
+	return err;
+}
+
+static int ssdfs_zlib_decompress(struct list_head *ws,
+				 unsigned char *cdata_in,
+				 unsigned char *data_out,
+				 size_t srclen, size_t destlen)
+{
+	struct ssdfs_zlib_workspace *workspace;
+	int wbits = MAX_WBITS;
+	int ret = Z_OK;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ws || !cdata_in || !data_out);
+
+	SSDFS_DBG("ws_ptr %p, cdata_in %p, data_out %p, "
+		  "srclen %zu, destlen %zu\n",
+		  ws, cdata_in, data_out, srclen, destlen);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	workspace = list_entry(ws, struct ssdfs_zlib_workspace, list);
+
+	workspace->inflate_stream.next_in = cdata_in;
+	workspace->inflate_stream.avail_in = srclen;
+	workspace->inflate_stream.total_in = 0;
+
+	workspace->inflate_stream.next_out = data_out;
+	workspace->inflate_stream.avail_out = destlen;
+	workspace->inflate_stream.total_out = 0;
+
+	/*
+	 * If it's deflate, and it's got no preset dictionary, then
+	 * we can tell zlib to skip the adler32 check.
+	 */
+	if (srclen > 2 && !(cdata_in[1] & PRESET_DICT) &&
+	    ((cdata_in[0] & 0x0f) == Z_DEFLATED) &&
+	    !(((cdata_in[0] << 8) + cdata_in[1]) % 31)) {
+
+		wbits = -((cdata_in[0] >> 4) + 8);
+		workspace->inflate_stream.next_in += 2;
+		workspace->inflate_stream.avail_in -= 2;
+	}
+
+	if (Z_OK != zlib_inflateInit2(&workspace->inflate_stream, wbits)) {
+		SSDFS_ERR("zlib_inflateInit2() failed\n");
+		return -EINVAL;
+	}
+
+	do {
+		ret = zlib_inflate(&workspace->inflate_stream, Z_FINISH);
+	} while (ret == Z_OK);
+
+	zlib_inflateEnd(&workspace->inflate_stream);
+
+	if (ret != Z_STREAM_END) {
+		SSDFS_ERR("inflate returned %d\n", ret);
+		return -EFAULT;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("decompression has succeded: "
+		  "total_in %zu, total_out %zu\n",
+		  workspace->inflate_stream.total_in,
+		  workspace->inflate_stream.total_out);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
diff --git a/fs/ssdfs/compression.c b/fs/ssdfs/compression.c
new file mode 100644
index 000000000000..78b67d342180
--- /dev/null
+++ b/fs/ssdfs/compression.c
@@ -0,0 +1,548 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/compression.c - compression logic implementation.
+ *
+ * Copyright (c) 2019-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+#include <linux/rwsem.h>
+#include <linux/zlib.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "compression.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_compr_page_leaks;
+atomic64_t ssdfs_compr_memory_leaks;
+atomic64_t ssdfs_compr_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_compr_cache_leaks_increment(void *kaddr)
+ * void ssdfs_compr_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_compr_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_compr_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_compr_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_compr_kfree(void *kaddr)
+ * struct page *ssdfs_compr_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_compr_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_compr_free_page(struct page *page)
+ * void ssdfs_compr_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(compr)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(compr)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_compr_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_compr_page_leaks, 0);
+	atomic64_set(&ssdfs_compr_memory_leaks, 0);
+	atomic64_set(&ssdfs_compr_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_compr_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_compr_page_leaks) != 0) {
+		SSDFS_ERR("COMPRESSION: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_compr_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_compr_memory_leaks) != 0) {
+		SSDFS_ERR("COMPRESSION: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_compr_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_compr_cache_leaks) != 0) {
+		SSDFS_ERR("COMPRESSION: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_compr_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+struct ssdfs_compressor *ssdfs_compressors[SSDFS_COMPR_TYPES_CNT];
+
+static struct list_head compr_idle_workspace[SSDFS_COMPR_TYPES_CNT];
+static spinlock_t compr_workspace_lock[SSDFS_COMPR_TYPES_CNT];
+static int compr_num_workspace[SSDFS_COMPR_TYPES_CNT];
+static atomic_t compr_alloc_workspace[SSDFS_COMPR_TYPES_CNT];
+static wait_queue_head_t compr_workspace_wait[SSDFS_COMPR_TYPES_CNT];
+
+static inline bool unable_compress(int type)
+{
+	if (!ssdfs_compressors[type])
+		return true;
+	else if (!ssdfs_compressors[type]->compr_ops)
+		return true;
+	else if (!ssdfs_compressors[type]->compr_ops->compress)
+		return true;
+	return false;
+}
+
+static inline bool unable_decompress(int type)
+{
+	if (!ssdfs_compressors[type])
+		return true;
+	else if (!ssdfs_compressors[type]->compr_ops)
+		return true;
+	else if (!ssdfs_compressors[type]->compr_ops->decompress)
+		return true;
+	return false;
+}
+
+static int ssdfs_none_compress(struct list_head *ws_ptr,
+				unsigned char *data_in,
+				unsigned char *cdata_out,
+				size_t *srclen, size_t *destlen)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("data_in %p, cdata_out %p, srclen %p, destlen %p\n",
+		  data_in, cdata_out, srclen, destlen);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (*srclen > *destlen) {
+		SSDFS_ERR("src_len %zu > dest_len %zu\n",
+			  *srclen, *destlen);
+		return -E2BIG;
+	}
+
+	err = ssdfs_memcpy(cdata_out, 0, PAGE_SIZE,
+			   data_in, 0, PAGE_SIZE,
+			   *srclen);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		return err;
+	}
+
+	*destlen = *srclen;
+	return 0;
+}
+
+static int ssdfs_none_decompress(struct list_head *ws_ptr,
+				 unsigned char *cdata_in,
+				 unsigned char *data_out,
+				 size_t srclen, size_t destlen)
+{
+	/* TODO: implement ssdfs_none_decompress() */
+	SSDFS_WARN("TODO: implement %s\n", __func__);
+	return -EOPNOTSUPP;
+}
+
+static const struct ssdfs_compress_ops ssdfs_compr_none_ops = {
+	.compress = ssdfs_none_compress,
+	.decompress = ssdfs_none_decompress,
+};
+
+static struct ssdfs_compressor ssdfs_none_compr = {
+	.type = SSDFS_COMPR_NONE,
+	.compr_ops = &ssdfs_compr_none_ops,
+	.name = "none",
+};
+
+static inline bool unknown_compression(int type)
+{
+	return type < SSDFS_COMPR_NONE || type >= SSDFS_COMPR_TYPES_CNT;
+}
+
+int ssdfs_register_compressor(struct ssdfs_compressor *compr)
+{
+	SSDFS_INFO("register %s compressor\n", compr->name);
+	ssdfs_compressors[compr->type] = compr;
+	return 0;
+}
+
+int ssdfs_unregister_compressor(struct ssdfs_compressor *compr)
+{
+	SSDFS_INFO("unregister %s compressor\n", compr->name);
+	ssdfs_compressors[compr->type] = NULL;
+	return 0;
+}
+
+int ssdfs_compressors_init(void)
+{
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("init compressors subsystem\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < SSDFS_COMPR_TYPES_CNT; i++) {
+		INIT_LIST_HEAD(&compr_idle_workspace[i]);
+		spin_lock_init(&compr_workspace_lock[i]);
+		atomic_set(&compr_alloc_workspace[i], 0);
+		init_waitqueue_head(&compr_workspace_wait[i]);
+	}
+
+	err = ssdfs_zlib_init();
+	if (err)
+		goto out;
+
+	err = ssdfs_lzo_init();
+	if (err)
+		goto zlib_exit;
+
+	err = ssdfs_register_compressor(&ssdfs_none_compr);
+	if (err)
+		goto lzo_exit;
+
+	return 0;
+
+lzo_exit:
+	ssdfs_lzo_exit();
+
+zlib_exit:
+	ssdfs_zlib_exit();
+
+out:
+	return err;
+}
+
+void ssdfs_free_workspaces(void)
+{
+	struct list_head *workspace;
+	const struct ssdfs_compress_ops *ops;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("destruct auxiliary workspaces\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < SSDFS_COMPR_TYPES_CNT; i++) {
+		if (!ssdfs_compressors[i])
+			continue;
+
+		ops = ssdfs_compressors[i]->compr_ops;
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!ops);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		while (!list_empty(&compr_idle_workspace[i])) {
+			workspace = compr_idle_workspace[i].next;
+			list_del(workspace);
+			if (ops->free_workspace)
+				ops->free_workspace(workspace);
+			atomic_dec(&compr_alloc_workspace[i]);
+		}
+	}
+}
+
+void ssdfs_compressors_exit(void)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("deinitialize compressors subsystem\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_free_workspaces();
+	ssdfs_unregister_compressor(&ssdfs_none_compr);
+	ssdfs_zlib_exit();
+	ssdfs_lzo_exit();
+}
+
+/*
+ * Find an available workspace or allocate a new one.
+ * ERR_PTR is returned in the case of error.
+ */
+static struct list_head *ssdfs_find_workspace(int type)
+{
+	struct list_head *workspace;
+	int cpus;
+	struct list_head *idle_workspace;
+	spinlock_t *workspace_lock;
+	atomic_t *alloc_workspace;
+	wait_queue_head_t *workspace_wait;
+	int *num_workspace;
+	const struct ssdfs_compress_ops *ops;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("type %d\n", type);
+
+	if (unknown_compression(type)) {
+		SSDFS_ERR("unknown compression type %d\n", type);
+		BUG();
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ops = ssdfs_compressors[type]->compr_ops;
+
+	if (!ops->alloc_workspace)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	cpus = num_online_cpus();
+	idle_workspace = &compr_idle_workspace[type];
+	workspace_lock = &compr_workspace_lock[type];
+	alloc_workspace = &compr_alloc_workspace[type];
+	workspace_wait = &compr_workspace_wait[type];
+	num_workspace = &compr_num_workspace[type];
+
+again:
+	spin_lock(workspace_lock);
+
+	if (!list_empty(idle_workspace)) {
+		workspace = idle_workspace->next;
+		list_del(workspace);
+		(*num_workspace)--;
+		spin_unlock(workspace_lock);
+		return workspace;
+	}
+
+	if (atomic_read(alloc_workspace) > cpus) {
+		DEFINE_WAIT(wait);
+
+		spin_unlock(workspace_lock);
+		prepare_to_wait(workspace_wait, &wait, TASK_UNINTERRUPTIBLE);
+		if (atomic_read(alloc_workspace) > cpus && !*num_workspace)
+			schedule();
+		finish_wait(workspace_wait, &wait);
+		goto again;
+	}
+	atomic_inc(alloc_workspace);
+	spin_unlock(workspace_lock);
+
+	workspace = ops->alloc_workspace();
+	if (IS_ERR(workspace)) {
+		atomic_dec(alloc_workspace);
+		wake_up(workspace_wait);
+	}
+
+	return workspace;
+}
+
+static void ssdfs_free_workspace(int type, struct list_head *workspace)
+{
+	struct list_head *idle_workspace;
+	spinlock_t *workspace_lock;
+	atomic_t *alloc_workspace;
+	wait_queue_head_t *workspace_wait;
+	int *num_workspace;
+	const struct ssdfs_compress_ops *ops;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("type %d, workspace %p\n", type, workspace);
+
+	if (unknown_compression(type)) {
+		SSDFS_ERR("unknown compression type %d\n", type);
+		BUG();
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ops = ssdfs_compressors[type]->compr_ops;
+
+	if (!ops->free_workspace)
+		return;
+
+	idle_workspace = &compr_idle_workspace[type];
+	workspace_lock = &compr_workspace_lock[type];
+	alloc_workspace = &compr_alloc_workspace[type];
+	workspace_wait = &compr_workspace_wait[type];
+	num_workspace = &compr_num_workspace[type];
+
+	spin_lock(workspace_lock);
+	if (*num_workspace < num_online_cpus()) {
+		list_add_tail(workspace, idle_workspace);
+		(*num_workspace)++;
+		spin_unlock(workspace_lock);
+		goto wake;
+	}
+	spin_unlock(workspace_lock);
+
+	ops->free_workspace(workspace);
+	atomic_dec(alloc_workspace);
+wake:
+	smp_mb();
+	if (waitqueue_active(workspace_wait))
+		wake_up(workspace_wait);
+}
+
+#define SSDFS_DICT_SIZE			256
+#define SSDFS_MIN_MAX_DIFF_THRESHOLD	150
+
+bool ssdfs_can_compress_data(struct page *page,
+			     unsigned data_size)
+{
+	unsigned *counts;
+	unsigned found_symbols = 0;
+	unsigned min, max;
+	u8 *kaddr;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(data_size == 0 || data_size > PAGE_SIZE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_ZLIB
+	if (CONFIG_SSDFS_ZLIB_COMR_LEVEL == Z_NO_COMPRESSION)
+		return false;
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	counts = ssdfs_compr_kzalloc(sizeof(unsigned) * SSDFS_DICT_SIZE,
+				     GFP_KERNEL);
+	if (!counts) {
+		SSDFS_WARN("fail to alloc array\n");
+		return true;
+	}
+
+	min = SSDFS_DICT_SIZE;
+	max = 0;
+
+	kaddr = (u8 *)kmap_local_page(page);
+	for (i = 0; i < data_size; i++) {
+		u8 *value = kaddr + i;
+		counts[*value]++;
+		if (counts[*value] == 1)
+			found_symbols++;
+		if (counts[*value] < min)
+			min = counts[*value];
+		if (counts[*value] > max)
+			max = counts[*value];
+	}
+	kunmap_local(kaddr);
+
+	ssdfs_compr_kfree(counts);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("data_size %u, found_symbols %u, min %u, max %u\n",
+		  data_size, found_symbols, min, max);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (max - min) >= SSDFS_MIN_MAX_DIFF_THRESHOLD;
+}
+
+int ssdfs_compress(int type, unsigned char *data_in, unsigned char *cdata_out,
+		    size_t *srclen, size_t *destlen)
+{
+	const struct ssdfs_compress_ops *ops;
+	struct list_head *workspace = NULL;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("type %d, data_in %p, cdata_out %p, "
+		  "srclen %zu, destlen %zu\n",
+		  type, data_in, cdata_out, *srclen, *destlen);
+
+	if (unknown_compression(type)) {
+		SSDFS_ERR("unknown compression type %d\n", type);
+		BUG();
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unable_compress(type)) {
+		SSDFS_ERR("unsupported compression type %d\n", type);
+		err = -EOPNOTSUPP;
+		goto failed_compress;
+	}
+
+	workspace = ssdfs_find_workspace(type);
+	if (PTR_ERR(workspace) == -EOPNOTSUPP &&
+	    ssdfs_compressors[type]->type == SSDFS_COMPR_NONE) {
+		/*
+		 * None compressor case.
+		 * Simply call compress() operation.
+		 */
+	} else if (IS_ERR(workspace)) {
+		err = -ENOMEM;
+		goto failed_compress;
+	}
+
+	ops = ssdfs_compressors[type]->compr_ops;
+	err = ops->compress(workspace, data_in, cdata_out, srclen, destlen);
+
+	ssdfs_free_workspace(type, workspace);
+	if (err == -E2BIG) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("%s compressor is unable to compress data %p "
+			  "of size %zu\n",
+			  ssdfs_compressors[type]->name,
+			  data_in, *srclen);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto failed_compress;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("%s compressor fails to compress data %p "
+			  "of size %zu because of err %d\n",
+			  ssdfs_compressors[type]->name,
+			  data_in, *srclen, err);
+		goto failed_compress;
+	}
+
+	return 0;
+
+failed_compress:
+	return err;
+}
+
+int ssdfs_decompress(int type, unsigned char *cdata_in, unsigned char *data_out,
+			size_t srclen, size_t destlen)
+{
+	const struct ssdfs_compress_ops *ops;
+	struct list_head *workspace;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("type %d, cdata_in %p, data_out %p, "
+		  "srclen %zu, destlen %zu\n",
+		  type, cdata_in, data_out, srclen, destlen);
+
+	if (unknown_compression(type)) {
+		SSDFS_ERR("unknown compression type %d\n", type);
+		BUG();
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unable_decompress(type)) {
+		SSDFS_ERR("unsupported compression type %d\n", type);
+		err = -EOPNOTSUPP;
+		goto failed_decompress;
+	}
+
+	workspace = ssdfs_find_workspace(type);
+	if (PTR_ERR(workspace) == -EOPNOTSUPP &&
+	    ssdfs_compressors[type]->type == SSDFS_COMPR_NONE) {
+		/*
+		 * None compressor case.
+		 * Simply call decompress() operation.
+		 */
+	} else if (IS_ERR(workspace)) {
+		err = -ENOMEM;
+		goto failed_decompress;
+	}
+
+	ops = ssdfs_compressors[type]->compr_ops;
+	err = ops->decompress(workspace, cdata_in, data_out, srclen, destlen);
+
+	ssdfs_free_workspace(type, workspace);
+	if (unlikely(err)) {
+		SSDFS_ERR("%s compresor fails to decompress data %p "
+			  "of size %zu because of err %d\n",
+			  ssdfs_compressors[type]->name,
+			  cdata_in, srclen, err);
+		goto failed_decompress;
+	}
+
+	return 0;
+
+failed_decompress:
+	return err;
+}
diff --git a/fs/ssdfs/compression.h b/fs/ssdfs/compression.h
new file mode 100644
index 000000000000..77243b09babd
--- /dev/null
+++ b/fs/ssdfs/compression.h
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/compression.h - compression/decompression support declarations.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#ifndef _SSDFS_COMPRESSION_H
+#define _SSDFS_COMPRESSION_H
+
+/*
+ * SSDFS compression algorithms.
+ *
+ * SSDFS_COMPR_NONE: no compression
+ * SSDFS_COMPR_ZLIB: ZLIB compression
+ * SSDFS_COMPR_LZO: LZO compression
+ * SSDFS_COMPR_TYPES_CNT: count of supported compression types
+ */
+enum {
+	SSDFS_COMPR_NONE,
+	SSDFS_COMPR_ZLIB,
+	SSDFS_COMPR_LZO,
+	SSDFS_COMPR_TYPES_CNT,
+};
+
+/*
+ * struct ssdfs_compress_ops - compressor operations
+ * @alloc_workspace - prepare workspace for (de)compression
+ * @free_workspace - free workspace after (de)compression
+ * @compress - compression method
+ * @decompress - decompression method
+ */
+struct ssdfs_compress_ops {
+	struct list_head * (*alloc_workspace)(void);
+	void (*free_workspace)(struct list_head *workspace);
+	int (*compress)(struct list_head *ws_ptr,
+			unsigned char *data_in,
+			unsigned char *cdata_out,
+			size_t *srclen,
+			size_t *destlen);
+	int (*decompress)(struct list_head *ws_ptr,
+			unsigned char *cdata_in,
+			unsigned char *data_out,
+			size_t srclen,
+			size_t destlen);
+};
+
+/*
+ * struct ssdfs_compressor - compressor type.
+ * @type: compressor type
+ * @name: compressor name
+ * @compr_ops: compressor operations
+ */
+struct ssdfs_compressor {
+	int type;
+	const char *name;
+	const struct ssdfs_compress_ops *compr_ops;
+};
+
+/* Available SSDFS compressors */
+extern struct ssdfs_compressor *ssdfs_compressors[SSDFS_COMPR_TYPES_CNT];
+
+/* compression.c */
+int ssdfs_register_compressor(struct ssdfs_compressor *);
+int ssdfs_unregister_compressor(struct ssdfs_compressor *);
+bool ssdfs_can_compress_data(struct page *page, unsigned data_size);
+int ssdfs_compress(int type, unsigned char *data_in, unsigned char *cdata_out,
+		    size_t *srclen, size_t *destlen);
+int ssdfs_decompress(int type, unsigned char *cdata_in, unsigned char *data_out,
+			size_t srclen, size_t destlen);
+
+#ifdef CONFIG_SSDFS_ZLIB
+/* compr_zlib.c */
+int ssdfs_zlib_init(void);
+void ssdfs_zlib_exit(void);
+#else
+static inline int ssdfs_zlib_init(void) { return 0; }
+static inline void ssdfs_zlib_exit(void) { return; }
+#endif /* CONFIG_SSDFS_ZLIB */
+
+#ifdef CONFIG_SSDFS_LZO
+/* compr_lzo.c */
+int ssdfs_lzo_init(void);
+void ssdfs_lzo_exit(void);
+#else
+static inline int ssdfs_lzo_init(void) { return 0; }
+static inline void ssdfs_lzo_exit(void) { return; }
+#endif /* CONFIG_SSDFS_LZO */
+
+#endif /* _SSDFS_COMPRESSION_H */
diff --git a/fs/ssdfs/peb_container.h b/fs/ssdfs/peb_container.h
new file mode 100644
index 000000000000..4a3e18ada1f5
--- /dev/null
+++ b/fs/ssdfs/peb_container.h
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_container.h - PEB container declarations.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#ifndef _SSDFS_PEB_CONTAINER_H
+#define _SSDFS_PEB_CONTAINER_H
+
+#include "block_bitmap.h"
+#include "peb.h"
+
+/* PEB container's array indexes */
+enum {
+	SSDFS_SEG_PEB1,
+	SSDFS_SEG_PEB2,
+	SSDFS_SEG_PEB_ITEMS_MAX
+};
+
+/* PEB container possible states */
+enum {
+	SSDFS_PEB_CONTAINER_EMPTY,
+	SSDFS_PEB1_SRC_CONTAINER,
+	SSDFS_PEB1_DST_CONTAINER,
+	SSDFS_PEB1_SRC_PEB2_DST_CONTAINER,
+	SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER,
+	SSDFS_PEB2_SRC_CONTAINER,
+	SSDFS_PEB2_DST_CONTAINER,
+	SSDFS_PEB2_SRC_PEB1_DST_CONTAINER,
+	SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER,
+	SSDFS_PEB_CONTAINER_STATE_MAX
+};
+
+/*
+ * PEB migration state
+ */
+enum {
+	SSDFS_PEB_UNKNOWN_MIGRATION_STATE,
+	SSDFS_PEB_NOT_MIGRATING,
+	SSDFS_PEB_MIGRATION_PREPARATION,
+	SSDFS_PEB_RELATION_PREPARATION,
+	SSDFS_PEB_UNDER_MIGRATION,
+	SSDFS_PEB_FINISHING_MIGRATION,
+	SSDFS_PEB_MIGRATION_STATE_MAX
+};
+
+/*
+ * PEB migration phase
+ */
+enum {
+	SSDFS_PEB_MIGRATION_STATUS_UNKNOWN,
+	SSDFS_SRC_PEB_NOT_EXHAUSTED,
+	SSDFS_DST_PEB_RECEIVES_DATA,
+	SSDFS_SHARED_ZONE_RECEIVES_DATA,
+	SSDFS_PEB_MIGRATION_PHASE_MAX
+};
+
+/*
+ * struct ssdfs_peb_container - PEB container
+ * @peb_type: type of PEB
+ * @peb_index: index of PEB in the array
+ * @log_pages: count of pages in full log
+ * @threads: PEB container's threads array
+ * @read_rq: read requests queue
+ * @update_rq: update requests queue
+ * @crq_ptr_lock: lock of pointer on create requests queue
+ * @create_rq: pointer on shared new page requests queue
+ * @parent_si: pointer on parent segment object
+ * @migration_lock: migration lock
+ * @migration_state: PEB migration state
+ * @migration_phase: PEB migration phase
+ * @items_state: items array state
+ * @shared_free_dst_blks: count of blocks that destination is able to share
+ * @migration_wq: wait queue for migration operations
+ * @cache_protection: PEB cache protection window
+ * @lock: container's internals lock
+ * @src_peb: pointer on source PEB
+ * @dst_peb: pointer on destination PEB
+ * @dst_peb_refs: reference counter of destination PEB (sharing counter)
+ * @items: buffers for PEB objects
+ * @peb_kobj: /sys/fs/ssdfs/<device>/<segN>/<pebN> kernel object
+ * @peb_kobj_unregister: completion state for <pebN> kernel object
+ */
+struct ssdfs_peb_container {
+	/* Static data */
+	u8 peb_type;
+	u16 peb_index;
+	u32 log_pages;
+
+	/* PEB container's threads */
+	struct ssdfs_thread_info thread[SSDFS_PEB_THREAD_TYPE_MAX];
+
+	/* Read requests queue */
+	struct ssdfs_requests_queue read_rq;
+
+	/* Update requests queue */
+	struct ssdfs_requests_queue update_rq;
+
+	spinlock_t pending_lock;
+	u32 pending_updated_user_data_pages;
+
+	/* Shared new page requests queue */
+	spinlock_t crq_ptr_lock;
+	struct ssdfs_requests_queue *create_rq;
+
+	/* Parent segment */
+	struct ssdfs_segment_info *parent_si;
+
+	/* Migration info */
+	struct mutex migration_lock;
+	atomic_t migration_state;
+	atomic_t migration_phase;
+	atomic_t items_state;
+	atomic_t shared_free_dst_blks;
+	wait_queue_head_t migration_wq;
+
+	/* PEB cache protection window */
+	struct ssdfs_protection_window cache_protection;
+
+	/* PEB objects */
+	struct rw_semaphore lock;
+	struct ssdfs_peb_info *src_peb;
+	struct ssdfs_peb_info *dst_peb;
+	atomic_t dst_peb_refs;
+	struct ssdfs_peb_info items[SSDFS_SEG_PEB_ITEMS_MAX];
+
+	/* /sys/fs/ssdfs/<device>/<segN>/<pebN> */
+	struct kobject peb_kobj;
+	struct completion peb_kobj_unregister;
+};
+
+#define PEBI_PTR(pebi) \
+	((struct ssdfs_peb_info *)(pebi))
+#define PEBC_PTR(pebc) \
+	((struct ssdfs_peb_container *)(pebc))
+#define READ_RQ_PTR(pebc) \
+	(&PEBC_PTR(pebc)->read_rq)
+
+#define SSDFS_GC_FINISH_MIGRATION	(4)
+
+/*
+ * Inline functions
+ */
+static inline
+bool is_peb_container_empty(struct ssdfs_peb_container *pebc)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return atomic_read(&pebc->items_state) == SSDFS_PEB_CONTAINER_EMPTY;
+}
+
+/*
+ * is_create_requests_queue_empty() - check that create queue has requests
+ * @pebc: pointer on PEB container
+ */
+static inline
+bool is_create_requests_queue_empty(struct ssdfs_peb_container *pebc)
+{
+	bool is_create_rq_empty = true;
+
+	spin_lock(&pebc->crq_ptr_lock);
+	if (pebc->create_rq) {
+		is_create_rq_empty =
+			is_ssdfs_requests_queue_empty(pebc->create_rq);
+	}
+	spin_unlock(&pebc->crq_ptr_lock);
+
+	return is_create_rq_empty;
+}
+
+/*
+ * have_flush_requests() - check that create or update queue have requests
+ * @pebc: pointer on PEB container
+ */
+static inline
+bool have_flush_requests(struct ssdfs_peb_container *pebc)
+{
+	bool is_create_rq_empty = true;
+	bool is_update_rq_empty = true;
+
+	is_create_rq_empty = is_create_requests_queue_empty(pebc);
+	is_update_rq_empty = is_ssdfs_requests_queue_empty(&pebc->update_rq);
+
+	return !is_create_rq_empty || !is_update_rq_empty;
+}
+
+static inline
+bool is_ssdfs_peb_containing_user_data(struct ssdfs_peb_container *pebc)
+{
+	return pebc->peb_type == SSDFS_MAPTBL_DATA_PEB_TYPE;
+}
+
+/*
+ * PEB container's API
+ */
+int ssdfs_peb_container_create(struct ssdfs_fs_info *fsi,
+				u64 seg, u32 peb_index,
+				u8 peb_type,
+				u32 log_pages,
+				struct ssdfs_segment_info *si);
+void ssdfs_peb_container_destroy(struct ssdfs_peb_container *pebc);
+
+int ssdfs_peb_container_invalidate_block(struct ssdfs_peb_container *pebc,
+				    struct ssdfs_phys_offset_descriptor *desc);
+int ssdfs_peb_get_free_pages(struct ssdfs_peb_container *pebc);
+int ssdfs_peb_get_used_data_pages(struct ssdfs_peb_container *pebc);
+int ssdfs_peb_get_invalid_pages(struct ssdfs_peb_container *pebc);
+
+int ssdfs_peb_join_create_requests_queue(struct ssdfs_peb_container *pebc,
+					 struct ssdfs_requests_queue *create_rq);
+void ssdfs_peb_forget_create_requests_queue(struct ssdfs_peb_container *pebc);
+bool is_peb_joined_into_create_requests_queue(struct ssdfs_peb_container *pebc);
+
+struct ssdfs_peb_info *
+ssdfs_get_current_peb_locked(struct ssdfs_peb_container *pebc);
+void ssdfs_unlock_current_peb(struct ssdfs_peb_container *pebc);
+struct ssdfs_peb_info *
+ssdfs_get_peb_for_migration_id(struct ssdfs_peb_container *pebc,
+			       u8 migration_id);
+
+int ssdfs_peb_container_create_destination(struct ssdfs_peb_container *ptr);
+int ssdfs_peb_container_forget_source(struct ssdfs_peb_container *pebc);
+int ssdfs_peb_container_forget_relation(struct ssdfs_peb_container *pebc);
+int ssdfs_peb_container_change_state(struct ssdfs_peb_container *pebc);
+
+/*
+ * PEB container's private API
+ */
+int ssdfs_peb_gc_thread_func(void *data);
+int ssdfs_peb_read_thread_func(void *data);
+int ssdfs_peb_flush_thread_func(void *data);
+
+u16 ssdfs_peb_estimate_reserved_metapages(u32 page_size, u32 pages_per_peb,
+					  u16 log_pages, u32 pebs_per_seg,
+					  bool is_migrating);
+int ssdfs_peb_read_page(struct ssdfs_peb_container *pebc,
+			struct ssdfs_segment_request *req,
+			struct completion **end);
+int ssdfs_peb_readahead_pages(struct ssdfs_peb_container *pebc,
+			      struct ssdfs_segment_request *req,
+			      struct completion **end);
+void ssdfs_peb_mark_request_block_uptodate(struct ssdfs_peb_container *pebc,
+					   struct ssdfs_segment_request *req,
+					   int blk_index);
+int ssdfs_peb_copy_page(struct ssdfs_peb_container *pebc,
+			u32 logical_blk,
+			struct ssdfs_segment_request *req);
+int ssdfs_peb_copy_pages_range(struct ssdfs_peb_container *pebc,
+				struct ssdfs_block_bmap_range *range,
+				struct ssdfs_segment_request *req);
+int ssdfs_peb_copy_pre_alloc_page(struct ssdfs_peb_container *pebc,
+				  u32 logical_blk,
+				  struct ssdfs_segment_request *req);
+int __ssdfs_peb_get_block_state_desc(struct ssdfs_peb_info *pebi,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_metadata_descriptor *area_desc,
+				struct ssdfs_block_state_descriptor *desc,
+				u64 *cno, u64 *parent_snapshot);
+int ssdfs_blk_desc_buffer_init(struct ssdfs_peb_container *pebc,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_phys_offset_descriptor *desc_off,
+				struct ssdfs_offset_position *pos,
+				struct ssdfs_metadata_descriptor *array,
+				size_t array_size);
+int ssdfs_peb_read_block_state(struct ssdfs_peb_container *pebc,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_phys_offset_descriptor *desc_off,
+				struct ssdfs_offset_position *pos,
+				struct ssdfs_metadata_descriptor *array,
+				size_t array_size);
+bool ssdfs_peb_has_dirty_pages(struct ssdfs_peb_info *pebi);
+int ssdfs_collect_dirty_segments_now(struct ssdfs_fs_info *fsi);
+
+#endif /* _SSDFS_PEB_CONTAINER_H */
diff --git a/fs/ssdfs/peb_migration_scheme.c b/fs/ssdfs/peb_migration_scheme.c
new file mode 100644
index 000000000000..d036b04fc646
--- /dev/null
+++ b/fs/ssdfs/peb_migration_scheme.c
@@ -0,0 +1,1302 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_migration_scheme.c - Implementation of PEBs' migration scheme.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * Copyright (c) 2022-2023 Bytedance Ltd. and/or its affiliates.
+ *              https://www.bytedance.com/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ *                  Cong Wang
+ */
+
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "page_vector.h"
+#include "block_bitmap.h"
+#include "peb_block_bitmap.h"
+#include "segment_block_bitmap.h"
+#include "offset_translation_table.h"
+#include "page_array.h"
+#include "peb.h"
+#include "peb_container.h"
+#include "peb_mapping_table.h"
+#include "segment_bitmap.h"
+#include "segment.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_migration_page_leaks;
+atomic64_t ssdfs_migration_memory_leaks;
+atomic64_t ssdfs_migration_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_migration_cache_leaks_increment(void *kaddr)
+ * void ssdfs_migration_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_migration_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_migration_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_migration_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_migration_kfree(void *kaddr)
+ * struct page *ssdfs_migration_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_migration_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_migration_free_page(struct page *page)
+ * void ssdfs_migration_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(migration)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(migration)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_migration_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_migration_page_leaks, 0);
+	atomic64_set(&ssdfs_migration_memory_leaks, 0);
+	atomic64_set(&ssdfs_migration_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_migration_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_migration_page_leaks) != 0) {
+		SSDFS_ERR("MIGRATION SCHEME: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_migration_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_migration_memory_leaks) != 0) {
+		SSDFS_ERR("MIGRATION SCHEME: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_migration_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_migration_cache_leaks) != 0) {
+		SSDFS_ERR("MIGRATION SCHEME: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_migration_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/*
+ * ssdfs_peb_start_migration() - prepare and start PEB's migration
+ * @pebc: pointer on PEB container
+ */
+int ssdfs_peb_start_migration(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg_id %llu, peb_index %u, peb_type %#x, "
+		  "migration_state %#x, items_state %#x\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, pebc->peb_type,
+		  atomic_read(&pebc->migration_state),
+		  atomic_read(&pebc->items_state));
+#else
+	SSDFS_DBG("seg_id %llu, peb_index %u, peb_type %#x, "
+		  "migration_state %#x, items_state %#x\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, pebc->peb_type,
+		  atomic_read(&pebc->migration_state),
+		  atomic_read(&pebc->items_state));
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = pebc->parent_si->fsi;
+	si = pebc->parent_si;
+
+	mutex_lock(&pebc->migration_lock);
+
+check_migration_state:
+	switch (atomic_read(&pebc->migration_state)) {
+	case SSDFS_PEB_NOT_MIGRATING:
+		/* valid state */
+		break;
+
+	case SSDFS_PEB_UNDER_MIGRATION:
+		err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("PEB is under migration already: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto start_migration_done;
+
+	case SSDFS_PEB_MIGRATION_PREPARATION:
+	case SSDFS_PEB_RELATION_PREPARATION:
+	case SSDFS_PEB_FINISHING_MIGRATION: {
+			DEFINE_WAIT(wait);
+
+			mutex_unlock(&pebc->migration_lock);
+			prepare_to_wait(&pebc->migration_wq, &wait,
+					TASK_UNINTERRUPTIBLE);
+			schedule();
+			finish_wait(&pebc->migration_wq, &wait);
+			mutex_lock(&pebc->migration_lock);
+			goto check_migration_state;
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid migration_state %#x\n",
+			   atomic_read(&pebc->migration_state));
+		goto start_migration_done;
+	}
+
+	err = ssdfs_peb_container_create_destination(pebc);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to start PEB migration: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index,
+			  err);
+		goto start_migration_done;
+	}
+
+	for (i = 0; i < SSDFS_GC_THREAD_TYPE_MAX; i++) {
+		atomic_inc(&fsi->gc_should_act[i]);
+		wake_up_all(&fsi->gc_wait_queue[i]);
+	}
+
+start_migration_done:
+	mutex_unlock(&pebc->migration_lock);
+
+	wake_up_all(&pebc->migration_wq);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
+/*
+ * is_peb_under_migration() - check that PEB is under migration
+ * @pebc: pointer on PEB container
+ */
+bool is_peb_under_migration(struct ssdfs_peb_container *pebc)
+{
+	int state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_read(&pebc->migration_state);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("migration state %#x\n", state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (state) {
+	case SSDFS_PEB_NOT_MIGRATING:
+		return false;
+
+	case SSDFS_PEB_MIGRATION_PREPARATION:
+	case SSDFS_PEB_RELATION_PREPARATION:
+	case SSDFS_PEB_UNDER_MIGRATION:
+	case SSDFS_PEB_FINISHING_MIGRATION:
+		return true;
+
+	default:
+		SSDFS_WARN("invalid migration_state %#x\n",
+			   atomic_read(&pebc->migration_state));
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return false;
+}
+
+/*
+ * is_pebs_relation_alive() - check PEBs' relation validity
+ * @pebc: pointer on PEB container
+ */
+bool is_pebs_relation_alive(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_container *dst_pebc;
+	int shared_free_dst_blks = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si);
+	BUG_ON(!mutex_is_locked(&pebc->migration_lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebc->parent_si;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_state %#x\n",
+		  atomic_read(&pebc->items_state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+try_define_items_state:
+	switch (atomic_read(&pebc->items_state)) {
+	case SSDFS_PEB1_SRC_CONTAINER:
+	case SSDFS_PEB2_SRC_CONTAINER:
+		return false;
+
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB2_DST_CONTAINER:
+		if (atomic_read(&pebc->shared_free_dst_blks) <= 0)
+			return false;
+		else
+			return true;
+
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+		return true;
+
+	case SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER:
+		switch (atomic_read(&pebc->migration_state)) {
+		case SSDFS_PEB_UNDER_MIGRATION:
+			/* valid state */
+			break;
+
+		case SSDFS_PEB_RELATION_PREPARATION: {
+				DEFINE_WAIT(wait);
+
+				mutex_unlock(&pebc->migration_lock);
+				prepare_to_wait(&pebc->migration_wq, &wait,
+						TASK_UNINTERRUPTIBLE);
+				schedule();
+				finish_wait(&pebc->migration_wq, &wait);
+				mutex_lock(&pebc->migration_lock);
+				goto try_define_items_state;
+			}
+			break;
+
+		default:
+			SSDFS_WARN("invalid migration_state %#x\n",
+				   atomic_read(&pebc->migration_state));
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+			return false;
+		}
+
+		down_read(&pebc->lock);
+
+		if (!pebc->dst_peb) {
+			err = -ERANGE;
+			SSDFS_WARN("dst_peb is NULL\n");
+			goto finish_relation_check;
+		}
+
+		dst_pebc = pebc->dst_peb->pebc;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!dst_pebc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		shared_free_dst_blks =
+			atomic_read(&dst_pebc->shared_free_dst_blks);
+
+finish_relation_check:
+		up_read(&pebc->lock);
+
+		if (unlikely(err))
+			return false;
+
+		if (shared_free_dst_blks > 0)
+			return true;
+		break;
+
+	default:
+		SSDFS_WARN("invalid items_state %#x\n",
+			   atomic_read(&pebc->items_state));
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+	}
+
+	return false;
+}
+
+/*
+ * has_peb_migration_done() - check that PEB's migration has been done
+ * @pebc: pointer on PEB container
+ */
+bool has_peb_migration_done(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	struct ssdfs_block_bmap *blk_bmap;
+	u16 valid_blks = U16_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si);
+
+	SSDFS_DBG("migration_state %#x\n",
+		  atomic_read(&pebc->migration_state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&pebc->migration_state)) {
+	case SSDFS_PEB_NOT_MIGRATING:
+	case SSDFS_PEB_FINISHING_MIGRATION:
+		return true;
+
+	case SSDFS_PEB_MIGRATION_PREPARATION:
+	case SSDFS_PEB_RELATION_PREPARATION:
+		return false;
+
+	case SSDFS_PEB_UNDER_MIGRATION:
+		/* valid state */
+		break;
+
+	default:
+		SSDFS_WARN("invalid migration_state %#x\n",
+			   atomic_read(&pebc->migration_state));
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		return true;
+	}
+
+	si = pebc->parent_si;
+	seg_blkbmap = &si->blk_bmap;
+
+	if (pebc->peb_index >= seg_blkbmap->pebs_count) {
+		SSDFS_WARN("peb_index %u >= pebs_count %u\n",
+			   pebc->peb_index,
+			   seg_blkbmap->pebs_count);
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		return false;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!seg_blkbmap->peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	peb_blkbmap = &seg_blkbmap->peb[pebc->peb_index];
+
+	down_read(&peb_blkbmap->lock);
+
+	switch (atomic_read(&peb_blkbmap->buffers_state)) {
+	case SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST:
+	case SSDFS_PEB_BMAP2_SRC_PEB_BMAP1_DST:
+		/* valid state */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid buffers_state %#x\n",
+			   atomic_read(&peb_blkbmap->buffers_state));
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_define_bmap_state;
+		break;
+	}
+
+	blk_bmap = peb_blkbmap->src;
+
+	if (!blk_bmap) {
+		err = -ERANGE;
+		SSDFS_WARN("source block bitmap is NULL\n");
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_define_bmap_state;
+	}
+
+	err = ssdfs_block_bmap_lock(blk_bmap);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap\n");
+		goto finish_define_bmap_state;
+	}
+
+	err = ssdfs_block_bmap_get_used_pages(blk_bmap);
+
+	ssdfs_block_bmap_unlock(blk_bmap);
+
+	if (unlikely(err < 0)) {
+		SSDFS_ERR("fail to define valid blocks count: "
+			  "err %d\n", err);
+		goto finish_define_bmap_state;
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(err >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+		valid_blks = (u16)err;
+		err = 0;
+	}
+
+finish_define_bmap_state:
+	up_read(&peb_blkbmap->lock);
+
+	if (unlikely(err))
+		return false;
+
+	return valid_blks == 0 ? true : false;
+}
+
+/*
+ * should_migration_be_finished() - check that migration should be finished
+ * @pebc: pointer on PEB container
+ */
+bool should_migration_be_finished(struct ssdfs_peb_container *pebc)
+{
+	return !is_pebs_relation_alive(pebc) || has_peb_migration_done(pebc);
+}
+
+/*
+ * ssdfs_peb_migrate_valid_blocks_range() - migrate valid blocks
+ * @si: segment object
+ * @pebc: pointer on PEB container
+ * @peb_blkbmap: PEB container's block bitmap
+ * @range: range of valid blocks
+ */
+int ssdfs_peb_migrate_valid_blocks_range(struct ssdfs_segment_info *si,
+					 struct ssdfs_peb_container *pebc,
+					 struct ssdfs_peb_blk_bmap *peb_blkbmap,
+					 struct ssdfs_block_bmap_range *range)
+{
+	struct ssdfs_segment_request *req;
+	struct ssdfs_block_bmap_range copy_range;
+	struct ssdfs_block_bmap_range sub_range;
+	bool need_repeat = false;
+	int processed_blks;
+	struct page *page;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !pebc || !peb_blkbmap || !range);
+
+	SSDFS_DBG("seg_id %llu, peb_index %u, peb_type %#x, "
+		  "range (start %u, len %u)\n",
+		  si->seg_id, pebc->peb_index, pebc->peb_type,
+		  range->start, range->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (range->len == 0) {
+		SSDFS_ERR("empty range\n");
+		return -EINVAL;
+	}
+
+	ssdfs_memcpy(&copy_range,
+		     0, sizeof(struct ssdfs_block_bmap_range),
+		     range,
+		     0, sizeof(struct ssdfs_block_bmap_range),
+		     sizeof(struct ssdfs_block_bmap_range));
+
+repeat_valid_blocks_processing:
+	req = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req)) {
+		err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+		SSDFS_ERR("fail to allocate request: err %d\n",
+			  err);
+		return err;
+	}
+
+	need_repeat = false;
+	ssdfs_request_init(req);
+	ssdfs_get_request(req);
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_COLLECT_GARBAGE_REQ,
+					    SSDFS_COPY_PAGE,
+					    SSDFS_REQ_SYNC,
+					    req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	err = ssdfs_peb_copy_pages_range(pebc, &copy_range, req);
+	if (err == -EAGAIN) {
+		err = 0;
+		need_repeat = true;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to copy range: err %d\n",
+			  err);
+		goto fail_process_valid_blocks;
+	}
+
+	processed_blks = req->result.processed_blks;
+
+	if (copy_range.len < processed_blks) {
+		err = -ERANGE;
+		SSDFS_ERR("range1 %u <= range2 %d\n",
+			  copy_range.len, processed_blks);
+		goto fail_process_valid_blocks;
+	}
+
+	for (i = 0; i < processed_blks; i++)
+		ssdfs_peb_mark_request_block_uptodate(pebc, req, i);
+
+	for (i = 0; i < pagevec_count(&req->result.pvec); i++) {
+		page = req->result.pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		set_page_writeback(page);
+	}
+
+	req->result.err = 0;
+	req->result.processed_blks = 0;
+	atomic_set(&req->result.state, SSDFS_UNKNOWN_REQ_RESULT);
+
+	err = ssdfs_segment_migrate_range_async(si, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to migrate range: err %d\n",
+			  err);
+		goto fail_process_valid_blocks;
+	}
+
+	sub_range.start = copy_range.start;
+	sub_range.len = processed_blks;
+
+	err = ssdfs_peb_blk_bmap_invalidate(peb_blkbmap,
+					    SSDFS_PEB_BLK_BMAP_SOURCE,
+					    &sub_range);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to invalidate range: "
+			  "(start %u, len %u), err %d\n",
+			  sub_range.start, sub_range.len, err);
+		goto finish_valid_blocks_processing;
+	}
+
+	if (need_repeat) {
+		copy_range.start += processed_blks;
+		copy_range.len -= processed_blks;
+		goto repeat_valid_blocks_processing;
+	}
+
+	return 0;
+
+fail_process_valid_blocks:
+	ssdfs_migration_pagevec_release(&req->result.pvec);
+	ssdfs_put_request(req);
+	ssdfs_request_free(req);
+
+finish_valid_blocks_processing:
+	return err;
+}
+
+/*
+ * ssdfs_peb_migrate_pre_alloc_blocks_range() - migrate pre-allocated blocks
+ * @si: segment object
+ * @pebc: pointer on PEB container
+ * @peb_blkbmap: PEB container's block bitmap
+ * @range: range of pre-allocated blocks
+ */
+static
+int ssdfs_peb_migrate_pre_alloc_blocks_range(struct ssdfs_segment_info *si,
+					struct ssdfs_peb_container *pebc,
+					struct ssdfs_peb_blk_bmap *peb_blkbmap,
+					struct ssdfs_block_bmap_range *range)
+{
+	struct ssdfs_segment_request *req;
+	struct ssdfs_block_bmap_range sub_range;
+	int processed_blks = 0;
+	u32 logical_blk;
+	bool has_data = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !pebc || !peb_blkbmap || !range);
+
+	SSDFS_DBG("seg_id %llu, peb_index %u, peb_type %#x, "
+		  "range (start %u, len %u)\n",
+		  si->seg_id, pebc->peb_index, pebc->peb_type,
+		  range->start, range->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (range->len == 0) {
+		SSDFS_ERR("empty range\n");
+		return -EINVAL;
+	}
+
+	while (processed_blks < range->len) {
+		req = ssdfs_request_alloc();
+		if (IS_ERR_OR_NULL(req)) {
+			err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+			SSDFS_ERR("fail to allocate request: err %d\n",
+				  err);
+			return err;
+		}
+
+		ssdfs_request_init(req);
+		ssdfs_get_request(req);
+
+		ssdfs_request_prepare_internal_data(SSDFS_PEB_COLLECT_GARBAGE_REQ,
+						    SSDFS_COPY_PRE_ALLOC_PAGE,
+						    SSDFS_REQ_SYNC,
+						    req);
+		ssdfs_request_define_segment(si->seg_id, req);
+
+		logical_blk = range->start + processed_blks;
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(logical_blk >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		req->place.start.blk_index = (u16)logical_blk;
+		req->place.len = 1;
+
+		req->extent.ino = U64_MAX;
+		req->extent.logical_offset = U64_MAX;
+		req->extent.data_bytes = 0;
+
+		req->result.processed_blks = 0;
+
+		err = ssdfs_peb_copy_pre_alloc_page(pebc, logical_blk, req);
+		if (err == -ENODATA) {
+			/* pre-allocated page hasn't content */
+			err = 0;
+			has_data = false;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to copy pre-alloc page: "
+				  "logical_blk %u, err %d\n",
+				  logical_blk, err);
+			goto fail_process_pre_alloc_blocks;
+		} else {
+			int i;
+			u32 pages_count = pagevec_count(&req->result.pvec);
+			struct page *page;
+
+			ssdfs_peb_mark_request_block_uptodate(pebc, req, 0);
+
+			for (i = 0; i < pages_count; i++) {
+				page = req->result.pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+				BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				set_page_writeback(page);
+			}
+
+			has_data = true;
+		}
+
+		req->result.err = 0;
+		req->result.processed_blks = 0;
+		atomic_set(&req->result.state, SSDFS_UNKNOWN_REQ_RESULT);
+
+		if (has_data) {
+			err = ssdfs_segment_migrate_fragment_async(si, req);
+		} else {
+			err = ssdfs_segment_migrate_pre_alloc_page_async(si,
+									 req);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to migrate pre-alloc page: "
+				  "logical_blk %u, err %d\n",
+				  logical_blk, err);
+			goto fail_process_pre_alloc_blocks;
+		}
+
+		sub_range.start = logical_blk;
+		sub_range.len = 1;
+
+		err = ssdfs_peb_blk_bmap_invalidate(peb_blkbmap,
+						    SSDFS_PEB_BLK_BMAP_SOURCE,
+						    &sub_range);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to invalidate range: "
+				  "(start %u, len %u), err %d\n",
+				  sub_range.start, sub_range.len, err);
+			goto finish_pre_alloc_blocks_processing;
+		}
+
+		processed_blks++;
+	}
+
+	return 0;
+
+fail_process_pre_alloc_blocks:
+	ssdfs_migration_pagevec_release(&req->result.pvec);
+	ssdfs_put_request(req);
+	ssdfs_request_free(req);
+
+finish_pre_alloc_blocks_processing:
+	return err;
+}
+
+/*
+ * has_ssdfs_source_peb_valid_blocks() - check that source PEB has valid blocks
+ * @pebc: pointer on PEB container
+ */
+bool has_ssdfs_source_peb_valid_blocks(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	int used_pages;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc);
+
+	SSDFS_DBG("seg_id %llu, peb_index %u, peb_type %#x, "
+		  "migration_state %#x, items_state %#x\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, pebc->peb_type,
+		  atomic_read(&pebc->migration_state),
+		  atomic_read(&pebc->items_state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebc->parent_si;
+	seg_blkbmap = &si->blk_bmap;
+	peb_blkbmap = &seg_blkbmap->peb[pebc->peb_index];
+
+	used_pages = ssdfs_src_blk_bmap_get_used_pages(peb_blkbmap);
+	if (used_pages < 0) {
+		err = used_pages;
+		SSDFS_ERR("fail to get used pages: err %d\n",
+			  err);
+		return false;
+	}
+
+	if (used_pages > 0)
+		return true;
+
+	return false;
+}
+
+/*
+ * ssdfs_peb_prepare_range_migration() - prepare blocks' range migration
+ * @pebc: pointer on PEB container
+ * @range_len: required range length
+ * @blk_type: type of migrating block
+ *
+ * This method tries to prepare range of blocks for migration.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL    - invalid input.
+ * %-ERANGE    - internal error.
+ * %-ENODATA   - no blocks for migration has been found.
+ */
+int ssdfs_peb_prepare_range_migration(struct ssdfs_peb_container *pebc,
+				      u32 range_len, int blk_type)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	struct ssdfs_block_bmap_range range = {0, 0};
+	u32 pages_per_peb;
+	int used_pages;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc);
+	BUG_ON(!mutex_is_locked(&pebc->migration_lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg_id %llu, peb_index %u, peb_type %#x, "
+		  "migration_state %#x, migration_phase %#x, "
+		  "items_state %#x, range_len %u, blk_type %#x\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, pebc->peb_type,
+		  atomic_read(&pebc->migration_state),
+		  atomic_read(&pebc->migration_phase),
+		  atomic_read(&pebc->items_state),
+		  range_len, blk_type);
+#else
+	SSDFS_DBG("seg_id %llu, peb_index %u, peb_type %#x, "
+		  "migration_state %#x, migration_phase %#x, "
+		  "items_state %#x, range_len %u, blk_type %#x\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, pebc->peb_type,
+		  atomic_read(&pebc->migration_state),
+		  atomic_read(&pebc->migration_phase),
+		  atomic_read(&pebc->items_state),
+		  range_len, blk_type);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (range_len == 0) {
+		SSDFS_ERR("invalid range_len %u\n", range_len);
+		return -EINVAL;
+	}
+
+	switch (blk_type) {
+	case SSDFS_BLK_VALID:
+	case SSDFS_BLK_PRE_ALLOCATED:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected blk_type %#x\n",
+			  blk_type);
+		return -EINVAL;
+	}
+
+	si = pebc->parent_si;
+	seg_blkbmap = &si->blk_bmap;
+	peb_blkbmap = &seg_blkbmap->peb[pebc->peb_index];
+	pages_per_peb = si->fsi->pages_per_peb;
+
+	switch (atomic_read(&pebc->migration_state)) {
+	case SSDFS_PEB_UNDER_MIGRATION:
+		/* valid state */
+		break;
+
+	default:
+		SSDFS_WARN("invalid migration_state %#x\n",
+			   atomic_read(&pebc->migration_state));
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&pebc->migration_phase)) {
+	case SSDFS_SRC_PEB_NOT_EXHAUSTED:
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("SRC PEB is not exausted\n");
+#else
+		SSDFS_DBG("SRC PEB is not exausted\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+		return -ENODATA;
+
+	case SSDFS_DST_PEB_RECEIVES_DATA:
+	case SSDFS_SHARED_ZONE_RECEIVES_DATA:
+		/* continue logic */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected migration phase %#x\n",
+			  atomic_read(&pebc->migration_phase));
+		return -ERANGE;
+	}
+
+	used_pages = ssdfs_src_blk_bmap_get_used_pages(peb_blkbmap);
+	if (used_pages < 0) {
+		err = used_pages;
+		SSDFS_ERR("fail to get used pages: err %d\n",
+			  err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("used_pages %d\n", used_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (used_pages > 0) {
+		err = ssdfs_peb_blk_bmap_collect_garbage(peb_blkbmap,
+							 0, pages_per_peb,
+							 blk_type,
+							 &range);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("found range: (start %u, len %u), err %d\n",
+			  range.start, range.len, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (err == -ENODATA) {
+			/* no valid blocks */
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+			SSDFS_ERR("no valid blocks\n");
+#else
+			SSDFS_DBG("no valid blocks\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to collect garbage: "
+				  "seg_id %llu, err %d\n",
+				  si->seg_id, err);
+			return err;
+		} else if (range.len == 0) {
+			SSDFS_ERR("invalid found range "
+				  "(start %u, len %u)\n",
+				  range.start, range.len);
+			return -ERANGE;
+		}
+
+		range.len = min_t(u32, range_len, (u32)range.len);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("final range: (start %u, len %u)\n",
+			  range.start, range.len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (is_ssdfs_peb_containing_user_data(pebc)) {
+			ssdfs_account_updated_user_data_pages(si->fsi,
+							      range.len);
+		}
+
+		switch (blk_type) {
+		case SSDFS_BLK_VALID:
+			err = ssdfs_peb_migrate_valid_blocks_range(si, pebc,
+								   peb_blkbmap,
+								   &range);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to migrate valid blocks: "
+					  "range (start %u, len %u), err %d\n",
+					  range.start, range.len, err);
+				return err;
+			}
+			break;
+
+		case SSDFS_BLK_PRE_ALLOCATED:
+			err = ssdfs_peb_migrate_pre_alloc_blocks_range(si,
+								    pebc,
+								    peb_blkbmap,
+								    &range);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to migrate pre-alloc blocks: "
+					  "range (start %u, len %u), err %d\n",
+					  range.start, range.len, err);
+				return err;
+			}
+			break;
+
+		default:
+			BUG();
+		}
+	} else {
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("unable to find blocks for migration\n");
+#else
+		SSDFS_DBG("unable to find blocks for migration\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+		return -ENODATA;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_finish_migration() - finish PEB migration
+ * @pebc: pointer on PEB container
+ */
+int ssdfs_peb_finish_migration(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_info *pebi;
+	struct ssdfs_segment_blk_bmap *seg_blkbmap;
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	int used_pages;
+	u32 pages_per_peb;
+	int old_migration_state;
+	bool is_peb_exhausted = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg_id %llu, peb_index %u, peb_type %#x, "
+		  "migration_state %#x, items_state %#x\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, pebc->peb_type,
+		  atomic_read(&pebc->migration_state),
+		  atomic_read(&pebc->items_state));
+#else
+	SSDFS_DBG("seg_id %llu, peb_index %u, peb_type %#x, "
+		  "migration_state %#x, items_state %#x\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, pebc->peb_type,
+		  atomic_read(&pebc->migration_state),
+		  atomic_read(&pebc->items_state));
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	si = pebc->parent_si;
+	fsi = pebc->parent_si->fsi;
+	pages_per_peb = fsi->pages_per_peb;
+	seg_blkbmap = &si->blk_bmap;
+	peb_blkbmap = &seg_blkbmap->peb[pebc->peb_index];
+
+	mutex_lock(&pebc->migration_lock);
+
+check_migration_state:
+	old_migration_state = atomic_read(&pebc->migration_state);
+
+	used_pages = ssdfs_src_blk_bmap_get_used_pages(peb_blkbmap);
+	if (used_pages < 0) {
+		err = used_pages;
+		SSDFS_ERR("fail to get used pages: err %d\n",
+			  err);
+		goto finish_migration_done;
+	}
+
+	switch (old_migration_state) {
+	case SSDFS_PEB_NOT_MIGRATING:
+	case SSDFS_PEB_MIGRATION_PREPARATION:
+	case SSDFS_PEB_RELATION_PREPARATION:
+		err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("PEB is not migrating: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_migration_done;
+
+	case SSDFS_PEB_UNDER_MIGRATION:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("PEB is under migration: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (!fsi->is_zns_device) {
+			pebi = pebc->dst_peb;
+			if (!pebi) {
+				err = -ERANGE;
+				SSDFS_ERR("PEB pointer is NULL: "
+					  "seg_id %llu, peb_index %u\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index);
+				goto finish_migration_done;
+			}
+		}
+
+		ssdfs_peb_current_log_lock(pebi);
+		is_peb_exhausted = is_ssdfs_peb_exhausted(fsi, pebi);
+		ssdfs_peb_current_log_unlock(pebi);
+
+		if (is_peb_exhausted)
+			goto try_finish_migration_now;
+		else if (has_peb_migration_done(pebc))
+			goto try_finish_migration_now;
+		else if (used_pages <= SSDFS_GC_FINISH_MIGRATION)
+			goto try_finish_migration_now;
+		else {
+			err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("Don't finish migration: "
+				  "seg_id %llu, peb_index %u\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_migration_done;
+		}
+		break;
+
+	case SSDFS_PEB_FINISHING_MIGRATION: {
+			DEFINE_WAIT(wait);
+
+			mutex_unlock(&pebc->migration_lock);
+			prepare_to_wait(&pebc->migration_wq, &wait,
+					TASK_UNINTERRUPTIBLE);
+			schedule();
+			finish_wait(&pebc->migration_wq, &wait);
+			mutex_lock(&pebc->migration_lock);
+			goto check_migration_state;
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid migration_state %#x\n",
+			   atomic_read(&pebc->migration_state));
+		goto finish_migration_done;
+	}
+
+try_finish_migration_now:
+	atomic_set(&pebc->migration_state, SSDFS_PEB_FINISHING_MIGRATION);
+
+	while (used_pages > 0) {
+		struct ssdfs_block_bmap_range range1 = {0, 0};
+		struct ssdfs_block_bmap_range range2 = {0, 0};
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("used_pages %d\n", used_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_peb_blk_bmap_collect_garbage(peb_blkbmap,
+							 0, pages_per_peb,
+							 SSDFS_BLK_VALID,
+							 &range1);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("range1.start %u, range1.len %u, err %d\n",
+			  range1.start, range1.len, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (err == -ENODATA) {
+			/* no valid blocks */
+			err = 0;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to collect garbage: "
+				  "seg_id %llu, err %d\n",
+				  si->seg_id, err);
+			goto finish_migration_done;
+		}
+
+		err = ssdfs_peb_blk_bmap_collect_garbage(peb_blkbmap,
+							0, pages_per_peb,
+							SSDFS_BLK_PRE_ALLOCATED,
+							&range2);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("range2.start %u, range2.len %u, err %d\n",
+			  range2.start, range2.len, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (err == -ENODATA) {
+			/* no valid blocks */
+			err = 0;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to collect garbage: "
+				  "seg_id %llu, err %d\n",
+				  si->seg_id, err);
+			goto finish_migration_done;
+		}
+
+		if (range1.len == 0 && range2.len == 0) {
+			err = -ERANGE;
+			SSDFS_ERR("no valid blocks were found\n");
+			goto finish_migration_done;
+		}
+
+		if (range1.len > 0) {
+			if (is_ssdfs_peb_containing_user_data(pebc)) {
+				ssdfs_account_updated_user_data_pages(si->fsi,
+								    range1.len);
+			}
+
+			err = ssdfs_peb_migrate_valid_blocks_range(si, pebc,
+								   peb_blkbmap,
+								   &range1);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to migrate valid blocks: "
+					  "range (start %u, len %u), err %d\n",
+					  range1.start, range1.len, err);
+				goto finish_migration_done;
+			}
+		}
+
+		if (range2.len > 0) {
+			if (is_ssdfs_peb_containing_user_data(pebc)) {
+				ssdfs_account_updated_user_data_pages(si->fsi,
+								    range2.len);
+			}
+
+			err = ssdfs_peb_migrate_pre_alloc_blocks_range(si,
+								    pebc,
+								    peb_blkbmap,
+								    &range2);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to migrate pre-alloc blocks: "
+					  "range (start %u, len %u), err %d\n",
+					  range2.start, range2.len, err);
+				goto finish_migration_done;
+			}
+		}
+
+		used_pages -= range1.len;
+		used_pages -= range2.len;
+
+		if (used_pages < 0) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid used_pages %d\n",
+				  used_pages);
+			goto finish_migration_done;
+		}
+	}
+
+	used_pages = ssdfs_src_blk_bmap_get_used_pages(peb_blkbmap);
+	if (used_pages != 0) {
+		err = -ERANGE;
+		SSDFS_ERR("source PEB has valid blocks: "
+			  "used_pages %d\n",
+			  used_pages);
+		goto finish_migration_done;
+	}
+
+	switch (atomic_read(&pebc->items_state)) {
+	case SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER:
+		err = ssdfs_peb_container_forget_relation(pebc);
+		break;
+
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB2_DST_CONTAINER:
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+		err = ssdfs_peb_container_forget_source(pebc);
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid items_state %#x\n",
+			   atomic_read(&pebc->items_state));
+		goto finish_migration_done;
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to break relation: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index, err);
+		goto finish_migration_done;
+	}
+
+finish_migration_done:
+	if (err) {
+		switch (atomic_read(&pebc->migration_state)) {
+		case SSDFS_PEB_FINISHING_MIGRATION:
+			atomic_set(&pebc->migration_state,
+				   old_migration_state);
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+	}
+
+	mutex_unlock(&pebc->migration_lock);
+
+	wake_up_all(&pebc->migration_wq);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
-- 
2.34.1

