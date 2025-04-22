Return-Path: <linux-fsdevel+bounces-46958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F55A96E66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E39B4407D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC1D28A3F8;
	Tue, 22 Apr 2025 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mW2jCIel"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6CB2857EA;
	Tue, 22 Apr 2025 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331998; cv=none; b=VcU9R/1iOdrx+VWSJSGGZqhm5agGyRwkr0qsz2Gj7hFzRTldg41dVglw5j7u93HW3I6cSe51gd84p8owwvrsWp1ytny/uyQCr+bYegNUXZ0chwMi/jXLr+P6hwZGzxcKU0Q/xUxv5V8MEoe8S+Otzyz/+mwFGdDxvwYnFliQ25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331998; c=relaxed/simple;
	bh=HWK/Svwe9kRih2a7pRghHBSIUN3wwU8r4xV0EcIgci8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/58X9XlaqGkMH9xhWPgx3pm+Tqns3QaDJ1OztzcmfPDCrBX2cVLraBmk8ygEpNJFHJMTlQlv0VzXBOTYnOkINSntIYUWdNycaCK9eEPz32O6zv00QRcaXVznTnwP6NNz12fjtE/iunSGpEf+kytJQDdBbx3tpSCpMtIveJmSy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mW2jCIel; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=l/F4z/tDIO8fCjZT51bLPvoe5UaAe6WQER3MP3GDa3c=; b=mW2jCIelm5DcNyEWyn/zpgTPNV
	mdfKMHSzjicLqj4akBGNgyo0rc4DaNcpA/T1zRk+c8NPsdG72Yg+YapJIU2mW/H9oIkRV2ll4QjQx
	oSsZolpbKIdZcxWeGbFpBqaMbU0C3HEoOc0HV+yqCwNk5WL23lRer+WNyrAHnxelBS2f+B4QcylOI
	9QVK6U7KpOUS5T3dLmnLgcG1wSwKuYA4a34TCdPVn/ePR643/TBu/Jlruv0OSwbjUzk4iAdmEvb32
	G1LB+wXMfcdZNkvrSBhu8uSIGqAKloU4YQRCbx21kPo+UaMwmRTB1ySkrL3ErQu22Nij5ik+UyMdd
	VlEVOjgg==;
Received: from [2001:4bb8:2fc:38c3:78fb:84a5:c78c:68b6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Ea3-00000007U9a-1NrP;
	Tue, 22 Apr 2025 14:26:36 +0000
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
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 01/17] block: add a bio_add_virt_nofail helper
Date: Tue, 22 Apr 2025 16:26:02 +0200
Message-ID: <20250422142628.1553523-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250422142628.1553523-1-hch@lst.de>
References: <20250422142628.1553523-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a helper to add a directly mapped kernel virtual address to a
bio so that callers don't have to convert to pages or folios.

For now only the _nofail variant is provided as that is what all the
obvious callers want.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index cafc7c215de8..0678b67162ee 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -417,6 +417,23 @@ void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
 			  size_t off);
+
+/**
+ * bio_add_virt_nofail - add data in the diret kernel mapping to a bio
+ * @bio: destination bio
+ * @vaddr: data to add
+ * @len: length of the data to add, may cross pages
+ *
+ * Add the data at @vaddr to @bio.  The caller must have ensure a segment
+ * is available for the added data.  No merging into an existing segment
+ * will be performed.
+ */
+static inline void bio_add_virt_nofail(struct bio *bio, void *vaddr,
+		unsigned len)
+{
+	__bio_add_page(bio, virt_to_page(vaddr), len, offset_in_page(vaddr));
+}
+
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
-- 
2.47.2


