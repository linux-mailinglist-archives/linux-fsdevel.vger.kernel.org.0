Return-Path: <linux-fsdevel+bounces-8565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FAF839012
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29021F221FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D9460EE4;
	Tue, 23 Jan 2024 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MM8rPQWD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4A60ECD;
	Tue, 23 Jan 2024 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016467; cv=none; b=V92LkYpLWZaxte+I9EEmGAjOqrCdSl50jql+sf+0rsO3P378VBes10lUfJ/c7CGn2+TzriM29FUPcqsgub502ZdUbMTzgF109x6VaMwEK09Bmu2kqDrN1o2MKeQUXrG07aBTf9Bhu+L4DYtnCbmPJtK83wRjDoaxTCj6tcWAJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016467; c=relaxed/simple;
	bh=0Ste0MfMG6DdZ4HR2aJYpYgdnL9rMRG/HPBFV6aC8fE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o7WtuORY8kaNH8gvuOpubP0bVCbz9e7u1W4biCdR9p3/mxfia5wST2TLtIewlm9oFl3tVPjO+5vfldOWoPDIxC0ec5gdEAYP6GvnCiEehgFRfdsLvOWhzXlynPS0jkiNaPM6hJOeYIPgSq7+flnTGeBPi+SDP+Ief9OnrPrngGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MM8rPQWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7246FC43390;
	Tue, 23 Jan 2024 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016467;
	bh=0Ste0MfMG6DdZ4HR2aJYpYgdnL9rMRG/HPBFV6aC8fE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MM8rPQWDaOkXW2bY7AsMjhToTbK+0n5oerO00WDGvuOqw8rRJZCAgcoJHIAHKkEwz
	 08B7xVPtUT3YdOnG1tAuiWq9yUyEzh0aJHlepQyGfs24YHi8eM4NBsEzVDJuphG9YH
	 lB1Kh3Gby3Fyl1uPO3bItI4BDhkJIMVzG715/MCh3N1SI9JcPF2KgxzcG0du+8z2Jk
	 c3FWJt1WiYWOr/LS4QXEUaDRz1KhBLbdhDyHYeltJSQqjsU10H9dQZ9so81ghWR3Ze
	 88DZ7Csh9xYPF5tgQOmMh8UG7E1EU/BRRzAWHSQAQVPCQiN67ePg3G+4LsSjb64CKz
	 qz9sd5g3+SnrQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:37 +0100
Subject: [PATCH v2 20/34] erofs: port device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-20-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=3211; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0Ste0MfMG6DdZ4HR2aJYpYgdnL9rMRG/HPBFV6aC8fE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37dAOd07uXfVjNtmr3uFZis9q0kvtPkp4yfXd3HO5
 /KwxLM3O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbC9peR4RIv15+Mt/OZLO49
 jX9x99o1Gd86qRe75fv4LtXJs9ZO+8rIMK1bzbr5eMmK4AU/2F3ZxYpnrdFbbzxP1zl++Yng4s8
 qnAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/erofs/data.c     |  6 +++---
 fs/erofs/internal.h |  2 +-
 fs/erofs/super.c    | 16 ++++++++--------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index c98aeda8abb2..433fc39ba423 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -220,7 +220,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return 0;
 		}
-		map->m_bdev = dif->bdev_handle ? dif->bdev_handle->bdev : NULL;
+		map->m_bdev = dif->bdev_file ? file_bdev(dif->bdev_file) : NULL;
 		map->m_daxdev = dif->dax_dev;
 		map->m_dax_part_off = dif->dax_part_off;
 		map->m_fscache = dif->fscache;
@@ -238,8 +238,8 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
 				map->m_pa -= startoff;
-				map->m_bdev = dif->bdev_handle ?
-					      dif->bdev_handle->bdev : NULL;
+				map->m_bdev = dif->bdev_file ?
+					      file_bdev(dif->bdev_file) : NULL;
 				map->m_daxdev = dif->dax_dev;
 				map->m_dax_part_off = dif->dax_part_off;
 				map->m_fscache = dif->fscache;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b0409badb017..0f0706325b7b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -49,7 +49,7 @@ typedef u32 erofs_blk_t;
 struct erofs_device_info {
 	char *path;
 	struct erofs_fscache *fscache;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 5f60f163bd56..9b4b66dcdd4f 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -177,7 +177,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_fscache *fscache;
 	struct erofs_deviceslot *dis;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	void *ptr;
 
 	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *pos), EROFS_KMAP);
@@ -201,12 +201,12 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
 	} else if (!sbi->devs->flatdev) {
-		bdev_handle = bdev_open_by_path(dif->path, BLK_OPEN_READ,
+		bdev_file = bdev_file_open_by_path(dif->path, BLK_OPEN_READ,
 						sb->s_type, NULL);
-		if (IS_ERR(bdev_handle))
-			return PTR_ERR(bdev_handle);
-		dif->bdev_handle = bdev_handle;
-		dif->dax_dev = fs_dax_get_by_bdev(bdev_handle->bdev,
+		if (IS_ERR(bdev_file))
+			return PTR_ERR(bdev_file);
+		dif->bdev_file = bdev_file;
+		dif->dax_dev = fs_dax_get_by_bdev(file_bdev(bdev_file),
 				&dif->dax_part_off, NULL, NULL);
 	}
 
@@ -754,8 +754,8 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 	struct erofs_device_info *dif = ptr;
 
 	fs_put_dax(dif->dax_dev, NULL);
-	if (dif->bdev_handle)
-		bdev_release(dif->bdev_handle);
+	if (dif->bdev_file)
+		fput(dif->bdev_file);
 	erofs_fscache_unregister_cookie(dif->fscache);
 	dif->fscache = NULL;
 	kfree(dif->path);

-- 
2.43.0


