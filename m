Return-Path: <linux-fsdevel+bounces-13615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93943872043
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 14:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499F728354E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 13:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF985C7F;
	Tue,  5 Mar 2024 13:33:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29F85C74;
	Tue,  5 Mar 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645625; cv=none; b=lcH18OTDi/fW9w+v5o8UieWZdTKou9zup119i3TmUgkVfbKXllYVff6506klzgZszFDofB1316In5xt1uW+IktCr2Hy0DtJr54wnf4k8w4A3UH0ZJ35gtep+ASZ5Oo+T43NJEWTF2+CkWAIqNoZJlSofMLGCHBfshGLz7/kkFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645625; c=relaxed/simple;
	bh=ItAT0NnYhcPDafMCdVsOrCiekZ0qH74J7MJ5JNhPLu4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dyo+S0RA7Ucfl7MOM6yot4/xa42fUCrMNHOQJPqcPTckhQMrcKIsn2JI6c4wdaN9XGJn5bx7bemwV+yU4+TTJLYOxCZ/D95cpQLQUFUZs+rS+45iC5bhirj07QVbFkuiAPZuZe6E3SZNx0+JFrIhz0BG0dvetU4GnW+RtUwpU1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TpxKh23rvz1h1Dg;
	Tue,  5 Mar 2024 21:31:20 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F0DA1A016E;
	Tue,  5 Mar 2024 21:33:40 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:33:39 +0800
From: Tong Tiangen <tongtiangen@huawei.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, David Howells
	<dhowells@redhat.com>, Al Viro <viro@kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tong
 Tiangen <tongtiangen@huawei.com>, <wangkefeng.wang@huawei.com>, Guohanjun
	<guohanjun@huawei.com>
Subject: [PATCH] coredump: get machine check errors early rather than during iov_iter
Date: Tue, 5 Mar 2024 21:33:36 +0800
Message-ID: <20240305133336.3804360-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)

The commit f1982740f5e7 ("iov_iter: Convert iterate*() to inline funcs")
leads to deadloop in generic_perform_write()[1], due to return value of
copy_page_from_iter_atomic() changed from non-zero value to zero.

The code logic of the I/O performance-critical path of the iov_iter is
mixed with machine check[2], actually, there's no need to complicate it,
a more appropriate method is to get the error as early as possible in
the coredump process instead of during the I/O process. In addition,
the iov_iter performance-critical path can have clean logic.

[1] https://lore.kernel.org/lkml/4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com/
[2] commit 245f09226893 ("mm: hwpoison: coredump: support recovery from dump_user_range()")

Fixes: f1982740f5e7 ("iov_iter: Convert iterate*() to inline funcs")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Tested-by: David Howells <dhowells@redhat.com>
---
 fs/coredump.c       | 42 +++++++++++++++++++++++++++++++++++++++---
 include/linux/uio.h | 16 ----------------
 lib/iov_iter.c      | 23 -----------------------
 3 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index f258c17c1841..ea155ffee14c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -872,6 +872,9 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 	loff_t pos;
 	ssize_t n;
 
+	if (!page)
+		return 0;
+
 	if (cprm->to_skip) {
 		if (!__dump_skip(cprm, cprm->to_skip))
 			return 0;
@@ -884,7 +887,6 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 	pos = file->f_pos;
 	bvec_set_page(&bvec, page, PAGE_SIZE, 0);
 	iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, PAGE_SIZE);
-	iov_iter_set_copy_mc(&iter);
 	n = __kernel_write_iter(cprm->file, &iter, &pos);
 	if (n != PAGE_SIZE)
 		return 0;
@@ -895,10 +897,41 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 	return 1;
 }
 
+/*
+ * If we might get machine checks from kernel accesses during the
+ * core dump, let's get those errors early rather than during the
+ * IO. This is not performance-critical enough to warrant having
+ * all the machine check logic in the iovec paths.
+ */
+#ifdef copy_mc_to_kernel
+
+#define dump_page_alloc() alloc_page(GFP_KERNEL)
+#define dump_page_free(x) __free_page(x)
+static struct page *dump_page_copy(struct page *src, struct page *dst)
+{
+	void *buf = kmap_local_page(src);
+	size_t left = copy_mc_to_kernel(page_address(dst), buf, PAGE_SIZE);
+
+	kunmap_local(buf);
+	return left ? NULL : dst;
+}
+
+#else
+
+#define dump_page_alloc() ((struct page *)8) // Not NULL
+#define dump_page_free(x) do { } while (0)
+#define dump_page_copy(src, dst) ((dst), (src))
+
+#endif
+
 int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		    unsigned long len)
 {
 	unsigned long addr;
+	struct page *dump_page = dump_page_alloc();
+
+	if (!dump_page)
+		return 0;
 
 	for (addr = start; addr < start + len; addr += PAGE_SIZE) {
 		struct page *page;
@@ -912,14 +945,17 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		 */
 		page = get_dump_page(addr);
 		if (page) {
-			int stop = !dump_emit_page(cprm, page);
+			int stop = !dump_emit_page(cprm, dump_page_copy(page, dump_page));
 			put_page(page);
-			if (stop)
+			if (stop) {
+				dump_page_free(dump_page);
 				return 0;
+			}
 		} else {
 			dump_skip(cprm, PAGE_SIZE);
 		}
 	}
+	dump_page_free(dump_page);
 	return 1;
 }
 #endif
diff --git a/include/linux/uio.h b/include/linux/uio.h
index bea9c89922d9..00cebe2b70de 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -40,7 +40,6 @@ struct iov_iter_state {
 
 struct iov_iter {
 	u8 iter_type;
-	bool copy_mc;
 	bool nofault;
 	bool data_source;
 	size_t iov_offset;
@@ -248,22 +247,8 @@ size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i);
 
 #ifdef CONFIG_ARCH_HAS_COPY_MC
 size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
-static inline void iov_iter_set_copy_mc(struct iov_iter *i)
-{
-	i->copy_mc = true;
-}
-
-static inline bool iov_iter_is_copy_mc(const struct iov_iter *i)
-{
-	return i->copy_mc;
-}
 #else
 #define _copy_mc_to_iter _copy_to_iter
-static inline void iov_iter_set_copy_mc(struct iov_iter *i) { }
-static inline bool iov_iter_is_copy_mc(const struct iov_iter *i)
-{
-	return false;
-}
 #endif
 
 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
@@ -355,7 +340,6 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 	WARN_ON(direction & ~(READ | WRITE));
 	*i = (struct iov_iter) {
 		.iter_type = ITER_UBUF,
-		.copy_mc = false,
 		.data_source = direction,
 		.ubuf = buf,
 		.count = count,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e0aa6b440ca5..cf2eb2b2f983 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -166,7 +166,6 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 	WARN_ON(direction & ~(READ | WRITE));
 	*i = (struct iov_iter) {
 		.iter_type = ITER_IOVEC,
-		.copy_mc = false,
 		.nofault = false,
 		.data_source = direction,
 		.__iov = iov,
@@ -244,27 +243,9 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 EXPORT_SYMBOL_GPL(_copy_mc_to_iter);
 #endif /* CONFIG_ARCH_HAS_COPY_MC */
 
-static __always_inline
-size_t memcpy_from_iter_mc(void *iter_from, size_t progress,
-			   size_t len, void *to, void *priv2)
-{
-	return copy_mc_to_kernel(to + progress, iter_from, len);
-}
-
-static size_t __copy_from_iter_mc(void *addr, size_t bytes, struct iov_iter *i)
-{
-	if (unlikely(i->count < bytes))
-		bytes = i->count;
-	if (unlikely(!bytes))
-		return 0;
-	return iterate_bvec(i, bytes, addr, NULL, memcpy_from_iter_mc);
-}
-
 static __always_inline
 size_t __copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(iov_iter_is_copy_mc(i)))
-		return __copy_from_iter_mc(addr, bytes, i);
 	return iterate_and_advance(i, bytes, addr,
 				   copy_from_user_iter, memcpy_from_iter);
 }
@@ -633,7 +614,6 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int direction,
 	WARN_ON(direction & ~(READ | WRITE));
 	*i = (struct iov_iter){
 		.iter_type = ITER_KVEC,
-		.copy_mc = false,
 		.data_source = direction,
 		.kvec = kvec,
 		.nr_segs = nr_segs,
@@ -650,7 +630,6 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 	WARN_ON(direction & ~(READ | WRITE));
 	*i = (struct iov_iter){
 		.iter_type = ITER_BVEC,
-		.copy_mc = false,
 		.data_source = direction,
 		.bvec = bvec,
 		.nr_segs = nr_segs,
@@ -679,7 +658,6 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
 	BUG_ON(direction & ~1);
 	*i = (struct iov_iter) {
 		.iter_type = ITER_XARRAY,
-		.copy_mc = false,
 		.data_source = direction,
 		.xarray = xarray,
 		.xarray_start = start,
@@ -703,7 +681,6 @@ void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
 	BUG_ON(direction != READ);
 	*i = (struct iov_iter){
 		.iter_type = ITER_DISCARD,
-		.copy_mc = false,
 		.data_source = false,
 		.count = count,
 		.iov_offset = 0
-- 
2.25.1


