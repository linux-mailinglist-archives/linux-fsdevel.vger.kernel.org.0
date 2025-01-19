Return-Path: <linux-fsdevel+bounces-39598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B28EBA1600A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 04:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C0816595A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 03:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6DB7DA8C;
	Sun, 19 Jan 2025 03:00:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id AEF37125DF;
	Sun, 19 Jan 2025 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737255604; cv=none; b=SBDPaVzSO8RVtOL3UW33kl1rB8YPRf2jGeEkIPPxy3yTntLqFVHa2dV9kywauK1CBqHb2ms1pBA2ll2LumZZF5SQxzWwOTHRlCRWz/KKjz6PWCo54hBCyKS6nzihzMn7grx86zQ2nQn0Er1KdsdosClNUG/nTKGwQYPDJBJdSHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737255604; c=relaxed/simple;
	bh=KyMUxEzpigFw6/QYlXrdLpbhGCPNQRzhJr0vWnUDxOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EtuZfC8KbZrgP/TyH8YoxVkml9DWoKnITiaf1TvYy3nQ9OSBdIMGxLCG3BgY3txD6fZ8SVA45+HKnwFgkMFsTVE7qNzAUNWWbl7l9ZlAsJw/rzviihv/Try3Z6Xtb3zA5Dx1kkAsu80ON1539RH9g/vBzB5Jmd24Zx5qoVieWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id DCB5760106CF9;
	Sun, 19 Jan 2025 10:59:56 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/stat.c: avoid harmless garbage value problem in vfs_statx_path()
Date: Sun, 19 Jan 2025 10:59:47 +0800
Message-Id: <20250119025946.1168957-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang static checker(scan-build) warning:
fs/stat.c:287:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  287 |                 stat->result_mask |= STATX_MNT_ID_UNIQUE;
      |                 ~~~~~~~~~~~~~~~~~ ^
fs/stat.c:290:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  290 |                 stat->result_mask |= STATX_MNT_ID;

When vfs_getattr() failed because of security_inode_getattr(), 'stat' is
uninitialized. In this case, there is a harmless garbage problem in
vfs_statx_path(). It's better to return error directly when
vfs_getattr() failed, avoiding garbage value and more clearly.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 fs/stat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index 0870e969a8a0..14eb3d01d98a 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -281,6 +281,8 @@ static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
 			  u32 request_mask)
 {
 	int error = vfs_getattr(path, stat, request_mask, flags);
+	if (error)
+		return error;
 
 	if (request_mask & STATX_MNT_ID_UNIQUE) {
 		stat->mnt_id = real_mount(path->mnt)->mnt_id_unique;
@@ -302,7 +304,7 @@ static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
 	if (S_ISBLK(stat->mode))
 		bdev_statx(path, stat, request_mask);
 
-	return error;
+	return 0;
 }
 
 static int vfs_statx_fd(int fd, int flags, struct kstat *stat,
-- 
2.30.2


