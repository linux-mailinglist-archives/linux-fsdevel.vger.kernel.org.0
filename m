Return-Path: <linux-fsdevel+bounces-29755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2519C97D6FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2689286CCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3903A17C224;
	Fri, 20 Sep 2024 14:37:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C06FB6
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726843046; cv=none; b=fEJeArQg+POB7mx4pJ81YJnQQvQGoyZ7s1PI3b9FG9rJhXpDNLFSHIfdEksryQl9C0GbYaIKdX7eoAodH3zTzjlP90vs+1FqLN2EeEAMAKc0JshMC4qsivwVLbM5p2udfPxTXzNzk/7L4KFoY4Buaxyq3mhv2BHbO0N9c1tPMUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726843046; c=relaxed/simple;
	bh=CrAnsw/K7t6p8Uyw8TT1OVYMx9oOLfTaCCLAbv6rxZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILuDQ+BB/qjDymjGGpRAxfS1JuwHXvWVXf1jk8SmrlF/Tkefj8eGhiC+GQfS0qei/eKzwkJTegel9XX+Q3MbyDKLiiLkix3M0iH7Y87+cckVlWdRl7bAw311UpGZLRDOQnwaR41KQECrOPzVBxCq3nUsiN0OHmhnCzDPNqi6Djs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X9FLr4q0WzySBq;
	Fri, 20 Sep 2024 22:36:20 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 701C5140392;
	Fri, 20 Sep 2024 22:37:16 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Sep 2024 22:37:15 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
	<hughd@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox
	<willy@infradead.org>
CC: Anna Schumaker <Anna.Schumaker@Netapp.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2] tmpfs: fault in smaller chunks if large folio allocation not allowed
Date: Fri, 20 Sep 2024 22:36:54 +0800
Message-ID: <20240920143654.1008756-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240914140613.2334139-1-wangkefeng.wang@huawei.com>
References: <20240914140613.2334139-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
v2:
- Don't use IOCB flags

 mm/filemap.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 3e46ca45e13d..b33f260fa32f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4126,13 +4126,28 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 }
 EXPORT_SYMBOL(generic_file_direct_write);
 
+static size_t generic_mapping_max_folio_size(struct address_space *mapping,
+					     loff_t pos)
+{
+	struct inode *inode = mapping->host;
+	pgoff_t index = pos >> PAGE_SHIFT;
+
+	if (!shmem_mapping(mapping))
+		goto out;
+
+	if (!shmem_allowable_huge_orders(inode, NULL, index, 0, false))
+		return PAGE_SIZE;
+out:
+	return mapping_max_folio_size(mapping);
+}
+
 ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 {
 	struct file *file = iocb->ki_filp;
 	loff_t pos = iocb->ki_pos;
 	struct address_space *mapping = file->f_mapping;
 	const struct address_space_operations *a_ops = mapping->a_ops;
-	size_t chunk = mapping_max_folio_size(mapping);
+	size_t chunk = generic_mapping_max_folio_size(mapping, pos);
 	long status = 0;
 	ssize_t written = 0;
 
-- 
2.27.0


