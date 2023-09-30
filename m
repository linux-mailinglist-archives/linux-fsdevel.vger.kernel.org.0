Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F8F7B3E2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjI3FCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbjI3FBt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:01:49 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899DACC2;
        Fri, 29 Sep 2023 22:01:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c5c91bece9so121451755ad.3;
        Fri, 29 Sep 2023 22:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050090; x=1696654890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqRIIscirReKomhnn9aWQqgUEl26ak+53Sd7DXm6yNk=;
        b=J/E/6cYhFXODUgKhgpw7KxO+RWk866Jd1T6p7wnebtV6nCbMczelHpVDQ7G1MSUy8W
         jqTwlRcS0CaFFCd3NcOuElMHkuTKgcEgeIqcvcf6RciT/SZ4kmmeL2BR3G5UKxX/Cqxd
         vEwbUEvfbRfEQ+5Ic4n8vFkVsIQMFUtDcflMf5bR0WSZ9rQt5MvWyFijaoOQyT1H1A33
         Ir1vwtDCT1wAvPFyQPFzY5St53rmd4N18dRKX61lGuJvDEL14bznoikTycv07vTynHIA
         GpN2/NOrEGz9KZglogJFEMaKrBWuN1DKeuZFfnFRW9q6W6JRC23js+oPhHxRy1TnUzVV
         +KJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050090; x=1696654890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqRIIscirReKomhnn9aWQqgUEl26ak+53Sd7DXm6yNk=;
        b=d8yTDrbQ3CwV8jv489YYcOox37BekvmHzCNLdJKZUKfju6drmKt00SxgP8ooAc/bpn
         PMNT83p/tB15U9Zc4lzavd2AEkZ6qXYOwS16MdoTk02hu+GTjXqXa8y7pXaYzGn6noMi
         jxvSe7sHdnoW9wXymHVn1DKmiswpSyWgOidSL4Yth32MYIBpCoLm1AoZsBl2zkewhQHY
         /7HwulgTGDXGbKU4KYY5FlaAGamFZ2sWZtAC5PR4mZgA4qa2/d/Wv6uTboh1zZAUql7p
         b8dSngvvm08EGcnRgjfMLVnPZ3x0PnTSNbjnWJ8rW976VUAlx0aFPXipIp0jFtjgYMeq
         yZQQ==
X-Gm-Message-State: AOJu0YxU5q1yKhu6s06Zo/dajpBCd1OHO4e19b5rSWZhYzgesaUZqVwV
        USgrQmbBS/v4Q4LF4h4vyok=
X-Google-Smtp-Source: AGHT+IFmXRu8d6qDpLkIqSWIVe9p5te2KB46ZsYikIRm4E6Z4vdff7fDocDNnF8ojVR4oc3Gyyl2kw==
X-Received: by 2002:a17:902:c94d:b0:1c7:4a8a:32d1 with SMTP id i13-20020a170902c94d00b001c74a8a32d1mr2347477pla.28.1696050090497;
        Fri, 29 Sep 2023 22:01:30 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:30 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 10/29] f2fs: move f2fs_xattr_handlers and f2fs_xattr_handler_map to .rodata
Date:   Sat, 30 Sep 2023 02:00:14 -0300
Message-Id: <20230930050033.41174-11-wedsonaf@gmail.com>
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
f2fs_xattr_handlers or f2fs_xattr_handler_map at runtime.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/f2fs/xattr.c | 4 ++--
 fs/f2fs/xattr.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 476b186b90a6..3895a066f36c 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -189,7 +189,7 @@ const struct xattr_handler f2fs_xattr_security_handler = {
 	.set	= f2fs_xattr_generic_set,
 };
 
-static const struct xattr_handler *f2fs_xattr_handler_map[] = {
+static const struct xattr_handler * const f2fs_xattr_handler_map[] = {
 	[F2FS_XATTR_INDEX_USER] = &f2fs_xattr_user_handler,
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
 	[F2FS_XATTR_INDEX_POSIX_ACL_ACCESS] = &nop_posix_acl_access,
@@ -202,7 +202,7 @@ static const struct xattr_handler *f2fs_xattr_handler_map[] = {
 	[F2FS_XATTR_INDEX_ADVISE] = &f2fs_xattr_advise_handler,
 };
 
-const struct xattr_handler *f2fs_xattr_handlers[] = {
+const struct xattr_handler * const f2fs_xattr_handlers[] = {
 	&f2fs_xattr_user_handler,
 	&f2fs_xattr_trusted_handler,
 #ifdef CONFIG_F2FS_FS_SECURITY
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index b1811c392e6f..a005ffdcf717 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -125,7 +125,7 @@ extern const struct xattr_handler f2fs_xattr_trusted_handler;
 extern const struct xattr_handler f2fs_xattr_advise_handler;
 extern const struct xattr_handler f2fs_xattr_security_handler;
 
-extern const struct xattr_handler *f2fs_xattr_handlers[];
+extern const struct xattr_handler * const f2fs_xattr_handlers[];
 
 extern int f2fs_setxattr(struct inode *, int, const char *,
 				const void *, size_t, struct page *, int);
-- 
2.34.1

