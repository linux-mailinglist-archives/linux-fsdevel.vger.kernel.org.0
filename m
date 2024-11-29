Return-Path: <linux-fsdevel+bounces-36119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B155C9DBF43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 06:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB4EB22497
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 05:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F7015855C;
	Fri, 29 Nov 2024 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oWoqSeft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9361547FF;
	Fri, 29 Nov 2024 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732859473; cv=none; b=A2NA0R9fxDbBhAwaxO969jF6/Bf4vEvAQx3CzqoZxi7LuhBYFVClFrWkucwiU24SfRat0H1yC13ZVtSPDEfSzGQOuSzTmiQoRFR0y4RdpH9ck49l9Uz3dSwXqwa1dLOcQJT1muv5Y+lOhDXABrjLoJacPitXXdUn/Db0q+8YEyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732859473; c=relaxed/simple;
	bh=aDtdq9caWDRhpliU4N7JPTCsamZ1q2ke8PI42WXds1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/oqaJqo45dSe4UKeCnQbN/fFN/nDq2EIHThg/BawM2dKbiOYoY/7TpLdkJJrD44Owg1gg4fapj+O+YMARlzwuzuelPTWU5sUQ7iU/tn6R/GVnsnsGo+CMoBjfaf3VFCd0HTh87s9eYojgwC6dT14LPV1YZ7syeQ35rk4EX5z2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oWoqSeft; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=uWZkCEwwYb4dP6PPOM0IVSKbmg2RK8kTAbzH0C95S7g=; b=oWoqSeftByZWcIP+U4SR7tF/Hj
	XzSBb/cuP1d6VK7vaVo+f5fJOsOLTcPIhSxrFPtdTSWF7iaj7wQ8y+HGYAC+vrUXLOAPLBMs46Qou
	OJoBE/zIoQZt1MyvokLyo5RMolw+dsWbg+wlk40MNi/fotKEov4TsAux9GP40CZZJXyWlZcMbDWgA
	6VkLHQK83TxiKxKt1Z851FbqCZQwi8C+4c2Hk9Y+B3w+GTWB7VluBXvkUBWIbZcztNaKxANqxRVEU
	jO0501MqHamEW6FX5DryhFuP5zqE5JW6jzPLOhfPHhKoV0M2KNRYMmBb2lu98guIS8xCh76dz+2Rz
	Qt6Ye+OA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGtu9-00000003bSE-1mXv;
	Fri, 29 Nov 2024 05:51:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 4/5] ceph: Use a folio throughout writepage_nounlock()
Date: Fri, 29 Nov 2024 05:50:55 +0000
Message-ID: <20241129055058.858940-5-willy@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129055058.858940-1-willy@infradead.org>
References: <20241129055058.858940-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove references to page->index, page->mapping, thp_size(),
page_offset() and other page APIs in favour of their more efficient
folio replacements.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index a5c59fec8a76..aba8d55bd533 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -664,14 +664,14 @@ static u64 get_writepages_data_length(struct inode *inode,
 static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 {
 	struct folio *folio = page_folio(page);
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = fsc->client;
 	struct ceph_snap_context *snapc, *oldest;
-	loff_t page_off = page_offset(page);
+	loff_t page_off = folio_pos(folio);
 	int err;
-	loff_t len = thp_size(page);
+	loff_t len = folio_size(folio);
 	loff_t wlen;
 	struct ceph_writeback_ctl ceph_wbc;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
@@ -679,8 +679,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	bool caching = ceph_is_cache_enabled(inode);
 	struct page *bounce_page = NULL;
 
-	doutc(cl, "%llx.%llx page %p idx %lu\n", ceph_vinop(inode), page,
-	      page->index);
+	doutc(cl, "%llx.%llx folio %p idx %lu\n", ceph_vinop(inode), folio,
+	      folio->index);
 
 	if (ceph_inode_is_shutdown(inode))
 		return -EIO;
@@ -688,18 +688,18 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	/* verify this is a writeable snap context */
 	snapc = page_snap_context(page);
 	if (!snapc) {
-		doutc(cl, "%llx.%llx page %p not dirty?\n", ceph_vinop(inode),
-		      page);
+		doutc(cl, "%llx.%llx folio %p not dirty?\n", ceph_vinop(inode),
+		      folio);
 		return 0;
 	}
 	oldest = get_oldest_context(inode, &ceph_wbc, snapc);
 	if (snapc->seq > oldest->seq) {
-		doutc(cl, "%llx.%llx page %p snapc %p not writeable - noop\n",
-		      ceph_vinop(inode), page, snapc);
+		doutc(cl, "%llx.%llx folio %p snapc %p not writeable - noop\n",
+		      ceph_vinop(inode), folio, snapc);
 		/* we should only noop if called by kswapd */
 		WARN_ON(!(current->flags & PF_MEMALLOC));
 		ceph_put_snap_context(oldest);
-		redirty_page_for_writepage(wbc, page);
+		folio_redirty_for_writepage(wbc, folio);
 		return 0;
 	}
 	ceph_put_snap_context(oldest);
@@ -716,8 +716,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 		len = ceph_wbc.i_size - page_off;
 
 	wlen = IS_ENCRYPTED(inode) ? round_up(len, CEPH_FSCRYPT_BLOCK_SIZE) : len;
-	doutc(cl, "%llx.%llx page %p index %lu on %llu~%llu snapc %p seq %lld\n",
-	      ceph_vinop(inode), page, page->index, page_off, wlen, snapc,
+	doutc(cl, "%llx.%llx folio %p index %lu on %llu~%llu snapc %p seq %lld\n",
+	      ceph_vinop(inode), folio, folio->index, page_off, wlen, snapc,
 	      snapc->seq);
 
 	if (atomic_long_inc_return(&fsc->writeback_count) >
@@ -730,14 +730,14 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 				    ceph_wbc.truncate_seq,
 				    ceph_wbc.truncate_size, true);
 	if (IS_ERR(req)) {
-		redirty_page_for_writepage(wbc, page);
+		folio_redirty_for_writepage(wbc, folio);
 		return PTR_ERR(req);
 	}
 
 	if (wlen < len)
 		len = wlen;
 
-	set_page_writeback(page);
+	folio_start_writeback(folio);
 	if (caching)
 		ceph_set_page_fscache(page);
 	ceph_fscache_write_to_cache(inode, page_off, len, caching);
@@ -747,15 +747,15 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 						    CEPH_FSCRYPT_BLOCK_SIZE, 0,
 						    GFP_NOFS);
 		if (IS_ERR(bounce_page)) {
-			redirty_page_for_writepage(wbc, page);
-			end_page_writeback(page);
+			folio_redirty_for_writepage(wbc, folio);
+			folio_end_writeback(folio);
 			ceph_osdc_put_request(req);
 			return PTR_ERR(bounce_page);
 		}
 	}
 
 	/* it may be a short write due to an object boundary */
-	WARN_ON_ONCE(len > thp_size(page));
+	WARN_ON_ONCE(len > folio_size(folio));
 	osd_req_op_extent_osd_data_pages(req, 0,
 			bounce_page ? &bounce_page : &page, wlen, 0,
 			false, false);
@@ -781,25 +781,25 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 		if (err == -ERESTARTSYS) {
 			/* killed by SIGKILL */
 			doutc(cl, "%llx.%llx interrupted page %p\n",
-			      ceph_vinop(inode), page);
-			redirty_page_for_writepage(wbc, page);
-			end_page_writeback(page);
+			      ceph_vinop(inode), folio);
+			folio_redirty_for_writepage(wbc, folio);
+			folio_end_writeback(folio);
 			return err;
 		}
 		if (err == -EBLOCKLISTED)
 			fsc->blocklisted = true;
-		doutc(cl, "%llx.%llx setting page/mapping error %d %p\n",
-		      ceph_vinop(inode), err, page);
+		doutc(cl, "%llx.%llx setting mapping error %d %p\n",
+		      ceph_vinop(inode), err, folio);
 		mapping_set_error(&inode->i_data, err);
 		wbc->pages_skipped++;
 	} else {
 		doutc(cl, "%llx.%llx cleaned page %p\n",
-		      ceph_vinop(inode), page);
+		      ceph_vinop(inode), folio);
 		err = 0;  /* vfs expects us to return 0 */
 	}
-	oldest = detach_page_private(page);
+	oldest = folio_detach_private(folio);
 	WARN_ON_ONCE(oldest != snapc);
-	end_page_writeback(page);
+	folio_end_writeback(folio);
 	ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
 	ceph_put_snap_context(snapc);  /* page's reference */
 
-- 
2.45.2


