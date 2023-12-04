Return-Path: <linux-fsdevel+bounces-4742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 019C5802D38
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 09:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E47280CF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C897FBF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hfVmBXDq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27771B1;
	Sun,  3 Dec 2023 23:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701676352;
	bh=qsEBHDax+s7znxB3EesnA+Cx/J6JWc+CwYaqV7C/mz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hfVmBXDqoE2YJJldVofqpz/WfcE44RA5hrjOLjKrsSgg8+Vqz84+o+k8l9htgRRuh
	 GNgCzJ2F8uqa8XxJuyz10kUjmac79RpTKqgK2TP3AAPjAx7N0rDGu3MpOebqHilblI
	 e96AYqMrxRiH3i0WeQj0kc2hdK4B6hopDMqYiW6c=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 04 Dec 2023 08:52:26 +0100
Subject: [PATCH v2 13/18] sysctl: move sysctl type to ctl_table_header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-13-7a5060b11447@weissschuh.net>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
To: Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=3565;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=qsEBHDax+s7znxB3EesnA+Cx/J6JWc+CwYaqV7C/mz4=;
 b=tMIii9ffAADr2UzePskIfAqvkha4rSZzcbOgaBFMjvqiqSSnOcNxY/LJgEC+njVgyCMiCAdq9
 SW3QXP7NxdDA0aQiXdPhxD49iCJoOupbeLO1zlHRwAauVfNse8Y++Ct
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In a future commit the sysctl core will only use
"const struct ctl_table". As a preparation for that move this mutable
field from "struct ctl_table" to "struct ctl_table_header".

This is also more correct in general as this is in fact a property of
the header and not the table itself.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c  | 11 ++++++-----
 include/linux/sysctl.h | 22 +++++++++++-----------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 689a30196d0c..a398cc77637f 100644
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
@@ -231,7 +231,8 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 		return -EROFS;
 
 	/* Am I creating a permanently empty directory? */
-	if (sysctl_is_perm_empty_ctl_header(header)) {
+	if (header->ctl_table == sysctl_mount_point ||
+	    sysctl_is_perm_empty_ctl_header(header)) {
 		if (!RB_EMPTY_ROOT(&dir->root))
 			return -EINVAL;
 		sysctl_set_perm_empty_ctl_header(dir_h);
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ada36ef8cecb..061ea65104be 100644
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
+		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
+	} type;
 };
 
 struct ctl_dir {

-- 
2.43.0


