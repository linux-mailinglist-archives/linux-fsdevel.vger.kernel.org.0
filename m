Return-Path: <linux-fsdevel+bounces-22421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F144C916F9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 19:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEFE1B242FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F05117B513;
	Tue, 25 Jun 2024 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="N8E4q7Lp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0A7176ABC;
	Tue, 25 Jun 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337921; cv=none; b=FGMirkI6xisohdTge3E6NKK2eVMD+CyeqGFHgCDuIF9PoFJvW4CUd2a2rbEOpeBI+oaC4TWhCPece77NTLvZgyO1PzHC3uC15MmjmCoLbUNfrvg8xLDgDy9stGh1JCiDe/BZSp7Mjg52bMmC9V5Zj69hs4NeB8Oj4B69Jblao4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337921; c=relaxed/simple;
	bh=mztnKDUfv3MVWNEqial7pd6AhpX2wGYUuHCwargNepo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EpR/A+dgEWWuqAHnj7Ok+STEqM+kRk1LxsKelhNvCKyymLQLKEAguprClJY6lWjOyZ/G9LzMHliLP55CGazwoGIt1xAJ6oQymHIlVReLv5aZT8Py5cFQyaFQhZitZCL3cAG29vlKLyQPRihcDt8As7I6o33PkgnCI2T7nF+/laQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=N8E4q7Lp; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=khnUJHqlUttp4A9nzaPS54+2lf54pAfsWRq9a5hBfSI=; b=N8E4q7LpXAkpKvgO5APaWVwXfr
	CCNbeEWtMkKd0lIXsV7BZ+2VMw+g2nzeoJJfWdj/dffMgoxsYhvmYTorbPPp4NcfR4sDHR/+hfJpZ
	1+YdwivJU/7Ko/TjUPcnYzitYI/NMazJdipgDuf7mWz0N3YI++trtsnyeGILPtCkWiTAOpi+5fLJi
	Z9hWpOVx4GguoHCFbMAwp+isHDuxfShYOOci9S8Z/ETK2NtokLxEbv9dxagL5YEs/a1YvcEYSHUkl
	PhvFgHjGX+7NWfhH6BqeCZdA503ZyfUMqunIyR3/XuixM4l2GbS6uArSu2inlYBLrYtsw91y+V1nz
	D0bpfcpg==;
Received: from 179-125-70-190-dinamico.pombonet.net.br ([179.125.70.190] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sMAKi-007Oa3-ND; Tue, 25 Jun 2024 19:51:57 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-fsdevel@vger.kernel.org
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>,
	dlunev@chromium.org,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH v2 2/2] fat: always use dir_emit_dots and ignore . and .. entries
Date: Tue, 25 Jun 2024 14:51:33 -0300
Message-Id: <20240625175133.922758-3-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625175133.922758-1-cascardo@igalia.com>
References: <20240625175133.922758-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of only using dir_emit_dots for the root inode and explictily
requiring the . and .. entries to emit them, use dir_emit_dots for all
directories.

That allows filesystems with directories without the . or .. entries to
still show them.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/fat/dir.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 4e4a359a1ea3..e70781569de5 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -583,15 +583,14 @@ static int __fat_readdir(struct inode *inode, struct file *file,
 	mutex_lock(&sbi->s_lock);
 
 	cpos = ctx->pos;
-	/* Fake . and .. for the root directory. */
-	if (inode->i_ino == MSDOS_ROOT_INO) {
-		if (!dir_emit_dots(file, ctx))
-			goto out;
-		if (ctx->pos == 2) {
-			fake_offset = 1;
-			cpos = 0;
-		}
+
+	if (!dir_emit_dots(file, ctx))
+		goto out;
+	if (ctx->pos == 2) {
+		fake_offset = 1;
+		cpos = 0;
 	}
+
 	if (cpos & (sizeof(struct msdos_dir_entry) - 1)) {
 		ret = -ENOENT;
 		goto out;
@@ -671,13 +670,8 @@ static int __fat_readdir(struct inode *inode, struct file *file,
 	if (fake_offset && ctx->pos < 2)
 		ctx->pos = 2;
 
-	if (!memcmp(de->name, MSDOS_DOT, MSDOS_NAME)) {
-		if (!dir_emit_dot(file, ctx))
-			goto fill_failed;
-	} else if (!memcmp(de->name, MSDOS_DOTDOT, MSDOS_NAME)) {
-		if (!dir_emit_dotdot(file, ctx))
-			goto fill_failed;
-	} else {
+	if (memcmp(de->name, MSDOS_DOT, MSDOS_NAME) &&
+	    memcmp(de->name, MSDOS_DOTDOT, MSDOS_NAME)) {
 		unsigned long inum;
 		loff_t i_pos = fat_make_i_pos(sb, bh, de);
 		struct inode *tmp = fat_iget(sb, i_pos);
-- 
2.34.1


