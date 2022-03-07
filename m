Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B464D4D038E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 16:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbiCGP7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 10:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbiCGP7A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:59:00 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B6631521
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Mar 2022 07:58:04 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u1so24012779wrg.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Mar 2022 07:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FhxT+I9yip7vypG+Wqj2xpjVbvXzHRodQBlpPGS8dwo=;
        b=NFEYHwgxfRmCaO9ZtBOiTkSwfY+qk3hOUH3ZJXKFDNob5Fl0DBdlfFmncC/Kgh31wp
         FdXrGS7NE2go0yrSGqxtAq+u4Ukks4lkuCVjQK9xytXMYYYHpB2LnDka3qIOoy8YJrCC
         5qFnrIK8HEFJIQm+l3pePEl7IqzaeLRQM26f1PE/rYlRu2/XAkf9r8YxuLZ7sU983Vef
         SqSzZvQD5ZZueTHM9T6ZI6Un1KDonw/r9TceHPJzD35UUBK224Uktfi4JxbIpnK6kZSG
         WabdGLbPGmfXmMGUpHS+R/alWcSaGn0G4x845TEiA6dY0kiK9usTe6JYzkc/R9fIO5v7
         b1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FhxT+I9yip7vypG+Wqj2xpjVbvXzHRodQBlpPGS8dwo=;
        b=Qc4vi0sAuiQxrrugHIGrzTqs+moo7lVm+FiOFOlG57prR90zkTYCZCWybp20Xd7PA8
         6c9KPqdYMD7ZT52iau/+a/CzTqYLWsmJJVp6R/fji3ynjerB2Q74cIrR70y2bIr69Ko2
         Zh0DnUnPSeCZVkSvc5Rf83KPAw+jQo2Q9HWNdsctZS6sJCr/NOkRvZ1XY/GLyabxfvO4
         gfxNT9h94UVnIm2YSZGI7aEVS7wNMcQyTMoDDeuHq7CfCfVlkoRHPEUed677+QgdM/R9
         zFiecP5oRPtojU/5nqxZmyuAhkWIcONf26EO4nqivlCzBqdwZy7tsacmG7PvpNA8TTB9
         8diw==
X-Gm-Message-State: AOAM531FOv3FcC378GabFtDk/O2fouuEBHtCsiDFi3lTsRQ45EIqLxTz
        Dkr1PTM7ccYn7EImdedRSKc=
X-Google-Smtp-Source: ABdhPJzTqYGwQvN1gxbj35CLT/A2jfShvlFTgrqJsKwTK5FHd4xhI08cgp0/KrA7F4uhm7pGdxjk+Q==
X-Received: by 2002:adf:a4d2:0:b0:1f0:326a:27f3 with SMTP id h18-20020adfa4d2000000b001f0326a27f3mr8995388wrb.382.1646668683222;
        Mon, 07 Mar 2022 07:58:03 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm11686591wrv.79.2022.03.07.07.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:58:02 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] fsnotify: allow adding an inode mark without pinning inode
Date:   Mon,  7 Mar 2022 17:57:39 +0200
Message-Id: <20220307155741.1352405-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307155741.1352405-1-amir73il@gmail.com>
References: <20220307155741.1352405-1-amir73il@gmail.com>
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

Make that behavior opt-out with the flag FSNOTIFY_ADD_MARK_NO_IREF.

Instead of taking the inode reference when attaching connector to inode
and dropping the inode reference when detaching connector from inode,
take the inode reference on attach of the first mark that wants to hold
an inode reference and drop the inode reference on detach of the last
mark that wants to hold an inode reference.

This leaves the choice to the backend whether or not to pin the inode
when adding an inode mark.

This is intended to be used when adding a mark with ignored mask that is
used for optimization in cases where group can afford getting unneeded
events and reinstate the mark with ignored mask when inode is accessed
again after being evicted.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/mark.c                 | 70 ++++++++++++++++++++++++++++----
 include/linux/fsnotify_backend.h |  3 ++
 2 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 190df435919f..f71b6814bfa7 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -213,6 +213,17 @@ static void *fsnotify_detach_connector_from_object(
 	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
 		inode = fsnotify_conn_inode(conn);
 		inode->i_fsnotify_mask = 0;
+
+		pr_debug("%s: inode=%p iref=%u sb_connectors=%lu icount=%u\n",
+			 __func__, inode, atomic_read(&conn->proxy_iref),
+			 atomic_long_read(&inode->i_sb->s_fsnotify_connectors),
+			 atomic_read(&inode->i_count));
+
+		/* Unpin inode when detaching from connector */
+		if (atomic_read(&conn->proxy_iref))
+			atomic_set(&conn->proxy_iref, 0);
+		else
+			inode = NULL;
 	} else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
 		fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
 	} else if (conn->type == FSNOTIFY_OBJ_TYPE_SB) {
@@ -240,12 +251,43 @@ static void fsnotify_final_mark_destroy(struct fsnotify_mark *mark)
 /* Drop object reference originally held by a connector */
 static void fsnotify_drop_object(unsigned int type, void *objp)
 {
+	struct inode *inode = objp;
+
 	if (!objp)
 		return;
 	/* Currently only inode references are passed to be dropped */
 	if (WARN_ON_ONCE(type != FSNOTIFY_OBJ_TYPE_INODE))
 		return;
-	fsnotify_put_inode_ref(objp);
+
+	pr_debug("%s: inode=%p sb_connectors=%lu, icount=%u\n", __func__,
+		 inode, atomic_long_read(&inode->i_sb->s_fsnotify_connectors),
+		 atomic_read(&inode->i_count));
+
+	fsnotify_put_inode_ref(inode);
+}
+
+/* Drop the proxy refcount on inode maintainted by connector */
+static struct inode *fsnotify_drop_iref(struct fsnotify_mark_connector *conn,
+					unsigned int *type)
+{
+	struct inode *inode = fsnotify_conn_inode(conn);
+
+	if (WARN_ON_ONCE(!inode || conn->type != FSNOTIFY_OBJ_TYPE_INODE))
+		return NULL;
+
+	pr_debug("%s: inode=%p iref=%u sb_connectors=%lu icount=%u\n",
+		 __func__, inode, atomic_read(&conn->proxy_iref),
+		 atomic_long_read(&inode->i_sb->s_fsnotify_connectors),
+		 atomic_read(&inode->i_count));
+
+	if (WARN_ON_ONCE(!atomic_read(&conn->proxy_iref)) ||
+	    !atomic_dec_and_test(&conn->proxy_iref))
+		return NULL;
+
+	fsnotify_put_inode_ref(inode);
+	*type = FSNOTIFY_OBJ_TYPE_INODE;
+
+	return inode;
 }
 
 void fsnotify_put_mark(struct fsnotify_mark *mark)
@@ -275,6 +317,9 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 		free_conn = true;
 	} else {
 		__fsnotify_recalc_mask(conn);
+		/* Unpin inode on last mark that wants inode refcount held */
+		if (mark->flags & FSNOTIFY_MARK_FLAG_HAS_IREF)
+			objp = fsnotify_drop_iref(conn, &type);
 	}
 	WRITE_ONCE(mark->connector, NULL);
 	spin_unlock(&conn->lock);
@@ -499,7 +544,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 					       unsigned int obj_type,
 					       __kernel_fsid_t *fsid)
 {
-	struct inode *inode = NULL;
 	struct fsnotify_mark_connector *conn;
 
 	conn = kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_KERNEL);
@@ -507,6 +551,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		return -ENOMEM;
 	spin_lock_init(&conn->lock);
 	INIT_HLIST_HEAD(&conn->list);
+	atomic_set(&conn->proxy_iref, 0);
 	conn->type = obj_type;
 	conn->obj = connp;
 	/* Cache fsid of filesystem containing the object */
@@ -517,10 +562,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		conn->fsid.val[0] = conn->fsid.val[1] = 0;
 		conn->flags = 0;
 	}
-	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
-		inode = fsnotify_conn_inode(conn);
-		fsnotify_get_inode_ref(inode);
-	}
 	fsnotify_get_sb_connectors(conn);
 
 	/*
@@ -529,8 +570,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	 */
 	if (cmpxchg(connp, NULL, conn)) {
 		/* Someone else created list structure for us */
-		if (inode)
-			fsnotify_put_inode_ref(inode);
 		fsnotify_put_sb_connectors(conn);
 		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
 	}
@@ -649,6 +688,21 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 	/* mark should be the last entry.  last is the current last entry */
 	hlist_add_behind_rcu(&mark->obj_list, &last->obj_list);
 added:
+	/* Pin inode on first mark that wants inode refcount held */
+	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE &&
+	    !(flags & FSNOTIFY_ADD_MARK_NO_IREF)) {
+		struct inode *inode = fsnotify_conn_inode(conn);
+
+		mark->flags |= FSNOTIFY_MARK_FLAG_HAS_IREF;
+		if (atomic_inc_return(&conn->proxy_iref) == 1)
+			fsnotify_get_inode_ref(inode);
+
+		pr_debug("%s: inode=%p iref=%u sb_connectors=%lu icount=%u\n",
+			 __func__, inode, atomic_read(&conn->proxy_iref),
+			 atomic_long_read(&inode->i_sb->s_fsnotify_connectors),
+			 atomic_read(&inode->i_count));
+	}
+
 	/*
 	 * Since connector is attached to object using cmpxchg() we are
 	 * guaranteed that connector initialization is fully visible by anyone
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 0b548518b166..de718864c5f5 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -425,6 +425,7 @@ struct fsnotify_mark_connector {
 	unsigned short type;	/* Type of object [lock] */
 #define FSNOTIFY_CONN_FLAG_HAS_FSID	0x01
 	unsigned short flags;	/* flags [lock] */
+	atomic_t proxy_iref;	/* marks that want inode reference held */
 	__kernel_fsid_t fsid;	/* fsid of filesystem containing object */
 	union {
 		/* Object pointer [lock] */
@@ -471,6 +472,7 @@ struct fsnotify_mark {
 	/* Events types to ignore [mark->lock, group->mark_mutex] */
 	__u32 ignored_mask;
 	/* Internal fsnotify flags */
+#define FSNOTIFY_MARK_FLAG_HAS_IREF		0x01
 #define FSNOTIFY_MARK_FLAG_ALIVE		0x02
 #define FSNOTIFY_MARK_FLAG_ATTACHED		0x04
 	/* Backend controlled flags */
@@ -636,6 +638,7 @@ extern int fsnotify_get_conn_fsid(const struct fsnotify_mark_connector *conn,
 
 /* attach the mark to the object */
 #define FSNOTIFY_ADD_MARK_ALLOW_DUPS	0x1
+#define FSNOTIFY_ADD_MARK_NO_IREF	0x2
 
 extern int fsnotify_add_mark(struct fsnotify_mark *mark,
 			     fsnotify_connp_t *connp, unsigned int obj_type,
-- 
2.25.1

