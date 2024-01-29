Return-Path: <linux-fsdevel+bounces-9322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4F783FFA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F5D1C21DDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92EC537FC;
	Mon, 29 Jan 2024 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="u6Vv7kMM";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Wtto7Qtd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC22C537E4;
	Mon, 29 Jan 2024 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515654; cv=none; b=Yy5ADQkFG8/J4WvD9QxVJd+bVQt7b85Yi+P9m7kp7c5PSd3zBa9q7GG5YIo+97q7mvf7Dg0s3glQzQ7GJHIQPDY2K/GIYO8Lw60ntxzQ4b7Iarx/I6+nCjtZS8tRJczUrESEXc1IDteDObGNCAOu6589LnUSsbz8IslN4do2Yvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515654; c=relaxed/simple;
	bh=ebmE+3+S0pyuODXXnBFsAaOW8KZdxmR2O/v1cJbjSO4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=FWxT1FbR2DkjL75FmaP6cR/1kVVcJrTqCjP8+7N1A+pRvoHlMHsOHEJxTj7NCYA23n6tZeGcbeb3f4XU5PyCliTzO+J5F1GoV7reDCv6SgXegfVnTpjyHrZoqYZ+naW8BkprqphZWgRSyNN0EtiHMzgjjWp1VZuUjRavnWTy2ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=u6Vv7kMM; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=Wtto7Qtd; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 7FDD4211A;
	Mon, 29 Jan 2024 08:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1706515239;
	bh=SelnU1PmjcEBam/XFIeYfnjb/zVT85VEHjJYVt2fRhM=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=u6Vv7kMMhVrF1vzHeBcbgCVN50yqGtaSjYEW8ON03Jpi9XNbYJTXzaxT3SL7XzqkR
	 6cVEFcLHJqpCZPwiKlGjpz4nt/DQ35sChxYkSuds3Mglu5URBYpWvpL+eCJTyNUdyU
	 PwK2jkF7UHG1AxfabfmC4+8rZX4YlrHvxS8NDj4A=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id CD4702135;
	Mon, 29 Jan 2024 08:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1706515649;
	bh=SelnU1PmjcEBam/XFIeYfnjb/zVT85VEHjJYVt2fRhM=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=Wtto7QtdPRPmS/B/yMBSisnCRJ6+b1ajjrp4oEe6VyxUX0X4ZSj8qrypAZAtWHZj9
	 lYzyzKoRORuHV0Debb33xTzi+KuDmwW4b2O3si54WDc+C+3enMK+RyZdkLoaGZNKuK
	 ZTtdTn5ydRwrRNARy+ocBiKd+dGUC7ujq+i7Y2SQ=
Received: from [192.168.211.199] (192.168.211.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 29 Jan 2024 11:07:29 +0300
Message-ID: <7d42dc06-2f7f-40b4-8d9f-89eebd0a8f06@paragon-software.com>
Date: Mon, 29 Jan 2024 11:07:29 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/5] fs/ntfs3: Prevent generic message "attempt to access
 beyond end of device"
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <dedce962-d48d-41d6-bbbf-e95c66daba80@paragon-software.com>
In-Reply-To: <dedce962-d48d-41d6-bbbf-e95c66daba80@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)


It used in test environment.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fsntfs.c  | 24 ++++++++++++++++++++++++
  fs/ntfs3/ntfs_fs.h | 14 +-------------
  2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 321978019407..ae2ef5c11868 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1007,6 +1007,30 @@ static inline __le32 security_hash(const void 
*sd, size_t bytes)
      return cpu_to_le32(hash);
  }

+/*
+ * simple wrapper for sb_bread_unmovable.
+ */
+struct buffer_head *ntfs_bread(struct super_block *sb, sector_t block)
+{
+    struct ntfs_sb_info *sbi = sb->s_fs_info;
+    struct buffer_head *bh;
+
+    if (unlikely(block >= sbi->volume.blocks)) {
+        /* prevent generic message "attempt to access beyond end of 
device" */
+        ntfs_err(sb, "try to read out of volume at offset 0x%llx",
+             (u64)block << sb->s_blocksize_bits);
+        return NULL;
+    }
+
+    bh = sb_bread_unmovable(sb, block);
+    if (bh)
+        return bh;
+
+    ntfs_err(sb, "failed to read volume at offset 0x%llx",
+         (u64)block << sb->s_blocksize_bits);
+    return NULL;
+}
+
  int ntfs_sb_read(struct super_block *sb, u64 lbo, size_t bytes, void 
*buffer)
  {
      struct block_device *bdev = sb->s_bdev;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 2b54ae94440f..81f7563428ee 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -586,6 +586,7 @@ bool check_index_header(const struct INDEX_HDR *hdr, 
size_t bytes);
  int log_replay(struct ntfs_inode *ni, bool *initialized);

  /* Globals from fsntfs.c */
+struct buffer_head *ntfs_bread(struct super_block *sb, sector_t block);
  bool ntfs_fix_pre_write(struct NTFS_RECORD_HEADER *rhdr, size_t bytes);
  int ntfs_fix_post_read(struct NTFS_RECORD_HEADER *rhdr, size_t bytes,
                 bool simple);
@@ -1032,19 +1033,6 @@ static inline u64 bytes_to_block(const struct 
super_block *sb, u64 size)
      return (size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
  }

-static inline struct buffer_head *ntfs_bread(struct super_block *sb,
-                         sector_t block)
-{
-    struct buffer_head *bh = sb_bread_unmovable(sb, block);
-
-    if (bh)
-        return bh;
-
-    ntfs_err(sb, "failed to read volume at offset 0x%llx",
-         (u64)block << sb->s_blocksize_bits);
-    return NULL;
-}
-
  static inline struct ntfs_inode *ntfs_i(struct inode *inode)
  {
      return container_of(inode, struct ntfs_inode, vfs_inode);
-- 
2.34.1


