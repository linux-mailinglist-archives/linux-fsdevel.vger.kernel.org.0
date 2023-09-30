Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0637B3E50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjI3FED (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjI3FDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:03:40 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966481AB;
        Fri, 29 Sep 2023 22:02:21 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-578cc95db68so8226743a12.1;
        Fri, 29 Sep 2023 22:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050141; x=1696654941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFRp7G+qDWZEQApnHi6mmaUctO5D9NgBjXm6s7XGppI=;
        b=cmblsLyN05V9ss1mhetvhEbg3xK7fHaT8bPpk3rntyI57iWq4Gs4Lg3h2UuozUyql8
         An0T32+uosTyEdHeMzopE+C14r2OlBXk3Cs6r9v6kOJCg82nKPe64BpUiXaTnRLzRD8w
         4jh9rFWdbJqAbtLUcaqq123gF9UhMmC/eUYZmhy+ynCUt3mQ43K7k/vcmRdyD+dVXsmY
         bNkDkyqqztqNTW1j57mh20rI4YRATWCKtxeT5O+fHq4U3ejOrf03hRd7yA1edGy1Gbz4
         R9Ej6UzhTwtYS3RUapRER1lEraC3B762qexArrPC53vl3kZW+KdQKNozkcuS5heH4Xx9
         Qx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050141; x=1696654941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFRp7G+qDWZEQApnHi6mmaUctO5D9NgBjXm6s7XGppI=;
        b=dz12R+S3pMTVqzdF5uh2tBJdWJl4BBnl2KLe24K+f31jRsBQF0idsEq9Qpll5s6OzB
         DPZcAHImIkb3PRx03IN/zj1J+Sd3ZQyrWwwjFLAf1LWJeV+7WrYZNpJmUcrCxbImROnt
         Zd3R4kB3ZOb0PKvB7tCDhAIvh1RvOXZWywxcyyECSWYgH7m5DQqwzCs5TC9ajlJHktIm
         6n3MqM4eCl+H556GyTr4iCljrbs4wOZRDQh4U6ioyjxMmWjdOvsQkePfzisG9i0/IeAX
         zJy0sdpQLWzUE41COIazxUSMIxlqyycwgOUpvXu2Ui9h09ASS+vGqMYDi/vmKZvOQ70Z
         cLww==
X-Gm-Message-State: AOJu0YwshEiloyNrepPY6ejCYX859cfRLtuwnB6wgkj5ZNcrdrw5v3yA
        quXDvhNE8YMOTsVA0j82598=
X-Google-Smtp-Source: AGHT+IGpIQVcwPvUll8zQVvM7975BEjZofvows5C/41pz1gJI60bATTCFwi9O1QmSqWVIMqSSvJEIQ==
X-Received: by 2002:a05:6a21:998a:b0:14c:84e6:1ab4 with SMTP id ve10-20020a056a21998a00b0014c84e61ab4mr7099900pzb.33.1696050140965;
        Fri, 29 Sep 2023 22:02:20 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:02:20 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 25/29] ubifs: move ubifs_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:29 -0300
Message-Id: <20230930050033.41174-26-wedsonaf@gmail.com>
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
ubifs_xattr_handlers at runtime.

Cc: Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/ubifs/ubifs.h | 2 +-
 fs/ubifs/xattr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 4c36044140e7..8a9a66255e7e 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2043,7 +2043,7 @@ ssize_t ubifs_xattr_get(struct inode *host, const char *name, void *buf,
 			size_t size);
 
 #ifdef CONFIG_UBIFS_FS_XATTR
-extern const struct xattr_handler *ubifs_xattr_handlers[];
+extern const struct xattr_handler * const ubifs_xattr_handlers[];
 ssize_t ubifs_listxattr(struct dentry *dentry, char *buffer, size_t size);
 void ubifs_evict_xattr_inode(struct ubifs_info *c, ino_t xattr_inum);
 int ubifs_purge_xattrs(struct inode *host);
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 349228dd1191..5e17e9591e6e 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -735,7 +735,7 @@ static const struct xattr_handler ubifs_security_xattr_handler = {
 };
 #endif
 
-const struct xattr_handler *ubifs_xattr_handlers[] = {
+const struct xattr_handler * const ubifs_xattr_handlers[] = {
 	&ubifs_user_xattr_handler,
 	&ubifs_trusted_xattr_handler,
 #ifdef CONFIG_UBIFS_FS_SECURITY
-- 
2.34.1

