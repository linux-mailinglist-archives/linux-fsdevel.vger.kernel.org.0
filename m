Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 976A81612EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgBQNPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41429 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgBQNPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so19706023wrw.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 05:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mp/NZJhDpTVTKOe7pgjJLtK1WnKPYZUsnP23pwfKWw8=;
        b=kuUuOup7VeeeOqe1tdVqZ18/1b1s9aQAntaEngYN8UUvm78utGpmZzDIUJ+1wpjbwu
         /YKviWALtol6zNhA9zIBjQ28S2IXogGLUrxP+7MJxP2ehsDTYAFYa3DCAcqnV+/eEMUf
         SRCHUQm/b9a96YUBdI/NC2aQ7tj7ovzqyzYIfGXrdPaJxJzC5q2iXIDy4SPXxo87/WA0
         M7HuSMaW+7y8mnO+bg3CNRSyntbBZfXRlADOQ8lhPtxUnd1kLRHKxp+d/ckubYYZ7hpc
         Etr9+73GIgeBPTVGFxOXs+HOQisPsy68CNmqEZzW6juvXkxWEJ2mhCEgTfdQgtCN2ZwI
         aBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mp/NZJhDpTVTKOe7pgjJLtK1WnKPYZUsnP23pwfKWw8=;
        b=FpdGhJ7YZO+BiDEvxZJQtHQnaSjz9o02J+KicAJihK+CVThdjXcGkZhm87S5viTZU0
         Grh9t0LkxEJpqDdTbOAswOtLRPahKRSXz1ZJ+u/XhFQgrOYyB+iwuHZa/n8JUWNnl0Ko
         yce1q19o6xLvYA+7kZdS8jCAsFz+5Lsce63Sc78QMze2OZk+bWfau9Y6ygeUWzr+x1gE
         3qzZsE8Gy+3Sktcr+e/FOUNYS4oFyvgwbtARniHvibmPPeIOyG5wtFN9xuacBkrKJfYb
         NYuaJxmfZzueoP9O3yxmqvpxli5XhckTOpyWsqb7bhvg9NrSzHmE25Mk5+CyW2n6nYJY
         gwcg==
X-Gm-Message-State: APjAAAVTVQK9ZhSwuLD3Pwhs1t1YBP2/HBIH5s2k3u6iTYFmy31ram1o
        BGZCYzRwC8gjdIopTBgMf7o=
X-Google-Smtp-Source: APXvYqwkXESPAbAWFag7TpqSQ75UK2h9ppcC9Q9VDwE4CX01B6WTFByB4BJLIrhOL1Ar82m08gwSzA==
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr23487272wrx.403.1581945316694;
        Mon, 17 Feb 2020 05:15:16 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m21sm545745wmi.27.2020.02.17.05.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:15:16 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 08/16] fanotify: merge duplicate events on parent and child
Date:   Mon, 17 Feb 2020 15:14:47 +0200
Message-Id: <20200217131455.31107-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217131455.31107-1-amir73il@gmail.com>
References: <20200217131455.31107-1-amir73il@gmail.com>
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
 fs/notify/fanotify/fanotify.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 98c3cbf29003..dab7e9895e02 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -282,6 +282,7 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 	struct inode *id = fanotify_fid_inode(inode, mask, data, data_type);
 	const struct path *path = fsnotify_data_path(data, data_type);
+	struct dentry *dentry = fsnotify_data_dentry(data, data_type);
 
 	/*
 	 * For queues with unlimited length lost events are not expected and
@@ -312,7 +313,12 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
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

