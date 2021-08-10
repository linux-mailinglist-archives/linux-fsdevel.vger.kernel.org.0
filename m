Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15553E7BD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 17:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242707AbhHJPMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 11:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242696AbhHJPMt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:12:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30388C061798
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 08:12:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso2202432wms.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KKgN7W6IzD5JntVCA6XBkExK5gIwEcrb/3fsqauRnWQ=;
        b=i2xe5CAFIDWi3Zo0Y+OGTEQIVeAVZeR97JkCevBkKp1/fjzfeJhosB15wRGVgew/Pv
         RsXpKU32b3MyUcB/gAln0ZzZGbm7Rahx9dK3Uqu0xdB93GNZOg10obx6IqKhcRRl6wyi
         cX0uXQflZeYoS8RcOugNkZL4PLHdnkcTsR0UcUHUHEGUx2RE+Ty0+zNXJPQ6BhAnxBsZ
         rGdr5P/11w6gExL9rWZFe31VhKIBVTCPfURRLCJYOwTyo686hay7p3cCLgZ9EcUpYqD9
         aYSZ1JO4BExPSJzOmSG/T1k4IJpa3jeBe7OwvGYr291v5Buj1uShv0N7+pCI/4xqbRg2
         auMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KKgN7W6IzD5JntVCA6XBkExK5gIwEcrb/3fsqauRnWQ=;
        b=jimoL5R5lu5hJUxW5gdusAufBIvBoPNrq3gjYtPeIUA20osXxNBr7N5/Gh5joD6Giy
         LDxvh2VCqeNVi7vjBGYOR18bzW2YzSbSV0alH6nKRm1hNz2a7A+SyGE63hzB/3ItDT9Q
         FbJnkQW3IdyuU0i7MUVbFP81akGYGDZJ8vLg5wusqYTbfO5PRRhJJeby4OE+Mwv4RBo9
         zZVqJ2JCn/+m6CSNGWgiJIi0kDLm9ILUa2zs8T9UK8/PUcHxLmQ0Ad4QuCivxGFTDUUX
         frT2Fx0mParDjKwpAIZqrvY4z0WS3EMMVAilZ3ZzMYA7eTA6teWOItoO8Qqv4frgeZ7x
         UC4Q==
X-Gm-Message-State: AOAM531OYNB79sPCJ1XBhHvkskuU9ETyz56Dqb58BmE28zMG0hXTPJak
        0z8KNuwPX+DhkiEjJ8F9/g8=
X-Google-Smtp-Source: ABdhPJy2zS6dkF3VL0+SSsCoGwsNlYjdodkrUeCcbrzZeSMR7y1Anlhw/az3D0tHHeScHBYQY8Yr+A==
X-Received: by 2002:a1c:6a07:: with SMTP id f7mr12718291wmc.15.1628608345812;
        Tue, 10 Aug 2021 08:12:25 -0700 (PDT)
Received: from localhost.localdomain ([141.226.248.20])
        by smtp.gmail.com with ESMTPSA id k12sm9568920wrd.75.2021.08.10.08.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 08:12:25 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org,
        Matthew Bobrowski <repnop@google.com>
Subject: [PATCH v2 2/4] fsnotify: count s_fsnotify_inode_refs for attached connectors
Date:   Tue, 10 Aug 2021 18:12:18 +0300
Message-Id: <20210810151220.285179-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810151220.285179-1-amir73il@gmail.com>
References: <20210810151220.285179-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of incrementing s_fsnotify_inode_refs when detaching connector
from inode, increment it earlier when attaching connector to inode.
Next patch is going to use s_fsnotify_inode_refs to count all objects
with attached connectors.

Reviewed-by: Matthew Bobrowski <repnop@google.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/mark.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 80459db58f63..2d8c46e1167d 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -169,6 +169,21 @@ static void fsnotify_connector_destroy_workfn(struct work_struct *work)
 	}
 }
 
+static void fsnotify_get_inode_ref(struct inode *inode)
+{
+	ihold(inode);
+	atomic_long_inc(&inode->i_sb->s_fsnotify_inode_refs);
+}
+
+static void fsnotify_put_inode_ref(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+
+	iput(inode);
+	if (atomic_long_dec_and_test(&sb->s_fsnotify_inode_refs))
+		wake_up_var(&sb->s_fsnotify_inode_refs);
+}
+
 static void *fsnotify_detach_connector_from_object(
 					struct fsnotify_mark_connector *conn,
 					unsigned int *type)
@@ -182,7 +197,6 @@ static void *fsnotify_detach_connector_from_object(
 	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
 		inode = fsnotify_conn_inode(conn);
 		inode->i_fsnotify_mask = 0;
-		atomic_long_inc(&inode->i_sb->s_fsnotify_inode_refs);
 	} else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
 		fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
 	} else if (conn->type == FSNOTIFY_OBJ_TYPE_SB) {
@@ -209,19 +223,12 @@ static void fsnotify_final_mark_destroy(struct fsnotify_mark *mark)
 /* Drop object reference originally held by a connector */
 static void fsnotify_drop_object(unsigned int type, void *objp)
 {
-	struct inode *inode;
-	struct super_block *sb;
-
 	if (!objp)
 		return;
 	/* Currently only inode references are passed to be dropped */
 	if (WARN_ON_ONCE(type != FSNOTIFY_OBJ_TYPE_INODE))
 		return;
-	inode = objp;
-	sb = inode->i_sb;
-	iput(inode);
-	if (atomic_long_dec_and_test(&sb->s_fsnotify_inode_refs))
-		wake_up_var(&sb->s_fsnotify_inode_refs);
+	fsnotify_put_inode_ref(objp);
 }
 
 void fsnotify_put_mark(struct fsnotify_mark *mark)
@@ -495,7 +502,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	}
 	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
 		inode = fsnotify_conn_inode(conn);
-		ihold(inode);
+		fsnotify_get_inode_ref(inode);
 	}
 
 	/*
@@ -505,7 +512,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	if (cmpxchg(connp, NULL, conn)) {
 		/* Someone else created list structure for us */
 		if (inode)
-			iput(inode);
+			fsnotify_put_inode_ref(inode);
 		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
 	}
 
-- 
2.32.0

