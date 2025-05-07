Return-Path: <linux-fsdevel+bounces-48359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57596AADE11
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BC23BD85B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC5125D55F;
	Wed,  7 May 2025 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xn/w0PYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2241FF7B4;
	Wed,  7 May 2025 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619500; cv=none; b=XU5Ua5oVbN2nwTz6I6WBn4nW92YrPlOL47CgZT7fuk8QgOt4SjoKYcaEc5D0xy1GO8YgirbToUXuumjISBK4Z8QJt93tTSpYzniGY6OMcnJOMZtm53GI6GknDf6VFMJYcw4pPJCUis+26UQq/FS8SIFcjSgEu9oNKh5GLzf7N4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619500; c=relaxed/simple;
	bh=kWAvFnMe+9arwJUpwLWc7bDqJd6kgJkeCYPK3bgUCPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNY20BC0p5Yvwt3BPHJAv0rrlcbwgPklnQ2ed36E2Wza3yAOJl8409PhNdAyAhNNXiI7eqwVKdp9SosuzciQejIO0bOAiiDhkN9AKk4N3+qnAW+kU7KQRAaeb+P/m7GJNf89aWPHMoxH+msw6VEtLILlzQV9P9EleaiF4pPargY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xn/w0PYU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7sKBij/18hKZXL1goke5lA/hYCecXOSCKj1BCa9hfgI=; b=xn/w0PYUzYCMJjjPQwpFstCDJe
	SNECrG57m915CVtqG4SoWzBLvkcOEKwP9zdxAbadHd1mhiX2RBikip81gpOt/QX+0bg3k85RVfk2M
	8cfEsckHlhNRPiiz6ckYgnEOxpHhL8di/wdD78Um+jkunHE81YuDssD5NjahiCuDZMBVEPzTqOAKB
	NOseS5EoiceTlLxPKtE2bLQD5B9RyqCaNIQxP3Rep/O091xb8iwNrteJook0Qx0qcm3B5IaOvtgF7
	MoBbrerRbURo+iSL5/JPnbyskEQjnpyXUu3CXqYYJeqCPFvW+wHmxqWcraR6rzB8zYvtkyLRoiZR2
	rLKTz9MQ==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdWD-0000000FJ3s-41Bl;
	Wed, 07 May 2025 12:04:58 +0000
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
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 01/19] block: add a bio_add_virt_nofail helper
Date: Wed,  7 May 2025 14:04:25 +0200
Message-ID: <20250507120451.4000627-2-hch@lst.de>
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

Add a helper to add a directly mapped kernel virtual address to a
bio so that callers don't have to convert to pages or folios.

For now only the _nofail variant is provided as that is what all the
obvious callers want.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c         | 16 ++++++++++++++++
 include/linux/bio.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 1e42aefc7377..bd3d048d0a72 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -991,6 +991,22 @@ void __bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL_GPL(__bio_add_page);
 
+/**
+ * bio_add_virt_nofail - add data in the direct kernel mapping to a bio
+ * @bio: destination bio
+ * @vaddr: data to add
+ * @len: length of the data to add, may cross pages
+ *
+ * Add the data at @vaddr to @bio.  The caller must have ensure a segment
+ * is available for the added data.  No merging into an existing segment
+ * will be performed.
+ */
+void bio_add_virt_nofail(struct bio *bio, void *vaddr, unsigned len)
+{
+	__bio_add_page(bio, virt_to_page(vaddr), len, offset_in_page(vaddr));
+}
+EXPORT_SYMBOL_GPL(bio_add_virt_nofail);
+
 /**
  *	bio_add_page	-	attempt to add page(s) to bio
  *	@bio: destination bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index cafc7c215de8..acca7464080c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -417,6 +417,8 @@ void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
 			  size_t off);
+void bio_add_virt_nofail(struct bio *bio, void *vaddr, unsigned len);
+
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
-- 
2.47.2


