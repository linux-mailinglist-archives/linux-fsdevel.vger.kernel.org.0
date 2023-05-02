Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DE16F4D8F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 01:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjEBXWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 19:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEBXWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 19:22:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8632128;
        Tue,  2 May 2023 16:22:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aaf70676b6so22033025ad.3;
        Tue, 02 May 2023 16:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683069736; x=1685661736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lgMQUkd3KBDP4s/1XVkXehFFe7sxYiQlnhryYVxOB2g=;
        b=LWUbpa+uQUvwwOdRlC0Pk8VuQuXmYewaovZXseTz+3OTIOpNQVPsyFmtKmg+mQflnf
         6CJjEYFqEU1oQwEprovsS3r+IFbWbUlDL29RCSIiSunLp/6K3ir45sl4ED4kijVHXeJv
         ynUn6JBn5eM2K9LEL3vEFUuNT4JfDpQoTrzjceyayADfyrbtAc88FdPS5YpmXf4KcKi3
         0tudcbM5NyucVvb4cmIzW+zaPT0WZVLVSQWDhcoSfqx7YrniVedMp6gFRlxmo6aROglp
         XAVWn+ogeeQB+3h2xKJROvCpfQMJOenMQla30Nc7GgQIXxsgX5EuzKRjzTyDnGGv9iDH
         OUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683069736; x=1685661736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgMQUkd3KBDP4s/1XVkXehFFe7sxYiQlnhryYVxOB2g=;
        b=MnEhx1xswGPUr/oRD19ESR+WVVJjumnt+20v26buUP7fmkZcwV6QdCLd5248NX3Jo3
         OLz2n17v5xGrfNRzXkx9oFKVxUyzVl3ufvvRqujOp2swkpS+LkTXceRF70uEpIN3k/Bg
         KSBquRQWpGdn9Z/oghwtbJowDYZ4SWxtox6nPxRM06zqBnavsrXJsOFb6MGB5uhOCEjm
         2+s0jjxdCA4CcabyEZQSoo5XXCfegpsTRs9GL7mKqYkVxE4Xg9PCdAKf7zUFWvvD+dMt
         wc/IKeE867SejbFLE548lC6FkH8ybpPOAHmc1h5Rq3MIL1yy3YYWRpyTvILjAcd9vcou
         jhGQ==
X-Gm-Message-State: AC+VfDydCTwxQ58mG0BiPmeBJ7t2zo0qUF824HuYaE77sYgQ1N3171JP
        LPqde25ifx0Nz36Vw8eIaC4=
X-Google-Smtp-Source: ACHHUZ5DMcJ8Ahx9RqFPEqh7DOK/oauMWI1cqqdWGQgaKPvztWrt/1/A0htAGrVIMuVYpSe559X3TQ==
X-Received: by 2002:a17:902:b78a:b0:1a6:d4cb:eeb3 with SMTP id e10-20020a170902b78a00b001a6d4cbeeb3mr94494pls.63.1683069735961;
        Tue, 02 May 2023 16:22:15 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-87-104.dynamic-ip.hinet.net. [36.228.87.104])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b00194caf3e975sm20261704plx.208.2023.05.02.16.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 16:22:15 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [PATCH] fs: fix incorrect fmode_t casts
Date:   Wed,  3 May 2023 07:22:08 +0800
Message-Id: <20230502232210.119063-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use __FMODE_NONOTIFY instead of FMODE_NONOTIFY to fixes
the following sparce warnings:
fs/overlayfs/file.c:48:37: sparse: warning: restricted fmode_t degrades to integer
fs/overlayfs/file.c:128:13: sparse: warning: restricted fmode_t degrades to integer
fs/open.c:1159:21: sparse: warning: restricted fmode_t degrades to integer

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 fs/open.c           | 2 +-
 fs/overlayfs/file.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 4478adcc4f3a..9d5edcedcbb7 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1156,7 +1156,7 @@ inline struct open_how build_open_how(int flags, umode_t mode)
 inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 {
 	u64 flags = how->flags;
-	u64 strip = FMODE_NONOTIFY | O_CLOEXEC;
+	u64 strip = __FMODE_NONOTIFY | O_CLOEXEC;
 	int lookup_flags = 0;
 	int acc_mode = ACC_MODE(flags);
 
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 7c04f033aadd..0801917f932e 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -35,7 +35,7 @@ static char ovl_whatisit(struct inode *inode, struct inode *realinode)
 }
 
 /* No atime modification nor notify on underlying */
-#define OVL_OPEN_FLAGS (O_NOATIME | FMODE_NONOTIFY)
+#define OVL_OPEN_FLAGS (O_NOATIME | __FMODE_NONOTIFY)
 
 static struct file *ovl_open_realfile(const struct file *file,
 				      const struct path *realpath)
-- 
2.34.1

