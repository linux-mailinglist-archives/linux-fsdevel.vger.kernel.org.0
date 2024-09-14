Return-Path: <linux-fsdevel+bounces-29378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82FA979142
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 16:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42611C21339
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 14:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822121CFEAF;
	Sat, 14 Sep 2024 14:07:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD821CF292
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Sep 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726322828; cv=none; b=lOjgiXQo6JSHC35/1W5n3ENbyeQ2V8bDgJZieKKpKjTizz4+v++0vT0QmKArMW1CFQEY1YKlHcayaP3uj1/2e9nWueACSajLCSLSX2iPuy8ibzqIM52SsTOiphC3xlANXDknRcjGhIDvQvvuE/PcUoOGWK85K996A1eXsLz2smo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726322828; c=relaxed/simple;
	bh=oqWvqmnP0rt762TCrg7NpM0wCbv0yKPR6bGqg9HO16w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IjSo33u8P/oeyq77Rvgy7kBPwPnQuR2VIjx1DOA/Uq5XA9yUVi/6XtHSqv7nyVsaQkITY18EY65EX+qLjqX0hs47PpjWYBp4CktsmWBBDs+aM0yvpNpQl0n+DJX9OkOxmug5YMK4Xxy/oFmrFTcUH4Ep7XM3fztFdNmr16mlxlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X5XyH2qYqzyQs3;
	Sat, 14 Sep 2024 22:05:43 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 68AC2140137;
	Sat, 14 Sep 2024 22:06:54 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 14 Sep 2024 22:06:53 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
	<hughd@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox
	<willy@infradead.org>
CC: Anna Schumaker <Anna.Schumaker@Netapp.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH -next] tmpfs: fault in smaller chunks if large folio allocation not allowed
Date: Sat, 14 Sep 2024 22:06:13 +0800
Message-ID: <20240914140613.2334139-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100008.china.huawei.com (7.185.36.138)

The tmpfs supports large folio, but there is some configurable options
to enable/disable large folio allocation, and for huge=within_size,
large folio only allowabled if it fully within i_size, so there is
performance issue when perform write without large folio, the issue is
similar to commit 4e527d5841e2 ("iomap: fault in smaller chunks for
non-large folio mappings").

Fix it by checking whether it allows large folio allocation or not
before perform write.

Fixes: 9aac777aaf94 ("filemap: Convert generic_perform_write() to support large folios")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/fs.h | 2 ++
 mm/filemap.c       | 7 ++++++-
 mm/shmem.c         | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1e25267e2e48..d642e323354b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -346,6 +346,8 @@ struct readahead_control;
 #define IOCB_DIO_CALLER_COMP	(1 << 22)
 /* kiocb is a read or write operation submitted by fs/aio.c. */
 #define IOCB_AIO_RW		(1 << 23)
+/* fault int small chunks(PAGE_SIZE) from userspace */
+#define IOCB_NO_LARGE_CHUNK	(1 << 24)
 
 /* for use in trace events */
 #define TRACE_IOCB_STRINGS \
diff --git a/mm/filemap.c b/mm/filemap.c
index 3e46ca45e13d..27e73f2680ef 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4132,9 +4132,14 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	loff_t pos = iocb->ki_pos;
 	struct address_space *mapping = file->f_mapping;
 	const struct address_space_operations *a_ops = mapping->a_ops;
-	size_t chunk = mapping_max_folio_size(mapping);
 	long status = 0;
 	ssize_t written = 0;
+	size_t chunk;
+
+	if (iocb->ki_flags & IOCB_NO_LARGE_CHUNK)
+		chunk = PAGE_SIZE;
+	else
+		chunk = mapping_max_folio_size(mapping);
 
 	do {
 		struct folio *folio;
diff --git a/mm/shmem.c b/mm/shmem.c
index 530fe8cfcc21..2909bead774b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3228,6 +3228,7 @@ static ssize_t shmem_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
+	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	ssize_t ret;
 
 	inode_lock(inode);
@@ -3240,6 +3241,10 @@ static ssize_t shmem_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ret = file_update_time(file);
 	if (ret)
 		goto unlock;
+
+	if (!shmem_allowable_huge_orders(inode, NULL, index, 0, false))
+		iocb->ki_flags |= IOCB_NO_LARGE_CHUNK;
+
 	ret = generic_perform_write(iocb, from);
 unlock:
 	inode_unlock(inode);
-- 
2.27.0


