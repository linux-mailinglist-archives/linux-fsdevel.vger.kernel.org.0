Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78031771F81
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 13:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjHGLKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 07:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjHGLKg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:10:36 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D1B170B
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 04:10:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-265c94064b8so592249a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 04:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691406609; x=1692011409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8W8qq2Uz0spC2GoySlMERPhgmOL8aWRmiOXTDM010g=;
        b=LtcpivNSr/5U6x0m/uiyeqUuM2dtsqsVmyslCvnMZ+TbsDLmyfYCok7TOqfFwU4aou
         suPwxQHD97VI0Q62GW+ZYHDc8tjkHAC6Y2CfDY4CzUPMlkJryxFMZeRg2u77WPUScUma
         /UWc/sCeR8W9qQ3wk0oPqkWmTEZmPd4YXzSaovoOZwWfn9s/VibhxnVRbQAxTTT4rsLS
         7EPkGC2ZgyKx21jg/v6bd406CHIloRAPbtMcp+52o9Mv0AXgKZgqXOlA0BowU0u6XLn9
         g3j+asxGnqU4OhqCycxU0aToYArdbvRqg5AMoRMXcXqSNLhcPxtT3QmhYn/OoV2pniV3
         od0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406609; x=1692011409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8W8qq2Uz0spC2GoySlMERPhgmOL8aWRmiOXTDM010g=;
        b=U47c0gYXzAflfnw75ldWEZ5NKBJeheP0r73/Yi6GrQ3QJ0U/rLVVRx7aZdMpslQJuP
         ELcFVJf93s0T7sKmSN3tvUDzWMTOLmDcL0q3fK4Xmy31zxOB40ru7/kkIfJjFnD56kAs
         yTsoDy3adJ2PRuP8a/j7k/7m3HgHiFI3qFw11Zo3PQHHV7JqRzcSFpOF5WVIpttBw8xw
         17ezHYBVi2wpARdVPrn5kvBaUv2ElJL0XsplH01ORJ3rYm8nLuJysYTFO8q6qJhT8ZJE
         pN8qw7Er02SnIs7Ceo9Lf2fmV1mvmz4tybs+4R9mb3lnQBAYf18JTDus7RrWN7U0qEqJ
         QobA==
X-Gm-Message-State: ABy/qLZ6lcyJ/sUtS694PBNfJsi1+AwPk5VV76T25bAdJ6dCfDafy740
        udTfU3II30LkZXHzHEdRFWPjIw==
X-Google-Smtp-Source: APBJJlH4Xq2ZH2mKI5CfuqTuY77FQCtuH4PGEB2vg3tzfU2CpFxEqGweFj8X5L0soAOYNhp1I46kQg==
X-Received: by 2002:a17:90a:4104:b0:25c:1ad3:a4a1 with SMTP id u4-20020a17090a410400b0025c1ad3a4a1mr24586808pjf.1.1691406608964;
        Mon, 07 Aug 2023 04:10:08 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:10:08 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, simon.horman@corigine.com,
        dlemoal@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 01/48] mm: move some shrinker-related function declarations to mm/internal.h
Date:   Mon,  7 Aug 2023 19:08:49 +0800
Message-Id: <20230807110936.21819-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following functions are only used inside the mm subsystem, so it's
better to move their declarations to the mm/internal.h file.

1. shrinker_debugfs_add()
2. shrinker_debugfs_detach()
3. shrinker_debugfs_remove()

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/shrinker.h | 19 -------------------
 mm/internal.h            | 28 ++++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 224293b2dd06..8dc15aa37410 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -106,28 +106,9 @@ extern void free_prealloced_shrinker(struct shrinker *shrinker);
 extern void synchronize_shrinkers(void);
 
 #ifdef CONFIG_SHRINKER_DEBUG
-extern int shrinker_debugfs_add(struct shrinker *shrinker);
-extern struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
-					      int *debugfs_id);
-extern void shrinker_debugfs_remove(struct dentry *debugfs_entry,
-				    int debugfs_id);
 extern int __printf(2, 3) shrinker_debugfs_rename(struct shrinker *shrinker,
 						  const char *fmt, ...);
 #else /* CONFIG_SHRINKER_DEBUG */
-static inline int shrinker_debugfs_add(struct shrinker *shrinker)
-{
-	return 0;
-}
-static inline struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
-						     int *debugfs_id)
-{
-	*debugfs_id = -1;
-	return NULL;
-}
-static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
-					   int debugfs_id)
-{
-}
 static inline __printf(2, 3)
 int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 {
diff --git a/mm/internal.h b/mm/internal.h
index 154da4f0d557..6f21926393af 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1143,4 +1143,32 @@ struct vma_prepare {
 	struct vm_area_struct *remove;
 	struct vm_area_struct *remove2;
 };
+
+/*
+ * shrinker related functions
+ */
+
+#ifdef CONFIG_SHRINKER_DEBUG
+extern int shrinker_debugfs_add(struct shrinker *shrinker);
+extern struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
+					      int *debugfs_id);
+extern void shrinker_debugfs_remove(struct dentry *debugfs_entry,
+				    int debugfs_id);
+#else /* CONFIG_SHRINKER_DEBUG */
+static inline int shrinker_debugfs_add(struct shrinker *shrinker)
+{
+	return 0;
+}
+static inline struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
+						     int *debugfs_id)
+{
+	*debugfs_id = -1;
+	return NULL;
+}
+static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
+					   int debugfs_id)
+{
+}
+#endif /* CONFIG_SHRINKER_DEBUG */
+
 #endif	/* __MM_INTERNAL_H */
-- 
2.30.2

