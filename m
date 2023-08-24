Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBC17865E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239627AbjHXDhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239625AbjHXDgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:36:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B21310F2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:36:24 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a32506e90so1060972b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848183; x=1693452983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrI/X5Yh7LcU5jmS4qIzMzIMVvFD9p+WXlgnh63DuQo=;
        b=bi91mAkWfHF+ZGYrAGi8fSfP1rZgaQ9UJQma4R2GISMfzIMSepcMEEtmQfvpPwQ6sZ
         52K3xo34HKG6b4Tb0EhiNBVsZ9PyIACSu80NiXODexlSiTfsepdidiPEL6ktcGMDBKkH
         CWpSVA/inH6bwziARO2vWCSnFe3pz89phQgHiYKVDAZf74s4T/6V3tF34JyKaqboDMmH
         SESxt5Qwuo7Pdz2vKABn2yS97A32aC1lsl9BQ3K0Wakrgi/UtYf3bF0wCw1wYDKP5wJG
         GOFGVNp3DQTv8FP9lay3DWqR5HarnFkL1KQcm6aePLHP9ZUkzjnAXDUEXu0QaA+19pee
         Q3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848183; x=1693452983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrI/X5Yh7LcU5jmS4qIzMzIMVvFD9p+WXlgnh63DuQo=;
        b=jE4blJxAkk1yEnaHdtqThCN2NWBJd/UytZj8NPu6BO4qQVy67Ox4We1XFey2MJeCQ6
         yaiRbwHbIdraybX7cLY1c3LmtC9sUEjjI4tvcSqfmvaobLGP7oPmrmKw9Qnwf9/6ONDI
         WgS8BXutG2tIHrWc8pd3sHl4LSSWh0BF+oUEfd8EK/BOO9dsWFIleVWgddTqqRDdLFaO
         flZ07h85udXmRmKMVcSWnoACNbvs5ek2IaCogafSruT36tSRJzyfW8TdSUYubxpyurHM
         hDA7lUpvKk0I86x8eHOlc/8mSBc3t8yrOycGhcTpYYxm7kFpc89Xp/SEyIDNsnITB7Nt
         VKsw==
X-Gm-Message-State: AOJu0YzfcWKXR5iFCh7FJQ6ECn39o/ZhRbk1UhSW09YJF0usmDNdR0s3
        yvLlKJQZuNi7NlE3ytVG5qpbfA==
X-Google-Smtp-Source: AGHT+IHygFMFVjr3jXqgDVchpFeZd7tEZ1ZJUV56jgY+zNR9KGBBKA6XO9KnSRG3Wm4xupEdPrToWQ==
X-Received: by 2002:a05:6a20:938d:b0:13c:bda3:79c3 with SMTP id x13-20020a056a20938d00b0013cbda379c3mr17537865pzh.4.1692848183684;
        Wed, 23 Aug 2023 20:36:23 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id p16-20020a62ab10000000b0068b6137d144sm2996570pff.30.2023.08.23.20.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:36:23 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, joel@joelfernandes.org,
        christian.koenig@amd.com, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 1/4] mm: move some shrinker-related function declarations to mm/internal.h
Date:   Thu, 24 Aug 2023 11:35:36 +0800
Message-Id: <20230824033539.34570-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824033539.34570-1-zhengqi.arch@bytedance.com>
References: <20230824033539.34570-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/shrinker.h | 19 -------------------
 mm/internal.h            | 26 ++++++++++++++++++++++++++
 mm/shrinker_debug.c      |  2 ++
 3 files changed, 28 insertions(+), 19 deletions(-)

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
index 7499b5ea1cf6..f30bb60e7790 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1155,4 +1155,30 @@ struct vma_prepare {
 	struct vm_area_struct *remove;
 	struct vm_area_struct *remove2;
 };
+
+/* shrinker related functions */
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
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 3ab53fad8876..ee0cddb4530f 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -6,6 +6,8 @@
 #include <linux/shrinker.h>
 #include <linux/memcontrol.h>
 
+#include "internal.h"
+
 /* defined in vmscan.c */
 extern struct rw_semaphore shrinker_rwsem;
 extern struct list_head shrinker_list;
-- 
2.30.2

