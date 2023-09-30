Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0351A7B3E48
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjI3FDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbjI3FDD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:03:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE3F19B2;
        Fri, 29 Sep 2023 22:02:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5ff5f858dso87314455ad.2;
        Fri, 29 Sep 2023 22:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050129; x=1696654929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UA+v7vVQRQxu5MLsOJ6RxWE6x/okoJ8LNf7oCvDbOY=;
        b=J/Ur7VXNDXSb5TMhCWT6V5Q7cX1BUXmsXlPMi4l/n3vGOR6xfm6p6t6fIGmsusncCP
         DRyCFL2fS4TvZecx3fDy4AjO4xuRArhrPpR7bmuELUAKaZa/nX/J6F+s/CoEjnGkf6mX
         Rwxb4i12JRG0Tn+/nP1ln+rxvGJU0KBeiZu7VDfxs+3WKRTmg+3/Q7GCOTvPSCLiJt0p
         u1K7p07n2GH6gTjzrXIVv/bXk3lli7dMDQHrxQ8giHTIq1oh+4cM45OKdaExrQgjD0wy
         r9LklzBAX6ivTX0xbAiHBrnotuk5Nstx7c3+Wzu5RuMoBHucpJzplVTyRuGQ+TelXKiZ
         yKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050129; x=1696654929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UA+v7vVQRQxu5MLsOJ6RxWE6x/okoJ8LNf7oCvDbOY=;
        b=uQYArvhS1MrOy6f0eMGnADQ7lEfhXoFr2bKr16E7/oEIDcSRISGBhWDnQznejEzNFx
         I4bU15W4tra08XKQExNHsiScPiwBg0zXmBu9biB09ycgylal67U2V+u7WpeF4fOoPs87
         FYBxqSvD9tqLeK2eZEVdTDHMJIKB5Ec8/F8TQBz4MrvU1sGZcPPN4Qf/Q9IsyfRB2ibI
         TkP6Q7Bw6Vy++2Nv8WMvH84Bt0lUpar+iyjZvfigChebR2VyUKPJMeu+gD0o8NpJV6bV
         oU5zIWgLtgvKTOw5AKmoZsf5mzaoqsEt7JLhM3SVoDxtfty0t5y9gAl+MWUAXJX7ON7X
         gQuQ==
X-Gm-Message-State: AOJu0Yyxf2jo1ktKr2dewpgLeZe/ZseYqLBHT+BGqCtS9bI6x76shQGk
        IrzSQMyaLQ1YQ7bSXY1VVZg=
X-Google-Smtp-Source: AGHT+IEuzkaprS5HRUdUWT/HBBKMyiJ/HANbQ2WxSEr67qAVmdBIMEr9nsIf9FKgGhVaVUaQQDdZHw==
X-Received: by 2002:a17:903:230d:b0:1c0:98fe:3677 with SMTP id d13-20020a170903230d00b001c098fe3677mr6409717plh.56.1696050128820;
        Fri, 29 Sep 2023 22:02:08 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:02:08 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Subject: [PATCH 21/29] orangefs: move orangefs_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:25 -0300
Message-Id: <20230930050033.41174-22-wedsonaf@gmail.com>
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
orangefs_xattr_handlers at runtime.

Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
Cc: devel@lists.orangefs.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/orangefs/orangefs-kernel.h | 2 +-
 fs/orangefs/xattr.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index ce20d3443869..e211f29544e5 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -103,7 +103,7 @@ enum orangefs_vfs_op_states {
 #define ORANGEFS_CACHE_CREATE_FLAGS 0
 #endif
 
-extern const struct xattr_handler *orangefs_xattr_handlers[];
+extern const struct xattr_handler * const orangefs_xattr_handlers[];
 
 extern struct posix_acl *orangefs_get_acl(struct inode *inode, int type, bool rcu);
 extern int orangefs_set_acl(struct mnt_idmap *idmap,
diff --git a/fs/orangefs/xattr.c b/fs/orangefs/xattr.c
index 68b62689a63e..74ef75586f38 100644
--- a/fs/orangefs/xattr.c
+++ b/fs/orangefs/xattr.c
@@ -554,7 +554,7 @@ static const struct xattr_handler orangefs_xattr_default_handler = {
 	.set = orangefs_xattr_set_default,
 };
 
-const struct xattr_handler *orangefs_xattr_handlers[] = {
+const struct xattr_handler * const orangefs_xattr_handlers[] = {
 	&orangefs_xattr_default_handler,
 	NULL
 };
-- 
2.34.1

