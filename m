Return-Path: <linux-fsdevel+bounces-65425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C669AC04F3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240761A63117
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 08:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905B230103F;
	Fri, 24 Oct 2025 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SyZcOLm7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9BC2FD67C;
	Fri, 24 Oct 2025 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293120; cv=none; b=kTtVb4qNZqvJ/OPX/eb6IBcQzOu/F6ytm/c10oIg/AHyTMQqVRXJbUL4so1+YpDgPHLDAh7namgOopbtKxrThxbXYXVpX8Bw8UW/u7gxaC3kFBUlRUjFr/Iwh44GnX+mpLEzwfrCpsa+TdHLSfBpaWkkbEyhCrEBC7lvBvYZx18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293120; c=relaxed/simple;
	bh=4H4KIm0qaF0FKHfvmzdPTrQYJhWVTHcJ4zi6uWngmmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0VLzmxdbAD8UmjYlg862xncqqc2v/kM7W3TbP9ttmvIUAjn8hRbot1iZP27UCDpXFc/39G6djko6prVGnJWSRhZl+VMBOgn+8Th3pKcLNTCCjDB6gaiqLGaA7AQ6uXhnr/++2nB8v+EZ92zQDYdcifP2mUamkelbA09S9SPF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SyZcOLm7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2P9bxasjyjeJJnWosoT8opCXvi31OW+wT7P6nXr4e1Y=; b=SyZcOLm7azl5JrW08U5yz1c8Lh
	vix5yzp4RagXc9bFo+bUtELCBUfInp9awNVrH7BimMHQsmNxNbn2NfRCaB+UOT8Yzpo1fRvY/x+v4
	scFL4I92+OgnK2NMTDGidcI04vnqTxLbozymLpf16DX1dcb9AZNd/kBPz48GBE8wcZGIRtCbynCxs
	V+ivSs1pVpv02buP3YEMxeVD1DHHiEWZ5tH584nBd5oNKCviM/ud4X3bYCoY+pctji5tgfkQ+casz
	RRVwARP3a9ApjtC3sPfLGPUBRJi4K/6g7HBQaZCO2tqCJ/VIDcD2u1xN8Gp/WbneQcmiTEtJ87Uxn
	7QJDn4OA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCCnS-00000008c5u-1C5z;
	Fri, 24 Oct 2025 08:05:14 +0000
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
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 03/10] ocfs2: don't opencode filemap_fdatawrite_range in ocfs2_journal_submit_inode_data_buffers
Date: Fri, 24 Oct 2025 10:04:14 +0200
Message-ID: <20251024080431.324236-4-hch@lst.de>
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
filemap_fdatawrite_wbc.  There is a slight change in the conversion
as nr_to_write is now set to LONG_MAX instead of double the number
of the pages in the range.  LONG_MAX is the usual nr_to_write for
WB_SYNC_ALL writeback, and the value expected by lower layers here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/ocfs2/journal.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index e5f58ff2175f..85239807dec7 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -902,15 +902,8 @@ int ocfs2_journal_alloc(struct ocfs2_super *osb)
 
 static int ocfs2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 {
-	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
-	struct writeback_control wbc = {
-		.sync_mode =  WB_SYNC_ALL,
-		.nr_to_write = mapping->nrpages * 2,
-		.range_start = jinode->i_dirty_start,
-		.range_end = jinode->i_dirty_end,
-	};
-
-	return filemap_fdatawrite_wbc(mapping, &wbc);
+	return filemap_fdatawrite_range(jinode->i_vfs_inode->i_mapping,
+			jinode->i_dirty_start, jinode->i_dirty_end);
 }
 
 int ocfs2_journal_init(struct ocfs2_super *osb, int *dirty)
-- 
2.47.3


