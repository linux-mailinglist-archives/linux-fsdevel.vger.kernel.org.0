Return-Path: <linux-fsdevel+bounces-41886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB8BA38B99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2CA3B4059
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2156F237705;
	Mon, 17 Feb 2025 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WjHNGbd+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FA7237708;
	Mon, 17 Feb 2025 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818287; cv=none; b=dFAMUNQS1Zz9EA3oKD/q47FPDqqOwoWrFpRfI+sOzQvcq8TtaOVibtQJH4A1s1IFl4tvh4PU6ouHgmPFywRd5eLzJA4Uh5Zf5FtX2woEitBc625f1XVpNUKdFwl+J5np+zYDZVU4xUb7VyhTnhWmUvcs2ZWKvObvxsEKQQJWuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818287; c=relaxed/simple;
	bh=/aZ9KxDO0+CT55cwnMECln9jnRuyUJUkGYCOCvBjWvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNgvYEOU6BM2dwpauJ9dOM7TH990uhegTfhY6No9oN32TTKe95x+Edop6SbjZm4aZbTOtlb35mOxv1gNpzR9mUcy8+C/LzEYDuC/B24rWlbwBvmUarWL2iJPPRRcaBthko9JgD43Jw3Z9TbUAM4V3ONgDLUl87apno+woeTAbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WjHNGbd+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=43YiqePgIAjXaPnBKT44VEq/hCrHaFMvycXoABjek6Q=; b=WjHNGbd+g2rGOaD0RYrT/iut09
	HW4vRxuYWprDjZxJN8FVotFeMct8SwsKXGL9vdqYHbknOqZy3Q3v5fLy95ZeREZDBv6/favfr330E
	/NHBpUC3niFQKF68fYwujX936RSNEHih/Vp00O/0KU5QAKjHgulaeyZQwW6V+Hwx/9mlvADX4j13Z
	U1HQ/NsE9Z707mEfhPd5AOPaRzwcMbXZ1X2i4pjX2VliZ5+4wFcHcVcT+F3RRrA8A/r7tQRd64F6f
	OMij92q76sbh7o05LEMSGxarbGdeU0GLEbsMsd1l3ynJsAV5L81Cc9GCWRnc0B/UZlxaXiHdy6E9j
	5ppacodg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6DB-00000001nvc-0rmG;
	Mon, 17 Feb 2025 18:51:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v3 1/9] ceph: Remove ceph_writepage()
Date: Mon, 17 Feb 2025 18:51:09 +0000
Message-ID: <20250217185119.430193-2-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217185119.430193-1-willy@infradead.org>
References: <20250217185119.430193-1-willy@infradead.org>
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
index f4e43fe5bb5e..200dca1ff2d6 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -862,32 +862,6 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
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
@@ -1954,7 +1928,6 @@ static int ceph_write_end(struct file *file, struct address_space *mapping,
 const struct address_space_operations ceph_aops = {
 	.read_folio = netfs_read_folio,
 	.readahead = netfs_readahead,
-	.writepage = ceph_writepage,
 	.writepages = ceph_writepages_start,
 	.write_begin = ceph_write_begin,
 	.write_end = ceph_write_end,
@@ -1962,6 +1935,7 @@ const struct address_space_operations ceph_aops = {
 	.invalidate_folio = ceph_invalidate_folio,
 	.release_folio = netfs_release_folio,
 	.direct_IO = noop_direct_IO,
+	.migrate_folio = filemap_migrate_folio,
 };
 
 static void ceph_block_sigs(sigset_t *oldset)
-- 
2.47.2


