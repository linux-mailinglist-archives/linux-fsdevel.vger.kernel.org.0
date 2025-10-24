Return-Path: <linux-fsdevel+bounces-65426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DAAC04F1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE6434FBB3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 08:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03263019C0;
	Fri, 24 Oct 2025 08:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e5QxhOIc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9778630148D;
	Fri, 24 Oct 2025 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293126; cv=none; b=hmvzPyFGrVF25L+8UKuIlIUfFWh0m4KjBeqmRAj5akFXNHC71yCF+uqVs4Cwv6wZDjPASbqUcx3i4F5G0Ztmjv8lTCZWmZQVi/TG/5MA1xSuv07vVmfVMD0JaBCmfydRGb+ZN/7WW64J5Ox2WEkbddD0XTJaAeuxe+sxWAP7rw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293126; c=relaxed/simple;
	bh=pepna2SpXFZWzrEwlVKr2yXbUjMZE9c1cwuR7rvyDRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPbS/w7u5lWTP6jZ4R2yuZNZT+DHTX6M9Wi3vq8QnJcDcXh5NAwpF7X0GTYltdSfZZ49+R3KRbtlIM5nfQg5aKHRl3ZXNROA0ge1fE65cx3SIa3vEm3flT/RydWaKIm3WNsItDaYZrcEI8SHPjbOijSADCTCnBAzUlBjUBGW5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e5QxhOIc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=blGde8W3zS/zXI9AbS8g1T7M/TUy61wo/WYiRf9KRNo=; b=e5QxhOIcxdiOltjAMQ/VttSoGx
	+haNlzPyaaJcJ4UUgsn3P+iWfvmyt7FRpi44/AMJTitmkY/9QmEnTO+hQO1d5W86NYd6TfQEWsuwA
	v791Kg1M4AnDF6JlNDShxoY+/19WaMjZk/UFkeOTcqrBSnbuKpSplIGIxRhvvmDWH4vg05AafnCLP
	SJIn6wwOAwK/9bKAXyVNlxw5DT8/LtOtjbrT3pbhB95rFCrr5yksba0ukCKf3JaudZHe/Kgyf8GFd
	DZfTXTdTUL22/54QcU9eIQiOQYYH7h5eScyFg7m83Lk4V2wb0T07jJTtuPQnSexE29mFYKWMYVyQC
	CefsepVQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCCnZ-00000008cAP-0etU;
	Fri, 24 Oct 2025 08:05:21 +0000
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
Subject: [PATCH 04/10] btrfs: use the local tmp_inode variable in start_delalloc_inodes
Date: Fri, 24 Oct 2025 10:04:15 +0200
Message-ID: <20251024080431.324236-5-hch@lst.de>
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

start_delalloc_inodes has a struct inode * pointer available in the
main loop, use it instead of re-calculating it from the btrfs inode.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3b1b3a0553ee..9edb78fc57fc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8744,9 +8744,9 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 		if (snapshot)
 			set_bit(BTRFS_INODE_SNAPSHOT_FLUSH, &inode->runtime_flags);
 		if (full_flush) {
-			work = btrfs_alloc_delalloc_work(&inode->vfs_inode);
+			work = btrfs_alloc_delalloc_work(tmp_inode);
 			if (!work) {
-				iput(&inode->vfs_inode);
+				iput(tmp_inode);
 				ret = -ENOMEM;
 				goto out;
 			}
@@ -8754,7 +8754,7 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 			btrfs_queue_work(root->fs_info->flush_workers,
 					 &work->work);
 		} else {
-			ret = filemap_fdatawrite_wbc(inode->vfs_inode.i_mapping, wbc);
+			ret = filemap_fdatawrite_wbc(tmp_inode->i_mapping, wbc);
 			btrfs_add_delayed_iput(inode);
 			if (ret || wbc->nr_to_write <= 0)
 				goto out;
-- 
2.47.3


