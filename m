Return-Path: <linux-fsdevel+bounces-75757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJnuJtY3eml+4gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:22:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D362A57FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5ADB308BBE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0C4310774;
	Wed, 28 Jan 2026 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2/FVXGDG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0E12417C6;
	Wed, 28 Jan 2026 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616964; cv=none; b=s9FEMvgft26OGu37+CnIIsV8uIDwC6M2r0pSd90dvclHFzIO6m/ERYKqgaJjL8mAKJgc+SzbtfsbFSngfTe9RVBmCd3yyAoCN7om4PJSUXM0vopZFgdi0IyEheJ4JuyLLJdI4R30RegpZ6OpN5IVt1kA+v4q3lFkgGbULvsWcig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616964; c=relaxed/simple;
	bh=ddiLOcWt0Ob8kvVACq4PRZ925uF8NRfLbWWJm1nKlVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqV9i/F7Ym7aNy69nKkc796SSSivcXHETQKNwpJCdwnHpR3ExMlzSJBG2HbWYp1xp3DD3UrxVwLZ/KGzhmgSXBJbZufhzOkn3fWPKY8gKRWrcgnGfl0RMTDCDYBRewnGLqzCdjLmKLV+aBVNNus9pPPUYfWCNGkmrnM0DrnuT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2/FVXGDG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jpSbt0tAR10Q5c0DPZZ2W0/np43VEEStHe5T2lcPdiI=; b=2/FVXGDG9pkAamJ8vj3o4oehGW
	p3++0y875M2AUyl/1PxrAaQRdb/DNsKGhWWavr2Pcuv3FUiDKxXyQkBeRcO6OftjB2myCo0260PS7
	KjXSlXrgsgPBhXIE2O2O7r1Uhdfq/aPeWPN0eksxILndVRZsqojcf3IgUxKKCyYSTUOO9GD+ZX7Ec
	csoQLKzPXKDzorvPqsivYhHPlhGFYrdcW1QUMbz1JePdi1KikXCxUoyh/WhLlhC1B9VoqybF0kkgh
	axzP17Dy6hrD0PnJYGsqnxkN06DvBHUuEPNYkzeQ4gV1YA3LeBSX99uJ3Mhu0NBtm7rnQs7cY4FFM
	InyMpOmQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl8D2-0000000GN0G-3rwZ;
	Wed, 28 Jan 2026 16:16:01 +0000
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
Date: Wed, 28 Jan 2026 17:15:01 +0100
Message-ID: <20260128161517.666412-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128161517.666412-1-hch@lst.de>
References: <20260128161517.666412-1-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75757-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,oracle.com:email,samsung.com:email,infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D362A57FB
X-Rspamd-Action: no action

Add a set of helpers for file system initiated integrity information.
These include mempool backed allocations and verifying based on a passed
in sector and size which is often available from file system completion
routines.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
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


