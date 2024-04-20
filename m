Return-Path: <linux-fsdevel+bounces-17325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A194B8AB8DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564391F21552
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F098F55;
	Sat, 20 Apr 2024 02:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SHDbkDdU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A578F79DD;
	Sat, 20 Apr 2024 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581450; cv=none; b=KSdOonYWgalh/jf4Zycya4tqdhJEvgHG43SY66m2U+0MNh7qGgDH34B9D7R4LLmAc7WqHXafl3y0fZ79nQLZPr/cPux/QGCLW0FvU2OEnZYlu5F05Hr/Ur647mbetlHRmR0iyOyw7aNfsLZEXYOIXPzASoEC7OVx/Ly83QQ/JPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581450; c=relaxed/simple;
	bh=4MwBE7u5de5BF4nUaoFf4BqiiTWYHEGiETIg6CUpGNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4JOplB1Y7MNRqMDLbfoHEupwLCqMYkPhrV0VEGu7XlRJg8J5ipw85jpb6EwxXfR8uZksriCG14TWp2LxxBY3pJA2TNttDY5FiBsOWu9HRduCIU8fCOyeyrPrqk+1NEsGwMcYijFznKJbjsiVmNP+EMnjoMbt8bydsUKolp+6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SHDbkDdU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=eZyFacoFWlUHyNqrE7n/pQQL9VwstpBC8fVXbXaKtgE=; b=SHDbkDdUXYYhOmhVhYt8AuK0Tm
	WVxf22XfwmYx0s7guJf+stOq9LBuUgrpIIR3A9vfvIMJC8X/MTk87iVoKUlkoZSLlQ0nytX+y1cVj
	2ANfN7CXd3bJW0OKIVyxxpznqc4+tA4HxljCUW1/NqWZjbIujAL2q5tDdvaDcgwBpSt9/3r+QhlpL
	1pfwRTriQRgK3VGIyS+FQWstMaDiO+I11uC9Om8f/Ay8wFlwgMRgu6+b6enWHYjSdVYmnFhVnUUZN
	BrL9LCA0RcI5ukfmUcmAQ1HVkhnWGv9/oiiYr6XxIDuiM3oSTQwMyTMVx4Ckaqhd3Rhz/m9Yt9e4k
	luhV/yAw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oO-000000095e1-1H9I;
	Sat, 20 Apr 2024 02:50:44 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 01/30] btrfs: Use a folio in wait_dev_supers()
Date: Sat, 20 Apr 2024 03:49:56 +0100
Message-ID: <20240420025029.2166544-2-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes a few calls to compound_head() and calls to obsolete APIs.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/disk-io.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3d512b041977..32cf64ccd761 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3849,7 +3849,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
 
 	for (i = 0; i < max_mirrors; i++) {
-		struct page *page;
+		struct folio *folio;
 
 		ret = btrfs_sb_log_location(device, i, READ, &bytenr);
 		if (ret == -ENOENT) {
@@ -3864,27 +3864,27 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		    device->commit_total_bytes)
 			break;
 
-		page = find_get_page(device->bdev->bd_mapping,
+		folio = filemap_get_folio(device->bdev->bd_mapping,
 				     bytenr >> PAGE_SHIFT);
-		if (!page) {
+		if (IS_ERR(folio)) {
 			errors++;
 			if (i == 0)
 				primary_failed = true;
 			continue;
 		}
-		/* Page is submitted locked and unlocked once the IO completes */
-		wait_on_page_locked(page);
-		if (PageError(page)) {
+		/* Folio is unlocked once the write completes */
+		folio_wait_locked(folio);
+		if (folio_test_error(folio)) {
 			errors++;
 			if (i == 0)
 				primary_failed = true;
 		}
 
 		/* Drop our reference */
-		put_page(page);
+		folio_put(folio);
 
 		/* Drop the reference from the writing run */
-		put_page(page);
+		folio_put(folio);
 	}
 
 	/* log error, force error return */
-- 
2.43.0


