Return-Path: <linux-fsdevel+bounces-12425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE8985F1CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 08:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B72B24441
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 07:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0432317C74;
	Thu, 22 Feb 2024 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="eqfk8toY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53693F9D3;
	Thu, 22 Feb 2024 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708585706; cv=none; b=DsrkK+uf9J/ZT/bqXUVpWecxZxXd8R88fpULCeihHddkT0LE4FRaw4rq6DSXx8eDW4EDB386EUDRnwNvdX0qA1zNZpOhJ0dGvwMXJjUjfv8HUKLeyP6K6enuppqrUBZff9ZXgwg5nobi7clBGSZmYJGp1fTah9LBTYB6OcAqiRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708585706; c=relaxed/simple;
	bh=rBJrdZIe+s7xK7S2lsli6LzdtB7oW9aF4vhR2l0SL8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4/jtX5oXZ/jBFn/BPf07DWdGEaAbYQ5873E1e6hv5NDpsNonSEKWBSZ3M9fOvSxASd2jVe6CAVxoGszizZs77BNRFCkijlS+mX69OfwjtqHJSS/PHVerBQUowwAIwSYv9G68ZyTMjXtwmPJLk9vFGyViLnobxsHa/KoyNrDZYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=eqfk8toY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1708585697;
	bh=rBJrdZIe+s7xK7S2lsli6LzdtB7oW9aF4vhR2l0SL8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eqfk8toY1el32V/MPrbxgEpdTa0Hpy3mTXhGrT8zRUU/8yQPnZvswvVrDEUBNx/PA
	 w9IXJ5hf+IFzgQ4levuO2YB4QCgEosLFzsLl63iohcoE2ZdFwJtL7+e4LYJXTYoJ/8
	 3RT8r+5HyD9xc45EQBk1Ms4OT8KNlLXROChzhucE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 22 Feb 2024 08:07:36 +0100
Subject: [PATCH 1/4] sysctl: drop sysctl_is_perm_empty_ctl_table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240222-sysctl-empty-dir-v1-1-45ba9a6352e8@weissschuh.net>
References: <20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net>
In-Reply-To: <20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708585698; l=1782;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rBJrdZIe+s7xK7S2lsli6LzdtB7oW9aF4vhR2l0SL8A=;
 b=7oyFr8FNzsmBv8BO9h8IoLO6rz1mnJRIVR631dGxVGtdMKPzisMzyDSluUjqUgS3jCK10TR++
 tx/Y8YJsER3AWg0frDqiiuSIuTyXlCdeDX8NNyuLFXS14z0mnwxQdtT
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

It is used only twice and those callers are simpler with
sysctl_is_perm_empty_ctl_header().
So use this sibling function.

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
2.43.2


