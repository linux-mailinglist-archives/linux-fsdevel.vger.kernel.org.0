Return-Path: <linux-fsdevel+bounces-43301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E97A50CC9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 21:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E7C1893118
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AE2257433;
	Wed,  5 Mar 2025 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RWm7PUCH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E054C253340
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207661; cv=none; b=Ase/Nad2IvxIhIyjsp5M7nTkYi8IGcbX21kWDu7tlu7h/exr/V5iMmXhfgv44zJW8ppG1ea+3rZH9UKAwHjKX7zKluMyxIAz3DcKwofd9Ne8oBH3FPB17SZ4ZBglVBhSLE4GqrBmj1GmrlGbKZnCyY9CgI9wSiWveqg+LS25os0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207661; c=relaxed/simple;
	bh=/ZkpV6VzDEWZ++NDYAivQ2PVGTdaj/CKfft0UriuEPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7U08TmEv6QKy7qM5QU9ZGGXx1jlfdrbVmtyRRItfJ9TRWZcE5X2Osk4TLpC+D/Lp0keKKYti6i5DR9D+n6RyuooYMmw0nBVuRCScf+rCWcwhbo0Jc+bQOQykZezwcHbQRpEzm0hLXtI6TIqoXhxbuTKTVxJuSAgseZ3QHJSoZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RWm7PUCH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6OHiEQxE0Mic6ndYDggIZx08G5+QyO3uodDDBOd8sOk=; b=RWm7PUCHT6khHS6TV5tZOB5IRS
	ZfV5gVKe80wxieCrAXc2N9PAEZdgOoThCiC9qGx5QoAlR6R0THCAGct1Y+5CfRI53AGdgrRI0AQzL
	YY5EwPOTvmYL8klE0Z98pQOSKZbevj4MHVapsgpv6Cu+kyzgh0GMSvMEfXNrjJ8SYnPgRa7U4AMAI
	BEJWJGJU+Rx607b5uX7vvsFCLkHInLamwhJ+eIFDdHewNAQMBNj4GzWxtxl7n78e2kM74C6VcDwpE
	hwBhx9V/og6+t1VuBNN7H+ypqOomKpGe4GukNrNMm5G+QlFntkAx2xBXycb8MveTko3oFIwAvYLr3
	Sd33lJVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpveT-00000006Bn5-0ybw;
	Wed, 05 Mar 2025 20:47:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH v2 4/9] orangefs: Remove orangefs_writepage()
Date: Wed,  5 Mar 2025 20:47:28 +0000
Message-ID: <20250305204734.1475264-5-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204734.1475264-1-willy@infradead.org>
References: <20250305204734.1475264-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we add a migrate_folio operation, we can remove orangefs_writepage
(as there is already a writepages operation).  filemap_migrate_folio()
will do fine as struct orangefs_write_range does not need to be adjusted
when the folio is migrated.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/inode.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 63d7c1ca0dfd..4ad049d5cc9c 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -64,15 +64,6 @@ static int orangefs_writepage_locked(struct page *page,
 	return ret;
 }
 
-static int orangefs_writepage(struct page *page, struct writeback_control *wbc)
-{
-	int ret;
-	ret = orangefs_writepage_locked(page, wbc);
-	unlock_page(page);
-	end_page_writeback(page);
-	return ret;
-}
-
 struct orangefs_writepages {
 	loff_t off;
 	size_t len;
@@ -605,7 +596,6 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
 
 /** ORANGEFS2 implementation of address space operations */
 static const struct address_space_operations orangefs_address_operations = {
-	.writepage = orangefs_writepage,
 	.readahead = orangefs_readahead,
 	.read_folio = orangefs_read_folio,
 	.writepages = orangefs_writepages,
@@ -615,6 +605,7 @@ static const struct address_space_operations orangefs_address_operations = {
 	.invalidate_folio = orangefs_invalidate_folio,
 	.release_folio = orangefs_release_folio,
 	.free_folio = orangefs_free_folio,
+	.migrate_folio = filemap_migrate_folio,
 	.launder_folio = orangefs_launder_folio,
 	.direct_IO = orangefs_direct_IO,
 };
-- 
2.47.2


