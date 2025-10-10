Return-Path: <linux-fsdevel+bounces-63742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D920BCC8D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 12:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E132D355582
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 10:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32292F3C25;
	Fri, 10 Oct 2025 10:34:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9E12F0C67;
	Fri, 10 Oct 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760092484; cv=none; b=fBJe1UmddO/DKs7LLhMfqeHjaRo+qIcKDNU3ducbDqTYMAvrb7mgHwTJfeBOZcwZXBCoJbsYqOZU2W5BKKy2xF7bo4PVwJKgMlswmWVrVXhnt3mj799funlpauTQ1hU1BiYUvcy+RjBA68N717Kpl+91z40Q7MH0fhdcitDA3yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760092484; c=relaxed/simple;
	bh=mbJmM6BNJHUabh4u8YeL3sdf4tyrULCGkseO9tryUd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbIADS3iwLP0eintOx2W2Q6hoRDUzDscQWe3LP8lELQzcsHop+1838hn/stz11Hj9ff2C5iN6uWE8BylMnFHqUw00oGGTjYPYtC0C6Y0pyYhwpe8hgUXZ4xiohCnMt0eW+UF9+4k9/vAPFZ7H2o+7Ppcby9ktukNt77+O/+gLAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cjjlX1QL5zYQvLF;
	Fri, 10 Oct 2025 18:34:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 604FD1A1441;
	Fri, 10 Oct 2025 18:34:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgCHS2Ms4ehoxOK5CQ--.63632S9;
	Fri, 10 Oct 2025 18:34:34 +0800 (CST)
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
Subject: [PATCH v3 05/12] ext4: use EXT4_B_TO_LBLK() in mext_check_arguments()
Date: Fri, 10 Oct 2025 18:33:19 +0800
Message-ID: <20251010103326.3353700-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251010103326.3353700-1-yi.zhang@huaweicloud.com>
References: <20251010103326.3353700-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHS2Ms4ehoxOK5CQ--.63632S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1fCFy3CrW5ur1rZry8Grg_yoW8GF1Dp3
	WIyan5C3yqqa4Y9w109F1Iv348Ka1xGr47XrWfJr4UWay0kFyFgF15Kan8Aa4jqrWkJ34r
	ZFn2kr17Xw15G3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Switch to using EXT4_B_TO_LBLK() to calculate the EOF position of the
origin and donor inodes, instead of using open-coded calculations.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/move_extent.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 0f4b7c89edd3..6175906c7119 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -461,12 +461,6 @@ mext_check_arguments(struct inode *orig_inode,
 		     __u64 donor_start, __u64 *len)
 {
 	__u64 orig_eof, donor_eof;
-	unsigned int blkbits = orig_inode->i_blkbits;
-	unsigned int blocksize = 1 << blkbits;
-
-	orig_eof = (i_size_read(orig_inode) + blocksize - 1) >> blkbits;
-	donor_eof = (i_size_read(donor_inode) + blocksize - 1) >> blkbits;
-
 
 	if (donor_inode->i_mode & (S_ISUID|S_ISGID)) {
 		ext4_debug("ext4 move extent: suid or sgid is set"
@@ -526,6 +520,9 @@ mext_check_arguments(struct inode *orig_inode,
 			orig_inode->i_ino, donor_inode->i_ino);
 		return -EINVAL;
 	}
+
+	orig_eof = EXT4_B_TO_LBLK(orig_inode, i_size_read(orig_inode));
+	donor_eof = EXT4_B_TO_LBLK(donor_inode, i_size_read(donor_inode));
 	if (orig_eof <= orig_start)
 		*len = 0;
 	else if (orig_eof < orig_start + *len - 1)
-- 
2.46.1


