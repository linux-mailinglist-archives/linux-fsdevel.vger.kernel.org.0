Return-Path: <linux-fsdevel+bounces-21490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91996904828
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 03:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EAD28598E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 01:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B73E4696;
	Wed, 12 Jun 2024 01:10:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E1E1FA1;
	Wed, 12 Jun 2024 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718154608; cv=none; b=CS6NCcv79rqYh+ptHsMYTqwoyqo3sieM1CQX9evSxWsR2E0Crafw8D0xZTpsbXeAeXQSDopyKjaOIhid7Aa918avjkWP6Y5xYLm2IJi2Q3Gdw7dKyyZGOPFiNg5KunevSQRDj2DdKgvyzcCM8OChKokH3bIhSoZpKSn4y+CmiJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718154608; c=relaxed/simple;
	bh=zoHdF/WyuE+w6NzEkLDnvsTjYjSFD4r+wZV59EXEvbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlpAxfL59R5PB/eOFPJDYEZl8gObjQ2qEGyZIoURe1SKetoj66ydF1vYS4zffeHxnm2rYB9X55GyQbVVmDcO3WqQNZWQZGGw2FA+TWtEzexLIQUvi13x+04SPeLcGE3Gga6+uO6JMHOMZpVmyS6Ng4x0TEGSOFfwenShGhOUdPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VzS5x64cgz1SBrq;
	Wed, 12 Jun 2024 09:05:57 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id EFDA8180069;
	Wed, 12 Jun 2024 09:10:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 09:10:02 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <muchun.song@linux.dev>, <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC: <mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH 1/2] hugetlbfs: support tracepoint
Date: Wed, 12 Jun 2024 09:11:55 +0800
Message-ID: <20240612011156.2891254-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612011156.2891254-1-lihongbo22@huawei.com>
References: <20240612011156.2891254-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Add basic tracepoints for {alloc, evict, free}_inode, setattr and
fallocate. These can help users to debug hugetlbfs more conveniently.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 MAINTAINERS                      |   1 +
 include/trace/events/hugetlbfs.h | 164 +++++++++++++++++++++++++++++++
 2 files changed, 165 insertions(+)
 create mode 100644 include/trace/events/hugetlbfs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index aacccb376c28..df6fe4aa0f50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10187,6 +10187,7 @@ F:	Documentation/mm/hugetlbfs_reserv.rst
 F:	Documentation/mm/vmemmap_dedup.rst
 F:	fs/hugetlbfs/
 F:	include/linux/hugetlb.h
+F:	include/trace/events/hugetlbfs.h
 F:	mm/hugetlb.c
 F:	mm/hugetlb_vmemmap.c
 F:	mm/hugetlb_vmemmap.h
diff --git a/include/trace/events/hugetlbfs.h b/include/trace/events/hugetlbfs.h
new file mode 100644
index 000000000000..a4d785c87155
--- /dev/null
+++ b/include/trace/events/hugetlbfs.h
@@ -0,0 +1,164 @@
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
+	TP_printk("dev = (%d,%d), ino = %lu, dir = %lu, mode = 0%o",
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
+	TP_printk("dev = (%d,%d), ino = %lu, i_mode = 0%o, i_size = %lld, i_nlink = %u, seals = %u, i_blocks = %llu",
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
+	TP_PROTO(struct inode *inode,
+		unsigned int d_len, const unsigned char *d_name,
+		unsigned int ia_valid, unsigned int ia_mode,
+		unsigned int ia_uid, unsigned int ia_gid,
+		loff_t old_size, loff_t ia_size),
+
+	TP_ARGS(inode, d_len, d_name,
+		ia_valid, ia_mode, ia_uid, ia_gid, old_size, ia_size),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev)
+		__field(ino_t,		ino)
+		__field(unsigned int,	d_len)
+		__string(d_name,	d_name)
+		__field(unsigned int,	ia_valid)
+		__field(unsigned int,	ia_mode)
+		__field(unsigned int,	ia_uid)
+		__field(unsigned int,	ia_gid)
+		__field(loff_t,		old_size)
+		__field(loff_t,		ia_size)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->d_len		= d_len;
+		__assign_str(d_name);
+		__entry->ia_valid	= ia_valid;
+		__entry->ia_mode	= ia_mode;
+		__entry->ia_uid		= ia_uid;
+		__entry->ia_gid		= ia_gid;
+		__entry->old_size	= old_size;
+		__entry->ia_size	= ia_size;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, name = %.*s, ia_valid = %u, ia_mode = 0%o, ia_uid = %u, ia_gid = %u, old_size = %lld, ia_size = %lld",
+		MAJOR(__entry->dev), MINOR(__entry->dev), (unsigned long)__entry->ino,
+		__entry->d_len, __get_str(d_name), __entry->ia_valid, __entry->ia_mode,
+		__entry->ia_uid, __entry->ia_gid, __entry->old_size, __entry->ia_size)
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
+	TP_printk("dev = (%d,%d), ino = %lu, mode = %x, offset = %lld, len = %lld,  i_size = %lld, ret = %d",
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


