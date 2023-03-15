Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5346BBFD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 23:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjCOWfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 18:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjCOWf3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:35:29 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185331A4A7;
        Wed, 15 Mar 2023 15:35:29 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id c18so3110939ple.11;
        Wed, 15 Mar 2023 15:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678919728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92A4DUbJ1iUIOVebdBn43IKUXQ3Gfcz8flu0VYa3d5E=;
        b=Hp4yl/ZltEWLxBah+zIf1dphSkP8oelYZyX2TSKDGpo8/QqwJNfQ2N8we0G+DL3IfC
         XlxZP5QVkvCz9sRNB/NMGR7c+72FJxsqtk5Lcx1avbtUUyIpogLs3kwsXVZooXt7lR04
         aProqK8uWI1dj9hzrE3MS2hYdGLQsN0kcwNrwkzPo0rUvwJPALOHHt4ciRF/ozyeOc62
         N8NUZ2mortani3zEFsAkJ6sWrOT+rbbinz/sFlZMGBvm0gCEsnV98KgkVNPXtLO5Ok0p
         sViem/15sna13t2pFhyzdRI7SrzC4HQoRN5zkG1VJo4v5c4QPhjBmXWqfvwgltqwNxg1
         ZPLw==
X-Gm-Message-State: AO0yUKWNFmSE8kpvR9Ubvw1Kp3ID/A9w/BsMpKXssFtk+ZIDeqaRB/MV
        LAM+zdUe1gKhgua0okBN0M8=
X-Google-Smtp-Source: AK7set+pGmiEdzu6DvkI1Xw2bnUxgTyMADlzGfLU1rQW8x9SeLVvw89D+Q3dzzPSJoV4NhjxJs5DEA==
X-Received: by 2002:a05:6a20:9146:b0:d3:f0af:4707 with SMTP id x6-20020a056a20914600b000d3f0af4707mr1756251pzc.20.1678919728496;
        Wed, 15 Mar 2023 15:35:28 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id c12-20020aa781cc000000b005dc70330d9bsm4034369pfn.26.2023.03.15.15.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 15:35:28 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        brauner@kernel.org, Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v8 1/3] ksmbd: remove internal.h include
Date:   Thu, 16 Mar 2023 07:34:33 +0900
Message-Id: <20230315223435.5139-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315223435.5139-1-linkinjeon@kernel.org>
References: <20230315223435.5139-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
index dc4eb91a577a..071a7517f1a7 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -59,8 +59,6 @@ extern int finish_clean_context(struct fs_context *fc);
  */
 extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
 			   struct path *path, struct path *root);
-extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
-			   const char *, unsigned int, struct path *);
 int do_rmdir(int dfd, struct filename *name);
 int do_unlinkat(int dfd, struct filename *name);
 int may_linkat(struct mnt_idmap *idmap, const struct path *link);
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 5ea9229dad2c..cef07d7fb7dc 100644
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
index 0d4531fd46e7..c2747cfe97ac 100644
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

