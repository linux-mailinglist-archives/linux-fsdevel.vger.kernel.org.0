Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F78717CC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 12:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjEaKEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 06:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjEaKEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 06:04:23 -0400
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D02612E
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 03:04:19 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685527104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZzyzkXd70pYEdWJhGutN+U1hmZmD/p5d/wpcM6Ajy+8=;
        b=ZihWgnR2scrQOnB2k5nDPiR/oFSAGcE5oxTl8DJZlC6c35SkDHP860/TT0nEoqYq/lrcq1
        d6CKRaCpb2dkgODgBX/qkpML3eCN0n5h1kziLNHv4ErGYZOVxBG6L8XG40g2Y8QxSO+u0s
        Pr9f8hmxkoCyCfWi4RAZ5pmhxQ/yWCA=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 2/8] mm: vmscan: split unregister_shrinker()
Date:   Wed, 31 May 2023 09:57:36 +0000
Message-Id: <20230531095742.2480623-3-qi.zheng@linux.dev>
In-Reply-To: <20230531095742.2480623-1-qi.zheng@linux.dev>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kirill Tkhai <tkhai@ya.ru>

This and the next patches in this series aim to make
time effect of synchronize_srcu() invisible for user.
The patch splits unregister_shrinker() in two functions:

	unregister_shrinker_delayed_initiate()
	unregister_shrinker_delayed_finalize()

and shrinker users may make the second of them to be called
asynchronous (e.g., from workqueue). Next patches make
superblock shrinker to follow this way, so user-visible
umount() time won't contain delays from synchronize_srcu().

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/shrinker.h |  2 ++
 mm/vmscan.c              | 22 ++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 224293b2dd06..e9d5a19d83fe 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -102,6 +102,8 @@ extern void register_shrinker_prepared(struct shrinker *shrinker);
 extern int __printf(2, 3) register_shrinker(struct shrinker *shrinker,
 					    const char *fmt, ...);
 extern void unregister_shrinker(struct shrinker *shrinker);
+extern void unregister_shrinker_delayed_initiate(struct shrinker *shrinker);
+extern void unregister_shrinker_delayed_finalize(struct shrinker *shrinker);
 extern void free_prealloced_shrinker(struct shrinker *shrinker);
 extern void synchronize_shrinkers(void);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a773e97e152e..baf8d2327d70 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -799,10 +799,7 @@ int register_shrinker(struct shrinker *shrinker, const char *fmt, ...)
 #endif
 EXPORT_SYMBOL(register_shrinker);
 
-/*
- * Remove one
- */
-void unregister_shrinker(struct shrinker *shrinker)
+void unregister_shrinker_delayed_initiate(struct shrinker *shrinker)
 {
 	struct dentry *debugfs_entry;
 	int debugfs_id;
@@ -819,6 +816,13 @@ void unregister_shrinker(struct shrinker *shrinker)
 	mutex_unlock(&shrinker_mutex);
 
 	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
+}
+EXPORT_SYMBOL(unregister_shrinker_delayed_initiate);
+
+void unregister_shrinker_delayed_finalize(struct shrinker *shrinker)
+{
+	if (!shrinker->nr_deferred)
+		return;
 
 	atomic_inc(&shrinker_srcu_generation);
 	synchronize_srcu(&shrinker_srcu);
@@ -826,6 +830,16 @@ void unregister_shrinker(struct shrinker *shrinker)
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
+EXPORT_SYMBOL(unregister_shrinker_delayed_finalize);
+
+/*
+ * Remove one
+ */
+void unregister_shrinker(struct shrinker *shrinker)
+{
+	unregister_shrinker_delayed_initiate(shrinker);
+	unregister_shrinker_delayed_finalize(shrinker);
+}
 EXPORT_SYMBOL(unregister_shrinker);
 
 /**
-- 
2.30.2

