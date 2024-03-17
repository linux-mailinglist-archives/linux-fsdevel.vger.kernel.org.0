Return-Path: <linux-fsdevel+bounces-14643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A858E87DF43
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 19:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B9F1C2088E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62FB1D545;
	Sun, 17 Mar 2024 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+jdEmvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6D9208A7
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700926; cv=none; b=K+jsEjhvrCFzqRNbk9DoDw1sYt32HY6caTUxSXCFaEKA53CdS0oIh5CgZaIL+OjroMYjsOACVPKKkFB6yZAuAvKY7D15ml5yX0SSd8kKwgtOcQeTWbQe/NPwuglxaqERtRCYH0Opb5Alh1KIUeKy80nxgeIMS3V8zIL3GemXLAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700926; c=relaxed/simple;
	bh=WhboYfJ8TYpkM9sSfKcQI81W0vuvG/j1K0uxakIEFbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ne3DtCic14HR0Zn4ZZhRdXR7Cjo5Uh6yuLFl8ncVmNRoijG+eX2hhQ9791Vu9t83kFyPJJYeOnK28bIulbyl4B/lFGD5SQ06AvoOzxBQhrZGn20YLql9Ohriavv5O4HskzOhmco3Uzkb4kNFQgdDVD3AtOJsXIM3RUVBJ2bFOjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+jdEmvS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34005b5927eso702505f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 11:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710700923; x=1711305723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qF6zPkLbskXOD4wQs0uPprrBI+YNVlFRih1iWlgRCE=;
        b=i+jdEmvS73PPxUpo+BSy2aY+9TV0/QDOVTyfDNDBrwfXmrMulavQKK2JfWke0IjM1p
         yO5fgfWpg+m5M+r34j3/RTm1lWqa8Pep52KAhm5qgBPqY+yN8HmikMbQWXB8DWsY8zeQ
         CFczxQUD4cmi3KU7dZfOy4eakVa0eLALyu9UbVNR9u4eIvcqAfVAOdNhuo2ZpCqNfybM
         3ytWoTAJe9GFh2B4PiHdaYutzOH9rqa5sU+SIMzFCtQJzlx/DBqL/YUbI/AqKLYHm9QU
         EfAJZSTUsIwEJ/43HPSoKPDvA3khdaY2NFw/VqyNZg5GxpBSv4DQ56wJsSZO6awMxNxc
         yzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710700923; x=1711305723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qF6zPkLbskXOD4wQs0uPprrBI+YNVlFRih1iWlgRCE=;
        b=w+qj9wpc9VramfBZDec5PBUFvtANs5n0vDHnzuzZtKoNZH7a207itYbyvakLvtWqrk
         wITtjKOkWe1szxTIvivOt1Sx2HHvHm9xVgmIk/rAL5he0XeMAnAPr4eudzGrDL26As5f
         LbRuK+DFol4I21Nu+hDt6T/k+BYu5/MtsJmzcI2xCDZlMuV/pgXK9loCJF0FBCFKOsvp
         O8biuM/Lx+Ln52ls9JSDDKn7PONEJ8AudtX81iOOyyfEgZoWV60ZjlVmcwElasrKUfEb
         w0YIy/W3lPWdlQf7L4Iaaj+urLLcQEN4TbdggNWYuj6HLN2xmzht6r0flSvIS3V2gVpy
         eR9w==
X-Forwarded-Encrypted: i=1; AJvYcCUD3ADPXYSPF6H3g0hzjP4zdgad2NdHWF3jaGSgdNdX6FjVW4p5fNip+/GRxGTT9X+8nwkuyMCstpEZUqpUsdFdUFovuDC6hMJew4FOKw==
X-Gm-Message-State: AOJu0YzDRFCkDw1AMFnA1n0DmVapHvZ6nf0O7q3Va5uDQXK4nz4U07/M
	2pFwA3RcgH5T4wp9cWOBrocX8mxTsSkmTVZB+02W+xJ1WCQ0LG5U
X-Google-Smtp-Source: AGHT+IGCkulSdYeBHqotjs9tMxr9Kf+UyOUo5AtT8o15t0qpbprgcaFAKGbHF93pFPwU+RV+XXa15w==
X-Received: by 2002:a5d:428c:0:b0:33e:b68b:4edd with SMTP id k12-20020a5d428c000000b0033eb68b4eddmr7932940wrq.64.1710700922501;
        Sun, 17 Mar 2024 11:42:02 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b0033e22a7b3f8sm3070716wrb.75.2024.03.17.11.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:42:02 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/10] fsnotify: rename fsnotify_{get,put}_sb_connectors()
Date: Sun, 17 Mar 2024 20:41:45 +0200
Message-Id: <20240317184154.1200192-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240317184154.1200192-1-amir73il@gmail.com>
References: <20240317184154.1200192-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of counting the number of connectors in an sb, we would like
to count the number of watched objects per priority group.

As a start, create an accessor fsnotify_sb_watched_objects() to
s_fsnotify_connectors and rename the fsnotify_{get,put}_sb_connectors()
helpers to fsnotify_{get,put}_sb_watchers() to better describes the
counter.

Increment the counter at the end of fsnotify_attach_connector_to_object()
if connector was attached instead of decrementing it on race to connect.

This is fine, because fsnotify_delete_sb() cannot be running in parallel
to fsnotify_attach_connector_to_object() which requires a reference to
a filesystem object.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             |  4 +-
 fs/notify/mark.c                 | 67 ++++++++++++++++++--------------
 include/linux/fsnotify.h         |  2 +-
 include/linux/fsnotify_backend.h |  5 +++
 4 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 2fc105a72a8f..503e7c75e777 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -92,8 +92,8 @@ void fsnotify_sb_delete(struct super_block *sb)
 	fsnotify_unmount_inodes(sb);
 	fsnotify_clear_marks_by_sb(sb);
 	/* Wait for outstanding object references from connectors */
-	wait_var_event(&sb->s_fsnotify_connectors,
-		       !atomic_long_read(&sb->s_fsnotify_connectors));
+	wait_var_event(fsnotify_sb_watched_objects(sb),
+		       !atomic_long_read(fsnotify_sb_watched_objects(sb)));
 }
 
 /*
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index d6944ff86ffa..8339d77b1aa2 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -116,10 +116,43 @@ __u32 fsnotify_conn_mask(struct fsnotify_mark_connector *conn)
 	return *fsnotify_conn_mask_p(conn);
 }
 
+static void fsnotify_get_sb_watched_objects(struct super_block *sb)
+{
+	atomic_long_inc(fsnotify_sb_watched_objects(sb));
+}
+
+static void fsnotify_put_sb_watched_objects(struct super_block *sb)
+{
+	if (atomic_long_dec_and_test(fsnotify_sb_watched_objects(sb)))
+		wake_up_var(fsnotify_sb_watched_objects(sb));
+}
+
 static void fsnotify_get_inode_ref(struct inode *inode)
 {
 	ihold(inode);
-	atomic_long_inc(&inode->i_sb->s_fsnotify_connectors);
+	fsnotify_get_sb_watched_objects(inode->i_sb);
+}
+
+static void fsnotify_put_inode_ref(struct inode *inode)
+{
+	iput(inode);
+	fsnotify_put_sb_watched_objects(inode->i_sb);
+}
+
+static void fsnotify_get_sb_watchers(struct fsnotify_mark_connector *conn)
+{
+	struct super_block *sb = fsnotify_connector_sb(conn);
+
+	if (sb)
+		fsnotify_get_sb_watched_objects(sb);
+}
+
+static void fsnotify_put_sb_watchers(struct fsnotify_mark_connector *conn)
+{
+	struct super_block *sb = fsnotify_connector_sb(conn);
+
+	if (sb)
+		fsnotify_put_sb_watched_objects(sb);
 }
 
 /*
@@ -213,31 +246,6 @@ static void fsnotify_connector_destroy_workfn(struct work_struct *work)
 	}
 }
 
-static void fsnotify_put_inode_ref(struct inode *inode)
-{
-	struct super_block *sb = inode->i_sb;
-
-	iput(inode);
-	if (atomic_long_dec_and_test(&sb->s_fsnotify_connectors))
-		wake_up_var(&sb->s_fsnotify_connectors);
-}
-
-static void fsnotify_get_sb_connectors(struct fsnotify_mark_connector *conn)
-{
-	struct super_block *sb = fsnotify_connector_sb(conn);
-
-	if (sb)
-		atomic_long_inc(&sb->s_fsnotify_connectors);
-}
-
-static void fsnotify_put_sb_connectors(struct fsnotify_mark_connector *conn)
-{
-	struct super_block *sb = fsnotify_connector_sb(conn);
-
-	if (sb && atomic_long_dec_and_test(&sb->s_fsnotify_connectors))
-		wake_up_var(&sb->s_fsnotify_connectors);
-}
-
 static void *fsnotify_detach_connector_from_object(
 					struct fsnotify_mark_connector *conn,
 					unsigned int *type)
@@ -261,7 +269,7 @@ static void *fsnotify_detach_connector_from_object(
 		fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
 	}
 
-	fsnotify_put_sb_connectors(conn);
+	fsnotify_put_sb_watchers(conn);
 	rcu_assign_pointer(*(conn->obj), NULL);
 	conn->obj = NULL;
 	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
@@ -549,8 +557,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	conn->flags = 0;
 	conn->type = obj_type;
 	conn->obj = connp;
-	conn->flags = 0;
-	fsnotify_get_sb_connectors(conn);
 
 	/*
 	 * cmpxchg() provides the barrier so that readers of *connp can see
@@ -558,10 +564,11 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	 */
 	if (cmpxchg(connp, NULL, conn)) {
 		/* Someone else created list structure for us */
-		fsnotify_put_sb_connectors(conn);
 		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
+		return 0;
 	}
 
+	fsnotify_get_sb_watchers(conn);
 	return 0;
 }
 
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 1a9de119a0f7..e470bb67c9a3 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -20,7 +20,7 @@
 /* Are there any inode/mount/sb objects that are being watched at all? */
 static inline bool fsnotify_sb_has_watchers(struct super_block *sb)
 {
-	return atomic_long_read(&sb->s_fsnotify_connectors);
+	return atomic_long_read(fsnotify_sb_watched_objects(sb));
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 8f40c349b228..d4e3bc55d174 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -483,6 +483,11 @@ struct fsnotify_mark_connector {
 	struct hlist_head list;
 };
 
+static inline atomic_long_t *fsnotify_sb_watched_objects(struct super_block *sb)
+{
+	return &sb->s_fsnotify_connectors;
+}
+
 /*
  * A mark is simply an object attached to an in core inode which allows an
  * fsnotify listener to indicate they are either no longer interested in events
-- 
2.34.1


