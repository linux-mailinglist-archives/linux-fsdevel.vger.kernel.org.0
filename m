Return-Path: <linux-fsdevel+bounces-12423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553B985F1C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 08:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A881F239CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 07:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B179B17BD3;
	Thu, 22 Feb 2024 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="sI2FXOL4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5374817583;
	Thu, 22 Feb 2024 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708585706; cv=none; b=NlXNkEVWOuJmH8FOiwQVkHwEoxM9/huggCaHG8tUcB/e9snrkrJX1q7Q6Sr/12LsaFxeSpBrksHwPQeuggw0GAEjSsEDKufgBi9sUSPZUEtVfirKhU0NVe5ArhIMPtqthKhR6hoGUZPIiaROkkUbGNTJ0Ap4etLUyukvv86NSwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708585706; c=relaxed/simple;
	bh=cR/IG5pmCHIdq4ymlgJjzjZH7hGnhfCNGmfTaQlgx2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrXFVmmcHsc9epTYneRAQM/4gXneZ6s38VyL1kDKL8C7/6KvuAjZ/i9FxSxM5pPYHSls9heZDB3ZeQcpah9w62h3rZjZ5S3Zn7V7NGuM8OH7P93fng2f5QKd244HLw+sE1+4lEGI1Y/EcjUMtKuyMv3viNc8/tRXgnXRe5F167Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=sI2FXOL4; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1708585697;
	bh=cR/IG5pmCHIdq4ymlgJjzjZH7hGnhfCNGmfTaQlgx2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sI2FXOL4hfum+t+KTRgchDnOI8GtyZ+U2OlwsKV+xRYJbFv7ZXz4VosAWZQpGkL6y
	 pMr9HTuWloFx/WLC/nWwYV57tcifWRfUl/ZljHF3zTYfgGEAwZpkFU7ZAjkkUjIduK
	 8zzs7J1mQvHCBvcLnPQLVjyDSwOMvdh32FtJTiwk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 22 Feb 2024 08:07:37 +0100
Subject: [PATCH 2/4] sysctl: move sysctl type to ctl_table_header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240222-sysctl-empty-dir-v1-2-45ba9a6352e8@weissschuh.net>
References: <20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net>
In-Reply-To: <20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708585698; l=3419;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=cR/IG5pmCHIdq4ymlgJjzjZH7hGnhfCNGmfTaQlgx2Q=;
 b=mXTAh1XCV3sH20hmYe/pluA998xG0eK+HatacPk2BM4CJfLqM772dOjRU172Oi9MS6/nsEYW9
 LnrVAjlwabKDyoAi0cWgrqrclnCoeEKm2sif+4xpz3CYvNATXoBnFnl
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

As static initialization of the is not possible anymore move it into
init_header() where all the other header fields are also initialized.

Reduce memory consumption as there are less instances of
ctl_table_header than ctl_table.

Removing this mutable member also opens the way to constify static
instances of ctl_table.

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
2.43.2


