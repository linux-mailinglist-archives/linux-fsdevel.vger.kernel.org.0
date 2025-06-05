Return-Path: <linux-fsdevel+bounces-50734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EF7ACF024
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 15:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7653AD890
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 13:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32581233136;
	Thu,  5 Jun 2025 13:17:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F11E5B95;
	Thu,  5 Jun 2025 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129423; cv=none; b=L/ikGqGfhIuGL4Mnc43hsEbyrbXA9JZ9hdAKGjW4RZxkfc9JEQynjXXy7kdt6oS+1zkqhwDshH+a0qiTeBymrIaaMMspT4qtmXYbLboLRoWcHHZriFDShQ6pSReciHxWJ7yfFuM7Lt13vBnTpjS+zcHJ1I0e9AudrKmHvKPPtKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129423; c=relaxed/simple;
	bh=Rffk9NOkRdkHAyYWHIAj1Dcp+53gJMpF5CccF6Jess4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VddNQhoBwub/6YCeCinUDAZCa6Qg6gR9lze8bZfrirqKeNCf2WZgEAh3TL0I9JNUjYHWw6Hm0+M6Fkdx0yoIqSyq86Ac0qvq0aChGoWcq3OOY/TnoVao9zVJs7UU/R4JwXstEEAfATJCHEYQg1FCL+2heoRRBZ9DYjxgAwGlm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bClND0D1vzYQvgy;
	Thu,  5 Jun 2025 21:17:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 157A31A0DC7;
	Thu,  5 Jun 2025 21:16:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgDnTH3HmEFobD9lOQ--.29489S7;
	Thu, 05 Jun 2025 21:16:58 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: hughd@google.com,
	baolin.wang@linux.alibaba.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/7] mm: shmem: wrap additional shmem quota related code with CONFIG_TMPFS_QUOTA
Date: Fri,  6 Jun 2025 06:10:35 +0800
Message-Id: <20250605221037.7872-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250605221037.7872-1-shikemeng@huaweicloud.com>
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnTH3HmEFobD9lOQ--.29489S7
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyUur4DuFyfKFWxKrWUtwb_yoWrJw13pF
	n7Grs8GFWUXFy0krWxur4furyftFWfGr1xtrWDKw1Yy3Wv9w1SgF1xKF1Yvrn3Zr97u3yS
	qFs29a4DuF48G3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2
	AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
	1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	s3kuDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Some code routines and structure members are unreachable when
CONFIG_TMPFS_QUOTA is off. Wrap additional shmem quota related code to
eliniate these unreachable sections.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 include/linux/shmem_fs.h |  4 ++++
 mm/shmem.c               | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 0b273a7b9f01..4873359a5442 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -47,12 +47,14 @@ struct shmem_inode_info {
 	(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL | FS_NOATIME_FL | FS_CASEFOLD_FL)
 #define SHMEM_FL_INHERITED		(FS_NODUMP_FL | FS_NOATIME_FL | FS_CASEFOLD_FL)
 
+#ifdef CONFIG_TMPFS_QUOTA
 struct shmem_quota_limits {
 	qsize_t usrquota_bhardlimit; /* Default user quota block hard limit */
 	qsize_t usrquota_ihardlimit; /* Default user quota inode hard limit */
 	qsize_t grpquota_bhardlimit; /* Default group quota block hard limit */
 	qsize_t grpquota_ihardlimit; /* Default group quota inode hard limit */
 };
+#endif
 
 struct shmem_sb_info {
 	unsigned long max_blocks;   /* How many blocks are allowed */
@@ -72,7 +74,9 @@ struct shmem_sb_info {
 	spinlock_t shrinklist_lock;   /* Protects shrinklist */
 	struct list_head shrinklist;  /* List of shinkable inodes */
 	unsigned long shrinklist_len; /* Length of shrinklist */
+#ifdef CONFIG_TMPFS_QUOTA
 	struct shmem_quota_limits qlimits; /* Default quota limits */
+#endif
 };
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
diff --git a/mm/shmem.c b/mm/shmem.c
index 9f5e1eccaacb..e3e05bbb6db2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -121,8 +121,10 @@ struct shmem_options {
 	int huge;
 	int seen;
 	bool noswap;
+#ifdef CONFIG_TMPFS_QUOTA
 	unsigned short quota_types;
 	struct shmem_quota_limits qlimits;
+#endif
 #if IS_ENABLED(CONFIG_UNICODE)
 	struct unicode_map *encoding;
 	bool strict_encoding;
@@ -132,7 +134,9 @@ struct shmem_options {
 #define SHMEM_SEEN_HUGE 4
 #define SHMEM_SEEN_INUMS 8
 #define SHMEM_SEEN_NOSWAP 16
+#ifdef CONFIG_TMPFS_QUOTA
 #define SHMEM_SEEN_QUOTA 32
+#endif
 };
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -4549,6 +4553,7 @@ enum shmem_param {
 	Opt_inode32,
 	Opt_inode64,
 	Opt_noswap,
+#ifdef CONFIG_TMPFS_QUOTA
 	Opt_quota,
 	Opt_usrquota,
 	Opt_grpquota,
@@ -4556,6 +4561,7 @@ enum shmem_param {
 	Opt_usrquota_inode_hardlimit,
 	Opt_grpquota_block_hardlimit,
 	Opt_grpquota_inode_hardlimit,
+#endif
 	Opt_casefold_version,
 	Opt_casefold,
 	Opt_strict_encoding,
@@ -4742,6 +4748,7 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->noswap = true;
 		ctx->seen |= SHMEM_SEEN_NOSWAP;
 		break;
+#ifdef CONFIG_TMPFS_QUOTA
 	case Opt_quota:
 		if (fc->user_ns != &init_user_ns)
 			return invalfc(fc, "Quotas in unprivileged tmpfs mounts are unsupported");
@@ -4796,6 +4803,7 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 				       "Group quota inode hardlimit too large.");
 		ctx->qlimits.grpquota_ihardlimit = size;
 		break;
+#endif
 	case Opt_casefold_version:
 		return shmem_parse_opt_casefold(fc, param, false);
 	case Opt_casefold:
@@ -4899,13 +4907,13 @@ static int shmem_reconfigure(struct fs_context *fc)
 		goto out;
 	}
 
+#ifdef CONFIG_TMPFS_QUOTA
 	if (ctx->seen & SHMEM_SEEN_QUOTA &&
 	    !sb_any_quota_loaded(fc->root->d_sb)) {
 		err = "Cannot enable quota on remount";
 		goto out;
 	}
 
-#ifdef CONFIG_TMPFS_QUOTA
 #define CHANGED_LIMIT(name)						\
 	(ctx->qlimits.name## hardlimit &&				\
 	(ctx->qlimits.name## hardlimit != sbinfo->qlimits.name## hardlimit))
-- 
2.30.0


