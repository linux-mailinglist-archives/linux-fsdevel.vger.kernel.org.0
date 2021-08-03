Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF413DF44A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 20:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbhHCSEP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 14:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbhHCSEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 14:04:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44087C061757
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Aug 2021 11:04:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n28-20020a05600c3b9cb02902552e60df56so2674597wms.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Aug 2021 11:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VgPb9kmai7KZaL+bLbc2JstMQjeBUpDeYZiCnA5QgkE=;
        b=scJ9Z4Kqjoz9+BDu8mO/XxgIwOkhsRSc5lkPYAQgu+PN0tsfGDyI7P28GkuEUjF/te
         YkRdP+ENLL8g9OV9hoPF2BmR8k4rQtvQe/JbL81QAHCFJtRDAvIcFG3P1/MxnvNK6JkG
         hi1uNcw8NTpECStrgzW+u6cKU78ve2FUNl0vPpmjUIgSE18eStinSQbLTzWwDt8ca1gr
         If8ohPPnGxdboj+P3pVZ13isrrxsYGqON+wGwGuRS8LwquQmEBUquOL66Zdu/S2CMsFD
         9MfnuttI2HhS8Khbc1jpMDq8YO7JZkzmcpG8twEWc0sW+xDnbAXQjekxEjHpLtiKIK0p
         AOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VgPb9kmai7KZaL+bLbc2JstMQjeBUpDeYZiCnA5QgkE=;
        b=YwiDF8gSreCV48GAozPUDaWm7qP1LDaNKYTWmUqIbZ6GIWPCyAccCrMEugQykkc1ti
         zqM9HbpXQSKK1itkU3uAXK7NmQEs5PWIw2UcHAVlzr+7Peqpx1WzRg2YyvJqaWQ15VqG
         1CZvsxCNHHmDsM40quonpGL94bA4IJbsOp5a2woXV8/UyvkF597AnAEXcr0OPOyv5mJr
         dTGl99XqPrq89jquUm/DO+e5dbW4F+cbn2TbnW46wCKll6HbAfLd7HhZ1zGE5Z5NDEY5
         WsccFf/BweqAbJ5fQgnwjbC02WYOm1mKVyzf4tpfHRllcJQ6ZFh6IZfOBj1Dv8NJsNzT
         Z87A==
X-Gm-Message-State: AOAM531avRyMfiKQffkEqYsG8GneoKprpd7+409s3cqhAehX8HWyc0zN
        lHRi3+1CBKak8xaJJ2KUKGw=
X-Google-Smtp-Source: ABdhPJwS5BAuyNreiYXP+2l4GAz5Fj54ZiXwfRhxJ1wsaqjINLMifW4Ik9Jk1EOmFkQMhdmeu9oKcg==
X-Received: by 2002:a1c:3886:: with SMTP id f128mr5680592wma.85.1628013841871;
        Tue, 03 Aug 2021 11:04:01 -0700 (PDT)
Received: from localhost.localdomain ([185.110.110.213])
        by smtp.gmail.com with ESMTPSA id b14sm15515555wrm.43.2021.08.03.11.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 11:04:01 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] fsnotify: count s_fsnotify_inode_refs for attached connectors
Date:   Tue,  3 Aug 2021 21:03:42 +0300
Message-Id: <20210803180344.2398374-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210803180344.2398374-1-amir73il@gmail.com>
References: <20210803180344.2398374-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of incrementing s_fsnotify_inode_refs when detaching connector
from inode, increment it earlier when attaching connector to inode.
Next patch is going to use s_fsnotify_inode_refs to count all objects
with attached connectors.

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
2.25.1

