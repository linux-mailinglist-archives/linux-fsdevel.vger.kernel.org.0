Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D227B3E27
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjI3FBz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjI3FBp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:01:45 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BB9171D;
        Fri, 29 Sep 2023 22:01:25 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-577e62e2adfso10221040a12.2;
        Fri, 29 Sep 2023 22:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050085; x=1696654885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XF2XqSbh4bo4XlOeQPlKNJjJGH1v1k5zwfAqr3Sp+Eg=;
        b=Uqg4XSc8LOXnjixz7zU3bwd86/0oR3nfdfPp7D1FuNFzHUUgS9qLlrWBclpd0ukjD6
         yfXo7mlJKWZvuySlQyhXif7oLX9TVekbMd+P3Zt6Ls7lejpK7MNIte4D6e64ukeFz+Om
         wVrDxIOmYshBZAo6UvsRoUkJr7am0oNt3c+GBgwmVA5IOWBZP60wforu41Mo4Ly90lI4
         e04H/PBO3TT48CWBzLNTXPfHlHfX7pGet6Jpula/Hg5LzZxykQdrcWtmxVa1CinC7B9E
         tQjqHsQcZXOeX9wjm3cajHjZ8uv9OHbbHYBZbXatylxh2qZthSyIidm8eUo+5rn24OFX
         QZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050085; x=1696654885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XF2XqSbh4bo4XlOeQPlKNJjJGH1v1k5zwfAqr3Sp+Eg=;
        b=FQAWd07JQuTQXi3Be6MHh7s1//+E5UIwWZ8EwXWEMH1aTyTbO5Vg8ezNxZbliEZ7If
         LKYp4p7HbmWcNkM53zHDfULvsun3EkAuXjlynADsnB2CRzD8mgmNuh07hOjR04+3IxvJ
         27iwhc/moPsAFPGed0DoUnZyFWEpBTQ3ncTog1CRXwVmSovfzXN9Z1vf58USazmBk79e
         WEzSOkhDxkNMJWToeLrRrWxaedkIXjJ43tpo+cT3yLN1ddybrsdKqbmXGoESLxdL/rtT
         TDQiQ7snt0F4lTUc6FgGbedmazZk/B9ZHArNK9I8X++HCQ0Gqe4ZWRVE/TiXOkOKclOS
         XVjg==
X-Gm-Message-State: AOJu0YwO+lIdFP/zdATKnMNiswyp7+UA0cXUjJHF/W9+EP/zZIh9lJAq
        POMlBzkDEUiEGOc4+cvRNrE=
X-Google-Smtp-Source: AGHT+IE7V3xhs1zZFq/CXLdO1Vk52Mu1MAiCsLfb6oVrmfuzI+coZi/OnssV2s1Maqaixu9A56W4oA==
X-Received: by 2002:a05:6a20:3c87:b0:15e:bcd:57f5 with SMTP id b7-20020a056a203c8700b0015e0bcd57f5mr6763988pzj.3.1696050084677;
        Fri, 29 Sep 2023 22:01:24 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:24 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Subject: [PATCH 08/29] erofs: move erofs_xattr_handlers and xattr_handler_map to .rodata
Date:   Sat, 30 Sep 2023 02:00:12 -0300
Message-Id: <20230930050033.41174-9-wedsonaf@gmail.com>
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
erofs_xattr_handlers or xattr_handler_map at runtime.

Cc: Gao Xiang <xiang@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: Yue Hu <huyue2@coolpad.com>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/erofs/xattr.c | 2 +-
 fs/erofs/xattr.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 40178b6e0688..a6dd68ea5df2 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -166,7 +166,7 @@ const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
 };
 #endif
 
-const struct xattr_handler *erofs_xattr_handlers[] = {
+const struct xattr_handler * const erofs_xattr_handlers[] = {
 	&erofs_xattr_user_handler,
 	&erofs_xattr_trusted_handler,
 #ifdef CONFIG_EROFS_FS_SECURITY
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index f16283cb8c93..b246cd0e135e 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -23,7 +23,7 @@ static inline const char *erofs_xattr_prefix(unsigned int idx,
 {
 	const struct xattr_handler *handler = NULL;
 
-	static const struct xattr_handler *xattr_handler_map[] = {
+	static const struct xattr_handler * const xattr_handler_map[] = {
 		[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
 		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] = &nop_posix_acl_access,
@@ -44,7 +44,7 @@ static inline const char *erofs_xattr_prefix(unsigned int idx,
 	return xattr_prefix(handler);
 }
 
-extern const struct xattr_handler *erofs_xattr_handlers[];
+extern const struct xattr_handler * const erofs_xattr_handlers[];
 
 int erofs_xattr_prefixes_init(struct super_block *sb);
 void erofs_xattr_prefixes_cleanup(struct super_block *sb);
-- 
2.34.1

