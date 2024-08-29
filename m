Return-Path: <linux-fsdevel+bounces-27771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF37963BB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 08:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68745283F1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 06:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF31B132124;
	Thu, 29 Aug 2024 06:33:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA0E47A76;
	Thu, 29 Aug 2024 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724913197; cv=none; b=p8llBe+Xr1WHyJIiRwA+dcy6e5b2s3RTuT0k9S3DBbvLyl0vcdD/J+lvw5PX0RVNLvpGdCUsd7E7+NlR3NImfqF2qL/ZD3MIvDTQVozRUgbHjtfLlM+I3xAvxBuFmmihedUK9o6FwNXip1gcPRtQ09HH3cvvBmeAya4dtTA+vD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724913197; c=relaxed/simple;
	bh=mICJpqw5WpEh2dbM6f4jT6a7wPgGFvdiNOGFYgBsOso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQHTEfKPj9+D5WIwWtPffxNJV8o2SUsiecEnVMTVqU7bRoa5F6kDQzVZ/Kq4+jJXNce7yJLu1Vq3o4+wizhqioN8iV/YbPhIJVuz7WLtTPdcIcdhikLcyi3VYfhX0enUcQWG4XJPLopuAwyBTxG2wpSgsVlWV3XoAELu7zjPI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvWYz21wXz20n5b;
	Thu, 29 Aug 2024 14:28:23 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BA5C1A0188;
	Thu, 29 Aug 2024 14:33:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 Aug
 2024 14:33:13 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <muchun.song@linux.dev>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>, <david@fromorbit.com>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH RESEND v3 1/2] hugetlbfs: support tracepoint
Date: Thu, 29 Aug 2024 14:41:09 +0800
Message-ID: <20240829064110.67884-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829064110.67884-1-lihongbo22@huawei.com>
References: <20240829064110.67884-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Add basic tracepoints for {alloc, evict, free}_inode, setattr and
fallocate. These can help users to debug hugetlbfs more conveniently.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 MAINTAINERS                      |   1 +
 include/trace/events/hugetlbfs.h | 156 +++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)
 create mode 100644 include/trace/events/hugetlbfs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a70b7c9c3533..f7d90c090961 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10367,6 +10367,7 @@ F:	Documentation/mm/hugetlbfs_reserv.rst
 F:	Documentation/mm/vmemmap_dedup.rst
 F:	fs/hugetlbfs/
 F:	include/linux/hugetlb.h
+F:	include/trace/events/hugetlbfs.h
 F:	mm/hugetlb.c
 F:	mm/hugetlb_vmemmap.c
 F:	mm/hugetlb_vmemmap.h
diff --git a/include/trace/events/hugetlbfs.h b/include/trace/events/hugetlbfs.h
new file mode 100644
index 000000000000..8331c904a9ba
--- /dev/null
+++ b/include/trace/events/hugetlbfs.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hugetlbfs
+
+#if !defined(_TRACE_HUGETLBFS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_HUGETLBFS_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(hugetlbfs_alloc_inode,
+
+	TP_PROTO(struct inode *inode, struct inode *dir, int mode),
+
+	TP_ARGS(inode, dir, mode),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev)
+		__field(ino_t,		ino)
+		__field(ino_t,		dir)
+		__field(__u16,		mode)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->dir		= dir->i_ino;
+		__entry->mode		= mode;
+	),
+
+	TP_printk("dev %d,%d ino %lu dir %lu mode 0%o",
+		MAJOR(__entry->dev), MINOR(__entry->dev),
+		(unsigned long) __entry->ino,
+		(unsigned long) __entry->dir, __entry->mode)
+);
+
+DECLARE_EVENT_CLASS(hugetlbfs__inode,
+
+	TP_PROTO(struct inode *inode),
+
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev)
+		__field(ino_t,		ino)
+		__field(__u16,		mode)
+		__field(loff_t,		size)
+		__field(unsigned int,	nlink)
+		__field(unsigned int,	seals)
+		__field(blkcnt_t,	blocks)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->mode		= inode->i_mode;
+		__entry->size		= inode->i_size;
+		__entry->nlink		= inode->i_nlink;
+		__entry->seals		= HUGETLBFS_I(inode)->seals;
+		__entry->blocks		= inode->i_blocks;
+	),
+
+	TP_printk("dev %d,%d ino %lu mode 0%o size %lld nlink %u seals %u blocks %llu",
+		MAJOR(__entry->dev), MINOR(__entry->dev), (unsigned long) __entry->ino,
+		__entry->mode, __entry->size, __entry->nlink, __entry->seals,
+		(unsigned long long)__entry->blocks)
+);
+
+DEFINE_EVENT(hugetlbfs__inode, hugetlbfs_evict_inode,
+
+	TP_PROTO(struct inode *inode),
+
+	TP_ARGS(inode)
+);
+
+DEFINE_EVENT(hugetlbfs__inode, hugetlbfs_free_inode,
+
+	TP_PROTO(struct inode *inode),
+
+	TP_ARGS(inode)
+);
+
+TRACE_EVENT(hugetlbfs_setattr,
+
+	TP_PROTO(struct inode *inode, struct dentry *dentry,
+		struct iattr *attr),
+
+	TP_ARGS(inode, dentry, attr),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev)
+		__field(ino_t,		ino)
+		__field(unsigned int,	d_len)
+		__string(d_name,	dentry->d_name.name)
+		__field(unsigned int,	ia_valid)
+		__field(unsigned int,	ia_mode)
+		__field(loff_t,		old_size)
+		__field(loff_t,		ia_size)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->d_len		= dentry->d_name.len;
+		__assign_str(d_name);
+		__entry->ia_valid	= attr->ia_valid;
+		__entry->ia_mode	= attr->ia_mode;
+		__entry->old_size	= inode->i_size;
+		__entry->ia_size	= attr->ia_size;
+	),
+
+	TP_printk("dev %d,%d ino %lu name %.*s valid %#x mode 0%o old_size %lld size %lld",
+		MAJOR(__entry->dev), MINOR(__entry->dev), (unsigned long)__entry->ino,
+		__entry->d_len, __get_str(d_name), __entry->ia_valid, __entry->ia_mode,
+		__entry->old_size, __entry->ia_size)
+);
+
+TRACE_EVENT(hugetlbfs_fallocate,
+
+	TP_PROTO(struct inode *inode, int mode,
+		loff_t offset, loff_t len, int ret),
+
+	TP_ARGS(inode, mode, offset, len, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev)
+		__field(ino_t,		ino)
+		__field(int,		mode)
+		__field(loff_t,		offset)
+		__field(loff_t,		len)
+		__field(loff_t,		size)
+		__field(int,		ret)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->mode		= mode;
+		__entry->offset		= offset;
+		__entry->len		= len;
+		__entry->size		= inode->i_size;
+		__entry->ret		= ret;
+	),
+
+	TP_printk("dev %d,%d ino %lu mode 0%o offset %lld len %lld size %lld ret %d",
+		MAJOR(__entry->dev), MINOR(__entry->dev),
+		(unsigned long)__entry->ino, __entry->mode,
+		(unsigned long long)__entry->offset,
+		(unsigned long long)__entry->len,
+		(unsigned long long)__entry->size,
+		__entry->ret)
+);
+
+#endif /* _TRACE_HUGETLBFS_H */
+
+ /* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.34.1


