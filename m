Return-Path: <linux-fsdevel+bounces-74809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OPKC8V3cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:52:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C48F852650
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 521FF7412BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A73E44D682;
	Wed, 21 Jan 2026 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OuaikYK4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D0644CAC5;
	Wed, 21 Jan 2026 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977890; cv=none; b=mhS0meZ/Kwpe3Gpjranz32zdQCJUt+6IJJAgopEIsBPcR8xnL0MFUuDXzwoI4xbn4ARMmqiGJfWd3vIW/AyMuM2X1SUx6UVKZtFceEp0rS3FqYizwdQgAfbjkOv9r41U18lU1beL4v0xRvsxansk8WM5YQu4jEeD/cow2xGPAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977890; c=relaxed/simple;
	bh=eh0TkDcgUnlysat9gPqYRAhb83fJWj2v3UQ6Ss8S/lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gswfk7pwZ6ZrnsKJsIUnnpAh2HKHj+JbAVi710ut+/D+wOZ3N0yefyTpzfH7bYFDzDpuLI47Nd4nIJBjMYYMQIMwNvTw+EQuRJHrpuJt4+/9E/EUsOL7vDS0p9YPJ7K3YX4++uoixX/vr34RSVvODxF5pcwZmicNt5xft+Bf2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OuaikYK4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=m3uJFAe6Nwm8oxIVrtYyptHAtOGhUNvoxTqgDgk391s=; b=OuaikYK40BmCYHqLqurAEGiCti
	kmpzkIN8Y3WukDR4Ls/W0cTc4lFmtyefY63cbtXj3oVBeZcOEupzpRIF07fz1GzC6faOsURQlbfbX
	LycmHupeTppcf2DcOveNTj8MqUEU3Aa3a1DhxkOT63ysz82I7bQ+oNlx/iG7sbFJCFPRhCrBmUYay
	gmAFdCkSLGOqATNMQ731n79RVn4AWuvAv6cbTiua1kSsbTrlSgcHuYuHJiQgHo+q8URfprJo931Ac
	Ft807H8vk7nJnVoiMxEwLKvoOd8RjNxAktFCz5Rvjaj6Pl4lh6GsqFErqzutQWKaduCbxIQ7RjGIb
	5kGeTPsw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viRxN-00000004xei-45qa;
	Wed, 21 Jan 2026 06:44:46 +0000
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
Date: Wed, 21 Jan 2026 07:43:21 +0100
Message-ID: <20260121064339.206019-14-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121064339.206019-1-hch@lst.de>
References: <20260121064339.206019-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-74809-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,lst.de:email,lst.de:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: C48F852650
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Support using the ioend structure to defer I/O completion for
buffered reads by calling into the buffered read I/O completion
handler from iomap_finish_ioend.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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


