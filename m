Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F9B4FF306
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiDMJMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiDMJMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAD21CFE2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q3so1010090wrj.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXs35vihM88XJ2kkE3QaoH5UldyApMgkiHQew6I8P28=;
        b=mDn1Nl4Fp9bEq5ORyeDomf51yk7opH7Jq7v+Odj7mhZ3QbdtSwJP9L+M1VMWk4Pzs/
         K21QDeellslBgquSW8nxeRefOMCwKfu5mxUKVVwLnZtr3FaQse1rm5yA9O4A8ZW1gfYd
         53B6qRrrDJU0j+1gWMVsrMQj2oBNPXitqa4VcuMyLnNcg/KsE+IN0549K7SgF/S9nVKy
         RaneE5ZMuEzMBZw7taBgsHR4oy0iNpzFHUFxeUbKj98mZtn2ES3xjINegh16Q4NLZZUk
         Wy/8/j8dHQ+uMPBKsylKPydXWuSpK8F3Yd0zWfpLoa/4QQGjTvzpCSxKbHSH0Bns40i9
         kp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXs35vihM88XJ2kkE3QaoH5UldyApMgkiHQew6I8P28=;
        b=febM8eNx4i8jMUX2wPwwPqeUE3mSy+RAcBKeojgYzsLn/GmNjAfyuUBnWIffAzBHWr
         jPg1/MFB8921iXun70672/sZV7kSNW3KmbzkD35c+4KCrFVzEVxzpEKhxP7Ngyn3wnGN
         n9mE0N5Y+xm/y3oHTp0T3eR5Kd/sEBd+w1k6vQEJms/1D65wm3BH7EzTDhry/L7GEkd8
         nuPI/kasxlAHDcezMntR4BhQkf671gPsBSy+ylSGA4QsEL7WIJ9LXkcMEDIeHcRpyuEg
         nAs2yYfh5qrnfsjv9eeWzcJarMM7aEBLcdw1T7AGNDGHzR2+WnxiP3cedi9g5Xe2sEz8
         8Yqw==
X-Gm-Message-State: AOAM53117RRhPsV9j0edi74e8WXaw5Em/UYw1sRbSE9nsPXZzjZ2cBUb
        f0ho4AWNFfVxiOjvGGcqq7s=
X-Google-Smtp-Source: ABdhPJy+6/a8/RpOxJRC4tc+N5Xl7SZmIRFSrz8bU2sz1vtSQ2x1LpCg+keFefuB8W1ZQJBqhSB5Sg==
X-Received: by 2002:adf:f44d:0:b0:207:b33f:ea7b with SMTP id f13-20020adff44d000000b00207b33fea7bmr3422904wrp.628.1649840979509;
        Wed, 13 Apr 2022 02:09:39 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:39 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 01/16] inotify: show inotify mask flags in proc fdinfo
Date:   Wed, 13 Apr 2022 12:09:20 +0300
Message-Id: <20220413090935.3127107-2-amir73il@gmail.com>
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

The inotify mask flags IN_ONESHOT and IN_EXCL_UNLINK are not "internal
to kernel" and should be exposed in procfs fdinfo so CRIU can restore
them.

Fixes: 6933599697c9 ("inotify: hide internal kernel bits from fdinfo")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fdinfo.c               | 11 ++---------
 fs/notify/inotify/inotify.h      | 12 ++++++++++++
 fs/notify/inotify/inotify_user.c |  2 +-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 57f0d5d9f934..3451708fd035 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -83,16 +83,9 @@ static void inotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 	inode_mark = container_of(mark, struct inotify_inode_mark, fsn_mark);
 	inode = igrab(fsnotify_conn_inode(mark->connector));
 	if (inode) {
-		/*
-		 * IN_ALL_EVENTS represents all of the mask bits
-		 * that we expose to userspace.  There is at
-		 * least one bit (FS_EVENT_ON_CHILD) which is
-		 * used only internally to the kernel.
-		 */
-		u32 mask = mark->mask & IN_ALL_EVENTS;
-		seq_printf(m, "inotify wd:%x ino:%lx sdev:%x mask:%x ignored_mask:%x ",
+		seq_printf(m, "inotify wd:%x ino:%lx sdev:%x mask:%x ignored_mask:0 ",
 			   inode_mark->wd, inode->i_ino, inode->i_sb->s_dev,
-			   mask, mark->ignored_mask);
+			   inotify_mark_user_mask(mark));
 		show_mark_fhandle(m, inode);
 		seq_putc(m, '\n');
 		iput(inode);
diff --git a/fs/notify/inotify/inotify.h b/fs/notify/inotify/inotify.h
index 2007e3711916..8f00151eb731 100644
--- a/fs/notify/inotify/inotify.h
+++ b/fs/notify/inotify/inotify.h
@@ -22,6 +22,18 @@ static inline struct inotify_event_info *INOTIFY_E(struct fsnotify_event *fse)
 	return container_of(fse, struct inotify_event_info, fse);
 }
 
+/*
+ * INOTIFY_USER_FLAGS represents all of the mask bits that we expose to
+ * userspace.  There is at least one bit (FS_EVENT_ON_CHILD) which is
+ * used only internally to the kernel.
+ */
+#define INOTIFY_USER_MASK (IN_ALL_EVENTS | IN_ONESHOT | IN_EXCL_UNLINK)
+
+static inline __u32 inotify_mark_user_mask(struct fsnotify_mark *fsn_mark)
+{
+	return fsn_mark->mask & INOTIFY_USER_MASK;
+}
+
 extern void inotify_ignored_and_remove_idr(struct fsnotify_mark *fsn_mark,
 					   struct fsnotify_group *group);
 extern int inotify_handle_inode_event(struct fsnotify_mark *inode_mark,
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 54583f62dc44..3ef57db0ec9d 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -110,7 +110,7 @@ static inline __u32 inotify_arg_to_mask(struct inode *inode, u32 arg)
 		mask |= FS_EVENT_ON_CHILD;
 
 	/* mask off the flags used to open the fd */
-	mask |= (arg & (IN_ALL_EVENTS | IN_ONESHOT | IN_EXCL_UNLINK));
+	mask |= (arg & INOTIFY_USER_MASK);
 
 	return mask;
 }
-- 
2.35.1

