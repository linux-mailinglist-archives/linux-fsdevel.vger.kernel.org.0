Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3D859A9D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 02:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244574AbiHTAGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 20:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241454AbiHTAGP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:06:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767B9C57B6;
        Fri, 19 Aug 2022 17:06:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id w11-20020a17090a380b00b001f73f75a1feso8918714pjb.2;
        Fri, 19 Aug 2022 17:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=r0urdVAKZH+r97LU3eOMfx4g8PQ8jLK6FF0zKigNvZ0=;
        b=F7WRHYVzB80o6Xs6BYj6XMW/5FwBtQufwFCIMWXu/epIA+D3qleqo0x7CGMZpQKrGL
         Gmm3LkWQrH459OnhELRx5LWskchgCoR3eWcdPrP0+AmgTZF6w+89jQ7g59hZQCTcl2Lz
         H0rEdxct6WCXlj0FfoC/JC4deTu5HW/y+uPpcyHBkKSDmyveedHlPsvPhofK8KMICn1r
         waaUtsCgubmfywXryDGDg3ggKNS/XrgTLr0vBCbCaxd5gigcQMqPiP6emelbsDB1F3Ts
         Mj5qOY2iw2/GSwuhlMUGS+J0c27FWLT4PL3xelDKwoQEdhTZdnO4MZ2XTVICqgYSLO7e
         hxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=r0urdVAKZH+r97LU3eOMfx4g8PQ8jLK6FF0zKigNvZ0=;
        b=LkUMjl4qdvqDbShPdgONvL2iNV7GhyVu5//NTt0sFku+g277rJMEELpfvKMAsjFGvZ
         liWOb+JVRU7R39aTTL61zK8n4FngW+XZ195Z++qgvJGo5vSi3J7ALnEjEa6+FChVl0/R
         eFZmEcFPmvVninF6w5kWXuzMHUvHYFgb4JKKU+N6iwnV2kyXjW0XU2WWIgPLMBxSn/gt
         rTv5R527LX8aPW/5XngxV0YfvzZmJm7qJR3jwi+Lfvbjd8EAFYV+sHns+14w/Sx4eM6P
         dfVQKppcalTwvNpKEG7o5qZLsLh30gbuouMKi9VNF24bPv1QlY7EaPDFljMnhiWKBSfx
         mx+w==
X-Gm-Message-State: ACgBeo1/3TLK8Rl02aW3BvIMzP5eGJh4jv25Kn/leycp/L3P7iakZWoV
        gVG8JHbbJTfGaJGwC8Pn7cU=
X-Google-Smtp-Source: AA6agR65e1YvovHGewqdWxEyf+s95nV04zXCKXFK1+we8tiYqDmHn0f1gDC1TK6V2ZKGNWIQE9X8+w==
X-Received: by 2002:a17:902:b28c:b0:172:cfe4:bd2b with SMTP id u12-20020a170902b28c00b00172cfe4bd2bmr1076728plr.44.1660953973499;
        Fri, 19 Aug 2022 17:06:13 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a2f5])
        by smtp.gmail.com with ESMTPSA id i25-20020a631319000000b0041d9e78de05sm3280960pgl.73.2022.08.19.17.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 17:06:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/7] kernfs: Allow kernfs nodes to be deactivated and re-activated
Date:   Fri, 19 Aug 2022 14:05:50 -1000
Message-Id: <20220820000550.367085-7-tj@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820000550.367085-1-tj@kernel.org>
References: <20220820000550.367085-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, kernfs nodes can be created deactivated and activated later to
allow creation of multiple nodes to succeed or fail as a group. Extend this
capability so that kernfs nodes can be deactivated and re-activated anytime
and however many times. This can be used to toggle interface files for
features which can be dynamically turned on and off.

kernfs_activate()'s skip conditions are updated so that it doesn't ignore
re-activations and suppress re-activations of files which are being removed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/kernfs/dir.c        | 89 ++++++++++++++++++++++++++++++------------
 include/linux/kernfs.h |  2 +
 2 files changed, 65 insertions(+), 26 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index f857731598cd..6db031362585 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -483,7 +483,7 @@ static bool kernfs_drain(struct kernfs_node *kn)
 	 * worrying about draining.
 	 */
 	if (atomic_read(&kn->active) == KN_DEACTIVATED_BIAS &&
-	    kernfs_should_drain_open_files(kn))
+	    !kernfs_should_drain_open_files(kn))
 		return false;
 
 	up_write(&root->kernfs_rwsem);
@@ -1321,14 +1321,15 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 }
 
 /**
- * kernfs_activate - activate a node which started deactivated
+ * kernfs_activate - activate a node's subtree
  * @kn: kernfs_node whose subtree is to be activated
  *
- * If the root has KERNFS_ROOT_CREATE_DEACTIVATED set, a newly created node
- * needs to be explicitly activated.  A node which hasn't been activated
- * isn't visible to userland and deactivation is skipped during its
- * removal.  This is useful to construct atomic init sequences where
- * creation of multiple nodes should either succeed or fail atomically.
+ * If newly created on a root w/ %KERNFS_ROOT_CREATE_DEACTIVATED or after a
+ * kernfs_deactivate() call, @kn is deactivated and invisible to userland. This
+ * function activates all nodes in @kn's inclusive subtree making them visible.
+ *
+ * %KERNFS_ROOT_CREATE_DEACTIVATED is useful when constructing init sequences
+ * where creation of multiple nodes should either succeed or fail atomically.
  *
  * The caller is responsible for ensuring that this function is not called
  * after kernfs_remove*() is invoked on @kn.
@@ -1342,7 +1343,7 @@ void kernfs_activate(struct kernfs_node *kn)
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
-		if (pos->flags & KERNFS_ACTIVATED)
+		if (kernfs_active(pos) || (kn->flags & KERNFS_REMOVING))
 			continue;
 
 		WARN_ON_ONCE(pos->parent && RB_EMPTY_NODE(&pos->rb));
@@ -1355,6 +1356,58 @@ void kernfs_activate(struct kernfs_node *kn)
 	up_write(&root->kernfs_rwsem);
 }
 
+static void kernfs_deactivate_locked(struct kernfs_node *kn, bool removing)
+{
+	struct kernfs_root *root = kernfs_root(kn);
+	struct kernfs_node *pos;
+
+	lockdep_assert_held_write(&root->kernfs_rwsem);
+
+	/* prevent any new usage under @kn by deactivating all nodes */
+	pos = NULL;
+	while ((pos = kernfs_next_descendant_post(pos, kn))) {
+		if (kernfs_active(pos))
+			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
+		if (removing)
+			pos->flags |= KERNFS_REMOVING;
+	}
+
+	/*
+	 * No new active usage can be created. Drain existing ones. As
+	 * kernfs_drain() may drop kernfs_rwsem temporarily, pin @pos so that it
+	 * doesn't go away underneath us.
+	 *
+	 * If kernfs_rwsem was released, restart from the beginning. Forward
+	 * progress is guaranteed as a drained node is guaranteed to stay
+	 * drained. In the unlikely case that the loop restart ever becomes a
+	 * problem, we should be able to work around by batching up the
+	 * draining.
+	 */
+	pos = NULL;
+	while ((pos = kernfs_next_descendant_post(pos, kn))) {
+		kernfs_get(pos);
+		if (kernfs_drain(pos))
+			pos = NULL;
+		kernfs_put(pos);
+	}
+}
+
+/**
+ * kernfs_deactivate - deactivate a node's subtree
+ * @kn: kernfs_node whose subtree is to be deactivated
+ *
+ * Deactivate @kn's inclusive subtree. On return, the subtree is invisible to
+ * userland and there are no in-flight file operations.
+ */
+void kernfs_deactivate(struct kernfs_node *kn)
+{
+	struct kernfs_root *root = kernfs_root(kn);
+
+	down_write(&root->kernfs_rwsem);
+	kernfs_deactivate_locked(kn, false);
+	up_write(&root->kernfs_rwsem);
+}
+
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
@@ -1374,26 +1427,12 @@ static void __kernfs_remove(struct kernfs_node *kn)
 
 	pr_debug("kernfs %s: removing\n", kn->name);
 
-	/* prevent any new usage under @kn by deactivating all nodes */
-	pos = NULL;
-	while ((pos = kernfs_next_descendant_post(pos, kn)))
-		if (kernfs_active(pos))
-			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
+	kernfs_deactivate_locked(kn, true);
 
-	/* deactivate and unlink the subtree node-by-node */
+	/* unlink the subtree node-by-node */
 	do {
 		pos = kernfs_leftmost_descendant(kn);
 
-		/*
-		 * kernfs_drain() may drop kernfs_rwsem temporarily and @pos's
-		 * base ref could have been put by someone else by the time
-		 * the function returns.  Make sure it doesn't go away
-		 * underneath us.
-		 */
-		kernfs_get(pos);
-
-		kernfs_drain(pos);
-
 		/*
 		 * kernfs_unlink_sibling() succeeds once per node.  Use it
 		 * to decide who's responsible for cleanups.
@@ -1410,8 +1449,6 @@ static void __kernfs_remove(struct kernfs_node *kn)
 
 			kernfs_put(pos);
 		}
-
-		kernfs_put(pos);
 	} while (pos != kn);
 }
 
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 367044d7708c..657eea1395b6 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -112,6 +112,7 @@ enum kernfs_node_flag {
 	KERNFS_SUICIDED		= 0x0800,
 	KERNFS_EMPTY_DIR	= 0x1000,
 	KERNFS_HAS_RELEASE	= 0x2000,
+	KERNFS_REMOVING		= 0x4000,
 };
 
 /* @flags for kernfs_create_root() */
@@ -429,6 +430,7 @@ struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
 				       const char *name,
 				       struct kernfs_node *target);
 void kernfs_activate(struct kernfs_node *kn);
+void kernfs_deactivate(struct kernfs_node *kn);
 void kernfs_remove(struct kernfs_node *kn);
 void kernfs_break_active_protection(struct kernfs_node *kn);
 void kernfs_unbreak_active_protection(struct kernfs_node *kn);
-- 
2.37.2

