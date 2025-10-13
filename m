Return-Path: <linux-fsdevel+bounces-63885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8555BD1481
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 04:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0043F3BA9F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 02:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAFA2EDD7C;
	Mon, 13 Oct 2025 02:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FDfBpYZN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED671F5423;
	Mon, 13 Oct 2025 02:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324323; cv=none; b=R8fcFwSVoRXJbYTcmkWOrg1whz4i/jgf4q+sO4rAoOZEKHeefFEMeTlNbLuQGwfmEO8pk1EasPZPAQ6iVYOrzdA4FvvFN7UcUpsdQ4wouVN7aQNe2DMIPPm6N/9vAaZuMlgD3FSR3ZJ7zxql+Wf9jTXVZqX5zBfJxLABugptOS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324323; c=relaxed/simple;
	bh=cWKrZUawsezlCPQEn6CVYft5tCLpw9dN+GZZ65iEIys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1aOB7nJapJobfniaTPYUY10kA+pNDMv5GbinMOUpTec8lbtVLjWr/HGIifyHiJv8OvC1ClztWiDERlkzNQYU8CGRlhaw8ED6cM3U8r2D+BR3fRfbvq4h27CWV94a6K+TqxUBcge11Vq6u3z+8RKhpzz4QWQ7pDl6c0was1hGMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FDfBpYZN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dQZOPAAeeds/w0ZlIXWjsgocvBDsAHF4UQnFeVZIJl8=; b=FDfBpYZNHkGYl26RqtPTH1d2z0
	0grd2UwV3PK7DTQrexZXFT2MSdKVpYRL+Gjc3eFSuxeb03ctH5iPyQKpzIO6edBYs5CLd9PefOSSM
	i+j8w8lTD4MZx5T8BNzqhQjwiPzFGW4QohpQ8TOsPSGb5ECwtiYghElUUuDsSmqULiAgDmPuLdwDj
	pE95DuAtsOpzDNx6YaGtSTFWpMCalmXOLEyUGHDbBZ2vFQKi0Hg9HE1rwYeigBs5zic7UhFJ9nSVl
	VJUIaBI9dI/hwo2OaxbrpcOR0PsHLKqRYJcCmgouWBRYW+9tyuOye5gNQ/srvuYKJiOGWhaYnd0Oq
	epabVJjQ==;
Received: from [220.85.59.196] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v88lh-0000000C87W-3jg1;
	Mon, 13 Oct 2025 02:58:38 +0000
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
Subject: [PATCH 03/10] ocfs2: don't opencode filemap_fdatawrite_range in ocfs2_journal_submit_inode_data_buffers
Date: Mon, 13 Oct 2025 11:57:58 +0900
Message-ID: <20251013025808.4111128-4-hch@lst.de>
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
filemap_fdatawrite_wbc.  There is a slight change in the conversion
as nr_to_write is now set to LONG_MAX instead of double the number
of the pages in the range.  LONG_MAX is the usual nr_to_write for
WB_SYNC_ALL writeback, and the value expected by lower layers here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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


