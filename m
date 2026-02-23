Return-Path: <linux-fsdevel+bounces-77942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGfGHsZVnGkAEQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:27:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DC1176D59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EC8730E6CAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B1E1FC7FB;
	Mon, 23 Feb 2026 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y0JGwaxc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6491E991B;
	Mon, 23 Feb 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852912; cv=none; b=XdrhR8gaMgl3xqkanWV7DCc/lMIUippvvW8AVy+SdCPAPgiM0zDRqwPAyPU3KoWGlfzBVhWL8j4MnYfGwDx6tnF9ui9EW5cBc7qot8zmX8p8AX62xaMAiG4zUtV4BztcdjXkvyuLktj8q0hkg7NToo3u+kF6lxerJyT79I3kM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852912; c=relaxed/simple;
	bh=bCkv+rcDKzK/XdV1dS+MEj6uGhMj1CDTItrGiW3Ag8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ed4CArorp8BPVlAYFYPuTCTHI5Hrs0OZO+8OSVP6KpwN2iqfuDGXdToMIEk/oXjyUQe6M+hg5O8NOFnXw1V5lGo2M0sFngR9rU3vfCWQpyVlpUYytf0nc3AotZ3BcpKQq8ars7meao5Rg9j+yB1jJN51Nq3Zs0xIUEQLiScVrPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y0JGwaxc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XwiW+MeTxlYy1GyjnYbCjaCzCpe2HMCBOPfkskdlg5o=; b=Y0JGwaxcQ6F1UKo0ZnSrMlxi4a
	NZP/mYuHX723IZLNISu+0kYvFvMxpVOBlgzdVS0sRchtKq63Rk7DX099MkvdluZOMn1VeBSqfnIR/
	qLUTDSVtgDHE3oQ6grCH8wFxyPFqxS/g8kZFPM9zmNXbZ1j0QJW36P87/5t7PpUwriNz4/y5+ccch
	ADUIAqn5bBA0A3uPycrl1iZhUjxXHnYOBAQ4yxB4r4bfFRJ5JXh1BeyrbrXC6ws3e/78jjq4122Y4
	eeXXUnCXbyVYcQ1klR5WpAgSXtl/3hSwjVPb5LRowRj/inAlFazWnbc13JWSakedPWq4ydUs787ot
	WzPDLWcA==;
Received: from [94.156.175.41] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuVsh-00000000Lws-3acm;
	Mon, 23 Feb 2026 13:21:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 06/16] block: add fs_bio_integrity helpers
Date: Mon, 23 Feb 2026 05:20:06 -0800
Message-ID: <20260223132021.292832-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223132021.292832-1-hch@lst.de>
References: <20260223132021.292832-1-hch@lst.de>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-77942-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,oracle.com:email,samsung.com:email,lst.de:mid,lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12DC1176D59
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


