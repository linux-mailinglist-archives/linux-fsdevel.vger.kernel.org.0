Return-Path: <linux-fsdevel+bounces-25777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC15950542
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 14:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440381F242B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 12:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41DC19923A;
	Tue, 13 Aug 2024 12:39:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9319ADBE;
	Tue, 13 Aug 2024 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552766; cv=none; b=YUe1MHl7tNI115rQfQSUaXqKMZyYEPOvnozYWtcIGPuOQRG5U8dBoQnsHQb69l7xA3FdtKEKVr6HU94Ssblc5ScAvZWrs8LQoyRgVyGcEQS/bEh6PuuOw3VVKYNeplqGB+VyEbsKTBwVYFl/5wc52EX+lJyqF+QB4BGGjuZIq+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552766; c=relaxed/simple;
	bh=mG267X2NkABTMWHGvozWZ1uh+wCYxCuzMcZjHn0D2Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MmFfpVEJ2SfLnuMF9qB2ubA0LwoHleEmgFWSUiX+mQI2zujxRWHWajv2IxSXQXwWrlgJdbtO5H1Ekz0Ynfu34yPlP3F6NYDpep+cbn7QeCv0OP4p67gEQ5jbzTk8FtfGe2B3AJLHl56F7sdMeY7tdvc0BY+xHOPAsAos6MYxmeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WjrY74gV7z4f3jdP;
	Tue, 13 Aug 2024 20:39:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 597611A0568;
	Tue, 13 Aug 2024 20:39:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4XkU7tmejNSBg--.17625S14;
	Tue, 13 Aug 2024 20:39:21 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v3 10/12] ext4: make extent status types exclusive
Date: Tue, 13 Aug 2024 20:34:50 +0800
Message-Id: <20240813123452.2824659-11-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnj4XkU7tmejNSBg--.17625S14
X-Coremail-Antispam: 1UD129KBjvJXoW7urykGr1xGr47Jw4DXrykuFg_yoW8uw17pa
	s5Jws8Kr4UWan7u34SkF1rXF15Gw4Ikr9rurZ3Gw1Fva45JrWrCFyxKry5WrnFqFW8ZFya
	yayFyw1kGay3Ja7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since we don't add delayed flag in unwritten extents, all of the four
extent status types EXTENT_STATUS_WRITTEN, EXTENT_STATUS_UNWRITTEN,
EXTENT_STATUS_DELAYED and EXTENT_STATUS_HOLE are exclusive now, add
assertion when storing pblock before inserting extent into status tree
and add comment to the status definition.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 3ca40f018994..7d7af642f7b2 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -42,6 +42,10 @@ enum {
 #define ES_SHIFT (sizeof(ext4_fsblk_t)*8 - ES_FLAGS)
 #define ES_MASK (~((ext4_fsblk_t)0) << ES_SHIFT)
 
+/*
+ * Besides EXTENT_STATUS_REFERENCED, all these extent type masks
+ * are exclusive, only one type can be set at a time.
+ */
 #define EXTENT_STATUS_WRITTEN	(1 << ES_WRITTEN_B)
 #define EXTENT_STATUS_UNWRITTEN (1 << ES_UNWRITTEN_B)
 #define EXTENT_STATUS_DELAYED	(1 << ES_DELAYED_B)
@@ -51,7 +55,9 @@ enum {
 #define ES_TYPE_MASK	((ext4_fsblk_t)(EXTENT_STATUS_WRITTEN | \
 			  EXTENT_STATUS_UNWRITTEN | \
 			  EXTENT_STATUS_DELAYED | \
-			  EXTENT_STATUS_HOLE) << ES_SHIFT)
+			  EXTENT_STATUS_HOLE))
+
+#define ES_TYPE_VALID(type)	((type) && !((type) & ((type) - 1)))
 
 struct ext4_sb_info;
 struct ext4_extent;
@@ -156,7 +162,7 @@ static inline unsigned int ext4_es_status(struct extent_status *es)
 
 static inline unsigned int ext4_es_type(struct extent_status *es)
 {
-	return (es->es_pblk & ES_TYPE_MASK) >> ES_SHIFT;
+	return (es->es_pblk >> ES_SHIFT) & ES_TYPE_MASK;
 }
 
 static inline int ext4_es_is_written(struct extent_status *es)
@@ -228,6 +234,8 @@ static inline void ext4_es_store_pblock_status(struct extent_status *es,
 					       ext4_fsblk_t pb,
 					       unsigned int status)
 {
+	WARN_ON_ONCE(!ES_TYPE_VALID(status & ES_TYPE_MASK));
+
 	es->es_pblk = (((ext4_fsblk_t)status << ES_SHIFT) & ES_MASK) |
 		      (pb & ~ES_MASK);
 }
-- 
2.39.2


