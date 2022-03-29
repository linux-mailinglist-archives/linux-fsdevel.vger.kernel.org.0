Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB474EA8C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 09:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbiC2HvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 03:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbiC2HvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:51:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562FF1E3E2B
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h4so23491893wrc.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4c3DGo6tjgx4VrE0f1pQ13QNGFWI5EFvnHPKPJcp//8=;
        b=pcmZg3C0BmCACPs/SePkZ9knBAOzPhj/EPrT18VcFjOsdLAYrtXaOih1sBELsvu7Pd
         4RxrzznPUzYalLO9WJ4uzwZO//xfM8FQTMVP4Bh8Ak6+0NGR2XxgH6qhCtc1YA3C8/l3
         iIo1YFDGccq+wKqfVSHI0z4DDFerZXba4+Q5yqxjsy9cxAUfpyddM9FMkl/zELmUbOwy
         73xnd3vApOfK+RSWAFaCzmaV/sIz4WP/qsCBqMGP5AIYMNRytmGusvSgvt/rW0zQcPL7
         PwG7JwkzWPOMMU6KEfOF1DyetQiQywOvUZsiyNIyKe6FEjgkjrLwWCChB0gWXU6v+Lgy
         YmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4c3DGo6tjgx4VrE0f1pQ13QNGFWI5EFvnHPKPJcp//8=;
        b=Y8DG6F7CbKiC5sPXgRRM6jthk5iRbaEEiTUqSCsTULifRJNMK4XCpoMb/a3ZH4abbd
         jsU1UMC0fxp2EfGPabHQjC7MsgLI10zIVpBrbNXhiunpZVbGKTZCWlFAvhsctgounlE3
         M1Su8SvxdA9WOgq4GprDpl4+T9nGnC9ZeqapYGOk3DFD4N/Rq4/gV4BUKvb/nBh8lPwc
         dJ1ff5WQW4HXhfMHUIIrTbdd6G3cI6fEfEt7katOFnkRguIQ5AS6H7oIrITWoD9S2FMS
         /PXF6RO0N6ugTfO8QRsl1DJsAnAVx3lAakyzVeYXeT9dROPYIYhkbt4GJ0HP5BmZS457
         BQnw==
X-Gm-Message-State: AOAM533VfOZTB7xRq0aQo1MNjZzKE0yE0J6lnwdDOLAwCp4eFVu4bLZk
        XnpTtSLdzEEXl708JhLY/nc=
X-Google-Smtp-Source: ABdhPJyTR8G3P/XTL2imaHuNtJI88liNV4JLqhuPW6b7BfR/kl+FRIaQhGS9xegGU7aqKzcMREvE3A==
X-Received: by 2002:a5d:5507:0:b0:203:e0a3:7016 with SMTP id b7-20020a5d5507000000b00203e0a37016mr28380748wrv.575.1648540155859;
        Tue, 29 Mar 2022 00:49:15 -0700 (PDT)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm1534342wms.25.2022.03.29.00.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:15 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 04/16] fsnotify: remove unneeded refcounts of s_fsnotify_connectors
Date:   Tue, 29 Mar 2022 10:48:52 +0300
Message-Id: <20220329074904.2980320-5-amir73il@gmail.com>
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

s_fsnotify_connectors is elevated for every inode mark in addition to
the refcount already taken by the inode connector.

This is a relic from s_fsnotify_inode_refs pre connector era.
Remove those unneeded recounts.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/mark.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index b1443e66ba26..698ed0a1a47e 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -169,21 +169,6 @@ static void fsnotify_connector_destroy_workfn(struct work_struct *work)
 	}
 }
 
-static void fsnotify_get_inode_ref(struct inode *inode)
-{
-	ihold(inode);
-	atomic_long_inc(&inode->i_sb->s_fsnotify_connectors);
-}
-
-static void fsnotify_put_inode_ref(struct inode *inode)
-{
-	struct super_block *sb = inode->i_sb;
-
-	iput(inode);
-	if (atomic_long_dec_and_test(&sb->s_fsnotify_connectors))
-		wake_up_var(&sb->s_fsnotify_connectors);
-}
-
 static void fsnotify_get_sb_connectors(struct fsnotify_mark_connector *conn)
 {
 	struct super_block *sb = fsnotify_connector_sb(conn);
@@ -245,7 +230,7 @@ static void fsnotify_drop_object(unsigned int type, void *objp)
 	/* Currently only inode references are passed to be dropped */
 	if (WARN_ON_ONCE(type != FSNOTIFY_OBJ_TYPE_INODE))
 		return;
-	fsnotify_put_inode_ref(objp);
+	iput(objp);
 }
 
 void fsnotify_put_mark(struct fsnotify_mark *mark)
@@ -519,7 +504,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	}
 	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
 		inode = fsnotify_conn_inode(conn);
-		fsnotify_get_inode_ref(inode);
+		ihold(inode);
 	}
 	fsnotify_get_sb_connectors(conn);
 
@@ -530,7 +515,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	if (cmpxchg(connp, NULL, conn)) {
 		/* Someone else created list structure for us */
 		if (inode)
-			fsnotify_put_inode_ref(inode);
+			iput(inode);
 		fsnotify_put_sb_connectors(conn);
 		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
 	}
-- 
2.25.1

