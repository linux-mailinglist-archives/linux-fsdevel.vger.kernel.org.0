Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E427B3E32
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjI3FC1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbjI3FBu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:01:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19A91B9;
        Fri, 29 Sep 2023 22:01:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5859d13f73dso1084558a12.1;
        Fri, 29 Sep 2023 22:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050096; x=1696654896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwKeB2GcV8X8HT4SX1MXoeR5H7ol3LfqqF5Xgl3DCSk=;
        b=L7afGCidyMkbrsdDhyIwgZMneQ2xkh5v/HjCcVhs7WfvhegSN0iZ7ObGm7Yd6JtVyh
         gJmuFBS9SmvwpgoOWyZkkMYJU5jzfuU+pDD+UgwX6FLlioRBYHphCI/8TtsyouvgDneA
         ZrSqF6zREYD7mMg4WgrbkP+Vn7tRAzLtDZcxXZfp85uqA0Vx4u8k4pb85btNSkYw4DSh
         eA359rKPGLLSt9d4TyCJQuLNYRhbnugWtY2T+bzr17bQHjV7DIbxOiii7VVHo2FIKeOr
         diX8S//jz4WM/CX/y66u0CJ5WMxY7MbkO2zLAzH4zAqJGSNt2Ta6WIeB5cZXRQMbQ5xA
         jAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050096; x=1696654896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwKeB2GcV8X8HT4SX1MXoeR5H7ol3LfqqF5Xgl3DCSk=;
        b=YhFMRV73kwDTgt5vGdi06u6Kix5CRSQ3NFy8WaKm9Cr3jJ7+U/oTJ/GpEBOIk/3KQX
         4F0XGObGbbZeonmrCjnO7dnqngyibBhcfauOBxylQ4YgfbNE7L+yOaApuTgUbrLmeQnN
         xe+35f8ytFYF5nX+J1/3XGscDkhTDyKNKUvs79w50iii17Rnu5m3mMAGH9RCrmmXhBi8
         OLJynVckz8DlCSlRGt1zxsUtoVZt27KA1z3RMwQcIiyJpm06NGTIGY5ED5BXD9+4W3Hb
         Ftdr0F4o6zjQqgq+52oFWoFIOwdn1sBr8bscU1y/kWfdVlQY1z665gewHFsSdeb9Vko9
         U5vw==
X-Gm-Message-State: AOJu0YxQBN+erSeY+LGl0mkqOCC28xiDA0D6N597eVh1ABReUqMxnxiA
        Q7vVdXAVyUhHFwtxC0BIFpE=
X-Google-Smtp-Source: AGHT+IEvarzPr/wanHw3WlffE8n4isOYDUaHmTBU4OusHr+SsPOQsgnsCDdcqx9c5xvYMHgnXwSeWg==
X-Received: by 2002:a17:903:456:b0:1c3:1c74:5d0a with SMTP id iw22-20020a170903045600b001c31c745d0amr5368060plb.34.1696050096054;
        Fri, 29 Sep 2023 22:01:36 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:35 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 12/29] gfs2: move gfs2_xattr_handlers_max to .rodata
Date:   Sat, 30 Sep 2023 02:00:16 -0300
Message-Id: <20230930050033.41174-13-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930050033.41174-1-wedsonaf@gmail.com>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

This makes it harder for accidental or malicious changes to
gfs2_xattr_handlers_max at runtime.

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/gfs2/super.h | 4 ++--
 fs/gfs2/xattr.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/super.h b/fs/gfs2/super.h
index bba58629bc45..3555dc69183a 100644
--- a/fs/gfs2/super.h
+++ b/fs/gfs2/super.h
@@ -59,8 +59,8 @@ extern const struct export_operations gfs2_export_ops;
 extern const struct super_operations gfs2_super_ops;
 extern const struct dentry_operations gfs2_dops;
 
-extern const struct xattr_handler *gfs2_xattr_handlers_max[];
-extern const struct xattr_handler **gfs2_xattr_handlers_min;
+extern const struct xattr_handler * const gfs2_xattr_handlers_max[];
+extern const struct xattr_handler * const *gfs2_xattr_handlers_min;
 
 #endif /* __SUPER_DOT_H__ */
 
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 93b36d026bb4..146c32d44bd1 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -1494,7 +1494,7 @@ static const struct xattr_handler gfs2_xattr_trusted_handler = {
 	.set    = gfs2_xattr_set,
 };
 
-const struct xattr_handler *gfs2_xattr_handlers_max[] = {
+const struct xattr_handler * const gfs2_xattr_handlers_max[] = {
 	/* GFS2_FS_FORMAT_MAX */
 	&gfs2_xattr_trusted_handler,
 
@@ -1504,4 +1504,4 @@ const struct xattr_handler *gfs2_xattr_handlers_max[] = {
 	NULL,
 };
 
-const struct xattr_handler **gfs2_xattr_handlers_min = gfs2_xattr_handlers_max + 1;
+const struct xattr_handler * const *gfs2_xattr_handlers_min = gfs2_xattr_handlers_max + 1;
-- 
2.34.1

