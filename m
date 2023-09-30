Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594DA7B3E39
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjI3FCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjI3FBx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:01:53 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6E2CE6;
        Fri, 29 Sep 2023 22:01:43 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c61bde0b4bso90823145ad.3;
        Fri, 29 Sep 2023 22:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050103; x=1696654903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvbnXtkeP9vLNSIc1O3qas9xHaLQIqu8ISSeZ0t4O0M=;
        b=WR4dBCwqwdsx8Zi6fJhEwjZBXszFELf+jxpKQoDJlszfZ1N+ref7hEoS/7yiUtSdCJ
         KZKZsenU9t7s1aYxZWobCH83vle/GqEaJpxGpwB4NHMOlGdqP6Xnm9RDrrDMjIHOMNYh
         kRWX4It7l7W+aQ0f9UQhzzRm4x1e3oAR+tRnZoDuNuCwWeVgOpWSe6y1I+oqdQaHD2RE
         lA9IMNa1NImMxs6PrwIk1IZJNNgrnccjEYPvq8DBzGWp4geffLNzJ2lCYEbPq43gK80T
         x0t4AZDZ3hBo4PQvuTvokTYV2wbhrX6j/qAgJ45a5Cw3EMKkwiNcGw1Vy+Oa/zIcCXuL
         4aZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050103; x=1696654903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvbnXtkeP9vLNSIc1O3qas9xHaLQIqu8ISSeZ0t4O0M=;
        b=BNbj2At8ThQDsZ6tWha3lWGxrgddodErKLy8a38TRbRF9ZK/dv4hhNyg+W907xT0wM
         hkm2mgYJQ+vqPkr8CRRGLsiXvWE7N+Ygb3/+yKkV0xG/cS8dVTIAoi+zpzBpnnBQobWX
         6i3UVrG/YyqFkgbOHdTVRO9B9Q0ivHy5Pz/HUwzPvMPADy9HYEzig+4+M7vLweN42Avu
         4aWKN5l4VpImQJSAOw4HEOFT1tJBvMigzwCLogYTpNdKMAAoiekgcjPio1FsGs88tJmr
         XmH/Aeq1kP4Hw5Rgu16mP+wmuKaZhSQLIVkWEmrZZrQPB6msuNnbqXr3/jrwvUlXkqth
         4Dzg==
X-Gm-Message-State: AOJu0Yzhzl2zXhk3V71+dwCYf2C2slWxeAEwEJFQ5k8ZUnCZDGZIVStF
        DbJSX8vG1a+ocq/DBgh55eg=
X-Google-Smtp-Source: AGHT+IHWPp5GDuSkJqhkMrYSN6o7H32y8m1warQSys7iIHsnmIW1CkiwE7DyvBkiHOBx8/qAvG+G8w==
X-Received: by 2002:a17:902:7445:b0:1c5:ce3c:c399 with SMTP id e5-20020a170902744500b001c5ce3cc399mr6626185plt.39.1696050102764;
        Fri, 29 Sep 2023 22:01:42 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:42 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH 14/29] hfsplus: move hfsplus_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:18 -0300
Message-Id: <20230930050033.41174-15-wedsonaf@gmail.com>
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
hfsplus_xattr_handlers at runtime.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/hfsplus/xattr.c | 2 +-
 fs/hfsplus/xattr.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 58021e73c00b..9c9ff6b8c6f7 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -13,7 +13,7 @@
 
 static int hfsplus_removexattr(struct inode *inode, const char *name);
 
-const struct xattr_handler *hfsplus_xattr_handlers[] = {
+const struct xattr_handler * const hfsplus_xattr_handlers[] = {
 	&hfsplus_xattr_osx_handler,
 	&hfsplus_xattr_user_handler,
 	&hfsplus_xattr_trusted_handler,
diff --git a/fs/hfsplus/xattr.h b/fs/hfsplus/xattr.h
index d14e362b3eba..15cc55e41410 100644
--- a/fs/hfsplus/xattr.h
+++ b/fs/hfsplus/xattr.h
@@ -17,7 +17,7 @@ extern const struct xattr_handler hfsplus_xattr_user_handler;
 extern const struct xattr_handler hfsplus_xattr_trusted_handler;
 extern const struct xattr_handler hfsplus_xattr_security_handler;
 
-extern const struct xattr_handler *hfsplus_xattr_handlers[];
+extern const struct xattr_handler * const hfsplus_xattr_handlers[];
 
 int __hfsplus_setxattr(struct inode *inode, const char *name,
 			const void *value, size_t size, int flags);
-- 
2.34.1

