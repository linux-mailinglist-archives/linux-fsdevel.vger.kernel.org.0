Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7B37B3E31
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjI3FCZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbjI3FBu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:01:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38D41B0;
        Fri, 29 Sep 2023 22:01:33 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-578b4981526so9576823a12.0;
        Fri, 29 Sep 2023 22:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050093; x=1696654893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Di+r7igCO4YXKaYMIYrRDbHqqg+poxo6bQkzPMC2DI=;
        b=JAbDr6eNg1PJBrpWcF8pM+0gTBU5L1Rb/qIi7ESh/AgzEYudfdwjj6dGUmvfmeiRio
         nYC1NT5PCjsfhqp9xY/0jn+l61MfbRgU/IqzjV+fHBiW6w2LSejWh6JODKqh2xm5ckWu
         LbdwHEL3f+uHVoZtZgrn60uIGvyNw87JRlO47CA5uH6aWWaIsiaTzvBigZcdHb2pKpJ/
         Pn1g08XSQY+DJ+Nex//hWmKuJIT2F5hfZ+hdNblxQ16ghd30Kt3EsoXRY8sR91iySO2W
         rKDTM4T3tc+yhmhOpmZ9eE73BNHC3YO2Y0kUz7URRsobQCRM4IOf4BsFdIDOO7Zn9XTi
         DiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050093; x=1696654893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Di+r7igCO4YXKaYMIYrRDbHqqg+poxo6bQkzPMC2DI=;
        b=hkWOoD49HjHd4v6F7j2jvwStrWzphLV2iV7b1nQ++pMKtiGjzEC8jSkD42ruNb54Xj
         yP7NwYI3XM/HqF/svmSjZIm33yaQiLOHY9j+dECsfC6str9Xm08FJTPr5xAUvz7j+BLM
         h3OsjjReQA3SxlD6BZReid2Fvm3erwfZgk7FBspyVvAxaUpXgutaF5bYK8GnxjFH0dq8
         l462CwykCrpxoZaUIvul8fRIAurelxGL0mT1RKnaTvfkObU5g76aUkyRw0tm2W7NE3q8
         y7OibQiMt/LjWOeoOlMkEAhOkMwyV4L4Nsk5N1jOWAjE9Vqpqwf+5EFiJnuccoTtARwQ
         1nzQ==
X-Gm-Message-State: AOJu0YzZaj1ggWga1TYfQGWUs8mCoQfbvAOv8gSGbr2MvY3hkKZDLmei
        V8nB0uOjlKmluFMB0TcE1A4=
X-Google-Smtp-Source: AGHT+IG8Agrv/ko/MYrHOli4ihDTl4dEycL16ZkYXNHwGjruWUxcniQ8lH15H525OHDjmjxMklD2+w==
X-Received: by 2002:a05:6a20:258d:b0:161:27c5:9c41 with SMTP id k13-20020a056a20258d00b0016127c59c41mr6192739pzd.28.1696050093022;
        Fri, 29 Sep 2023 22:01:33 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:32 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 11/29] fuse: move fuse_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:15 -0300
Message-Id: <20230930050033.41174-12-wedsonaf@gmail.com>
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
fuse_xattr_handlers at runtime.

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/fuse/fuse_i.h | 2 +-
 fs/fuse/xattr.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9b7fc7d3c7f1..2e8c2e06cf78 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1268,7 +1268,7 @@ ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
 		      size_t size);
 ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size);
 int fuse_removexattr(struct inode *inode, const char *name);
-extern const struct xattr_handler *fuse_xattr_handlers[];
+extern const struct xattr_handler * const fuse_xattr_handlers[];
 
 struct posix_acl;
 struct posix_acl *fuse_get_inode_acl(struct inode *inode, int type, bool rcu);
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 49c01559580f..5b423fdbb13f 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -209,7 +209,7 @@ static const struct xattr_handler fuse_xattr_handler = {
 	.set    = fuse_xattr_set,
 };
 
-const struct xattr_handler *fuse_xattr_handlers[] = {
+const struct xattr_handler * const fuse_xattr_handlers[] = {
 	&fuse_xattr_handler,
 	NULL
 };
-- 
2.34.1

