Return-Path: <linux-fsdevel+bounces-77504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCPCINhYlWnQPAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:14:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2351A15345B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A305306377B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F4730B502;
	Wed, 18 Feb 2026 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0Ej0/e76"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EAB2DC323;
	Wed, 18 Feb 2026 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395197; cv=none; b=pQF49XU7zXc8os6Lnz44k57+6vBqwF8nM8cqji37jItCIpxqpXCpdCJYniP4uejGoFGqm7OqD1Xli7ZtVc3Hj9hwExXyWLn3pEtKP4V5+yKmNJ7q3rD2SC9GepadF14wZNgfbGzGuvxzu3NdJwysvZGrrwoUhMr6PjCnTfs5H0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395197; c=relaxed/simple;
	bh=bCkv+rcDKzK/XdV1dS+MEj6uGhMj1CDTItrGiW3Ag8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwSfyL3MMyfVlgzF4XYe5WPL8yRAXPAtb/LHV7jKU0rpPlCduynHjCz1mgsrmbzK95bmFVAJWzTJa6XtS/TMiQk53y2kx51RzvSFugIsd1BE3UFu6opVxX0fYLLLtGiS8jr/vYcrFK1mcHShHgucpuc4q70EwvIXKy1m3480y1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0Ej0/e76; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XwiW+MeTxlYy1GyjnYbCjaCzCpe2HMCBOPfkskdlg5o=; b=0Ej0/e76cUZ533aSWC1Zo5wulJ
	+6jio/ou6gwpBha0tjr0VLWZFUPG9DIOBw9641E8Lnn93LRTqbucMsKnenIiLQwkJGiOMQDz8p+EO
	ttDvGEqbwV0vJ8OW7AGCkNTiR7X5JvipMkr2kGqut0Y8DIv071MNKXe3oZe8WV+5WS8SNK5axDmdv
	90zSG5NXAVjoyJ4yhi36k+Im4EnsvndsEVMTd8M/AU2xOPec2Shi+2QefdD/65u8gNnsXREz2yFkl
	tDrobequZJnlCencTKNIgsDLT37Pidgx8KtgjLhZpNDaKGN0sqG379Uznq7UoieuAX9zsUHwiqF9e
	TblBAnsQ==;
Received: from [2001:4bb8:2dc:9863:1842:9381:9c0f:de32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsaoE-00000009LRp-1vzW;
	Wed, 18 Feb 2026 06:13:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 06/15] block: add fs_bio_integrity helpers
Date: Wed, 18 Feb 2026 07:12:00 +0100
Message-ID: <20260218061238.3317841-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260218061238.3317841-1-hch@lst.de>
References: <20260218061238.3317841-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77504-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,lst.de:email,infradead.org:dkim,oracle.com:email,samsung.com:email]
X-Rspamd-Queue-Id: 2351A15345B
X-Rspamd-Action: no action

Add a set of helpers for file system initiated integrity information.
These include mempool backed allocations and verifying based on a passed
in sector and size which is often available from file system completion
routines.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/Makefile                |  2 +-
 block/bio-integrity-fs.c      | 81 +++++++++++++++++++++++++++++++++++
 include/linux/bio-integrity.h |  6 +++
 3 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 block/bio-integrity-fs.c

diff --git a/block/Makefile b/block/Makefile
index c65f4da93702..7dce2e44276c 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -26,7 +26,7 @@ bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
 obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
 
 obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o \
-				   bio-integrity-auto.o
+				   bio-integrity-auto.o bio-integrity-fs.o
 obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
 obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
 obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
new file mode 100644
index 000000000000..acb1e5f270d2
--- /dev/null
+++ b/block/bio-integrity-fs.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Christoph Hellwig.
+ */
+#include <linux/blk-integrity.h>
+#include <linux/bio-integrity.h>
+#include "blk.h"
+
+struct fs_bio_integrity_buf {
+	struct bio_integrity_payload	bip;
+	struct bio_vec			bvec;
+};
+
+static struct kmem_cache *fs_bio_integrity_cache;
+static mempool_t fs_bio_integrity_pool;
+
+unsigned int fs_bio_integrity_alloc(struct bio *bio)
+{
+	struct fs_bio_integrity_buf *iib;
+	unsigned int action;
+
+	action = bio_integrity_action(bio);
+	if (!action)
+		return 0;
+
+	iib = mempool_alloc(&fs_bio_integrity_pool, GFP_NOIO);
+	bio_integrity_init(bio, &iib->bip, &iib->bvec, 1);
+
+	bio_integrity_alloc_buf(bio, action & BI_ACT_ZERO);
+	if (action & BI_ACT_CHECK)
+		bio_integrity_setup_default(bio);
+	return action;
+}
+
+void fs_bio_integrity_free(struct bio *bio)
+{
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+
+	bio_integrity_free_buf(bip);
+	mempool_free(container_of(bip, struct fs_bio_integrity_buf, bip),
+			&fs_bio_integrity_pool);
+
+	bio->bi_integrity = NULL;
+	bio->bi_opf &= ~REQ_INTEGRITY;
+}
+
+void fs_bio_integrity_generate(struct bio *bio)
+{
+	if (fs_bio_integrity_alloc(bio))
+		bio_integrity_generate(bio);
+}
+EXPORT_SYMBOL_GPL(fs_bio_integrity_generate);
+
+int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
+{
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+
+	/*
+	 * Reinitialize bip->bip_iter.
+	 *
+	 * This is for use in the submitter after the driver is done with the
+	 * bio.  Requires the submitter to remember the sector and the size.
+	 */
+	memset(&bip->bip_iter, 0, sizeof(bip->bip_iter));
+	bip->bip_iter.bi_sector = sector;
+	bip->bip_iter.bi_size = bio_integrity_bytes(bi, size >> SECTOR_SHIFT);
+	return blk_status_to_errno(bio_integrity_verify(bio, &bip->bip_iter));
+}
+
+static int __init fs_bio_integrity_init(void)
+{
+	fs_bio_integrity_cache = kmem_cache_create("fs_bio_integrity",
+			sizeof(struct fs_bio_integrity_buf), 0,
+			SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL);
+	if (mempool_init_slab_pool(&fs_bio_integrity_pool, BIO_POOL_SIZE,
+			fs_bio_integrity_cache))
+		panic("fs_bio_integrity: can't create pool\n");
+	return 0;
+}
+fs_initcall(fs_bio_integrity_init);
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 232b86b9bbcb..af5178434ec6 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -145,4 +145,10 @@ void bio_integrity_alloc_buf(struct bio *bio, bool zero_buffer);
 void bio_integrity_free_buf(struct bio_integrity_payload *bip);
 void bio_integrity_setup_default(struct bio *bio);
 
+unsigned int fs_bio_integrity_alloc(struct bio *bio);
+void fs_bio_integrity_free(struct bio *bio);
+void fs_bio_integrity_generate(struct bio *bio);
+int fs_bio_integrity_verify(struct bio *bio, sector_t sector,
+		unsigned int size);
+
 #endif /* _LINUX_BIO_INTEGRITY_H */
-- 
2.47.3


