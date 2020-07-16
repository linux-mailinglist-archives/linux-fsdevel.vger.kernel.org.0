Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607E7221EB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgGPIm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgGPImx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:42:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9D2C08C5DB
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so6060079wrj.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QGqAhMrMuoujNT2ORyROwugO3M+lp0SIzz7RA0iePck=;
        b=nLhawUtgFbqiZMYsbbM1NINnP0eFsdyiVYysudTEhGS+g5WI2/dBumw0flt7De+TYI
         6CWJ2sydHB3yWuSyTbJAUdyljMo3ClE8innHNQAo7LDXrKmawDGPeN463CvuJqA2FAnc
         UWnVEDtV2GIXApobF+yzsK+585FYDe/qxrGwE+hkQRRKrpUcsX7ynUoZH0PybXInBLDh
         27Xy3Gtv/3ROHS9M56mzZIK/rI5A4VIfJwWJ+J2c/816WlgL+S/J4+3+zIyv41kBM2JT
         pkLDnrLFuFC45yq45sJu4DllL7u+dfP+SQwubXbRT+1PEv29hWFEfJKdXGyhZqeIoA/H
         UaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QGqAhMrMuoujNT2ORyROwugO3M+lp0SIzz7RA0iePck=;
        b=eXc5vKbLM5fsAzrCGSnZIZvWcyVlY6aa/PhD924M7fP8ez9NgtlWPggKaxMeHt8WFw
         DJpASe+epP6Lh/IqISBbXqtdX4+cYvwLs+SW4WklqQPMQJNOJAz2L0ebwzGk3VL5DgeR
         KQUmSe+qkiF9iARJOIT85EwK1S/bo76tEk7ZAZV3CnXyN2scajd6hIvar4s1h6us96LM
         8MiwT6nJE2gI9n1iR4xx/1iLtr9haNiQQVA+Z6upLf0g0POUFLIprhZdicYB7T0avIfr
         F0ORGho3TUhi6/bsfj5mvCstVCXcJQIcVN7mEikuzILTNF0NAybDodZHoN66B3VN6vKk
         5BOg==
X-Gm-Message-State: AOAM5326moRjlMlVK+984+Fni0ESZl+ADlgTmJ/8kYJaTEKnYmj49bNb
        wTRDdKiMakjsU2hbS0GEwasXuDRU
X-Google-Smtp-Source: ABdhPJzhR4F8zJLsXUlNjpZKHNS6QbEcftOdpVQvozBMtma05szazu+qLbuP/vmnJP3CakCNwQFGgQ==
X-Received: by 2002:adf:f74f:: with SMTP id z15mr3759455wrp.233.1594888971908;
        Thu, 16 Jul 2020 01:42:51 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:51 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 11/22] dnotify: report both events on parent and child with single callback
Date:   Thu, 16 Jul 2020 11:42:19 +0300
Message-Id: <20200716084230.30611-12-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For some events (e.g. DN_ATTRIB on sub-directory) fsnotify may call
dnotify_handle_event() once for watching parent and once again for
the watching sub-directory.

Do the same thing with a single callback instead of two callbacks when
marks iterator contains both inode and child entries.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/dnotify/dnotify.c | 42 +++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 608c3e70e81f..305e5559560a 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -70,26 +70,15 @@ static void dnotify_recalc_inode_mask(struct fsnotify_mark *fsn_mark)
  * destroy the dnotify struct if it was not registered to receive multiple
  * events.
  */
-static int dnotify_handle_event(struct fsnotify_group *group, u32 mask,
-				const void *data, int data_type,
-				struct inode *dir,
-				const struct qstr *file_name, u32 cookie,
-				struct fsnotify_iter_info *iter_info)
+static void dnotify_one_event(struct fsnotify_group *group, u32 mask,
+			      struct fsnotify_mark *inode_mark)
 {
-	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
 	struct dnotify_mark *dn_mark;
 	struct dnotify_struct *dn;
 	struct dnotify_struct **prev;
 	struct fown_struct *fown;
 	__u32 test_mask = mask & ~FS_EVENT_ON_CHILD;
 
-	/* not a dir, dnotify doesn't care */
-	if (!dir)
-		return 0;
-
-	if (WARN_ON(fsnotify_iter_vfsmount_mark(iter_info)))
-		return 0;
-
 	dn_mark = container_of(inode_mark, struct dnotify_mark, fsn_mark);
 
 	spin_lock(&inode_mark->lock);
@@ -111,6 +100,33 @@ static int dnotify_handle_event(struct fsnotify_group *group, u32 mask,
 	}
 
 	spin_unlock(&inode_mark->lock);
+}
+
+static int dnotify_handle_event(struct fsnotify_group *group, u32 mask,
+				const void *data, int data_type,
+				struct inode *dir,
+				const struct qstr *file_name, u32 cookie,
+				struct fsnotify_iter_info *iter_info)
+{
+	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
+	struct fsnotify_mark *child_mark = fsnotify_iter_child_mark(iter_info);
+
+	/* not a dir, dnotify doesn't care */
+	if (!dir)
+		return 0;
+
+	if (WARN_ON(fsnotify_iter_vfsmount_mark(iter_info)))
+		return 0;
+
+	/*
+	 * Some events can be sent on both parent dir and subdir marks
+	 * (e.g. DN_ATTRIB).  If both parent dir and subdir are watching,
+	 * report the event once to parent dir and once to subdir.
+	 */
+	if (inode_mark)
+		dnotify_one_event(group, mask, inode_mark);
+	if (child_mark)
+		dnotify_one_event(group, mask, child_mark);
 
 	return 0;
 }
-- 
2.17.1

