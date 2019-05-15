Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831141FAF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEOTdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:33:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:38814 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbfEOTdk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:33:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E9A2ABCE;
        Wed, 15 May 2019 19:33:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C1F991E3C9E; Wed, 15 May 2019 21:33:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH] fanotify: Disallow permission events for proc filesystem
Date:   Wed, 15 May 2019 21:33:37 +0200
Message-Id: <20190515193337.11167-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Proc filesystem has special locking rules for various files. Thus
fanotify which opens files on event delivery can easily deadlock
against another process that waits for fanotify permission event to be
handled. Since permission events on /proc have doubtful value anyway,
just disallow them.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fanotify/fanotify_user.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index a90bb19dcfa2..73719949faa6 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -920,6 +920,20 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
 	return 0;
 }
 
+static int fanotify_events_supported(struct path *path, __u64 mask)
+{
+	/*
+	 * Proc is special and various files have special locking rules so
+	 * fanotify permission events have high chances of deadlocking the
+	 * system. Just disallow them.
+	 */
+	if (mask & FANOTIFY_PERM_EVENTS &&
+	    !strcmp(path->mnt->mnt_sb->s_type->name, "proc")) {
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
 static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 			    int dfd, const char  __user *pathname)
 {
@@ -1018,6 +1032,12 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (ret)
 		goto fput_and_out;
 
+	if (flags & FAN_MARK_ADD) {
+		ret = fanotify_events_supported(&path, mask);
+		if (ret)
+			goto path_put_and_out;
+	}
+
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
 		ret = fanotify_test_fid(&path, &__fsid);
 		if (ret)
-- 
2.16.4

