Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCEB7B3E2A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjI3FCE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbjI3FBe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:01:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F30FCF5;
        Fri, 29 Sep 2023 22:01:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2774f6943b1so8389147a91.0;
        Fri, 29 Sep 2023 22:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050078; x=1696654878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moKe2A8erbuVLM63RNmgB8NBsCNapPq9yq0WoyHwDmA=;
        b=lVOh9VrIg2nHAqimSf5mDWMmLaMsjN66R02bvnGHtoKo0G2dwCmHLbuiXgJoqf4oYz
         7KpkKugKRuBTMjuXUG8M6Hz63eaSeajASjwOM2brUVl6lcS78jLAAhYHcyiSXEUzn6UY
         /YtLASjjlDx5vJWg3SVJ3TQObsKdU5hSAMGko8149z/b+cqkkank1cF5lV4zgzQarEck
         jUA2dVHH3a7c052SbzubZ/QTd0GYJCcvxYaQc25XnIlOUnoFy1MAcBVx2BvPfXvEOYQK
         NxZXB82tu3TVgu5grpDpCuao/LDYcJHv4oPeZdE2Vcl3Uxwl7KaEQxN912JFXYQDlhhg
         YbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050078; x=1696654878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moKe2A8erbuVLM63RNmgB8NBsCNapPq9yq0WoyHwDmA=;
        b=LASJagE8y5klTlW1gvDuYifSTNoqyw6660n4kZCU9uPLhSUqdRcGdUbGfgfYwgVk3d
         0dbii0wzow8SktjXYplK+96JsxLp0YjKygkBE8wyPTM5wCBIOfVUWEzxa7Ut5CzjmH9C
         wif2pAUU1sfp+cBVTxSN7YW06wFoSOkUx03pWS9vYeiBSIaclMHvzP+U1iGBXbKdh4fW
         NJ7zLfv+SG112CdRmwzycTVerzhdVhGi/SnC4GNliafhdhlPQ62xWgbTXIPhJ7ZB+fCK
         jvjexbhgOEUA7/3OVKZXtvauym+i1KGondA2U1rTs3ax0864nmrR7idyUuQfKTIX7ttg
         GQag==
X-Gm-Message-State: AOJu0Yw3ECrOw3yLt39V3zq4o5H7v61DKXVVgf5G0eMRxPe6Gc1dIxPd
        KydF4+ZH96VyZoKN/x4iG3w=
X-Google-Smtp-Source: AGHT+IG9xUPKggQukfGlY8IPKqDIaRFyp8HV3eI9857ynlu4H7izyVX8aLW+YGzrRTPz4rA+zvfUXg==
X-Received: by 2002:a17:90b:383:b0:26d:416a:b027 with SMTP id ga3-20020a17090b038300b0026d416ab027mr6303354pjb.31.1696050078485;
        Fri, 29 Sep 2023 22:01:18 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:18 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH 06/29] ceph: move ceph_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:10 -0300
Message-Id: <20230930050033.41174-7-wedsonaf@gmail.com>
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
ceph_xattr_handlers at runtime.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/ceph/super.h | 2 +-
 fs/ceph/xattr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 3bfddf34d488..b40be1a0f778 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1089,7 +1089,7 @@ ssize_t __ceph_getxattr(struct inode *, const char *, void *, size_t);
 extern ssize_t ceph_listxattr(struct dentry *, char *, size_t);
 extern struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_info *ci);
 extern void __ceph_destroy_xattrs(struct ceph_inode_info *ci);
-extern const struct xattr_handler *ceph_xattr_handlers[];
+extern const struct xattr_handler * const ceph_xattr_handlers[];
 
 struct ceph_acl_sec_ctx {
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 806183959c47..0350d7465bbb 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1416,7 +1416,7 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
  * List of handlers for synthetic system.* attributes. Other
  * attributes are handled directly.
  */
-const struct xattr_handler *ceph_xattr_handlers[] = {
+const struct xattr_handler * const ceph_xattr_handlers[] = {
 	&ceph_other_xattr_handler,
 	NULL,
 };
-- 
2.34.1

