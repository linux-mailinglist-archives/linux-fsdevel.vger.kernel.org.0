Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1AC510ED1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 04:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357193AbiD0CgX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 22:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiD0CgU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:36:20 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C590A65D0D;
        Tue, 26 Apr 2022 19:33:10 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id h1so398208pfv.12;
        Tue, 26 Apr 2022 19:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KI2OXoDSI4Jfk05XGM6BWGfsrNlJaKDwvdIstImWDWQ=;
        b=UOerIdgK2gi9kl+79xQLCOUSiJ7uexPx1O1n/5GihdTT7qc79au3JQpIYacQ22N3ed
         bqpnXjDJ1YZZbdc/SyG0rVvlYa+3boJR0psn0VmpQLz9i7ONNVHUtubB4DZTsh2vBdta
         o+M5JWQM4/urDiI5FnKszFXpO3zS21TYzSS9b1tsBGJxStLIhyzsukEM3ICx8b6j3opv
         ol1KXb9CbrNXjbFQ8JP8iUhFa+PYJ/W6ubmC1ozvLpklyLlY6gWK78Ci9wijdI8Jvxs6
         mcF95v5ucQaC4NDpDD2IqQp3MbZCwIFPRjPWm6w1E5aeX2yIQrrKxGm2coIAl539uIXg
         SZaw==
X-Gm-Message-State: AOAM532hUXpZ++T/aTFqXCW9WEpy4+xERrtvn7SZnQEDSZlud2RggHwU
        a4yTmMiFDw1tmuimOrdsquGaj/fdf6M=
X-Google-Smtp-Source: ABdhPJyUWAYHf9/HLoqpz4GCZed+tg2AqSi/FeiFTP/2ojK8IsoiTXzed0HFHooUzqd+DNpuRYMa7Q==
X-Received: by 2002:a63:257:0:b0:3aa:a481:9159 with SMTP id 84-20020a630257000000b003aaa4819159mr22103321pgc.1.1651026789868;
        Tue, 26 Apr 2022 19:33:09 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id t1-20020a628101000000b0050d47199857sm7338564pfd.73.2022.04.26.19.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 19:33:09 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 1/3] ksmbd: remove internal.h include
Date:   Wed, 27 Apr 2022 11:32:43 +0900
Message-Id: <20220427023245.7327-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since vfs_path_lookup is exported, It should not be internal.
Move vfs_path_lookup prototype in internal.h to linux/namei.h.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/internal.h         | 2 --
 fs/ksmbd/vfs.c        | 2 --
 include/linux/namei.h | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 08503dc68d2b..a73eda6f9f63 100644
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
index dcdd07c6efff..f79dfcebe480 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -18,8 +18,6 @@
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

