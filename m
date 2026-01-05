Return-Path: <linux-fsdevel+bounces-72372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C92D7CF1940
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 02:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C2A5301515E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 01:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692228468E;
	Mon,  5 Jan 2026 01:48:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6901367;
	Mon,  5 Jan 2026 01:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767577727; cv=none; b=LBCTIYDNs0hI8r+AuXDG7tQxSRNk8gZcOE62GdmwopA+mV3YWdHm2D6L4vGD1v+tMonlrbaJEPoL4JkAZ/S1Vn2+bO9smdPtBxJA3AnRjIP+HzivwkboViUyOZG5cYivFk+SRl4qOWaNt8ImijbC4YErpRapDnulvt4vsdiC32U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767577727; c=relaxed/simple;
	bh=d6q/zjeIncE/mA9v6xm9GVqB2a6KGFw352k6rnKR8f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2f2strpDtMMnnpYpDgCbM6DoSIAdv0zfff5StcQRPvfSnV4+KTtTbLrGzOBu4dFnhK3aE7cxLp65/sjAC5BhueHXarmtsDqAQ553obVExpDdqW+tkCAQe6If+t08whJZKXOiLEUTH/SkAzForxXXprWKhh+TJb4umpz7DFCLo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dkxyY0n3pzKHMX2;
	Mon,  5 Jan 2026 09:48:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9423940573;
	Mon,  5 Jan 2026 09:48:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgBHp_dpGFtppFisCg--.42376S5;
	Mon, 05 Jan 2026 09:48:42 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	yukuai@fnnas.com
Subject: [PATCH -next v3 1/7] ext4: use reserved metadata blocks when splitting extent on endio
Date: Mon,  5 Jan 2026 09:45:16 +0800
Message-ID: <20260105014522.1937690-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105014522.1937690-1-yi.zhang@huaweicloud.com>
References: <20260105014522.1937690-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHp_dpGFtppFisCg--.42376S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw15Ary3ZF4fKF4UGrW8Xrb_yoW8trWUpF
	yak3W8Gr40qw1Y9F92yF48Aryjk3W5GF47urZxtayUWay7AryrXr12kw1F9FyYvrWxJ3WY
	vr40vw18Zwn8Ca7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JU4OJ5UUUUU=
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
process, it won't increase the risk of losing data if we postpone the
conversion.

Therefore, also use EXT4_GET_BLOCKS_METADATA_NOFAIL in
ext4_convert_unwritten_extents_endio() to prepare for the buffered I/O
iomap conversion, which may perform extent conversion during the end I/O
process.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 27eb2c1df012..e53959120b04 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3794,6 +3794,8 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 	 * illegal.
 	 */
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
+		int flags = EXT4_GET_BLOCKS_CONVERT |
+			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
 #ifdef CONFIG_EXT4_DEBUG
 		ext4_warning(inode->i_sb, "Inode (%ld) finished: extent logical block %llu,"
 			     " len %u; IO logical block %llu, len %u",
@@ -3801,7 +3803,7 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 			     (unsigned long long)map->m_lblk, map->m_len);
 #endif
 		path = ext4_split_convert_extents(handle, inode, map, path,
-						EXT4_GET_BLOCKS_CONVERT, NULL);
+						  flags, NULL);
 		if (IS_ERR(path))
 			return path;
 
-- 
2.52.0


