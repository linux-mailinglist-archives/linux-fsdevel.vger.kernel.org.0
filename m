Return-Path: <linux-fsdevel+bounces-65428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E26EC04FE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8963440224F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 08:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AB8301497;
	Fri, 24 Oct 2025 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Js/UGbVF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C52FDC49;
	Fri, 24 Oct 2025 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293142; cv=none; b=sCBVSvqKRKpRVRq6p0tF7PBRYDksX0M4BX0zVNTlfX7TKKGTr8Bandkskq1erTbG1g5FW1HJHqH3ozdc8qzp0D+v1/+m5p8b+ElK/xY5NS8pWf1V9GocEyk03ZtZKvp4AxXXoxRl3egSSfOo2PmyGgw1jCvGpQdWbATAAyntUS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293142; c=relaxed/simple;
	bh=dADoB3c/8ZD5MM15nVKKm3xuAkX4iX8txIe6MKT7N1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFD4dusBgzBRdA3FW3B0gJZE1Rh++1BWH0CVV+M/LzqmaVbt1aQj6uWoJIx+du2jLXAoGFpq+/TaZLK+8eyVNDXyR7oedVoMaC5qG2zahvNHwQTPQp7Mzgp9g5nsSs8VolW5AxDYTElR0t+5u+rPvsIzbgNduu+O3H5Y1vW8dIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Js/UGbVF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dt5Y9yUiiRdlF2Ic+Ii5j4wLNf1I5IugK8AmLWSy1WY=; b=Js/UGbVFZZ+OME4DUpP16a6gKq
	abrzc4WOMNevqV2nkdK0YUfY8pKvH4grE6fpxHacd2uTTimgcnn7O9U3ihpVcPb+2Ozjnnz4uiZ8q
	nnAnEXrVeNUOXgZ8E76x7T2/YyGmAlwEUcqfQQ6doNhxQ/ooD98B+lj/03Fdpv62sWQT1Y0zCVe58
	k/rPUZOiQUKnEHokwUOhgGsNqh6Z41ZKICvaKoxR5RjXBnfuk4nxxy3+JCartGOCv6OrYphXMbW7K
	I1q/uJTmTYOMiVXAbW3rg6juNoqiA85xiEuBN7VjsYGxv7Fi+UWb970IT9epMHNZAgfY2YhZty9xL
	75TfRhKw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCCnp-00000008cEG-1P9g;
	Fri, 24 Oct 2025 08:05:37 +0000
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
Subject: [PATCH 06/10] mm,btrfs: add a filemap_flush_nr helper
Date: Fri, 24 Oct 2025 10:04:17 +0200
Message-ID: <20251024080431.324236-7-hch@lst.de>
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

Abstract out the btrfs-specific behavior of kicking off I/O on a number
of pages on an address_space into a well-defined helper.

Note: there is no kerneldoc comment for the new function because it is
not part of the public API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c        | 13 ++-----------
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 22 ++++++++++++++++++++++
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b97d6c1f7772..d12b8116adde 100644
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
+			ret = filemap_flush_nr(tmp_inode->i_mapping,
+					nr_to_write);
 			btrfs_add_delayed_iput(inode);
 
-			if (*nr_to_write != LONG_MAX)
-				*nr_to_write = wbc.nr_to_write;
 			if (ret || *nr_to_write <= 0)
 				goto out;
 		}
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 09b581c1d878..cebdf160d3dd 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -38,6 +38,7 @@ int filemap_invalidate_pages(struct address_space *mapping,
 int write_inode_now(struct inode *, int sync);
 int filemap_fdatawrite(struct address_space *);
 int filemap_flush(struct address_space *);
+int filemap_flush_nr(struct address_space *mapping, long *nr_to_write);
 int filemap_fdatawait_keep_errors(struct address_space *mapping);
 int filemap_fdatawait_range(struct address_space *, loff_t lstart, loff_t lend);
 int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
diff --git a/mm/filemap.c b/mm/filemap.c
index 99d6919af60d..e344b79a012d 100644
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
+int filemap_flush_nr(struct address_space *mapping, long *nr_to_write)
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
+EXPORT_SYMBOL_FOR_MODULES(filemap_flush_nr, "btrfs");
+
 /**
  * filemap_range_has_page - check if a page exists in range.
  * @mapping:           address space within which to check
-- 
2.47.3


