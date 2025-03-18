Return-Path: <linux-fsdevel+bounces-44257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F2EA66A87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1733BB3CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 06:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2215F1D63CD;
	Tue, 18 Mar 2025 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C2aHdx9E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85EC4C6D;
	Tue, 18 Mar 2025 06:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279656; cv=none; b=K6ek521MdNGSQM9IFttjiLFzYrKQPzlLU3gaVh9IBqEF2Q8zhqxEA0VM2qzBP8yC8UVxyrU+9GHnB0r0/O6BzaKMFAc+Fj6KDpHdwgXQbkwMu+77x/Z0humfHxhkRj3cPPk5uudrIooi0J+U8akyxF6YGLR8Q+N3R37jqh7oHrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279656; c=relaxed/simple;
	bh=R8IA/h5kuNMYoLSiaR1PFdQprQUncRuQof6zLLOa+Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O7nHlqaacuysipxm4H9hajiC4UjkTr9fN5zEVIuehChKSMFuxEs36ONmkUbW5cYLVxH8b69JGiNdkig5LQtzP+ghdA8kdA3jZtazMTEaDqHQnEC+W/vk0Oy02teIyN7Fz4QbCSidU2qkg14WTBBXIq+uV2lE9xyOJm6kMIpXyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C2aHdx9E; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/lMSm
	DJnLQOCrq8yGaCgmI/hezWy6ytM+F+ncidM3WY=; b=C2aHdx9EIQtVaa3mFsBHS
	/F2jAQxF2koD63mAcmLhPD5hzL+rn2ZObrWyrYJFUvTtnK5merK6LWCOD+feLOm1
	T1s0wBWMeIqVv55HQFpEf0Yn3YV289ZWSG0H+fzUXXG3hxW9cLFPYKHFGIeVzcha
	EYl/FqhHZAU7sq8I2KqwQY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnj1R_E9lnWny0AA--.27191S2;
	Tue, 18 Mar 2025 14:32:32 +0800 (CST)
From: Liu Ye <liuyerd@163.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev
Cc: akpm@linux-foundation.org,
	willy@infradead.org,
	david@redhat.com,
	svetly.todorov@memverge.com,
	vbabka@suse.cz,
	liuyerd@163.com,
	ran.xiaokai@zte.com.cn,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH v4] fs/proc/page: Refactoring to reduce code duplication.
Date: Tue, 18 Mar 2025 14:32:26 +0800
Message-Id: <20250318063226.223284-1-liuyerd@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj1R_E9lnWny0AA--.27191S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr48XF4xZr1kuw4xZw4kXrb_yoWxAry8pF
	s8Gr4jyw48W34Ykr1xJ395Zas8G3s3Aa1Yy3y7G34Sva47JFnaka4SyFn0vFyxGryUZF1U
	ua909ry3CFWjyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnjjgUUUUU=
X-CM-SenderInfo: 5olx5vlug6il2tof0z/1tbiKBAUTGfZDod+JgAAsP

From: Liu Ye <liuye@kylinos.cn>

The function kpageflags_read and kpagecgroup_read is quite similar
to kpagecount_read. Consider refactoring common code into a helper
function to reduce code duplication.

Signed-off-by: Liu Ye <liuye@kylinos.cn>

---
V4 : Update code remake patch.
V3 : Add a stub for page_cgroup_ino and remove the #ifdef CONFIG_MEMCG.
V2 : Use an enumeration to indicate the operation to be performed
to avoid passing functions.
---
---
 fs/proc/page.c             | 161 +++++++++++++------------------------
 include/linux/memcontrol.h |   4 +
 2 files changed, 58 insertions(+), 107 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 23fc771100ae..999af26c7298 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -22,6 +22,12 @@
 #define KPMMASK (KPMSIZE - 1)
 #define KPMBITS (KPMSIZE * BITS_PER_BYTE)
 
+enum kpage_operation {
+	KPAGE_FLAGS,
+	KPAGE_COUNT,
+	KPAGE_CGROUP,
+};
+
 static inline unsigned long get_max_dump_pfn(void)
 {
 #ifdef CONFIG_SPARSEMEM
@@ -37,19 +43,17 @@ static inline unsigned long get_max_dump_pfn(void)
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
+		enum kpage_operation op)
 {
 	const unsigned long max_dump_pfn = get_max_dump_pfn();
 	u64 __user *out = (u64 __user *)buf;
+	struct page *page;
 	unsigned long src = *ppos;
 	unsigned long pfn;
 	ssize_t ret = 0;
+	u64 info;
 
 	pfn = src / KPMSIZE;
 	if (src & KPMMASK || count & KPMMASK)
@@ -59,24 +63,34 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
 	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
 
 	while (count > 0) {
-		struct page *page;
-		u64 mapcount = 0;
-
 		/*
 		 * TODO: ZONE_DEVICE support requires to identify
 		 * memmaps that were actually initialized.
 		 */
 		page = pfn_to_online_page(pfn);
-		if (page) {
-			struct folio *folio = page_folio(page);
 
-			if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
-				mapcount = folio_precise_page_mapcount(folio, page);
-			else
-				mapcount = folio_average_page_mapcount(folio);
-		}
-
-		if (put_user(mapcount, out)) {
+		if (page) {
+			switch (op) {
+			case KPAGE_FLAGS:
+				info = stable_page_flags(page);
+				break;
+			case KPAGE_COUNT:
+				if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
+					info = folio_precise_page_mapcount(page_folio(page), page);
+				else
+					info = folio_average_page_mapcount(page_folio(page));
+				break;
+			case KPAGE_CGROUP:
+				info = page_cgroup_ino(page);
+				break;
+			default:
+				info = 0;
+				break;
+			}
+		} else
+			info = 0;
+
+		if (put_user(info, out)) {
 			ret = -EFAULT;
 			break;
 		}
@@ -94,17 +108,23 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
 	return ret;
 }
 
+/* /proc/kpagecount - an array exposing page mapcounts
+ *
+ * Each entry is a u64 representing the corresponding
+ * physical page mapcount.
+ */
+static ssize_t kpagecount_read(struct file *file, char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	return kpage_read(file, buf, count, ppos, KPAGE_COUNT);
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
@@ -225,47 +245,17 @@ u64 stable_page_flags(const struct page *page)
 #endif
 
 	return u;
-};
+}
 
+/* /proc/kpageflags - an array exposing page flags
+ *
+ * Each entry is a u64 representing the corresponding
+ * physical page flags.
+ */
 static ssize_t kpageflags_read(struct file *file, char __user *buf,
-			     size_t count, loff_t *ppos)
+		size_t count, loff_t *ppos)
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
-
-	*ppos += (char __user *)out - buf;
-	if (!ret)
-		ret = (char __user *)out - buf;
-	return ret;
+	return kpage_read(file, buf, count, ppos, KPAGE_FLAGS);
 }
 
 static const struct proc_ops kpageflags_proc_ops = {
@@ -276,53 +266,10 @@ static const struct proc_ops kpageflags_proc_ops = {
 
 #ifdef CONFIG_MEMCG
 static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
-				size_t count, loff_t *ppos)
+		size_t count, loff_t *ppos)
 {
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
-
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
+	return kpage_read(file, buf, count, ppos, KPAGE_CGROUP);
 }
-
 static const struct proc_ops kpagecgroup_proc_ops = {
 	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_lseek	= mem_lseek,
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 53364526d877..5264d148bdd9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1793,6 +1793,10 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
 {
 }
 
+static inline ino_t page_cgroup_ino(struct page *page)
+{
+	return 0;
+}
 #endif /* CONFIG_MEMCG */
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
-- 
2.25.1


