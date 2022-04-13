Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9F14FF312
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiDMJMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbiDMJMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EA61EC63
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t1so1654504wra.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eps8yFsEpxS8bu8r3iUtycLYs0pOhOSbpDv2fHjkFlI=;
        b=LdffZ9sX73iEbZcStazRQnNVmkfje0HqnBOsCf9IkHC1mfyDlEXqWVl0OBt3+1bHWZ
         D+1mQ5ZrOg34D/4lbrkCo3QCQis9VC8cNhPUHtpqmEFgWABYjYl265bkZf8a3/7yzt35
         6BUmHklBKr56bQwhUAPvXGyYsr2GI1Z1wH0Zn0kjOCJKuwPuemX6qvDK9JZrhu6/lTPL
         l/4neAlEZ/cJL3vTwqeru4cfYLY81e/AuaM7moWL682ypdreayu9jLgt05AY+06AqV5n
         6nntNRB0OICLuy5wLi7lXHAhg+aaYeBnpt5/nRnTu2nGDNHTg2uMx+X9UYWGtF0qozyC
         ELWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eps8yFsEpxS8bu8r3iUtycLYs0pOhOSbpDv2fHjkFlI=;
        b=mFx9qJevuAQtlfvV5Eeg471Rhq8tbuISh75kps0Kz5h+Q5DxiWQVy48HHSfoNhML2k
         clmbwlizum2bRVLses9B8EQRNfBzZGQyqwn1J0aTioIHybmuYbxZVitGyI1KYamhqPLw
         Un64FrU4ZYgXZmtgiIgWkxxM1IiBalr4jAg635WdZrzgtwZnnIzRFrIDzAIB8fnP7TFD
         4DY2SmCGfUyPry+hzEKbSXzb1opf48wZ77uSUZj3Zlw30hL1auVblxb9JO+sJcCzctV6
         4tLI1pTWNW5Nm9v0mtwmjEvJcV1LNau1vHHbU5cOw0K3iZdzSkOnlwybkVZDHySefOIq
         IjdA==
X-Gm-Message-State: AOAM531W69bWV/x3UL9hOcpqkg0TxMX4Rp2BpS0DXI5HkWTkwO8aGOoi
        O+5xHcrh23EdyQd1MqFZG8Y=
X-Google-Smtp-Source: ABdhPJyQdf/fvYgjkuq6d67c/TOCmo5xVSBjDhMSF1IKWj7FC2hNH2xRFfs0dMb6uZR9gOYxDZ0Tbg==
X-Received: by 2002:a05:6000:1842:b0:207:9b57:6bbf with SMTP id c2-20020a056000184200b002079b576bbfmr17130352wri.336.1649840983554;
        Wed, 13 Apr 2022 02:09:43 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:43 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 04/16] fsnotify: pass flags argument to fsnotify_add_mark() via mark
Date:   Wed, 13 Apr 2022 12:09:23 +0300
Message-Id: <20220413090935.3127107-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413090935.3127107-1-amir73il@gmail.com>
References: <20220413090935.3127107-1-amir73il@gmail.com>
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
index c86982be2d50..ea8f557881b1 100644
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
index b1c72edd9784..2ff686882303 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -473,6 +473,7 @@ struct fsnotify_mark {
 	/* General fsnotify mark flags */
 #define FSNOTIFY_MARK_FLAG_ALIVE		0x0001
 #define FSNOTIFY_MARK_FLAG_ATTACHED		0x0002
+#define FSNOTIFY_MARK_FLAG_ALLOW_DUPS		0x0004
 	/* inotify mark flags */
 #define FSNOTIFY_MARK_FLAG_EXCL_UNLINK		0x0010
 #define FSNOTIFY_MARK_FLAG_IN_ONESHOT		0x0020
@@ -634,30 +635,30 @@ extern struct fsnotify_mark *fsnotify_find_mark(fsnotify_connp_t *connp,
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
2.35.1

