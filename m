Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104BC4D038D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 16:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243948AbiCGP7D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 10:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiCGP67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:58:59 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854F93137D
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Mar 2022 07:58:03 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r65so9482952wma.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Mar 2022 07:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CjXRp1bdXZQL0cITkY0adRmoRgN6m5tRA5jHYrqnWvw=;
        b=cTpFz0OJmsR0jJIAYqPxk0aPmjBDgVkFjdvYJY5/1rZgvJC/MQt7K86isw8O8M2OSz
         pVYfAiS1EmwZZ+hoplFRfjxcRQQh/mDgpd9SH84Aip/dzXgOjj5dosSmLYh7SudYFnhr
         ni6okfwHdEHeXDMhFquAR/YWM6YDgrz03j1RmRrGzzm6YO09ANns2XwZCxMs6bfmTYYn
         ha23oU3f1/9jo//zYkZhZj3j+JZikb6ehY1ZRDKVMiR+1DBH8OAqDHbDh0p2iewoDjoM
         xm0r+Er0fx8a6FxTTHNX3ElZ8UG4m0kv5XL/GK5xekZrQIKzWl+UAhVgFsx26V26IDhq
         gG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CjXRp1bdXZQL0cITkY0adRmoRgN6m5tRA5jHYrqnWvw=;
        b=Z2pkrkY4ZZZFFKo4leCqDKsm3Ov/SCxPiI+Qf0Xh2BcPob0A7GLuwvX668tPxFhIC0
         55RxqzHPzQFTSNItu/t5Dw050JYX8DJWoaLQxblNOdSrVhNN9+yJFBnNN80GF3psQplK
         Aa87YkfhGKwHfouN2pXRV3LXwi+VgIth/yuE4OhTzR8fxc4GTYHuZ6RpCmXLeQVlTaIZ
         PgMAytS3GQRGKsopricsYZz/mih3LM74Q15tqwGmAlOFmrkqR5tM0TygsYeJ6KYoj7ZQ
         +QFSXNM3NaAxaNVFj6ZwqdKMrqp6RqQjXG85gPNU/KgkcMKA9TcvQ5lGOnJsTyN13OGc
         SHsg==
X-Gm-Message-State: AOAM532yUJxB5P+0O4m8qHzAO2yNFyfuTNlF1IyIHtx7jtAUhzwPyTis
        oRE8srgJwcUTC+y+h/sHHjY=
X-Google-Smtp-Source: ABdhPJy2Wyzi4G/URB5OKS0TD7RYdhx6yxQUXyE4n5Gx0khSleRgcDnEAqOEOhnyX8LLd9V3OQ4zNw==
X-Received: by 2002:a1c:ed0e:0:b0:380:fa8c:da99 with SMTP id l14-20020a1ced0e000000b00380fa8cda99mr9658023wmh.135.1646668682051;
        Mon, 07 Mar 2022 07:58:02 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm11686591wrv.79.2022.03.07.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:58:01 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] fsnotify: pass flags argument to fsnotify_add_mark()
Date:   Mon,  7 Mar 2022 17:57:38 +0200
Message-Id: <20220307155741.1352405-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307155741.1352405-1-amir73il@gmail.com>
References: <20220307155741.1352405-1-amir73il@gmail.com>
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

Instead of passing the allow_dups argument to fsnotify_add_mark()
as a 'boolean' int, pass a generic flags argument and define the flag
FSNOTIFY_ADD_MARK_ALLOW_DUPS to express the old allow_dups meaning.

We are going to use the flags argument to pass more options to
to fsnotify_add_mark().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/mark.c                 | 13 ++++++-------
 include/linux/fsnotify_backend.h | 18 +++++++++---------
 kernel/audit_fsnotify.c          |  3 ++-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 4853184f7dde..190df435919f 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -574,7 +574,7 @@ static struct fsnotify_mark_connector *fsnotify_grab_connector(
 static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 				  fsnotify_connp_t *connp,
 				  unsigned int obj_type,
-				  int allow_dups, __kernel_fsid_t *fsid)
+				  int flags, __kernel_fsid_t *fsid)
 {
 	struct fsnotify_mark *lmark, *last = NULL;
 	struct fsnotify_mark_connector *conn;
@@ -633,7 +633,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 
 		if ((lmark->group == mark->group) &&
 		    (lmark->flags & FSNOTIFY_MARK_FLAG_ATTACHED) &&
-		    !allow_dups) {
+		    !(flags & FSNOTIFY_ADD_MARK_ALLOW_DUPS)) {
 			err = -EEXIST;
 			goto out_err;
 		}
@@ -668,7 +668,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
  */
 int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 			     fsnotify_connp_t *connp, unsigned int obj_type,
-			     int allow_dups, __kernel_fsid_t *fsid)
+			     int flags, __kernel_fsid_t *fsid)
 {
 	struct fsnotify_group *group = mark->group;
 	int ret = 0;
@@ -688,7 +688,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	fsnotify_get_mark(mark); /* for g_list */
 	spin_unlock(&mark->lock);
 
-	ret = fsnotify_add_mark_list(mark, connp, obj_type, allow_dups, fsid);
+	ret = fsnotify_add_mark_list(mark, connp, obj_type, flags, fsid);
 	if (ret)
 		goto err;
 
@@ -708,14 +708,13 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 }
 
 int fsnotify_add_mark(struct fsnotify_mark *mark, fsnotify_connp_t *connp,
-		      unsigned int obj_type, int allow_dups,
-		      __kernel_fsid_t *fsid)
+		      unsigned int obj_type, int flags, __kernel_fsid_t *fsid)
 {
 	int ret;
 	struct fsnotify_group *group = mark->group;
 
 	mutex_lock(&group->mark_mutex);
-	ret = fsnotify_add_mark_locked(mark, connp, obj_type, allow_dups, fsid);
+	ret = fsnotify_add_mark_locked(mark, connp, obj_type, flags, fsid);
 	mutex_unlock(&group->mark_mutex);
 	return ret;
 }
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 0bd63608e935..0b548518b166 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -633,30 +633,30 @@ extern struct fsnotify_mark *fsnotify_find_mark(fsnotify_connp_t *connp,
 /* Get cached fsid of filesystem containing object */
 extern int fsnotify_get_conn_fsid(const struct fsnotify_mark_connector *conn,
 				  __kernel_fsid_t *fsid);
+
 /* attach the mark to the object */
+#define FSNOTIFY_ADD_MARK_ALLOW_DUPS	0x1
+
 extern int fsnotify_add_mark(struct fsnotify_mark *mark,
 			     fsnotify_connp_t *connp, unsigned int obj_type,
-			     int allow_dups, __kernel_fsid_t *fsid);
+			     int flags, __kernel_fsid_t *fsid);
 extern int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 				    fsnotify_connp_t *connp,
-				    unsigned int obj_type, int allow_dups,
+				    unsigned int obj_type, int flags,
 				    __kernel_fsid_t *fsid);
 
 /* attach the mark to the inode */
 static inline int fsnotify_add_inode_mark(struct fsnotify_mark *mark,
-					  struct inode *inode,
-					  int allow_dups)
+					  struct inode *inode, int flags)
 {
 	return fsnotify_add_mark(mark, &inode->i_fsnotify_marks,
-				 FSNOTIFY_OBJ_TYPE_INODE, allow_dups, NULL);
+				 FSNOTIFY_OBJ_TYPE_INODE, flags, NULL);
 }
 static inline int fsnotify_add_inode_mark_locked(struct fsnotify_mark *mark,
-						 struct inode *inode,
-						 int allow_dups)
+						 struct inode *inode, int flags)
 {
 	return fsnotify_add_mark_locked(mark, &inode->i_fsnotify_marks,
-					FSNOTIFY_OBJ_TYPE_INODE, allow_dups,
-					NULL);
+					FSNOTIFY_OBJ_TYPE_INODE, flags, NULL);
 }
 
 /* given a group and a mark, flag mark to be freed when all references are dropped */
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 02348b48447c..82233f651c62 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -100,7 +100,8 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	audit_update_mark(audit_mark, dentry->d_inode);
 	audit_mark->rule = krule;
 
-	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, true);
+	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode,
+				      FSNOTIFY_ADD_MARK_ALLOW_DUPS);
 	if (ret < 0) {
 		fsnotify_put_mark(&audit_mark->mark);
 		audit_mark = ERR_PTR(ret);
-- 
2.25.1

