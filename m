Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225356A2623
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBYBQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjBYBPx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:15:53 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EA5126FB
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:46 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id bi17so820486oib.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccnAJAh0dcfidseCDgjxq/IXJ8B72T0PFubL58Ayp1A=;
        b=U9oY2egA1mIiP10J/fzkO0nYtSWcWaQRfKluneGuNm8rnyPWjwMi0ZtnFYMnot2Rez
         6lKYMxJvIkm93JUuwdlPvUG9xL7I9x1maiWL1GEYeX3zwIiDmxXKjyoiPH+XgTzg+q9n
         Hcwvn83jtIm+xuLzHp6grSqWrZLvvALr4wnM55jl95C5VrbLXBq7C5YdqVRK2VQUXMUr
         38st56V56Q+6MunBjkJNCAM93itYzQTapFPy1flcFTm7tx4pC7RnNqladaoaqKadiqyp
         W+DmbtVoBnVS1tpmlaUEZCjzurKooy2htGNSrf5QXRL66CvcrbHIJZWzn1TXLA2a/uS9
         K91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccnAJAh0dcfidseCDgjxq/IXJ8B72T0PFubL58Ayp1A=;
        b=eKe9WYRFSsU0tGN1+7Jp0Snu6gJyPyD0DP8Z75gAUvKUvwTyKgkefPH97ECFs+//bO
         QGxzLR8zfEYReoAAJp+Q9fFmOh+1BhOgZT6vGEMIenS2CQkfZXYACZO3LPipvoPk0et0
         oPg7YhyI5CDHTrOaaju71p4cGhBm6Z7nyLZCBPnRA8d0B8ldsAM3jRMjnZN1RGlacu8d
         Ztmvns/hs2v44XeGuoL/FMFFFpMZW9UeSmiglZPnog1L23zvbO9CLHPrBi08W8AknveW
         M8iqQNhLN9I3iLjhjSDq2Z0T0aC8mIyPcrh5jBHkcXHMpFiRDcSIAsAcNafjrbv+rntG
         0QZA==
X-Gm-Message-State: AO0yUKUiTyfb/xFkPJf5+Sa6oxpF2w0LeX2LqO+lJORYcIsU0GtrYYBM
        +JBm3+UTDg8doTkrgk1c3bwXa6sJ+wl+E227
X-Google-Smtp-Source: AK7set/yjgUlUJKej5XQV+nMrlTx/OCMkCv8CYo4+Ezsj8mVLU6C5wcjoUtaHyLjPxCB9D9Gmro+sQ==
X-Received: by 2002:aca:180a:0:b0:37f:cc3d:a342 with SMTP id h10-20020aca180a000000b0037fcc3da342mr3671694oih.1.1677287742834;
        Fri, 24 Feb 2023 17:15:42 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:15:41 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 04/76] ssdfs: implement super operations
Date:   Fri, 24 Feb 2023 17:08:15 -0800
Message-Id: <20230225010927.813929-5-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230225010927.813929-1-slava@dubeyko.com>
References: <20230225010927.813929-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Patch implements register/unregister file system logic.
The register FS logic includes caches creation/initialization,
compression support initialization, sysfs subsystem
initialization. Oppositely, unregister FS logic executes
destruction of caches, compression subsystem, and sysfs
entries.

Also, patch implements basic mount/unmount logic.
The ssdfs_fill_super() implements mount logic that includes:
(1) parsing mount options,
(2) extract superblock info,
(3) create key in-core metadata structures (mapping table,
    segment bitmap, b-trees),
(4) create root inode,
(5) start metadata structures' threads,
(6) commit superblock on finish of mount operation.

The ssdfs_put_super() implements unmount logic:
(1) stop metadata threads,
(2) wait unfinished user data requests,
(3) flush dirty metadata structures,
(4) commit superblock,
(5) destroy in-core metadata structures.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/fs_error.c  |  257 ++++++
 fs/ssdfs/options.c   |  190 +++++
 fs/ssdfs/readwrite.c |  651 +++++++++++++++
 fs/ssdfs/super.c     | 1844 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 2942 insertions(+)
 create mode 100644 fs/ssdfs/fs_error.c
 create mode 100644 fs/ssdfs/options.c
 create mode 100644 fs/ssdfs/readwrite.c
 create mode 100644 fs/ssdfs/super.c

diff --git a/fs/ssdfs/fs_error.c b/fs/ssdfs/fs_error.c
new file mode 100644
index 000000000000..452ace18272d
--- /dev/null
+++ b/fs/ssdfs/fs_error.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/fs_error.c - logic for the case of file system errors detection.
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
+#include <linux/page-flags.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_fs_error_page_leaks;
+atomic64_t ssdfs_fs_error_memory_leaks;
+atomic64_t ssdfs_fs_error_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_fs_error_cache_leaks_increment(void *kaddr)
+ * void ssdfs_fs_error_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_fs_error_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_fs_error_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_fs_error_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_fs_error_kfree(void *kaddr)
+ * struct page *ssdfs_fs_error_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_fs_error_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_fs_error_free_page(struct page *page)
+ * void ssdfs_fs_error_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(fs_error)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(fs_error)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_fs_error_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_fs_error_page_leaks, 0);
+	atomic64_set(&ssdfs_fs_error_memory_leaks, 0);
+	atomic64_set(&ssdfs_fs_error_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_fs_error_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_fs_error_page_leaks) != 0) {
+		SSDFS_ERR("FS ERROR: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_fs_error_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_fs_error_memory_leaks) != 0) {
+		SSDFS_ERR("FS ERROR: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_fs_error_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_fs_error_cache_leaks) != 0) {
+		SSDFS_ERR("FS ERROR: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_fs_error_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static void ssdfs_handle_error(struct super_block *sb)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+
+	if (sb->s_flags & SB_RDONLY)
+		return;
+
+	spin_lock(&fsi->volume_state_lock);
+	fsi->fs_state = SSDFS_ERROR_FS;
+	spin_unlock(&fsi->volume_state_lock);
+
+	if (ssdfs_test_opt(fsi->mount_opts, ERRORS_PANIC)) {
+		panic("SSDFS (device %s): panic forced after error\n",
+			fsi->devops->device_name(sb));
+	} else if (ssdfs_test_opt(fsi->mount_opts, ERRORS_RO)) {
+		SSDFS_CRIT("Remounting filesystem read-only\n");
+		/*
+		 * Make sure updated value of ->s_mount_flags will be visible
+		 * before ->s_flags update
+		 */
+		smp_wmb();
+		sb->s_flags |= SB_RDONLY;
+	}
+}
+
+void ssdfs_fs_error(struct super_block *sb, const char *file,
+		    const char *function, unsigned int line,
+		    const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	pr_crit("SSDFS error (device %s): pid %d:%s:%d %s(): comm %s: %pV",
+		SSDFS_FS_I(sb)->devops->device_name(sb), current->pid,
+		file, line, function, current->comm, &vaf);
+	va_end(args);
+
+	ssdfs_handle_error(sb);
+}
+
+int ssdfs_set_page_dirty(struct page *page)
+{
+	struct address_space *mapping = page->mapping;
+	unsigned long flags;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page_index: %llu, mapping %p\n",
+		  (u64)page_index(page), mapping);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!PageLocked(page)) {
+		SSDFS_WARN("page isn't locked: "
+			   "page_index %llu, mapping %p\n",
+			   (u64)page_index(page), mapping);
+		return -ERANGE;
+	}
+
+	SetPageDirty(page);
+
+	if (mapping) {
+		xa_lock_irqsave(&mapping->i_pages, flags);
+		__xa_set_mark(&mapping->i_pages, page_index(page),
+				PAGECACHE_TAG_DIRTY);
+		xa_unlock_irqrestore(&mapping->i_pages, flags);
+	}
+
+	return 0;
+}
+
+int __ssdfs_clear_dirty_page(struct page *page)
+{
+	struct address_space *mapping = page->mapping;
+	unsigned long flags;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page_index: %llu, mapping %p\n",
+		  (u64)page_index(page), mapping);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!PageLocked(page)) {
+		SSDFS_WARN("page isn't locked: "
+			   "page_index %llu, mapping %p\n",
+			   (u64)page_index(page), mapping);
+		return -ERANGE;
+	}
+
+	if (mapping) {
+		xa_lock_irqsave(&mapping->i_pages, flags);
+		if (test_bit(PG_dirty, &page->flags)) {
+			__xa_clear_mark(&mapping->i_pages,
+					page_index(page),
+					PAGECACHE_TAG_DIRTY);
+		}
+		xa_unlock_irqrestore(&mapping->i_pages, flags);
+	}
+
+	TestClearPageDirty(page);
+
+	return 0;
+}
+
+int ssdfs_clear_dirty_page(struct page *page)
+{
+	struct address_space *mapping = page->mapping;
+	unsigned long flags;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page_index: %llu, mapping %p\n",
+		  (u64)page_index(page), mapping);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!PageLocked(page)) {
+		SSDFS_WARN("page isn't locked: "
+			   "page_index %llu, mapping %p\n",
+			   (u64)page_index(page), mapping);
+		return -ERANGE;
+	}
+
+	if (mapping) {
+		xa_lock_irqsave(&mapping->i_pages, flags);
+		if (test_bit(PG_dirty, &page->flags)) {
+			__xa_clear_mark(&mapping->i_pages,
+					page_index(page),
+					PAGECACHE_TAG_DIRTY);
+			xa_unlock_irqrestore(&mapping->i_pages, flags);
+			return clear_page_dirty_for_io(page);
+		}
+		xa_unlock_irqrestore(&mapping->i_pages, flags);
+		return 0;
+	}
+
+	TestClearPageDirty(page);
+
+	return 0;
+}
+
+/*
+ * ssdfs_clear_dirty_pages - discard dirty pages in address space
+ * @mapping: address space with dirty pages for discarding
+ */
+void ssdfs_clear_dirty_pages(struct address_space *mapping)
+{
+	struct pagevec pvec;
+	unsigned int i;
+	pgoff_t index = 0;
+	int err;
+
+	pagevec_init(&pvec);
+
+	while (pagevec_lookup_tag(&pvec, mapping, &index,
+				  PAGECACHE_TAG_DIRTY)) {
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			struct page *page = pvec.pages[i];
+
+			ssdfs_lock_page(page);
+			err = ssdfs_clear_dirty_page(page);
+			ssdfs_unlock_page(page);
+
+			if (unlikely(err)) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("fail clear page dirty: "
+					  "page_index %llu\n",
+					  (u64)page_index(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+			}
+		}
+		ssdfs_fs_error_pagevec_release(&pvec);
+		cond_resched();
+	}
+}
diff --git a/fs/ssdfs/options.c b/fs/ssdfs/options.c
new file mode 100644
index 000000000000..e36870868c08
--- /dev/null
+++ b/fs/ssdfs/options.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/options.c - mount options parsing.
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
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/parser.h>
+#include <linux/mount.h>
+#include <linux/slab.h>
+#include <linux/seq_file.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "segment_bitmap.h"
+
+/*
+ * SSDFS mount options.
+ *
+ * Opt_compr: change default compressor
+ * Opt_fs_err_panic: panic if fs error is detected
+ * Opt_fs_err_ro: remount in RO state if fs error is detected
+ * Opt_fs_err_cont: continue execution if fs error is detected
+ * Opt_ignore_fs_state: ignore on-disk file system state during mount
+ * Opt_err: just end of array marker
+ */
+enum {
+	Opt_compr,
+	Opt_fs_err_panic,
+	Opt_fs_err_ro,
+	Opt_fs_err_cont,
+	Opt_ignore_fs_state,
+	Opt_err,
+};
+
+static const match_table_t tokens = {
+	{Opt_compr, "compr=%s"},
+	{Opt_fs_err_panic, "errors=panic"},
+	{Opt_fs_err_ro, "errors=remount-ro"},
+	{Opt_fs_err_cont, "errors=continue"},
+	{Opt_ignore_fs_state, "fs_state=ignore"},
+	{Opt_err, NULL},
+};
+
+int ssdfs_parse_options(struct ssdfs_fs_info *fs_info, char *data)
+{
+	substring_t args[MAX_OPT_ARGS];
+	char *p, *name;
+
+	if (!data)
+		return 0;
+
+	while ((p = strsep(&data, ","))) {
+		int token;
+
+		if (!*p)
+			continue;
+
+		token = match_token(p, tokens, args);
+		switch (token) {
+		case Opt_compr:
+			name = match_strdup(&args[0]);
+
+			if (!name)
+				return -ENOMEM;
+			if (!strcmp(name, "none"))
+				ssdfs_set_opt(fs_info->mount_opts,
+						COMPR_MODE_NONE);
+#ifdef CONFIG_SSDFS_ZLIB
+			else if (!strcmp(name, "zlib"))
+				ssdfs_set_opt(fs_info->mount_opts,
+						COMPR_MODE_ZLIB);
+#endif
+#ifdef CONFIG_SSDFS_LZO
+			else if (!strcmp(name, "lzo"))
+				ssdfs_set_opt(fs_info->mount_opts,
+						COMPR_MODE_LZO);
+#endif
+			else {
+				SSDFS_ERR("unknown compressor %s\n", name);
+				ssdfs_kfree(name);
+				return -EINVAL;
+			}
+			ssdfs_kfree(name);
+			break;
+
+		case Opt_fs_err_panic:
+			/* Clear possible default initialization */
+			ssdfs_clear_opt(fs_info->mount_opts, ERRORS_RO);
+			ssdfs_clear_opt(fs_info->mount_opts, ERRORS_CONT);
+			ssdfs_set_opt(fs_info->mount_opts, ERRORS_PANIC);
+			break;
+
+		case Opt_fs_err_ro:
+			/* Clear possible default initialization */
+			ssdfs_clear_opt(fs_info->mount_opts, ERRORS_PANIC);
+			ssdfs_clear_opt(fs_info->mount_opts, ERRORS_CONT);
+			ssdfs_set_opt(fs_info->mount_opts, ERRORS_RO);
+			break;
+
+		case Opt_fs_err_cont:
+			/* Clear possible default initialization */
+			ssdfs_clear_opt(fs_info->mount_opts, ERRORS_PANIC);
+			ssdfs_clear_opt(fs_info->mount_opts, ERRORS_RO);
+			ssdfs_set_opt(fs_info->mount_opts, ERRORS_CONT);
+			break;
+
+		case Opt_ignore_fs_state:
+			ssdfs_set_opt(fs_info->mount_opts, IGNORE_FS_STATE);
+			break;
+
+		default:
+			SSDFS_ERR("unrecognized mount option '%s'\n", p);
+			return -EINVAL;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("DONE: parse options\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+void ssdfs_initialize_fs_errors_option(struct ssdfs_fs_info *fsi)
+{
+	if (fsi->fs_errors == SSDFS_ERRORS_PANIC)
+		ssdfs_set_opt(fsi->mount_opts, ERRORS_PANIC);
+	else if (fsi->fs_errors == SSDFS_ERRORS_RO)
+		ssdfs_set_opt(fsi->mount_opts, ERRORS_RO);
+	else if (fsi->fs_errors == SSDFS_ERRORS_CONTINUE)
+		ssdfs_set_opt(fsi->mount_opts, ERRORS_CONT);
+	else {
+		u16 def_behaviour = SSDFS_ERRORS_DEFAULT;
+
+		switch (def_behaviour) {
+		case SSDFS_ERRORS_PANIC:
+			ssdfs_set_opt(fsi->mount_opts, ERRORS_PANIC);
+			break;
+
+		case SSDFS_ERRORS_RO:
+			ssdfs_set_opt(fsi->mount_opts, ERRORS_RO);
+			break;
+		}
+	}
+}
+
+int ssdfs_show_options(struct seq_file *seq, struct dentry *root)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(root->d_sb);
+	char *compress_type;
+
+	if (ssdfs_test_opt(fsi->mount_opts, COMPR_MODE_ZLIB)) {
+		compress_type = "zlib";
+		seq_printf(seq, ",compress=%s", compress_type);
+	} else if (ssdfs_test_opt(fsi->mount_opts, COMPR_MODE_LZO)) {
+		compress_type = "lzo";
+		seq_printf(seq, ",compress=%s", compress_type);
+	}
+
+	if (ssdfs_test_opt(fsi->mount_opts, ERRORS_PANIC))
+		seq_puts(seq, ",errors=panic");
+	else if (ssdfs_test_opt(fsi->mount_opts, ERRORS_RO))
+		seq_puts(seq, ",errors=remount-ro");
+	else if (ssdfs_test_opt(fsi->mount_opts, ERRORS_CONT))
+		seq_puts(seq, ",errors=continue");
+
+	if (ssdfs_test_opt(fsi->mount_opts, IGNORE_FS_STATE))
+		seq_puts(seq, ",fs_state=ignore");
+
+	return 0;
+}
diff --git a/fs/ssdfs/readwrite.c b/fs/ssdfs/readwrite.c
new file mode 100644
index 000000000000..b47cef995e4b
--- /dev/null
+++ b/fs/ssdfs/readwrite.c
@@ -0,0 +1,651 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/readwrite.c - read/write primitive operations.
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
+#include <linux/rwsem.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+
+#include <trace/events/ssdfs.h>
+
+/*
+ * ssdfs_read_page_from_volume() - read page from volume
+ * @fsi: pointer on shared file system object
+ * @peb_id: PEB identification number
+ * @bytes_off: offset from PEB's begining in bytes
+ * @page: memory page
+ *
+ * This function tries to read page from the volume.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-EIO        - I/O error.
+ */
+int ssdfs_read_page_from_volume(struct ssdfs_fs_info *fsi,
+				u64 peb_id, u32 bytes_off,
+				struct page *page)
+{
+	struct super_block *sb;
+	loff_t offset;
+	u32 peb_size;
+	u32 pagesize;
+	u32 pages_per_peb;
+	u32 pages_off;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !page);
+	BUG_ON(!fsi->devops->readpage);
+
+	SSDFS_DBG("fsi %p, peb_id %llu, bytes_off %u, page %p\n",
+		  fsi, peb_id, bytes_off, page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	sb = fsi->sb;
+	pagesize = fsi->pagesize;
+	pages_per_peb = fsi->pages_per_peb;
+	pages_off = bytes_off / pagesize;
+
+	if (pages_per_peb >= (U32_MAX / pagesize)) {
+		SSDFS_ERR("pages_per_peb %u >= U32_MAX / pagesize %u\n",
+			  pages_per_peb, pagesize);
+		return -EINVAL;
+	}
+
+	peb_size = pages_per_peb * pagesize;
+
+	if (peb_id >= div_u64(ULLONG_MAX, peb_size)) {
+		SSDFS_ERR("peb_id %llu >= ULLONG_MAX / peb_size %u\n",
+			  peb_id, peb_size);
+		return -EINVAL;
+	}
+
+	offset = peb_id * peb_size;
+
+	if (pages_off >= pages_per_peb) {
+		SSDFS_ERR("pages_off %u >= pages_per_peb %u\n",
+			  pages_off, pages_per_peb);
+		return -EINVAL;
+	}
+
+	if (pages_off >= (U32_MAX / pagesize)) {
+		SSDFS_ERR("pages_off %u >= U32_MAX / pagesize %u\n",
+			  pages_off, fsi->pagesize);
+		return -EINVAL;
+	}
+
+	offset += bytes_off;
+
+	if (fsi->devops->peb_isbad) {
+		err = fsi->devops->peb_isbad(sb, offset);
+		if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("offset %llu is in bad PEB: err %d\n",
+				  (unsigned long long)offset, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -EIO;
+		}
+	}
+
+	err = fsi->devops->readpage(sb, page, offset);
+	if (unlikely(err)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fail to read page: offset %llu, err %d\n",
+			  (unsigned long long)offset, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_read_pagevec_from_volume() - read pagevec from volume
+ * @fsi: pointer on shared file system object
+ * @peb_id: PEB identification number
+ * @bytes_off: offset from PEB's begining in bytes
+ * @pvec: pagevec [in|out]
+ *
+ * This function tries to read pages from the volume.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-EIO        - I/O error.
+ */
+int ssdfs_read_pagevec_from_volume(struct ssdfs_fs_info *fsi,
+				   u64 peb_id, u32 bytes_off,
+				   struct pagevec *pvec)
+{
+	struct super_block *sb;
+	loff_t offset;
+	u32 peb_size;
+	u32 pagesize;
+	u32 pages_per_peb;
+	u32 pages_off;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !pvec);
+	BUG_ON(!fsi->devops->readpages);
+
+	SSDFS_DBG("fsi %p, peb_id %llu, bytes_off %u, pvec %p\n",
+		  fsi, peb_id, bytes_off, pvec);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	sb = fsi->sb;
+	pagesize = fsi->pagesize;
+	pages_per_peb = fsi->pages_per_peb;
+	pages_off = bytes_off / pagesize;
+
+	if (pages_per_peb >= (U32_MAX / pagesize)) {
+		SSDFS_ERR("pages_per_peb %u >= U32_MAX / pagesize %u\n",
+			  pages_per_peb, pagesize);
+		return -EINVAL;
+	}
+
+	peb_size = pages_per_peb * pagesize;
+
+	if (peb_id >= div_u64(ULLONG_MAX, peb_size)) {
+		SSDFS_ERR("peb_id %llu >= ULLONG_MAX / peb_size %u\n",
+			  peb_id, peb_size);
+		return -EINVAL;
+	}
+
+	offset = peb_id * peb_size;
+
+	if (pages_off >= pages_per_peb) {
+		SSDFS_ERR("pages_off %u >= pages_per_peb %u\n",
+			  pages_off, pages_per_peb);
+		return -EINVAL;
+	}
+
+	if (pages_off >= (U32_MAX / pagesize)) {
+		SSDFS_ERR("pages_off %u >= U32_MAX / pagesize %u\n",
+			  pages_off, fsi->pagesize);
+		return -EINVAL;
+	}
+
+	offset += bytes_off;
+
+	if (fsi->devops->peb_isbad) {
+		err = fsi->devops->peb_isbad(sb, offset);
+		if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("offset %llu is in bad PEB: err %d\n",
+				  (unsigned long long)offset, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -EIO;
+		}
+	}
+
+	err = fsi->devops->readpages(sb, pvec, offset);
+	if (unlikely(err)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fail to read pvec: offset %llu, err %d\n",
+			  (unsigned long long)offset, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_aligned_read_buffer() - aligned read from volume into buffer
+ * @fsi: pointer on shared file system object
+ * @peb_id: PEB identification number
+ * @bytes_off: offset from PEB's begining in bytes
+ * @buf: buffer
+ * @size: buffer size
+ * @read_bytes: really read bytes
+ *
+ * This function tries to read in buffer by means of page aligned
+ * request. It reads part of requested data in the case of unaligned
+ * request. The @read_bytes returns value of really read data.
+ *
+ * RETURN:
+ * [success] - buffer contains data of @read_bytes in size.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-EIO        - I/O error.
+ */
+int ssdfs_aligned_read_buffer(struct ssdfs_fs_info *fsi,
+			      u64 peb_id, u32 bytes_off,
+			      void *buf, size_t size,
+			      size_t *read_bytes)
+{
+	struct super_block *sb;
+	loff_t offset;
+	u32 peb_size;
+	u32 pagesize;
+	u32 pages_per_peb;
+	u32 pages_off;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !buf);
+	BUG_ON(!fsi->devops->read);
+
+	SSDFS_DBG("fsi %p, peb_id %llu, bytes_off %u, buf %p, size %zu\n",
+		  fsi, peb_id, bytes_off, buf, size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	sb = fsi->sb;
+	pagesize = fsi->pagesize;
+	pages_per_peb = fsi->pages_per_peb;
+	pages_off = bytes_off / pagesize;
+
+	if (pages_per_peb >= (U32_MAX / pagesize)) {
+		SSDFS_ERR("pages_per_peb %u >= U32_MAX / pagesize %u\n",
+			  pages_per_peb, pagesize);
+		return -EINVAL;
+	}
+
+	peb_size = pages_per_peb * pagesize;
+
+	if (peb_id >= div_u64(ULLONG_MAX, peb_size)) {
+		SSDFS_ERR("peb_id %llu >= ULLONG_MAX / peb_size %u\n",
+			  peb_id, peb_size);
+		return -EINVAL;
+	}
+
+	offset = peb_id * peb_size;
+
+	if (pages_off >= pages_per_peb) {
+		SSDFS_ERR("pages_off %u >= pages_per_peb %u\n",
+			  pages_off, pages_per_peb);
+		return -EINVAL;
+	}
+
+	if (pages_off >= (U32_MAX / pagesize)) {
+		SSDFS_ERR("pages_off %u >= U32_MAX / pagesize %u\n",
+			  pages_off, fsi->pagesize);
+		return -EINVAL;
+	}
+
+	if (size > pagesize) {
+		SSDFS_ERR("size %zu > pagesize %u\n",
+			  size, fsi->pagesize);
+		return -EINVAL;
+	}
+
+	offset += bytes_off;
+
+	*read_bytes = ((pages_off + 1) * pagesize) - bytes_off;
+	*read_bytes = min_t(size_t, *read_bytes, size);
+
+	if (fsi->devops->peb_isbad) {
+		err = fsi->devops->peb_isbad(sb, offset);
+		if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("offset %llu is in bad PEB: err %d\n",
+				  (unsigned long long)offset, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -EIO;
+		}
+	}
+
+	err = fsi->devops->read(sb, offset, *read_bytes, buf);
+	if (unlikely(err)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fail to read from offset %llu, size %zu, err %d\n",
+			  (unsigned long long)offset, *read_bytes, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_unaligned_read_buffer() - unaligned read from volume into buffer
+ * @fsi: pointer on shared file system object
+ * @peb_id: PEB identification number
+ * @bytes_off: offset from PEB's begining in bytes
+ * @buf: buffer
+ * @size: buffer size
+ *
+ * This function tries to read in buffer by means of page unaligned
+ * request.
+ *
+ * RETURN:
+ * [success] - buffer contains data of @size in bytes.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-EIO        - I/O error.
+ */
+int ssdfs_unaligned_read_buffer(struct ssdfs_fs_info *fsi,
+				u64 peb_id, u32 bytes_off,
+				void *buf, size_t size)
+{
+	size_t read_bytes = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !buf);
+	BUG_ON(!fsi->devops->read);
+
+	SSDFS_DBG("fsi %p, peb_id %llu, bytes_off %u, buf %p, size %zu\n",
+		  fsi, peb_id, bytes_off, buf, size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	do {
+		size_t iter_size = size - read_bytes;
+		size_t iter_read_bytes;
+
+		err = ssdfs_aligned_read_buffer(fsi, peb_id,
+						bytes_off + read_bytes,
+						buf + read_bytes,
+						iter_size,
+						&iter_read_bytes);
+		if (err) {
+			SSDFS_ERR("fail to read from peb_id %llu, offset %zu, "
+				  "size %zu, err %d\n",
+				  peb_id, (size_t)(bytes_off + read_bytes),
+				  iter_size, err);
+			return err;
+		}
+
+		read_bytes += iter_read_bytes;
+	} while (read_bytes < size);
+
+	return 0;
+}
+
+/*
+ * ssdfs_can_write_sb_log() - check that superblock log can be written
+ * @sb: pointer on superblock object
+ * @sb_log: superblock log's extent
+ *
+ * This function checks that superblock log can be written
+ * successfully.
+ *
+ * RETURN:
+ * [success] - superblock log can be written successfully.
+ * [failure] - error code:
+ *
+ * %-ERANGE     - invalid extent.
+ */
+int ssdfs_can_write_sb_log(struct super_block *sb,
+			   struct ssdfs_peb_extent *sb_log)
+{
+	struct ssdfs_fs_info *fsi;
+	u64 cur_peb;
+	u32 page_offset;
+	u32 log_size;
+	loff_t byte_off;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!sb || !sb_log);
+
+	SSDFS_DBG("leb_id %llu, peb_id %llu, "
+		  "page_offset %u, pages_count %u\n",
+		  sb_log->leb_id, sb_log->peb_id,
+		  sb_log->page_offset, sb_log->pages_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = SSDFS_FS_I(sb);
+
+	if (!fsi->devops->can_write_page)
+		return 0;
+
+	cur_peb = sb_log->peb_id;
+	page_offset = sb_log->page_offset;
+	log_size = sb_log->pages_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_peb %llu, page_offset %u, "
+		  "log_size %u, pages_per_peb %u\n",
+		  cur_peb, page_offset,
+		  log_size, fsi->pages_per_peb);
+
+	if (log_size > fsi->pages_per_seg) {
+		SSDFS_ERR("log_size value %u is too big\n",
+			  log_size);
+		return -ERANGE;
+	}
+
+	if (cur_peb > div_u64(ULLONG_MAX, fsi->pages_per_seg)) {
+		SSDFS_ERR("cur_peb value %llu is too big\n",
+			  cur_peb);
+		return -ERANGE;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	byte_off = cur_peb * fsi->pages_per_peb;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (byte_off > div_u64(ULLONG_MAX, fsi->pagesize)) {
+		SSDFS_ERR("byte_off value %llu is too big\n",
+			  byte_off);
+		return -ERANGE;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	byte_off *= fsi->pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if ((u64)page_offset > div_u64(ULLONG_MAX, fsi->pagesize)) {
+		SSDFS_ERR("page_offset value %u is too big\n",
+			  page_offset);
+		return -ERANGE;
+	}
+
+	if (byte_off > (ULLONG_MAX - ((u64)page_offset * fsi->pagesize))) {
+		SSDFS_ERR("byte_off value %llu is too big\n",
+			  byte_off);
+			return -ERANGE;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	byte_off += (u64)page_offset * fsi->pagesize;
+
+	for (i = 0; i < log_size; i++) {
+#ifdef CONFIG_SSDFS_DEBUG
+		if (byte_off > (ULLONG_MAX - (i * fsi->pagesize))) {
+			SSDFS_ERR("offset value %llu is too big\n",
+				  byte_off);
+			return -ERANGE;
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = fsi->devops->can_write_page(sb, byte_off, true);
+		if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page can't be written: err %d\n", err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		}
+
+		byte_off += fsi->pagesize;
+	}
+
+	return 0;
+}
+
+int ssdfs_unaligned_read_pagevec(struct pagevec *pvec,
+				 u32 offset, u32 size,
+				 void *buf)
+{
+	struct page *page;
+	u32 page_off;
+	u32 bytes_off;
+	size_t read_bytes = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pvec || !buf);
+
+	SSDFS_DBG("pvec %p, offset %u, size %u, buf %p\n",
+		  pvec, offset, size, buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	do {
+		size_t iter_read_bytes;
+		size_t cur_off;
+
+		bytes_off = offset + read_bytes;
+		page_off = bytes_off / PAGE_SIZE;
+		cur_off = bytes_off % PAGE_SIZE;
+
+		iter_read_bytes = min_t(size_t,
+					(size_t)(size - read_bytes),
+					(size_t)(PAGE_SIZE - cur_off));
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page_off %u, cur_off %zu, "
+			  "iter_read_bytes %zu\n",
+			  page_off, cur_off,
+			  iter_read_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (page_off >= pagevec_count(pvec)) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page out of range: index %u: "
+				  "offset %zu, pagevec_count %u\n",
+				  page_off, cur_off,
+				  pagevec_count(pvec));
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -E2BIG;
+		}
+
+		page = pvec->pages[page_off];
+
+		ssdfs_lock_page(page);
+		err = ssdfs_memcpy_from_page(buf, read_bytes, size,
+					     page, cur_off, PAGE_SIZE,
+					     iter_read_bytes);
+		ssdfs_unlock_page(page);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: "
+				  "read_bytes %zu, offset %zu, "
+				  "iter_read_bytes %zu, err %d\n",
+				  read_bytes, cur_off,
+				  iter_read_bytes, err);
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		read_bytes += iter_read_bytes;
+	} while (read_bytes < size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("BUF DUMP\n");
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     buf, size);
+	SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+int ssdfs_unaligned_write_pagevec(struct pagevec *pvec,
+				  u32 offset, u32 size,
+				  void *buf)
+{
+	struct page *page;
+	u32 page_off;
+	u32 bytes_off;
+	size_t written_bytes = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pvec || !buf);
+
+	SSDFS_DBG("pvec %p, offset %u, size %u, buf %p\n",
+		  pvec, offset, size, buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	do {
+		size_t iter_write_bytes;
+		size_t cur_off;
+
+		bytes_off = offset + written_bytes;
+		page_off = bytes_off / PAGE_SIZE;
+		cur_off = bytes_off % PAGE_SIZE;
+
+		iter_write_bytes = min_t(size_t,
+					(size_t)(size - written_bytes),
+					(size_t)(PAGE_SIZE - cur_off));
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("bytes_off %u, page_off %u, "
+			  "cur_off %zu, written_bytes %zu, "
+			  "iter_write_bytes %zu\n",
+			  bytes_off, page_off, cur_off,
+			  written_bytes, iter_write_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (page_off >= pagevec_count(pvec)) {
+			SSDFS_ERR("invalid page index %u: "
+				  "offset %zu, pagevec_count %u\n",
+				  page_off, cur_off,
+				  pagevec_count(pvec));
+			return -EINVAL;
+		}
+
+		page = pvec->pages[page_off];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+		WARN_ON(!PageLocked(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_memcpy_to_page(page, cur_off, PAGE_SIZE,
+					   buf, written_bytes, size,
+					   iter_write_bytes);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: "
+				  "written_bytes %zu, offset %zu, "
+				  "iter_write_bytes %zu, err %d\n",
+				  written_bytes, cur_off,
+				  iter_write_bytes, err);
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		written_bytes += iter_write_bytes;
+	} while (written_bytes < size);
+
+	return 0;
+}
diff --git a/fs/ssdfs/super.c b/fs/ssdfs/super.c
new file mode 100644
index 000000000000..a3b144e6eafb
--- /dev/null
+++ b/fs/ssdfs/super.c
@@ -0,0 +1,1844 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/super.c - module and superblock management.
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
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/super.h>
+#include <linux/exportfs.h>
+#include <linux/pagevec.h>
+#include <linux/blkdev.h>
+#include <linux/backing-dev.h>
+#include <linux/delay.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "version.h"
+#include "segment_bitmap.h"
+#include "offset_translation_table.h"
+#include "page_array.h"
+#include "page_vector.h"
+#include "peb_container.h"
+#include "segment.h"
+#include "segment_tree.h"
+#include "current_segment.h"
+#include "peb_mapping_table.h"
+#include "extents_queue.h"
+#include "btree_search.h"
+#include "btree_node.h"
+#include "btree.h"
+#include "inodes_tree.h"
+#include "shared_extents_tree.h"
+#include "shared_dictionary.h"
+#include "extents_tree.h"
+#include "dentries_tree.h"
+#include "xattr_tree.h"
+#include "xattr.h"
+#include "acl.h"
+#include "snapshots_tree.h"
+#include "invalidated_extents_tree.h"
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/ssdfs.h>
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_allocated_pages;
+atomic64_t ssdfs_memory_leaks;
+atomic64_t ssdfs_super_page_leaks;
+atomic64_t ssdfs_super_memory_leaks;
+atomic64_t ssdfs_super_cache_leaks;
+
+atomic64_t ssdfs_locked_pages;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_super_cache_leaks_increment(void *kaddr)
+ * void ssdfs_super_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_super_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_super_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_super_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_super_kfree(void *kaddr)
+ * struct page *ssdfs_super_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_super_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_super_free_page(struct page *page)
+ * void ssdfs_super_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(super)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(super)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_super_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_super_page_leaks, 0);
+	atomic64_set(&ssdfs_super_memory_leaks, 0);
+	atomic64_set(&ssdfs_super_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_super_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_super_page_leaks) != 0) {
+		SSDFS_ERR("SUPER: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_super_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_super_memory_leaks) != 0) {
+		SSDFS_ERR("SUPER: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_super_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_super_cache_leaks) != 0) {
+		SSDFS_ERR("SUPER: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_super_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static void init_once(void *foo)
+{
+	struct ssdfs_inode_info *ii = (struct ssdfs_inode_info *)foo;
+
+	inode_init_once(&ii->vfs_inode);
+}
+
+/*
+ * This method is called by inode_alloc() to allocate memory
+ * for struct inode and initialize it
+ */
+struct inode *ssdfs_alloc_inode(struct super_block *sb)
+{
+	struct ssdfs_inode_info *ii;
+
+	ii = alloc_inode_sb(sb, ssdfs_inode_cachep, GFP_KERNEL);
+	if (!ii)
+		return NULL;
+
+	ssdfs_super_cache_leaks_increment(ii);
+
+	init_once((void *)ii);
+
+	atomic_set(&ii->private_flags, 0);
+	init_rwsem(&ii->lock);
+	ii->parent_ino = U64_MAX;
+	ii->flags = 0;
+	ii->name_hash = 0;
+	ii->name_len = 0;
+	ii->extents_tree = NULL;
+	ii->dentries_tree = NULL;
+	ii->xattrs_tree = NULL;
+	ii->inline_file = NULL;
+	memset(&ii->raw_inode, 0, sizeof(struct ssdfs_inode));
+
+	return &ii->vfs_inode;
+}
+
+static void ssdfs_i_callback(struct rcu_head *head)
+{
+	struct inode *inode = container_of(head, struct inode, i_rcu);
+	struct ssdfs_inode_info *ii = SSDFS_I(inode);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu\n", inode->i_ino);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (ii->extents_tree)
+		ssdfs_extents_tree_destroy(ii);
+
+	if (ii->dentries_tree)
+		ssdfs_dentries_tree_destroy(ii);
+
+	if (ii->xattrs_tree)
+		ssdfs_xattrs_tree_destroy(ii);
+
+	if (ii->inline_file)
+		ssdfs_destroy_inline_file_buffer(inode);
+
+	ssdfs_super_cache_leaks_decrement(ii);
+	kmem_cache_free(ssdfs_inode_cachep, ii);
+}
+
+/*
+ * This method is called by destroy_inode() to release
+ * resources allocated for struct inode
+ */
+static void ssdfs_destroy_inode(struct inode *inode)
+{
+	call_rcu(&inode->i_rcu, ssdfs_i_callback);
+}
+
+static void ssdfs_init_inode_once(void *obj)
+{
+	struct ssdfs_inode_info *ii = obj;
+	inode_init_once(&ii->vfs_inode);
+}
+
+static int ssdfs_remount_fs(struct super_block *sb, int *flags, char *data)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	struct ssdfs_peb_extent last_sb_log = {0};
+	struct ssdfs_sb_log_payload payload;
+	unsigned long old_sb_flags;
+	unsigned long old_mount_opts;
+	int err;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("sb %p, flags %#x, data %p\n", sb, *flags, data);
+#else
+	SSDFS_DBG("sb %p, flags %#x, data %p\n", sb, *flags, data);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	old_sb_flags = sb->s_flags;
+	old_mount_opts = fsi->mount_opts;
+
+	pagevec_init(&payload.maptbl_cache.pvec);
+
+	err = ssdfs_parse_options(fsi, data);
+	if (err)
+		goto restore_opts;
+
+	set_posix_acl_flag(sb);
+
+	if ((*flags & SB_RDONLY) == (sb->s_flags & SB_RDONLY))
+		goto out;
+
+	if (*flags & SB_RDONLY) {
+		down_write(&fsi->volume_sem);
+
+		err = ssdfs_prepare_sb_log(sb, &last_sb_log);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare sb log: err %d\n",
+				  err);
+		}
+
+		err = ssdfs_snapshot_sb_log_payload(sb, &payload);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to snapshot sb log's payload: err %d\n",
+				  err);
+		}
+
+		if (!err) {
+			err = ssdfs_commit_super(sb, SSDFS_VALID_FS,
+						 &last_sb_log,
+						 &payload);
+		} else {
+			SSDFS_ERR("fail to prepare sb log payload: "
+				  "err %d\n", err);
+		}
+
+		up_write(&fsi->volume_sem);
+
+		if (err)
+			SSDFS_ERR("fail to commit superblock info\n");
+
+		sb->s_flags |= SB_RDONLY;
+		SSDFS_DBG("remount in RO mode\n");
+	} else {
+		down_write(&fsi->volume_sem);
+
+		err = ssdfs_prepare_sb_log(sb, &last_sb_log);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare sb log: err %d\n",
+				  err);
+		}
+
+		err = ssdfs_snapshot_sb_log_payload(sb, &payload);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to snapshot sb log's payload: err %d\n",
+				  err);
+		}
+
+		if (!err) {
+			err = ssdfs_commit_super(sb, SSDFS_MOUNTED_FS,
+						 &last_sb_log,
+						 &payload);
+		} else {
+			SSDFS_ERR("fail to prepare sb log payload: "
+				  "err %d\n", err);
+		}
+
+		up_write(&fsi->volume_sem);
+
+		if (err) {
+			SSDFS_NOTICE("fail to commit superblock info\n");
+			goto restore_opts;
+		}
+
+		sb->s_flags &= ~SB_RDONLY;
+		SSDFS_DBG("remount in RW mode\n");
+	}
+out:
+	ssdfs_super_pagevec_release(&payload.maptbl_cache.pvec);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+
+restore_opts:
+	sb->s_flags = old_sb_flags;
+	fsi->mount_opts = old_mount_opts;
+	ssdfs_super_pagevec_release(&payload.maptbl_cache.pvec);
+	return err;
+}
+
+static inline
+bool unfinished_user_data_requests_exist(struct ssdfs_fs_info *fsi)
+{
+	u64 flush_requests = 0;
+
+	spin_lock(&fsi->volume_state_lock);
+	flush_requests = fsi->flushing_user_data_requests;
+	spin_unlock(&fsi->volume_state_lock);
+
+	return flush_requests > 0;
+}
+
+static int ssdfs_sync_fs(struct super_block *sb, int wait)
+{
+	struct ssdfs_fs_info *fsi;
+	int err = 0;
+
+	fsi = SSDFS_FS_I(sb);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("sb %p\n", sb);
+#else
+	SSDFS_DBG("sb %p\n", sb);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+#ifdef CONFIG_SSDFS_SHOW_CONSUMED_MEMORY
+	SSDFS_ERR("SYNCFS is starting...\n");
+	ssdfs_check_memory_leaks();
+#endif /* CONFIG_SSDFS_SHOW_CONSUMED_MEMORY */
+
+	atomic_set(&fsi->global_fs_state, SSDFS_METADATA_GOING_FLUSHING);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("SSDFS_METADATA_GOING_FLUSHING\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	wake_up_all(&fsi->pending_wq);
+
+	if (unfinished_user_data_requests_exist(fsi)) {
+		wait_queue_head_t *wq = &fsi->finish_user_data_flush_wq;
+
+		err = wait_event_killable_timeout(*wq,
+				!unfinished_user_data_requests_exist(fsi),
+				SSDFS_DEFAULT_TIMEOUT);
+		if (err < 0)
+			WARN_ON(err < 0);
+		else
+			err = 0;
+
+		if (unfinished_user_data_requests_exist(fsi))
+			BUG();
+	}
+
+	atomic_set(&fsi->global_fs_state, SSDFS_METADATA_UNDER_FLUSH);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("SSDFS_METADATA_UNDER_FLUSH\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&fsi->volume_sem);
+
+	if (fsi->fs_feature_compat &
+			SSDFS_HAS_INVALID_EXTENTS_TREE_COMPAT_FLAG) {
+		err = ssdfs_invextree_flush(fsi);
+		if (err) {
+			SSDFS_ERR("fail to flush invalidated extents btree: "
+				  "err %d\n", err);
+		}
+	}
+
+	if (fsi->fs_feature_compat & SSDFS_HAS_SHARED_EXTENTS_COMPAT_FLAG) {
+		err = ssdfs_shextree_flush(fsi);
+		if (err) {
+			SSDFS_ERR("fail to flush shared extents btree: "
+				  "err %d\n", err);
+		}
+	}
+
+	if (fsi->fs_feature_compat & SSDFS_HAS_INODES_TREE_COMPAT_FLAG) {
+		err = ssdfs_inodes_btree_flush(fsi->inodes_tree);
+		if (err) {
+			SSDFS_ERR("fail to flush inodes btree: "
+				  "err %d\n", err);
+		}
+	}
+
+	if (fsi->fs_feature_compat & SSDFS_HAS_SHARED_DICT_COMPAT_FLAG) {
+		err = ssdfs_shared_dict_btree_flush(fsi->shdictree);
+		if (err) {
+			SSDFS_ERR("fail to flush shared dictionary: "
+				  "err %d\n", err);
+		}
+	}
+
+	err = ssdfs_execute_create_snapshots(fsi);
+	if (err) {
+		SSDFS_ERR("fail to process the snapshots creation\n");
+	}
+
+	if (fsi->fs_feature_compat & SSDFS_HAS_SNAPSHOTS_TREE_COMPAT_FLAG) {
+		err = ssdfs_snapshots_btree_flush(fsi);
+		if (err) {
+			SSDFS_ERR("fail to flush snapshots btree: "
+				  "err %d\n", err);
+		}
+	}
+
+	if (fsi->fs_feature_compat & SSDFS_HAS_SEGBMAP_COMPAT_FLAG) {
+		err = ssdfs_segbmap_flush(fsi->segbmap);
+		if (err) {
+			SSDFS_ERR("fail to flush segment bitmap: "
+				  "err %d\n", err);
+		}
+	}
+
+	if (fsi->fs_feature_compat & SSDFS_HAS_MAPTBL_COMPAT_FLAG) {
+		err = ssdfs_maptbl_flush(fsi->maptbl);
+		if (err) {
+			SSDFS_ERR("fail to flush mapping table: "
+				  "err %d\n", err);
+		}
+	}
+
+	up_write(&fsi->volume_sem);
+
+	atomic_set(&fsi->global_fs_state, SSDFS_REGULAR_FS_OPERATIONS);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("SSDFS_REGULAR_FS_OPERATIONS\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_SHOW_CONSUMED_MEMORY
+	SSDFS_ERR("SYNCFS has been finished...\n");
+	ssdfs_check_memory_leaks();
+#endif /* CONFIG_SSDFS_SHOW_CONSUMED_MEMORY */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (unlikely(err))
+		goto fail_sync_fs;
+
+	trace_ssdfs_sync_fs(sb, wait);
+
+	return 0;
+
+fail_sync_fs:
+	trace_ssdfs_sync_fs_exit(sb, wait, err);
+	return err;
+}
+
+static struct inode *ssdfs_nfs_get_inode(struct super_block *sb,
+					 u64 ino, u32 generation)
+{
+	struct inode *inode;
+
+	if (ino < SSDFS_ROOT_INO)
+		return ERR_PTR(-ESTALE);
+
+	inode = ssdfs_iget(sb, ino);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+	if (generation && inode->i_generation != generation) {
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
+	return inode;
+}
+
+static struct dentry *ssdfs_fh_to_dentry(struct super_block *sb,
+					 struct fid *fid,
+					 int fh_len, int fh_type)
+{
+	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
+				    ssdfs_nfs_get_inode);
+}
+
+static struct dentry *ssdfs_fh_to_parent(struct super_block *sb,
+					 struct fid *fid,
+					 int fh_len, int fh_type)
+{
+	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
+				    ssdfs_nfs_get_inode);
+}
+
+static struct dentry *ssdfs_get_parent(struct dentry *child)
+{
+	struct qstr dotdot = QSTR_INIT("..", 2);
+	ino_t ino;
+	int err;
+
+	err = ssdfs_inode_by_name(d_inode(child), &dotdot, &ino);
+	if (unlikely(err))
+		return ERR_PTR(err);
+
+	return d_obtain_alias(ssdfs_iget(child->d_sb, ino));
+}
+
+static const struct export_operations ssdfs_export_ops = {
+	.get_parent	= ssdfs_get_parent,
+	.fh_to_dentry	= ssdfs_fh_to_dentry,
+	.fh_to_parent	= ssdfs_fh_to_parent,
+};
+
+static const struct super_operations ssdfs_super_operations = {
+	.alloc_inode	= ssdfs_alloc_inode,
+	.destroy_inode	= ssdfs_destroy_inode,
+	.evict_inode	= ssdfs_evict_inode,
+	.write_inode	= ssdfs_write_inode,
+	.statfs		= ssdfs_statfs,
+	.show_options	= ssdfs_show_options,
+	.put_super	= ssdfs_put_super,
+	.remount_fs	= ssdfs_remount_fs,
+	.sync_fs	= ssdfs_sync_fs,
+};
+
+static void ssdfs_memory_page_locks_checker_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_locked_pages, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static void ssdfs_check_memory_page_locks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_locked_pages) != 0) {
+		SSDFS_WARN("Lock keeps %lld memory pages\n",
+			   atomic64_read(&ssdfs_locked_pages));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static void ssdfs_memory_leaks_checker_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_allocated_pages, 0);
+	atomic64_set(&ssdfs_memory_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+#ifdef CONFIG_SSDFS_POSIX_ACL
+	ssdfs_acl_memory_leaks_init();
+#endif /* CONFIG_SSDFS_POSIX_ACL */
+
+	ssdfs_block_bmap_memory_leaks_init();
+	ssdfs_btree_memory_leaks_init();
+	ssdfs_btree_hierarchy_memory_leaks_init();
+	ssdfs_btree_node_memory_leaks_init();
+	ssdfs_btree_search_memory_leaks_init();
+
+#ifdef CONFIG_SSDFS_ZLIB
+	ssdfs_zlib_memory_leaks_init();
+#endif /* CONFIG_SSDFS_ZLIB */
+
+#ifdef CONFIG_SSDFS_LZO
+	ssdfs_lzo_memory_leaks_init();
+#endif /* CONFIG_SSDFS_LZO */
+
+	ssdfs_compr_memory_leaks_init();
+	ssdfs_cur_seg_memory_leaks_init();
+	ssdfs_dentries_memory_leaks_init();
+
+#ifdef CONFIG_SSDFS_MTD_DEVICE
+	ssdfs_dev_mtd_memory_leaks_init();
+#elif defined(CONFIG_SSDFS_BLOCK_DEVICE)
+	ssdfs_dev_bdev_memory_leaks_init();
+	ssdfs_dev_zns_memory_leaks_init();
+#else
+	BUILD_BUG();
+#endif
+
+	ssdfs_dir_memory_leaks_init();
+
+#ifdef CONFIG_SSDFS_DIFF_ON_WRITE_USER_DATA
+	ssdfs_diff_memory_leaks_init();
+#endif /* CONFIG_SSDFS_DIFF_ON_WRITE_USER_DATA */
+
+	ssdfs_ext_queue_memory_leaks_init();
+	ssdfs_ext_tree_memory_leaks_init();
+	ssdfs_file_memory_leaks_init();
+	ssdfs_fs_error_memory_leaks_init();
+	ssdfs_inode_memory_leaks_init();
+	ssdfs_ino_tree_memory_leaks_init();
+	ssdfs_invext_tree_memory_leaks_init();
+	ssdfs_blk2off_memory_leaks_init();
+	ssdfs_parray_memory_leaks_init();
+	ssdfs_page_vector_memory_leaks_init();
+	ssdfs_flush_memory_leaks_init();
+	ssdfs_gc_memory_leaks_init();
+	ssdfs_map_queue_memory_leaks_init();
+	ssdfs_map_tbl_memory_leaks_init();
+	ssdfs_map_cache_memory_leaks_init();
+	ssdfs_map_thread_memory_leaks_init();
+	ssdfs_migration_memory_leaks_init();
+	ssdfs_peb_memory_leaks_init();
+	ssdfs_read_memory_leaks_init();
+	ssdfs_recovery_memory_leaks_init();
+	ssdfs_req_queue_memory_leaks_init();
+	ssdfs_seg_obj_memory_leaks_init();
+	ssdfs_seg_bmap_memory_leaks_init();
+	ssdfs_seg_blk_memory_leaks_init();
+	ssdfs_seg_tree_memory_leaks_init();
+	ssdfs_seq_arr_memory_leaks_init();
+	ssdfs_dict_memory_leaks_init();
+	ssdfs_shextree_memory_leaks_init();
+	ssdfs_super_memory_leaks_init();
+	ssdfs_xattr_memory_leaks_init();
+	ssdfs_snap_reqs_queue_memory_leaks_init();
+	ssdfs_snap_rules_list_memory_leaks_init();
+	ssdfs_snap_tree_memory_leaks_init();
+}
+
+static void ssdfs_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_POSIX_ACL
+	ssdfs_acl_check_memory_leaks();
+#endif /* CONFIG_SSDFS_POSIX_ACL */
+
+	ssdfs_block_bmap_check_memory_leaks();
+	ssdfs_btree_check_memory_leaks();
+	ssdfs_btree_hierarchy_check_memory_leaks();
+	ssdfs_btree_node_check_memory_leaks();
+	ssdfs_btree_search_check_memory_leaks();
+
+#ifdef CONFIG_SSDFS_ZLIB
+	ssdfs_zlib_check_memory_leaks();
+#endif /* CONFIG_SSDFS_ZLIB */
+
+#ifdef CONFIG_SSDFS_LZO
+	ssdfs_lzo_check_memory_leaks();
+#endif /* CONFIG_SSDFS_LZO */
+
+	ssdfs_compr_check_memory_leaks();
+	ssdfs_cur_seg_check_memory_leaks();
+	ssdfs_dentries_check_memory_leaks();
+
+#ifdef CONFIG_SSDFS_MTD_DEVICE
+	ssdfs_dev_mtd_check_memory_leaks();
+#elif defined(CONFIG_SSDFS_BLOCK_DEVICE)
+	ssdfs_dev_bdev_check_memory_leaks();
+	ssdfs_dev_zns_check_memory_leaks();
+#else
+	BUILD_BUG();
+#endif
+
+	ssdfs_dir_check_memory_leaks();
+
+#ifdef CONFIG_SSDFS_DIFF_ON_WRITE_USER_DATA
+	ssdfs_diff_check_memory_leaks();
+#endif /* CONFIG_SSDFS_DIFF_ON_WRITE_USER_DATA */
+
+	ssdfs_ext_queue_check_memory_leaks();
+	ssdfs_ext_tree_check_memory_leaks();
+	ssdfs_file_check_memory_leaks();
+	ssdfs_fs_error_check_memory_leaks();
+	ssdfs_inode_check_memory_leaks();
+	ssdfs_ino_tree_check_memory_leaks();
+	ssdfs_invext_tree_check_memory_leaks();
+	ssdfs_blk2off_check_memory_leaks();
+	ssdfs_parray_check_memory_leaks();
+	ssdfs_page_vector_check_memory_leaks();
+	ssdfs_flush_check_memory_leaks();
+	ssdfs_gc_check_memory_leaks();
+	ssdfs_map_queue_check_memory_leaks();
+	ssdfs_map_tbl_check_memory_leaks();
+	ssdfs_map_cache_check_memory_leaks();
+	ssdfs_map_thread_check_memory_leaks();
+	ssdfs_migration_check_memory_leaks();
+	ssdfs_peb_check_memory_leaks();
+	ssdfs_read_check_memory_leaks();
+	ssdfs_recovery_check_memory_leaks();
+	ssdfs_req_queue_check_memory_leaks();
+	ssdfs_seg_obj_check_memory_leaks();
+	ssdfs_seg_bmap_check_memory_leaks();
+	ssdfs_seg_blk_check_memory_leaks();
+	ssdfs_seg_tree_check_memory_leaks();
+	ssdfs_seq_arr_check_memory_leaks();
+	ssdfs_dict_check_memory_leaks();
+	ssdfs_shextree_check_memory_leaks();
+	ssdfs_super_check_memory_leaks();
+	ssdfs_xattr_check_memory_leaks();
+	ssdfs_snap_reqs_queue_check_memory_leaks();
+	ssdfs_snap_rules_list_check_memory_leaks();
+	ssdfs_snap_tree_check_memory_leaks();
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+#ifdef CONFIG_SSDFS_SHOW_CONSUMED_MEMORY
+	if (atomic64_read(&ssdfs_allocated_pages) != 0) {
+		SSDFS_ERR("Memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_allocated_pages));
+	}
+
+	if (atomic64_read(&ssdfs_memory_leaks) != 0) {
+		SSDFS_ERR("Memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_memory_leaks));
+	}
+#else
+	if (atomic64_read(&ssdfs_allocated_pages) != 0) {
+		SSDFS_WARN("Memory leaks include %lld pages\n",
+			   atomic64_read(&ssdfs_allocated_pages));
+	}
+
+	if (atomic64_read(&ssdfs_memory_leaks) != 0) {
+		SSDFS_WARN("Memory allocator suffers from %lld leaks\n",
+			   atomic64_read(&ssdfs_memory_leaks));
+	}
+#endif /* CONFIG_SSDFS_SHOW_CONSUMED_MEMORY */
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static int ssdfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct ssdfs_fs_info *fs_info;
+	struct ssdfs_peb_extent last_sb_log = {0};
+	struct ssdfs_sb_log_payload payload;
+	struct inode *root_i;
+	u64 fs_feature_compat;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("sb %p, data %p, silent %#x\n", sb, data, silent);
+#else
+	SSDFS_DBG("sb %p, data %p, silent %#x\n", sb, data, silent);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("segment header size %zu, "
+		  "partial log header size %zu, "
+		  "footer size %zu\n",
+		  sizeof(struct ssdfs_segment_header),
+		  sizeof(struct ssdfs_partial_log_header),
+		  sizeof(struct ssdfs_log_footer));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_memory_page_locks_checker_init();
+	ssdfs_memory_leaks_checker_init();
+
+	fs_info = ssdfs_super_kzalloc(sizeof(*fs_info), GFP_KERNEL);
+	if (!fs_info)
+		return -ENOMEM;
+
+#ifdef CONFIG_SSDFS_TESTING
+	fs_info->do_fork_invalidation = true;
+#endif /* CONFIG_SSDFS_TESTING */
+
+	fs_info->max_open_zones = 0;
+	fs_info->is_zns_device = false;
+	fs_info->zone_size = U64_MAX;
+	fs_info->zone_capacity = U64_MAX;
+	atomic_set(&fs_info->open_zones, 0);
+
+#ifdef CONFIG_SSDFS_MTD_DEVICE
+	fs_info->mtd = sb->s_mtd;
+	fs_info->devops = &ssdfs_mtd_devops;
+	sb->s_bdi = sb->s_mtd->backing_dev_info;
+#elif defined(CONFIG_SSDFS_BLOCK_DEVICE)
+	if (bdev_is_zoned(sb->s_bdev)) {
+		fs_info->devops = &ssdfs_zns_devops;
+		fs_info->is_zns_device = true;
+		fs_info->max_open_zones = bdev_max_open_zones(sb->s_bdev);
+
+		fs_info->zone_size = ssdfs_zns_zone_size(sb,
+						SSDFS_RESERVED_VBR_SIZE);
+		if (fs_info->zone_size >= U64_MAX) {
+			SSDFS_ERR("fail to get zone size\n");
+			return -ERANGE;
+		}
+
+		fs_info->zone_capacity = ssdfs_zns_zone_capacity(sb,
+						SSDFS_RESERVED_VBR_SIZE);
+		if (fs_info->zone_capacity >= U64_MAX) {
+			SSDFS_ERR("fail to get zone capacity\n");
+			return -ERANGE;
+		} else if (fs_info->zone_capacity > fs_info->zone_size) {
+			SSDFS_ERR("invalid zone capacity: "
+				  "capacity %llu, size %llu\n",
+				  fs_info->zone_capacity,
+				  fs_info->zone_size);
+			return -ERANGE;
+		}
+	} else
+		fs_info->devops = &ssdfs_bdev_devops;
+
+	sb->s_bdi = bdi_get(sb->s_bdev->bd_disk->bdi);
+	atomic_set(&fs_info->pending_bios, 0);
+	fs_info->erase_page = ssdfs_super_alloc_page(GFP_KERNEL);
+	if (IS_ERR_OR_NULL(fs_info->erase_page)) {
+		err = (fs_info->erase_page == NULL ?
+				-ENOMEM : PTR_ERR(fs_info->erase_page));
+		SSDFS_ERR("unable to allocate memory page\n");
+		goto free_erase_page;
+	}
+	memset(page_address(fs_info->erase_page), 0xFF, PAGE_SIZE);
+#else
+	BUILD_BUG();
+#endif
+
+	fs_info->sb = sb;
+	sb->s_fs_info = fs_info;
+	atomic64_set(&fs_info->flush_reqs, 0);
+	init_waitqueue_head(&fs_info->pending_wq);
+	init_waitqueue_head(&fs_info->finish_user_data_flush_wq);
+	atomic_set(&fs_info->global_fs_state, SSDFS_UNKNOWN_GLOBAL_FS_STATE);
+
+	for (i = 0; i < SSDFS_GC_THREAD_TYPE_MAX; i++) {
+		init_waitqueue_head(&fs_info->gc_wait_queue[i]);
+		atomic_set(&fs_info->gc_should_act[i], 1);
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("parse options started...\n");
+#else
+	SSDFS_DBG("parse options started...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	err = ssdfs_parse_options(fs_info, data);
+	if (err)
+		goto free_erase_page;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("gather superblock info started...\n");
+#else
+	SSDFS_DBG("gather superblock info started...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	err = ssdfs_gather_superblock_info(fs_info, silent);
+	if (err)
+		goto free_erase_page;
+
+	spin_lock(&fs_info->volume_state_lock);
+	fs_feature_compat = fs_info->fs_feature_compat;
+	spin_unlock(&fs_info->volume_state_lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("create device group started...\n");
+#else
+	SSDFS_DBG("create device group started...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	err = ssdfs_sysfs_create_device_group(sb);
+	if (err)
+		goto release_maptbl_cache;
+
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_magic = SSDFS_SUPER_MAGIC;
+	sb->s_op = &ssdfs_super_operations;
+	sb->s_export_op = &ssdfs_export_ops;
+
+	sb->s_xattr = ssdfs_xattr_handlers;
+	set_posix_acl_flag(sb);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("create snapshots subsystem started...\n");
+#else
+	SSDFS_DBG("create snapshots subsystem started...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	err = ssdfs_snapshot_subsystem_init(fs_info);
+	if (err == -EINTR) {
+		/*
+		 * Ignore this error.
+		 */
+		err = 0;
+		goto destroy_sysfs_device_group;
+	} else if (err)
+		goto destroy_sysfs_device_group;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("create segment tree started...\n");
+#else
+	SSDFS_DBG("create segment tree started...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	down_write(&fs_info->volume_sem);
+	err = ssdfs_segment_tree_create(fs_info);
+	up_write(&fs_info->volume_sem);
+	if (err)
+		goto destroy_snapshot_subsystem;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("create mapping table started...\n");
+#else
+	SSDFS_DBG("create mapping table started...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (fs_feature_compat & SSDFS_HAS_MAPTBL_COMPAT_FLAG) {
+		down_write(&fs_info->volume_sem);
+		err = ssdfs_maptbl_create(fs_info);
+		up_write(&fs_info->volume_sem);
+
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+			err = 0;
+			goto destroy_segments_tree;
+		} else if (err)
+			goto destroy_segments_tree;
+	} else {
+		err = -EIO;
+		SSDFS_WARN("volume hasn't mapping table\n");
+		goto destroy_segments_tree;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("create segment bitmap started...\n");
+#else
+	SSDFS_DBG("create segment bitmap started...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (fs_feature_compat & SSDFS_HAS_SEGBMAP_COMPAT_FLAG) {
+		down_write(&fs_info->volume_sem);
+		err = ssdfs_segbmap_create(fs_info);
+		up_write(&fs_info->volume_sem);
+
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+			err = 0;
+			goto destroy_maptbl;
+		} else if (err)
+			goto destroy_maptbl;
+	} else {
+		err = -EIO;
+		SSDFS_WARN("volume hasn't segment bitmap\n");
+		goto destroy_maptbl;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("create shared extents tree started...\n");
+#else
+	SSDFS_DBG("create shared extents tree started...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (fs_info->fs_feature_compat & SSDFS_HAS_SHARED_EXTENTS_COMPAT_FLAG) {
+		down_write(&fs_info->volume_sem);
+		err = ssdfs_shextree_create(fs_info);
+		up_write(&fs_info->volume_sem);
+		if (err)
+			goto destroy_segbmap;
+	} else {
+		err = -EIO;
+		SSDFS_WARN("volume hasn't shared extents tree\n");
+		goto destroy_segbmap;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("create invalidated extents btree started...\n");
+#else
+	SSDFS_DBG("create invalidated extents btree started...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (fs_feature_compat & SSDFS_HAS_INVALID_EXTENTS_TREE_COMPAT_FLAG) {
+		down_write(&fs_info->volume_sem);
+		err = ssdfs_invextree_create(fs_info);
+		up_write(&fs_info->volume_sem);
+		if (err)
+			goto destroy_shextree;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("create current segment array started...\n");
+#else
+	SSDFS_DBG("create current segment array started...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	down_write(&fs_info->volume_sem);
+	err = ssdfs_current_segment_array_create(fs_info);
+	up_write(&fs_info->volume_sem);
+	if (err)
+		goto destroy_invext_btree;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("create shared dictionary started...\n");
+#else
+	SSDFS_DBG("create shared dictionary started...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (fs_feature_compat & SSDFS_HAS_SHARED_DICT_COMPAT_FLAG) {
+		down_write(&fs_info->volume_sem);
+
+		err = ssdfs_shared_dict_btree_create(fs_info);
+		if (err) {
+			up_write(&fs_info->volume_sem);
+			goto destroy_current_segment_array;
+		}
+
+		err = ssdfs_shared_dict_btree_init(fs_info);
+		if (err) {
+			up_write(&fs_info->volume_sem);
+			goto destroy_shdictree;
+		}
+
+		up_write(&fs_info->volume_sem);
+	} else {
+		err = -EIO;
+		SSDFS_WARN("volume hasn't shared dictionary\n");
+		goto destroy_current_segment_array;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("create inodes btree started...\n");
+#else
+	SSDFS_DBG("create inodes btree started...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (fs_feature_compat & SSDFS_HAS_INODES_TREE_COMPAT_FLAG) {
+		down_write(&fs_info->volume_sem);
+		err = ssdfs_inodes_btree_create(fs_info);
+		up_write(&fs_info->volume_sem);
+		if (err)
+			goto destroy_shdictree;
+	} else {
+		err = -EIO;
+		SSDFS_WARN("volume hasn't inodes btree\n");
+		goto destroy_shdictree;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("getting root inode...\n");
+#else
+	SSDFS_DBG("getting root inode...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	root_i = ssdfs_iget(sb, SSDFS_ROOT_INO);
+	if (IS_ERR(root_i)) {
+		SSDFS_DBG("getting root inode failed\n");
+		err = PTR_ERR(root_i);
+		goto destroy_inodes_btree;
+	}
+
+	if (!S_ISDIR(root_i->i_mode) || !root_i->i_blocks || !root_i->i_size) {
+		err = -ERANGE;
+		iput(root_i);
+		SSDFS_ERR("corrupted root inode\n");
+		goto destroy_inodes_btree;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("d_make_root()\n");
+#else
+	SSDFS_DBG("d_make_root()\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	sb->s_root = d_make_root(root_i);
+	if (!sb->s_root) {
+		err = -ENOMEM;
+		goto put_root_inode;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("starting GC threads...\n");
+#else
+	SSDFS_DBG("starting GC threads...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	err = ssdfs_start_gc_thread(fs_info, SSDFS_SEG_USING_GC_THREAD);
+	if (err == -EINTR) {
+		/*
+		 * Ignore this error.
+		 */
+		err = 0;
+		goto put_root_inode;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to start GC-using-seg thread: "
+			  "err %d\n", err);
+		goto put_root_inode;
+	}
+
+	err = ssdfs_start_gc_thread(fs_info, SSDFS_SEG_USED_GC_THREAD);
+	if (err == -EINTR) {
+		/*
+		 * Ignore this error.
+		 */
+		err = 0;
+		goto stop_gc_using_seg_thread;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to start GC-used-seg thread: "
+			  "err %d\n", err);
+		goto stop_gc_using_seg_thread;
+	}
+
+	err = ssdfs_start_gc_thread(fs_info, SSDFS_SEG_PRE_DIRTY_GC_THREAD);
+	if (err == -EINTR) {
+		/*
+		 * Ignore this error.
+		 */
+		err = 0;
+		goto stop_gc_used_seg_thread;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to start GC-pre-dirty-seg thread: "
+			  "err %d\n", err);
+		goto stop_gc_used_seg_thread;
+	}
+
+	err = ssdfs_start_gc_thread(fs_info, SSDFS_SEG_DIRTY_GC_THREAD);
+	if (err == -EINTR) {
+		/*
+		 * Ignore this error.
+		 */
+		err = 0;
+		goto stop_gc_pre_dirty_seg_thread;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to start GC-dirty-seg thread: "
+			  "err %d\n", err);
+		goto stop_gc_pre_dirty_seg_thread;
+	}
+
+	if (!(sb->s_flags & SB_RDONLY)) {
+		pagevec_init(&payload.maptbl_cache.pvec);
+
+		down_write(&fs_info->volume_sem);
+
+		err = ssdfs_prepare_sb_log(sb, &last_sb_log);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare sb log: err %d\n",
+				  err);
+		}
+
+		err = ssdfs_snapshot_sb_log_payload(sb, &payload);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to snapshot sb log's payload: err %d\n",
+				  err);
+		}
+
+		if (!err) {
+			err = ssdfs_commit_super(sb, SSDFS_MOUNTED_FS,
+						 &last_sb_log,
+						 &payload);
+		} else {
+			SSDFS_ERR("fail to prepare sb log payload: "
+				  "err %d\n", err);
+		}
+
+		up_write(&fs_info->volume_sem);
+
+		ssdfs_super_pagevec_release(&payload.maptbl_cache.pvec);
+
+		if (err) {
+			SSDFS_NOTICE("fail to commit superblock info: "
+				     "remount filesystem in RO mode\n");
+			sb->s_flags |= SB_RDONLY;
+		}
+	}
+
+	atomic_set(&fs_info->global_fs_state, SSDFS_REGULAR_FS_OPERATIONS);
+
+	SSDFS_INFO("%s has been mounted on device %s\n",
+		   SSDFS_VERSION, fs_info->devops->device_name(sb));
+
+	return 0;
+
+stop_gc_pre_dirty_seg_thread:
+	ssdfs_stop_gc_thread(fs_info, SSDFS_SEG_PRE_DIRTY_GC_THREAD);
+
+stop_gc_used_seg_thread:
+	ssdfs_stop_gc_thread(fs_info, SSDFS_SEG_USED_GC_THREAD);
+
+stop_gc_using_seg_thread:
+	ssdfs_stop_gc_thread(fs_info, SSDFS_SEG_USING_GC_THREAD);
+
+put_root_inode:
+	iput(root_i);
+
+destroy_inodes_btree:
+	ssdfs_inodes_btree_destroy(fs_info);
+
+destroy_shdictree:
+	ssdfs_shared_dict_btree_destroy(fs_info);
+
+destroy_current_segment_array:
+	ssdfs_destroy_all_curent_segments(fs_info);
+
+destroy_invext_btree:
+	ssdfs_invextree_destroy(fs_info);
+
+destroy_shextree:
+	ssdfs_shextree_destroy(fs_info);
+
+destroy_segbmap:
+	ssdfs_segbmap_destroy(fs_info);
+
+destroy_maptbl:
+	ssdfs_maptbl_stop_thread(fs_info->maptbl);
+	ssdfs_maptbl_destroy(fs_info);
+
+destroy_segments_tree:
+	ssdfs_segment_tree_destroy(fs_info);
+	ssdfs_current_segment_array_destroy(fs_info);
+
+destroy_snapshot_subsystem:
+	ssdfs_snapshot_subsystem_destroy(fs_info);
+
+destroy_sysfs_device_group:
+	ssdfs_sysfs_delete_device_group(fs_info);
+
+release_maptbl_cache:
+	ssdfs_maptbl_cache_destroy(&fs_info->maptbl_cache);
+
+free_erase_page:
+	if (fs_info->erase_page)
+		ssdfs_super_free_page(fs_info->erase_page);
+
+	ssdfs_destruct_sb_info(&fs_info->sbi);
+	ssdfs_destruct_sb_info(&fs_info->sbi_backup);
+
+	ssdfs_free_workspaces();
+
+	ssdfs_super_kfree(fs_info);
+
+	rcu_barrier();
+
+	ssdfs_check_memory_page_locks();
+	ssdfs_check_memory_leaks();
+	return err;
+}
+
+static void ssdfs_put_super(struct super_block *sb)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	struct ssdfs_peb_extent last_sb_log = {0};
+	struct ssdfs_sb_log_payload payload;
+	u64 fs_feature_compat;
+	u16 fs_state;
+	bool can_commit_super = true;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("sb %p\n", sb);
+#else
+	SSDFS_DBG("sb %p\n", sb);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	atomic_set(&fsi->global_fs_state, SSDFS_METADATA_GOING_FLUSHING);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("SSDFS_METADATA_GOING_FLUSHING\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	wake_up_all(&fsi->pending_wq);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("STOP THREADS...\n");
+#else
+	SSDFS_DBG("STOP THREADS...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	err = ssdfs_stop_gc_thread(fsi, SSDFS_SEG_USING_GC_THREAD);
+	if (err) {
+		SSDFS_ERR("fail to stop GC using seg thread: "
+			  "err %d\n", err);
+	}
+
+	err = ssdfs_stop_gc_thread(fsi, SSDFS_SEG_USED_GC_THREAD);
+	if (err) {
+		SSDFS_ERR("fail to stop GC used seg thread: "
+			  "err %d\n", err);
+	}
+
+	err = ssdfs_stop_gc_thread(fsi, SSDFS_SEG_PRE_DIRTY_GC_THREAD);
+	if (err) {
+		SSDFS_ERR("fail to stop GC pre-dirty seg thread: "
+			  "err %d\n", err);
+	}
+
+	err = ssdfs_stop_gc_thread(fsi, SSDFS_SEG_DIRTY_GC_THREAD);
+	if (err) {
+		SSDFS_ERR("fail to stop GC dirty seg thread: "
+			  "err %d\n", err);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("GC threads have been stoped\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_shared_dict_stop_thread(fsi->shdictree);
+	if (err == -EIO) {
+		ssdfs_fs_error(fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"thread I/O issue\n");
+	} else if (unlikely(err)) {
+		SSDFS_WARN("thread stopping issue: err %d\n",
+			   err);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("shared dictionary thread has been stoped\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < SSDFS_INVALIDATION_QUEUE_NUMBER; i++) {
+		err = ssdfs_shextree_stop_thread(fsi->shextree, i);
+		if (err == -EIO) {
+			ssdfs_fs_error(fsi->sb,
+					__FILE__, __func__, __LINE__,
+					"thread I/O issue\n");
+		} else if (unlikely(err)) {
+			SSDFS_WARN("thread stopping issue: ID %d, err %d\n",
+				   i, err);
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("shared extents threads have been stoped\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_stop_snapshots_btree_thread(fsi);
+	if (err == -EIO) {
+		ssdfs_fs_error(fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"thread I/O issue\n");
+	} else if (unlikely(err)) {
+		SSDFS_WARN("thread stopping issue: err %d\n",
+			   err);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("snaphots btree thread has been stoped\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_maptbl_stop_thread(fsi->maptbl);
+	if (unlikely(err)) {
+		SSDFS_WARN("maptbl thread stopping issue: err %d\n",
+			   err);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("mapping table thread has been stoped\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&fsi->volume_state_lock);
+	fs_feature_compat = fsi->fs_feature_compat;
+	fs_state = fsi->fs_state;
+	spin_unlock(&fsi->volume_state_lock);
+
+	pagevec_init(&payload.maptbl_cache.pvec);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("Wait unfinished user data requests...\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unfinished_user_data_requests_exist(fsi)) {
+		wait_queue_head_t *wq = &fsi->finish_user_data_flush_wq;
+
+		err = wait_event_killable_timeout(*wq,
+				!unfinished_user_data_requests_exist(fsi),
+				SSDFS_DEFAULT_TIMEOUT);
+		if (err < 0)
+			WARN_ON(err < 0);
+		else
+			err = 0;
+
+		if (unfinished_user_data_requests_exist(fsi))
+			BUG();
+	}
+
+	atomic_set(&fsi->global_fs_state, SSDFS_METADATA_UNDER_FLUSH);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("SSDFS_METADATA_UNDER_FLUSH\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!(sb->s_flags & SB_RDONLY)) {
+		down_write(&fsi->volume_sem);
+
+		err = ssdfs_prepare_sb_log(sb, &last_sb_log);
+		if (unlikely(err)) {
+			can_commit_super = false;
+			SSDFS_ERR("fail to prepare sb log: err %d\n",
+				  err);
+		}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("Flush invalidated extents b-tree...\n");
+#else
+		SSDFS_DBG("Flush invalidated extents b-tree...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (fsi->fs_feature_compat &
+				SSDFS_HAS_INVALID_EXTENTS_TREE_COMPAT_FLAG) {
+			err = ssdfs_invextree_flush(fsi);
+			if (err) {
+				SSDFS_ERR("fail to flush invalidated extents btree: "
+					  "err %d\n", err);
+			}
+		}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("Flush shared extents b-tree...\n");
+#else
+		SSDFS_DBG("Flush shared extents b-tree...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (fsi->fs_feature_compat &
+				SSDFS_HAS_SHARED_EXTENTS_COMPAT_FLAG) {
+			err = ssdfs_shextree_flush(fsi);
+			if (err) {
+				SSDFS_ERR("fail to flush shared extents btree: "
+					  "err %d\n", err);
+			}
+		}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("Flush inodes b-tree...\n");
+#else
+		SSDFS_DBG("Flush inodes b-tree...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (fs_feature_compat & SSDFS_HAS_INODES_TREE_COMPAT_FLAG) {
+			err = ssdfs_inodes_btree_flush(fsi->inodes_tree);
+			if (err) {
+				SSDFS_ERR("fail to flush inodes btree: "
+					  "err %d\n", err);
+			}
+		}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("Flush shared dictionary b-tree...\n");
+#else
+		SSDFS_DBG("Flush shared dictionary b-tree...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (fs_feature_compat & SSDFS_HAS_SHARED_DICT_COMPAT_FLAG) {
+			err = ssdfs_shared_dict_btree_flush(fsi->shdictree);
+			if (err) {
+				SSDFS_ERR("fail to flush shared dictionary: "
+					  "err %d\n", err);
+			}
+		}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("Execute create snapshots...\n");
+#else
+		SSDFS_DBG("Execute create snapshots...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		err = ssdfs_execute_create_snapshots(fsi);
+		if (err) {
+			SSDFS_ERR("fail to process the snapshots creation\n");
+		}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("Flush snapshots b-tree...\n");
+#else
+		SSDFS_DBG("Flush snapshots b-tree...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (fsi->fs_feature_compat &
+				SSDFS_HAS_SNAPSHOTS_TREE_COMPAT_FLAG) {
+			err = ssdfs_snapshots_btree_flush(fsi);
+			if (err) {
+				SSDFS_ERR("fail to flush snapshots btree: "
+					  "err %d\n", err);
+			}
+		}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("Flush segment bitmap...\n");
+#else
+		SSDFS_DBG("Flush segment bitmap...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (fs_feature_compat & SSDFS_HAS_SEGBMAP_COMPAT_FLAG) {
+			err = ssdfs_segbmap_flush(fsi->segbmap);
+			if (err) {
+				SSDFS_ERR("fail to flush segbmap: "
+					  "err %d\n", err);
+			}
+		}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("Flush PEB mapping table...\n");
+#else
+		SSDFS_DBG("Flush PEB mapping table...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (fs_feature_compat & SSDFS_HAS_MAPTBL_COMPAT_FLAG) {
+			err = ssdfs_maptbl_flush(fsi->maptbl);
+			if (err) {
+				SSDFS_ERR("fail to flush maptbl: "
+					  "err %d\n", err);
+			}
+
+			set_maptbl_going_to_be_destroyed(fsi);
+		}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("Commit superblock...\n");
+#else
+		SSDFS_DBG("Commit superblock...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (can_commit_super) {
+			err = ssdfs_snapshot_sb_log_payload(sb, &payload);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to snapshot log's payload: "
+					  "err %d\n", err);
+			} else {
+				err = ssdfs_commit_super(sb, SSDFS_VALID_FS,
+							 &last_sb_log,
+							 &payload);
+			}
+		} else {
+			/* prepare error code */
+			err = -ERANGE;
+		}
+
+		if (err) {
+			SSDFS_ERR("fail to commit superblock info: "
+				  "err %d\n", err);
+		}
+
+		up_write(&fsi->volume_sem);
+	} else {
+		if (fs_state == SSDFS_ERROR_FS) {
+			down_write(&fsi->volume_sem);
+
+			err = ssdfs_prepare_sb_log(sb, &last_sb_log);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare sb log: err %d\n",
+					  err);
+			}
+
+			err = ssdfs_snapshot_sb_log_payload(sb, &payload);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to snapshot log's payload: "
+					  "err %d\n", err);
+			}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+			SSDFS_ERR("Commit superblock...\n");
+#else
+			SSDFS_DBG("Commit superblock...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+			if (!err) {
+				err = ssdfs_commit_super(sb, SSDFS_ERROR_FS,
+							 &last_sb_log,
+							 &payload);
+			}
+
+			up_write(&fsi->volume_sem);
+
+			if (err) {
+				SSDFS_ERR("fail to commit superblock info: "
+					  "err %d\n", err);
+			}
+		}
+	}
+
+	atomic_set(&fsi->global_fs_state, SSDFS_UNKNOWN_GLOBAL_FS_STATE);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("SSDFS_UNKNOWN_GLOBAL_FS_STATE\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("Starting destroy the metadata structures...\n");
+#else
+	SSDFS_DBG("Starting destroy the metadata structures...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_super_pagevec_release(&payload.maptbl_cache.pvec);
+	fsi->devops->sync(sb);
+	ssdfs_snapshot_subsystem_destroy(fsi);
+	ssdfs_invextree_destroy(fsi);
+	ssdfs_shextree_destroy(fsi);
+	ssdfs_inodes_btree_destroy(fsi);
+	ssdfs_shared_dict_btree_destroy(fsi);
+	ssdfs_segbmap_destroy(fsi);
+	ssdfs_destroy_all_curent_segments(fsi);
+	ssdfs_segment_tree_destroy(fsi);
+	ssdfs_current_segment_array_destroy(fsi);
+	ssdfs_maptbl_destroy(fsi);
+	ssdfs_sysfs_delete_device_group(fsi);
+
+	SSDFS_INFO("%s has been unmounted from device %s\n",
+		   SSDFS_VERSION, fsi->devops->device_name(sb));
+
+	if (fsi->erase_page)
+		ssdfs_super_free_page(fsi->erase_page);
+
+	ssdfs_maptbl_cache_destroy(&fsi->maptbl_cache);
+	ssdfs_destruct_sb_info(&fsi->sbi);
+	ssdfs_destruct_sb_info(&fsi->sbi_backup);
+
+	ssdfs_free_workspaces();
+
+	ssdfs_super_kfree(fsi);
+	sb->s_fs_info = NULL;
+
+	rcu_barrier();
+
+	ssdfs_check_memory_page_locks();
+	ssdfs_check_memory_leaks();
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("All metadata structures have been destroyed...\n");
+#else
+	SSDFS_DBG("All metadata structures have been destroyed...\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+}
+
+static struct dentry *ssdfs_mount(struct file_system_type *fs_type,
+				  int flags, const char *dev_name,
+				  void *data)
+{
+#ifdef CONFIG_SSDFS_MTD_DEVICE
+	return mount_mtd(fs_type, flags, dev_name, data, ssdfs_fill_super);
+#elif defined(CONFIG_SSDFS_BLOCK_DEVICE)
+	return mount_bdev(fs_type, flags, dev_name, data, ssdfs_fill_super);
+#else
+	BUILD_BUG();
+	return NULL;
+#endif
+}
+
+static void kill_ssdfs_sb(struct super_block *sb)
+{
+#ifdef CONFIG_SSDFS_MTD_DEVICE
+	kill_mtd_super(sb);
+#elif defined(CONFIG_SSDFS_BLOCK_DEVICE)
+	kill_block_super(sb);
+#else
+	BUILD_BUG();
+#endif
+}
+
+static struct file_system_type ssdfs_fs_type = {
+	.name		= "ssdfs",
+	.owner		= THIS_MODULE,
+	.mount		= ssdfs_mount,
+	.kill_sb	= kill_ssdfs_sb,
+#ifdef CONFIG_SSDFS_BLOCK_DEVICE
+	.fs_flags	= FS_REQUIRES_DEV,
+#endif
+};
+MODULE_ALIAS_FS(SSDFS_VERSION);
+
+static void ssdfs_destroy_caches(void)
+{
+	/*
+	 * Make sure all delayed rcu free inodes are flushed before we
+	 * destroy cache.
+	 */
+	rcu_barrier();
+
+	if (ssdfs_inode_cachep)
+		kmem_cache_destroy(ssdfs_inode_cachep);
+
+	ssdfs_destroy_seg_req_obj_cache();
+	ssdfs_destroy_btree_search_obj_cache();
+	ssdfs_destroy_free_ino_desc_cache();
+	ssdfs_destroy_btree_node_obj_cache();
+	ssdfs_destroy_seg_obj_cache();
+	ssdfs_destroy_extent_info_cache();
+	ssdfs_destroy_peb_mapping_info_cache();
+	ssdfs_destroy_blk2off_frag_obj_cache();
+	ssdfs_destroy_name_info_cache();
+}
+
+static int ssdfs_init_caches(void)
+{
+	int err;
+
+	ssdfs_zero_seg_obj_cache_ptr();
+	ssdfs_zero_seg_req_obj_cache_ptr();
+	ssdfs_zero_extent_info_cache_ptr();
+	ssdfs_zero_btree_node_obj_cache_ptr();
+	ssdfs_zero_btree_search_obj_cache_ptr();
+	ssdfs_zero_free_ino_desc_cache_ptr();
+	ssdfs_zero_peb_mapping_info_cache_ptr();
+	ssdfs_zero_blk2off_frag_obj_cache_ptr();
+	ssdfs_zero_name_info_cache_ptr();
+
+	ssdfs_inode_cachep = kmem_cache_create("ssdfs_inode_cache",
+					sizeof(struct ssdfs_inode_info), 0,
+					SLAB_RECLAIM_ACCOUNT |
+					SLAB_MEM_SPREAD |
+					SLAB_ACCOUNT,
+					ssdfs_init_inode_once);
+	if (!ssdfs_inode_cachep) {
+		SSDFS_ERR("unable to create inode cache\n");
+		return -ENOMEM;
+	}
+
+	err = ssdfs_init_seg_obj_cache();
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to create segment object cache: err %d\n",
+			  err);
+		goto destroy_caches;
+	}
+
+	err = ssdfs_init_seg_req_obj_cache();
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to create segment request object cache: "
+			  "err %d\n",
+			  err);
+		goto destroy_caches;
+	}
+
+	err = ssdfs_init_extent_info_cache();
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to create extent info object cache: "
+			  "err %d\n",
+			  err);
+		goto destroy_caches;
+	}
+
+	err = ssdfs_init_btree_node_obj_cache();
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to create btree node object cache: err %d\n",
+			  err);
+		goto destroy_caches;
+	}
+
+	err = ssdfs_init_btree_search_obj_cache();
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to create btree search object cache: "
+			  "err %d\n",
+			  err);
+		goto destroy_caches;
+	}
+
+	err = ssdfs_init_free_ino_desc_cache();
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to create free inode descriptors cache: "
+			  "err %d\n",
+			  err);
+		goto destroy_caches;
+	}
+
+	err = ssdfs_init_peb_mapping_info_cache();
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to create PEB mapping descriptors cache: "
+			  "err %d\n",
+			  err);
+		goto destroy_caches;
+	}
+
+	err = ssdfs_init_blk2off_frag_obj_cache();
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to create blk2off fragments cache: "
+			  "err %d\n",
+			  err);
+		goto destroy_caches;
+	}
+
+	err = ssdfs_init_name_info_cache();
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to create name info cache: "
+			  "err %d\n",
+			  err);
+		goto destroy_caches;
+	}
+
+	return 0;
+
+destroy_caches:
+	ssdfs_destroy_caches();
+	return -ENOMEM;
+}
+
+static inline void ssdfs_print_info(void)
+{
+	SSDFS_INFO("%s loaded\n", SSDFS_VERSION);
+}
+
+static int __init ssdfs_init(void)
+{
+	int err;
+
+	err = ssdfs_init_caches();
+	if (err) {
+		SSDFS_ERR("failed to initialize caches\n");
+		goto failed_init;
+	}
+
+	err = ssdfs_compressors_init();
+	if (err) {
+		SSDFS_ERR("failed to initialize compressors\n");
+		goto free_caches;
+	}
+
+	err = ssdfs_sysfs_init();
+	if (err) {
+		SSDFS_ERR("failed to initialize sysfs subsystem\n");
+		goto stop_compressors;
+	}
+
+	err = register_filesystem(&ssdfs_fs_type);
+	if (err) {
+		SSDFS_ERR("failed to register filesystem\n");
+		goto sysfs_exit;
+	}
+
+	ssdfs_print_info();
+
+	return 0;
+
+sysfs_exit:
+	ssdfs_sysfs_exit();
+
+stop_compressors:
+	ssdfs_compressors_exit();
+
+free_caches:
+	ssdfs_destroy_caches();
+
+failed_init:
+	return err;
+}
+
+static void __exit ssdfs_exit(void)
+{
+	ssdfs_destroy_caches();
+	unregister_filesystem(&ssdfs_fs_type);
+	ssdfs_sysfs_exit();
+	ssdfs_compressors_exit();
+}
+
+module_init(ssdfs_init);
+module_exit(ssdfs_exit);
+
+MODULE_DESCRIPTION("SSDFS -- SSD-oriented File System");
+MODULE_AUTHOR("HGST, San Jose Research Center, Storage Architecture Group");
+MODULE_AUTHOR("Viacheslav Dubeyko <slava@dubeyko.com>");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.34.1

