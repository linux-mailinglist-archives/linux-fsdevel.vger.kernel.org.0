Return-Path: <linux-fsdevel+bounces-63882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0557BD1451
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 04:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63CAF4EAF02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 02:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C2D2EDD60;
	Mon, 13 Oct 2025 02:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="maHSux2m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B35B7263B;
	Mon, 13 Oct 2025 02:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324307; cv=none; b=Q69NhHhvUNFAn4D8H5g2083e3P1rFW7j9qbzV6EnI0N8QI6f2bqyMa8XY/4W6+ZO1gQk3/88jZ+Ou/VdYso6nOWDmMDpRL4CQgRLgZVuxiHJ9DnHHvVi/8dvv6HHBEi9eb1KHaZaCieCw8xJnGynX3N6bZtH31bDn84gKLVFPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324307; c=relaxed/simple;
	bh=5/bUe/jEAN76NDePv92gQJkk/Dm+3ysTT5Merfo6yzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdp8BwCYN4QorDpgJX+tUGyO72wumm00dK+Sf5BFWlo5qZs1qiw5xddtthKu5IOH7umGUgeS1GbE25tj2Qrh4SXGwnJXWCNNvH/izzPOXyR5OJb7P3TjATSN5HCgzpR85/WiSyl87IM3fL9iyCkrbMGoHKxv+mOIsvfZMvvLYsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=maHSux2m; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=k7kWsG81WpnYygnvfC8rInS9rSdz4W8cC7aKY0cPGLs=; b=maHSux2m35jlsPKGQB66zbYMn7
	kGD7mWvZJomyIRGH52uw+6DlYEBnyMX+F3wDTPNTff6hpDDwK3Rc4lMaEHjWG5lOBy5Yx6E1SVDCS
	MkGH4QSVr+7PLk5yB9Q7tBxQGJlgu708ZZlx7vL5YT7Jjn2ag5y9j6CmiOWkILQXQvaAbGrjKfOqo
	hxjDsEw7eHk+B1KQkdONUXUT0UTJliS9OiwDlZoIJguOVFdVwz8fXyUfU1CIDry0ywa4I5c0DnK+G
	sTXHVzriLK2ibD84Yz2cQxN4rUFED8OOYoxL7oV6vhWjZh8aJCGtcsgr7I/wo3qfGRS+vJOnxklgn
	HNxl422w==;
Received: from [220.85.59.196] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v88lS-0000000C869-0N1Z;
	Mon, 13 Oct 2025 02:58:22 +0000
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
	linux-mm@kvack.org
Subject: [PATCH 01/10] mm: don't opencode filemap_fdatawrite_range in filemap_invalidate_inode
Date: Mon, 13 Oct 2025 11:57:56 +0900
Message-ID: <20251013025808.4111128-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251013025808.4111128-1-hch@lst.de>
References: <20251013025808.4111128-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use filemap_fdatawrite_range instead of opencoding the logic using
filemap_fdatawrite_wbc.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 13f0259d993c..99d6919af60d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4457,16 +4457,8 @@ int filemap_invalidate_inode(struct inode *inode, bool flush,
 	unmap_mapping_pages(mapping, first, nr, false);
 
 	/* Write back the data if we're asked to. */
-	if (flush) {
-		struct writeback_control wbc = {
-			.sync_mode	= WB_SYNC_ALL,
-			.nr_to_write	= LONG_MAX,
-			.range_start	= start,
-			.range_end	= end,
-		};
-
-		filemap_fdatawrite_wbc(mapping, &wbc);
-	}
+	if (flush)
+		filemap_fdatawrite_range(mapping, start, end);
 
 	/* Wait for writeback to complete on all folios and discard. */
 	invalidate_inode_pages2_range(mapping, start / PAGE_SIZE, end / PAGE_SIZE);
-- 
2.47.3


