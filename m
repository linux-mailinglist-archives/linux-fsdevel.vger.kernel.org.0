Return-Path: <linux-fsdevel+bounces-45527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826A4A791BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 17:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EA816D758
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB39A23BD09;
	Wed,  2 Apr 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aldD+WzI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375AE23C8C2
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606017; cv=none; b=GT+jAzpv+5+gyXEW9C/5bRIcYXHkr5qIhxj4vTjWntHgpf9pShl7hZeD86lwW8DKu9IyVIZcKdZELhQm4zErZZn0rZLYjHJIJQuWJn79mD6B10c5xm5lL4zANcQWGfM2/cFB8sr+0Qtxp7IkQ8oJWa5kY9RYGwXqSF9gnByci64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606017; c=relaxed/simple;
	bh=jjv6wdpbNpVGQWg0nMWZQir9RvJwLLoF9rWGfw0EUZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKJDNStYCbuOQ1Qbel1/Ao8pvs3u8oeL3Ojm1XwA/kca5vR6RPRbtI5YW8HpWAISSnQ9HyfVAmAGDtR8Bc8Ajz+zzHeVPiTrkZn9OYQqw+FsWJuq7MagYjqwPsTWbMyJ4Pcm/UN4mV/JnXCrcsi9LtvKQCojpP7r9oj6kKTAg+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aldD+WzI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=USN/8SwPxGkpN9iKStANYoZJi04hj3LODUnr4I2+Xx8=; b=aldD+WzI/aKdQ2XEMrI1DtpAyB
	uXrZ5Dnx/rhBTcN/bbRRqfOX2YC53+ZpRz75qWLyq/1urNcEOc/sxxc6aRf1DOrWtUeZST0atwG6D
	rPDsdz3NfzG5svTviGHXM5+n0/M+CqRecB+4O3qugWSFiematCWWMs+IbVGc80UFwNmGMuDH5MNYP
	xHJ9/+9ozytW5lP9Ugm7M2e4JbX3WPxUGItRy7OKJVKFlWocD9Z5qGu77nJE/Lxq+pXQ3VXqtPTRP
	36PRWYzQ4cZfAiVLx10GN+rhiM3tnzFQir5/15+eQigFcNP4ROxf+F6Sik872RulOVx8/DHDKhXYI
	kdfgkjLA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzzZX-00000009gsD-1Wga;
	Wed, 02 Apr 2025 15:00:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 4/9] writeback: Remove writeback_use_writepage()
Date: Wed,  2 Apr 2025 15:59:58 +0100
Message-ID: <20250402150005.2309458-5-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402150005.2309458-1-willy@infradead.org>
References: <20250402150005.2309458-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ->writepage operation has been removed from all filesystems but
shmem and swap, neither of which call in here.  Remove this alternative
to calling ->writepages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 18456ddd463b..3cf7ae45be58 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2621,27 +2621,6 @@ int write_cache_pages(struct address_space *mapping,
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-static int writeback_use_writepage(struct address_space *mapping,
-		struct writeback_control *wbc)
-{
-	struct folio *folio = NULL;
-	struct blk_plug plug;
-	int err;
-
-	blk_start_plug(&plug);
-	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
-		err = mapping->a_ops->writepage(&folio->page, wbc);
-		if (err == AOP_WRITEPAGE_ACTIVATE) {
-			folio_unlock(folio);
-			err = 0;
-		}
-		mapping_set_error(mapping, err);
-	}
-	blk_finish_plug(&plug);
-
-	return err;
-}
-
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	int ret;
@@ -2652,14 +2631,11 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 	wb = inode_to_wb_wbc(mapping->host, wbc);
 	wb_bandwidth_estimate_start(wb);
 	while (1) {
-		if (mapping->a_ops->writepages) {
+		if (mapping->a_ops->writepages)
 			ret = mapping->a_ops->writepages(mapping, wbc);
-		} else if (mapping->a_ops->writepage) {
-			ret = writeback_use_writepage(mapping, wbc);
-		} else {
+		else
 			/* deal with chardevs and other special files */
 			ret = 0;
-		}
 		if (ret != -ENOMEM || wbc->sync_mode != WB_SYNC_ALL)
 			break;
 
-- 
2.47.2


