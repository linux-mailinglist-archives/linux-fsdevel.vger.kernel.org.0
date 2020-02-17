Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1BD1612F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgBQNPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46254 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbgBQNPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so19653329wrl.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 05:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kkFQg2HH7gHiyqi5OvCqenDUG/5/Cpl5W50irvXu3Kw=;
        b=gi7x+CnBsWYKqMkLtcOJsFs2KZwtlSKD+/FGYMf4rs9xdka8QPakOv7VmkUFQB26Rg
         vqnWPBEs23xINQe3zb7ec+aykGSX+u+f0a0w/7u2zCknWWkqHIf2x3OBWuGWi56y8N0z
         zEpGfzv7ZT7WgxK2gr6z1U9eWERRwdeg27KKfWKpSqAY7ua88hkyBF/SdGD5JbGJ3QV2
         F2zaJDx2vF3mhXROseV3o1TjZwI3nNR6lKvUe3tR0Uv0lv/2sZ6vywzqdDbxZkSnKPSn
         Upfm5lXPX1CxvOGO8bs7t1SBSubkrN1XaXku1DeYnGBYh3eNgSRuyF+g7HCsoVIXpzly
         WGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kkFQg2HH7gHiyqi5OvCqenDUG/5/Cpl5W50irvXu3Kw=;
        b=FUt4BnL6Oh6GWC7hp5VjKFIMQCHJGLAruIFRqEpL35lp/IskxNapysv7CsNCr4m1Al
         CiGyDy3iQ0p/XcS6jNPqaB8CQZPvo8PRy1fXuYIbk7Hj1d4HzY6aQ6lvrw3WfP2OTc3V
         7vzN7eXIZvb3MP2XY6r9W0cXsXNtMBrkmm186AuMD9Gaj+jYFIyaj5kSeuFt3d669Hwh
         y/vMvN2D2PWLRSWcCdhui8XATmJnBhwCFM/NrMl6twB3WOn8VrnmHxsnSSaAaARgCmEW
         aCTyttRfImZBQAnmVo8SrvNHUdMqmukgd7VYB5QHPGCoIGJSfky7TaPFobypURjrfD/V
         AxAg==
X-Gm-Message-State: APjAAAWD9LuOhfLyBK9JHUVmGUsJvwUE4Mnd5/zHfarF1uM9GFINrAaF
        hcUaSbDQPgsy6AS6b8Fxbs8=
X-Google-Smtp-Source: APXvYqzUVf7CxxAlEPlZGfdUpf5aoYQP4TiTEMCZSSGY+IuDSi1sAnmlVXK5sVqkl9wIprsFKKVVBQ==
X-Received: by 2002:adf:ed0c:: with SMTP id a12mr22158227wro.368.1581945314283;
        Mon, 17 Feb 2020 05:15:14 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m21sm545745wmi.27.2020.02.17.05.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:15:13 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 06/16] fsnotify: pass dentry instead of inode for events possible on child
Date:   Mon, 17 Feb 2020 15:14:45 +0200
Message-Id: <20200217131455.31107-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217131455.31107-1-amir73il@gmail.com>
References: <20200217131455.31107-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most events that can be reported to watching parent pass
FSNOTIFY_EVENT_PATH as event data, except for FS_ARRTIB and FS_MODIFY
as a result of truncate.

Define a new data type to pass for event - FSNOTIFY_EVENT_DENTRY
and use it to pass the dentry instead of it's ->d_inode for those events.

Soon, we are going to use the dentry data type to report events
with name info in fanotify backend.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h         |  4 ++--
 include/linux/fsnotify_backend.h | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index af30e0a56f2e..7ba40c19bc7e 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -49,8 +49,8 @@ static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
 	if (S_ISDIR(inode->i_mode))
 		mask |= FS_ISDIR;
 
-	fsnotify_parent(dentry, mask, inode, FSNOTIFY_EVENT_INODE);
-	fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
+	fsnotify_parent(dentry, mask, dentry, FSNOTIFY_EVENT_DENTRY);
+	fsnotify(inode, mask, dentry, FSNOTIFY_EVENT_DENTRY, NULL, 0);
 }
 
 static inline int fsnotify_file(struct file *file, __u32 mask)
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index b1f418cc28e1..bd3f6114a7a9 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -217,6 +217,7 @@ enum fsnotify_data_type {
 	FSNOTIFY_EVENT_NONE,
 	FSNOTIFY_EVENT_PATH,
 	FSNOTIFY_EVENT_INODE,
+	FSNOTIFY_EVENT_DENTRY,
 };
 
 static inline const struct inode *fsnotify_data_inode(const void *data,
@@ -225,6 +226,8 @@ static inline const struct inode *fsnotify_data_inode(const void *data,
 	switch (data_type) {
 	case FSNOTIFY_EVENT_INODE:
 		return data;
+	case FSNOTIFY_EVENT_DENTRY:
+		return d_inode(data);
 	case FSNOTIFY_EVENT_PATH:
 		return d_inode(((const struct path *)data)->dentry);
 	default:
@@ -232,6 +235,20 @@ static inline const struct inode *fsnotify_data_inode(const void *data,
 	}
 }
 
+static inline struct dentry *fsnotify_data_dentry(const void *data,
+						  int data_type)
+{
+	switch (data_type) {
+	case FSNOTIFY_EVENT_DENTRY:
+		/* Non const is needed for dget() */
+		return (struct dentry *)data;
+	case FSNOTIFY_EVENT_PATH:
+		return ((const struct path *)data)->dentry;
+	default:
+		return NULL;
+	}
+}
+
 static inline const struct path *fsnotify_data_path(const void *data,
 						    int data_type)
 {
-- 
2.17.1

