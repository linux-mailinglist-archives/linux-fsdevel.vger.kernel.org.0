Return-Path: <linux-fsdevel+bounces-65423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0FCC04EFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA9B1A63C4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 08:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4192E301715;
	Fri, 24 Oct 2025 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OJ7tYu38"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8704F2FD67C;
	Fri, 24 Oct 2025 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293093; cv=none; b=FWMG4SQcxdSwVZzUaEAYOWGUyehLFgCGQSWsWTPd/M7HLqjuvsipqoXZsnAPGX9l17pRRMKfUCSCnSOBbevo1Y4Q4APWfWWoN6jC6Q/GE0Zkpt+RgRRBE1KqUFqrN0hgJqjAqLBnBNsu6TMmgVLW7G9XrV6SI+wspaEbC3xOMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293093; c=relaxed/simple;
	bh=roFCFZua0Lv07Kf/hqCKxGW+HHK7uk/PMh4o76fwMU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OI4W9c8TesAc8cZFAW6U7cNRla14IaBBsf/k+pcL6Whe1aWWo4vQf67eQu4k8A+2+IXkaa8yb0zzbKVxCGfVoa6kjKpV4TyzfG4SiO5B1QRJIpkosANv2v9KG/N4vXyKqaVQTfEb4jazhGzqtGrqyPpNTEGjLq4o15awVf+X7vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OJ7tYu38; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jYNTxYIvfkheoJqN9754McBKPDeXnK4exyWJDqYAb+Q=; b=OJ7tYu38O/M/EmCj56S9HyxwM+
	j/MgDY2cewA4DHdbgZD5+lsfdRKWYE/thmo+DAAhTEQJvcx94qZtN5GUp//euqbZRrUAwub+7D/ip
	BwH6Z2MPj6e9TBe09HjUYdUpwV314GvopmTdoe6bjiT0hcxtSHZCE9+2QbDGVtA+2WW65fYjlI5Sg
	UFbHzmBdpwRNvAHbYFJd4jgnj2Yw5q9nJAgB4ZrGcAap7PO12c6ltZJyTpogW6/htvsVKPTrGP5Ow
	3SvSCyiGRQfpMC0paMwsE+z+lcv6VFfZSYkbRECS1l/nrIY6dzsv1ZcYw3B2hDw9NPdeEgxNIB8Uk
	vQC81CeA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCCn1-00000008c2S-1B1p;
	Fri, 24 Oct 2025 08:04:47 +0000
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
	David Hildenbrand <david@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 01/10] mm: don't opencode filemap_fdatawrite_range in filemap_invalidate_inode
Date: Fri, 24 Oct 2025 10:04:12 +0200
Message-ID: <20251024080431.324236-2-hch@lst.de>
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

Use filemap_fdatawrite_range instead of opencoding the logic using
filemap_fdatawrite_wbc.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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


