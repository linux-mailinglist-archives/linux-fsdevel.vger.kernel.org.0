Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1B8113AD55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 16:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgANPRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 10:17:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38738 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbgANPRI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:17:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id u2so14143848wmc.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 07:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZT7fyZWv4Z8PX0V/HxqGVFS1bFMgoku/EGZ6kI9ggq8=;
        b=kViKAOA7Pb1bMjJ+IOv7KsWsCKY3uc+YhG9IcbRh6GFRSFimPCGRQtqO07ewcm812L
         qvRZ6ox9Sgt+gQxKEjnBZwjftX19jDpN/UMjVj/I43jiQAMBGGrT2Wys3L7V7hNuHyjb
         PIg9HvTORRIw3heuFEOXbF0XELZ2p6MiBZ2zwNiOzZBOpSzC6PehxG4UZxwGFmIIPjFr
         IWo4ObdVWo8RKM+pBFu48Zc4hZDB7p60AEnsdVxRJUq/yP07d7KV7kS45CnSJKMuGEbP
         kjpd+MH+QC+USpvzmbOWuvMHxFC4iQq9pPoBQlriBz2rdyEDlAdKBeDEjnDSSawqijeW
         ziSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZT7fyZWv4Z8PX0V/HxqGVFS1bFMgoku/EGZ6kI9ggq8=;
        b=aAN8LFB6+FUkazmjTcrZ1RGK+xPzbDht5Cbr93DkezlCIFaeyLeXkfpFfadGdciW0U
         t1+BUeV9nsjS5QYoTiZiN24OoikFe5RQ3RAPDrR7h4zFN5LMFXGmy6Ldp1gL/tCXEd7j
         hzRlrddNivjrRI9fKo5kn4PvYmN3tdoMvp1bhoqzFASgkC/JwefiipTQBm+oqaWV6Z9Z
         Gl024q8ywS6O6m9j44Cie7FqykL1UeFAxAFRNQMNPv18bk3fXAV8jBTOQkB22VwAAoyc
         aDqE7maRNeqadqatSooEodeJvoAnH8DYCRWP6zg518DQt6zP4idu6SmWF4de4t0hLfNt
         IPHg==
X-Gm-Message-State: APjAAAUkPMJOhJJvMTpRfi0w8/PdmBJl1aCUHhAypMiRmnqhShEqcKbs
        Rx2EhQK/8gtkEcbXAYHuulYHPo/G
X-Google-Smtp-Source: APXvYqzLuQpIeuT/eEat/mO22kYdxUXL482t5HPMSPsidhRHztzdI4N2h2Xs3vup01cm8/ZgB8EPVA==
X-Received: by 2002:a7b:cf26:: with SMTP id m6mr26047196wmg.17.1579015027513;
        Tue, 14 Jan 2020 07:17:07 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id s19sm18276993wmj.33.2020.01.14.07.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:17:07 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/6] fanotify: merge duplicate events on parent and child
Date:   Tue, 14 Jan 2020 17:16:54 +0200
Message-Id: <20200114151655.29473-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114151655.29473-1-amir73il@gmail.com>
References: <20200114151655.29473-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With inotify, when a watch is set on a directory and on its child, an
event on the child is reported twice, once with wd of the parent watch
and once with wd of the child watch without the filename.

With fanotify, when a watch is set on a directory and on its child, an
event on the child is reported twice, but it has the exact same
information - either an open file descriptor of the child or an encoded
fid of the child.

The reason that the two identical events are not merged is because the
tag used for merging events in the queue is the child inode in one event
and parent inode in the other.

For events with path or dentry data, use the dentry instead of inode as
the tag for event merging, so that the event reported on parent will be
merged with the event reported on the child.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 34454390e4b6..2ae82040f26f 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -265,17 +265,21 @@ static int fanotify_encode_fid(struct fanotify_event *event,
  * FS_CREATE reports the modified dir inode and not the created inode.
  */
 static struct inode *fanotify_fid_inode(struct inode *to_tell, u32 event_mask,
-					const void *data, int data_type)
+					const void *data, int data_type,
+					struct dentry **pdentry)
 {
 	if (event_mask & ALL_FSNOTIFY_DIRENT_EVENTS)
 		return to_tell;
 	else if (data_type == FSNOTIFY_EVENT_INODE)
 		return (struct inode *)data;
 	else if (data_type == FSNOTIFY_EVENT_DENTRY)
-		return d_inode(data);
+		*pdentry = (struct dentry *)data;
 	else if (data_type == FSNOTIFY_EVENT_PATH)
-		return d_inode(((struct path *)data)->dentry);
-	return NULL;
+		*pdentry = ((struct path *)data)->dentry;
+	else
+		return NULL;
+
+	return d_inode(*pdentry);
 }
 
 struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
@@ -285,7 +289,9 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 {
 	struct fanotify_event *event = NULL;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
-	struct inode *id = fanotify_fid_inode(inode, mask, data, data_type);
+	struct dentry *dentry = NULL;
+	struct inode *id = fanotify_fid_inode(inode, mask, data, data_type,
+					      &dentry);
 
 	/*
 	 * For queues with unlimited length lost events are not expected and
@@ -316,7 +322,12 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	if (!event)
 		goto out;
 init: __maybe_unused
-	fsnotify_init_event(&event->fse, inode);
+	/*
+	 * Use the dentry instead of inode as tag for event queue, so event
+	 * reported on parent is merged with event reported on child when both
+	 * directory and child watches exist.
+	 */
+	fsnotify_init_event(&event->fse, (void *)dentry ?: inode);
 	event->mask = mask;
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
 		event->pid = get_pid(task_pid(current));
-- 
2.17.1

