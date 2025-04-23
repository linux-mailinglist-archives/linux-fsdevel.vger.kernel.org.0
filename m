Return-Path: <linux-fsdevel+bounces-47073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F3EA9849D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 11:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA9E1B6294B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0614425C83C;
	Wed, 23 Apr 2025 09:03:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D2C225402;
	Wed, 23 Apr 2025 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399013; cv=none; b=NWx9dfh6H7qI9AG/HCqRFzxxE3ILqerYgGg9+8zh2j8BN9v/DPDbQcFEoCeYp5gDuz8plPoBvGKO39J5RdOVACLiIBIZ7HbPYqdHRd7w2fySqrlvYVUUr4qq/uFZf85m4KwL9lSdBUmGXtt/31iEJVrg8BZWgMZmhgW/x5dHOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399013; c=relaxed/simple;
	bh=WtUwSHuTeaBvjZinOcJftwdviR//LrgtyCp/b0uWmXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSgG6N+AeETnGdAZX7lHwCqhpbI+XdKsi94cPZRU3/nH2sefoIXITgHZUPCnHNZewKPnwdwWxvBczjaZLIlFdnruLmgux/n7kTm+29umAqHCnpF4nzBwQ9zSIw5LJTjJzAublKVPT/wIt8k4yDjl4D1gXBpoeTIy3Fs/ZS44b/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZjCmw5vHtz4f3lDN;
	Wed, 23 Apr 2025 17:02:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4E57F1A1C77;
	Wed, 23 Apr 2025 17:03:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXacPQrAhoJkGrKA--.8976S8;
	Wed, 23 Apr 2025 17:03:22 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 4/9] ext4: prevent stale extent cache entries caused by concurrent fiemap
Date: Wed, 23 Apr 2025 16:52:52 +0800
Message-ID: <20250423085257.122685-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250423085257.122685-1-yi.zhang@huaweicloud.com>
References: <20250423085257.122685-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXacPQrAhoJkGrKA--.8976S8
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF13Kr4ruF1rWF17Ww43trb_yoW8KF13pr
	sI9F98Gr4rX3s5WrZ2qFW8Za4Ska48GrWjy3yfG3ZrZFyUJr40gF1rKFyFyF1Fg3ykAw4Y
	qF40kw1UGa4Uu3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUo73vUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The ext4_fiemap() currently invokes ext4_ext_precache() and
iomap_fiemap() to preload the extent cache and query mapping information
without holding the inode's i_rwsem. This can result in stale extent
cache entries when competing with operations such as
ext4_collapse_range() which calls ext4_ext_remove_space() or
ext4_ext_shift_extents().

The problem arises when ext4_ext_remove_space() temporarily releases
i_data_sem due to insufficient journal credits. During this interval, a
concurrent ext4_fiemap() may cache extent entries that are about to be
deleted. As a result, these cached entries become stale and inconsistent
with the actual extents.

Loading the extents cache without holding the inode's i_rwsem or the
mapping's invalidate_lock is not permitted besides during the writeback.
Fix this by holding the i_rwsem in ext4_fiemap().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 8a5724b2dc51..3adf05fbdd59 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4963,10 +4963,11 @@ int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 {
 	int error = 0;
 
+	inode_lock_shared(inode);
 	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
 		error = ext4_ext_precache(inode);
 		if (error)
-			return error;
+			goto unlock;
 		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
 	}
 
@@ -4977,15 +4978,19 @@ int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	 */
 	error = ext4_fiemap_check_ranges(inode, start, &len);
 	if (error)
-		return error;
+		goto unlock;
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
 		fieinfo->fi_flags &= ~FIEMAP_FLAG_XATTR;
-		return iomap_fiemap(inode, fieinfo, start, len,
-				    &ext4_iomap_xattr_ops);
+		error = iomap_fiemap(inode, fieinfo, start, len,
+				     &ext4_iomap_xattr_ops);
+	} else {
+		error = iomap_fiemap(inode, fieinfo, start, len,
+				     &ext4_iomap_report_ops);
 	}
-
-	return iomap_fiemap(inode, fieinfo, start, len, &ext4_iomap_report_ops);
+unlock:
+	inode_unlock_shared(inode);
+	return error;
 }
 
 int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
-- 
2.46.1


