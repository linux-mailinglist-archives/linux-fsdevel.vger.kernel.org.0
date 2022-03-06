Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D28E4CE805
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 02:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiCFBLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 20:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiCFBLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 20:11:47 -0500
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C8535DCC;
        Sat,  5 Mar 2022 17:10:56 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id e13so10897022plh.3;
        Sat, 05 Mar 2022 17:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hP0S734wwC7pJwjk7blXilh0iBBGpOed5Zt7sWmFDBc=;
        b=8BjM8tBotYzlBRq5fS17+PMjBbCtlvQUMDCydjz5nVZ4YRLGTXUxzhOx2qu0QILA8f
         s1gHZzJpKwopxa7LXowZCO03ZLP1sPQZFjCJo/9J1Rr2jIuDCTN1jcqIz9Gzu2TepPgW
         QiVblafcxTm3ME5QEZe51agUljSzvZk8xdbEuWdZU7HSD/8ACgSgjiWSqhXDLtmlcgus
         fXaCKc8px1deV0D3Il/2/fXmJ5hcgbQY+pJGMSi7kz6oDn/prv40Ra6OFzYNDbToSejf
         t8d7zfvaFi2omGlXzb4kdchJw/aTYHWzxlZEHL5N2LPKgXT43TZs2sQuStb9itGxK5d+
         Hr1g==
X-Gm-Message-State: AOAM530wdfhBd/bS2zOQcmbxGAtyBPBRZ351Kq+dRDeWEES/gTVS7Fzn
        dOClPZx0akV+1E7yonLdzjbapR8PgdM=
X-Google-Smtp-Source: ABdhPJw/BbHe5c5KXzInOg/T8oKGoHflYa7mAUS0UN1ErXaLf37QSc0SvlefrsVUZjoU74jkuGJy2Q==
X-Received: by 2002:a17:902:aa8e:b0:14f:fa5e:fe80 with SMTP id d14-20020a170902aa8e00b0014ffa5efe80mr6011236plr.84.1646529055480;
        Sat, 05 Mar 2022 17:10:55 -0800 (PST)
Received: from localhost.localdomain ([61.74.27.164])
        by smtp.gmail.com with ESMTPSA id d2-20020a056a0024c200b004f6b6817549sm7668110pfv.173.2022.03.05.17.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 17:10:55 -0800 (PST)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/4] ksmbd: remove internal.h include
Date:   Sun,  6 Mar 2022 10:10:42 +0900
Message-Id: <20220306011045.13014-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since vfs_path_lookup is exported, It should not be internal.
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

