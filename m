Return-Path: <linux-fsdevel+bounces-60401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C314B46714
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 01:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08405E1488
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 23:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEA622E3E9;
	Fri,  5 Sep 2025 23:19:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CC21F866A
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757114362; cv=none; b=MXXWmXYeg2VpTUurQLt9Fp92lktDu04ZYPXiG2vkvXeE3cLvcW2KsTieYUYxBHZ6IT7+ZSaCcChx4Wm8z6XrV20pXo56Qvxn0LBmkYXFltiy1RDdqqOQL6kC2+MzWriveIJj5N+AG5JTuwbam57CALf1riTxHwL8HG/NyAd2T4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757114362; c=relaxed/simple;
	bh=uIkWKP23TkK4nAXNFrlpfPcdPnCQDbYcuFZnxpG9NXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MUjQolrnnxR+QZKJvxKMSrqFV3D+Qz9dd/WCO7wBaL1b9WKgol84wNtRLqrAFfmkw+KJmRwZr/BHCi/UJGsdP4Cck9VTHfzEvgAhYnoU17RAYGi7UU6x25MHb4KmE1Ar8kPQflHaPgKLnfpNZMk4GB3PW1U663pAjZTytQFgrb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b52196e8464so509890a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 16:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757114359; x=1757719159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfV4l7VaDuqWMCwZtACco3WrbxZ/vf2zbWmGFVD/hT8=;
        b=WKmvG0jfIbmzk2fkSJqgneqgzjoTnUh+9X/8lsL2l5fk+GSV59FgfPedT6LSsRzrqw
         cSsYh6XG9Rc85f5zdpm25L+zTB7IsZ77z9stQX706JU2zLQpYEMKNHcAlqDD8qw9wpSe
         wNNfVAdUIVHTQEkP+yeWGImp7Wqukv+GpKHE66soBapd8sK8I/NyaeuqG9XqgJAsSj7a
         nf6qzZjrNINaPbiq+l32cReBB64GNVqCsAgB0aYd9Jnx5DnaqkjXgxc+CMbmwcFjf9Pm
         x7J+mfJawsG8ERV8tFS6dPdAZOBxMecjAT1N9+lhT9+jHKlWMowxfbpTUyPCaQKkASDD
         dfHw==
X-Gm-Message-State: AOJu0YyIQGh+Rr28ZFom/rKJkxBl+RPvHTRqAJGtRWHGdFhD1Xkz6Tol
	d8SxspHYPjDctobYUvaQVG2AKU8OQ9u0jIBue4ShXYLqaENmvIVVLJKdLvUkWQ==
X-Gm-Gg: ASbGncuB83zMH1gtkRehimOJ8zyg6kUy3qQpzqnNJcSzCRfDyuJs4uyHqdGktbB/ZT3
	DcG6ZcfiuVzHlw7WxXuJ5nhVSwGRl5hl8JoiLGb4uYiXZuka+Pf9uymPvz07kJGiIBBDNMkQOqW
	MC4AilWIxoiNg+CJkguE7fiQZLBDWgJPxoCpqTDo7S5/8rFNf+UIsIqgXjueR4WkLfSVEyYLvLH
	IXjllLbV/fno1zSf9luj99zqYRSbVxovrYysXWXkKNw/MdTUzzzBiA1K4TUg0FMfjZK5W3QpIO/
	mZV9Cl3scf/5G7B83HcVxL5KGqWKPJGku++ee9X3gj3DtuIhMN8k0D2aPD9W+0L9OZr/J8iIxG7
	XHLyCGmoOmcSFbfvz9HjEOA0/z53eygYIbXCwImYkA8rl893M38Y2gW00Y1g=
X-Google-Smtp-Source: AGHT+IFgBNU3/bQpiX+uWlq//7dwCYeTtfQgLDwMYWjVkFFHJSZAU3In8+cGbALYgQPybjpjE6kTjw==
X-Received: by 2002:a17:90a:f944:b0:32b:be39:7804 with SMTP id 98e67ed59e1d1-32d43ef50fcmr643994a91.8.1757114359267;
        Fri, 05 Sep 2025 16:19:19 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329b3e28a10sm15328141a91.18.2025.09.05.16.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 16:19:18 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	Yuezhang.Mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com
Subject: [PATCH] exfat: validate cluster allocation bits of the allocation bitmap
Date: Sat,  6 Sep 2025 08:19:10 +0900
Message-Id: <20250905231910.8343-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/exfat/balloc.c | 72 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 12 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index cc01556c9d9b..c09bdb1762f4 100644
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
+		return -EINVAL;
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
2.25.1


