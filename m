Return-Path: <linux-fsdevel+bounces-7201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB6A822DC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEAE2841B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88691B296;
	Wed,  3 Jan 2024 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thfgqDA0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315161B28C;
	Wed,  3 Jan 2024 12:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9E4C433C8;
	Wed,  3 Jan 2024 12:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286570;
	bh=P3DXc6r93q4e/bSDxN5TyqBmcIjNYn5UWCDVsifWszU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=thfgqDA09nh49/RzY8JNhY3zhkwtaXlvzDntgW5a+G6oNUs6Nz4X+EWp7t7nHlfnh
	 4trCXGreQqQ/h6jtRRh0GOUYmZ92VT9a29v6xgLB2wWpe2jkQFFPryP6V0q+RWbW5N
	 O6dv2578mO7wfV9h3SI21aN1hPIgO/pHyIMysdMUCsY3AQluWdFgcyQHhmSL1jKhku
	 KpJrPXUY5jCTz5hMVi6nOAGHA36u5IqRyahYpYmJWWw8W5xzVfRODXuGDKagYweeWV
	 9/5QrK1zx+t2qv+F5vPFqoGkwo/FtmaFfUU9+Slx2mxdNnTloQHxvGTD/JfUisoqbA
	 fjqt3ZxpacedA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:18 +0100
Subject: [PATCH RFC 20/34] erofs: port device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-20-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=3160; i=brauner@kernel.org;
 h=from:subject:message-id; bh=P3DXc6r93q4e/bSDxN5TyqBmcIjNYn5UWCDVsifWszU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbTdN0dE2n/XlVUHnI17a9X3yjALbeX/pvjP92371
 XuNbdm1HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5coXhv8t//Ui5vxnTV62T
 i2Q7yxK10XhX8F1Xg7BiYT/ugJM7oxj+GX48/V2er07fYv3HqltnlM/tW7Eo4Okq3pCwlA0P/+a
 bsQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/erofs/data.c     |  6 +++---
 fs/erofs/internal.h |  2 +-
 fs/erofs/super.c    | 16 ++++++++--------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index c98aeda8abb2..fed9153f2b83 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -220,7 +220,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return 0;
 		}
-		map->m_bdev = dif->bdev_handle ? dif->bdev_handle->bdev : NULL;
+		map->m_bdev = dif->f_bdev ? F_BDEV(dif->f_bdev) : NULL;
 		map->m_daxdev = dif->dax_dev;
 		map->m_dax_part_off = dif->dax_part_off;
 		map->m_fscache = dif->fscache;
@@ -238,8 +238,8 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
 				map->m_pa -= startoff;
-				map->m_bdev = dif->bdev_handle ?
-					      dif->bdev_handle->bdev : NULL;
+				map->m_bdev = dif->f_bdev ?
+					      F_BDEV(dif->f_bdev) : NULL;
 				map->m_daxdev = dif->dax_dev;
 				map->m_dax_part_off = dif->dax_part_off;
 				map->m_fscache = dif->fscache;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b0409badb017..8ad8957de64c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -49,7 +49,7 @@ typedef u32 erofs_blk_t;
 struct erofs_device_info {
 	char *path;
 	struct erofs_fscache *fscache;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3789d6224513..bc0772445ad5 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -171,7 +171,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_fscache *fscache;
 	struct erofs_deviceslot *dis;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	void *ptr;
 
 	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *pos), EROFS_KMAP);
@@ -195,12 +195,12 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
 	} else if (!sbi->devs->flatdev) {
-		bdev_handle = bdev_open_by_path(dif->path, BLK_OPEN_READ,
+		f_bdev = bdev_file_open_by_path(dif->path, BLK_OPEN_READ,
 						sb->s_type, NULL);
-		if (IS_ERR(bdev_handle))
-			return PTR_ERR(bdev_handle);
-		dif->bdev_handle = bdev_handle;
-		dif->dax_dev = fs_dax_get_by_bdev(bdev_handle->bdev,
+		if (IS_ERR(f_bdev))
+			return PTR_ERR(f_bdev);
+		dif->f_bdev = f_bdev;
+		dif->dax_dev = fs_dax_get_by_bdev(F_BDEV(f_bdev),
 				&dif->dax_part_off, NULL, NULL);
 	}
 
@@ -748,8 +748,8 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 	struct erofs_device_info *dif = ptr;
 
 	fs_put_dax(dif->dax_dev, NULL);
-	if (dif->bdev_handle)
-		bdev_release(dif->bdev_handle);
+	if (dif->f_bdev)
+		fput(dif->f_bdev);
 	erofs_fscache_unregister_cookie(dif->fscache);
 	dif->fscache = NULL;
 	kfree(dif->path);

-- 
2.42.0


