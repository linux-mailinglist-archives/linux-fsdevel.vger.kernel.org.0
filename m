Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F60B4C7EB3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 00:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiB1Xtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 18:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiB1Xtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:49:41 -0500
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226E211986A;
        Mon, 28 Feb 2022 15:49:02 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id e13so12072435plh.3;
        Mon, 28 Feb 2022 15:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lc4mIXXL5Ef/I3p10v5+TFlkCVtwPuZSDWJdp2LidKA=;
        b=yupkfphPjkB8DwkmZQzTlg0peVIwp+xq7afQ++f/BY64fuyZp6cWLLOr27ueLq5rhs
         fcOi2auDCMNRMP3WklwjrztSCti8DajiKUlbw0pkogw9cYExMtLASJ9ox5ZfflTCtHzk
         cm8m1RtbXiHw1FD95qIuQvue4g2qzDd74n4blnvkn5bkyIRwbG4SVGdcxD4pY3/4YhvJ
         YGYZHsqVD3oAfEpfVVOU24B28wd7NPQWw9J88k/k1+3nPB6VswXzoidZuSYtF1O0amux
         QlYlriCcQoDEuL9iewPhIhsvAYzTE6UhFpyCiesYt48wI7nOjgwPDT8GrK418WrSL+M3
         9RIw==
X-Gm-Message-State: AOAM533LOCyZasGsYH1XZHexTmf1cYJ5pGnX4dFIgsXEQrWy7VYf/bhY
        WsklZhfBjOgbdsoIRsRvUZloTiNgZo4=
X-Google-Smtp-Source: ABdhPJxT592izrQyWeL4sbYn4PtXt/J5FjaECRbMuy3IpE6I999dIsNTHUnqv/+2IXUKJYm37FhD4g==
X-Received: by 2002:a17:90a:af88:b0:1bd:6b5d:4251 with SMTP id w8-20020a17090aaf8800b001bd6b5d4251mr3732648pjq.134.1646092141054;
        Mon, 28 Feb 2022 15:49:01 -0800 (PST)
Received: from localhost.localdomain ([61.74.27.164])
        by smtp.gmail.com with ESMTPSA id t27-20020aa7939b000000b004ce11b956absm13829905pfe.186.2022.02.28.15.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:49:00 -0800 (PST)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/4] ksmbd: remove internal.h include
Date:   Tue,  1 Mar 2022 08:48:30 +0900
Message-Id: <20220228234833.10434-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since vfs_path_lookup() is exported, It should not be internal.
Move vfs_path_lookup prototype in internal.h to linux/namei.h.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/internal.h         | 2 --
 fs/ksmbd/vfs.c        | 2 --
 include/linux/namei.h | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 8590c973c2f4..deee2367df44 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -58,8 +58,6 @@ extern int finish_clean_context(struct fs_context *fc);
  */
 extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
 			   struct path *path, struct path *root);
-extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
-			   const char *, unsigned int, struct path *);
 int do_rmdir(int dfd, struct filename *name);
 int do_unlinkat(int dfd, struct filename *name);
 int may_linkat(struct user_namespace *mnt_userns, struct path *link);
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 19d36393974c..a1ab0aaceba5 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -19,8 +19,6 @@
 #include <linux/sched/xacct.h>
 #include <linux/crc32c.h>
 
-#include "../internal.h"	/* for vfs_path_lookup */
-
 #include "glob.h"
 #include "oplock.h"
 #include "connection.h"
diff --git a/include/linux/namei.h b/include/linux/namei.h
index e89329bb3134..4858c3cdf7c6 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -63,6 +63,8 @@ extern struct dentry *kern_path_create(int, const char *, struct path *, unsigne
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
+int vfs_path_lookup(struct dentry *, struct vfsmount *, const char *,
+		    unsigned int, struct path *);
 
 extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
-- 
2.25.1

