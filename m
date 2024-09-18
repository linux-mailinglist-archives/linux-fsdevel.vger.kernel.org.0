Return-Path: <linux-fsdevel+bounces-29659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C117597BDD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DB0285F17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0978218C90F;
	Wed, 18 Sep 2024 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YshBiDlJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583FD18B470;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668769; cv=none; b=kiTZ4RcWXZ+PnXIdsC/HYBR2eZhJMRFJnDjBVtYztdKygKeBloddNKPmWymZsa3hCRHK0S+AplaNm2T+R3WVwpsdCBn1a0ik4wOoIvd0EO7iRuWtThh2hy5AfVWjYcbduUpBW0BD5F4CcBgtbza9bthzpwWFbhC7MNhAcmEcBAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668769; c=relaxed/simple;
	bh=8/JtWAjFO16OAT7HzPLupeSOnXwBE9QA6QRe0YA3btw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YnqMyrxOu0eQO/mB94xei5LDbEj83Q27eTNZlPurTyZyZaW93G+UXPS+VrXcsTXK8suZ0XfGYr+IkvTH6xNuJRxhjBmpAaIt8LcwcGlPhMdXXkbiTD2P2yoQVTZtK7Fospr9DwNlGiDYyIjgrs4hr1oKSEP+utAb23xkvUZvHYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YshBiDlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03845C4CED0;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668769;
	bh=8/JtWAjFO16OAT7HzPLupeSOnXwBE9QA6QRe0YA3btw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YshBiDlJBWRcM2Xg4LaZE1YdVQG9RhJub2ctPazP64QAfvzhHwezMV5uAV+wvggab
	 wZ7sPrTsPBEnZPfgoXWhF+pHx/AWyC6N9uLXRce28GqiIiA6fhu/DunbfNwP32MOpp
	 W9QDyD6GIM2DUTI4NwEi/x5qjIPYvZgW0h8pPDr+ajCGCTVJVPpf48EHWYR4onmQMH
	 TeQLEUcrcYEUMhW/FEY/waTHQ/0gok7yDwn4sVVUaGSfdvgq91GrbuIzEy7TrLh0oa
	 CyjzCmh/+jPE8Pt+gnAKoM6N7DiGqp9qkm8jZ/XDGt4wl1qyM822xLg2lzMW6Qj8iR
	 /k+4AXuNvfhDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E960CCCD1B7;
	Wed, 18 Sep 2024 14:12:48 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:12:21 +0800
Subject: [PATCH v5.4-v4.19 2/6] fs: move vfs_fstatat out of line
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-5-4-y-v1-2-8a771c9bbe5f@gmail.com>
References: <20240918-statx-stable-linux-5-4-y-v1-0-8a771c9bbe5f@gmail.com>
In-Reply-To: <20240918-statx-stable-linux-5-4-y-v1-0-8a771c9bbe5f@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>, 
 Christoph Hellwig <hch@lst.de>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2373;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=cAg8g3RAmbShO+C0L2Soe5vWdpoEVWcVWpevQzMAjzM=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t/d3qqZqYy7HcKahGMFY3/BnO547a2jJCq09
 UewNTOwimiJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurf3QAKCRCwMePKe/7Z
 bm75EACQv0fUl953s50IWGUBZ54obM/Msu+o0PNBzgKXSOys4Jdoazs4hERyM/YpsSR/A/3CrkI
 s3dJss1HUMmZjvvgEwEY0zcH6bhlkdyN7Wbde9RY8S+lgRRUmjoy0RD+EzthEdg55JoYBo/iIe5
 Bf6q6qAqjcQEty+/KKGnOZ7XQnCLDDeVnth/HRo/Eo+/fb3S3ps2G8e8bvIUt1jLfW90eBkRSrS
 XnI2zuzBQOR1ibE2GxvlgAZaKfiuirjfCnAmra11d9PQZs6k/M2sPLL5lJhnNGKjk367d/8/Rpc
 M/R+mI/HGpqLO3vZ5g+35BPrOxEfoxXmTDbPTgvwDPxAKZa2yZshNM3csq+xe076TtWW4U+7prH
 IP6AnElgntY+a4av17iu+sK8Q10116/doQQ3EIYkZY2z7euw6AqUGMLHTvDDzyxEvjiWIOSXD5m
 R+tdLzoSDA5V25xb7VUgqVhYqWA2MLespH5ueD9oiuermAJXCtHt/xNy9vOy8KmfqBaZzraI4FC
 lrDO+o8J92cM61necDwMkbE6FyNIwf1+gMoa7lZ1kI5oSqRpw4a/G6Ow3pFm6RiGNI16Oeyv+x7
 +LOBIs+K1pZ7XybbtgwitE3YU1NMnie61Y6mkY8b/yYzdXOz5jYYD1JbLXURXJvfbmGa0m4UqR/
 F+MVWfE4JzzcJzg==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

From: Christoph Hellwig <hch@lst.de>

commit 09f1bde upstream.

This allows to keep vfs_statx static in fs/stat.c to prepare for the following
changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Cc: <stable@vger.kernel.org> # 4.19.x-5.4.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 fs/stat.c          |  9 +++++++--
 include/linux/fs.h | 10 +++-------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 268c9eb89656..b09a0e2a6681 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -165,7 +165,7 @@ EXPORT_SYMBOL(vfs_statx_fd);
  *
  * 0 will be returned on success, and a -ve error code if unsuccessful.
  */
-int vfs_statx(int dfd, const char __user *filename, int flags,
+static int vfs_statx(int dfd, const char __user *filename, int flags,
 	      struct kstat *stat, u32 request_mask)
 {
 	struct path path;
@@ -197,8 +197,13 @@ int vfs_statx(int dfd, const char __user *filename, int flags,
 out:
 	return error;
 }
-EXPORT_SYMBOL(vfs_statx);
 
+int vfs_fstatat(int dfd, const char __user *filename,
+			      struct kstat *stat, int flags)
+{
+	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
+			 stat, STATX_BASIC_STATS);
+}
 
 #ifdef __ARCH_WANT_OLD_STAT
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2db4e5f7d00b..952f103be4a0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3259,20 +3259,16 @@ extern const struct inode_operations simple_symlink_inode_operations;
 
 extern int iterate_dir(struct file *, struct dir_context *);
 
-extern int vfs_statx(int, const char __user *, int, struct kstat *, u32);
 extern int vfs_statx_fd(unsigned int, struct kstat *, u32, unsigned int);
 
-static inline int vfs_fstatat(int dfd, const char __user *filename,
-			      struct kstat *stat, int flags)
-{
-	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
-			 stat, STATX_BASIC_STATS);
-}
 static inline int vfs_fstat(int fd, struct kstat *stat)
 {
 	return vfs_statx_fd(fd, stat, STATX_BASIC_STATS, 0);
 }
 
+int vfs_fstatat(int dfd, const char __user *filename, struct kstat *stat,
+		int flags);
+
 static inline int vfs_stat(const char __user *filename, struct kstat *stat)
 {
 	return vfs_fstatat(AT_FDCWD, filename, stat, 0);

-- 
2.43.0



