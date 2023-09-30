Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7F37B3E2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjI3FCV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjI3FBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:01:47 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5F61981;
        Fri, 29 Sep 2023 22:01:29 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53fa455cd94so10168441a12.2;
        Fri, 29 Sep 2023 22:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050087; x=1696654887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xs6PHcuMqp3EC+KxYSNZ8/WH8PkZyTmto6O1b+gZZPE=;
        b=WGoZ93sLPHX8oeOwmjBE/faiAhK3db/DhACNLKBkyeabwg/YHXqmQqrLg7VijkplBO
         h7JbmMBGTt4uq/wAgNpYTHXcIE+EBBIz4YUIDjS0mGgzCRs5mRqB+cddKcs6kOmy4kyi
         KcWyf4PbO6r7yJzcNRkeCeOEMMjJbKraSbCg9BObA3vGjSVjdPoL4qEnMfvAw1b+6Wfb
         4pKs+a3Dj88IJ2/b4McJDHWujJjCkeaU9ZkEFXJY27Qd3BPI9MFMZitb0Xanl0pZF2n2
         Na5Z8TjSDLR9qoQ4TOSg6Vj6o2AsWB3P4ivAvDyER7wom0Nav/PdsgE8NFENZ3QQn9l8
         3ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050087; x=1696654887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xs6PHcuMqp3EC+KxYSNZ8/WH8PkZyTmto6O1b+gZZPE=;
        b=LYB63Uzyzaf4t8wRk0c7hGO8qqs6tO3QpxWw+Zc7fgZS0IyDrxk2f+/wh6HHYpi5Cd
         YJxjJr7V3Qh3dnWAmGxlcyPC62IovgytWuxp6jiaPrfNMtB5Kqny/wwQxh2Rry2ews6f
         1dgYVjA+Yci3E5M3Bjoz119mKsFFvPuM3dnJpWrylpr10J8veNqAMQp5Z8xMWaOtZ/Fp
         boJsypCec7GIZAzrwmCqjNQDrddsuJkVSGFod5TgzhQ3eZOjtkpO4nnZj9CG1eQ8+qvY
         gLyfqbYJGKGBPRlboNPu0Ie2UJrS+UtkdPV04gScLbWqyAzZWl6S/C2Z7h/fNW7HdHMO
         3kqA==
X-Gm-Message-State: AOJu0YyMbp05vB6d5pWn8jMEqh6CudRrKtUr1tXtNiowqFn8HYd1YDQP
        t1caTrKshYB+w1NjQxgBC/0=
X-Google-Smtp-Source: AGHT+IF2ffj2CqhPFD3YrjokUH17pXIdrnqNQhiaAIcE818tuDF2gSNmYuJmOfBgBwWGbBTiSEob2A==
X-Received: by 2002:a17:902:ce8b:b0:1c0:d5b1:2de8 with SMTP id f11-20020a170902ce8b00b001c0d5b12de8mr6916994plg.9.1696050087440;
        Fri, 29 Sep 2023 22:01:27 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:27 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: [PATCH 09/29] ext2: move ext2_xattr_handlers and ext2_xattr_handler_map to .rodata
Date:   Sat, 30 Sep 2023 02:00:13 -0300
Message-Id: <20230930050033.41174-10-wedsonaf@gmail.com>
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
ext2_xattr_handlers or ext2_xattr_handler_map at runtime.

Cc: Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/ext2/xattr.c | 4 ++--
 fs/ext2/xattr.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 8906ba479aaf..cfbe376da612 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -98,7 +98,7 @@ static struct buffer_head *ext2_xattr_cache_find(struct inode *,
 static void ext2_xattr_rehash(struct ext2_xattr_header *,
 			      struct ext2_xattr_entry *);
 
-static const struct xattr_handler *ext2_xattr_handler_map[] = {
+static const struct xattr_handler * const ext2_xattr_handler_map[] = {
 	[EXT2_XATTR_INDEX_USER]		     = &ext2_xattr_user_handler,
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
 	[EXT2_XATTR_INDEX_POSIX_ACL_ACCESS]  = &nop_posix_acl_access,
@@ -110,7 +110,7 @@ static const struct xattr_handler *ext2_xattr_handler_map[] = {
 #endif
 };
 
-const struct xattr_handler *ext2_xattr_handlers[] = {
+const struct xattr_handler * const ext2_xattr_handlers[] = {
 	&ext2_xattr_user_handler,
 	&ext2_xattr_trusted_handler,
 #ifdef CONFIG_EXT2_FS_SECURITY
diff --git a/fs/ext2/xattr.h b/fs/ext2/xattr.h
index 7925f596e8e2..6a4966949047 100644
--- a/fs/ext2/xattr.h
+++ b/fs/ext2/xattr.h
@@ -72,7 +72,7 @@ extern void ext2_xattr_delete_inode(struct inode *);
 extern struct mb_cache *ext2_xattr_create_cache(void);
 extern void ext2_xattr_destroy_cache(struct mb_cache *cache);
 
-extern const struct xattr_handler *ext2_xattr_handlers[];
+extern const struct xattr_handler * const ext2_xattr_handlers[];
 
 # else  /* CONFIG_EXT2_FS_XATTR */
 
-- 
2.34.1

