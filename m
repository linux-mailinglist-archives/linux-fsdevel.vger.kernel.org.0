Return-Path: <linux-fsdevel+bounces-17251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FD78A9D3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 16:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D49286A7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88741DFD8;
	Thu, 18 Apr 2024 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ugFWRl7H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF83137761
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451083; cv=none; b=IDkpO+RKVB/pj2JVAQRVBGQUoktSbPl9N7tGVjXnA6gWd1NE22iNc8Jtb8IFQ90SdpXcbfEdk5CXyiKm7gZlQoR5fT8YzTRcyYwIp+Gxfl39lXorQ1FxREEFWD6qG2Mu+qv5w8mm+j6ML6CtKkA9o/ZKcPbrFofbpMGUy0U0QfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451083; c=relaxed/simple;
	bh=eKT0YaMllCNQB6rz3VP0XVmqW5UyK3WdeT2JU79gv4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijoQkH+XkWOfVT7BtS9ymAow30NyReIbpcc26u9BpHSjKb76/XKcGJFXJY2k70cxcxsD8T0E4tuOzRzF2byDEhg/SYjIsWBi7STGkPTSDCHwbNeNj6xtpuf4IPWXoN13gHIZQKVpAmzmM4DgNE8MW5VFIL6Az6GErenn05zrY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ugFWRl7H; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QmzrnFm2hYgFZI9nVWXU3Upsx9CwQLwwmsJrr2bs+0E=; b=ugFWRl7HzO/eGM2/AYgWdIgtNr
	W/fjYU0Ti6h5xMhS/GptgLhp5u14Ux2NMpwU3t5V9f4KlLPsuBX+MtCTOeUbTVuJn6KP2jYN2ugLR
	tOJ2i86ZZZuNPShGSlFz5lQrzw/822ykcewe3Z+L7rIL4h41P6sJliEvBfPdd0E44ikDe38yakR1Q
	wcCY4BQ0IR6iMXmqz6mmIuP3ZdPAjQ/yYzs5qgW1M/3tyH9dYg4gjQOBZEVm44FPMKptgHyENwT+k
	STlt0i1aSTNM/nxfYRY2lxRmzGam4krf3yHnRAtctKWuwGYi77D9obLiMxysjKBK+d9ApUvETBvzB
	uGcn6Gnw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxStj-00000005X6O-2dI2;
	Thu, 18 Apr 2024 14:37:59 +0000
Date: Thu, 18 Apr 2024 15:37:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 14/13] jfs: Stop using PG_error
Message-ID: <ZiEwRzu_H3pfs5pa@casper.infradead.org>
References: <20240417175659.818299-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417175659.818299-1-willy@infradead.org>

Jan pointed out that I'm really close to being able to remove PG_error
entirely with just jfs and btrfs still testing the flag.  So here's an
attempt to remove use of the PG_error from JFS.  We only need to
remember the 'status' if we have multiple metapage blocks per host page,
so I keep it in the meta_anchor.

What do you think?

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 19854bd8dfea..df575a873ec6 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -76,6 +76,7 @@ static mempool_t *metapage_mempool;
 struct meta_anchor {
 	int mp_count;
 	atomic_t io_count;
+	blk_status_t status;
 	struct metapage *mp[MPS_PER_PAGE];
 };
 
@@ -138,12 +139,16 @@ static inline void inc_io(struct folio *folio)
 	atomic_inc(&anchor->io_count);
 }
 
-static inline void dec_io(struct folio *folio, void (*handler) (struct folio *))
+static inline void dec_io(struct folio *folio, blk_status_t status,
+		void (*handler)(struct folio *, blk_status_t))
 {
 	struct meta_anchor *anchor = folio->private;
 
+	if (anchor->status == BLK_STS_OK)
+		anchor->status = status;
+
 	if (atomic_dec_and_test(&anchor->io_count))
-		handler(folio);
+		handler(folio, anchor->status);
 }
 
 #else
@@ -168,7 +173,7 @@ static inline void remove_metapage(struct folio *folio, struct metapage *mp)
 }
 
 #define inc_io(folio) do {} while(0)
-#define dec_io(folio, handler) handler(folio)
+#define dec_io(folio, status, handler) handler(folio, status)
 
 #endif
 
@@ -258,23 +263,20 @@ static sector_t metapage_get_blocks(struct inode *inode, sector_t lblock,
 	return lblock;
 }
 
-static void last_read_complete(struct folio *folio)
+static void last_read_complete(struct folio *folio, blk_status_t status)
 {
-	if (!folio_test_error(folio))
-		folio_mark_uptodate(folio);
-	folio_unlock(folio);
+	if (status)
+		printk(KERN_ERR "Read error %d at %#llx\n", status,
+				folio_pos(folio));
+
+	folio_end_read(folio, status == 0);
 }
 
 static void metapage_read_end_io(struct bio *bio)
 {
 	struct folio *folio = bio->bi_private;
 
-	if (bio->bi_status) {
-		printk(KERN_ERR "metapage_read_end_io: I/O error\n");
-		folio_set_error(folio);
-	}
-
-	dec_io(folio, last_read_complete);
+	dec_io(folio, bio->bi_status, last_read_complete);
 	bio_put(bio);
 }
 
@@ -300,11 +302,17 @@ static void remove_from_logsync(struct metapage *mp)
 	LOGSYNC_UNLOCK(log, flags);
 }
 
-static void last_write_complete(struct folio *folio)
+static void last_write_complete(struct folio *folio, blk_status_t status)
 {
 	struct metapage *mp;
 	unsigned int offset;
 
+	if (status) {
+		int err = blk_status_to_errno(status);
+		printk(KERN_ERR "metapage_write_end_io: I/O error\n");
+		mapping_set_error(folio->mapping, err);
+	}
+
 	for (offset = 0; offset < PAGE_SIZE; offset += PSIZE) {
 		mp = folio_to_mp(folio, offset);
 		if (mp && test_bit(META_io, &mp->flag)) {
@@ -326,12 +334,7 @@ static void metapage_write_end_io(struct bio *bio)
 
 	BUG_ON(!folio->private);
 
-	if (bio->bi_status) {
-		int err = blk_status_to_errno(bio->bi_status);
-		printk(KERN_ERR "metapage_write_end_io: I/O error\n");
-		mapping_set_error(folio->mapping, err);
-	}
-	dec_io(folio, last_write_complete);
+	dec_io(folio, bio->bi_status, last_write_complete);
 	bio_put(bio);
 }
 
@@ -454,10 +457,10 @@ static int metapage_write_folio(struct folio *folio,
 		       4, bio, sizeof(*bio), 0);
 	bio_put(bio);
 	folio_unlock(folio);
-	dec_io(folio, last_write_complete);
+	dec_io(folio, BLK_STS_OK, last_write_complete);
 err_out:
 	while (bad_blocks--)
-		dec_io(folio, last_write_complete);
+		dec_io(folio, BLK_STS_OK, last_write_complete);
 	return -EIO;
 }
 

