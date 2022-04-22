Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427C250B6CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447280AbiDVMIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447343AbiDVMHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D88756C0C
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y10so15921628ejw.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9T6Q4zdWuiNah4N126by/dtMphNQa1luMMXI9WbPAQ=;
        b=KiwqWFXsfqZZaPvfrB1d+/El7eBrur2TUdgPAYSQlaC1IAJGlExeEBM/gJrjwAij/9
         57FqMyUys/jhdJcLdhPoP66FYhRmFKeUi+Y7YwPSiNLR4qEqqCaU6wkd5bS/DdisG5rb
         UW9wOljSURqR7zqxDWGgHoIW7K2cz66o50V7K4V1VaRx51Qpb2CGs7XfPpeK+a1MWrZZ
         H8kd0JTX273fGH1b4C+sdY/lz+i8yb0A0vcQFOUMfeMcPNoFPKbC5SuMyhXIBcpUImyQ
         s1n9hcgrEwO+/b48kiwWY4VaYtEJkZzpTcRoOc1SR7BJxEGT7mQDl3kc0gomcF6AQRwD
         k34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9T6Q4zdWuiNah4N126by/dtMphNQa1luMMXI9WbPAQ=;
        b=w9XlEW9P4L0vLvTOyVTOFLCNxVn0RKs+o6kdcC4EwbGlUvyHZF3klBnP1qUzFEPNR/
         ht0kWwgu8BhAoHmJVrPj8Kmo+MYvADlK9EKHYP6fDiiexhi78g2ckVHYR82wuhXtyRII
         et6fksrfDnWbNBmWFVhst59k96k/4Zwn3clljbvEjpZVVUxw7gdY0eAxjkFaYFO51i6Z
         VU7JTGtZ7oCm3j/Ocp6B+GIt+WtE+U8a/xGOoBZ5VJPU6wM0z7WGsWAUszrgkx5XX3UV
         fKUNVMbUUdHwhHDVRJnIYIju/61DAEAKxIgUKAG/t4ilBciDR1bMPyT8SHRHncFFCp/j
         bXLg==
X-Gm-Message-State: AOAM531X17gJk/OlB75uhX0hvxXg8VDoXPCzaH33EIGl76NXliV2Q0zZ
        0RCWUpwy17ouvhJhrz+IrPC5p9L7wuU=
X-Google-Smtp-Source: ABdhPJw4xnkT9ZJimZyv/VE5D4zi2zfxkxVO8okYmXrmjH5tpDFFYBHPeN9ktvpRk91IAaVWsMQeWA==
X-Received: by 2002:a17:907:2bf4:b0:6e8:93d4:46e9 with SMTP id gv52-20020a1709072bf400b006e893d446e9mr3861497ejc.69.1650629030660;
        Fri, 22 Apr 2022 05:03:50 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm697026ejv.43.2022.04.22.05.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:50 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 11/16] fsnotify: allow adding an inode mark without pinning inode
Date:   Fri, 22 Apr 2022 15:03:22 +0300
Message-Id: <20220422120327.3459282-12-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422120327.3459282-1-amir73il@gmail.com>
References: <20220422120327.3459282-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/notify/mark.c                 | 79 ++++++++++++++++++++++++--------
 include/linux/fsnotify_backend.h |  2 +
 2 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 982ca2f20ff5..0a06e9e359e7 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -116,20 +116,67 @@ __u32 fsnotify_conn_mask(struct fsnotify_mark_connector *conn)
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
+static void fsnotify_get_inode_ref(struct inode *inode)
+{
+	ihold(inode);
+	atomic_long_inc(&inode->i_sb->s_fsnotify_connectors);
+}
+
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
+		fsnotify_get_inode_ref(fsnotify_conn_inode(conn));
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
@@ -169,12 +216,6 @@ static void fsnotify_connector_destroy_workfn(struct work_struct *work)
 	}
 }
 
-static void fsnotify_get_inode_ref(struct inode *inode)
-{
-	ihold(inode);
-	atomic_long_inc(&inode->i_sb->s_fsnotify_connectors);
-}
-
 static void fsnotify_put_inode_ref(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
@@ -213,6 +254,10 @@ static void *fsnotify_detach_connector_from_object(
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
@@ -274,7 +319,8 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 		objp = fsnotify_detach_connector_from_object(conn, &type);
 		free_conn = true;
 	} else {
-		__fsnotify_recalc_mask(conn);
+		objp = __fsnotify_recalc_mask(conn);
+		type = conn->type;
 	}
 	WRITE_ONCE(mark->connector, NULL);
 	spin_unlock(&conn->lock);
@@ -497,7 +543,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 					       unsigned int obj_type,
 					       __kernel_fsid_t *fsid)
 {
-	struct inode *inode = NULL;
 	struct fsnotify_mark_connector *conn;
 
 	conn = kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_KERNEL);
@@ -505,6 +550,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		return -ENOMEM;
 	spin_lock_init(&conn->lock);
 	INIT_HLIST_HEAD(&conn->list);
+	conn->flags = 0;
 	conn->type = obj_type;
 	conn->obj = connp;
 	/* Cache fsid of filesystem containing the object */
@@ -515,10 +561,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		conn->fsid.val[0] = conn->fsid.val[1] = 0;
 		conn->flags = 0;
 	}
-	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
-		inode = fsnotify_conn_inode(conn);
-		fsnotify_get_inode_ref(inode);
-	}
 	fsnotify_get_sb_connectors(conn);
 
 	/*
@@ -527,8 +569,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	 */
 	if (cmpxchg(connp, NULL, conn)) {
 		/* Someone else created list structure for us */
-		if (inode)
-			fsnotify_put_inode_ref(inode);
 		fsnotify_put_sb_connectors(conn);
 		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
 	}
@@ -690,8 +730,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	if (ret)
 		goto err;
 
-	if (mark->mask || mark->ignored_mask)
-		fsnotify_recalc_mask(mark->connector);
+	fsnotify_recalc_mask(mark->connector);
 
 	return ret;
 err:
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index d62111e83244..9a1a9e78f69f 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -456,6 +456,7 @@ struct fsnotify_mark_connector {
 	spinlock_t lock;
 	unsigned short type;	/* Type of object [lock] */
 #define FSNOTIFY_CONN_FLAG_HAS_FSID	0x01
+#define FSNOTIFY_CONN_FLAG_HAS_IREF	0x02
 	unsigned short flags;	/* flags [lock] */
 	__kernel_fsid_t fsid;	/* fsid of filesystem containing object */
 	union {
@@ -510,6 +511,7 @@ struct fsnotify_mark {
 #define FSNOTIFY_MARK_FLAG_IN_ONESHOT		0x0020
 	/* fanotify mark flags */
 #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x0100
+#define FSNOTIFY_MARK_FLAG_NO_IREF		0x0200
 	unsigned int flags;		/* flags [mark->lock] */
 };
 
-- 
2.35.1

