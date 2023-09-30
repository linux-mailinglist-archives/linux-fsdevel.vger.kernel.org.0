Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878517B3E46
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjI3FDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjI3FDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:03:01 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E860F19A7;
        Fri, 29 Sep 2023 22:02:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c735473d1aso24030585ad.1;
        Fri, 29 Sep 2023 22:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050126; x=1696654926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERTq1h2JUPIQir/rEk+r3r2PZJ52vm7XhnYInCUG6b0=;
        b=m9y5oWQza7nh/yZ20urfhCbcy1kUZ2krNB39UVylJBvU8G/oKiNgOmyUL5Ziokcr/J
         c/hKbNws8ir2Ar61HSJwid9KLdc0oM4Xoy0fYi7WWC4oFGZOsKKFv4CqdgoGzju+cb4P
         lgpmLKMFSoJ03dQm/fBz1DMi/4b5URf+aQQSxCoJ41gnnNXKVEp3ktLjI6Qxk6qMH5ZE
         orcMqhH/wqWedFDlJnOOTcXl9rF3HQvQGuE17hlv+2WVKbiGEBMctHZ/qHZMD2X1OgnM
         a5RbzawyR3JVyFLJaZxlNftYzSdZeAohsJn7kUYYd2pe7kwYrFHLGuK6aV1wvcnq6YAh
         hjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050126; x=1696654926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERTq1h2JUPIQir/rEk+r3r2PZJ52vm7XhnYInCUG6b0=;
        b=K9PpvlduTpOqJ9OGt0CXWg6E0DKKZ4gEFfMt95DgqnhlTkxrw8k82ghYvnTNJwTEJ2
         TPu6YDRfVmGvOzkRujSD1y5NU+U1iptuRi0wN2RrCmhEdXEOlLQxt+eBjfu8eZBpQv69
         PVoNrVWRhD6ceimLf/mI4nXa17U7oKPp3NEl+ufpFGHFgp1qqWJO2LDla6QKKGLl9ws1
         iTsXB9Yks/FoKLFSDuaM7dVKPzBtz8eQz1j0daOepNnT0bp5KOESjV//P2AzsNHIW0Jw
         YMhPXrh7hY+V0pYWxlQ9DTb4BY1JxS/qqto9grrKDbjBauSfkUknM13CPg6NzgLItnPQ
         SQyw==
X-Gm-Message-State: AOJu0YxzpPOxm/p0D8O3BgCo9kGBNDn9tX7B8EoMJxUroY/8TpbmEe0Q
        +JPR/4KBLPkMKpCD+R4Oq18=
X-Google-Smtp-Source: AGHT+IE93Nz+CTn1eMCxHn42HhU5uqXNXT05Y4Weq1sWMG/m1tkqHDxA4tUzrKL70aU/jJiOIdVMlw==
X-Received: by 2002:a17:902:f7c6:b0:1c3:a4f2:7c92 with SMTP id h6-20020a170902f7c600b001c3a4f27c92mr4959184plw.65.1696050125757;
        Fri, 29 Sep 2023 22:02:05 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:02:05 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@lists.linux.dev
Subject: [PATCH 20/29] ocfs2: move ocfs2_xattr_handlers and ocfs2_xattr_handler_map to .rodata
Date:   Sat, 30 Sep 2023 02:00:24 -0300
Message-Id: <20230930050033.41174-21-wedsonaf@gmail.com>
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
ocfs2_xattr_handlers or ocfs2_xattr_handler_map at runtime.

Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: ocfs2-devel@lists.linux.dev
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/ocfs2/xattr.c | 4 ++--
 fs/ocfs2/xattr.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 4ac77ff6e676..1c54adac1e50 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -87,14 +87,14 @@ static struct ocfs2_xattr_def_value_root def_xv = {
 	.xv.xr_list.l_count = cpu_to_le16(1),
 };
 
-const struct xattr_handler *ocfs2_xattr_handlers[] = {
+const struct xattr_handler * const ocfs2_xattr_handlers[] = {
 	&ocfs2_xattr_user_handler,
 	&ocfs2_xattr_trusted_handler,
 	&ocfs2_xattr_security_handler,
 	NULL
 };
 
-static const struct xattr_handler *ocfs2_xattr_handler_map[OCFS2_XATTR_MAX] = {
+static const struct xattr_handler * const ocfs2_xattr_handler_map[OCFS2_XATTR_MAX] = {
 	[OCFS2_XATTR_INDEX_USER]		= &ocfs2_xattr_user_handler,
 	[OCFS2_XATTR_INDEX_POSIX_ACL_ACCESS]	= &nop_posix_acl_access,
 	[OCFS2_XATTR_INDEX_POSIX_ACL_DEFAULT]	= &nop_posix_acl_default,
diff --git a/fs/ocfs2/xattr.h b/fs/ocfs2/xattr.h
index 00308b57f64f..65e9aa743919 100644
--- a/fs/ocfs2/xattr.h
+++ b/fs/ocfs2/xattr.h
@@ -30,7 +30,7 @@ struct ocfs2_security_xattr_info {
 extern const struct xattr_handler ocfs2_xattr_user_handler;
 extern const struct xattr_handler ocfs2_xattr_trusted_handler;
 extern const struct xattr_handler ocfs2_xattr_security_handler;
-extern const struct xattr_handler *ocfs2_xattr_handlers[];
+extern const struct xattr_handler * const ocfs2_xattr_handlers[];
 
 ssize_t ocfs2_listxattr(struct dentry *, char *, size_t);
 int ocfs2_xattr_get_nolock(struct inode *, struct buffer_head *, int,
-- 
2.34.1

