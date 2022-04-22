Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1309150B6C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447267AbiDVMHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447288AbiDVMHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF63056758
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u15so15896097ejf.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXs35vihM88XJ2kkE3QaoH5UldyApMgkiHQew6I8P28=;
        b=PIj7AjpvgC52cIE2KFp2MCRg7MGXWkZ+bCDbyb/uo/mcUPSiGjGynYuYk/RgH8iOZ7
         0MvZ/erYEAm4APD1U4VAmy8omumDHRriQgjnun22AiWaSq5gMjH+Qhpl22PZ8ItJEEzy
         /vUVMLNjfrzTqZ20jhAUryVzHc3giRbG9DuUBnxtnQ7gJkXjjNBYdLKvVQtXmxEyJG48
         VeFD89dKng6fvypHpoDBpj6dB/m42yrl2cS0P8arLy0bF0lppf1rDRKKhcXpP2OPP2ub
         NLMRr4bLnPT7cLUWQZM/ekLnnTMcZ/L+1q1C+ZkEuSP1gFEtixAGsYhYD5ZY+58sL8qz
         UTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXs35vihM88XJ2kkE3QaoH5UldyApMgkiHQew6I8P28=;
        b=aRcQbtEZdx0oDSo+9bLBPa4ptx+bKdxQmo7W7FghXdQ671zeGn/GU5Te+lszKZ3813
         z+GRyvC6+yvDlW/uf9OfPDmAwXvXhcCf4Jm8YxQy3UKjkIe3F+RxMsJB8NtFHmUdjcYG
         JS5eXDJazeTdTgeryfEJltlgQLoo0cN6tTStvJss5sdqhIJCdij+6DNq8X3w+5AlmeYV
         iom+EKtQ7M5Hp7Nlwb7nEk3Cnz/89/C3pzryfJsZTAfCcFJx+rvJYFqM57LuIrvv04KO
         n5j5eShTSjho0zu+b8q50ReekzCDsF/6Z4ZIu6YSxUufDOdXwZF2psoGNAPkCh0YYlpz
         eRKg==
X-Gm-Message-State: AOAM533l1HeFcwSbzoKIwnmE1VKffUeTMf/1WibfyKJZvfE39I/SOFkh
        vGZLQcrxHkCsZcAhUqkgouk=
X-Google-Smtp-Source: ABdhPJwHYl+soG9iOTl5eM07X3E9rHVESqJALsXCVN/oirE1FxJip9eT0S0QAr2D5p/b45f8DibTiA==
X-Received: by 2002:a17:907:8a0d:b0:6ef:e43e:f08f with SMTP id sc13-20020a1709078a0d00b006efe43ef08fmr3825019ejc.733.1650629012236;
        Fri, 22 Apr 2022 05:03:32 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm697026ejv.43.2022.04.22.05.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:31 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 01/16] inotify: show inotify mask flags in proc fdinfo
Date:   Fri, 22 Apr 2022 15:03:12 +0300
Message-Id: <20220422120327.3459282-2-amir73il@gmail.com>
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

