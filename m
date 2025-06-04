Return-Path: <linux-fsdevel+bounces-50567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30879ACD580
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 04:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09C417C656
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 02:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE1A1EBFFF;
	Wed,  4 Jun 2025 02:21:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC151CAA65;
	Wed,  4 Jun 2025 02:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749003717; cv=none; b=PQirUksw/xN9LlE9elBlp+8PEFfs8Ke4lUS7M6HtpqJleGq1/faAMpMAz74tDtSmvJYIcUNnrSw0cfqYx+F4L8UcupzD/kNYJ29jvTeMhTSji9kEa8XLaCcSr9ldUmvKXU5KjFF0ELqHRYo+/GEqCPg3RLb7p/MxjovEE2SKhgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749003717; c=relaxed/simple;
	bh=oe/IsoHj3uuiOaz1yf23CSSzT3TKBGkSgmrmFnnvtR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TI2YMW6autRM+Rj99d6TGMgYrmou8AGO2lsTOFsgZpsQhdkpg2F2L7u1HiHdLFzs6rJhaiLIe93H6NSkXt5/4qqWGfkL3SMFRuuo4uggdOAzJDzAXijsQUunZM6XzENXGqN0ABM6dsvbSnbjmZiLpmZWnfSw6V4Z/N+gebrT+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bBrtj3VNWzYQvMW;
	Wed,  4 Jun 2025 10:21:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 838471A11BA;
	Wed,  4 Jun 2025 10:21:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl+nrT9oedfBOQ--.14997S11;
	Wed, 04 Jun 2025 10:21:48 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	john.g.garry@oracle.com,
	bmarzins@redhat.com,
	chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com,
	brauner@kernel.org,
	martin.petersen@oracle.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 07/10] fs: introduce FALLOC_FL_WRITE_ZEROES to fallocate
Date: Wed,  4 Jun 2025 10:08:47 +0800
Message-ID: <20250604020850.1304633-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl+nrT9oedfBOQ--.14997S11
X-Coremail-Antispam: 1UD129KBjvJXoWxAryrGFW7Jr18Aw1kArW3GFg_yoWrAr13pF
	W3Gr1rGrW0ga45C3s3Can7ur98Zws5Gr43ZrWIgr4jvr45Jr1xKFsFgryYva4xJrZrAF4Y
	qrnI9r98ua47A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRiF4iUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

With the development of flash-based storage devices, we can quickly
write zeros to SSDs using the WRITE_ZERO command if the devices do not
actually write physical zeroes to the media. Therefore, we can use this
command to quickly preallocate a real all-zero file with written
extents. This approach should be beneficial for subsequent pure
overwriting within this file, as it can save on block allocation and,
consequently, significant metadata changes, which should greatly improve
overwrite performance on certain filesystems.

Therefore, introduce a new operation FALLOC_FL_WRITE_ZEROES to
fallocate. This flag is used to convert a specified range of a file to
zeros by issuing a zeroing operation. Blocks should be allocated for the
regions that span holes in the file, and the entire range is converted
to written extents. If the underlying device supports the actual offload
write zeroes command, the process of zeroing out operation can be
accelerated. If it does not, we currently don't prevent the file system
from writing actual zeros to the device. This provides users with a new
method to quickly generate a zeroed file, users no longer need to write
zero data to create a file with written extents.

Users can determine whether a disk supports the unmap write zeroes
operation through querying this sysfs interface:

    /sys/block/<disk>/queue/write_zeroes_unmap

Finally, this flag cannot be specified in conjunction with the
FALLOC_FL_KEEP_SIZE since allocating written extents beyond file EOF is
not permitted. In addition, filesystems that always require out-of-place
writes should not support this flag since they still need to allocated
new blocks during subsequent overwrites.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/open.c                   |  1 +
 include/linux/falloc.h      |  3 ++-
 include/uapi/linux/falloc.h | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 7828234a7caa..b777e11e5522 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -281,6 +281,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		break;
 	case FALLOC_FL_COLLAPSE_RANGE:
 	case FALLOC_FL_INSERT_RANGE:
+	case FALLOC_FL_WRITE_ZEROES:
 		if (mode & FALLOC_FL_KEEP_SIZE)
 			return -EOPNOTSUPP;
 		break;
diff --git a/include/linux/falloc.h b/include/linux/falloc.h
index 3f49f3df6af5..7c38c6b76b60 100644
--- a/include/linux/falloc.h
+++ b/include/linux/falloc.h
@@ -36,7 +36,8 @@ struct space_resv {
 				 FALLOC_FL_COLLAPSE_RANGE |	\
 				 FALLOC_FL_ZERO_RANGE |		\
 				 FALLOC_FL_INSERT_RANGE |	\
-				 FALLOC_FL_UNSHARE_RANGE)
+				 FALLOC_FL_UNSHARE_RANGE |	\
+				 FALLOC_FL_WRITE_ZEROES)
 
 /* on ia32 l_start is on a 32-bit boundary */
 #if defined(CONFIG_X86_64)
diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
index 5810371ed72b..265aae7ff8c1 100644
--- a/include/uapi/linux/falloc.h
+++ b/include/uapi/linux/falloc.h
@@ -78,4 +78,22 @@
  */
 #define FALLOC_FL_UNSHARE_RANGE		0x40
 
+/*
+ * FALLOC_FL_WRITE_ZEROES is used to convert a specified range of a file to
+ * zeros by issuing a zeroing operation. Blocks should be allocated for the
+ * regions that span holes in the file, and the entire range is converted to
+ * written extents. This flag is beneficial for subsequent pure overwriting
+ * within this range, as it can save on block allocation and, consequently,
+ * significant metadata changes. Therefore, filesystems that always require
+ * out-of-place writes should not support this flag.
+ *
+ * Different filesystems may implement different limitations on the
+ * granularity of the zeroing operation. Most will preferably be accelerated
+ * by submitting write zeroes command if the backing storage supports, which
+ * may not physically write zeros to the media.
+ *
+ * This flag cannot be specified in conjunction with the FALLOC_FL_KEEP_SIZE.
+ */
+#define FALLOC_FL_WRITE_ZEROES		0x80
+
 #endif /* _UAPI_FALLOC_H_ */
-- 
2.46.1


