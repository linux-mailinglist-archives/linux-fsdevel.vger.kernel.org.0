Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D0D722F54
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 21:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjFETJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 15:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbjFETJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:09:17 -0400
X-Greylist: delayed 350 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 12:09:09 PDT
Received: from forward206c.mail.yandex.net (forward206c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D555E5D;
        Mon,  5 Jun 2023 12:09:09 -0700 (PDT)
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
        by forward206c.mail.yandex.net (Yandex) with ESMTP id 47156628AA;
        Mon,  5 Jun 2023 22:03:27 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:160b:0:640:acd0:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 37B946003D;
        Mon,  5 Jun 2023 22:03:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id D3YHdS6DcOs0-TqtIfVrH;
        Mon, 05 Jun 2023 22:03:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1685991799;
        bh=+IzLiAr4hGoU+Pviuk7ygHtq+6fMQv9f3smgHpwNKuw=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From;
        b=OGrv/TbDGlW78nIq/v3X13MdFHBKPT4rbxik+/dLXWSsNg3JAt1QziJRND95B7QWd
         t2F1dPFG+s24W3tEx7lNJP1KDrTIoNVWl9dB7AZmq2ZA4ZCtBlOaz2CDlUmD7vcZYK
         NpKTRl0e23MTd0mT9DvzVIrgrnTx7Xf/nVp+2aAg=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From:   Kirill Tkhai <tkhai@ya.ru>
To:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com,
        david@fromorbit.com
Subject: [PATCH v2 2/3] mm: Split unregister_shrinker() in fast and slow part
Date:   Mon,  5 Jun 2023 22:03:13 +0300
Message-Id: <168599179360.70911.4102140966715923751.stgit@pro.pro>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <168599103578.70911.9402374667983518835.stgit@pro.pro>
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This splits unregister_shrinker() in two parts, and this allows
to make the unregistration faster by moving the slow part
in delayed asynchronous work. Note, that the guarantees remain
the same: no do_shrink_slab() calls are possible after the first
part. This will be used in next patch.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 include/linux/shrinker.h |    4 ++++
 mm/vmscan.c              |   35 +++++++++++++++++++++++++++++------
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 224293b2dd06..1cc572fa6070 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -4,6 +4,7 @@
 
 #include <linux/atomic.h>
 #include <linux/types.h>
+#include <linux/rwsem.h>
 
 /*
  * This struct is used to pass information from page reclaim to the shrinkers.
@@ -83,6 +84,7 @@ struct shrinker {
 #endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
+	struct rw_semaphore rwsem;
 };
 #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
 
@@ -102,6 +104,8 @@ extern void register_shrinker_prepared(struct shrinker *shrinker);
 extern int __printf(2, 3) register_shrinker(struct shrinker *shrinker,
 					    const char *fmt, ...);
 extern void unregister_shrinker(struct shrinker *shrinker);
+extern void unregister_shrinker_delayed_initiate(struct shrinker *shrinker);
+extern void unregister_shrinker_delayed_finalize(struct shrinker *shrinker);
 extern void free_prealloced_shrinker(struct shrinker *shrinker);
 extern void synchronize_shrinkers(void);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a773e97e152e..f24fd58dcc2a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -706,6 +706,7 @@ static int __prealloc_shrinker(struct shrinker *shrinker)
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
 
+	init_rwsem(&shrinker->rwsem);
 	return 0;
 }
 
@@ -757,7 +758,9 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	mutex_lock(&shrinker_mutex);
 	list_add_tail_rcu(&shrinker->list, &shrinker_list);
+	down_write(&shrinker->rwsem);
 	shrinker->flags |= SHRINKER_REGISTERED;
+	up_write(&shrinker->rwsem);
 	shrinker_debugfs_add(shrinker);
 	mutex_unlock(&shrinker_mutex);
 }
@@ -802,7 +805,7 @@ EXPORT_SYMBOL(register_shrinker);
 /*
  * Remove one
  */
-void unregister_shrinker(struct shrinker *shrinker)
+void unregister_shrinker_delayed_initiate(struct shrinker *shrinker)
 {
 	struct dentry *debugfs_entry;
 	int debugfs_id;
@@ -812,20 +815,33 @@ void unregister_shrinker(struct shrinker *shrinker)
 
 	mutex_lock(&shrinker_mutex);
 	list_del_rcu(&shrinker->list);
+	down_write(&shrinker->rwsem);
 	shrinker->flags &= ~SHRINKER_REGISTERED;
+	up_write(&shrinker->rwsem);
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
 	debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
 	mutex_unlock(&shrinker_mutex);
 
 	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
+}
+EXPORT_SYMBOL(unregister_shrinker_delayed_initiate);
 
+void unregister_shrinker_delayed_finalize(struct shrinker *shrinker)
+{
 	atomic_inc(&shrinker_srcu_generation);
 	synchronize_srcu(&shrinker_srcu);
 
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
+EXPORT_SYMBOL(unregister_shrinker_delayed_finalize);
+
+void unregister_shrinker(struct shrinker *shrinker)
+{
+	unregister_shrinker_delayed_initiate(shrinker);
+	unregister_shrinker_delayed_finalize(shrinker);
+}
 EXPORT_SYMBOL(unregister_shrinker);
 
 /**
@@ -856,9 +872,15 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 					  : SHRINK_BATCH;
 	long scanned = 0, next_deferred;
 
+	if (!down_read_trylock(&shrinker->rwsem))
+		return 0;
+	if (!(shrinker->flags & SHRINKER_REGISTERED))
+		goto unlock;
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
-	if (freeable == 0 || freeable == SHRINK_EMPTY)
-		return freeable;
+	if (freeable == 0 || freeable == SHRINK_EMPTY) {
+		freed = freeable;
+		goto unlock;
+	}
 
 	/*
 	 * copy the current shrinker scan count into a local variable
@@ -937,6 +959,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	new_nr = add_nr_deferred(next_deferred, shrinker, shrinkctl);
 
 	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
+unlock:
+	up_read(&shrinker->rwsem);
 	return freed;
 }
 
@@ -968,9 +992,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		struct shrinker *shrinker;
 
 		shrinker = idr_find(&shrinker_idr, i);
-		if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
-			if (!shrinker)
-				clear_bit(i, info->map);
+		if (unlikely(!shrinker)) {
+			clear_bit(i, info->map);
 			continue;
 		}
 

