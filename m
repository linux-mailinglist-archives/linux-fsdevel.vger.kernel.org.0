Return-Path: <linux-fsdevel+bounces-75764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LuGBWo4emkd4wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:25:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A485CA595E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CA443118CAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE1F313534;
	Wed, 28 Jan 2026 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Esgfg00P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98FE3093A8;
	Wed, 28 Jan 2026 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617002; cv=none; b=cyBRdjL5Dn1HEzZnGMYhrZL1X9EjV66UvPuU3nCN6GdsoIlwP8K7udbW0c7toN7X26urMEcEpycWNp1K6Sc0zATFLI4O/FhJVUdraEyr9+jCTGNrJNtCMPgOl9o7KvkZsKdbH6TSE6K7IhFZFrR4Gv7UTl1XgD02t9tKiHaHJyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617002; c=relaxed/simple;
	bh=HqvEHyvsh8JFh+oGy4J009I4RqSPT4FdfvRxt3nE7UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyO0DZ9R7z/b21pZPSmboWxQruX6pCRSc0MioZNujMSGeXfQh2raTkTHqNBYzfMlLIR0idfDG2tgwwY5bOgFysRYuWbmuR6k8n7RJ1aDWbExPLZ5L3cg/fsMGeL4UF5NIgXrhlbkaofa2qCnfcJAot7ItVzRctDCFdPsL30iGTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Esgfg00P; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZhFRZ+XgIG9F5vpX02p6cKkBJIRlITKQXrytAp6/Xs8=; b=Esgfg00PiC/jYu+ExdbEYV/KAz
	bt+LgiTQ/dzZmfAGraLlmiyTdNnjKMW09YM1F3fQmUAxeIj80efDu6YSRfCzfPLvCo2YxtwiSfGkI
	pZjzOzDLbjNmZa1gNypBuN+2CaYHCOnvBd19p+5+gtzMOR5jsyb/W8VBlvU7Kf7TAk7mOh+J2qdh3
	1vwd/9ZcObQv2AdlKk1ToEvAnDgTdtJQQvI2FWDBSQrL3MFMcs/8m1H0mWkjzjWFwFnPAC8fwtX7I
	b2Gi7VRDxsISDa8LJyU/1DKiNuHP+kH1INKFWVcbl5V4vdFmKfofylbEa+09ETDhgX3kHlRR6w093
	pYzgGTFA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl8Dg-0000000GN2Z-1ekP;
	Wed, 28 Jan 2026 16:16:40 +0000
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
Subject: [PATCH 13/15] iomap: support ioends for buffered reads
Date: Wed, 28 Jan 2026 17:15:08 +0100
Message-ID: <20260128161517.666412-14-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75764-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim,samsung.com:email,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: A485CA595E
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
index 800d12f45438..72f20e8c8893 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -36,7 +36,7 @@ EXPORT_SYMBOL_GPL(iomap_init_ioend);
  * state, release holds on bios, and finally free up memory.  Do not use the
  * ioend after this.
  */
-static u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
+static u32 iomap_finish_ioend_buffered_write(struct iomap_ioend *ioend)
 {
 	struct inode *inode = ioend->io_inode;
 	struct bio *bio = &ioend->io_bio;
@@ -68,7 +68,7 @@ static void ioend_writeback_end_bio(struct bio *bio)
 	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
 
 	ioend->io_error = blk_status_to_errno(bio->bi_status);
-	iomap_finish_ioend_buffered(ioend);
+	iomap_finish_ioend_buffered_write(ioend);
 }
 
 /*
@@ -260,7 +260,9 @@ static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
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


