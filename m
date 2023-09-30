Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0272A7B3E3F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbjI3FDQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjI3FCX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:02:23 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E041510E7;
        Fri, 29 Sep 2023 22:01:55 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27747002244so9144653a91.2;
        Fri, 29 Sep 2023 22:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050115; x=1696654915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoSS5+yx7J+uWrFeSUXvh9abBFJWkLUVnx99Iw9FVh0=;
        b=ggyKUR3EXYYVlvz449UDK7Upsyy3t7my4SD+b9E9EwQZlGJUhMFRAOQ+ZDXTnKxtrT
         eTnjnurFZs/xvpIjV8f+nzxDbtEP0+1YauwDTsNoX7FmZsd7iv8T5Mz967gv7tsOKeKk
         6FexgoxoychUKTiNiQCrY+Zu0Caz7ViMd/4Zuvdh95w46TbGqOiGNScbIcMOdA0h4Gix
         kKZMupl5P9w8wFfLfhF6VH1l8qdLiosv7S4NY6SoktFI03jztA5TeLGtSXeI2XlWQFyj
         N+RF10C/whD0vqAzUWjaSDQxeB299dbmqjk2dHV9iWnBH50jzff+GNiGejd2pkgm8Dx2
         fNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050115; x=1696654915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoSS5+yx7J+uWrFeSUXvh9abBFJWkLUVnx99Iw9FVh0=;
        b=H8X/69eExXoFkRAC8Bmz3Gx+ENI3lDY0zVPlpAf2GUQcswgijGmlHTpQpjhFhqVRsU
         x2fW9ecHEb/wKYmCg3FxtL2SDQWVdDxd3qFj3/bgdL2LXjBSOGXf3xYsqp/asKTtbKj6
         upS+bzhLQSAb2jIwytk3R9jv7eNCGJqajHYDjx205wWKUI+THJFSdyx39rV4MqDGYmh9
         iUncDtaY4qGTPMq90V7WWM3bInpoo1e3a1+MUe0DajBlcH37S4Tw6Rx3eu0SbWLBgsiJ
         8JeMlhnse8Kz7z8ws7khtW1CCtCF68EnMJwEML8SBBye4oBJk3WkOilQlImwjJkihevl
         NPxg==
X-Gm-Message-State: AOJu0YwDKB5Dj6NHkI45+2AzTkMh+Ap2oALBc22/OEjtpJwxNsUmn5BL
        UIlqOz5Wr9gpClGfl1bP6G9Gzsyf7z52lQ==
X-Google-Smtp-Source: AGHT+IEMWxsIMtJlcvm4h/VCowplAb2v1HoqTZeqIugjFkQ5WTf9CFM9T3FpOLr/sorn6RkIJw0rug==
X-Received: by 2002:a17:90a:e60a:b0:277:371e:fa9b with SMTP id j10-20020a17090ae60a00b00277371efa9bmr5370212pjy.24.1696050115411;
        Fri, 29 Sep 2023 22:01:55 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:55 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 17/29] kernfs: move kernfs_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:21 -0300
Message-Id: <20230930050033.41174-18-wedsonaf@gmail.com>
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
kernfs_xattr_handlers at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/kernfs/inode.c           | 2 +-
 fs/kernfs/kernfs-internal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index b22b74d1a115..45a63c4e5e4e 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -434,7 +434,7 @@ static const struct xattr_handler kernfs_user_xattr_handler = {
 	.set = kernfs_vfs_user_xattr_set,
 };
 
-const struct xattr_handler *kernfs_xattr_handlers[] = {
+const struct xattr_handler * const kernfs_xattr_handlers[] = {
 	&kernfs_trusted_xattr_handler,
 	&kernfs_security_xattr_handler,
 	&kernfs_user_xattr_handler,
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index a9b854cdfdb5..237f2764b941 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -127,7 +127,7 @@ extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
 /*
  * inode.c
  */
-extern const struct xattr_handler *kernfs_xattr_handlers[];
+extern const struct xattr_handler * const kernfs_xattr_handlers[];
 void kernfs_evict_inode(struct inode *inode);
 int kernfs_iop_permission(struct mnt_idmap *idmap,
 			  struct inode *inode, int mask);
-- 
2.34.1

