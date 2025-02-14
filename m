Return-Path: <linux-fsdevel+bounces-41731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC33FA36272
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C437A3DC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 15:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BF6267B0F;
	Fri, 14 Feb 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EXqpZLNt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E52526738A;
	Fri, 14 Feb 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548644; cv=none; b=tUT5v5NL3gZImHffhBmlWoE31bZoYD6Fj9nRcghfOnEMcmWax6ng8bbpFBaFg/LFprG01+/Yltckl6kjcp0lq+ZIBT1ujpoxXBa1XMEkVNSG0ogsgs17XgC5PHTuP3aNb7+jcPp6ZZ8LrskzcSl0/qh2eTDYRj8/l6/9/2HJxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548644; c=relaxed/simple;
	bh=muOdRkGDwEUnzBGQsk7UmE5rrVjfZS8VOqSo0u1P9+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsZqrloGxaTuBX/XoniaqnDbMJVp0wLy4B2K5xxQoR5ErUXPFejH4Dp8ZA6F6QXwb0656CRIOZLmLUY88Xmnycnzt3wVcXIx3mqKQ4mCaZ0/zxccafZiCJMS/Yo4JVafiWjoVGD6MGVSEXlR6r+XFQqthjnclXh4SKqxsqGLMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EXqpZLNt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=AYAc7B4ukyBFc0II/FT4cbS4Kv+k7LbDS2G9S7Ve4CI=; b=EXqpZLNt/pbdRW4WGBxg4xPaaP
	YovZQA6G0uTss2+TIWbKv4ut1kYE0MKI7e3kIahfZCb97CmX6aW2q1sOPJyr6qaqF3xMHkpJspYWS
	yfqew5W8x5WFP4KmuIf67ckc6v2znYubQ1qt0+C8tWmTMvgTsJDTzBYRRQdvY+x51L84S8DiRgODq
	2wQrmi+kGymJ7IyVwLxDRUjjOEuT4sIO3tzjTloZZKky90vSWaz9UVhZYM/Fd14QcqPjpMgiQltM3
	ZtfQ7zHHyDyzg5tNeX+C4d/sYcpxd0NwOcrlUjSlGZGVDH0Le3LdZgdqrnrYKxQVrthlcR3Azer4y
	sLB4/YXg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiy40-0000000BhyJ-23zP;
	Fri, 14 Feb 2025 15:57:12 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v2 2/7] ceph: Remove ceph_writepage()
Date: Fri, 14 Feb 2025 15:57:04 +0000
Message-ID: <20250214155710.2790505-3-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214155710.2790505-1-willy@infradead.org>
References: <20250214155710.2790505-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ceph already has a writepages operation which is preferred over writepage
in all situations except for page migration.  By adding a migrate_folio
operation, there will be no situations in which ->writepage should
be called.  filemap_migrate_folio() is an appropriate operation to use
because the ceph data stored in folio->private does not contain any
reference to the memory address of the folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 80bc0cbacd7a..9b972251881a 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -820,32 +820,6 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	return err;
 }
 
-static int ceph_writepage(struct page *page, struct writeback_control *wbc)
-{
-	int err;
-	struct inode *inode = page->mapping->host;
-	BUG_ON(!inode);
-	ihold(inode);
-
-	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    ceph_inode_to_fs_client(inode)->write_congested) {
-		redirty_page_for_writepage(wbc, page);
-		return AOP_WRITEPAGE_ACTIVATE;
-	}
-
-	folio_wait_private_2(page_folio(page)); /* [DEPRECATED] */
-
-	err = writepage_nounlock(page, wbc);
-	if (err == -ERESTARTSYS) {
-		/* direct memory reclaimer was killed by SIGKILL. return 0
-		 * to prevent caller from setting mapping/page error */
-		err = 0;
-	}
-	unlock_page(page);
-	iput(inode);
-	return err;
-}
-
 /*
  * async writeback completion handler.
  *
@@ -1597,7 +1571,6 @@ static int ceph_write_end(struct file *file, struct address_space *mapping,
 const struct address_space_operations ceph_aops = {
 	.read_folio = netfs_read_folio,
 	.readahead = netfs_readahead,
-	.writepage = ceph_writepage,
 	.writepages = ceph_writepages_start,
 	.write_begin = ceph_write_begin,
 	.write_end = ceph_write_end,
@@ -1605,6 +1578,7 @@ const struct address_space_operations ceph_aops = {
 	.invalidate_folio = ceph_invalidate_folio,
 	.release_folio = netfs_release_folio,
 	.direct_IO = noop_direct_IO,
+	.migrate_folio = filemap_migrate_folio,
 };
 
 static void ceph_block_sigs(sigset_t *oldset)
-- 
2.47.2


