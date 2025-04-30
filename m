Return-Path: <linux-fsdevel+bounces-47782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8895CAA573F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8089C7BD8C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7C02DA103;
	Wed, 30 Apr 2025 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RNLLtJAj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194432D112D;
	Wed, 30 Apr 2025 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048173; cv=none; b=WaybH7m3Fi3EtchpqonGfLksZxWCWERdvEishrkECBWteYmLaTWaTfmvLsCXhSmqNj/yVK78SrFYq13193F0E2FtwJh9eMbGq7+RQ7r71Q/KIlcCB4tVw4qL1773Zsy2RWlFZ/CFmnLZiWg63DvYcJxKGzs5Kg7ELDm8gfzfFpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048173; c=relaxed/simple;
	bh=OIT8D9UFNb1d9Dlz/Os+jQxbR9HnKrh9qihmM3kgHaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0c3Ki7gqpmZkREaanlPzcrGulaCh7cKQM2fI5vEBa+6eaK+ktDQ75X2kGrgaGIgRCcsfSrvflQ8y9kbrRj8ofMhDZHY9/QHyjdjsLtCgEM+xv54UTJkX4RfFAa0+mP9+66Dx9ey28qHbKJfPsRTgsdeQnJqsO20sHx4jcKsYyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RNLLtJAj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8Wl4BvCSQnbrRkqv5IxIf4BMJ33yPY3XcI6p9wrRSLI=; b=RNLLtJAjv+/ELmsv+fDIWLR1uh
	kWB/8jaQvCBKDq4LoN9vYMOQftnDgLBfNVYMdJ1rAXaoBGwmDRn0A4AiU2OMD8l5ZAjI/wLplIlRF
	zezfkrtliTRImKOdQ7u251njeslfP9RHQghoCZiaJ8y3k6Hs1qzQyU9GhC9Fj9EghldsunNCaWSTL
	EzzGGH7iNzkkugFyAZZDdgrT3eeykboFePOCRUpgrHjV8d14Qlz0anM/LLSELy/J0QNn3G8bZgfGo
	dxtrIN1vPSORhJYCdP4HHwuH1fIyWW2mSqfsvaUZbj79ufnVNzJ0Yzg3sd/vJAc01QdicIMOYcXAH
	4/306wsQ==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEtH-0000000E2iS-0XO6;
	Wed, 30 Apr 2025 21:22:51 +0000
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
	linux-pm@vger.kernel.org
Subject: [PATCH 17/19] xfs: simplify building the bio in xlog_write_iclog
Date: Wed, 30 Apr 2025 16:21:47 -0500
Message-ID: <20250430212159.2865803-18-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430212159.2865803-1-hch@lst.de>
References: <20250430212159.2865803-1-hch@lst.de>
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


