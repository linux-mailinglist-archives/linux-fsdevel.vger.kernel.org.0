Return-Path: <linux-fsdevel+bounces-15116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DE8887195
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 18:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7FD1F23D0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 17:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A525FDA6;
	Fri, 22 Mar 2024 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jKrF2+St"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F05DF24;
	Fri, 22 Mar 2024 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127167; cv=none; b=qzk+JQebCrZ2UjPV5Zsn9Wf5liE6Is+sNTK6sLu6lTbyh2Gyo94KpYo6EKUuNcLglYOr4MJ99u/ix37EMDIILVAJV/2hGlc2i+KJVJcI2FJXzBsYjCr7FNHfVbsUZAAyw5qU13s3GXMBLJpNFi5MPZ8fg+PIHTmENDvT2Gt77hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127167; c=relaxed/simple;
	bh=fbNFIH997ozcRary5wTNHgChd3s3fGTnPrgslom1cXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZvNmImzSbVyUyitwwLlvPySwKTqq6ellxeaucY8yHTBRux+07btqY604B2dpFSGzNMtG9xDYJhJKcX/YLB/FnnIBiXamU22F3YXq0MYGTjJaejY7ulMa/26ikK+a+0EyL7+pE//S50ddRC8EDtvGKWSiWqOipnf4QoThouuxBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jKrF2+St; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1711127160;
	bh=fbNFIH997ozcRary5wTNHgChd3s3fGTnPrgslom1cXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jKrF2+StoDsBP4OFlzssR6cUtxccJX8wLt3fD5XgcZTbZ4YTpPxfoJwhw1RVXvZuw
	 yFzfxuiJ7n6qsA/1sRDfYs1LoShIGWCRW2Vx/SynyRjRDL9An95HFjfoIKQZt5tLDR
	 jnRhJrO0EORbgl1ZwQFNzoNX2hCuSlJOhifjeOZc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 22 Mar 2024 18:05:57 +0100
Subject: [PATCH v2 2/3] sysctl: move sysctl type to ctl_table_header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240322-sysctl-empty-dir-v2-2-e559cf8ec7c0@weissschuh.net>
References: <20240322-sysctl-empty-dir-v2-0-e559cf8ec7c0@weissschuh.net>
In-Reply-To: <20240322-sysctl-empty-dir-v2-0-e559cf8ec7c0@weissschuh.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711127159; l=3725;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=fbNFIH997ozcRary5wTNHgChd3s3fGTnPrgslom1cXY=;
 b=VvB9IY168QAX29XiUdGDePb/dx2TNalal2DoM7uVdqJkc8uLWk2TzbHdg5x2xCMvuja8ffKkQ
 sy55efShkhcAXuVGZFb+Odk8p752NwIqf0Fuq0Bo/J5xtGyJf/S6d+r
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Move the SYSCTL_TABLE_TYPE_{DEFAULT,PERMANENTLY_EMPTY} enums from
ctl_table to ctl_table_header.
Removing the mutable member is necessary to constify static instances
of struct ctl_table.

Move the initialization of the sysctl_mount_point type into
init_header() where all the other header fields are also initialized.

As a side-effect the memory usage of the sysctl core is reduced.
Each ctl_table_header instance can manage multiple ctl_table instances
and is only allocated when the table is actually registered.
This saves 8 bytes of memory per ctl_table on 64bit, 4 due to the enum
field itself and 4 due to padding.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c  | 10 ++++++----
 include/linux/sysctl.h | 22 +++++++++++-----------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 2f4d4329d83d..fde7a2f773f0 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -31,7 +31,7 @@ static const struct inode_operations proc_sys_dir_operations;
 
 /* Support for permanently empty directories */
 static struct ctl_table sysctl_mount_point[] = {
-	{.type = SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY }
+	{ }
 };
 
 /**
@@ -49,11 +49,11 @@ struct ctl_table_header *register_sysctl_mount_point(const char *path)
 EXPORT_SYMBOL(register_sysctl_mount_point);
 
 #define sysctl_is_perm_empty_ctl_header(hptr)		\
-	(hptr->ctl_table[0].type == SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
+	(hptr->type == SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
 #define sysctl_set_perm_empty_ctl_header(hptr)		\
-	(hptr->ctl_table[0].type = SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
+	(hptr->type = SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
 #define sysctl_clear_perm_empty_ctl_header(hptr)	\
-	(hptr->ctl_table[0].type = SYSCTL_TABLE_TYPE_DEFAULT)
+	(hptr->type = SYSCTL_TABLE_TYPE_DEFAULT)
 
 void proc_sys_poll_notify(struct ctl_table_poll *poll)
 {
@@ -208,6 +208,8 @@ static void init_header(struct ctl_table_header *head,
 			node++;
 		}
 	}
+	if (table == sysctl_mount_point)
+		sysctl_set_perm_empty_ctl_header(head);
 }
 
 static void erase_header(struct ctl_table_header *head)
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ee7d33b89e9e..c87f73c06cb9 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -137,17 +137,6 @@ struct ctl_table {
 	void *data;
 	int maxlen;
 	umode_t mode;
-	/**
-	 * enum type - Enumeration to differentiate between ctl target types
-	 * @SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
-	 * @SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Used to identify a permanently
-	 *                                       empty directory target to serve
-	 *                                       as mount point.
-	 */
-	enum {
-		SYSCTL_TABLE_TYPE_DEFAULT,
-		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
-	} type;
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
 	void *extra1;
@@ -188,6 +177,17 @@ struct ctl_table_header {
 	struct ctl_dir *parent;
 	struct ctl_node *node;
 	struct hlist_head inodes; /* head for proc_inode->sysctl_inodes */
+	/**
+	 * enum type - Enumeration to differentiate between ctl target types
+	 * @SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
+	 * @SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Used to identify a permanently
+	 *                                       empty directory target to serve
+	 *                                       as mount point.
+	 */
+	enum {
+		SYSCTL_TABLE_TYPE_DEFAULT,
+		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY,
+	} type;
 };
 
 struct ctl_dir {

-- 
2.44.0


