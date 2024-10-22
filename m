Return-Path: <linux-fsdevel+bounces-32551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6149A96A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C471C22717
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4838C149C52;
	Tue, 22 Oct 2024 03:13:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AE613E88C;
	Tue, 22 Oct 2024 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566781; cv=none; b=l0DSry85iyEVbFY4V3Vh0j5/Rbz58/SMHMT4GT9RfIkThHxfhCmMZOj2llMTuRKxvuDSvlwvodvB8v0Zk3KZxsJEQ6WmI5niBaiSdJ8fOAtH5jk7ToOcSS5YmfT9KLaPmPHhVgTe31oh21+oU/nRYoxLUf3vz9/Ua+OUJQEPtlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566781; c=relaxed/simple;
	bh=Q4ZjcXrFDZS2msa9ZwQ+vB5v3/8DlSJ9xp0ij3cEtWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeLJ4zNxDivNMVZhAfwptTEU452qFl5thQFkrLax8E1sZ+snEmjFe685Ct0Sh1MueBjGVAbIYR0Gu0Gjqyga6i1aN2n6nHFwygC583ZFZdkqkhL2iRQrD44LoVHox36Dg/dKevFMDHg/ET4UOs18LUXjVLaTJ5c9hwNujB607F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXcgH6bxHz4f3jkk;
	Tue, 22 Oct 2024 11:12:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 344111A058E;
	Tue, 22 Oct 2024 11:12:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S15;
	Tue, 22 Oct 2024 11:12:55 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 11/27] ext4: use reserved metadata blocks when splitting extent on endio
Date: Tue, 22 Oct 2024 19:10:42 +0800
Message-ID: <20241022111059.2566137-12-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S15
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw15Ary3ZF4fKF4UGrW8Xrb_yoW8ur1DpF
	yay3W8Gr40vw1Y9F92ya1UAr12k3W5GF47urZ8tayUuay7Ar1rXF12k34F9FyYvrWxJa1Y
	vr409w1UZwn5uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRRgAFtUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When performing buffered writes, we may need to split and convert an
unwritten extent into a written one during the end I/O process. However,
we do not reserve space specifically for these metadata changes, we only
reserve 2% of space or 4096 blocks. To address this, we use
EXT4_GET_BLOCKS_PRE_IO to potentially split extents in advance and
EXT4_GET_BLOCKS_METADATA_NOFAIL to utilize reserved space if necessary.

These two approaches can reduce the likelihood of running out of space
and losing data. However, these methods are merely best efforts, we
could still run out of space, and there is not much difference between
converting an extent during the writeback process and the end I/O
process, it won't increase the rick of losing data if we postpone the
conversion.

Therefore, also use EXT4_GET_BLOCKS_METADATA_NOFAIL in
ext4_convert_unwritten_extents_endio() to prepare for the buffered I/O
iomap conversion, which may perform extent conversion during the end I/O
process.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d5067d5aa449..33bc2cc5aff4 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3767,6 +3767,8 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 	 * illegal.
 	 */
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
+		int flags = EXT4_GET_BLOCKS_CONVERT |
+			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
 #ifdef CONFIG_EXT4_DEBUG
 		ext4_warning(inode->i_sb, "Inode (%ld) finished: extent logical block %llu,"
 			     " len %u; IO logical block %llu, len %u",
@@ -3774,7 +3776,7 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 			     (unsigned long long)map->m_lblk, map->m_len);
 #endif
 		path = ext4_split_convert_extents(handle, inode, map, path,
-						EXT4_GET_BLOCKS_CONVERT, NULL);
+						  flags, NULL);
 		if (IS_ERR(path))
 			return path;
 
-- 
2.46.1


