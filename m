Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CADAA18BAAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgCSPK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:10:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45269 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgCSPK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:10:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id i9so3430741wrx.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yAZeufZMP3+VvqXvebjKcn41g+hLAj10HPMbH884iL0=;
        b=idyZCh13m1OC84VA8MbbnSrOie7Qvr5EocH0+ceJdunNb4o/juuBM1XZaCSMXOKOn0
         ZmxaCbox+qdW9QD8LtgxoFXruUtUyt0EKdeK+CzE9puxeUqM/O7Hfv1JvWtg/rTX1RHg
         VMutTx+TAQV5owuYOicVO3MR38xv8mxqGe1kS7AOnECTK5ejQMod24lOhv6GVCVlLnJX
         7ltDOZwTRzZdOdfBsqe1q63vmpxtuVPKL87F8DnEY6RQGLnKYKpa8B7we3PWeotuiW5o
         PjbHDCwvgZ6ZWNNZb7qFvk6WQQglHxG9GcE01U3xYU1CdJWZlguGMa7XnIIBWmC1dzl0
         jNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yAZeufZMP3+VvqXvebjKcn41g+hLAj10HPMbH884iL0=;
        b=MMbWdqkcOjeQnXMYeYpkEvdpsiNjOMjxeYApwem7YysL3tM0H81NZdgZDquWAbBp3w
         pcqkKLX5OaCQdzrxmCIg06XvqyJU8znyuIIZMVz44u6br04yLqyg1cD1YFcBmPGxEnOd
         AfvVwn4NK4+zx6LHhvSZB+WZXpTQDCbI3jpBwfJMixxyrZWOJHNuvvfUbUvRkY7Pb308
         KCxt0UJXHzs19IWdBQQad06OwREHKuGz3r3+POiU170LtRc+kY7zK2xnbqMd3UoaP/nb
         UvqbgcZ0K4/hwtE61N+4wGusc9KdEnazibyLovKT3hfkVYwOmK+xdQOlcz0rlBjYzx1c
         D2QQ==
X-Gm-Message-State: ANhLgQ3FWGxd7Tz2Ls+r4ur59Dk6esJqVlKu9gqAz/5wfEpqTI1D0pCN
        SFuJG+fhsuT0Rrn4uZy0xws=
X-Google-Smtp-Source: ADFU+vvIheUXyduJCZfmgGloXJDfqz3v8LyAsn1V6Z9GD0iYRKEePs5Tgc5zls/j1IJvR0kFIncYIw==
X-Received: by 2002:a5d:6ca7:: with SMTP id a7mr5227202wra.157.1584630656934;
        Thu, 19 Mar 2020 08:10:56 -0700 (PDT)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id t193sm3716959wmt.14.2020.03.19.08.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:10:56 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 12/14] fanotify: prepare to report both parent and child fid's
Date:   Thu, 19 Mar 2020 17:10:20 +0200
Message-Id: <20200319151022.31456-13-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319151022.31456-1-amir73il@gmail.com>
References: <20200319151022.31456-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For some events, we are going to report both child and parent fid's,
so pass fsid and file handle as arguments to copy_fid_to_user(),
which is going to be called with parent and child file handles.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 6d30627863ff..aaa62bd2b80e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -52,6 +52,13 @@ struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
 
 #define FANOTIFY_EVENT_ALIGN 4
 
+static int fanotify_fid_info_len(int fh_len)
+{
+	return roundup(sizeof(struct fanotify_event_info_fid) +
+		       sizeof(struct file_handle) + fh_len,
+		       FANOTIFY_EVENT_ALIGN);
+}
+
 static int fanotify_event_info_len(struct fanotify_event *event)
 {
 	int fh_len = fanotify_event_object_fh_len(event);
@@ -59,9 +66,7 @@ static int fanotify_event_info_len(struct fanotify_event *event)
 	if (!fh_len)
 		return 0;
 
-	return roundup(sizeof(struct fanotify_event_info_fid) +
-		       sizeof(struct file_handle) + fh_len,
-		       FANOTIFY_EVENT_ALIGN);
+	return fanotify_fid_info_len(fh_len);
 }
 
 /*
@@ -201,14 +206,14 @@ static int process_access_response(struct fsnotify_group *group,
 	return -ENOENT;
 }
 
-static int copy_fid_to_user(struct fanotify_event *event, char __user *buf)
+static int copy_fid_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
+			    char __user *buf)
 {
 	struct fanotify_event_info_fid info = { };
 	struct file_handle handle = { };
 	unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *fh_buf;
-	struct fanotify_fh *fh = fanotify_event_object_fh(event);
 	size_t fh_len = fh->len;
-	size_t len = fanotify_event_info_len(event);
+	size_t len = fanotify_fid_info_len(fh_len);
 
 	if (!len)
 		return 0;
@@ -219,7 +224,7 @@ static int copy_fid_to_user(struct fanotify_event *event, char __user *buf)
 	/* Copy event info fid header followed by vaiable sized file handle */
 	info.hdr.info_type = FAN_EVENT_INFO_TYPE_FID;
 	info.hdr.len = len;
-	info.fsid = *fanotify_event_fsid(event);
+	info.fsid = *fsid;
 	if (copy_to_user(buf, &info, sizeof(info)))
 		return -EFAULT;
 
@@ -299,7 +304,9 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (f) {
 		fd_install(fd, f);
 	} else if (fanotify_event_has_fid(event)) {
-		ret = copy_fid_to_user(event, buf + FAN_EVENT_METADATA_LEN);
+		ret = copy_fid_to_user(fanotify_event_fsid(event),
+				       fanotify_event_object_fh(event),
+				       buf + FAN_EVENT_METADATA_LEN);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.17.1

