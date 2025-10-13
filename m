Return-Path: <linux-fsdevel+bounces-63888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD89BD14C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4877E3C1543
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 02:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7661F2F28FF;
	Mon, 13 Oct 2025 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hooMK41t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0002EDD71;
	Mon, 13 Oct 2025 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324345; cv=none; b=Spg34sHCO1kN/XOrDArthEIY6I30CTGclLP+HNK/D6e5VI68HxCjWhd0qxxD7iGcwjnRcULcMwWQoDql0skBeqAxCxk0wcksNLjv5cNafUoo7b5sjgqYXwbPtFQzqCObsN0ivfF0tcRn50qXor3BqSiF/MjAGyo0cQXNHAAadoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324345; c=relaxed/simple;
	bh=OwiEVQD2CafmgxwMDyma3dZ0NFKPNoCx+GEgIPuwDn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCIx3hS8A6ZBhF7HZt7B0JRwZI4a4G29Fsda86x5+ssejd+W7BsdusFc9O64syczMB5eqRkmWicbDxAlaSQr7Zry3JcI10Lw9VnPRzH23PlfrOqzGqzfzuB1zVDilIPM3PUFTFnjhNWDCibV2u1JXLU2Cb4OD3K2pVCV6f3ss9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hooMK41t; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SqMpmzvrENBMy7NbX0f6Mno/+2fYxO4ON6rsl2w4mjo=; b=hooMK41t3bXxsCf99o1BpcDMw8
	WfYDeaQyBA0b0R6oodz4lKBED6pp9FlG3MiZSTYa+z0CdX7OkY+HZZ/pe8KOk106r/wlutvwCn8Ly
	URKBG6Qg9Ui5oQpLFtlBPg3HuBA7VPcq7mrsOtzLnNA6NgUWDdtQKu/7AKjr3nd6i0BV13Lo2KZjQ
	d+xP5WEGIELFmYh2np8a7/2+MNlFBznDsCmUWTM8lTZfSreMH/H18WswhTq60KHxmmVDT1FqHq9NE
	E27U6Xbzo6nFVZiDXhXg+3JZOvtwxI/53zBY2ebKt6AqBOcNy6SkoCalxEkX3S93a9j7EjtpjAwUX
	4stfUbRQ==;
Received: from [220.85.59.196] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v88m2-0000000C8GM-43XE;
	Mon, 13 Oct 2025 02:58:59 +0000
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
Subject: [PATCH 06/10] mm,btrfs: add a filemap_fdatawrite_kick_nr helper
Date: Mon, 13 Oct 2025 11:58:01 +0900
Message-ID: <20251013025808.4111128-7-hch@lst.de>
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

Abstract out the btrfs-specific behavior of kicking off I/O on a number
of pages on an address_space into a well-defined helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c        | 13 ++-----------
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 22 ++++++++++++++++++++++
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b97d6c1f7772..b63d77154c45 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8752,19 +8752,10 @@ static int start_delalloc_inodes(struct btrfs_root *root, long *nr_to_write,
 			btrfs_queue_work(root->fs_info->flush_workers,
 					 &work->work);
 		} else {
-			struct writeback_control wbc = {
-				.nr_to_write = *nr_to_write,
-				.sync_mode = WB_SYNC_NONE,
-				.range_start = 0,
-				.range_end = LLONG_MAX,
-			};
-
-			ret = filemap_fdatawrite_wbc(tmp_inode->i_mapping,
-					&wbc);
+			ret = filemap_fdatawrite_kick_nr(tmp_inode->i_mapping,
+					nr_to_write);
 			btrfs_add_delayed_iput(inode);
 
-			if (*nr_to_write != LONG_MAX)
-				*nr_to_write = wbc.nr_to_write;
 			if (ret || *nr_to_write <= 0)
 				goto out;
 		}
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 09b581c1d878..fc060ce2d31d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -38,6 +38,8 @@ int filemap_invalidate_pages(struct address_space *mapping,
 int write_inode_now(struct inode *, int sync);
 int filemap_fdatawrite(struct address_space *);
 int filemap_flush(struct address_space *);
+int filemap_fdatawrite_kick_nr(struct address_space *mapping,
+		long *nr_to_write);
 int filemap_fdatawait_keep_errors(struct address_space *mapping);
 int filemap_fdatawait_range(struct address_space *, loff_t lstart, loff_t lend);
 int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
diff --git a/mm/filemap.c b/mm/filemap.c
index 99d6919af60d..b95e71774131 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -474,6 +474,28 @@ int filemap_flush(struct address_space *mapping)
 }
 EXPORT_SYMBOL(filemap_flush);
 
+/*
+ * Start writeback on @nr_to_write pages from @mapping.  No one but the existing
+ * btrfs caller should be using this.  Talk to linux-mm if you think adding a
+ * new caller is a good idea.
+ */
+int filemap_fdatawrite_kick_nr(struct address_space *mapping, long *nr_to_write)
+{
+	struct writeback_control wbc = {
+		.nr_to_write = *nr_to_write,
+		.sync_mode = WB_SYNC_NONE,
+		.range_start = 0,
+		.range_end = LLONG_MAX,
+	};
+	int ret;
+
+	ret = filemap_fdatawrite_wbc(mapping, &wbc);
+	if (!ret)
+		*nr_to_write = wbc.nr_to_write;
+	return ret;
+}
+EXPORT_SYMBOL_FOR_MODULES(filemap_fdatawrite_kick_nr, "btrfs");
+
 /**
  * filemap_range_has_page - check if a page exists in range.
  * @mapping:           address space within which to check
-- 
2.47.3


