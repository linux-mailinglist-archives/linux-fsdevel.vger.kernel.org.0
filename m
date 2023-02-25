Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C346A2627
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBYBQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBYBQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:00 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4E513516
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:52 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bh20so791135oib.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA13pvpEqCNvK58Lmj9i697NKs6YTsixMcGAJ0be9sk=;
        b=XO7pxqZPQ539oHSD3GMimG9CWfsOzYCciqJ7bY24JYF2A/3aWJZS44V17ghdwK2/S2
         64ojG05WeQrv3AQ0ns0Fff4OCAgDrI28gUjkmjSLLkxWHnkYncfud3IKjiSjN3n5dgdQ
         RaGDde/D36Nx3wPhFiZxgMFyNRxZvfwUbzhSXAOALXafu1skjWJRbQjbSU8kBTzcD64x
         etdAp+LMtRZnWAmmKvXdz6I9nsBxMnTQ6Cx7hlHqh+/3wzI4Bt7kHzZq4GanqFP9EkV0
         7ueiFl7C1ipwXheg3mQ/BeThUEtOfZm21Iq6QRK/LXL9Fsd1W5I1KFRdhdoNSsTXpOvA
         QpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qA13pvpEqCNvK58Lmj9i697NKs6YTsixMcGAJ0be9sk=;
        b=ABd0rZmaZ5nENgiT/JG99JR9M0eVRRG/VnB1gcZVIUq7sPwrQzilVz8qgMJkm90C7H
         NexBsl3rNuJra7dm0CkKLNay0useNxG1h/DXU5TyXyL5u9ql0fnVqY50+93KFPpzyByH
         2AX0+L4XD6ZLEfaXMOSttPaZpSYZu8mkSdMHq9z+ccCunlxlmYFbM5J5qMPFVjCTFEGC
         KyHbuJ0tC7NFAMmav59et0JXV1HWiISB0coCZoPBaT233FwAIEyvpsYKG6Yj1r+jP1sz
         yR/7OzCp7+aLpAzTEoZ8vkML+w0ZMeF+FPTlILCGcXm7FO8AvAuxXDaCwsTmAejCtUpw
         3vfg==
X-Gm-Message-State: AO0yUKWvLNrgm2gog6QcUq2xdCOvYE9dO90QnY9Ya8YSPFphZFnVhrk3
        sXpzwsVR9g4dVG0k0zhjqo1B5qQeQMnyH8vI
X-Google-Smtp-Source: AK7set8Bwi6Dk6sMFstbaXR3xdSZcjaeIJ5RV7z5c82W2GIuEhM7mG7D4zV03UwMyfcEL3HsUNS09w==
X-Received: by 2002:a05:6808:253:b0:383:f380:868e with SMTP id m19-20020a056808025300b00383f380868emr1985089oie.34.1677287751410;
        Fri, 24 Feb 2023 17:15:51 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:15:50 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 08/76] ssdfs: search last actual superblock
Date:   Fri, 24 Feb 2023 17:08:19 -0800
Message-Id: <20230225010927.813929-9-slava@dubeyko.com>
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

SSDFS is pure LFS file system. It means that there is no fixed
position of superblock on the volume. SSDFS keeps superblock
information into every segment header and log footer. Actually,
every log contains copy of superblock. However, it needs to find
a specialized superblock segment and last actual superblock state
for proper intialization of file system instance.

Search logic is split on several steps:
(1) find any valid segment header and extract information about
    current, next, and reserved superblock segment location,
(2) find latest valid superblock segment,
(3) find latest valid superblock state into superblock segment.

Search logic splits file system volume on several portions. It starts
to search in the first portion by using fast search algorithm.
The fast algorithm checks every 50th erase block in the portion.
If first portion hasn't last superblock segment, then search logic
starts several threads that are looking for last actual and valid
superblock segment by using fast search logic. Finally, if the fast
search algorithm is unable to find the last actual superblock segment,
then file system driver repeat the search by means of using slow
search algorithm logic. The slow search algorithm simply checks every
erase block in the portion. Usually, fast search algorithm is enough,
but if the volume could be corrupted, then slow search logic can be
used to find consistent state of superblock and to try to recover
the volume state.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/recovery_fast_search.c | 1194 ++++++++++++++++++++++++++++++
 fs/ssdfs/recovery_slow_search.c |  585 +++++++++++++++
 fs/ssdfs/recovery_thread.c      | 1196 +++++++++++++++++++++++++++++++
 3 files changed, 2975 insertions(+)
 create mode 100644 fs/ssdfs/recovery_fast_search.c
 create mode 100644 fs/ssdfs/recovery_slow_search.c
 create mode 100644 fs/ssdfs/recovery_thread.c

diff --git a/fs/ssdfs/recovery_fast_search.c b/fs/ssdfs/recovery_fast_search.c
new file mode 100644
index 000000000000..70c97331fccb
--- /dev/null
+++ b/fs/ssdfs/recovery_fast_search.c
@@ -0,0 +1,1194 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/recovery_fast_search.c - fast superblock search.
+ *
+ * Copyright (c) 2020-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#include <linux/slab.h>
+#include <linux/kthread.h>
+#include <linux/pagevec.h>
+#include <linux/blkdev.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "page_array.h"
+#include "page_vector.h"
+#include "peb.h"
+#include "segment_bitmap.h"
+#include "peb_mapping_table.h"
+#include "recovery.h"
+
+#include <trace/events/ssdfs.h>
+
+static inline
+bool IS_SB_PEB(struct ssdfs_recovery_env *env)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+#endif /* CONFIG_SSDFS_DEBUG */
+	int type;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env);
+	BUG_ON(!env->sbi.vh_buf);
+	BUG_ON(!is_ssdfs_magic_valid(&SSDFS_VH(env->sbi.vh_buf)->magic));
+	BUG_ON(!is_ssdfs_volume_header_csum_valid(env->sbi.vh_buf, hdr_size));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	type = le16_to_cpu(SSDFS_SEG_HDR(env->sbi.vh_buf)->seg_type);
+
+	if (type == SSDFS_SB_SEG_TYPE)
+		return true;
+
+	return false;
+}
+
+static inline
+void STORE_PEB_INFO(struct ssdfs_found_peb *peb,
+		    u64 peb_id, u64 cno,
+		    int type, int state)
+{
+	peb->peb_id = peb_id;
+	peb->cno = cno;
+	if (type == SSDFS_SB_SEG_TYPE)
+		peb->is_superblock_peb = true;
+	else
+		peb->is_superblock_peb = false;
+	peb->state = state;
+}
+
+static inline
+void STORE_SB_PEB_INFO(struct ssdfs_found_peb *peb,
+		       u64 peb_id)
+{
+	STORE_PEB_INFO(peb, peb_id, U64_MAX,
+			SSDFS_UNKNOWN_SEG_TYPE,
+			SSDFS_PEB_NOT_CHECKED);
+}
+
+static inline
+void STORE_MAIN_SB_PEB_INFO(struct ssdfs_recovery_env *env,
+			    struct ssdfs_found_protected_peb *ptr,
+			    int sb_seg_index)
+{
+	struct ssdfs_superblock_pebs_pair *pair;
+	struct ssdfs_found_peb *sb_peb;
+	u64 peb_id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr);
+	BUG_ON(sb_seg_index < SSDFS_CUR_SB_SEG ||
+		sb_seg_index >= SSDFS_SB_CHAIN_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pair = &ptr->found.sb_pebs[sb_seg_index];
+	sb_peb = &pair->pair[SSDFS_MAIN_SB_SEG];
+	peb_id = SSDFS_MAIN_SB_PEB(SSDFS_VH(env->sbi.vh_buf), sb_seg_index);
+
+	STORE_SB_PEB_INFO(sb_peb, peb_id);
+}
+
+static inline
+void STORE_COPY_SB_PEB_INFO(struct ssdfs_recovery_env *env,
+			    struct ssdfs_found_protected_peb *ptr,
+			    int sb_seg_index)
+{
+	struct ssdfs_superblock_pebs_pair *pair;
+	struct ssdfs_found_peb *sb_peb;
+	u64 peb_id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr);
+	BUG_ON(sb_seg_index < SSDFS_CUR_SB_SEG ||
+		sb_seg_index >= SSDFS_SB_CHAIN_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pair = &ptr->found.sb_pebs[sb_seg_index];
+	sb_peb = &pair->pair[SSDFS_COPY_SB_SEG];
+	peb_id = SSDFS_COPY_SB_PEB(SSDFS_VH(env->sbi.vh_buf), sb_seg_index);
+
+	STORE_SB_PEB_INFO(sb_peb, peb_id);
+}
+
+static inline
+void ssdfs_store_superblock_pebs_info(struct ssdfs_recovery_env *env,
+				      int peb_index)
+{
+	struct ssdfs_found_protected_peb *ptr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->found);
+	BUG_ON(!env->sbi.vh_buf);
+	BUG_ON(peb_index < SSDFS_LOWER_PEB_INDEX ||
+		peb_index >= SSDFS_PROTECTED_PEB_CHAIN_MAX);
+
+	SSDFS_DBG("env %p, peb_index %d\n",
+		  env, peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ptr = &env->found->array[peb_index];
+
+	STORE_MAIN_SB_PEB_INFO(env, ptr, SSDFS_CUR_SB_SEG);
+	STORE_COPY_SB_PEB_INFO(env, ptr, SSDFS_CUR_SB_SEG);
+
+	STORE_MAIN_SB_PEB_INFO(env, ptr, SSDFS_NEXT_SB_SEG);
+	STORE_COPY_SB_PEB_INFO(env, ptr, SSDFS_NEXT_SB_SEG);
+
+	STORE_MAIN_SB_PEB_INFO(env, ptr, SSDFS_RESERVED_SB_SEG);
+	STORE_COPY_SB_PEB_INFO(env, ptr, SSDFS_RESERVED_SB_SEG);
+
+	STORE_MAIN_SB_PEB_INFO(env, ptr, SSDFS_PREV_SB_SEG);
+	STORE_COPY_SB_PEB_INFO(env, ptr, SSDFS_PREV_SB_SEG);
+}
+
+static inline
+void ssdfs_store_protected_peb_info(struct ssdfs_recovery_env *env,
+				    int peb_index,
+				    u64 peb_id)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+#endif /* CONFIG_SSDFS_DEBUG */
+	struct ssdfs_found_protected_peb *ptr;
+	u64 cno;
+	int type;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->found);
+	BUG_ON(!env->sbi.vh_buf);
+	BUG_ON(peb_index < SSDFS_LOWER_PEB_INDEX ||
+		peb_index >= SSDFS_PROTECTED_PEB_CHAIN_MAX);
+	BUG_ON(!is_ssdfs_magic_valid(&SSDFS_VH(env->sbi.vh_buf)->magic));
+	BUG_ON(!is_ssdfs_volume_header_csum_valid(env->sbi.vh_buf, hdr_size));
+
+	SSDFS_DBG("env %p, peb_index %d, peb_id %llu\n",
+		  env, peb_index, peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	cno = le64_to_cpu(SSDFS_SEG_HDR(env->sbi.vh_buf)->cno);
+	type = le16_to_cpu(SSDFS_SEG_HDR(env->sbi.vh_buf)->seg_type);
+
+	ptr = &env->found->array[peb_index];
+	STORE_PEB_INFO(&ptr->peb, peb_id, cno, type, SSDFS_FOUND_PEB_VALID);
+	ssdfs_store_superblock_pebs_info(env, peb_index);
+}
+
+static
+int ssdfs_calculate_recovery_search_bounds(struct ssdfs_recovery_env *env,
+					   u64 dev_size,
+					   u64 *lower_peb, loff_t *lower_off,
+					   u64 *upper_peb, loff_t *upper_off)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->found || !env->fsi);
+	BUG_ON(!lower_peb || !lower_off);
+	BUG_ON(!upper_peb || !upper_off);
+
+	SSDFS_DBG("env %p, start_peb %llu, "
+		  "pebs_count %u, dev_size %llu\n",
+		  env, env->found->start_peb,
+		  env->found->pebs_count, dev_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*lower_peb = env->found->start_peb;
+	if (*lower_peb == 0)
+		*lower_off = SSDFS_RESERVED_VBR_SIZE;
+	else
+		*lower_off = *lower_peb * env->fsi->erasesize;
+
+	if (*lower_off >= dev_size) {
+		SSDFS_ERR("invalid offset: lower_off %llu, "
+			  "dev_size %llu\n",
+			  (unsigned long long)*lower_off,
+			  dev_size);
+		return -ERANGE;
+	}
+
+	*upper_peb = env->found->pebs_count - 1;
+	*upper_peb /= SSDFS_MAPTBL_PROTECTION_STEP;
+	*upper_peb *= SSDFS_MAPTBL_PROTECTION_STEP;
+	*upper_peb += env->found->start_peb;
+	*upper_off = *upper_peb * env->fsi->erasesize;
+
+	if (*upper_off >= dev_size) {
+		*upper_off = min_t(u64, *upper_off,
+				   dev_size - env->fsi->erasesize);
+		*upper_peb = *upper_off / env->fsi->erasesize;
+		*upper_peb -= env->found->start_peb;
+		*upper_peb /= SSDFS_MAPTBL_PROTECTION_STEP;
+		*upper_peb *= SSDFS_MAPTBL_PROTECTION_STEP;
+		*upper_peb += env->found->start_peb;
+		*upper_off = *upper_peb * env->fsi->erasesize;
+	}
+
+	return 0;
+}
+
+static
+int ssdfs_find_valid_protected_pebs(struct ssdfs_recovery_env *env)
+{
+	struct super_block *sb = env->fsi->sb;
+	u64 dev_size = env->fsi->devops->device_size(sb);
+	u64 lower_peb, upper_peb;
+	loff_t lower_off, upper_off;
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+	size_t vh_size = sizeof(struct ssdfs_volume_header);
+	struct ssdfs_volume_header *vh;
+	struct ssdfs_found_protected_peb *found;
+	bool magic_valid = false;
+	u64 cno = U64_MAX, last_cno = U64_MAX;
+	int err;
+
+	if (!env->found) {
+		SSDFS_ERR("unable to find protected PEBs\n");
+		return -EOPNOTSUPP;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("env %p, start_peb %llu, pebs_count %u\n",
+		  env, env->found->start_peb,
+		  env->found->pebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!env->fsi->devops->read) {
+		SSDFS_ERR("unable to read from device\n");
+		return -EOPNOTSUPP;
+	}
+
+	env->found->lower_offset = dev_size;
+	env->found->middle_offset = dev_size;
+	env->found->upper_offset = dev_size;
+
+	err = ssdfs_calculate_recovery_search_bounds(env, dev_size,
+						     &lower_peb, &lower_off,
+						     &upper_peb, &upper_off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to calculate search bounds: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	env->found->lower_offset = lower_off;
+	env->found->middle_offset = lower_off;
+	env->found->upper_offset = upper_off;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("lower_peb %llu, upper_peb %llu\n",
+		  lower_peb, upper_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	while (lower_peb <= upper_peb) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("lower_peb %llu, lower_off %llu\n",
+			  lower_peb, (u64)lower_off);
+		SSDFS_DBG("upper_peb %llu, upper_off %llu\n",
+			  upper_peb, (u64)upper_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = env->fsi->devops->read(sb,
+					     lower_off,
+					     hdr_size,
+					     env->sbi.vh_buf);
+		vh = SSDFS_VH(env->sbi.vh_buf);
+		magic_valid = is_ssdfs_magic_valid(&vh->magic);
+		cno = le64_to_cpu(SSDFS_SEG_HDR(env->sbi.vh_buf)->cno);
+
+		if (!err && magic_valid) {
+			found = &env->found->array[SSDFS_LOWER_PEB_INDEX];
+
+			if (found->peb.peb_id >= U64_MAX) {
+				ssdfs_store_protected_peb_info(env,
+						SSDFS_LOWER_PEB_INDEX,
+						lower_peb);
+
+				env->found->lower_offset = lower_off;
+
+				ssdfs_memcpy(&env->last_vh, 0, vh_size,
+					     env->sbi.vh_buf, 0, vh_size,
+					     vh_size);
+				ssdfs_backup_sb_info2(env);
+
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("FOUND: lower_peb %llu, "
+					  "lower_bound %llu\n",
+					  lower_peb, lower_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				goto define_last_cno_peb;
+			}
+
+			ssdfs_store_protected_peb_info(env,
+						SSDFS_UPPER_PEB_INDEX,
+						lower_peb);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("FOUND: lower_peb %llu, "
+				  "lower_bound %llu\n",
+				  lower_peb, lower_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+define_last_cno_peb:
+			if (last_cno >= U64_MAX) {
+				env->found->middle_offset = lower_off;
+				ssdfs_store_protected_peb_info(env,
+						SSDFS_LAST_CNO_PEB_INDEX,
+						lower_peb);
+				ssdfs_memcpy(&env->last_vh, 0, vh_size,
+					     env->sbi.vh_buf, 0, vh_size,
+					     vh_size);
+				ssdfs_backup_sb_info2(env);
+				last_cno = cno;
+
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("FOUND: lower_peb %llu, "
+					  "middle_offset %llu, "
+					  "cno %llu\n",
+					  lower_peb, lower_off, cno);
+#endif /* CONFIG_SSDFS_DEBUG */
+			} else if (cno > last_cno) {
+				env->found->middle_offset = lower_off;
+				ssdfs_store_protected_peb_info(env,
+						SSDFS_LAST_CNO_PEB_INDEX,
+						lower_peb);
+				ssdfs_memcpy(&env->last_vh, 0, vh_size,
+					     env->sbi.vh_buf, 0, vh_size,
+					     vh_size);
+				ssdfs_backup_sb_info2(env);
+				last_cno = cno;
+
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("FOUND: lower_peb %llu, "
+					  "middle_offset %llu, "
+					  "cno %llu\n",
+					  lower_peb, lower_off, cno);
+#endif /* CONFIG_SSDFS_DEBUG */
+			} else {
+				ssdfs_restore_sb_info2(env);
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("ignore valid PEB: "
+					  "lower_peb %llu, lower_off %llu, "
+					  "cno %llu, last_cno %llu\n",
+					  lower_peb, lower_off,
+					  cno, last_cno);
+#endif /* CONFIG_SSDFS_DEBUG */
+			}
+		} else {
+			ssdfs_restore_sb_info2(env);
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("peb %llu (offset %llu) is corrupted\n",
+				  lower_peb,
+				  (unsigned long long)lower_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+
+		lower_peb += SSDFS_MAPTBL_PROTECTION_STEP;
+		lower_off = lower_peb * env->fsi->erasesize;
+
+		if (kthread_should_stop())
+			goto finish_search;
+	}
+
+	found = &env->found->array[SSDFS_UPPER_PEB_INDEX];
+
+	if (found->peb.peb_id >= U64_MAX)
+		goto finish_search;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("env->lower_offset %llu, "
+		  "env->middle_offset %llu, "
+		  "env->upper_offset %llu\n",
+		  env->found->lower_offset,
+		  env->found->middle_offset,
+		  env->found->upper_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	SSDFS_RECOVERY_SET_FAST_SEARCH_TRY(env);
+
+	return 0;
+
+finish_search:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("unable to find valid PEB\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	SSDFS_RECOVERY_SET_FAST_SEARCH_TRY(env);
+
+	return -ENODATA;
+}
+
+static inline
+int ssdfs_read_sb_peb_checked(struct ssdfs_recovery_env *env,
+			      u64 peb_id)
+{
+	struct ssdfs_volume_header *vh;
+	size_t vh_size = sizeof(struct ssdfs_volume_header);
+	bool magic_valid = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->fsi || !env->fsi->sb);
+	BUG_ON(!env->sbi.vh_buf);
+
+	SSDFS_DBG("peb_id %llu\n", peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_read_checked_sb_info3(env, peb_id, 0);
+	vh = SSDFS_VH(env->sbi.vh_buf);
+	magic_valid = is_ssdfs_magic_valid(&vh->magic);
+
+	if (err || !magic_valid) {
+		err = -ENODATA;
+		ssdfs_restore_sb_info2(env);
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("peb %llu is corrupted\n",
+			  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_check;
+	} else {
+		ssdfs_memcpy(&env->last_vh, 0, vh_size,
+			     env->sbi.vh_buf, 0, vh_size,
+			     vh_size);
+		ssdfs_backup_sb_info2(env);
+		goto finish_check;
+	}
+
+finish_check:
+	return err;
+}
+
+int ssdfs_find_last_sb_seg_outside_fragment(struct ssdfs_recovery_env *env)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+#endif /* CONFIG_SSDFS_DEBUG */
+	struct super_block *sb;
+	struct ssdfs_volume_header *vh;
+	u64 leb_id;
+	u64 peb_id;
+	bool magic_valid = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->fsi || !env->fsi->sb);
+	BUG_ON(!env->sbi.vh_buf);
+	BUG_ON(!is_ssdfs_magic_valid(&SSDFS_VH(env->sbi.vh_buf)->magic));
+	BUG_ON(!is_ssdfs_volume_header_csum_valid(env->sbi.vh_buf, hdr_size));
+
+	SSDFS_DBG("env %p, env->sbi.vh_buf %p\n", env, env->sbi.vh_buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	sb = env->fsi->sb;
+	err = -ENODATA;
+
+	leb_id = SSDFS_MAIN_SB_LEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_CUR_SB_SEG);
+	peb_id = SSDFS_MAIN_SB_PEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_CUR_SB_SEG);
+
+	do {
+		err = ssdfs_read_sb_peb_checked(env, peb_id);
+		vh = SSDFS_VH(env->sbi.vh_buf);
+		magic_valid = is_ssdfs_magic_valid(&vh->magic);
+
+		if (err == -ENODATA)
+			goto finish_search;
+		else if (err) {
+			SSDFS_ERR("fail to read peb %llu\n",
+				  peb_id);
+			goto finish_search;
+		} else {
+			u64 new_leb_id;
+			u64 new_peb_id;
+
+			new_leb_id =
+				SSDFS_MAIN_SB_LEB(SSDFS_VH(env->sbi.vh_buf),
+						  SSDFS_CUR_SB_SEG);
+			new_peb_id =
+				SSDFS_MAIN_SB_PEB(SSDFS_VH(env->sbi.vh_buf),
+						  SSDFS_CUR_SB_SEG);
+
+			if (new_leb_id != leb_id || new_peb_id != peb_id) {
+				err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("SB segment not found: "
+					  "peb %llu\n",
+					  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_search;
+			}
+
+			env->sbi.last_log.leb_id = leb_id;
+			env->sbi.last_log.peb_id = peb_id;
+			env->sbi.last_log.page_offset = 0;
+			env->sbi.last_log.pages_count =
+				SSDFS_LOG_PAGES(env->sbi.vh_buf);
+
+			if (IS_SB_PEB(env)) {
+				if (is_cur_main_sb_peb_exhausted(env)) {
+					err = -ENOENT;
+#ifdef CONFIG_SSDFS_DEBUG
+					SSDFS_DBG("peb %llu is exhausted\n",
+						  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+					goto try_next_sb_peb;
+				} else {
+					err = 0;
+					goto finish_search;
+				}
+			} else {
+				err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("SB segment not found: "
+					  "peb %llu\n",
+					  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_search;
+			}
+		}
+
+try_next_sb_peb:
+		if (kthread_should_stop()) {
+			err = -ENODATA;
+			goto finish_search;
+		}
+
+		leb_id = SSDFS_MAIN_SB_LEB(SSDFS_VH(env->sbi_backup.vh_buf),
+						SSDFS_NEXT_SB_SEG);
+		peb_id = SSDFS_MAIN_SB_PEB(SSDFS_VH(env->sbi_backup.vh_buf),
+						SSDFS_NEXT_SB_SEG);
+	} while (magic_valid);
+
+finish_search:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search outside fragment is finished: "
+		  "err %d\n", err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+static
+int ssdfs_check_cur_main_sb_peb(struct ssdfs_recovery_env *env)
+{
+	struct ssdfs_volume_header *vh;
+	u64 leb_id;
+	u64 peb_id;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env);
+	BUG_ON(!env->sbi.vh_buf);
+
+	SSDFS_DBG("env %p, env->sbi.vh_buf %p\n", env, env->sbi.vh_buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	vh = SSDFS_VH(env->sbi.vh_buf);
+	leb_id = SSDFS_MAIN_SB_LEB(vh, SSDFS_CUR_SB_SEG);
+	peb_id = SSDFS_MAIN_SB_PEB(vh, SSDFS_CUR_SB_SEG);
+
+	ssdfs_backup_sb_info2(env);
+
+	err = ssdfs_read_sb_peb_checked(env, peb_id);
+	if (err == -ENODATA)
+		goto finish_check;
+	else if (err) {
+		SSDFS_ERR("fail to read peb %llu\n",
+			  peb_id);
+		goto finish_check;
+	} else {
+		u64 new_leb_id;
+		u64 new_peb_id;
+
+		vh = SSDFS_VH(env->sbi.vh_buf);
+		new_leb_id = SSDFS_MAIN_SB_LEB(vh, SSDFS_CUR_SB_SEG);
+		new_peb_id = SSDFS_MAIN_SB_PEB(vh, SSDFS_CUR_SB_SEG);
+
+		if (new_leb_id != leb_id || new_peb_id != peb_id) {
+			err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("SB segment not found: "
+				  "peb %llu\n",
+				  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_check;
+		}
+
+		env->sbi.last_log.leb_id = leb_id;
+		env->sbi.last_log.peb_id = peb_id;
+		env->sbi.last_log.page_offset = 0;
+		env->sbi.last_log.pages_count =
+			SSDFS_LOG_PAGES(env->sbi.vh_buf);
+
+		if (IS_SB_PEB(env)) {
+			if (is_cur_main_sb_peb_exhausted(env)) {
+				err = -ENOENT;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("peb %llu is exhausted\n",
+					  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_check;
+			} else {
+				err = 0;
+				goto finish_check;
+			}
+		} else {
+			err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("SB segment not found: "
+				  "peb %llu\n",
+				  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_check;
+		}
+	}
+
+finish_check:
+	return err;
+}
+
+static
+int ssdfs_check_cur_copy_sb_peb(struct ssdfs_recovery_env *env)
+{
+	struct ssdfs_volume_header *vh;
+	u64 leb_id;
+	u64 peb_id;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env);
+	BUG_ON(!env->sbi.vh_buf);
+
+	SSDFS_DBG("env %p, env->sbi.vh_buf %p\n", env, env->sbi.vh_buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	vh = SSDFS_VH(env->sbi.vh_buf);
+	leb_id = SSDFS_COPY_SB_LEB(vh, SSDFS_CUR_SB_SEG);
+	peb_id = SSDFS_COPY_SB_PEB(vh, SSDFS_CUR_SB_SEG);
+
+	ssdfs_backup_sb_info2(env);
+
+	err = ssdfs_read_sb_peb_checked(env, peb_id);
+	if (err == -ENODATA)
+		goto finish_check;
+	else if (err) {
+		SSDFS_ERR("fail to read peb %llu\n",
+			  peb_id);
+		goto finish_check;
+	} else {
+		u64 new_leb_id;
+		u64 new_peb_id;
+
+		vh = SSDFS_VH(env->sbi.vh_buf);
+		new_leb_id = SSDFS_COPY_SB_LEB(vh, SSDFS_CUR_SB_SEG);
+		new_peb_id = SSDFS_COPY_SB_PEB(vh, SSDFS_CUR_SB_SEG);
+
+		if (new_leb_id != leb_id || new_peb_id != peb_id) {
+			err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("SB segment not found: "
+				  "peb %llu\n",
+				  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_check;
+		}
+
+		env->sbi.last_log.leb_id = leb_id;
+		env->sbi.last_log.peb_id = peb_id;
+		env->sbi.last_log.page_offset = 0;
+		env->sbi.last_log.pages_count =
+			SSDFS_LOG_PAGES(env->sbi.vh_buf);
+
+		if (IS_SB_PEB(env)) {
+			if (is_cur_copy_sb_peb_exhausted(env)) {
+				err = -ENOENT;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("peb %llu is exhausted\n",
+					  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_check;
+			} else {
+				err = 0;
+				goto finish_check;
+			}
+		} else {
+			err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("SB segment not found: "
+				  "peb %llu\n",
+				  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_check;
+		}
+	}
+
+finish_check:
+	return err;
+}
+
+static
+int ssdfs_find_last_sb_seg_inside_fragment(struct ssdfs_recovery_env *env)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->fsi || !env->fsi->sb);
+	BUG_ON(!env->sbi.vh_buf);
+	BUG_ON(!is_ssdfs_magic_valid(&SSDFS_VH(env->sbi.vh_buf)->magic));
+	BUG_ON(!is_ssdfs_volume_header_csum_valid(env->sbi.vh_buf, hdr_size));
+
+	SSDFS_DBG("env %p, env->sbi.vh_buf %p\n", env, env->sbi.vh_buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+try_next_peb:
+	if (kthread_should_stop()) {
+		err = -ENODATA;
+		goto finish_search;
+	}
+
+	err = ssdfs_check_cur_main_sb_peb(env);
+	if (err == -ENODATA)
+		goto try_cur_copy_sb_peb;
+	else if (err == -ENOENT)
+		goto check_next_sb_pebs_pair;
+	else if (err)
+		goto finish_search;
+	else
+		goto finish_search;
+
+try_cur_copy_sb_peb:
+	if (kthread_should_stop()) {
+		err = -ENODATA;
+		goto finish_search;
+	}
+
+	err = ssdfs_check_cur_copy_sb_peb(env);
+	if (err == -ENODATA || err == -ENOENT)
+		goto check_next_sb_pebs_pair;
+	else if (err)
+		goto finish_search;
+	else
+		goto finish_search;
+
+check_next_sb_pebs_pair:
+	if (kthread_should_stop()) {
+		err = -ENODATA;
+		goto finish_search;
+	}
+
+	err = ssdfs_check_next_sb_pebs_pair(env);
+	if (err == -E2BIG) {
+		err = ssdfs_find_last_sb_seg_outside_fragment(env);
+		if (err == -ENODATA || err == -ENOENT) {
+			/* unable to find anything */
+			goto check_reserved_sb_pebs_pair;
+		} else if (err) {
+			SSDFS_ERR("search outside fragment has failed: "
+				  "err %d\n", err);
+			goto finish_search;
+		} else
+			goto finish_search;
+	} else if (!err)
+		goto try_next_peb;
+
+check_reserved_sb_pebs_pair:
+	if (kthread_should_stop()) {
+		err = -ENODATA;
+		goto finish_search;
+	}
+
+	err = ssdfs_check_reserved_sb_pebs_pair(env);
+	if (err == -E2BIG) {
+		err = ssdfs_find_last_sb_seg_outside_fragment(env);
+		if (err == -ENODATA || err == -ENOENT) {
+			/* unable to find anything */
+			goto finish_search;
+		} else if (err) {
+			SSDFS_ERR("search outside fragment has failed: "
+				  "err %d\n", err);
+			goto finish_search;
+		} else
+			goto finish_search;
+	} else if (!err)
+		goto try_next_peb;
+
+finish_search:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search inside fragment is finished: "
+		  "err %d\n", err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+static
+int ssdfs_find_last_sb_seg_starting_from_peb(struct ssdfs_recovery_env *env,
+					     struct ssdfs_found_peb *ptr)
+{
+	struct super_block *sb;
+	struct ssdfs_volume_header *vh;
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+	size_t vh_size = sizeof(struct ssdfs_volume_header);
+	u64 offset;
+	u64 threshold_peb;
+	u64 peb_id;
+	u64 cno = U64_MAX;
+	bool magic_valid = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->found || !env->fsi || !env->fsi->sb);
+	BUG_ON(!env->sbi.vh_buf);
+	BUG_ON(!env->fsi->devops->read);
+	BUG_ON(!ptr);
+	BUG_ON(ptr->peb_id >= U64_MAX);
+
+	SSDFS_DBG("peb_id %llu, start_peb %llu, pebs_count %u\n",
+		  ptr->peb_id,
+		  env->found->start_peb,
+		  env->found->pebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	sb = env->fsi->sb;
+	threshold_peb = env->found->start_peb + env->found->pebs_count;
+	peb_id = ptr->peb_id;
+	offset = peb_id * env->fsi->erasesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("peb_id %llu, offset %llu\n",
+		  peb_id, offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = env->fsi->devops->read(sb, offset, hdr_size,
+				     env->sbi.vh_buf);
+	vh = SSDFS_VH(env->sbi.vh_buf);
+	magic_valid = is_ssdfs_magic_valid(&vh->magic);
+
+	if (err || !magic_valid) {
+		ssdfs_restore_sb_info2(env);
+		ptr->state = SSDFS_FOUND_PEB_INVALID;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("peb %llu is corrupted\n",
+			  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		if (ptr->peb_id >= env->found->start_peb &&
+		    ptr->peb_id < threshold_peb) {
+			/* try again */
+			return -EAGAIN;
+		} else {
+			/* PEB is out of range */
+			return -E2BIG;
+		}
+	} else {
+		ssdfs_memcpy(&env->last_vh, 0, vh_size,
+			     env->sbi.vh_buf, 0, vh_size,
+			     vh_size);
+		ssdfs_backup_sb_info2(env);
+		cno = le64_to_cpu(SSDFS_SEG_HDR(env->sbi.vh_buf)->cno);
+		ptr->cno = cno;
+		ptr->is_superblock_peb = IS_SB_PEB(env);
+		ptr->state = SSDFS_FOUND_PEB_VALID;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("peb_id %llu, cno %llu, is_superblock_peb %#x\n",
+			  peb_id, cno, ptr->is_superblock_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	if (ptr->peb_id >= env->found->start_peb &&
+	    ptr->peb_id < threshold_peb) {
+		err = ssdfs_find_last_sb_seg_inside_fragment(env);
+		if (err == -ENODATA || err == -ENOENT) {
+			ssdfs_restore_sb_info2(env);
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("nothing has been found inside fragment: "
+				  "peb_id %llu\n",
+				  ptr->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -EAGAIN;
+		} else if (err) {
+			SSDFS_ERR("search inside fragment has failed: "
+				  "err %d\n", err);
+			return err;
+		}
+	} else {
+		err = ssdfs_find_last_sb_seg_outside_fragment(env);
+		if (err == -ENODATA || err == -ENOENT) {
+			ssdfs_restore_sb_info2(env);
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("nothing has been found outside fragment: "
+				  "peb_id %llu\n",
+				  ptr->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -E2BIG;
+		} else if (err) {
+			SSDFS_ERR("search outside fragment has failed: "
+				  "err %d\n", err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static
+int ssdfs_find_last_sb_seg_for_protected_peb(struct ssdfs_recovery_env *env)
+{
+	struct super_block *sb;
+	struct ssdfs_found_protected_peb *protected_peb;
+	struct ssdfs_found_peb *cur_peb;
+	u64 dev_size;
+	u64 threshold_peb;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->found || !env->fsi || !env->fsi->sb);
+	BUG_ON(!env->sbi.vh_buf);
+	BUG_ON(!env->fsi->devops->read);
+
+	SSDFS_DBG("env %p, env->sbi.vh_buf %p\n", env, env->sbi.vh_buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	sb = env->fsi->sb;
+	dev_size = env->fsi->devops->device_size(env->fsi->sb);
+	threshold_peb = env->found->start_peb + env->found->pebs_count;
+
+	protected_peb = &env->found->array[SSDFS_LAST_CNO_PEB_INDEX];
+
+	if (protected_peb->peb.peb_id >= U64_MAX) {
+		SSDFS_ERR("protected hasn't been found\n");
+		return -ERANGE;
+	}
+
+	cur_peb = CUR_MAIN_SB_PEB(&protected_peb->found);
+	if (cur_peb->peb_id >= U64_MAX) {
+		SSDFS_ERR("peb_id is invalid\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_find_last_sb_seg_starting_from_peb(env, cur_peb);
+	if (err == -EAGAIN || err == -E2BIG) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("nothing was found for peb %llu\n",
+			  cur_peb->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		/* continue search */
+	} else if (err) {
+		SSDFS_ERR("fail to find last superblock segment: "
+			  "err %d\n", err);
+		goto finish_search;
+	} else
+		goto finish_search;
+
+	cur_peb = CUR_COPY_SB_PEB(&protected_peb->found);
+	if (cur_peb->peb_id >= U64_MAX) {
+		SSDFS_ERR("peb_id is invalid\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_find_last_sb_seg_starting_from_peb(env, cur_peb);
+	if (err == -EAGAIN || err == -E2BIG) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("nothing was found for peb %llu\n",
+			  cur_peb->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		/* continue search */
+	} else if (err) {
+		SSDFS_ERR("fail to find last superblock segment: "
+			  "err %d\n", err);
+		goto finish_search;
+	} else
+		goto finish_search;
+
+	cur_peb = NEXT_MAIN_SB_PEB(&protected_peb->found);
+	if (cur_peb->peb_id >= U64_MAX) {
+		SSDFS_ERR("peb_id is invalid\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_find_last_sb_seg_starting_from_peb(env, cur_peb);
+	if (err == -EAGAIN || err == -E2BIG) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("nothing was found for peb %llu\n",
+			  cur_peb->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		/* continue search */
+	} else if (err) {
+		SSDFS_ERR("fail to find last superblock segment: "
+			  "err %d\n", err);
+		goto finish_search;
+	} else
+		goto finish_search;
+
+	cur_peb = NEXT_COPY_SB_PEB(&protected_peb->found);
+	if (cur_peb->peb_id >= U64_MAX) {
+		SSDFS_ERR("peb_id is invalid\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_find_last_sb_seg_starting_from_peb(env, cur_peb);
+	if (err == -EAGAIN || err == -E2BIG) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("nothing was found for peb %llu\n",
+			  cur_peb->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		/* continue search */
+	} else if (err) {
+		SSDFS_ERR("fail to find last superblock segment: "
+			  "err %d\n", err);
+		goto finish_search;
+	} else
+		goto finish_search;
+
+	cur_peb = RESERVED_MAIN_SB_PEB(&protected_peb->found);
+	if (cur_peb->peb_id >= U64_MAX) {
+		SSDFS_ERR("peb_id is invalid\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_find_last_sb_seg_starting_from_peb(env, cur_peb);
+	if (err == -EAGAIN || err == -E2BIG) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("nothing was found for peb %llu\n",
+			  cur_peb->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		/* continue search */
+	} else if (err) {
+		SSDFS_ERR("fail to find last superblock segment: "
+			  "err %d\n", err);
+		goto finish_search;
+	} else
+		goto finish_search;
+
+	cur_peb = RESERVED_COPY_SB_PEB(&protected_peb->found);
+	if (cur_peb->peb_id >= U64_MAX) {
+		SSDFS_ERR("peb_id is invalid\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_find_last_sb_seg_starting_from_peb(env, cur_peb);
+	if (err == -EAGAIN || err == -E2BIG) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("nothing was found for peb %llu\n",
+			  cur_peb->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_search;
+	} else if (err) {
+		SSDFS_ERR("fail to find last superblock segment: "
+			  "err %d\n", err);
+		goto finish_search;
+	} else
+		goto finish_search;
+
+finish_search:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search is finished: "
+		  "err %d\n", err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+static
+int ssdfs_recovery_protected_section_fast_search(struct ssdfs_recovery_env *env)
+{
+	u64 threshold_peb;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->fsi);
+	BUG_ON(!env->sbi.vh_buf);
+
+	SSDFS_DBG("env %p, env->sbi.vh_buf %p\n", env, env->sbi.vh_buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	threshold_peb = *SSDFS_RECOVERY_CUR_OFF_PTR(env) / env->fsi->erasesize;
+
+	err = ssdfs_find_any_valid_sb_segment2(env, threshold_peb);
+	if (err)
+		return err;
+
+	if (kthread_should_stop())
+		return -ENOENT;
+
+	err = ssdfs_find_latest_valid_sb_segment2(env);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int ssdfs_recovery_try_fast_search(struct ssdfs_recovery_env *env)
+{
+	struct ssdfs_found_protected_peb *found;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->found);
+	BUG_ON(!env->sbi.vh_buf);
+
+	SSDFS_DBG("env %p, start_peb %llu, pebs_count %u\n",
+		  env, env->found->start_peb,
+		  env->found->pebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_find_valid_protected_pebs(env);
+	if (err == -ENODATA) {
+		found = &env->found->array[SSDFS_LOWER_PEB_INDEX];
+
+		if (found->peb.peb_id >= U64_MAX) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("no valid protected PEBs in fragment: "
+				  "start_peb %llu, pebs_count %u\n",
+				  env->found->start_peb,
+				  env->found->pebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_fast_search;
+		} else {
+			/* search only in the last valid section */
+			err = ssdfs_recovery_protected_section_fast_search(env);
+			goto finish_fast_search;
+		}
+	} else if (err) {
+		SSDFS_ERR("fail to find protected PEBs: "
+			  "start_peb %llu, pebs_count %u, err %d\n",
+			  env->found->start_peb,
+			  env->found->pebs_count, err);
+		goto finish_fast_search;
+	}
+
+	err = ssdfs_find_last_sb_seg_for_protected_peb(env);
+	if (err == -EAGAIN) {
+		*SSDFS_RECOVERY_CUR_OFF_PTR(env) = env->found->middle_offset;
+		err = ssdfs_recovery_protected_section_fast_search(env);
+		if (err == -ENODATA || err == -E2BIG) {
+			SSDFS_DBG("SEARCH FINISHED: "
+				  "nothing was found\n");
+			goto finish_fast_search;
+		} else if (err) {
+			SSDFS_ERR("fail to find last SB segment: "
+				  "err %d\n", err);
+			goto finish_fast_search;
+		}
+	} else if (err == -ENODATA || err == -E2BIG) {
+			SSDFS_DBG("SEARCH FINISHED: "
+				  "nothing was found\n");
+			goto finish_fast_search;
+	} else if (err) {
+		SSDFS_ERR("fail to find last SB segment: "
+			  "err %d\n", err);
+		goto finish_fast_search;
+	}
+
+finish_fast_search:
+	return err;
+}
diff --git a/fs/ssdfs/recovery_slow_search.c b/fs/ssdfs/recovery_slow_search.c
new file mode 100644
index 000000000000..ca4d12b24ab3
--- /dev/null
+++ b/fs/ssdfs/recovery_slow_search.c
@@ -0,0 +1,585 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/recovery_slow_search.c - slow superblock search.
+ *
+ * Copyright (c) 2020-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#include <linux/slab.h>
+#include <linux/kthread.h>
+#include <linux/pagevec.h>
+#include <linux/blkdev.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "page_array.h"
+#include "page_vector.h"
+#include "peb.h"
+#include "segment_bitmap.h"
+#include "peb_mapping_table.h"
+#include "recovery.h"
+
+#include <trace/events/ssdfs.h>
+
+int ssdfs_find_latest_valid_sb_segment2(struct ssdfs_recovery_env *env)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+#endif /* CONFIG_SSDFS_DEBUG */
+	struct ssdfs_volume_header *last_vh;
+	u64 dev_size;
+	u64 cur_main_sb_peb, cur_copy_sb_peb;
+	u64 start_peb, next_peb;
+	u64 start_offset;
+	u64 step;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->fsi);
+	BUG_ON(!env->sbi.vh_buf);
+	BUG_ON(!env->fsi->devops->read);
+	BUG_ON(!is_ssdfs_magic_valid(&SSDFS_VH(env->sbi.vh_buf)->magic));
+	BUG_ON(!is_ssdfs_volume_header_csum_valid(env->sbi.vh_buf, hdr_size));
+
+	SSDFS_DBG("env %p, env->sbi.vh_buf %p\n", env, env->sbi.vh_buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	dev_size = env->fsi->devops->device_size(env->fsi->sb);
+	step = env->fsi->erasesize;
+
+try_next_peb:
+	if (kthread_should_stop()) {
+		err = -ENODATA;
+		goto rollback_valid_vh;
+	}
+
+	last_vh = SSDFS_VH(env->sbi.vh_buf);
+	cur_main_sb_peb = SSDFS_MAIN_SB_PEB(last_vh, SSDFS_CUR_SB_SEG);
+	cur_copy_sb_peb = SSDFS_COPY_SB_PEB(last_vh, SSDFS_CUR_SB_SEG);
+
+	if (cur_main_sb_peb != env->sbi.last_log.peb_id &&
+	    cur_copy_sb_peb != env->sbi.last_log.peb_id) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("volume header is corrupted\n");
+		SSDFS_DBG("cur_main_sb_peb %llu, cur_copy_sb_peb %llu, "
+			  "read PEB %llu\n",
+			  cur_main_sb_peb, cur_copy_sb_peb,
+			  env->sbi.last_log.peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto continue_search;
+	}
+
+	if (cur_main_sb_peb == env->sbi.last_log.peb_id) {
+		if (!is_cur_main_sb_peb_exhausted(env))
+			goto end_search;
+	} else {
+		if (!is_cur_copy_sb_peb_exhausted(env))
+			goto end_search;
+	}
+
+	err = ssdfs_check_next_sb_pebs_pair(env);
+	if (err == -E2BIG)
+		goto continue_search;
+	else if (err == -ENODATA || err == -ENOENT)
+		goto check_reserved_sb_pebs_pair;
+	else if (!err)
+		goto try_next_peb;
+
+check_reserved_sb_pebs_pair:
+	if (kthread_should_stop()) {
+		err = -ENODATA;
+		goto rollback_valid_vh;
+	}
+
+	err = ssdfs_check_reserved_sb_pebs_pair(env);
+	if (err == -E2BIG || err == -ENODATA || err == -ENOENT)
+		goto continue_search;
+	else if (!err)
+		goto try_next_peb;
+
+continue_search:
+	if (kthread_should_stop()) {
+		err = -ENODATA;
+		goto rollback_valid_vh;
+	}
+
+	start_offset = *SSDFS_RECOVERY_CUR_OFF_PTR(env) + env->fsi->erasesize;
+	start_peb = start_offset / env->fsi->erasesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_peb %llu, start_offset %llu, "
+		  "end_offset %llu\n",
+		  start_peb, start_offset,
+		  SSDFS_RECOVERY_UPPER_OFF(env));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_find_any_valid_volume_header2(env,
+						    start_offset,
+						    SSDFS_RECOVERY_UPPER_OFF(env),
+						    step);
+	if (err == -E2BIG) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find any valid header: "
+			  "peb_id %llu\n",
+			  start_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto end_search;
+	} else if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find any valid header: "
+			  "peb_id %llu\n",
+			  start_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto rollback_valid_vh;
+	}
+
+	if (kthread_should_stop()) {
+		err = -ENODATA;
+		goto rollback_valid_vh;
+	}
+
+	if (*SSDFS_RECOVERY_CUR_OFF_PTR(env) >= U64_MAX) {
+		err = -ENODATA;
+		goto rollback_valid_vh;
+	}
+
+	next_peb = *SSDFS_RECOVERY_CUR_OFF_PTR(env) / env->fsi->erasesize;
+
+	err = ssdfs_find_any_valid_sb_segment2(env, next_peb);
+	if (err == -E2BIG) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find any valid header: "
+			  "peb_id %llu\n",
+			  start_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto end_search;
+	} else if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find any valid sb seg: "
+			  "peb_id %llu\n",
+			  next_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto rollback_valid_vh;
+	} else
+		goto try_next_peb;
+
+rollback_valid_vh:
+	ssdfs_restore_sb_info2(env);
+
+end_search:
+	return err;
+}
+
+static inline
+bool need_continue_search(struct ssdfs_recovery_env *env)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_off %llu, upper_off %llu\n",
+		  *SSDFS_RECOVERY_CUR_OFF_PTR(env),
+		  SSDFS_RECOVERY_UPPER_OFF(env));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return *SSDFS_RECOVERY_CUR_OFF_PTR(env) < SSDFS_RECOVERY_UPPER_OFF(env);
+}
+
+static
+int ssdfs_recovery_first_phase_slow_search(struct ssdfs_recovery_env *env)
+{
+	u64 threshold_peb;
+	u64 peb_id;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->fsi);
+	BUG_ON(!env->sbi.vh_buf);
+
+	SSDFS_DBG("env %p, env->sbi.vh_buf %p\n", env, env->sbi.vh_buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+try_another_search:
+	if (kthread_should_stop()) {
+		err = -ENOENT;
+		goto finish_first_phase;
+	}
+
+	threshold_peb = *SSDFS_RECOVERY_CUR_OFF_PTR(env) / env->fsi->erasesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_off %llu, threshold_peb %llu\n",
+		  *SSDFS_RECOVERY_CUR_OFF_PTR(env),
+		  threshold_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_find_any_valid_sb_segment2(env, threshold_peb);
+	if (err == -E2BIG) {
+		ssdfs_restore_sb_info2(env);
+		err = ssdfs_find_last_sb_seg_outside_fragment(env);
+		if (err == -ENODATA || err == -ENOENT) {
+			if (kthread_should_stop()) {
+				err = -ENOENT;
+				goto finish_first_phase;
+			}
+
+			if (need_continue_search(env)) {
+				ssdfs_restore_sb_info2(env);
+
+				peb_id = *SSDFS_RECOVERY_CUR_OFF_PTR(env) /
+							env->fsi->erasesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("cur_off %llu, peb %llu\n",
+					  *SSDFS_RECOVERY_CUR_OFF_PTR(env),
+					  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				err = __ssdfs_find_any_valid_volume_header2(env,
+					    *SSDFS_RECOVERY_CUR_OFF_PTR(env),
+					    SSDFS_RECOVERY_UPPER_OFF(env),
+					    env->fsi->erasesize);
+				if (err) {
+					SSDFS_DBG("valid magic is not found\n");
+					goto finish_first_phase;
+				} else
+					goto try_another_search;
+			} else
+				goto finish_first_phase;
+		} else
+			goto finish_first_phase;
+	} else if (err == -ENODATA || err == -ENOENT) {
+		if (kthread_should_stop())
+			err = -ENOENT;
+		else
+			err = -EAGAIN;
+
+		goto finish_first_phase;
+	} else if (err)
+		goto finish_first_phase;
+
+	if (kthread_should_stop()) {
+		err = -ENOENT;
+		goto finish_first_phase;
+	}
+
+	err = ssdfs_find_latest_valid_sb_segment2(env);
+	if (err == -ENODATA || err == -ENOENT) {
+		if (kthread_should_stop()) {
+			err = -ENOENT;
+			goto finish_first_phase;
+		}
+
+		if (need_continue_search(env)) {
+			ssdfs_restore_sb_info2(env);
+
+			peb_id = *SSDFS_RECOVERY_CUR_OFF_PTR(env) /
+						env->fsi->erasesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cur_off %llu, peb %llu\n",
+				  *SSDFS_RECOVERY_CUR_OFF_PTR(env),
+				  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			err = __ssdfs_find_any_valid_volume_header2(env,
+					*SSDFS_RECOVERY_CUR_OFF_PTR(env),
+					SSDFS_RECOVERY_UPPER_OFF(env),
+					env->fsi->erasesize);
+				if (err) {
+					SSDFS_DBG("valid magic is not found\n");
+					goto finish_first_phase;
+				} else
+					goto try_another_search;
+		} else
+			goto finish_first_phase;
+	}
+
+finish_first_phase:
+	return err;
+}
+
+static
+int ssdfs_recovery_second_phase_slow_search(struct ssdfs_recovery_env *env)
+{
+	u64 threshold_peb;
+	u64 peb_id;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->fsi);
+	BUG_ON(!env->sbi.vh_buf);
+
+	SSDFS_DBG("env %p, env->sbi.vh_buf %p\n", env, env->sbi.vh_buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_second_slow_try_possible(env)) {
+		SSDFS_DBG("there is no room for second slow try\n");
+		return -EAGAIN;
+	}
+
+	SSDFS_RECOVERY_SET_SECOND_SLOW_TRY(env);
+
+try_another_search:
+	if (kthread_should_stop())
+		return -ENOENT;
+
+	peb_id = *SSDFS_RECOVERY_CUR_OFF_PTR(env) /
+				env->fsi->erasesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_off %llu, peb %llu\n",
+		  *SSDFS_RECOVERY_CUR_OFF_PTR(env),
+		  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_find_any_valid_volume_header2(env,
+					*SSDFS_RECOVERY_CUR_OFF_PTR(env),
+					SSDFS_RECOVERY_UPPER_OFF(env),
+					env->fsi->erasesize);
+	if (err) {
+		SSDFS_DBG("valid magic is not detected\n");
+		return err;
+	}
+
+	if (kthread_should_stop())
+		return -ENOENT;
+
+	threshold_peb = *SSDFS_RECOVERY_CUR_OFF_PTR(env) / env->fsi->erasesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_off %llu, threshold_peb %llu\n",
+		  *SSDFS_RECOVERY_CUR_OFF_PTR(env),
+		  threshold_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_find_any_valid_sb_segment2(env, threshold_peb);
+	if (err == -E2BIG) {
+		ssdfs_restore_sb_info2(env);
+		err = ssdfs_find_last_sb_seg_outside_fragment(env);
+		if (err == -ENODATA || err == -ENOENT) {
+			if (kthread_should_stop()) {
+				err = -ENOENT;
+				goto finish_second_phase;
+			}
+
+			if (need_continue_search(env)) {
+				ssdfs_restore_sb_info2(env);
+				goto try_another_search;
+			} else
+				goto finish_second_phase;
+		} else
+			goto finish_second_phase;
+	} else if (err == -ENODATA || err == -ENOENT) {
+		if (kthread_should_stop())
+			err = -ENOENT;
+		else
+			err = -EAGAIN;
+
+		goto finish_second_phase;
+	} else if (err)
+		goto finish_second_phase;
+
+	if (kthread_should_stop()) {
+		err = -ENOENT;
+		goto finish_second_phase;
+	}
+
+	err = ssdfs_find_latest_valid_sb_segment2(env);
+	if (err == -ENODATA || err == -ENOENT) {
+		if (kthread_should_stop()) {
+			err = -ENOENT;
+			goto finish_second_phase;
+		}
+
+		if (need_continue_search(env)) {
+			ssdfs_restore_sb_info2(env);
+			goto try_another_search;
+		} else
+			goto finish_second_phase;
+	}
+
+finish_second_phase:
+	return err;
+}
+
+static
+int ssdfs_recovery_third_phase_slow_search(struct ssdfs_recovery_env *env)
+{
+	u64 threshold_peb;
+	u64 peb_id;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->fsi);
+	BUG_ON(!env->sbi.vh_buf);
+
+	SSDFS_DBG("env %p, env->sbi.vh_buf %p\n", env, env->sbi.vh_buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_third_slow_try_possible(env)) {
+		SSDFS_DBG("there is no room for third slow try\n");
+		return -ENODATA;
+	}
+
+	SSDFS_RECOVERY_SET_THIRD_SLOW_TRY(env);
+
+try_another_search:
+	if (kthread_should_stop())
+		return -ENOENT;
+
+	peb_id = *SSDFS_RECOVERY_CUR_OFF_PTR(env) /
+				env->fsi->erasesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_off %llu, peb %llu\n",
+		  *SSDFS_RECOVERY_CUR_OFF_PTR(env),
+		  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_find_any_valid_volume_header2(env,
+					*SSDFS_RECOVERY_CUR_OFF_PTR(env),
+					SSDFS_RECOVERY_UPPER_OFF(env),
+					env->fsi->erasesize);
+	if (err) {
+		SSDFS_DBG("valid magic is not detected\n");
+		return err;
+	}
+
+	if (kthread_should_stop())
+		return -ENOENT;
+
+	threshold_peb = *SSDFS_RECOVERY_CUR_OFF_PTR(env) / env->fsi->erasesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_off %llu, threshold_peb %llu\n",
+		  *SSDFS_RECOVERY_CUR_OFF_PTR(env),
+		  threshold_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_find_any_valid_sb_segment2(env, threshold_peb);
+	if (err == -E2BIG) {
+		ssdfs_restore_sb_info2(env);
+		err = ssdfs_find_last_sb_seg_outside_fragment(env);
+		if (err == -ENODATA || err == -ENOENT) {
+			if (kthread_should_stop()) {
+				err = -ENOENT;
+				goto finish_third_phase;
+			}
+
+			if (need_continue_search(env)) {
+				ssdfs_restore_sb_info2(env);
+				goto try_another_search;
+			} else
+				goto finish_third_phase;
+		} else
+			goto finish_third_phase;
+	}  else if (err)
+		goto finish_third_phase;
+
+	if (kthread_should_stop()) {
+		err = -ENOENT;
+		goto finish_third_phase;
+	}
+
+	err = ssdfs_find_latest_valid_sb_segment2(env);
+	if (err == -ENODATA || err == -ENOENT) {
+		if (kthread_should_stop()) {
+			err = -ENOENT;
+			goto finish_third_phase;
+		}
+
+		if (need_continue_search(env)) {
+			ssdfs_restore_sb_info2(env);
+			goto try_another_search;
+		} else
+			goto finish_third_phase;
+	}
+
+finish_third_phase:
+	return err;
+}
+
+int ssdfs_recovery_try_slow_search(struct ssdfs_recovery_env *env)
+{
+	struct ssdfs_found_protected_peb *protected_peb;
+	struct ssdfs_volume_header *vh;
+	size_t vh_size = sizeof(struct ssdfs_volume_header);
+	bool magic_valid = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->found);
+	BUG_ON(!env->sbi.vh_buf);
+
+	SSDFS_DBG("env %p, start_peb %llu, pebs_count %u\n",
+		  env, env->found->start_peb, env->found->pebs_count);
+	SSDFS_DBG("env->lower_offset %llu, env->upper_offset %llu\n",
+		  env->found->lower_offset, env->found->upper_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	protected_peb = &env->found->array[SSDFS_LAST_CNO_PEB_INDEX];
+
+	if (protected_peb->peb.peb_id >= U64_MAX) {
+		SSDFS_DBG("fragment is empty\n");
+		return -ENODATA;
+	}
+
+	err = ssdfs_read_checked_sb_info3(env, protected_peb->peb.peb_id, 0);
+	vh = SSDFS_VH(env->sbi.vh_buf);
+	magic_valid = is_ssdfs_magic_valid(&vh->magic);
+
+	if (err || !magic_valid) {
+		err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("peb %llu is corrupted\n",
+			  protected_peb->peb.peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_search;
+	} else {
+		ssdfs_memcpy(&env->last_vh, 0, vh_size,
+			     env->sbi.vh_buf, 0, vh_size,
+			     vh_size);
+		ssdfs_backup_sb_info2(env);
+	}
+
+	if (env->found->start_peb == 0)
+		env->found->lower_offset = SSDFS_RESERVED_VBR_SIZE;
+	else {
+		env->found->lower_offset =
+			env->found->start_peb * env->fsi->erasesize;
+	}
+
+	env->found->upper_offset = (env->found->start_peb +
+					env->found->pebs_count - 1);
+	env->found->upper_offset *= env->fsi->erasesize;
+
+	SSDFS_RECOVERY_SET_FIRST_SLOW_TRY(env);
+
+	err = ssdfs_recovery_first_phase_slow_search(env);
+	if (err == -EAGAIN || err == -E2BIG ||
+	    err == -ENODATA || err == -ENOENT) {
+		if (kthread_should_stop()) {
+			err = -ENOENT;
+			goto finish_search;
+		}
+
+		err = ssdfs_recovery_second_phase_slow_search(env);
+		if (err == -EAGAIN || err == -E2BIG ||
+		    err == -ENODATA || err == -ENOENT) {
+			if (kthread_should_stop()) {
+				err = -ENOENT;
+				goto finish_search;
+			}
+
+			err = ssdfs_recovery_third_phase_slow_search(env);
+		}
+	}
+
+finish_search:
+	return err;
+}
diff --git a/fs/ssdfs/recovery_thread.c b/fs/ssdfs/recovery_thread.c
new file mode 100644
index 000000000000..cd1424762059
--- /dev/null
+++ b/fs/ssdfs/recovery_thread.c
@@ -0,0 +1,1196 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/recovery_thread.c - recovery thread's logic.
+ *
+ * Copyright (c) 2019-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#include <linux/slab.h>
+#include <linux/kthread.h>
+#include <linux/pagevec.h>
+#include <linux/blkdev.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "page_array.h"
+#include "page_vector.h"
+#include "peb.h"
+#include "segment_bitmap.h"
+#include "peb_mapping_table.h"
+#include "recovery.h"
+
+#include <trace/events/ssdfs.h>
+
+void ssdfs_backup_sb_info2(struct ssdfs_recovery_env *env)
+{
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+	size_t footer_size = sizeof(struct ssdfs_log_footer);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env);
+	BUG_ON(!env->sbi.vh_buf || !env->sbi.vs_buf);
+	BUG_ON(!env->sbi_backup.vh_buf || !env->sbi_backup.vs_buf);
+
+	SSDFS_DBG("last_log: leb_id %llu, peb_id %llu, "
+		  "page_offset %u, pages_count %u, "
+		  "volume state: free_pages %llu, timestamp %#llx, "
+		  "cno %#llx, fs_state %#x\n",
+		  env->sbi.last_log.leb_id,
+		  env->sbi.last_log.peb_id,
+		  env->sbi.last_log.page_offset,
+		  env->sbi.last_log.pages_count,
+		  le64_to_cpu(SSDFS_VS(env->sbi.vs_buf)->free_pages),
+		  le64_to_cpu(SSDFS_VS(env->sbi.vs_buf)->timestamp),
+		  le64_to_cpu(SSDFS_VS(env->sbi.vs_buf)->cno),
+		  le16_to_cpu(SSDFS_VS(env->sbi.vs_buf)->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_memcpy(env->sbi_backup.vh_buf, 0, hdr_size,
+		     env->sbi.vh_buf, 0, hdr_size,
+		     hdr_size);
+	ssdfs_memcpy(env->sbi_backup.vs_buf, 0, footer_size,
+		     env->sbi.vs_buf, 0, footer_size,
+		     footer_size);
+	ssdfs_memcpy(&env->sbi_backup.last_log,
+		     0, sizeof(struct ssdfs_peb_extent),
+		     &env->sbi.last_log,
+		     0, sizeof(struct ssdfs_peb_extent),
+		     sizeof(struct ssdfs_peb_extent));
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("last_log: leb_id %llu, peb_id %llu, "
+		  "page_offset %u, pages_count %u, "
+		  "volume state: free_pages %llu, timestamp %#llx, "
+		  "cno %#llx, fs_state %#x\n",
+		  env->sbi.last_log.leb_id,
+		  env->sbi.last_log.peb_id,
+		  env->sbi.last_log.page_offset,
+		  env->sbi.last_log.pages_count,
+		  le64_to_cpu(SSDFS_VS(env->sbi.vs_buf)->free_pages),
+		  le64_to_cpu(SSDFS_VS(env->sbi.vs_buf)->timestamp),
+		  le64_to_cpu(SSDFS_VS(env->sbi.vs_buf)->cno),
+		  le16_to_cpu(SSDFS_VS(env->sbi.vs_buf)->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+void ssdfs_restore_sb_info2(struct ssdfs_recovery_env *env)
+{
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+	size_t footer_size = sizeof(struct ssdfs_log_footer);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env);
+	BUG_ON(!env->sbi.vh_buf || !env->sbi.vs_buf);
+	BUG_ON(!env->sbi_backup.vh_buf || !env->sbi_backup.vs_buf);
+
+	SSDFS_DBG("last_log: leb_id %llu, peb_id %llu, "
+		  "page_offset %u, pages_count %u, "
+		  "volume state: free_pages %llu, timestamp %#llx, "
+		  "cno %#llx, fs_state %#x\n",
+		  env->sbi.last_log.leb_id,
+		  env->sbi.last_log.peb_id,
+		  env->sbi.last_log.page_offset,
+		  env->sbi.last_log.pages_count,
+		  le64_to_cpu(SSDFS_VS(env->sbi.vs_buf)->free_pages),
+		  le64_to_cpu(SSDFS_VS(env->sbi.vs_buf)->timestamp),
+		  le64_to_cpu(SSDFS_VS(env->sbi.vs_buf)->cno),
+		  le16_to_cpu(SSDFS_VS(env->sbi.vs_buf)->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_memcpy(env->sbi.vh_buf, 0, hdr_size,
+		     env->sbi_backup.vh_buf, 0, hdr_size,
+		     hdr_size);
+	ssdfs_memcpy(env->sbi.vs_buf, 0, footer_size,
+		     env->sbi_backup.vs_buf, 0, footer_size,
+		     footer_size);
+	ssdfs_memcpy(&env->sbi.last_log,
+		     0, sizeof(struct ssdfs_peb_extent),
+		     &env->sbi_backup.last_log,
+		     0, sizeof(struct ssdfs_peb_extent),
+		     sizeof(struct ssdfs_peb_extent));
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("last_log: leb_id %llu, peb_id %llu, "
+		  "page_offset %u, pages_count %u, "
+		  "volume state: free_pages %llu, timestamp %#llx, "
+		  "cno %#llx, fs_state %#x\n",
+		  env->sbi.last_log.leb_id,
+		  env->sbi.last_log.peb_id,
+		  env->sbi.last_log.page_offset,
+		  env->sbi.last_log.pages_count,
+		  le64_to_cpu(SSDFS_VS(env->sbi.vs_buf)->free_pages),
+		  le64_to_cpu(SSDFS_VS(env->sbi.vs_buf)->timestamp),
+		  le64_to_cpu(SSDFS_VS(env->sbi.vs_buf)->cno),
+		  le16_to_cpu(SSDFS_VS(env->sbi.vs_buf)->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+int ssdfs_read_checked_sb_info3(struct ssdfs_recovery_env *env,
+				u64 peb_id, u32 pages_off)
+{
+	u32 lf_off;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->fsi);
+
+	SSDFS_DBG("env %p, peb_id %llu, pages_off %u\n",
+		  env, peb_id, pages_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_read_checked_segment_header(env->fsi, peb_id, pages_off,
+						env->sbi.vh_buf, true);
+	if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("volume header is corrupted: "
+			  "peb_id %llu, offset %d, err %d\n",
+			  peb_id, pages_off, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	}
+
+	lf_off = SSDFS_LOG_FOOTER_OFF(env->sbi.vh_buf);
+
+	err = ssdfs_read_checked_log_footer(env->fsi,
+					    SSDFS_SEG_HDR(env->sbi.vh_buf),
+					    peb_id, lf_off, env->sbi.vs_buf,
+					    true);
+	if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("log footer is corrupted: "
+			  "peb_id %llu, offset %d, err %d\n",
+			  peb_id, lf_off, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	}
+
+	return 0;
+}
+
+static inline
+int ssdfs_read_and_check_volume_header(struct ssdfs_recovery_env *env,
+					u64 offset)
+{
+	struct super_block *sb;
+	struct ssdfs_volume_header *vh;
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+	u64 dev_size;
+	bool magic_valid, crc_valid, hdr_consistent;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->fsi);
+	BUG_ON(!env->fsi->devops->read);
+
+	SSDFS_DBG("env %p, offset %llu\n",
+		  env, offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	sb = env->fsi->sb;
+	dev_size = env->fsi->devops->device_size(sb);
+
+	err = env->fsi->devops->read(sb, offset, hdr_size,
+				     env->sbi.vh_buf);
+	if (err)
+		goto found_corrupted_peb;
+
+	err = -ENODATA;
+
+	vh = SSDFS_VH(env->sbi.vh_buf);
+	magic_valid = is_ssdfs_magic_valid(&vh->magic);
+	if (magic_valid) {
+		crc_valid = is_ssdfs_volume_header_csum_valid(env->sbi.vh_buf,
+								hdr_size);
+		hdr_consistent = is_ssdfs_volume_header_consistent(env->fsi, vh,
+								   dev_size);
+
+		if (crc_valid && hdr_consistent) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("found offset %llu\n",
+				  offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return 0;
+		}
+	}
+
+found_corrupted_peb:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("peb %llu (offset %llu) is corrupted\n",
+		  offset / env->fsi->erasesize, offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+int __ssdfs_find_any_valid_volume_header2(struct ssdfs_recovery_env *env,
+					  u64 start_offset,
+					  u64 end_offset,
+					  u64 step)
+{
+	u64 dev_size;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->fsi);
+	BUG_ON(!env->fsi->devops->read);
+
+	SSDFS_DBG("env %p, start_offset %llu, "
+		  "end_offset %llu, step %llu\n",
+		  env, start_offset, end_offset, step);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	dev_size = env->fsi->devops->device_size(env->fsi->sb);
+	end_offset = min_t(u64, dev_size, end_offset);
+
+	*SSDFS_RECOVERY_CUR_OFF_PTR(env) = start_offset;
+
+	if (start_offset >= end_offset) {
+		err = -E2BIG;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_offset %llu, end_offset %llu, err %d\n",
+			  start_offset, end_offset, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	}
+
+	while (*SSDFS_RECOVERY_CUR_OFF_PTR(env) < end_offset) {
+		if (kthread_should_stop())
+			return -ENOENT;
+
+		err = ssdfs_read_and_check_volume_header(env,
+					*SSDFS_RECOVERY_CUR_OFF_PTR(env));
+		if (!err) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("found offset %llu\n",
+				  *SSDFS_RECOVERY_CUR_OFF_PTR(env));
+#endif /* CONFIG_SSDFS_DEBUG */
+			return 0;
+		}
+
+		*SSDFS_RECOVERY_CUR_OFF_PTR(env) += step;
+	}
+
+	return -E2BIG;
+}
+
+int ssdfs_find_any_valid_sb_segment2(struct ssdfs_recovery_env *env,
+				     u64 threshold_peb)
+{
+	size_t vh_size = sizeof(struct ssdfs_volume_header);
+	struct ssdfs_volume_header *vh;
+	struct ssdfs_segment_header *seg_hdr;
+	u64 dev_size;
+	u64 start_peb;
+	loff_t start_offset, next_offset;
+	u64 last_cno, cno;
+	__le64 peb1, peb2;
+	__le64 leb1, leb2;
+	u64 checked_pebs[SSDFS_SB_CHAIN_MAX][SSDFS_SB_SEG_COPY_MAX];
+	u64 step;
+	int i, j;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->found || !env->fsi);
+	BUG_ON(!env->fsi->devops->read);
+
+	SSDFS_DBG("env %p, start_peb %llu, "
+		  "pebs_count %u, threshold_peb %llu\n",
+		  env, env->found->start_peb,
+		  env->found->pebs_count, threshold_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	dev_size = env->fsi->devops->device_size(env->fsi->sb);
+	step = env->fsi->erasesize;
+
+	start_peb = max_t(u64,
+			*SSDFS_RECOVERY_CUR_OFF_PTR(env) / env->fsi->erasesize,
+			threshold_peb);
+	start_offset = start_peb * env->fsi->erasesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_peb %llu, start_offset %llu, "
+		  "end_offset %llu\n",
+		  start_peb, start_offset,
+		  SSDFS_RECOVERY_UPPER_OFF(env));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*SSDFS_RECOVERY_CUR_OFF_PTR(env) = start_offset;
+
+	if (start_offset >= SSDFS_RECOVERY_UPPER_OFF(env)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_offset %llu >= end_offset %llu\n",
+			  start_offset, SSDFS_RECOVERY_UPPER_OFF(env));
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -E2BIG;
+	}
+
+	i = SSDFS_SB_CHAIN_MAX;
+	memset(checked_pebs, 0xFF,
+		(SSDFS_SB_CHAIN_MAX * sizeof(u64)) +
+		(SSDFS_SB_SEG_COPY_MAX * sizeof(u64)));
+
+try_next_volume_portion:
+	ssdfs_memcpy(&env->last_vh, 0, vh_size,
+		     env->sbi.vh_buf, 0, vh_size,
+		     vh_size);
+	last_cno = le64_to_cpu(SSDFS_SEG_HDR(env->sbi.vh_buf)->cno);
+
+try_again:
+	if (kthread_should_stop())
+		return -ENODATA;
+
+	switch (i) {
+	case SSDFS_SB_CHAIN_MAX:
+		i = SSDFS_CUR_SB_SEG;
+		break;
+
+	case SSDFS_CUR_SB_SEG:
+		i = SSDFS_NEXT_SB_SEG;
+		break;
+
+	case SSDFS_NEXT_SB_SEG:
+		i = SSDFS_RESERVED_SB_SEG;
+		break;
+
+	default:
+		start_offset = (threshold_peb * env->fsi->erasesize) + step;
+		start_offset = max_t(u64, start_offset,
+				     *SSDFS_RECOVERY_CUR_OFF_PTR(env) + step);
+		*SSDFS_RECOVERY_CUR_OFF_PTR(env) = start_offset;
+		err = __ssdfs_find_any_valid_volume_header2(env, start_offset,
+					SSDFS_RECOVERY_UPPER_OFF(env), step);
+		if (!err) {
+			i = SSDFS_SB_CHAIN_MAX;
+			threshold_peb = *SSDFS_RECOVERY_CUR_OFF_PTR(env);
+			threshold_peb /= env->fsi->erasesize;
+			goto try_next_volume_portion;
+		}
+
+		/* the fragment is checked completely */
+		return err;
+	}
+
+	err = -ENODATA;
+
+	for (j = SSDFS_MAIN_SB_SEG; j < SSDFS_SB_SEG_COPY_MAX; j++) {
+		u64 leb_id = le64_to_cpu(env->last_vh.sb_pebs[i][j].leb_id);
+		u64 peb_id = le64_to_cpu(env->last_vh.sb_pebs[i][j].peb_id);
+		u16 seg_type;
+		u32 erasesize = env->fsi->erasesize;
+
+		if (kthread_should_stop())
+			return -ENODATA;
+
+		if (peb_id == U64_MAX || leb_id == U64_MAX) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("invalid peb_id %llu, leb_id %llu, "
+				  "sb_chain %d, sb_copy %d\n",
+				  leb_id, peb_id, i, j);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("leb_id %llu, peb_id %llu, "
+			  "checked_peb %llu, threshold_peb %llu\n",
+			  leb_id, peb_id,
+			  checked_pebs[i][j],
+			  threshold_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (checked_pebs[i][j] == peb_id)
+			continue;
+		else
+			checked_pebs[i][j] = peb_id;
+
+		next_offset = peb_id * erasesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("peb_id %llu, next_offset %llu, "
+			  "cur_offset %llu, end_offset %llu\n",
+			  peb_id, next_offset,
+			  *SSDFS_RECOVERY_CUR_OFF_PTR(env),
+			  SSDFS_RECOVERY_UPPER_OFF(env));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (next_offset >= SSDFS_RECOVERY_UPPER_OFF(env)) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find valid SB segment: "
+				  "next_offset %llu >= end_offset %llu\n",
+				  next_offset,
+				  SSDFS_RECOVERY_UPPER_OFF(env));
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		}
+
+		if ((env->found->start_peb * erasesize) > next_offset) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find valid SB segment: "
+				  "next_offset %llu >= start_offset %llu\n",
+				  next_offset,
+				  env->found->start_peb * erasesize);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		}
+
+		err = ssdfs_read_checked_sb_info3(env, peb_id, 0);
+		if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("peb_id %llu is corrupted: err %d\n",
+				  peb_id, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		}
+
+		env->sbi.last_log.leb_id = leb_id;
+		env->sbi.last_log.peb_id = peb_id;
+		env->sbi.last_log.page_offset = 0;
+		env->sbi.last_log.pages_count =
+			SSDFS_LOG_PAGES(env->sbi.vh_buf);
+
+		seg_hdr = SSDFS_SEG_HDR(env->sbi.vh_buf);
+		seg_type = SSDFS_SEG_TYPE(seg_hdr);
+
+		if (seg_type == SSDFS_SB_SEG_TYPE) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("PEB %llu has been found\n",
+				  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return 0;
+		} else {
+			err = -EIO;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("PEB %llu is not sb segment\n",
+				  peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+
+		if (!err)
+			goto compare_vh_info;
+	}
+
+	if (err) {
+		ssdfs_memcpy(env->sbi.vh_buf, 0, vh_size,
+			     &env->last_vh, 0, vh_size,
+			     vh_size);
+		goto try_again;
+	}
+
+compare_vh_info:
+	vh = SSDFS_VH(env->sbi.vh_buf);
+	seg_hdr = SSDFS_SEG_HDR(env->sbi.vh_buf);
+	leb1 = env->last_vh.sb_pebs[SSDFS_CUR_SB_SEG][SSDFS_MAIN_SB_SEG].leb_id;
+	leb2 = vh->sb_pebs[SSDFS_CUR_SB_SEG][SSDFS_MAIN_SB_SEG].leb_id;
+	peb1 = env->last_vh.sb_pebs[SSDFS_CUR_SB_SEG][SSDFS_MAIN_SB_SEG].peb_id;
+	peb2 = vh->sb_pebs[SSDFS_CUR_SB_SEG][SSDFS_MAIN_SB_SEG].peb_id;
+	cno = le64_to_cpu(seg_hdr->cno);
+
+	if (cno > last_cno && (leb1 != leb2 || peb1 != peb2)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cno %llu, last_cno %llu, "
+			  "leb1 %llu, leb2 %llu, "
+			  "peb1 %llu, peb2 %llu\n",
+			  cno, last_cno,
+			  le64_to_cpu(leb1), le64_to_cpu(leb2),
+			  le64_to_cpu(peb1), le64_to_cpu(peb2));
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto try_again;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("unable to find any valid segment with superblocks chain\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+	return err;
+}
+
+static inline
+bool is_sb_peb_exhausted(struct ssdfs_recovery_env *env,
+			 u64 leb_id, u64 peb_id)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+#endif /* CONFIG_SSDFS_DEBUG */
+	struct ssdfs_peb_extent checking_page;
+	u64 pages_per_peb;
+	u16 sb_seg_log_pages;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->fsi);
+	BUG_ON(!env->sbi.vh_buf);
+	BUG_ON(!env->fsi->devops->read);
+	BUG_ON(!is_ssdfs_magic_valid(&SSDFS_VH(env->sbi.vh_buf)->magic));
+	BUG_ON(!is_ssdfs_volume_header_csum_valid(env->sbi.vh_buf, hdr_size));
+
+	SSDFS_DBG("env %p, env->sbi.vh_buf %p, "
+		  "leb_id %llu, peb_id %llu\n",
+		  env, env->sbi.vh_buf,
+		  leb_id, peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	sb_seg_log_pages =
+		le16_to_cpu(SSDFS_VH(env->sbi.vh_buf)->sb_seg_log_pages);
+
+	if (!env->fsi->devops->can_write_page) {
+		SSDFS_CRIT("fail to find latest valid sb info: "
+			   "can_write_page is not supported\n");
+		return true;
+	}
+
+	if (leb_id >= U64_MAX || peb_id >= U64_MAX) {
+		SSDFS_ERR("invalid leb_id %llu or peb_id %llu\n",
+			  leb_id, peb_id);
+		return true;
+	}
+
+	if (env->fsi->is_zns_device) {
+		pages_per_peb = div64_u64(env->fsi->zone_capacity,
+					  env->fsi->pagesize);
+	} else
+		pages_per_peb = env->fsi->pages_per_peb;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(pages_per_peb >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	checking_page.leb_id = leb_id;
+	checking_page.peb_id = peb_id;
+	checking_page.page_offset = (u32)pages_per_peb - sb_seg_log_pages;
+	checking_page.pages_count = 1;
+
+	err = ssdfs_can_write_sb_log(env->fsi->sb, &checking_page);
+	if (!err)
+		return false;
+
+	return true;
+}
+
+bool is_cur_main_sb_peb_exhausted(struct ssdfs_recovery_env *env)
+{
+	u64 leb_id;
+	u64 peb_id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->fsi);
+	BUG_ON(!env->sbi.vh_buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	leb_id = SSDFS_MAIN_SB_LEB(SSDFS_VH(env->sbi.vh_buf),
+				   SSDFS_CUR_SB_SEG);
+	peb_id = SSDFS_MAIN_SB_PEB(SSDFS_VH(env->sbi.vh_buf),
+				   SSDFS_CUR_SB_SEG);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("env %p, env->sbi.vh_buf %p, "
+		  "leb_id %llu, peb_id %llu\n",
+		  env, env->sbi.vh_buf,
+		  leb_id, peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return is_sb_peb_exhausted(env, leb_id, peb_id);
+}
+
+bool is_cur_copy_sb_peb_exhausted(struct ssdfs_recovery_env *env)
+{
+	u64 leb_id;
+	u64 peb_id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->fsi);
+	BUG_ON(!env->sbi.vh_buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	leb_id = SSDFS_COPY_SB_LEB(SSDFS_VH(env->sbi.vh_buf),
+				   SSDFS_CUR_SB_SEG);
+	peb_id = SSDFS_COPY_SB_PEB(SSDFS_VH(env->sbi.vh_buf),
+				   SSDFS_CUR_SB_SEG);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("env %p, env->sbi.vh_buf %p, "
+		  "leb_id %llu, peb_id %llu\n",
+		  env, env->sbi.vh_buf,
+		  leb_id, peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return is_sb_peb_exhausted(env, leb_id, peb_id);
+}
+
+static
+int ssdfs_check_sb_segs_sequence(struct ssdfs_recovery_env *env)
+{
+	u16 seg_type;
+	u64 cno1, cno2;
+	u64 cur_peb, next_peb, prev_peb;
+	u64 cur_leb, next_leb, prev_leb;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->fsi);
+	BUG_ON(!env->sbi.vh_buf);
+
+	SSDFS_DBG("env %p, env->sbi.vh_buf %p\n", env, env->sbi.vh_buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	seg_type = SSDFS_SEG_TYPE(SSDFS_SEG_HDR(env->sbi.vh_buf));
+	if (seg_type != SSDFS_SB_SEG_TYPE) {
+		SSDFS_DBG("invalid segment type\n");
+		return -ENODATA;
+	}
+
+	cno1 = SSDFS_SEG_CNO(env->sbi_backup.vh_buf);
+	cno2 = SSDFS_SEG_CNO(env->sbi.vh_buf);
+	if (cno1 >= cno2) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("last cno %llu is not lesser than read cno %llu\n",
+			  cno1, cno2);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	next_peb = SSDFS_MAIN_SB_PEB(SSDFS_VH(env->sbi_backup.vh_buf),
+					SSDFS_NEXT_SB_SEG);
+	cur_peb = SSDFS_MAIN_SB_PEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_CUR_SB_SEG);
+	if (next_peb != cur_peb) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("next_peb %llu doesn't equal to cur_peb %llu\n",
+			  next_peb, cur_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	prev_peb = SSDFS_MAIN_SB_PEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_PREV_SB_SEG);
+	cur_peb = SSDFS_MAIN_SB_PEB(SSDFS_VH(env->sbi_backup.vh_buf),
+					SSDFS_CUR_SB_SEG);
+	if (prev_peb != cur_peb) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("prev_peb %llu doesn't equal to cur_peb %llu\n",
+			  prev_peb, cur_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	next_leb = SSDFS_MAIN_SB_LEB(SSDFS_VH(env->sbi_backup.vh_buf),
+					SSDFS_NEXT_SB_SEG);
+	cur_leb = SSDFS_MAIN_SB_LEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_CUR_SB_SEG);
+	if (next_leb != cur_leb) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("next_leb %llu doesn't equal to cur_leb %llu\n",
+			  next_leb, cur_leb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	prev_leb = SSDFS_MAIN_SB_LEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_PREV_SB_SEG);
+	cur_leb = SSDFS_MAIN_SB_LEB(SSDFS_VH(env->sbi_backup.vh_buf),
+					SSDFS_CUR_SB_SEG);
+	if (prev_leb != cur_leb) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("prev_leb %llu doesn't equal to cur_leb %llu\n",
+			  prev_leb, cur_leb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	next_peb = SSDFS_COPY_SB_PEB(SSDFS_VH(env->sbi_backup.vh_buf),
+					SSDFS_NEXT_SB_SEG);
+	cur_peb = SSDFS_COPY_SB_PEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_CUR_SB_SEG);
+	if (next_peb != cur_peb) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("next_peb %llu doesn't equal to cur_peb %llu\n",
+			  next_peb, cur_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	prev_peb = SSDFS_COPY_SB_PEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_PREV_SB_SEG);
+	cur_peb = SSDFS_COPY_SB_PEB(SSDFS_VH(env->sbi_backup.vh_buf),
+					SSDFS_CUR_SB_SEG);
+	if (prev_peb != cur_peb) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("prev_peb %llu doesn't equal to cur_peb %llu\n",
+			  prev_peb, cur_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	next_leb = SSDFS_COPY_SB_LEB(SSDFS_VH(env->sbi_backup.vh_buf),
+					SSDFS_NEXT_SB_SEG);
+	cur_leb = SSDFS_COPY_SB_LEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_CUR_SB_SEG);
+	if (next_leb != cur_leb) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("next_leb %llu doesn't equal to cur_leb %llu\n",
+			  next_leb, cur_leb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	prev_leb = SSDFS_COPY_SB_LEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_PREV_SB_SEG);
+	cur_leb = SSDFS_COPY_SB_LEB(SSDFS_VH(env->sbi_backup.vh_buf),
+					SSDFS_CUR_SB_SEG);
+	if (prev_leb != cur_leb) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("prev_leb %llu doesn't equal to cur_leb %llu\n",
+			  prev_leb, cur_leb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
+int ssdfs_check_next_sb_pebs_pair(struct ssdfs_recovery_env *env)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+#endif /* CONFIG_SSDFS_DEBUG */
+	u64 next_leb;
+	u64 next_peb;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->found || !env->fsi);
+	BUG_ON(!env->sbi.vh_buf);
+	BUG_ON(!is_ssdfs_magic_valid(&SSDFS_VH(env->sbi.vh_buf)->magic));
+	BUG_ON(!is_ssdfs_volume_header_csum_valid(env->sbi.vh_buf, hdr_size));
+
+	SSDFS_DBG("env %p, env->sbi.vh_buf %p, "
+		  "env->start_peb %llu, env->pebs_count %u\n",
+		  env, env->sbi.vh_buf,
+		  env->found->start_peb, env->found->pebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	next_leb = SSDFS_MAIN_SB_LEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_NEXT_SB_SEG);
+	next_peb = SSDFS_MAIN_SB_PEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_NEXT_SB_SEG);
+	if (next_leb == U64_MAX || next_peb == U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid next_leb %llu, next_peb %llu\n",
+			  next_leb, next_peb);
+		goto end_next_peb_check;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("MAIN: next_leb %llu, next_peb %llu\n",
+		  next_leb, next_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (next_peb < env->found->start_peb ||
+	    next_peb >= (env->found->start_peb + env->found->pebs_count)) {
+		err = -E2BIG;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("next_peb %llu, start_peb %llu, pebs_count %u\n",
+			  next_peb,
+			  env->found->start_peb,
+			  env->found->pebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto end_next_peb_check;
+	}
+
+	ssdfs_backup_sb_info2(env);
+
+	err = ssdfs_read_checked_sb_info3(env, next_peb, 0);
+	if (!err) {
+		env->sbi.last_log.leb_id = next_leb;
+		env->sbi.last_log.peb_id = next_peb;
+		env->sbi.last_log.page_offset = 0;
+		env->sbi.last_log.pages_count =
+				SSDFS_LOG_PAGES(env->sbi.vh_buf);
+
+		err = ssdfs_check_sb_segs_sequence(env);
+		if (!err)
+			goto end_next_peb_check;
+	}
+
+	ssdfs_restore_sb_info2(env);
+	err = 0; /* try to read the backup copy */
+
+	next_leb = SSDFS_COPY_SB_LEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_NEXT_SB_SEG);
+	next_peb = SSDFS_COPY_SB_PEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_NEXT_SB_SEG);
+	if (next_leb >= U64_MAX || next_peb >= U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid next_leb %llu, next_peb %llu\n",
+			  next_leb, next_peb);
+		goto end_next_peb_check;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("COPY: next_leb %llu, next_peb %llu\n",
+		  next_leb, next_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (next_peb < env->found->start_peb ||
+	    next_peb >= (env->found->start_peb + env->found->pebs_count)) {
+		err = -E2BIG;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("next_peb %llu, start_peb %llu, pebs_count %u\n",
+			  next_peb,
+			  env->found->start_peb,
+			  env->found->pebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto end_next_peb_check;
+	}
+
+	err = ssdfs_read_checked_sb_info3(env, next_peb, 0);
+	if (!err) {
+		env->sbi.last_log.leb_id = next_leb;
+		env->sbi.last_log.peb_id = next_peb;
+		env->sbi.last_log.page_offset = 0;
+		env->sbi.last_log.pages_count =
+				SSDFS_LOG_PAGES(env->sbi.vh_buf);
+
+		err = ssdfs_check_sb_segs_sequence(env);
+		if (!err)
+			goto end_next_peb_check;
+	}
+
+	ssdfs_restore_sb_info2(env);
+
+end_next_peb_check:
+	return err;
+}
+
+int ssdfs_check_reserved_sb_pebs_pair(struct ssdfs_recovery_env *env)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	size_t hdr_size = sizeof(struct ssdfs_segment_header);
+#endif /* CONFIG_SSDFS_DEBUG */
+	u64 reserved_leb;
+	u64 reserved_peb;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env || !env->found || !env->fsi);
+	BUG_ON(!env->sbi.vh_buf);
+	BUG_ON(!is_ssdfs_magic_valid(&SSDFS_VH(env->sbi.vh_buf)->magic));
+	BUG_ON(!is_ssdfs_volume_header_csum_valid(env->sbi.vh_buf, hdr_size));
+
+	SSDFS_DBG("env %p, env->sbi.vh_buf %p, "
+		  "start_peb %llu, pebs_count %u\n",
+		  env, env->sbi.vh_buf,
+		  env->found->start_peb,
+		  env->found->pebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	reserved_leb = SSDFS_MAIN_SB_LEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_RESERVED_SB_SEG);
+	reserved_peb = SSDFS_MAIN_SB_PEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_RESERVED_SB_SEG);
+	if (reserved_leb >= U64_MAX || reserved_peb >= U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid reserved_leb %llu, reserved_peb %llu\n",
+			  reserved_leb, reserved_peb);
+		goto end_reserved_peb_check;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("MAIN: reserved_leb %llu, reserved_peb %llu\n",
+		  reserved_leb, reserved_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (reserved_peb < env->found->start_peb ||
+	    reserved_peb >= (env->found->start_peb + env->found->pebs_count)) {
+		err = -E2BIG;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("reserved_peb %llu, start_peb %llu, pebs_count %u\n",
+			  reserved_peb,
+			  env->found->start_peb,
+			  env->found->pebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto end_reserved_peb_check;
+	}
+
+	ssdfs_backup_sb_info2(env);
+
+	err = ssdfs_read_checked_sb_info3(env, reserved_peb, 0);
+	if (!err) {
+		env->sbi.last_log.leb_id = reserved_leb;
+		env->sbi.last_log.peb_id = reserved_peb;
+		env->sbi.last_log.page_offset = 0;
+		env->sbi.last_log.pages_count =
+				SSDFS_LOG_PAGES(env->sbi.vh_buf);
+		goto end_reserved_peb_check;
+	}
+
+	ssdfs_restore_sb_info2(env);
+	err = 0; /* try to read the backup copy */
+
+	reserved_leb = SSDFS_COPY_SB_LEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_RESERVED_SB_SEG);
+	reserved_peb = SSDFS_COPY_SB_PEB(SSDFS_VH(env->sbi.vh_buf),
+					SSDFS_RESERVED_SB_SEG);
+	if (reserved_leb >= U64_MAX || reserved_peb >= U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid reserved_leb %llu, reserved_peb %llu\n",
+			  reserved_leb, reserved_peb);
+		goto end_reserved_peb_check;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("COPY: reserved_leb %llu, reserved_peb %llu\n",
+		  reserved_leb, reserved_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (reserved_peb < env->found->start_peb ||
+	    reserved_peb >= (env->found->start_peb + env->found->pebs_count)) {
+		err = -E2BIG;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("reserved_peb %llu, start_peb %llu, pebs_count %u\n",
+			  reserved_peb,
+			  env->found->start_peb,
+			  env->found->pebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto end_reserved_peb_check;
+	}
+
+	err = ssdfs_read_checked_sb_info3(env, reserved_peb, 0);
+	if (!err) {
+		env->sbi.last_log.leb_id = reserved_leb;
+		env->sbi.last_log.peb_id = reserved_peb;
+		env->sbi.last_log.page_offset = 0;
+		env->sbi.last_log.pages_count =
+				SSDFS_LOG_PAGES(env->sbi.vh_buf);
+		goto end_reserved_peb_check;
+	}
+
+	ssdfs_restore_sb_info2(env);
+
+end_reserved_peb_check:
+	return err;
+}
+
+static inline
+bool has_recovery_job(struct ssdfs_recovery_env *env)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return atomic_read(&env->state) == SSDFS_START_RECOVERY;
+}
+
+int ssdfs_recovery_thread_func(void *data);
+
+static
+struct ssdfs_thread_descriptor recovery_thread = {
+	.threadfn = ssdfs_recovery_thread_func,
+	.fmt = "ssdfs-recovery-%u",
+};
+
+#define RECOVERY_THREAD_WAKE_CONDITION(env) \
+	(kthread_should_stop() || has_recovery_job(env))
+
+/*
+ * ssdfs_recovery_thread_func() - main fuction of recovery thread
+ * @data: pointer on data object
+ *
+ * This function is main fuction of recovery thread.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+int ssdfs_recovery_thread_func(void *data)
+{
+	struct ssdfs_recovery_env *env = data;
+	wait_queue_head_t *wait_queue;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (!env) {
+		SSDFS_ERR("pointer on environment is NULL\n");
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("recovery thread: env %p\n", env);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	wait_queue = &env->request_wait_queue;
+
+repeat:
+	if (kthread_should_stop()) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("stop recovery thread: env %p\n", env);
+#endif /* CONFIG_SSDFS_DEBUG */
+		complete_all(&env->thread.full_stop);
+		return 0;
+	}
+
+	if (atomic_read(&env->state) != SSDFS_START_RECOVERY)
+		goto sleep_recovery_thread;
+
+	if (env->found->start_peb >= U64_MAX ||
+	    env->found->pebs_count >= U32_MAX) {
+		err = -EINVAL;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("invalid input: "
+			  "start_peb %llu, pebs_count %u\n",
+			  env->found->start_peb,
+			  env->found->pebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_recovery;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_peb %llu, pebs_count %u\n",
+		  env->found->start_peb,
+		  env->found->pebs_count);
+	SSDFS_DBG("search_phase %#x\n",
+		  env->found->search_phase);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (env->found->search_phase) {
+	case SSDFS_RECOVERY_FAST_SEARCH:
+		err = ssdfs_recovery_try_fast_search(env);
+		if (err) {
+			if (kthread_should_stop()) {
+				err = -ENOENT;
+				goto finish_recovery;
+			}
+		}
+		break;
+
+	case SSDFS_RECOVERY_SLOW_SEARCH:
+		err = ssdfs_recovery_try_slow_search(env);
+		if (err) {
+			if (kthread_should_stop()) {
+				err = -ENOENT;
+				goto finish_recovery;
+			}
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("search has not been requested: "
+			  "search_phase %#x\n",
+			  env->found->search_phase);
+		goto finish_recovery;
+	}
+
+finish_recovery:
+	env->err = err;
+
+	if (env->err)
+		atomic_set(&env->state, SSDFS_RECOVERY_FAILED);
+	else
+		atomic_set(&env->state, SSDFS_RECOVERY_FINISHED);
+
+	wake_up_all(&env->result_wait_queue);
+
+sleep_recovery_thread:
+	wait_event_interruptible(*wait_queue,
+				 RECOVERY_THREAD_WAKE_CONDITION(env));
+	goto repeat;
+}
+
+/*
+ * ssdfs_recovery_start_thread() - start recovery's thread
+ * @env: recovery environment
+ * @id: thread's ID
+ */
+int ssdfs_recovery_start_thread(struct ssdfs_recovery_env *env,
+				u32 id)
+{
+	ssdfs_threadfn threadfn;
+	const char *fmt;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env);
+
+	SSDFS_DBG("env %p, id %u\n", env, id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	threadfn = recovery_thread.threadfn;
+	fmt = recovery_thread.fmt;
+
+	env->thread.task = kthread_create(threadfn, env, fmt, id);
+	if (IS_ERR_OR_NULL(env->thread.task)) {
+		err = (env->thread.task == NULL ? -ENOMEM :
+						PTR_ERR(env->thread.task));
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+		} else {
+			if (err == 0)
+				err = -ERANGE;
+			SSDFS_ERR("fail to start recovery thread: "
+				  "id %u, err %d\n", id, err);
+		}
+
+		return err;
+	}
+
+	init_waitqueue_head(&env->request_wait_queue);
+	init_waitqueue_entry(&env->thread.wait, env->thread.task);
+	add_wait_queue(&env->request_wait_queue, &env->thread.wait);
+	init_waitqueue_head(&env->result_wait_queue);
+	init_completion(&env->thread.full_stop);
+
+	wake_up_process(env->thread.task);
+
+	return 0;
+}
+
+/*
+ * ssdfs_recovery_stop_thread() - stop recovery thread
+ * @env: recovery environment
+ */
+int ssdfs_recovery_stop_thread(struct ssdfs_recovery_env *env)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!env);
+
+	SSDFS_DBG("env %p\n", env);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!env->thread.task)
+		return 0;
+
+	err = kthread_stop(env->thread.task);
+	if (err == -EINTR) {
+		/*
+		 * Ignore this error.
+		 * The wake_up_process() was never called.
+		 */
+		return 0;
+	} else if (unlikely(err)) {
+		SSDFS_WARN("thread function had some issue: err %d\n",
+			    err);
+		return err;
+	}
+
+	finish_wait(&env->request_wait_queue, &env->thread.wait);
+	env->thread.task = NULL;
+
+	err = SSDFS_WAIT_COMPLETION(&env->thread.full_stop);
+	if (unlikely(err)) {
+		SSDFS_ERR("stop thread fails: err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
-- 
2.34.1

