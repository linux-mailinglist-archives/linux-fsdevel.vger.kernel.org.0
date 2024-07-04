Return-Path: <linux-fsdevel+bounces-23087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADB6926DD9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 05:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDE21F263C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 03:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7813A18EA1;
	Thu,  4 Jul 2024 03:03:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B461CA87;
	Thu,  4 Jul 2024 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062212; cv=none; b=nVcQVV7NCEkJ89VHPtyabkCTnIPapaN6Po7hT1A8SOif4VaXR/SXlbYvmMuhu++AAtrXTHMUpmjtf/HuPfUZM8vOF28TKrqI0TQ/wCTnQ4NuUUvhdmuP+oc5cdp1tG0hi3euYrg+03x5wKdbXpPMeKkYs97RyRiHYOfeAmyjgSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062212; c=relaxed/simple;
	bh=dGLTdYq2h2klz3YB7ga+OgY2y9/yXF+azhAYesQVP+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBYSg90E7r8J9HWWgLAi8gn64UsgwHF3q1Kmas9yT1AxvdRhWYwwl+wGqgYDWGyeT2U1pmVxrMLJ66IuHQ3q7YfraSCq+47xwu4MWtza22kOCHB1r2NZim8v2YcaylZXOjyjY1fEPzSiJQkJQNXnttZRu72M/Ipy9gpH+/XrWbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WF1ZC6VKXzxTN5;
	Thu,  4 Jul 2024 10:58:59 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 2BBD814011A;
	Thu,  4 Jul 2024 11:03:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Jul
 2024 11:03:27 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <muchun.song@linux.dev>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>
CC: <linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v2 1/2] hugetlbfs: support tracepoint
Date: Thu, 4 Jul 2024 11:07:03 +0800
Message-ID: <20240704030704.2289667-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704030704.2289667-1-lihongbo22@huawei.com>
References: <20240704030704.2289667-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Add basic tracepoints for {alloc, evict, free}_inode, setattr and
fallocate. These can help users to debug hugetlbfs more conveniently.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 MAINTAINERS                      |   1 +
 include/trace/events/hugetlbfs.h | 160 +++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100644 include/trace/events/hugetlbfs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cd2ca0c3158e..865c48e92d40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10188,6 +10188,7 @@ F:	Documentation/mm/hugetlbfs_reserv.rst
 F:	Documentation/mm/vmemmap_dedup.rst
 F:	fs/hugetlbfs/
 F:	include/linux/hugetlb.h
+F:	include/trace/events/hugetlbfs.h
 F:	mm/hugetlb.c
 F:	mm/hugetlb_vmemmap.c
 F:	mm/hugetlb_vmemmap.h
diff --git a/include/trace/events/hugetlbfs.h b/include/trace/events/hugetlbfs.h
new file mode 100644
index 000000000000..975f584f6f51
--- /dev/null
+++ b/include/trace/events/hugetlbfs.h
@@ -0,0 +1,160 @@
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
+		__field(unsigned int,	ia_uid)
+		__field(unsigned int,	ia_gid)
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
+		__entry->ia_uid		= from_kuid_munged(current_user_ns(), attr->ia_uid);
+		__entry->ia_gid		= from_kgid_munged(current_user_ns(), attr->ia_gid);
+		__entry->old_size	= inode->i_size;
+		__entry->ia_size	= attr->ia_size;
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


