Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9DA7B3E3D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbjI3FDD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbjI3FCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:02:17 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761D010CF;
        Fri, 29 Sep 2023 22:01:49 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-578d0d94986so10819003a12.2;
        Fri, 29 Sep 2023 22:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050109; x=1696654909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvbjOndp8aI/Ez6XwF4rShTXeRhZbI/GoEOOUYLU6ao=;
        b=OMsYJ0djmL8A6YolidXzOPOh9rwmQaIemhL3oQ0JqpLorfCmOQnJ23DLZau4eyNwwM
         Ltfs4KuAOsuoZ7s38WmCX4OEgC2Cy11Wl+ko72JFODN6sWSnVEe6FHN+ZWqqVOyKpSkw
         bH/1h1wOg2mjykd4O8gkYPdPf6+yRZQ+vWnY6rBrC/s3l3YOaIxAie6WqpVm4COa9rCr
         h5fNAeXGaW9bSpmBJPpRW9NrdeGOJR47X6U7RxbYEEWUmovI6UfmEAgcBqiX7TJwkJq/
         FZiVwJAgGO8rNAxuR4xk4FQAh7uaxlrd9tWLKqB6/Q4+s4phrWJEq77JUoowa5XT98mQ
         Oegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050109; x=1696654909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvbjOndp8aI/Ez6XwF4rShTXeRhZbI/GoEOOUYLU6ao=;
        b=kJ5K+xlSySNKh1iy+pzccpNrtPoTzRxHM8EzYFyJYubQ848Sn5567Dnzt77/kqNnuR
         buTWftclkl8hv9uW0/DXGm5o2cXZoUaAqrmznkaPGZIg4ifmpRaFTUWfrJAJxEvkTyjW
         sJaIY0LTUJFO/zAt4eDGK0/qJ3npD2+BItfk0b0vQIjPi6qsb8D6Et7UAoi4KY3WwzG0
         T4hcXqNTZnjEyRAiO0mYFYUK/isFtTkifJyw+qEWbXSu4qQ/y0FbRv1hMcnAGahuzFgj
         0EA/iow6rgLlq1fmogEdQfmfOK10JeSp+m2ryjicd/rxd7efoOVv8x9ZzUBZSg8sFdid
         tOiw==
X-Gm-Message-State: AOJu0YzvrlMjx3HQTaJ9/DNw0K3/OmVXwkHNc6m3AVV8k9O6XJa/51YB
        CobTb8nJYyLnbUJnXCvZQc4=
X-Google-Smtp-Source: AGHT+IFTzTQoRrKBld3Z91Gl5//4DNU0err+xEbo2c8EVErnKUHrrks4dyaYIyT3+SlvU/O84IrtVw==
X-Received: by 2002:a05:6a21:4985:b0:160:7679:90 with SMTP id ax5-20020a056a21498500b0016076790090mr6093121pzc.56.1696050108746;
        Fri, 29 Sep 2023 22:01:48 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:48 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH 16/29] jfs: move jfs_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:20 -0300
Message-Id: <20230930050033.41174-17-wedsonaf@gmail.com>
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
jfs_xattr_handlers at runtime.

Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/jfs/jfs_xattr.h | 2 +-
 fs/jfs/xattr.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_xattr.h b/fs/jfs/jfs_xattr.h
index 0d33816d251d..ec67d8554d2c 100644
--- a/fs/jfs/jfs_xattr.h
+++ b/fs/jfs/jfs_xattr.h
@@ -46,7 +46,7 @@ extern int __jfs_setxattr(tid_t, struct inode *, const char *, const void *,
 extern ssize_t __jfs_getxattr(struct inode *, const char *, void *, size_t);
 extern ssize_t jfs_listxattr(struct dentry *, char *, size_t);
 
-extern const struct xattr_handler *jfs_xattr_handlers[];
+extern const struct xattr_handler * const jfs_xattr_handlers[];
 
 #ifdef CONFIG_JFS_SECURITY
 extern int jfs_init_security(tid_t, struct inode *, struct inode *,
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 931e50018f88..001c900a2b4d 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -985,7 +985,7 @@ static const struct xattr_handler jfs_trusted_xattr_handler = {
 	.set = jfs_xattr_set,
 };
 
-const struct xattr_handler *jfs_xattr_handlers[] = {
+const struct xattr_handler * const jfs_xattr_handlers[] = {
 	&jfs_os2_xattr_handler,
 	&jfs_user_xattr_handler,
 	&jfs_security_xattr_handler,
-- 
2.34.1

