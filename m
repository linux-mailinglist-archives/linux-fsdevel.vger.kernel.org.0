Return-Path: <linux-fsdevel+bounces-15118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D6C88719B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 18:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774DF1C235EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F63A5FF0E;
	Fri, 22 Mar 2024 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TmF/Wipx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7AC5D8F0;
	Fri, 22 Mar 2024 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127168; cv=none; b=JPI0sQtZHpucV3EIHUIeA5/J1Y+XqSN94tcH6z67GA/1c0hOZe9rd6EacKHq0+GI7F+bKA8uwboszK5O0vshvWyNP0pASXkX3cT/lgPKft35IVGHVrEOAJMGdmYkbz5A4cj5wc54BjksljO/4UP7JeDQOenImd+rPMcgr/l7K5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127168; c=relaxed/simple;
	bh=pKWmydccD60+SiYR6pnPoIGUdo4mn6q9g3JBlH5dGg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PY/HDjZV+w/J5+LbLCLZQYzWtW5LT4/MJUyQcMscEpf7oNdbkmTEmZs4J89TNYPU/b84H7TFj214bOmOpjZru9aSevR8esoGfB/KecPORZlHYTAmYWEWUryvf6xyuDnep95YnGua10K4rq/ypeOMdCcTjecGqwCIMtgO680ynr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TmF/Wipx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1711127160;
	bh=pKWmydccD60+SiYR6pnPoIGUdo4mn6q9g3JBlH5dGg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TmF/WipxHKHJanklGRgo/cD7B2NyM0Bu+uXwRPyXWnATzoI9fzXN2RHFXkKEeYuTB
	 Yek9tMJ+eLVIzfLTTOJeOa1NZLa2LoGLgGHy73oZlTIp22u3Nm/kPfA1+DbuScUDKq
	 TOy2rEgVBCFr6TWSgDCd35tEB0kqLoL2VDr2q9Ng=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 22 Mar 2024 18:05:58 +0100
Subject: [PATCH v2 3/3] sysctl: drop now unnecessary out-of-bounds check
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240322-sysctl-empty-dir-v2-3-e559cf8ec7c0@weissschuh.net>
References: <20240322-sysctl-empty-dir-v2-0-e559cf8ec7c0@weissschuh.net>
In-Reply-To: <20240322-sysctl-empty-dir-v2-0-e559cf8ec7c0@weissschuh.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711127159; l=1390;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=pKWmydccD60+SiYR6pnPoIGUdo4mn6q9g3JBlH5dGg4=;
 b=e2QXcJQf+5J7TWOe5KTw0NSnhPXCh5BNorgGtCKLWzMkZ4ieztJk+0p9kVHGW8OEWOzmZtSik
 x4WRtM13pd/BmJ+gbkFlP00GzXbeRd6PvpkRta6m+vFWl3C1lhrFNHj
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Remove the now unneeded check for ctl_table_size; it is safe
to do so as sysctl_set_perm_empty_ctl_header() does not access the
ctl_table member anymore.

This also makes the element of sysctl_mount_point unnecessary, so drop
it at the same time.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index fde7a2f773f0..7c0e27dc3d9d 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -30,9 +30,7 @@ static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
 /* Support for permanently empty directories */
-static struct ctl_table sysctl_mount_point[] = {
-	{ }
-};
+static struct ctl_table sysctl_mount_point[] = { };
 
 /**
  * register_sysctl_mount_point() - registers a sysctl mount point
@@ -232,8 +230,7 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 		return -EROFS;
 
 	/* Am I creating a permanently empty directory? */
-	if (header->ctl_table_size > 0 &&
-	    sysctl_is_perm_empty_ctl_header(header)) {
+	if (sysctl_is_perm_empty_ctl_header(header)) {
 		if (!RB_EMPTY_ROOT(&dir->root))
 			return -EINVAL;
 		sysctl_set_perm_empty_ctl_header(dir_h);

-- 
2.44.0


