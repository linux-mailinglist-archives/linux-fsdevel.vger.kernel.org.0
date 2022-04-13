Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9DA4FF311
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiDMJNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiDMJMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F518205E2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:54 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m33-20020a05600c3b2100b0038ec0218103so741469wms.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vjMJnOQ2xiLWlxLaltEAkegpH7Np+Ce8U+zcpqIVObE=;
        b=gwKS/LVuofS8tMZnsH60vY6DbrP2TrAFJhn3Mt19OtRdqPNNXQo/yljg6xWtk2D8I6
         Uo/VoW4RynfxOsF/gbZmBSZ/rw2UkteB6/CiPXtwsvmDBvhiSSsi+17cO7xgYL32omo9
         VwMv7xhkcM+h9oaC+QHA3ellArWHdp2DPPzHVaLmXKUbA11hrCATBzuWqxr7EpCiBcDQ
         pIvcMnWEHTvQR+ZIX0odwAbsnDxyEEDT6nQcGiOFb+yF9w3P+fjm33yxzitaCeJmg0yR
         w3BLUAoKtnOfQmaH1WJCRfNTBB0RdJo3CKtwLYs49P0nzJaNlgRwmM1bOcbCcx7YvuH+
         JIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vjMJnOQ2xiLWlxLaltEAkegpH7Np+Ce8U+zcpqIVObE=;
        b=mOSq7wG8yQvMfEgsUB0T+JADhACWj5UCI5j9ljSjJKE4K3V+llb7uRSPgMVlm3pPj1
         EMH+DM6GD7NUD57nQ70TPbwJwVvGdoC4KbYgBkvzZI5kmoo8a7HF72LSfvS4aPwLMjg8
         ZVzgThg2THEvbck7sfO7oUBk1RkY82FpFkD+ohrL01xkJvsUCN25mR+IGDzDMlr9vWxx
         3SvVsK2vYvKe0Ely+ex48fA6R7O/woGXxG/lXJ9r85XDm6NPLotnfgNsj2C+fKVsq52m
         Di25dpUNuZMK77ESnrt5fW12leCND5wX0yyTi1DN1Djg40mQyasmhWuQqvX0yQd15dr/
         QNtw==
X-Gm-Message-State: AOAM531KwfQ+GMnZecgl/IN6EStnqdjXvTaAfAGoN2uJY6o5NOwcLCXf
        Ghng5Y3wSpOaCiTxeA9iRqUgwYhlXNc=
X-Google-Smtp-Source: ABdhPJxEkUgmN3QPb2apEIBkyU2stKugie/10vY23Wh8IwKbCmw+waggvhOhmKevufx1gEqf80tucg==
X-Received: by 2002:a05:600c:54e:b0:38e:bbef:9115 with SMTP id k14-20020a05600c054e00b0038ebbef9115mr7628224wmc.60.1649840992906;
        Wed, 13 Apr 2022 02:09:52 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:52 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 11/16] fsnotify: allow adding an inode mark without pinning inode
Date:   Wed, 13 Apr 2022 12:09:30 +0300
Message-Id: <20220413090935.3127107-12-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413090935.3127107-1-amir73il@gmail.com>
References: <20220413090935.3127107-1-amir73il@gmail.com>
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
 fs/notify/mark.c                 | 80 ++++++++++++++++++++++++--------
 include/linux/fsnotify_backend.h |  2 +
 2 files changed, 62 insertions(+), 20 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 7120918d8251..e38cb241536f 100644
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
@@ -223,6 +268,7 @@ static void *fsnotify_detach_connector_from_object(
 	rcu_assign_pointer(*(conn->obj), NULL);
 	conn->obj = NULL;
 	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
+	conn->flags = 0;
 
 	return inode;
 }
@@ -274,7 +320,8 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 		objp = fsnotify_detach_connector_from_object(conn, &type);
 		free_conn = true;
 	} else {
-		__fsnotify_recalc_mask(conn);
+		objp = __fsnotify_recalc_mask(conn);
+		type = conn->type;
 	}
 	WRITE_ONCE(mark->connector, NULL);
 	spin_unlock(&conn->lock);
@@ -497,7 +544,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 					       unsigned int obj_type,
 					       __kernel_fsid_t *fsid)
 {
-	struct inode *inode = NULL;
 	struct fsnotify_mark_connector *conn;
 
 	conn = kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_KERNEL);
@@ -505,6 +551,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		return -ENOMEM;
 	spin_lock_init(&conn->lock);
 	INIT_HLIST_HEAD(&conn->list);
+	conn->flags = 0;
 	conn->type = obj_type;
 	conn->obj = connp;
 	/* Cache fsid of filesystem containing the object */
@@ -515,10 +562,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		conn->fsid.val[0] = conn->fsid.val[1] = 0;
 		conn->flags = 0;
 	}
-	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
-		inode = fsnotify_conn_inode(conn);
-		fsnotify_get_inode_ref(inode);
-	}
 	fsnotify_get_sb_connectors(conn);
 
 	/*
@@ -527,8 +570,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	 */
 	if (cmpxchg(connp, NULL, conn)) {
 		/* Someone else created list structure for us */
-		if (inode)
-			fsnotify_put_inode_ref(inode);
 		fsnotify_put_sb_connectors(conn);
 		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
 	}
@@ -690,8 +731,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	if (ret)
 		goto err;
 
-	if (mark->mask || mark->ignored_mask)
-		fsnotify_recalc_mask(mark->connector);
+	fsnotify_recalc_mask(mark->connector);
 
 	return ret;
 err:
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index fc6fdbaac797..478a985d13c2 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -457,6 +457,7 @@ struct fsnotify_mark_connector {
 	spinlock_t lock;
 	unsigned short type;	/* Type of object [lock] */
 #define FSNOTIFY_CONN_FLAG_HAS_FSID	0x01
+#define FSNOTIFY_CONN_FLAG_HAS_IREF	0x02
 	unsigned short flags;	/* flags [lock] */
 	__kernel_fsid_t fsid;	/* fsid of filesystem containing object */
 	union {
@@ -512,6 +513,7 @@ struct fsnotify_mark {
 #define FSNOTIFY_MARK_FLAG_IN_ONESHOT		0x0020
 	/* fanotify mark flags */
 #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x0100
+#define FSNOTIFY_MARK_FLAG_NO_IREF		0x0200
 	unsigned int flags;		/* flags [mark->lock] */
 };
 
-- 
2.35.1

