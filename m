Return-Path: <linux-fsdevel+bounces-14648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A022187DF48
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 19:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5684D281265
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 18:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6B620B20;
	Sun, 17 Mar 2024 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMxUmBLn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B247920334
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700933; cv=none; b=Ph8aFRn5EN9NLtb+bqmhwpbtS3wNs7jQzg55nXXeHZsJS0GdpkC4FudUfeP0F7qQCMd2boExtjdL2/FDHuX1InAozsJ9HVoX7nogqqC+8ebVgu2Muad46Y2EryUoen5CuUJcok+fjmeTZz8fhK0iH3RJXjXXwhXsWHJ3skwb23s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700933; c=relaxed/simple;
	bh=XBuvvLu8/UzoyoWT0MCweRt6WecfrWtaqSjcdu09ulw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7G11AYxusQEjm3JOMmZGyDAKUi7CuOO23cprm9ALpb5qyGFjBKKHYvil8+t7tpm6C+SRk1oqiTr8vcENscxsw0HVFbplcEdE9Fe676xG66W3i+bKOCOZAi4QxnkYDFLQ8XMdFH9PTjqaOZRQBvbvOQxnI+Uxx/doqhJmN+KETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMxUmBLn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e5978fc1bso1602548f8f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710700930; x=1711305730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgsT6wjDnbQxn+wibSyQGvFScP+pKGUvJsL4JNNuHjg=;
        b=HMxUmBLnBHa6JFkBZlgN+X9dIeUDSSfZpxprYA8BB/og/+pPdZhIEQjYw5oALcmfXQ
         b1V1ovai1bZHXHpAkPFfZlC2Xq2ctc8FW+yqZCA0AHkxbdllS/jl5KzfjOd4Ad6VUJ++
         XEPvikjEcP6oLzrYmBO1oHIQgDu/2OXdTQ6J1HP7BWGFqHzGGTIisTjDg7oWRhGjPG6D
         iyBl/Ki1mFYnBq5TMkadOoWcI+YSDlpaVZ2t0ZcQTDFTDwBo7gBJqeqhnW3fRCq+Ayfc
         Y2v4dHn0ysi+UnKPTx9dMK2lapqTXwfWJjpAW1CYHrbkXa/q/kIQWPjH/6cQSCFCkXSZ
         NBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710700930; x=1711305730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgsT6wjDnbQxn+wibSyQGvFScP+pKGUvJsL4JNNuHjg=;
        b=qvUHArkb5fOmgr5gRrPEVMN6dNnF5hXCksBPU0kyQSFNYz8mKlhuW8huE89FU9B5r/
         M4XFyb8okkxnIs5Oyv99UoWiIPenPmlX7UBuGEzK5QkR5iFwcT1h85S3gvrARMbiqrq7
         CirUBxFDX9uQanL5rgxqL84EQ82vsSppbKkcnim8gE6tRChnYR9ufB4P8exxu9OZWUCo
         WwP0Fim9Bv99ec9uqofvXet3X8ci/mLLHb3LfwPgHP+ccikBkUbIS3Qx1hgUs0GA1vTn
         wJ5YxG4+TmHm4ZHH5U6bhZmIB963cginvcIn0XBgS8eY3s5vW+TZrCrxFv38LagSi4V+
         vSbA==
X-Forwarded-Encrypted: i=1; AJvYcCWbda7tyGTNs/jeiVUpYssuy2iJItPIsjL8pQPcal4xbLPAMQ2p2etiVWFb23X3mJSBEHEtMpfU2tkGj60qOlEBECW5raq0ounIR8gPxA==
X-Gm-Message-State: AOJu0Yw1FpyFGF01A4ShvyKSqVhaMdP2wC8ySNNbbZ+2xD6KDrktZIBa
	yIG7JSbevcT1wUaMrCgOTmqOEQYTdcn1ofGHnRdSbUMSounSfY124xQpgcV+
X-Google-Smtp-Source: AGHT+IH7cGIbvP6H3oGjSR9mwqrSDv6lAifygCf+SG9ICDoiQek6e1ZInrkHAi6Od59nt/jrJBsb4g==
X-Received: by 2002:a5d:44c5:0:b0:33d:269e:132a with SMTP id z5-20020a5d44c5000000b0033d269e132amr7456361wrr.15.1710700929961;
        Sun, 17 Mar 2024 11:42:09 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b0033e22a7b3f8sm3070716wrb.75.2024.03.17.11.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:42:08 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/10] fsnotify: create helper fsnotify_update_sb_watchers()
Date: Sun, 17 Mar 2024 20:41:50 +0200
Message-Id: <20240317184154.1200192-7-amir73il@gmail.com>
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

We would like to count watched objects by priority group, so we will need
to update the watched object counter after adding/removing marks.

Create a helper fsnotify_update_sb_watchers() and call it after
attaching/detaching a mark, instead of fsnotify_{get,put}_sb_watchers()
only after attaching/detaching a connector.

Soon, we will use this helper to count watched objects by the highest
watching priority group.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/mark.c                 | 36 +++++++++++++++++++-------------
 include/linux/fsnotify_backend.h |  1 +
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index aa4233b5a3e4..0b703f9e6344 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -153,20 +153,23 @@ static void fsnotify_put_inode_ref(struct inode *inode)
 	fsnotify_put_sb_watched_objects(inode->i_sb);
 }
 
-static void fsnotify_get_sb_watchers(struct fsnotify_mark_connector *conn)
+/*
+ * Grab or drop watched objects reference depending on whether the connector
+ * is attached and has any marks attached.
+ */
+static void fsnotify_update_sb_watchers(struct super_block *sb,
+					struct fsnotify_mark_connector *conn)
 {
-	struct super_block *sb = fsnotify_connector_sb(conn);
+	bool is_watched = conn->flags & FSNOTIFY_CONN_FLAG_IS_WATCHED;
+	bool has_marks = conn->obj && !hlist_empty(&conn->list);
 
-	if (sb)
+	if (has_marks && !is_watched) {
+		conn->flags |= FSNOTIFY_CONN_FLAG_IS_WATCHED;
 		fsnotify_get_sb_watched_objects(sb);
-}
-
-static void fsnotify_put_sb_watchers(struct fsnotify_mark_connector *conn)
-{
-	struct super_block *sb = fsnotify_connector_sb(conn);
-
-	if (sb)
+	} else if (!has_marks && is_watched) {
+		conn->flags &= ~FSNOTIFY_CONN_FLAG_IS_WATCHED;
 		fsnotify_put_sb_watched_objects(sb);
+	}
 }
 
 /*
@@ -265,6 +268,7 @@ static void *fsnotify_detach_connector_from_object(
 					unsigned int *type)
 {
 	fsnotify_connp_t *connp = fsnotify_object_connp(conn->obj, conn->type);
+	struct super_block *sb = fsnotify_connector_sb(conn);
 	struct inode *inode = NULL;
 
 	*type = conn->type;
@@ -284,10 +288,10 @@ static void *fsnotify_detach_connector_from_object(
 		fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
 	}
 
-	fsnotify_put_sb_watchers(conn);
 	rcu_assign_pointer(*connp, NULL);
 	conn->obj = NULL;
 	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
+	fsnotify_update_sb_watchers(sb, conn);
 
 	return inode;
 }
@@ -339,6 +343,11 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 		objp = fsnotify_detach_connector_from_object(conn, &type);
 		free_conn = true;
 	} else {
+		struct super_block *sb = fsnotify_connector_sb(conn);
+
+		/* Update watched objects after detaching mark */
+		if (sb)
+			fsnotify_update_sb_watchers(sb, conn);
 		objp = __fsnotify_recalc_mask(conn);
 		type = conn->type;
 	}
@@ -580,10 +589,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	if (cmpxchg(connp, NULL, conn)) {
 		/* Someone else created list structure for us */
 		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
-		return 0;
 	}
-
-	fsnotify_get_sb_watchers(conn);
 	return 0;
 }
 
@@ -623,6 +629,7 @@ static struct fsnotify_mark_connector *fsnotify_grab_connector(
 static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
 				  unsigned int obj_type, int add_flags)
 {
+	struct super_block *sb = fsnotify_object_sb(obj, obj_type);
 	struct fsnotify_mark *lmark, *last = NULL;
 	struct fsnotify_mark_connector *conn;
 	fsnotify_connp_t *connp;
@@ -672,6 +679,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
 	/* mark should be the last entry.  last is the current last entry */
 	hlist_add_behind_rcu(&mark->obj_list, &last->obj_list);
 added:
+	fsnotify_update_sb_watchers(sb, conn);
 	/*
 	 * Since connector is attached to object using cmpxchg() we are
 	 * guaranteed that connector initialization is fully visible by anyone
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index face68fcf850..83004d9e07a3 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -465,6 +465,7 @@ FSNOTIFY_ITER_FUNCS(sb, SB)
 struct fsnotify_mark_connector {
 	spinlock_t lock;
 	unsigned short type;	/* Type of object [lock] */
+#define FSNOTIFY_CONN_FLAG_IS_WATCHED	0x01
 #define FSNOTIFY_CONN_FLAG_HAS_IREF	0x02
 	unsigned short flags;	/* flags [lock] */
 	union {
-- 
2.34.1


