Return-Path: <linux-fsdevel+bounces-15117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D31A2887196
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 18:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7BB282BA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 17:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A975FDA8;
	Fri, 22 Mar 2024 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iQny1SKi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75BD5D75F;
	Fri, 22 Mar 2024 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127167; cv=none; b=CFab3naLbsnP4MwWmQIWHO3hfj9AnujXoYY9ST1xRqJ6Sd9D0KpRBnWCBUSZRPJdbYipwkRATA7U3IXPdKqHLAF8lCsH/fsBnOedUlB2n01CublcyAolYKUD/HDm8+QXmWF1Ylm3yQKmdgOEctNvrRPdZcfVwK+3gY6FBB4pRRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127167; c=relaxed/simple;
	bh=UNKfueCHNBcmXRHOtTAvJsS3aYDsMC1mej59C9wE9T8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J4OGxzDW1zSECvuTycu3qJxusy1kDzTFm1hn0pmXcy7XkSrRkeprBGJz4CIz0yGPNNYpE0+PypDBncj6caq4xBPsaDlPN3qJWdJ/NT3ZSdYl/Cl1g9rwNPMNgjbvPLEQzpJAWL2fZpcdCarHZfmrl/g9l6FnQ7D0GfssXOLanlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iQny1SKi; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1711127160;
	bh=UNKfueCHNBcmXRHOtTAvJsS3aYDsMC1mej59C9wE9T8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iQny1SKi+jtKTEA3LueQvoHYfTtxHWpeo92cQQ4OBMF1kOBAbiHy2zciRaL1HQwju
	 BnKdgTXx2QNKvT7ZjfZtRSEGJJMOs3RQWIWwNN/XIlKdBBBg+/wFpEuVeaf1E+p24U
	 O91a9sCeKmiuAZD//CWdJiaEr1JAuaWNYfVSPM2g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 22 Mar 2024 18:05:56 +0100
Subject: [PATCH v2 1/3] sysctl: drop sysctl_is_perm_empty_ctl_table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240322-sysctl-empty-dir-v2-1-e559cf8ec7c0@weissschuh.net>
References: <20240322-sysctl-empty-dir-v2-0-e559cf8ec7c0@weissschuh.net>
In-Reply-To: <20240322-sysctl-empty-dir-v2-0-e559cf8ec7c0@weissschuh.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711127159; l=2025;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=UNKfueCHNBcmXRHOtTAvJsS3aYDsMC1mej59C9wE9T8=;
 b=5fseNA5fs6C4QJ0MV+zpKMytFpZsRbKFlT5V4AVL7WSkldAQxOgU2euTtH345bsAfsYEJzy5B
 /x+5sR4hOklDM03BMarh0YPulieYYd6zNDhfTS2c9l/tI1KVZ75l8bu
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

It is used only twice and those callers are simpler with
sysctl_is_perm_empty_ctl_header().
So use this sibling function.

This is part of an effort to constify definition of struct ctl_table.
For this effort the mutable member 'type' is moved from
struct ctl_table to struct ctl_table_header.
Unifying the macros sysctl_is_perm_empty_ctl_* makes this easier.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 37cde0efee57..2f4d4329d83d 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -48,10 +48,8 @@ struct ctl_table_header *register_sysctl_mount_point(const char *path)
 }
 EXPORT_SYMBOL(register_sysctl_mount_point);
 
-#define sysctl_is_perm_empty_ctl_table(tptr)		\
-	(tptr[0].type == SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
 #define sysctl_is_perm_empty_ctl_header(hptr)		\
-	(sysctl_is_perm_empty_ctl_table(hptr->ctl_table))
+	(hptr->ctl_table[0].type == SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
 #define sysctl_set_perm_empty_ctl_header(hptr)		\
 	(hptr->ctl_table[0].type = SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
 #define sysctl_clear_perm_empty_ctl_header(hptr)	\
@@ -233,7 +231,7 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 
 	/* Am I creating a permanently empty directory? */
 	if (header->ctl_table_size > 0 &&
-	    sysctl_is_perm_empty_ctl_table(header->ctl_table)) {
+	    sysctl_is_perm_empty_ctl_header(header)) {
 		if (!RB_EMPTY_ROOT(&dir->root))
 			return -EINVAL;
 		sysctl_set_perm_empty_ctl_header(dir_h);
@@ -1204,7 +1202,7 @@ static bool get_links(struct ctl_dir *dir,
 	struct ctl_table *entry, *link;
 
 	if (header->ctl_table_size == 0 ||
-	    sysctl_is_perm_empty_ctl_table(header->ctl_table))
+	    sysctl_is_perm_empty_ctl_header(header))
 		return true;
 
 	/* Are there links available for every entry in table? */

-- 
2.44.0


