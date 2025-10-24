Return-Path: <linux-fsdevel+bounces-65429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB6CC04F5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57CA04EDF11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 08:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5074D3019B6;
	Fri, 24 Oct 2025 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pNGaYHZT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284342FDC49;
	Fri, 24 Oct 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293154; cv=none; b=e7BeZ5Sc/zjUqPJx8eB1C/7nWptTNhDhDuUSnRrlNFQ0TulJSb06ruoyTZGSE1XI8CRScVIdytKN5E29A0XEx28w7mKuilUW65JBImtty99uqmxS7X43vbeI9l54CeJU4rLP3ZQzmzT2wJUDnW1DItT3b2lFPq/IiLv5bkYp7aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293154; c=relaxed/simple;
	bh=G+6wz45u0Pbf6VyUvfXh67FbXBeYnJMel7Aj07thAug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvVXOsrv2KFRDG9qlaXXnLvnBg/ZLzzLiDLAB9DMyKu/hZ8qC8DEqxPcdQgu5SF9mOSrOOW0mMaOTxZ2/8owG/5glvLAg7j1U5sGyBkjP5JJOVETcKdK+2eDYNbdKxC6R9YPNvhTdym9rw77IBYPb3U29CrvrZTh6WWkvVFhtDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pNGaYHZT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lGL2Ky/C5f4WiPo4ACDgwQE673KFrCXkKYNJpYlApDo=; b=pNGaYHZT2+pEkbOmqAAuHzvUCY
	tL+VPQrUf1wIiycXsLWAqp8LOwyNz/F/8Gyzm1vIoTBdLo3LCJqN2owwz5U/LKkNDJI7h3wkLL2pQ
	p7noeGxTFVC1xVvd3Fn2u+oSLeixgvFYYF6Iy38VjyFBUg/mEeTHgr/LW8dixMdJCsSHsa8b5eagY
	xknkONy2wiR1pQsf+fsTx/rCvWBzlNZEe0m4wfUB1t+0jQcRm1XV4/gkpMEdlWXKuA6Ii637MPEHv
	tVtn25mSzhPIhd/D5tHvzKcqOW6NXroJMKo/LL+BlrD6Adqnz9xwD7m3PBTdTzySidh5rfGx7yC5/
	H22fIynA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCCo1-00000008cGu-2B7Q;
	Fri, 24 Oct 2025 08:05:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	ocfs2-devel@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 07/10] mm: remove __filemap_fdatawrite
Date: Fri, 24 Oct 2025 10:04:18 +0200
Message-ID: <20251024080431.324236-8-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024080431.324236-1-hch@lst.de>
References: <20251024080431.324236-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

And rewrite filemap_fdatawrite to use filemap_fdatawrite_range instead
to have a simpler call chain.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 mm/filemap.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index e344b79a012d..3d4c4a96c586 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -422,25 +422,19 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 	return filemap_fdatawrite_wbc(mapping, &wbc);
 }
 
-static inline int __filemap_fdatawrite(struct address_space *mapping,
-	int sync_mode)
+int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
+		loff_t end)
 {
-	return __filemap_fdatawrite_range(mapping, 0, LLONG_MAX, sync_mode);
+	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_ALL);
 }
+EXPORT_SYMBOL(filemap_fdatawrite_range);
 
 int filemap_fdatawrite(struct address_space *mapping)
 {
-	return __filemap_fdatawrite(mapping, WB_SYNC_ALL);
+	return filemap_fdatawrite_range(mapping, 0, LLONG_MAX);
 }
 EXPORT_SYMBOL(filemap_fdatawrite);
 
-int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
-				loff_t end)
-{
-	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_ALL);
-}
-EXPORT_SYMBOL(filemap_fdatawrite_range);
-
 /**
  * filemap_fdatawrite_range_kick - start writeback on a range
  * @mapping:	target address_space
@@ -470,7 +464,7 @@ EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
  */
 int filemap_flush(struct address_space *mapping)
 {
-	return __filemap_fdatawrite(mapping, WB_SYNC_NONE);
+	return filemap_fdatawrite_range_kick(mapping, 0, LLONG_MAX);
 }
 EXPORT_SYMBOL(filemap_flush);
 
-- 
2.47.3


