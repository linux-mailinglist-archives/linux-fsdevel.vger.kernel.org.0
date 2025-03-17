Return-Path: <linux-fsdevel+bounces-44177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD80A6449F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 09:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4B817110C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 08:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F0621B8E1;
	Mon, 17 Mar 2025 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LXYa6rJh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0144F71747;
	Mon, 17 Mar 2025 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742198526; cv=none; b=CfBpCYeumlk5iTd/WGkME6xf1FI7hI8DAYh72kxVOl81SOt+eOA9EHNSX84UW1OMeUeE5VEyE71mj6M7IB+JZ4yrme9uGw59kSO/Ka5bG4OvdUlxmXAA+txVPe8x0t6GwTHQK9Dut7FkYQ1sJXrIZZLdvi3/zHGZAp2+qN2j+M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742198526; c=relaxed/simple;
	bh=M+Kw1B2DoYfbyTL0dVZrjviFZjE6yvLuLW9vZ2ZIIsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LFcSs5Bx3Q9S38QXNwswPCi9MD+sGayJbWufXf9/7UjXLA6MGjTld7t6pQG+xTy6QbCGnGYy/NSsDsKV/N4We4MtYHJ9guK4LZ2BXxMUN/7ueWL4CN/xqymOYg/YX9s+4rhGU0dksXcjzz0oS6jawRxDR0EVrEP0/cp68pc26mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LXYa6rJh; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=RJsWC
	v23zVbdpMXgJm8MXsao+iQkz5wN6dYN/CaaUcA=; b=LXYa6rJhwaB5lu4thZvy2
	OltLovenY8xOtcl+RjJaQYwy04OmMawhU1xbnGewiCRNkDglIkjK5p4n1g7/4EJx
	4S7g14OS5engNE15mgAbfk4hzYVrhEe/NVo0FIG4N1WErgRRCZ0wYIy/WKd/WXu2
	bcLt88lThX2FKmVyN0nQPk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3n4LP1tdnYeUzBQ--.3873S2;
	Mon, 17 Mar 2025 16:01:21 +0800 (CST)
From: Liu Ye <liuyerd@163.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	david@redhat.com,
	ran.xiaokai@zte.com.cn,
	dan.carpenter@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Liu Ye <liuyerd@163.com>,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH] fs/proc/page: Refactoring to reduce code duplication.
Date: Mon, 17 Mar 2025 16:01:18 +0800
Message-Id: <20250317080118.95696-1-liuyerd@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3n4LP1tdnYeUzBQ--.3873S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr48urW8AryrXFy8Kr1xKrg_yoW7ZFWkpF
	s8XayUArs5Wrn0kw1xJ398Zas8W34fZa1Yy3y7G34fZ3WUJrnIkFySyFn0vFy8G34UZw4U
	ua909ry5CF4UtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USoGdUUUUU=
X-CM-SenderInfo: 5olx5vlug6il2tof0z/1tbiKBETTGfXzsDMtAAAsg

From: Liu Ye <liuye@kylinos.cn>

The function kpageflags_read and kpagecgroup_read is quite similar
to kpagecount_read. Consider refactoring common code into a helper
function to reduce code duplication.

Signed-off-by: Liu Ye <liuye@kylinos.cn>
---
 fs/proc/page.c | 158 ++++++++++++++++---------------------------------
 1 file changed, 50 insertions(+), 108 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index a55f5acefa97..f413016ebe67 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -37,19 +37,17 @@ static inline unsigned long get_max_dump_pfn(void)
 #endif
 }
 
-/* /proc/kpagecount - an array exposing page mapcounts
- *
- * Each entry is a u64 representing the corresponding
- * physical page mapcount.
- */
-static ssize_t kpagecount_read(struct file *file, char __user *buf,
-			     size_t count, loff_t *ppos)
+static ssize_t kpage_read(struct file *file, char __user *buf,
+		size_t count, loff_t *ppos,
+		u64 (*get_page_info)(struct page *))
 {
 	const unsigned long max_dump_pfn = get_max_dump_pfn();
 	u64 __user *out = (u64 __user *)buf;
+	struct page *ppage;
 	unsigned long src = *ppos;
 	unsigned long pfn;
 	ssize_t ret = 0;
+	u64 info;
 
 	pfn = src / KPMSIZE;
 	if (src & KPMMASK || count & KPMMASK)
@@ -59,19 +57,14 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
 	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
 
 	while (count > 0) {
-		struct page *page;
-		u64 mapcount = 0;
-
-		/*
-		 * TODO: ZONE_DEVICE support requires to identify
-		 * memmaps that were actually initialized.
-		 */
-		page = pfn_to_online_page(pfn);
-		if (page)
-			mapcount = folio_precise_page_mapcount(page_folio(page),
-							       page);
-
-		if (put_user(mapcount, out)) {
+		ppage = pfn_to_online_page(pfn);
+
+		if (ppage)
+			info = get_page_info(ppage);
+		else
+			info = 0;
+
+		if (put_user(info, out)) {
 			ret = -EFAULT;
 			break;
 		}
@@ -89,17 +82,28 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
 	return ret;
 }
 
+static u64 get_page_count(struct page *page)
+{
+	return folio_precise_page_mapcount(page_folio(page), page);
+}
+
+/* /proc/kpagecount - an array exposing page mapcounts
+ *
+ * Each entry is a u64 representing the corresponding
+ * physical page mapcount.
+ */
+static ssize_t kpagecount_read(struct file *file, char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	return kpage_read(file, buf, count, ppos, get_page_count);
+}
+
 static const struct proc_ops kpagecount_proc_ops = {
 	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_lseek	= mem_lseek,
 	.proc_read	= kpagecount_read,
 };
 
-/* /proc/kpageflags - an array exposing page flags
- *
- * Each entry is a u64 representing the corresponding
- * physical page flags.
- */
 
 static inline u64 kpf_copy_bit(u64 kflags, int ubit, int kbit)
 {
@@ -220,47 +224,22 @@ u64 stable_page_flags(const struct page *page)
 #endif
 
 	return u;
-};
+}
 
-static ssize_t kpageflags_read(struct file *file, char __user *buf,
-			     size_t count, loff_t *ppos)
+static u64 get_page_flags(struct page *page)
 {
-	const unsigned long max_dump_pfn = get_max_dump_pfn();
-	u64 __user *out = (u64 __user *)buf;
-	unsigned long src = *ppos;
-	unsigned long pfn;
-	ssize_t ret = 0;
-
-	pfn = src / KPMSIZE;
-	if (src & KPMMASK || count & KPMMASK)
-		return -EINVAL;
-	if (src >= max_dump_pfn * KPMSIZE)
-		return 0;
-	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
-
-	while (count > 0) {
-		/*
-		 * TODO: ZONE_DEVICE support requires to identify
-		 * memmaps that were actually initialized.
-		 */
-		struct page *page = pfn_to_online_page(pfn);
-
-		if (put_user(stable_page_flags(page), out)) {
-			ret = -EFAULT;
-			break;
-		}
-
-		pfn++;
-		out++;
-		count -= KPMSIZE;
-
-		cond_resched();
-	}
+	return stable_page_flags(page);
+}
 
-	*ppos += (char __user *)out - buf;
-	if (!ret)
-		ret = (char __user *)out - buf;
-	return ret;
+/* /proc/kpageflags - an array exposing page flags
+ *
+ * Each entry is a u64 representing the corresponding
+ * physical page flags.
+ */
+static ssize_t kpageflags_read(struct file *file, char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	return kpage_read(file, buf, count, ppos, get_page_flags);
 }
 
 static const struct proc_ops kpageflags_proc_ops = {
@@ -270,54 +249,17 @@ static const struct proc_ops kpageflags_proc_ops = {
 };
 
 #ifdef CONFIG_MEMCG
-static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
-				size_t count, loff_t *ppos)
-{
-	const unsigned long max_dump_pfn = get_max_dump_pfn();
-	u64 __user *out = (u64 __user *)buf;
-	struct page *ppage;
-	unsigned long src = *ppos;
-	unsigned long pfn;
-	ssize_t ret = 0;
-	u64 ino;
-
-	pfn = src / KPMSIZE;
-	if (src & KPMMASK || count & KPMMASK)
-		return -EINVAL;
-	if (src >= max_dump_pfn * KPMSIZE)
-		return 0;
-	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
-
-	while (count > 0) {
-		/*
-		 * TODO: ZONE_DEVICE support requires to identify
-		 * memmaps that were actually initialized.
-		 */
-		ppage = pfn_to_online_page(pfn);
-
-		if (ppage)
-			ino = page_cgroup_ino(ppage);
-		else
-			ino = 0;
 
-		if (put_user(ino, out)) {
-			ret = -EFAULT;
-			break;
-		}
-
-		pfn++;
-		out++;
-		count -= KPMSIZE;
-
-		cond_resched();
-	}
-
-	*ppos += (char __user *)out - buf;
-	if (!ret)
-		ret = (char __user *)out - buf;
-	return ret;
+static u64 get_page_cgroup(struct page *page)
+{
+	return page_cgroup_ino(page);
 }
 
+static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	return kpage_read(file, buf, count, ppos, get_page_cgroup);
+}
 static const struct proc_ops kpagecgroup_proc_ops = {
 	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_lseek	= mem_lseek,
-- 
2.25.1


