Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A6613AD52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 16:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgANPRG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 10:17:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34149 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANPRF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:17:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so12572289wrr.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 07:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H/wb/9PcQcjDLZR1CpEvba/9unOTmGL87G16ihlKy8A=;
        b=iorv8EesgUW61Q/FLsMJnclOEoohxYvP+yAT5SmibWJXuTWG23hfFpIFr7OtOXAl7/
         e1VCE0ieQf6/pIuVVwst2xyFFIxCjNUIr9NrVdmQJsWrqbGG2kBDyDXssjaMcqljrjpm
         ieL9A4L6dncxG2wDCC8zSYIyDCKHi/V0490o+CfwymWrJJ0IkdJ5UjHs6yy5DKmnL+Vx
         0TOA4seBVIv87SQ0vh1UamL0as3kit5MQ1i+XukeKTTDpN9cHBMFeLialB2S5n7pEqPt
         7X/TgR8iYoCLL6M6h4/rwrD1JBXzPBsnLFEbbA48jJiF/cRJgg8LuyRUnqnTOJ3BpXEf
         /zJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H/wb/9PcQcjDLZR1CpEvba/9unOTmGL87G16ihlKy8A=;
        b=nPkCxP2PCkfgq1s8kupUtd8WIKbwlljv1JFA/ou9bTGayWPNiKCwIzag7XI+amJVzs
         B6lRlMxVzButCIL1A4WspNv1ntpadKc8OX8ZtDBmv+7wOTaMxvKCdI1CTj3FxbwJW5C0
         4oD/CSc7Ah0adGDVLN1gFMn9+cucQUzMsCY29KVj8V6qWfPEB9MGFi7S+dmEHMn+w/Gn
         ++aOptaPrYCnasr9vbKkxEsM/fcLTctYzRPK0FyBShLwxiLDsWGIIl0VIc4mxgxOHuGe
         3nqMgkze6QWsbNEzd4wjRdIaMjuntTcErxqthsKrv2hGkVEUMSS23Xl5aiE9N2DRq2s3
         5IRA==
X-Gm-Message-State: APjAAAXOyu3qHi0Xlh2BpLYNt+YdgAflfMHwxn0slpfO4bMOHKEwRyYr
        bkZjbGMi9tw8vaNmd70S8ENCZOx7
X-Google-Smtp-Source: APXvYqyjJgJxl2bsTVyS5mdt+scThmW8zeZMRbydB+YW14YWueny/s/BYOB59gzDbnaC9xCdL0MpJw==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr26041100wrm.241.1579015024288;
        Tue, 14 Jan 2020 07:17:04 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id s19sm18276993wmj.33.2020.01.14.07.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:17:03 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/6] fsnotify: pass dentry instead of inode for events possible on child
Date:   Tue, 14 Jan 2020 17:16:51 +0200
Message-Id: <20200114151655.29473-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114151655.29473-1-amir73il@gmail.com>
References: <20200114151655.29473-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most events that can be reported to watching parent pass
FSNOTIFY_EVENT_PATH as event data, except for FS_ARRTIB and FS_MODIFY
as a result of truncate.

Define a new data type to pass for event - FSNOTIFY_EVENT_DENTRY
and use it to pass the dentry instead of it's ->d_inode for those events.

Add a helper fsnotify_dentry(), similar to fsnotify_path() to report
those events to child and parent.

Soon, we are going to use the dentry data type to report events
with name info in fanotify backend.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c    |  2 ++
 fs/notify/fsnotify.c             |  4 ++--
 include/linux/fsnotify.h         | 16 ++++++++++------
 include/linux/fsnotify_backend.h |  3 ++-
 kernel/audit_fsnotify.c          |  5 ++++-
 kernel/audit_watch.c             |  5 ++++-
 6 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 5778d1347b35..b4cd90afece1 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -271,6 +271,8 @@ static struct inode *fanotify_fid_inode(struct inode *to_tell, u32 event_mask,
 		return to_tell;
 	else if (data_type == FSNOTIFY_EVENT_INODE)
 		return (struct inode *)data;
+	else if (data_type == FSNOTIFY_EVENT_DENTRY)
+		return d_inode(data);
 	else if (data_type == FSNOTIFY_EVENT_PATH)
 		return d_inode(((struct path *)data)->dentry);
 	return NULL;
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 46f225580009..13578372aee8 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -172,8 +172,8 @@ int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask
 			ret = fsnotify(p_inode, mask, path, FSNOTIFY_EVENT_PATH,
 				       &name.name, 0);
 		else
-			ret = fsnotify(p_inode, mask, dentry->d_inode, FSNOTIFY_EVENT_INODE,
-				       &name.name, 0);
+			ret = fsnotify(p_inode, mask, dentry,
+				       FSNOTIFY_EVENT_DENTRY, &name.name, 0);
 		release_dentry_name_snapshot(&name);
 	}
 
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index a2d5d175d3c1..5746420bb121 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -41,9 +41,15 @@ static inline int fsnotify_parent(const struct path *path,
 }
 
 /*
- * Simple wrapper to consolidate calls fsnotify_parent()/fsnotify() when
- * an event is on a path.
+ * Simple wrappers to consolidate calls fsnotify_parent()/fsnotify() when
+ * an event is on a path/dentry.
  */
+static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
+{
+	fsnotify_parent(NULL, dentry, mask);
+	fsnotify(d_inode(dentry), mask, dentry, FSNOTIFY_EVENT_DENTRY, NULL, 0);
+}
+
 static inline int fsnotify_path(struct inode *inode, const struct path *path,
 				__u32 mask)
 {
@@ -301,8 +307,7 @@ static inline void fsnotify_xattr(struct dentry *dentry)
 	if (S_ISDIR(inode->i_mode))
 		mask |= FS_ISDIR;
 
-	fsnotify_parent(NULL, dentry, mask);
-	fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
+	fsnotify_dentry(dentry, mask);
 }
 
 /*
@@ -336,8 +341,7 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
 		if (S_ISDIR(inode->i_mode))
 			mask |= FS_ISDIR;
 
-		fsnotify_parent(NULL, dentry, mask);
-		fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
+		fsnotify_dentry(dentry, mask);
 	}
 }
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index db3cabb4600e..cb47759b1ce9 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -212,10 +212,11 @@ struct fsnotify_group {
 	};
 };
 
-/* when calling fsnotify tell it if the data is a path or inode */
+/* when calling fsnotify tell it if the data is a path or inode or dentry */
 #define FSNOTIFY_EVENT_NONE	0
 #define FSNOTIFY_EVENT_PATH	1
 #define FSNOTIFY_EVENT_INODE	2
+#define FSNOTIFY_EVENT_DENTRY	3
 
 enum fsnotify_obj_type {
 	FSNOTIFY_OBJ_TYPE_INODE,
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index f0d243318452..ec6d00fd11b4 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -168,7 +168,10 @@ static int audit_mark_handle_event(struct fsnotify_group *group,
 
 	switch (data_type) {
 	case (FSNOTIFY_EVENT_PATH):
-		inode = ((const struct path *)data)->dentry->d_inode;
+		inode = d_inode(((const struct path *)data)->dentry);
+		break;
+	case (FSNOTIFY_EVENT_DENTRY):
+		inode = d_inode(data);
 		break;
 	case (FSNOTIFY_EVENT_INODE):
 		inode = (const struct inode *)data;
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 4508d5e0cf69..85e007184677 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -482,7 +482,10 @@ static int audit_watch_handle_event(struct fsnotify_group *group,
 
 	switch (data_type) {
 	case (FSNOTIFY_EVENT_PATH):
-		inode = d_backing_inode(((const struct path *)data)->dentry);
+		inode = d_inode(((const struct path *)data)->dentry);
+		break;
+	case (FSNOTIFY_EVENT_DENTRY):
+		inode = d_inode(data);
 		break;
 	case (FSNOTIFY_EVENT_INODE):
 		inode = (const struct inode *)data;
-- 
2.17.1

