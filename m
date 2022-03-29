Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C284EA8BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiC2HvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 03:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiC2Hu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:50:59 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CFA1E3E05
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h4so23491832wrc.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=opDUpK7X74k71HVH4N+7XyNkXF8O3XUdZUxk0kOEwc8=;
        b=FQG0rr95Pqud/m9Yp/dM7za4jb8DC9FPw7ninm+dDkNxsIUrTAFl5YQLgkxY1yGJF1
         20gRt6V2cuGaR000Jlxv7m6FVZBmhZoQ/+Hh7AdawQypf3KZxmBQma7A/eT+ngDQvT4M
         aUnYO+MeMLLs6jZER+aNxlsfQu3FNH3/pu8WesOsUU4c1HdluJPMBvN80ZOOdMnujqB7
         AEbyr9LbBqDb2z0vM83FLyG1pGFFpjxEwscV2YLOC2JGrZnYeyIJTdtAh+dXOZDFeFQI
         UV9B2Ki3muwVRPNUZZ32PHt+HEQODAecEwUD5KH2MKI9tcRREWUHL8KTryiIYhgKbxBN
         Tm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opDUpK7X74k71HVH4N+7XyNkXF8O3XUdZUxk0kOEwc8=;
        b=oeSRFQj7oHobnMs+9jvxnXteetI/UaeCMx60z86tUWdrGSM0d4uqrypIMfzATOxHTl
         kXf8ym1lrF+l1d+6H8EhHKS7BLyaKep2MjYUi7N/Ds7K1zK/JfInjDR9iFqybbrsYjlg
         htY05wI8fjCBjyp0ZdDZeS/lvSUZmxiFk6GqRTyGiZ2T1jUWiJALK9HfcpNgL6gaD/N/
         T0QWsYUV2lae/sRQ92v4PeWdnHCIaDFEyyHCVHPdRE4Ja/+t2e7SoQz9fz5nzpx18iWs
         miDmVJBviB/DynfFYZwVew1O6/6TCRN6kbm6h9OfB+znJtoRVK5FSxuh0t7wvBCFnd4i
         mlCQ==
X-Gm-Message-State: AOAM531l4vsW3aHpNd114KACr8xGdPMmBpvi67m4BpdcfLoyJA9HIZlu
        Kx6Xp1oZUrQ5ltV6aePMI5Y=
X-Google-Smtp-Source: ABdhPJyij0xpAsZsrhN/l3vaHtSno6UUqgAND/t/L4eH7ZnKrykaYsgEYBYnyW7XsK8sRAwvV3yNog==
X-Received: by 2002:adf:f943:0:b0:203:e832:129 with SMTP id q3-20020adff943000000b00203e8320129mr29300015wrr.626.1648540154653;
        Tue, 29 Mar 2022 00:49:14 -0700 (PDT)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm1534342wms.25.2022.03.29.00.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:14 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 03/16] fsnotify: pass flags argument to fsnotify_add_mark() via mark
Date:   Tue, 29 Mar 2022 10:48:51 +0300
Message-Id: <20220329074904.2980320-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329074904.2980320-1-amir73il@gmail.com>
References: <20220329074904.2980320-1-amir73il@gmail.com>
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
as an argument, define the mark flag FSNOTIFY_MARK_FLAG_ALLOW_DUPS
to express the old allow_dups meaning and pass this information on the
mark itself.

We use mark->flags to pass inotify control flags and will pass more
control flags in the future so let's make this the standard.

Although the FSNOTIFY_MARK_FLAG_ALLOW_DUPS flag is not used after the
call to fsnotify_add_mark(), it does not hurt to leave this information
on the mark for future use.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c |  2 +-
 fs/notify/inotify/inotify_user.c   |  4 ++--
 fs/notify/mark.c                   | 13 ++++++-------
 include/linux/fsnotify_backend.h   | 19 ++++++++++---------
 kernel/audit_fsnotify.c            |  3 ++-
 5 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9b32b76a9c30..0f0db1efa379 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1144,7 +1144,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	}
 
 	fsnotify_init_mark(mark, group);
-	ret = fsnotify_add_mark_locked(mark, connp, obj_type, 0, fsid);
+	ret = fsnotify_add_mark_locked(mark, connp, obj_type, fsid);
 	if (ret) {
 		fsnotify_put_mark(mark);
 		goto out_dec_ucounts;
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index d8907d32a05b..6fc0f598a7aa 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -603,7 +603,6 @@ static int inotify_new_watch(struct fsnotify_group *group,
 
 	fsnotify_init_mark(&tmp_i_mark->fsn_mark, group);
 	tmp_i_mark->fsn_mark.mask = inotify_arg_to_mask(inode, arg);
-	tmp_i_mark->fsn_mark.flags = inotify_arg_to_flags(arg);
 	tmp_i_mark->wd = -1;
 
 	ret = inotify_add_to_idr(idr, idr_lock, tmp_i_mark);
@@ -618,7 +617,8 @@ static int inotify_new_watch(struct fsnotify_group *group,
 	}
 
 	/* we are on the idr, now get on the inode */
-	ret = fsnotify_add_inode_mark_locked(&tmp_i_mark->fsn_mark, inode, 0);
+	ret = fsnotify_add_inode_mark_locked(&tmp_i_mark->fsn_mark, inode,
+					     inotify_arg_to_flags(arg));
 	if (ret) {
 		/* we failed to get on the inode, get off the idr */
 		inotify_remove_from_idr(group, tmp_i_mark);
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 4853184f7dde..b1443e66ba26 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -574,7 +574,7 @@ static struct fsnotify_mark_connector *fsnotify_grab_connector(
 static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 				  fsnotify_connp_t *connp,
 				  unsigned int obj_type,
-				  int allow_dups, __kernel_fsid_t *fsid)
+				  __kernel_fsid_t *fsid)
 {
 	struct fsnotify_mark *lmark, *last = NULL;
 	struct fsnotify_mark_connector *conn;
@@ -633,7 +633,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 
 		if ((lmark->group == mark->group) &&
 		    (lmark->flags & FSNOTIFY_MARK_FLAG_ATTACHED) &&
-		    !allow_dups) {
+		    !(mark->flags & FSNOTIFY_MARK_FLAG_ALLOW_DUPS)) {
 			err = -EEXIST;
 			goto out_err;
 		}
@@ -668,7 +668,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
  */
 int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 			     fsnotify_connp_t *connp, unsigned int obj_type,
-			     int allow_dups, __kernel_fsid_t *fsid)
+			     __kernel_fsid_t *fsid)
 {
 	struct fsnotify_group *group = mark->group;
 	int ret = 0;
@@ -688,7 +688,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	fsnotify_get_mark(mark); /* for g_list */
 	spin_unlock(&mark->lock);
 
-	ret = fsnotify_add_mark_list(mark, connp, obj_type, allow_dups, fsid);
+	ret = fsnotify_add_mark_list(mark, connp, obj_type, fsid);
 	if (ret)
 		goto err;
 
@@ -708,14 +708,13 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 }
 
 int fsnotify_add_mark(struct fsnotify_mark *mark, fsnotify_connp_t *connp,
-		      unsigned int obj_type, int allow_dups,
-		      __kernel_fsid_t *fsid)
+		      unsigned int obj_type, __kernel_fsid_t *fsid)
 {
 	int ret;
 	struct fsnotify_group *group = mark->group;
 
 	mutex_lock(&group->mark_mutex);
-	ret = fsnotify_add_mark_locked(mark, connp, obj_type, allow_dups, fsid);
+	ret = fsnotify_add_mark_locked(mark, connp, obj_type, fsid);
 	mutex_unlock(&group->mark_mutex);
 	return ret;
 }
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 8ecdc1750e67..9e8b5b52b9de 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -476,6 +476,7 @@ struct fsnotify_mark {
 	/* Backend controlled flags */
 #define FSNOTIFY_MARK_FLAG_EXCL_UNLINK		0x0010
 #define FSNOTIFY_MARK_FLAG_IN_ONESHOT		0x0020
+#define FSNOTIFY_MARK_FLAG_ALLOW_DUPS		0x0040
 #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x0100
 	unsigned int flags;		/* flags [mark->lock] */
 };
@@ -633,30 +634,30 @@ extern struct fsnotify_mark *fsnotify_find_mark(fsnotify_connp_t *connp,
 /* Get cached fsid of filesystem containing object */
 extern int fsnotify_get_conn_fsid(const struct fsnotify_mark_connector *conn,
 				  __kernel_fsid_t *fsid);
+
 /* attach the mark to the object */
 extern int fsnotify_add_mark(struct fsnotify_mark *mark,
 			     fsnotify_connp_t *connp, unsigned int obj_type,
-			     int allow_dups, __kernel_fsid_t *fsid);
+			     __kernel_fsid_t *fsid);
 extern int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 				    fsnotify_connp_t *connp,
-				    unsigned int obj_type, int allow_dups,
+				    unsigned int obj_type,
 				    __kernel_fsid_t *fsid);
 
 /* attach the mark to the inode */
 static inline int fsnotify_add_inode_mark(struct fsnotify_mark *mark,
-					  struct inode *inode,
-					  int allow_dups)
+					  struct inode *inode, int flags)
 {
+	mark->flags = flags;
 	return fsnotify_add_mark(mark, &inode->i_fsnotify_marks,
-				 FSNOTIFY_OBJ_TYPE_INODE, allow_dups, NULL);
+				 FSNOTIFY_OBJ_TYPE_INODE, NULL);
 }
 static inline int fsnotify_add_inode_mark_locked(struct fsnotify_mark *mark,
-						 struct inode *inode,
-						 int allow_dups)
+						 struct inode *inode, int flags)
 {
+	mark->flags = flags;
 	return fsnotify_add_mark_locked(mark, &inode->i_fsnotify_marks,
-					FSNOTIFY_OBJ_TYPE_INODE, allow_dups,
-					NULL);
+					FSNOTIFY_OBJ_TYPE_INODE, NULL);
 }
 
 /* given a group and a mark, flag mark to be freed when all references are dropped */
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 02348b48447c..3c35649bc7f5 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -100,7 +100,8 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	audit_update_mark(audit_mark, dentry->d_inode);
 	audit_mark->rule = krule;
 
-	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, true);
+	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode,
+				      FSNOTIFY_MARK_FLAG_ALLOW_DUPS);
 	if (ret < 0) {
 		fsnotify_put_mark(&audit_mark->mark);
 		audit_mark = ERR_PTR(ret);
-- 
2.25.1

