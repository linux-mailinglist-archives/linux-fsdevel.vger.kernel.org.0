Return-Path: <linux-fsdevel+bounces-65629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F303C098A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 18:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99EEC5034E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 16:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228B5308F0B;
	Sat, 25 Oct 2025 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGFZW81t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709C03064B1;
	Sat, 25 Oct 2025 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409307; cv=none; b=hm3MwdiF4EuzLznZIzUEt+ZGypubWM8OOoJ1aOv1IOSd+QkuQjeWn8WZNwDVOQWY5W7AJYAzWVQE3tNUhPbHvfInVUc42t7xJ+sI0eaUEDWq+PQY7hYoG3yG9FfHyFw1oHfGxI3TFo6yAT5VpArYk4Z23WBCPViAHjD8ngmCwW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409307; c=relaxed/simple;
	bh=ZFwS/yiQomAQ3MgaRgMgID6n07EAK9YcalbNOoA1M8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrU3bB5ox0ZQnRnjByTQKnKw5UXH3PtlMa0SrmJ9wf6VL2AlYYaQ7YaIjfO7GHZusWVbacHApup0YgPcGBRCulpcybGNXM+NDNHppZEeSn73qlyjuwDhOKFUhDFYwr0pugeAZUPoxwbgKqvaPuCPG/2zjVCoAymqiJBDWiIp4vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGFZW81t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CA4C2BC9E;
	Sat, 25 Oct 2025 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409307;
	bh=ZFwS/yiQomAQ3MgaRgMgID6n07EAK9YcalbNOoA1M8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MGFZW81tlHo5yg3ZLUiE+7DLB6nzLmlQQ4jERhfMjDl3NwFGtc0sQDPDf6FzqIOvb
	 nrfqgBvDZJpZ6SuRKaBIB6StaaOI5jfekeKiGNwuYzkx2gwAeRlKSNxtyYxpSH1t03
	 BR15Ie6qU72VvCImTPz964uie7yolZopOrDuA0SCfesmFr+Hkn17JrYTb+mvMgUVnT
	 9cbP9lB8RPGZbw6Ef6kXLSZPgAgvoC8l+4ZK8crSbh9MLXjp1NH25IHbhBKS70wQzE
	 3rTf8I4rL4KiueIKm+tvSWJyeiPiDR0DoKPQcfFjDGGMk97+NVaZo+LR1SGmDcZefF
	 Weiqh75oH5mdA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] exfat: validate cluster allocation bits of the allocation bitmap
Date: Sat, 25 Oct 2025 11:58:24 -0400
Message-ID: <20251025160905.3857885-273-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 79c1587b6cda74deb0c86fc7ba194b92958c793c ]

syzbot created an exfat image with cluster bits not set for the allocation
bitmap. exfat-fs reads and uses the allocation bitmap without checking
this. The problem is that if the start cluster of the allocation bitmap
is 6, cluster 6 can be allocated when creating a directory with mkdir.
exfat zeros out this cluster in exfat_mkdir, which can delete existing
entries. This can reallocate the allocated entries. In addition,
the allocation bitmap is also zeroed out, so cluster 6 can be reallocated.
This patch adds exfat_test_bitmap_range to validate that clusters used for
the allocation bitmap are correctly marked as in-use.

Reported-by: syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com
Tested-by: syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- The commit adds `exfat_test_bitmap_range()` to verify that every
  cluster backing the allocation bitmap file has its allocation bit set
  before the filesystem accepts the bitmap (`fs/exfat/balloc.c:29`).
  Without this guard, the mount path would happily proceed even when the
  bitmap’s own clusters are marked free, exactly the corruption pattern
  syzbot reported.
- The new helper simply walks the existing bitmap pages
  (`sbi->vol_amap`) and checks the relevant bits with the existing
  macros; on any mismatch it rejects the volume with `-EIO`, preventing
  us from ever reaching the allocator that can hand the bitmap’s cluster
  to new directories (`fs/exfat/balloc.c:108`, `fs/exfat/balloc.c:114`).
  This is a small, self-contained mount-time validation step.
- The bug being fixed is high severity: when the bitmap cluster is
  falsely free, `exfat_alloc_cluster()` can select it and zero the data
  while creating a directory (`fs/exfat/fatent.c:381` onward),
  destroying the bitmap and any directory entries stored there. The
  patch blocks that corruption before it can happen.
- Risk of regression is minimal—the helper only reads data we already
  loaded, relies on longstanding helpers/macros, and touches no runtime
  paths once the bitmap validates. If the check fails we already have to
  bail out because the on-disk image is inconsistent; no new behavior
  appears for well-formed volumes.
- The change stands on its own (no functional dependencies on later
  commits), fixes a real user-visible corruption scenario, and adheres
  to stable-tree guidance (bug fix, limited scope, no architectural
  churn). Backporting will materially improve resilience of exFAT mounts
  against malformed media.

 fs/exfat/balloc.c | 72 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 12 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index cc01556c9d9b3..071448adbd5d9 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -26,12 +26,55 @@
 /*
  *  Allocation Bitmap Management Functions
  */
+static bool exfat_test_bitmap_range(struct super_block *sb, unsigned int clu,
+		unsigned int count)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	unsigned int start = clu;
+	unsigned int end = clu + count;
+	unsigned int ent_idx, i, b;
+	unsigned int bit_offset, bits_to_check;
+	__le_long *bitmap_le;
+	unsigned long mask, word;
+
+	if (!is_valid_cluster(sbi, start) || !is_valid_cluster(sbi, end - 1))
+		return false;
+
+	while (start < end) {
+		ent_idx = CLUSTER_TO_BITMAP_ENT(start);
+		i = BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
+		b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
+
+		bitmap_le = (__le_long *)sbi->vol_amap[i]->b_data;
+
+		/* Calculate how many bits we can check in the current word */
+		bit_offset = b % BITS_PER_LONG;
+		bits_to_check = min(end - start,
+				    (unsigned int)(BITS_PER_LONG - bit_offset));
+
+		/* Create a bitmask for the range of bits to check */
+		if (bits_to_check >= BITS_PER_LONG)
+			mask = ~0UL;
+		else
+			mask = ((1UL << bits_to_check) - 1) << bit_offset;
+		word = lel_to_cpu(bitmap_le[b / BITS_PER_LONG]);
+
+		/* Check if all bits in the mask are set */
+		if ((word & mask) != mask)
+			return false;
+
+		start += bits_to_check;
+	}
+
+	return true;
+}
+
 static int exfat_allocate_bitmap(struct super_block *sb,
 		struct exfat_dentry *ep)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	long long map_size;
-	unsigned int i, need_map_size;
+	unsigned int i, j, need_map_size;
 	sector_t sector;
 
 	sbi->map_clu = le32_to_cpu(ep->dentry.bitmap.start_clu);
@@ -58,20 +101,25 @@ static int exfat_allocate_bitmap(struct super_block *sb,
 	sector = exfat_cluster_to_sector(sbi, sbi->map_clu);
 	for (i = 0; i < sbi->map_sectors; i++) {
 		sbi->vol_amap[i] = sb_bread(sb, sector + i);
-		if (!sbi->vol_amap[i]) {
-			/* release all buffers and free vol_amap */
-			int j = 0;
-
-			while (j < i)
-				brelse(sbi->vol_amap[j++]);
-
-			kvfree(sbi->vol_amap);
-			sbi->vol_amap = NULL;
-			return -EIO;
-		}
+		if (!sbi->vol_amap[i])
+			goto err_out;
 	}
 
+	if (exfat_test_bitmap_range(sb, sbi->map_clu,
+		EXFAT_B_TO_CLU_ROUND_UP(map_size, sbi)) == false)
+		goto err_out;
+
 	return 0;
+
+err_out:
+	j = 0;
+	/* release all buffers and free vol_amap */
+	while (j < i)
+		brelse(sbi->vol_amap[j++]);
+
+	kvfree(sbi->vol_amap);
+	sbi->vol_amap = NULL;
+	return -EIO;
 }
 
 int exfat_load_bitmap(struct super_block *sb)
-- 
2.51.0


