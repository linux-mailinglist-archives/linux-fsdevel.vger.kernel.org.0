Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8907B3E18
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjI3FBI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjI3FBG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:01:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057361AE;
        Fri, 29 Sep 2023 22:01:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c60f1a2652so10351695ad.0;
        Fri, 29 Sep 2023 22:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050064; x=1696654864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcuxStbjNijxSJq8zEaQg95VP+4PBlgl17JsgSzTRFE=;
        b=WCZJ1JdysZkIZlPqNO3x9kE5YTnAV8X2ft3sbU6A5sIdyIZ55bEe/m3IB4pJPNgGnG
         4QMjrazQ4otQQLZg74QKzKdOVl68rmAWYihEhSER9kKOgvRY6aapjx4HpDh7aujaHYoz
         jWI+njEs8+vqver587Le2gTP8sjsdlF5Q5XawTHuIuNI2WSExlQMGcto6tyLGHw4sUW4
         mxsrRLVz6TJ4Vl05B5pHYKFBmwkJgS6CTmiV+35iHB6XQ/AUTVD0AxrX7tlHE2/GCHCa
         3WoQUCTgpd7uJhe6QGFqmJQchFMnB4swNHG75prfcTQRj+jIg0cjsxVOLqbJk4NcFMIz
         eMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050064; x=1696654864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcuxStbjNijxSJq8zEaQg95VP+4PBlgl17JsgSzTRFE=;
        b=eDi1E2em9gkvffdv+J/hUInGCf/3m/15ic0PRYswDu6QZsJRiQdHd32RK/fRfdlE9C
         w828p5SXm5UJNs3QykdDFAXJijQ9w2TiYQmZiTuLa2MPHZS6TuVeb+jX70qImgFp2zEM
         R1KfTyz/owNiFahHiROLoMvlbY1wqYJPqve+DSmmCr7E1rXUoV5MzHHkPIUt9Pwqx0sm
         lzgZXBBK13QAf4iIt1Kkj8Ecnn7wSxqrBaONG+BIQo44bunn0tMmBFZEYphf0o2cc6jb
         c6bUd56jWh+Mzd/BMRugSARqaESMSCugZSZ9jEQDKXZ0wDRK+IVbIG6qV0LiTIioGsZE
         iGJQ==
X-Gm-Message-State: AOJu0YwArFK7ieI3f6oyZ6iDvQRRC1sEQICi+tGiL2MmRHLS389Z2mU3
        T17GrGxxR313d7SF3euxag8=
X-Google-Smtp-Source: AGHT+IHR/Z9vw2im73BCKMlfvXTH3LjrdswnqX7m/Xw1oMRvr5GOQ5Mq0e1yLd4AUBV/4jWIj0TlGA==
X-Received: by 2002:a17:903:184:b0:1bc:5e36:9ab4 with SMTP id z4-20020a170903018400b001bc5e369ab4mr9385815plg.21.1696050064402;
        Fri, 29 Sep 2023 22:01:04 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:04 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev
Subject: [PATCH 03/29] 9p: move xattr-related structs to .rodata
Date:   Sat, 30 Sep 2023 02:00:07 -0300
Message-Id: <20230930050033.41174-4-wedsonaf@gmail.com>
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
v9fs_xattr_user_handler, v9fs_xattr_trusted_handler,
v9fs_xattr_security_handler, or v9fs_xattr_handlers at runtime.

Cc: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/9p/xattr.c | 8 ++++----
 fs/9p/xattr.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index e00cf8109b3f..053d1cef6e13 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -162,27 +162,27 @@ static int v9fs_xattr_handler_set(const struct xattr_handler *handler,
 	return v9fs_xattr_set(dentry, full_name, value, size, flags);
 }
 
-static struct xattr_handler v9fs_xattr_user_handler = {
+static const struct xattr_handler v9fs_xattr_user_handler = {
 	.prefix	= XATTR_USER_PREFIX,
 	.get	= v9fs_xattr_handler_get,
 	.set	= v9fs_xattr_handler_set,
 };
 
-static struct xattr_handler v9fs_xattr_trusted_handler = {
+static const struct xattr_handler v9fs_xattr_trusted_handler = {
 	.prefix	= XATTR_TRUSTED_PREFIX,
 	.get	= v9fs_xattr_handler_get,
 	.set	= v9fs_xattr_handler_set,
 };
 
 #ifdef CONFIG_9P_FS_SECURITY
-static struct xattr_handler v9fs_xattr_security_handler = {
+static const struct xattr_handler v9fs_xattr_security_handler = {
 	.prefix	= XATTR_SECURITY_PREFIX,
 	.get	= v9fs_xattr_handler_get,
 	.set	= v9fs_xattr_handler_set,
 };
 #endif
 
-const struct xattr_handler *v9fs_xattr_handlers[] = {
+const struct xattr_handler * const v9fs_xattr_handlers[] = {
 	&v9fs_xattr_user_handler,
 	&v9fs_xattr_trusted_handler,
 #ifdef CONFIG_9P_FS_SECURITY
diff --git a/fs/9p/xattr.h b/fs/9p/xattr.h
index b5636e544c8a..3ad5a802352a 100644
--- a/fs/9p/xattr.h
+++ b/fs/9p/xattr.h
@@ -10,7 +10,7 @@
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 
-extern const struct xattr_handler *v9fs_xattr_handlers[];
+extern const struct xattr_handler * const v9fs_xattr_handlers[];
 
 ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
 			   void *buffer, size_t buffer_size);
-- 
2.34.1

