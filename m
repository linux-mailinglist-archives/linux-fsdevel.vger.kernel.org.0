Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B150B6CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447293AbiDVMIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447326AbiDVMHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408585677D
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y10so15920777ejw.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=db3Vitp2KKXMCI4tXhZ7Z8Fx9g7h4skvU3MLdKgjhyw=;
        b=KngyRv5S7jEIUN+xPISjuNxVzTRvP2aE+MoTdi4oiW/nVaRPLXy7hYTPKTeDHlFvA4
         PPZSNQ7QY0GF23uh/FccfXXNotoobp57GkaO9mfw2Sq8oIK72YY1fqTGj2tp7rNVVQM2
         EItCEXHeG2QfsimcXm9MCZSl6hY+E6fJLlChQ/r0SFfA0YO0pWVkGEjciy8bZEYsviW9
         GvkOsVlsDta5bd9Ggqlklkt81QGKWC8iZOm5pMQ4KxnqMty8VcFFvugYCWvJCKXy8bUj
         zGVW5dJrHVC8OSlW+cAR2qV5aEo8yQFWUg2Or4fC/ZWNECPJfV0jk+r+tw+hdojRwxIZ
         Gaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=db3Vitp2KKXMCI4tXhZ7Z8Fx9g7h4skvU3MLdKgjhyw=;
        b=PyiIvLBqqQ0IAOjxy64e6Onqjd0jPzoiAUi7rRy21fXQEh7u5gjDiiyjaVkizQWlyY
         ULMPVayltcNZLL71u6007EQN8DWXbxs3OZTIYf82C1yrtM4F5O3WldTQU44jyw5IpPgI
         nSCke7X1VmGVthi3lhMulKhMKgXL9+OLEcnI2mrUmgqVV9B7Cc24RhvK2wXE11qQ2aV6
         gye6aibFuj+zOpC1X1vV3BYH5KyxVXrD0JrKPkQ+iaUljyvDB6xefW3esCyzycPs4pju
         Nq6v57EogX/+Lx63CEV2S2rZIxVnSsKwefZ/27FQ3XLOVxrKsmo/IArs2HDeb/5wwxPc
         Wd5A==
X-Gm-Message-State: AOAM533oSdMlawpR/fbl1HLhNPCEgWImiXNiN1X7UbabKU7UVyO8Cdh5
        4S9k6lJXkK4tJeXt8IsyegQ=
X-Google-Smtp-Source: ABdhPJy89XvlqM8WQU15ch3dyL9cHUPZvyZ7+JNF+PbBfVOOmt3Cqx/mhmoOh1ruGb0sivx1olS1Bw==
X-Received: by 2002:a17:907:9706:b0:6f0:220e:cb7a with SMTP id jg6-20020a170907970600b006f0220ecb7amr3820465ejc.569.1650629021687;
        Fri, 22 Apr 2022 05:03:41 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm697026ejv.43.2022.04.22.05.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:41 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 05/16] fsnotify: make allow_dups a property of the group
Date:   Fri, 22 Apr 2022 15:03:16 +0300
Message-Id: <20220422120327.3459282-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422120327.3459282-1-amir73il@gmail.com>
References: <20220422120327.3459282-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of passing the allow_dups argument to fsnotify_add_mark()
as an argument, define the group flag FSNOTIFY_GROUP_DUPS to express
the allow_dups behavior and set this behavior at group creation time
for all calls of fsnotify_add_mark().

Rename the allow_dups argument to generic add_flags argument for future
use.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/mark.c                 | 12 ++++++------
 include/linux/fsnotify_backend.h | 13 +++++++------
 kernel/audit_fsnotify.c          |  4 ++--
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c86982be2d50..1fb246ea6175 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -574,7 +574,7 @@ static struct fsnotify_mark_connector *fsnotify_grab_connector(
 static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 				  fsnotify_connp_t *connp,
 				  unsigned int obj_type,
-				  int allow_dups, __kernel_fsid_t *fsid)
+				  int add_flags, __kernel_fsid_t *fsid)
 {
 	struct fsnotify_mark *lmark, *last = NULL;
 	struct fsnotify_mark_connector *conn;
@@ -633,7 +633,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 
 		if ((lmark->group == mark->group) &&
 		    (lmark->flags & FSNOTIFY_MARK_FLAG_ATTACHED) &&
-		    !allow_dups) {
+		    !(mark->group->flags & FSNOTIFY_GROUP_DUPS)) {
 			err = -EEXIST;
 			goto out_err;
 		}
@@ -668,7 +668,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
  */
 int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 			     fsnotify_connp_t *connp, unsigned int obj_type,
-			     int allow_dups, __kernel_fsid_t *fsid)
+			     int add_flags, __kernel_fsid_t *fsid)
 {
 	struct fsnotify_group *group = mark->group;
 	int ret = 0;
@@ -688,7 +688,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	fsnotify_get_mark(mark); /* for g_list */
 	spin_unlock(&mark->lock);
 
-	ret = fsnotify_add_mark_list(mark, connp, obj_type, allow_dups, fsid);
+	ret = fsnotify_add_mark_list(mark, connp, obj_type, add_flags, fsid);
 	if (ret)
 		goto err;
 
@@ -708,14 +708,14 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 }
 
 int fsnotify_add_mark(struct fsnotify_mark *mark, fsnotify_connp_t *connp,
-		      unsigned int obj_type, int allow_dups,
+		      unsigned int obj_type, int add_flags,
 		      __kernel_fsid_t *fsid)
 {
 	int ret;
 	struct fsnotify_group *group = mark->group;
 
 	mutex_lock(&group->mark_mutex);
-	ret = fsnotify_add_mark_locked(mark, connp, obj_type, allow_dups, fsid);
+	ret = fsnotify_add_mark_locked(mark, connp, obj_type, add_flags, fsid);
 	mutex_unlock(&group->mark_mutex);
 	return ret;
 }
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index f0bf557af009..dd440e6ff528 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -211,6 +211,7 @@ struct fsnotify_group {
 	bool shutdown;		/* group is being shut down, don't queue more events */
 
 #define FSNOTIFY_GROUP_USER	0x01 /* user allocated group */
+#define FSNOTIFY_GROUP_DUPS	0x02 /* allow multiple marks per object */
 	int flags;
 
 	/* stores all fastpath marks assoc with this group so they can be cleaned on unregister */
@@ -641,26 +642,26 @@ extern int fsnotify_get_conn_fsid(const struct fsnotify_mark_connector *conn,
 /* attach the mark to the object */
 extern int fsnotify_add_mark(struct fsnotify_mark *mark,
 			     fsnotify_connp_t *connp, unsigned int obj_type,
-			     int allow_dups, __kernel_fsid_t *fsid);
+			     int add_flags, __kernel_fsid_t *fsid);
 extern int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 				    fsnotify_connp_t *connp,
-				    unsigned int obj_type, int allow_dups,
+				    unsigned int obj_type, int add_flags,
 				    __kernel_fsid_t *fsid);
 
 /* attach the mark to the inode */
 static inline int fsnotify_add_inode_mark(struct fsnotify_mark *mark,
 					  struct inode *inode,
-					  int allow_dups)
+					  int add_flags)
 {
 	return fsnotify_add_mark(mark, &inode->i_fsnotify_marks,
-				 FSNOTIFY_OBJ_TYPE_INODE, allow_dups, NULL);
+				 FSNOTIFY_OBJ_TYPE_INODE, add_flags, NULL);
 }
 static inline int fsnotify_add_inode_mark_locked(struct fsnotify_mark *mark,
 						 struct inode *inode,
-						 int allow_dups)
+						 int add_flags)
 {
 	return fsnotify_add_mark_locked(mark, &inode->i_fsnotify_marks,
-					FSNOTIFY_OBJ_TYPE_INODE, allow_dups,
+					FSNOTIFY_OBJ_TYPE_INODE, add_flags,
 					NULL);
 }
 
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 35fe149586c8..6432a37ac1c9 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -100,7 +100,7 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	audit_update_mark(audit_mark, dentry->d_inode);
 	audit_mark->rule = krule;
 
-	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, true);
+	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
 	if (ret < 0) {
 		fsnotify_put_mark(&audit_mark->mark);
 		audit_mark = ERR_PTR(ret);
@@ -182,7 +182,7 @@ static const struct fsnotify_ops audit_mark_fsnotify_ops = {
 static int __init audit_fsnotify_init(void)
 {
 	audit_fsnotify_group = fsnotify_alloc_group(&audit_mark_fsnotify_ops,
-						    0);
+						    FSNOTIFY_GROUP_DUPS);
 	if (IS_ERR(audit_fsnotify_group)) {
 		audit_fsnotify_group = NULL;
 		audit_panic("cannot create audit fsnotify group");
-- 
2.35.1

