Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEB67B3E4F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjI3FEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjI3FDc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:03:32 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0870F1BE8;
        Fri, 29 Sep 2023 22:02:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c434c33ec0so114735915ad.3;
        Fri, 29 Sep 2023 22:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050138; x=1696654938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SX/rjYIK1IVXt18htg+5KG/0YnvzJQn6149rPJUtUFI=;
        b=TeVKZ34XN5rX3Hx21ON03LJGgRAhkcRlmI2N8tObLN/sZzXd7tVkFKxCp/feNKnGR3
         FDqDYyhf3tKepS8X5KCynb4FI+iiBz244RTrlq9bod7w94a3vJ2Oc1/1BqQHz5Fl6VUY
         9VAFcwU+VcpQkTWl9rDXWdPxNiG20/pz8YvFyOgjxTF5zEEMdaCrW76+w1mFvLlA1KcU
         a8V2rmfGYWJxkSdKOO+vT3CoT4Ii4NxqUfpHfJzHZhXVFmxb3P2iYhAJ6MEwuhTv5tMd
         7yP20zzflSp9D+b2U/ZG5BElCjkrBZWNYjrZz4an1GmsxiGl4oTRVPUuBUijTJpfvtHG
         hRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050138; x=1696654938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SX/rjYIK1IVXt18htg+5KG/0YnvzJQn6149rPJUtUFI=;
        b=oymItOY+KxmND7jSOnyI0kUZ3cLR1169zN0vzQgbR80jFKRv1mCvIKYK9ibATXqa5X
         Z8K10BaKfM1teKnZyhNbZ0h111QQbC11tOL2pWg0EAafncTcyFpvW25wjoDxyzAMmEJG
         NDbm51F7CBY0XtUkIYXVej5QLjH6T7N1254Wh7PP5t2Pla/iVjHMoe3bfSmG9icnhr1j
         qCgUHz0cC89rxFcpju+Tlv6J/jzHLypEWBwyBq5ZPYzbCGs3+AW3DFSNIUjuHEtgh9l/
         GrmqXLoYbpvF3Ccif8VhNuAX7JFTtLLof4u4bL8kykAWJT0go8PzfxyI/OYBVIsVreRG
         Tv9A==
X-Gm-Message-State: AOJu0YyOgIXCaaFyL2fRa02MQueSCSWipvVGFTEy8wqrE6i+T2gEZ0ET
        geRTavc/c8XZY9ZiWUjbxq8=
X-Google-Smtp-Source: AGHT+IFjm2a8W27CLi6N71R6Hxy8EwSmwRRP+6w+REpQ8qJqZGRE7okwJ0OJNqPWZzx5Z2Nm7josNg==
X-Received: by 2002:a17:902:c255:b0:1bb:c64f:9a5e with SMTP id 21-20020a170902c25500b001bbc64f9a5emr5364333plg.5.1696050138126;
        Fri, 29 Sep 2023 22:02:18 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:02:17 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 24/29] squashfs: move squashfs_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:28 -0300
Message-Id: <20230930050033.41174-25-wedsonaf@gmail.com>
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
squashfs_xattr_handlers at runtime.

Cc: Phillip Lougher <phillip@squashfs.org.uk>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/squashfs/squashfs.h | 2 +-
 fs/squashfs/xattr.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
index a6164fdf9435..5a756e6790b5 100644
--- a/fs/squashfs/squashfs.h
+++ b/fs/squashfs/squashfs.h
@@ -111,4 +111,4 @@ extern const struct address_space_operations squashfs_symlink_aops;
 extern const struct inode_operations squashfs_symlink_inode_ops;
 
 /* xattr.c */
-extern const struct xattr_handler *squashfs_xattr_handlers[];
+extern const struct xattr_handler * const squashfs_xattr_handlers[];
diff --git a/fs/squashfs/xattr.c b/fs/squashfs/xattr.c
index e1e3f3dd5a06..ce6608cabd49 100644
--- a/fs/squashfs/xattr.c
+++ b/fs/squashfs/xattr.c
@@ -262,7 +262,7 @@ static const struct xattr_handler *squashfs_xattr_handler(int type)
 	}
 }
 
-const struct xattr_handler *squashfs_xattr_handlers[] = {
+const struct xattr_handler * const squashfs_xattr_handlers[] = {
 	&squashfs_xattr_user_handler,
 	&squashfs_xattr_trusted_handler,
 	&squashfs_xattr_security_handler,
-- 
2.34.1

