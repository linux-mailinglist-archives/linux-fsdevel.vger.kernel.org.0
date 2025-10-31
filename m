Return-Path: <linux-fsdevel+bounces-66552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7E5C2369B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 07:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDF53A4A01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 06:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B30309EF8;
	Fri, 31 Oct 2025 06:31:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E72E6125;
	Fri, 31 Oct 2025 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892286; cv=none; b=Zttol9tuderhy2pFz7+UQ1wwJPP+FmtbOPb0IlgRRArb5AUSGS0IDVWv9MWv41JdHnjCxrNFiM2HM3l42KnOPNRGQScuMP6HEck5xw6RfypkFEHurjTI+QYoW05J+kZ3JPhaxyqJ0uf7cdhbNb8RnmbxQlb3V8HoWawvQB+lJ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892286; c=relaxed/simple;
	bh=W6rXC4yik0dnsYjY60VbMqpNeSek+IzWHWPrGzxVmnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRBPr4CxpBbdlF5Hw3wPFmxEKmGCf6eXm3ZEEfApKS0H3nCZjYGWqEhld0dM5BORg/9WEAJEWUP0jd+Ex9jv7uKM+RvDKK4DND8x9xir6LItUGCEEuEl2i9lzkp7dCS9UYgynvsbdeowZnBTGD7i/136HF4jObriiWFPDOZFM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cyWLh2nclzKHM0T;
	Fri, 31 Oct 2025 14:30:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 154031A1B8E;
	Fri, 31 Oct 2025 14:31:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgBHnESuVwRpEFrWCA--.33311S6;
	Fri, 31 Oct 2025 14:31:20 +0800 (CST)
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
	yangerkun@huawei.com
Subject: [PATCH 2/4] ext4: check for conflicts when caching extents
Date: Fri, 31 Oct 2025 14:29:03 +0800
Message-ID: <20251031062905.4135909-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251031062905.4135909-1-yi.zhang@huaweicloud.com>
References: <20251031062905.4135909-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnESuVwRpEFrWCA--.33311S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1fAF13tF45KFWrAw13Jwb_yoW5CrWDpr
	ZIkr15Jrn3WwnI9ayfAa1UXr1fKa18GrW7C34fKw1S9a45Zry3KF1jyFyjvF95XFW8Xr1a
	vF4Fkr18Ga1UJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUczV8UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since ext4_es_cache_extent() can only be used to load on-disk extents
and does not permit modifying extents, it is not possible to overwrite
an extent of a different type. To prevent misuse of the interface, the
current implementation checks only the first existing extent but does
not verify all extents within the range to be inserted, as doing so
would be time-consuming in highly fragmented scenarios. Furthermore,
adding such checks to __es_remove_extent() would complicate its logic.
Therefore, a full check can be performed in debug mode to ensure that
the function does not overwrite any valuable extents.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 50 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index f9546ecf7340..55103c331b6b 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -985,6 +985,48 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	return;
 }
 
+#ifdef CONFIG_EXT4_DEBUG
+/*
+ * If we find an extent that already exists during caching extents, its
+ * status must match the one to be cached. Otherwise, the extent status
+ * tree may have been corrupted.
+ */
+static void ext4_es_cache_extent_check(struct inode *inode,
+		struct extent_status *es, struct extent_status *newes)
+{
+	unsigned int status = ext4_es_type(newes);
+	struct rb_node *node;
+
+	if (ext4_es_type(es) != status)
+		goto conflict;
+
+	while ((node = rb_next(&es->rb_node)) != NULL) {
+		es = rb_entry(node, struct extent_status, rb_node);
+
+		if (es->es_lblk >= newes->es_lblk + newes->es_len)
+			break;
+		if (ext4_es_type(es) != status)
+			goto conflict;
+	}
+	return;
+
+conflict:
+	ext4_warning_inode(inode,
+			   "ES cache extent failed: add [%d,%d,%llu,0x%x] conflict with existing [%d,%d,%llu,0x%x]\n",
+			   newes->es_lblk, newes->es_len, ext4_es_pblock(newes),
+			   ext4_es_status(newes), es->es_lblk, es->es_len,
+			   ext4_es_pblock(es), ext4_es_status(es));
+
+	WARN_ON_ONCE(1);
+}
+#else
+static void ext4_es_cache_extent_check(struct inode __maybe_unused *inode,
+		struct extent_status *es, struct extent_status *newes)
+{
+	WARN_ON_ONCE(ext4_es_type(es) != ext4_es_type(newes));
+}
+#endif
+
 /*
  * ext4_es_cache_extent() inserts extent information into the extent status
  * tree. If 'overwrite' is not set, it inserts extent only if there isn't
@@ -1022,9 +1064,11 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (es && es->es_lblk <= end) {
 		if (!overwrite)
 			goto unlock;
-
-		/* Only extents of the same type can be overwritten. */
-		WARN_ON_ONCE(ext4_es_type(es) != status);
+		/*
+		 * Check whether the overwrites are safe. Only extents
+		 * of the same type can be overwritten.
+		 */
+		ext4_es_cache_extent_check(inode, es, &newes);
 		if (__es_remove_extent(inode, lblk, end, NULL, NULL))
 			goto unlock;
 	}
-- 
2.46.1


