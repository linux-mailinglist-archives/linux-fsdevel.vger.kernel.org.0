Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288464EA8C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 09:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiC2HvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 03:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiC2HvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:51:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD8A1E521C
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a1so23508477wrh.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ts3mTqn+OR+1m0lFg26zb/XHneWH9pyV4TFEIfdRYus=;
        b=Tzx/pGbfbrIRF19xD2nqGwr6nuRfACofKq1NbaG1GZ8EdKOS/3In9GvEKKIIFv3P9R
         dUbMn7tGfzCP6NLt4rqFxbYZuDBcc+rD1zAesL+FCDsX82YHuGXAcvEVx3XrXXiN5YZO
         sf4zKTw0Jql+JcyjTz3yY5F1zf03gFXY7QboxNjkP7JS+WGiy0h9t5MNEWKsLLdAjE46
         bqzyoue9yfXRBW0s20Zpwao4zNAW8M8I/DqsafjIBxRRJoqeEJH2t6R00ysCB/tqqezE
         p5rBuNvvhwy/9pUqWDrnu+sVrcxiYQwLSh0wrh9eHyzfgWRjEWV3lHuiVmGDNw4kSQLN
         B8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ts3mTqn+OR+1m0lFg26zb/XHneWH9pyV4TFEIfdRYus=;
        b=QBZFcRvhok9Avi47bAFv8rRf+AYXKFxHNtKjFS0ZMC5sKdkXpu7s9/cIprjS/OlcbJ
         4E115iAzXXrnjfGrSKuic+1PGk1SNPkYFHWLO0a63n3lO2De2Q40966SSNsi/ssEcdoC
         /0rkuWhg3S8olDvZHUvLlLArvIUUyz74x6lfuLWIVOxFzpTQKqgSlAYyG+c+N4Cd42JI
         BbBdCSjOZJdD9zR/wLjCCMJyn/Cgq0nmSL8Lb/TiD0Dk1M0pY5Vrrlnq6GhLnjbnJiLC
         FRgpWpRFD3XktQka/wOgDVrn+AQHbfCCnKRUUFn9wyhpVf5Bun4rUnLchpCy25vKClUo
         xKwg==
X-Gm-Message-State: AOAM531NFg9oTikOR/l9mV9gvYiziQxcQvuE+fgLApnFTNAdOyLWZ/cE
        IWqJviUnLaKM4V4S2tnhIP/SWBen0aY=
X-Google-Smtp-Source: ABdhPJwvDKKo1/6LImFNdzO5MN2TWcH6k4e9v7S0PGB096hk/NLVzsxdraF4niXjiXlXc4NWvUlZUA==
X-Received: by 2002:a5d:4688:0:b0:203:f0cc:da10 with SMTP id u8-20020a5d4688000000b00203f0ccda10mr29213470wrq.87.1648540164804;
        Tue, 29 Mar 2022 00:49:24 -0700 (PDT)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm1534342wms.25.2022.03.29.00.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:24 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 11/16] fsnotify: allow adding an inode mark without pinning inode
Date:   Tue, 29 Mar 2022 10:48:59 +0300
Message-Id: <20220329074904.2980320-12-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329074904.2980320-1-amir73il@gmail.com>
References: <20220329074904.2980320-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fsnotify_add_mark() and variants implicitly take a reference on inode
when attaching a mark to an inode.

Make that behavior opt-out with the mark flag FSNOTIFY_MARK_FLAG_NO_IREF.

Instead of taking the inode reference when attaching connector to inode
and dropping the inode reference when detaching connector from inode,
take the inode reference on attach of the first mark that wants to hold
an inode reference and drop the inode reference on detach of the last
mark that wants to hold an inode reference.

Backends can "upgrade" an existing mark to take an inode reference, but
cannot "downgrade" a mark with inode reference to release the refernce.

This leaves the choice to the backend whether or not to pin the inode
when adding an inode mark.

This is intended to be used when adding a mark with ignored mask that is
used for optimization in cases where group can afford getting unneeded
events and reinstate the mark with ignored mask when inode is accessed
again after being evicted.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/mark.c                 | 68 +++++++++++++++++++++++++-------
 include/linux/fsnotify_backend.h |  2 +
 2 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 94d53f9d2b5f..3e4de16c0593 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -116,20 +116,61 @@ __u32 fsnotify_conn_mask(struct fsnotify_mark_connector *conn)
 	return *fsnotify_conn_mask_p(conn);
 }
 
-static void __fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
+/*
+ * Update the proxy refcount on inode maintainted by connector.
+ *
+ * When it's time to drop the proxy refcount, clear the HAS_IREF flag
+ * and return the inode object.  fsnotify_drop_object() will be resonsible
+ * for doing iput() outside of spinlocks when last mark that wanted iref
+ * is detached.
+ *
+ * Note that the proxy refcount is NOT dropped if backend only sets the
+ * NO_IREF mark flag and does detach the mark!
+ */
+static struct inode *fsnotify_update_iref(struct fsnotify_mark_connector *conn,
+					  bool want_iref)
+{
+	bool has_iref = conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF;
+	struct inode *inode = NULL;
+
+	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE ||
+	    want_iref == has_iref)
+		return NULL;
+
+	if (want_iref) {
+		/* Pin inode if any mark wants inode refcount held */
+		ihold(fsnotify_conn_inode(conn));
+		conn->flags |= FSNOTIFY_CONN_FLAG_HAS_IREF;
+	} else {
+		/* Unpin inode after detach of last mark that wanted iref */
+		inode = fsnotify_conn_inode(conn);
+		conn->flags &= ~FSNOTIFY_CONN_FLAG_HAS_IREF;
+	}
+
+	return inode;
+}
+
+static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
 	u32 new_mask = 0;
+	bool want_iref = false;
 	struct fsnotify_mark *mark;
 
 	assert_spin_locked(&conn->lock);
 	/* We can get detached connector here when inode is getting unlinked. */
 	if (!fsnotify_valid_obj_type(conn->type))
-		return;
+		return NULL;
 	hlist_for_each_entry(mark, &conn->list, obj_list) {
-		if (mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED)
-			new_mask |= fsnotify_calc_mask(mark);
+		if (!(mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED))
+			continue;
+		new_mask |= fsnotify_calc_mask(mark);
+		if (conn->type == FSNOTIFY_OBJ_TYPE_INODE &&
+		    !(mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
+			want_iref = true;
 	}
 	*fsnotify_conn_mask_p(conn) = new_mask;
+
+	return fsnotify_update_iref(conn, want_iref);
 }
 
 /*
@@ -198,6 +239,10 @@ static void *fsnotify_detach_connector_from_object(
 	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
 		inode = fsnotify_conn_inode(conn);
 		inode->i_fsnotify_mask = 0;
+
+		/* Unpin inode when detaching from connector */
+		if (!(conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF))
+			inode = NULL;
 	} else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
 		fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
 	} else if (conn->type == FSNOTIFY_OBJ_TYPE_SB) {
@@ -208,6 +253,7 @@ static void *fsnotify_detach_connector_from_object(
 	rcu_assign_pointer(*(conn->obj), NULL);
 	conn->obj = NULL;
 	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
+	conn->flags = 0;
 
 	return inode;
 }
@@ -259,7 +305,8 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 		objp = fsnotify_detach_connector_from_object(conn, &type);
 		free_conn = true;
 	} else {
-		__fsnotify_recalc_mask(conn);
+		objp = __fsnotify_recalc_mask(conn);
+		type = conn->type;
 	}
 	WRITE_ONCE(mark->connector, NULL);
 	spin_unlock(&conn->lock);
@@ -484,7 +531,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 					       unsigned int obj_type,
 					       __kernel_fsid_t *fsid)
 {
-	struct inode *inode = NULL;
 	struct fsnotify_mark_connector *conn;
 
 	conn = kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_KERNEL);
@@ -492,6 +538,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		return -ENOMEM;
 	spin_lock_init(&conn->lock);
 	INIT_HLIST_HEAD(&conn->list);
+	conn->flags = 0;
 	conn->type = obj_type;
 	conn->obj = connp;
 	/* Cache fsid of filesystem containing the object */
@@ -502,10 +549,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		conn->fsid.val[0] = conn->fsid.val[1] = 0;
 		conn->flags = 0;
 	}
-	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
-		inode = fsnotify_conn_inode(conn);
-		ihold(inode);
-	}
 	fsnotify_get_sb_connectors(conn);
 
 	/*
@@ -514,8 +557,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	 */
 	if (cmpxchg(connp, NULL, conn)) {
 		/* Someone else created list structure for us */
-		if (inode)
-			iput(inode);
 		fsnotify_put_sb_connectors(conn);
 		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
 	}
@@ -677,8 +718,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	if (ret)
 		goto err;
 
-	if (mark->mask || mark->ignored_mask)
-		fsnotify_recalc_mask(mark->connector);
+	fsnotify_recalc_mask(mark->connector);
 
 	return ret;
 err:
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 083333ad451c..df58439a86fa 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -472,6 +472,7 @@ struct fsnotify_mark_connector {
 	spinlock_t lock;
 	unsigned short type;	/* Type of object [lock] */
 #define FSNOTIFY_CONN_FLAG_HAS_FSID	0x01
+#define FSNOTIFY_CONN_FLAG_HAS_IREF	0x02
 	unsigned short flags;	/* flags [lock] */
 	__kernel_fsid_t fsid;	/* fsid of filesystem containing object */
 	union {
@@ -526,6 +527,7 @@ struct fsnotify_mark {
 #define FSNOTIFY_MARK_FLAG_IN_ONESHOT		0x0020
 #define FSNOTIFY_MARK_FLAG_ALLOW_DUPS		0x0040
 #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x0100
+#define FSNOTIFY_MARK_FLAG_NO_IREF		0x0200
 	unsigned int flags;		/* flags [mark->lock] */
 };
 
-- 
2.25.1

