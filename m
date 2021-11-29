Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C11B46271E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbhK2XBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 18:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbhK2XAc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:00:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB6AC06FD4D
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:51 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q3so16569888wru.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2nL0n1C3OnRUFon2PoDxurocwWlB/mjbZadwhx3BctI=;
        b=Hb3YKXCfZ7lXDt+kbZCir1hun1uyPyhyycRNQc4PBOPJXUVIR/sclQCJPzUy4h72F/
         0fTWfWkOcjUkTo4RxfaXE0yhPnLr8Ab6y9NMlN3K/abculxjCgf8JWjwXnlSPclPpIYg
         ik+UCoGRswdsmBIWLpoF11zXyq//t36eFeS+lX9rX4X+oiR+g3AV/QBtltetC3J4tSaB
         NyoY6o5PgIkHtSXZ0FHlGn36u6mE9ShGy59XhI8VhtvnEw0SIRfCdwAqEy9hOfDMzdoo
         nPY6XwRBA2kYWG50Nn32aVy0R73joHwGOEdxrHhIBRwuhPShnvHuLalCll7jvF/VX0wN
         1Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2nL0n1C3OnRUFon2PoDxurocwWlB/mjbZadwhx3BctI=;
        b=f1ach6X+ds7SgsBhL3vG6uwt+2ZpCA6xUNQRq9eEmx4i2GldqJQE2/62WQSvsWA9IN
         tPzHdx2/pH3mFz30Kz3dcJGqVvnEEjq3k7k7rrrkIuMQ52yEbIQH8qXjUkLsto9GoPfJ
         WtvqVzorBToqerRJ1D8YMLmhyvOkVDx2UYj/B7ehvF8WjC6h0AFwsQ2GJzt76bljiJfK
         Hn39gXLz7dZ27JnJhWFDx2hM2R7h17kC1cD5ngWATY8d3aha6MsUgPsbpVvXx20Xu1Fl
         lFVTTwVNyeNEcN0zHRc+kXMBY0KZ5bzm3yE5sckvnCm7oV8FEh33Eqg+KqdFv1scvV9Q
         U/HA==
X-Gm-Message-State: AOAM533czpFLyBwVssPgS5Y1d6/rB2iXrAvM7BNjWaRaxMwqZkdDkOZU
        6LZFj0O6zZmiaSLCSm/JPbw=
X-Google-Smtp-Source: ABdhPJwI42yUitQVd9UzIsJbBJR7py5//Cp4ddyzz7FKWpQT+I4QIaeUdnU+0X86OvT2TF9yhCXCUQ==
X-Received: by 2002:adf:f9d2:: with SMTP id w18mr35832289wrr.501.1638216950474;
        Mon, 29 Nov 2021 12:15:50 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id m14sm19791830wrp.28.2021.11.29.12.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:15:50 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 09/11] fanotify: record either old name new name or both for FAN_RENAME
Date:   Mon, 29 Nov 2021 22:15:35 +0200
Message-Id: <20211129201537.1932819-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129201537.1932819-1-amir73il@gmail.com>
References: <20211129201537.1932819-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We do not want to report the dirfid+name of a directory whose
inode/sb are not watched, because watcher may not have permissions
to see the directory content.

Use an internal iter_info to indicate to fanotify_alloc_event()
which marks of this group are watching FAN_RENAME, so it can decide
if we need to record only the old parent+name, new parent+name or both.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 59 +++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index db81eab90544..050f0fa79079 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -284,6 +284,7 @@ static int fanotify_get_response(struct fsnotify_group *group,
  */
 static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 				     struct fsnotify_iter_info *iter_info,
+				     struct fsnotify_iter_info *match_info,
 				     u32 event_mask, const void *data,
 				     int data_type, struct inode *dir)
 {
@@ -335,6 +336,9 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 			continue;
 
 		marks_mask |= mark->mask;
+
+		/* Record the mark types of this group that matched the event */
+		fsnotify_iter_set_report_type(match_info, type);
 	}
 
 	test_mask = event_mask & marks_mask & ~marks_ignored_mask;
@@ -701,11 +705,12 @@ static struct fanotify_event *fanotify_alloc_error_event(
 	return &fee->fae;
 }
 
-static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
-						   u32 mask, const void *data,
-						   int data_type, struct inode *dir,
-						   const struct qstr *file_name,
-						   __kernel_fsid_t *fsid)
+static struct fanotify_event *fanotify_alloc_event(
+				struct fsnotify_group *group,
+				u32 mask, const void *data, int data_type,
+				struct inode *dir, const struct qstr *file_name,
+				__kernel_fsid_t *fsid,
+				struct fsnotify_iter_info *match_info)
 {
 	struct fanotify_event *event = NULL;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
@@ -753,13 +758,39 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		}
 
 		/*
-		 * In the special case of FAN_RENAME event, we record both
-		 * old and new parent+name.
+		 * In the special case of FAN_RENAME event, use the match_info
+		 * to determine if we need to report only the old parent+name,
+		 * only the new parent+name or both.
 		 * 'dirid' and 'file_name' are the old parent+name and
 		 * 'moved' has the new parent+name.
 		 */
-		if (mask & FAN_RENAME)
-			moved = fsnotify_data_dentry(data, data_type);
+		if (mask & FAN_RENAME) {
+			bool report_old, report_new;
+
+			if (WARN_ON_ONCE(!(match_info.report_mask)))
+				return NULL;
+
+			/* Report both old and new parent+name if sb watching */
+			report_old = report_new =
+				fsnotify_iter_should_report_type(match_info,
+						FSNOTIFY_ITER_TYPE_SB);
+			report_old |=
+				fsnotify_iter_should_report_type(match_info,
+						FSNOTIFY_ITER_TYPE_INODE);
+			report_new |=
+				fsnotify_iter_should_report_type(match_info,
+						FSNOTIFY_ITER_TYPE_INODE2);
+
+			if (!report_old) {
+				/* Do not report old parent+name */
+				dirid = NULL;
+				file_name = NULL;
+			}
+			if (report_new) {
+				/* Report new parent+name */
+				moved = fsnotify_data_dentry(data, data_type);
+			}
+		}
 	}
 
 	/*
@@ -872,6 +903,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	struct fanotify_event *event;
 	struct fsnotify_event *fsn_event;
 	__kernel_fsid_t fsid = {};
+	struct fsnotify_iter_info match_info = {};
 
 	BUILD_BUG_ON(FAN_ACCESS != FS_ACCESS);
 	BUILD_BUG_ON(FAN_MODIFY != FS_MODIFY);
@@ -897,12 +929,13 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 
 	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
 
-	mask = fanotify_group_event_mask(group, iter_info, mask, data,
-					 data_type, dir);
+	mask = fanotify_group_event_mask(group, iter_info, &match_info,
+					 mask, data, data_type, dir);
 	if (!mask)
 		return 0;
 
-	pr_debug("%s: group=%p mask=%x\n", __func__, group, mask);
+	pr_debug("%s: group=%p mask=%x report_mask=%x\n", __func__,
+		 group, mask, match_info.report_mask);
 
 	if (fanotify_is_perm_event(mask)) {
 		/*
@@ -921,7 +954,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	}
 
 	event = fanotify_alloc_event(group, mask, data, data_type, dir,
-				     file_name, &fsid);
+				     file_name, &fsid, &match_info);
 	ret = -ENOMEM;
 	if (unlikely(!event)) {
 		/*
-- 
2.33.1

