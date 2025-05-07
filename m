Return-Path: <linux-fsdevel+bounces-48375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9927AAADE93
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B186E1C270E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038C4269D0A;
	Wed,  7 May 2025 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jDZFDP3J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1032425D8E0;
	Wed,  7 May 2025 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619548; cv=none; b=Qezmh3+srnj4vIR/R686xXC2ep1d4mpGKDERS8GE2ORVB4SU0yxOoU6AbK0A1dXTclsnUKhgHn+wBMYL8jpohcN04Q86qpW4ZxibZemgQ+yPOUvDlnVWQ4yiu1+OYVskbfEIjBnNI1SC4LayemrtFjTRTS09SMujv/Fpp+ij3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619548; c=relaxed/simple;
	bh=PaJF1GSpdqKNoC4hFMOWo7SdZXIGfiJbGCSKb0zF8qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtIf0y6j/AcNprwJ1s9nq3ptk/MxRbcLO4Kqo14bthUrwa8Z7MQ5AVTZzLbDUskON3T0b+WqO7JSPC4cByuOXm7DKVwjSzTMFAknu8ayJAYbdzOXGrOqkSK7C3hXDmm9KVuYoXfOK218YRbyYIgrDLum6ijcUkpO8E5TCOqEgNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jDZFDP3J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ld81vmoUNiONAWvg9634g5/kPyF3d3aITw58P5WNE90=; b=jDZFDP3JCm8wPUulPhju8RoGmx
	oI1R7YcsqxV2YCIV522gd4iMNKtH6rZS6L+l4/3KzSPxzJVmy9V8xOVAqpiEnNIRmcDLkrir3gBZi
	m7YRyX3k+INcHNJWOz2tQuj2/AL9KMbjn8Vee0miFEndSHg1CQb/4e8NBDAo/DCyq4E7jw8O/0fQr
	nKzOr90K01X6E0WjQ6mVXooIakizWDRpeJav+afw9ILoP27KoqnL3kACqFQPbYinSiTD4MgOWXip+
	bwFJFXIOaTJRml8PNk6Th3QooooROXvHVa0JoHMwbwzcZXt2svCJrtUaRyB79qMR/MisRoM4Ybo12
	kNOdquyQ==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdX0-0000000FJIr-0Kh7;
	Wed, 07 May 2025 12:05:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 17/19] xfs: simplify building the bio in xlog_write_iclog
Date: Wed,  7 May 2025 14:04:41 +0200
Message-ID: <20250507120451.4000627-18-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507120451.4000627-1-hch@lst.de>
References: <20250507120451.4000627-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use the bio_add_virt_nofail and bio_add_vmalloc helpers to abstract
away the details of the memory allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_log.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 980aabc49512..793468b4d30d 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1607,27 +1607,6 @@ xlog_bio_end_io(
 		   &iclog->ic_end_io_work);
 }
 
-static int
-xlog_map_iclog_data(
-	struct bio		*bio,
-	void			*data,
-	size_t			count)
-{
-	do {
-		struct page	*page = kmem_to_page(data);
-		unsigned int	off = offset_in_page(data);
-		size_t		len = min_t(size_t, count, PAGE_SIZE - off);
-
-		if (bio_add_page(bio, page, len, off) != len)
-			return -EIO;
-
-		data += len;
-		count -= len;
-	} while (count);
-
-	return 0;
-}
-
 STATIC void
 xlog_write_iclog(
 	struct xlog		*log,
@@ -1693,11 +1672,12 @@ xlog_write_iclog(
 
 	iclog->ic_flags &= ~(XLOG_ICL_NEED_FLUSH | XLOG_ICL_NEED_FUA);
 
-	if (xlog_map_iclog_data(&iclog->ic_bio, iclog->ic_data, count))
-		goto shutdown;
-
-	if (is_vmalloc_addr(iclog->ic_data))
-		flush_kernel_vmap_range(iclog->ic_data, count);
+	if (is_vmalloc_addr(iclog->ic_data)) {
+		if (!bio_add_vmalloc(&iclog->ic_bio, iclog->ic_data, count))
+			goto shutdown;
+	} else {
+		bio_add_virt_nofail(&iclog->ic_bio, iclog->ic_data, count);
+	}
 
 	/*
 	 * If this log buffer would straddle the end of the log we will have
-- 
2.47.2


