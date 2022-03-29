Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F8C4EA8BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 09:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiC2Hu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 03:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiC2Hu4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:50:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C641E3190
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j18so23497098wrd.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RBBWODAqEE7f4cxeskCr956agfYsRrTCYelOP6RPfNg=;
        b=XDoXF5QPqTqa6WYvAEi10KDUsjnBc48c9kSuHSH2XE4tFD54Xb1diKHgLCUiABuGWs
         jKL4cYqjlFmskpmLEfXYcHPDl+2qIMXhvwlHGI+KifxtXJlST8HijRH4KkaEv+2mv6/b
         +n2GvIZmO8/Y+sekwQBrp8uoiiUW8QR/aGZ70IupQt//sRgMEX1eswVBV+Nagsc2/Ss2
         HRs+LPkbZBooSZbHJmYfT0pJll60y0FTornoRUbf3wT08VOadW62ogZQEBnbx1ki03PH
         a4K9tInLPXtRnLDinwZIqrl0YRbkID+rYvzi0hCYZnX+2grvKicIu3QAfpPrdtKkE8z/
         kpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RBBWODAqEE7f4cxeskCr956agfYsRrTCYelOP6RPfNg=;
        b=UqlKwjYvWsfEr+Xcr8K9CkM0Z/1qbitxf0gSlpC0c3MFbFb6z9KxJaIpvEjjVQNdg5
         y0mJHqE0dkMk9pAPoRasn2JQqF5DlKnQVEjnF9ByGY1oIgdCjd4sVWu9iuqVKr0qro1W
         zcMKvRLeHmqFHITBm/jlIhBeS492Vajqf+rMFLtqrxLBEWYaSGSp8q93Hitc6tRs0/Ne
         JmQAQISMFI6Fk2h6e4E5M1OW/byWpxh9dFMP0qnzRDEOv05x3ylQOloHFT5qfqw1o70Q
         kWM/Y/P8gKuooU+g+QdCLTctChWd2QnT3A5TzibFE8pUbyqLcn6EV89g5aNrm7zuC/9i
         idyg==
X-Gm-Message-State: AOAM532dbY/AlyTSvIJotowf4oGG59T4ANoh3AJircVVaYLU8gKn9w/q
        8ND4KEHAr+FE8VtOrqGeEbEjWE6IxeM=
X-Google-Smtp-Source: ABdhPJyIvmYSZTJa+6Dz2je3JaLuuHXQhmuF0F4kYU1E2UES3FcCltx8QDaEOOlcY1xnTiCvshf5gA==
X-Received: by 2002:a5d:4381:0:b0:205:cb7d:f315 with SMTP id i1-20020a5d4381000000b00205cb7df315mr7484579wrq.338.1648540152008;
        Tue, 29 Mar 2022 00:49:12 -0700 (PDT)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm1534342wms.25.2022.03.29.00.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:11 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 01/16] inotify: show inotify mask flags in proc fdinfo
Date:   Tue, 29 Mar 2022 10:48:49 +0300
Message-Id: <20220329074904.2980320-2-amir73il@gmail.com>
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
2.25.1

