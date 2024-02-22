Return-Path: <linux-fsdevel+bounces-12519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 906C58603AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 21:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3A61C24A9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 20:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB8C71747;
	Thu, 22 Feb 2024 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JGZc1gqk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F325C29CEA;
	Thu, 22 Feb 2024 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633843; cv=none; b=XTV5ZlyFKumEBfyILuZbHIPMMMc51vcPETUmQzOd3Waz9Qks+x4Q8MUsnDVuUbUL/LaQSJV/DLRVt0YaF4qeJfr8tz8yw/wPhbrzL9kXm4ZsimAIkOBe/NLRLiZ9ZaAW5qQOJwGGDknNV7n2fFHw+0+HPBLSLEok1XZ6mK8TG2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633843; c=relaxed/simple;
	bh=PGw/6elJRjzjT5oami1yJD74wKwg8urvYRLz170UPWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a0gMP9lMZvuMcpFVCY6yzKw8SuTGC80XtmjIlCuWbBs7LzpMGoAtdxoI5gwFy5tRTNBAfFC/rTRtGnrgHFNwUOOrrvAGklvO0J96m5z4slSmOujeA7rlWktXYdEBLAFfErSUoPcdbyUwRlPiqCqnU/+vYr5Wjen8sEZe3dH8YEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JGZc1gqk; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uDD88zaVrMvSV7jyXIjccldv2PnZ3aOybLZ9ITuOEPM=; b=JGZc1gqkZdMeL5Y4Bsdn/FPyaq
	DFOTfRXZTGmrEQmBgQ5yBj0Dbf9dCT8o6LG1NZ7WjVclxxUFMHtPouewiUtOBODiJaaefLnY6LK74
	wVx+P36s6ULKZM2OqnQX2+63eY3fP4Sda0nDOHVqFGm6/hTL2xwheMFdsp9jSvVN3jeqtddSS9kdS
	wdG7m+AgLId0wB3PGptDb5agHuynLsV9VSrPbxGJIp9pvk7TCbjMGCzM4zx4z6rfRAla3N6mFFSn3
	OSSUPSWcdYyrEPhPB8qnL+l75+Sbcc26ihMXCNfye6Uyh3b391GsEFcx9TNbnV8zAQL5/a+U1wovK
	zRamh19Q==;
Received: from 179-125-75-196-dinamico.pombonet.net.br ([179.125.75.196] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rdFi4-002SRK-9F; Thu, 22 Feb 2024 21:30:24 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>,
	dlunev@chromium.org,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH] fat: ignore .. subdir and always add a link to dirs
Date: Thu, 22 Feb 2024 17:30:13 -0300
Message-Id: <20240222203013.2649457-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tools used for creating images for the Lego Mindstrom EV3 are not
adding '.' and '..' entry in the 'Projects' directory.

Without this fix, the kernel can not fill the inode structure for
'Projects' directory.

See https://github.com/microsoft/pxt-ev3/issues/980
And https://github.com/microsoft/uf2-linux/issues/6

When counting the number of subdirs, ignore .. subdir and add one when
setting the initial link count for directories. This way, when .. is
present, it is still accounted for, and when neither . or .. are present, a
single link is still done, as it should, since this link would be the one
from the parent directory.

With this fix applied, we can mount an image with such empty directories,
access them, create subdirectories and remove them.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
Link: https://lore.kernel.org/all/20220204062232.3410036-1-gwendal@chromium.org/
Cc: dlunev@chromium.org
---
 fs/fat/dir.c   |  3 ++-
 fs/fat/inode.c | 12 +++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 00235b8a1823..fcdb652efc53 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -937,7 +937,8 @@ int fat_subdirs(struct inode *dir)
 	bh = NULL;
 	cpos = 0;
 	while (fat_get_short_entry(dir, &cpos, &bh, &de) >= 0) {
-		if (de->attr & ATTR_DIR)
+		if (de->attr & ATTR_DIR &&
+		    strncmp(de->name, MSDOS_DOTDOT, MSDOS_NAME))
 			count++;
 	}
 	brelse(bh);
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 1fac3dabf130..9a3bd38a4494 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -494,8 +494,14 @@ static int fat_validate_dir(struct inode *dir)
 {
 	struct super_block *sb = dir->i_sb;
 
-	if (dir->i_nlink < 2) {
-		/* Directory should have "."/".." entries at least. */
+	if (dir->i_nlink < 1) {
+		/*
+		 * Though it is expected that directories have at least
+		 * "."/".." entries, there are filesystems in the field that
+		 * don't have either. Even in those cases, at least one link
+		 * is necessary, as otherwise, when trying to increment it,
+		 * VFS would BUG.
+		 */
 		fat_fs_error(sb, "corrupted directory (invalid entries)");
 		return -EIO;
 	}
@@ -534,7 +540,7 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 			return error;
 		MSDOS_I(inode)->mmu_private = inode->i_size;
 
-		set_nlink(inode, fat_subdirs(inode));
+		set_nlink(inode, fat_subdirs(inode) + 1);
 
 		error = fat_validate_dir(inode);
 		if (error < 0)
-- 
2.34.1


