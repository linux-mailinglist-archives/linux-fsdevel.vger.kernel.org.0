Return-Path: <linux-fsdevel+bounces-77950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCFLIhZWnGkAEQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:28:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A60176DE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E3533064BCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5AA1DE8BE;
	Mon, 23 Feb 2026 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FmO63jLQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ABC883F;
	Mon, 23 Feb 2026 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853011; cv=none; b=p6Xeav6E8vIhBn4YapWOQwGy9P8aFE3vSM/7tT9IotTP3bPXuXyeeDHFegFcCKMmpdLJCb7u5cgke9rmADCt+cEP1zqadLYSsUbbdXAFBxSyZE0iAiZAUbigd2WmiRK08CWPkkT4+PJavFYd9QuBeD23rDJWRzC+V35ewZe7nmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853011; c=relaxed/simple;
	bh=OQabbqWhjC9e55rpxrMhHPgQR6QrNg8bPq/NfmF3dMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSjdXIahuLYteGZvVipPwoSpne3KuE16TLMBxDqeYluPM/ftEcperOei3T+nn/kVHyyGpyO4DXyaQ9A9Jx+k9XNxp/wP/E+0/Z7LfsJfbPE8vrujAzJrOFv6uTQHCzf8aKTNVhXE5Gf+3sNQg+dpzw+hZMv7ly9ptTHMesWTa74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FmO63jLQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Q9SWKGikV9J4BIuZzTfJI/5QtAsEWKOEmo9u48iCeeI=; b=FmO63jLQu+Z93yeTtB55YRR1iH
	S+vQdcKrzRzjrhyJnMlUYG5OLT1CEzJu7nMAR5lUgmzQpCyXw0UhcYEED0XB8+T7k47Pdxqd+YQll
	OWur2AYeBBIzYJlVs1yAQ7yy7ctyQMqv6Qomi/06B6i4Xz6xB9iLEcSxL5xH89v7YshmkfaX/iGak
	5Y5oBb7KYP7OQ4RepXNY1C6K+vemLQJoq0eI80Ie0lV/vDAjtiiQaaeoPf1HWh82BH5tgGkpka76r
	N17h5NHdy15UkmU9jNovKAUPfklZLCnkRM3ziSJi0fdXLhTgdxPalYES4VHq2vrOE4iA1yavgD08r
	K7yQtDDA==;
Received: from [94.156.175.41] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuVuJ-00000000M7g-3LMD;
	Mon, 23 Feb 2026 13:23:29 +0000
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
Subject: [PATCH 14/16] iomap: support ioends for buffered reads
Date: Mon, 23 Feb 2026 05:20:14 -0800
Message-ID: <20260223132021.292832-15-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-77950-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,lst.de:mid,lst.de:email,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36A60176DE2
X-Rspamd-Action: no action

Support using the ioend structure to defer I/O completion for
buffered reads by calling into the buffered read I/O completion
handler from iomap_finish_ioend.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/iomap/bio.c      | 19 ++++++++++++++++---
 fs/iomap/internal.h |  1 +
 fs/iomap/ioend.c    |  8 +++++---
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
index 259a2bf95a43..b4de67bdd513 100644
--- a/fs/iomap/bio.c
+++ b/fs/iomap/bio.c
@@ -8,14 +8,27 @@
 #include "internal.h"
 #include "trace.h"
 
-static void iomap_read_end_io(struct bio *bio)
+static u32 __iomap_read_end_io(struct bio *bio, int error)
 {
-	int error = blk_status_to_errno(bio->bi_status);
 	struct folio_iter fi;
+	u32 folio_count = 0;
 
-	bio_for_each_folio_all(fi, bio)
+	bio_for_each_folio_all(fi, bio) {
 		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
+		folio_count++;
+	}
 	bio_put(bio);
+	return folio_count;
+}
+
+static void iomap_read_end_io(struct bio *bio)
+{
+	__iomap_read_end_io(bio, blk_status_to_errno(bio->bi_status));
+}
+
+u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend)
+{
+	return __iomap_read_end_io(&ioend->io_bio, ioend->io_error);
 }
 
 static void iomap_bio_submit_read(const struct iomap_iter *iter,
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index 3a4e4aad2bd1..b39dbc17e3f0 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -4,6 +4,7 @@
 
 #define IOEND_BATCH_SIZE	4096
 
+u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend);
 u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
 
 #ifdef CONFIG_BLOCK
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index e4d57cb969f1..c6b6cd0f2fdd 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -37,7 +37,7 @@ EXPORT_SYMBOL_GPL(iomap_init_ioend);
  * state, release holds on bios, and finally free up memory.  Do not use the
  * ioend after this.
  */
-static u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
+static u32 iomap_finish_ioend_buffered_write(struct iomap_ioend *ioend)
 {
 	struct inode *inode = ioend->io_inode;
 	struct bio *bio = &ioend->io_bio;
@@ -74,7 +74,7 @@ static void ioend_writeback_end_bio(struct bio *bio)
 	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
 
 	ioend->io_error = blk_status_to_errno(bio->bi_status);
-	iomap_finish_ioend_buffered(ioend);
+	iomap_finish_ioend_buffered_write(ioend);
 }
 
 /*
@@ -266,7 +266,9 @@ static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 		return 0;
 	if (ioend->io_flags & IOMAP_IOEND_DIRECT)
 		return iomap_finish_ioend_direct(ioend);
-	return iomap_finish_ioend_buffered(ioend);
+	if (bio_op(&ioend->io_bio) == REQ_OP_READ)
+		return iomap_finish_ioend_buffered_read(ioend);
+	return iomap_finish_ioend_buffered_write(ioend);
 }
 
 /*
-- 
2.47.3


