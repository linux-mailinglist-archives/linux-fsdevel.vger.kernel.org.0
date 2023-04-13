Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430716E057F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 05:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDMDzO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 23:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDMDzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 23:55:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487C84EE8;
        Wed, 12 Apr 2023 20:55:09 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pxm070TYNzrZm9;
        Thu, 13 Apr 2023 11:53:43 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 11:55:06 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Miaohe Lin <linmiaohe@huawei.com>, <linux-kernel@vger.kernel.org>,
        <tongtiangen@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: hwpoison: coredump: support recovery from dump_user_range()
Date:   Thu, 13 Apr 2023 12:13:36 +0800
Message-ID: <20230413041336.26874-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The dump_user_range() is used to copy the user page to a coredump
file, but if a hardware memory error occurred during copy, which
called from __kernel_write_iter() in dump_user_range(), it crashs,

 CPU: 112 PID: 7014 Comm: mca-recover Not tainted 6.3.0-rc2 #425

 pc : __memcpy+0x110/0x260
 lr : _copy_from_iter+0x3bc/0x4c8
 ...
 Call trace:
  __memcpy+0x110/0x260
  copy_page_from_iter+0xcc/0x130
  pipe_write+0x164/0x6d8
  __kernel_write_iter+0x9c/0x210
  dump_user_range+0xc8/0x1d8
  elf_core_dump+0x308/0x368
  do_coredump+0x2e8/0xa40
  get_signal+0x59c/0x788
  do_signal+0x118/0x1f8
  do_notify_resume+0xf0/0x280
  el0_da+0x130/0x138
  el0t_64_sync_handler+0x68/0xc0
  el0t_64_sync+0x188/0x190

Generally, the '->write_iter' of file ops will use copy_page_from_iter()
and copy_page_from_iter_atomic(), change memcpy() to copy_mc_to_kernel()
in both of them to handle #MC during source read, which stop coredump
processing and kill the task instead of kernel panic, but the source
address may not always an user address, so introduce a new copy_mc flag
in struct iov_iter{} to indicate that the iter could do a safe memory
copy, also introduce the helpers to set/clear/check the flag, for now,
it's only used in coredump's dump_user_range(), but it could expand to
any other scenarios to fix the similar issue.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/coredump.c       |  2 ++
 include/linux/uio.h | 26 ++++++++++++++++++++++++++
 lib/iov_iter.c      | 17 +++++++++++++++--
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 5df1e6e1eb2b..d1c82ec86797 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -882,7 +882,9 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 	pos = file->f_pos;
 	bvec_set_page(&bvec, page, PAGE_SIZE, 0);
 	iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, PAGE_SIZE);
+	iov_iter_set_copy_mc(&iter);
 	n = __kernel_write_iter(cprm->file, &iter, &pos);
+	iov_iter_clear_copy_mc(&iter);
 	if (n != PAGE_SIZE)
 		return 0;
 	file->f_pos = pos;
diff --git a/include/linux/uio.h b/include/linux/uio.h
index c459e1d5772b..4a549ce2f6d9 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -43,6 +43,7 @@ struct iov_iter {
 	bool nofault;
 	bool data_source;
 	bool user_backed;
+	bool copy_mc;
 	size_t iov_offset;
 	/*
 	 * Hack alert: overlay ubuf_iovec with iovec + count, so
@@ -142,6 +143,30 @@ static inline bool user_backed_iter(const struct iov_iter *i)
 	return i->user_backed;
 }
 
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+static inline void iov_iter_set_copy_mc(struct iov_iter *i)
+{
+	i->copy_mc = true;
+}
+
+static inline void iov_iter_clear_copy_mc(struct iov_iter *i)
+{
+	i->copy_mc = false;
+}
+
+static inline bool iov_iter_is_copy_mc(const struct iov_iter *i)
+{
+	return i->copy_mc;
+}
+#else
+static inline void iov_iter_set_copy_mc(struct iov_iter *i) { }
+static inline void iov_iter_clear_copy_mc(struct iov_iter *i) {}
+static inline bool iov_iter_is_copy_mc(const struct iov_iter *i)
+{
+	return false;
+}
+#endif
+
 /*
  * Total number of bytes covered by an iovec.
  *
@@ -359,6 +384,7 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 		.iter_type = ITER_UBUF,
 		.user_backed = true,
 		.data_source = direction,
+		.copy_mc = false,
 		.ubuf = buf,
 		.count = count,
 		.nr_segs = 1
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6d0203a3c00a..84bdb09e64a7 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -291,6 +291,7 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 		.nofault = false,
 		.user_backed = true,
 		.data_source = direction,
+		.copy_mc = false,
 		.__iov = iov,
 		.nr_segs = nr_segs,
 		.iov_offset = 0,
@@ -371,6 +372,14 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 EXPORT_SYMBOL_GPL(_copy_mc_to_iter);
 #endif /* CONFIG_ARCH_HAS_COPY_MC */
 
+static void *memcpy_from_iter(struct iov_iter *i, void *to, const void *from,
+				 size_t size)
+{
+       if (iov_iter_is_copy_mc(i))
+               return (void *)copy_mc_to_kernel(to, from, size);
+	return memcpy(to, from, size);
+}
+
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
 	if (WARN_ON_ONCE(!i->data_source))
@@ -380,7 +389,7 @@ size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 		might_fault();
 	iterate_and_advance(i, bytes, base, len, off,
 		copyin(addr + off, base, len),
-		memcpy(addr + off, base, len)
+		memcpy_from_iter(i, addr + off, base, len)
 	)
 
 	return bytes;
@@ -571,7 +580,7 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t byt
 	}
 	iterate_and_advance(i, bytes, base, len, off,
 		copyin(p + off, base, len),
-		memcpy(p + off, base, len)
+		memcpy_from_iter(i, p + off, base, len)
 	)
 	kunmap_atomic(kaddr);
 	return bytes;
@@ -705,6 +714,7 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int direction,
 	*i = (struct iov_iter){
 		.iter_type = ITER_KVEC,
 		.data_source = direction,
+		.copy_mc = false,
 		.kvec = kvec,
 		.nr_segs = nr_segs,
 		.iov_offset = 0,
@@ -721,6 +731,7 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 	*i = (struct iov_iter){
 		.iter_type = ITER_BVEC,
 		.data_source = direction,
+		.copy_mc = false,
 		.bvec = bvec,
 		.nr_segs = nr_segs,
 		.iov_offset = 0,
@@ -749,6 +760,7 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
 	*i = (struct iov_iter) {
 		.iter_type = ITER_XARRAY,
 		.data_source = direction,
+		.copy_mc = false,
 		.xarray = xarray,
 		.xarray_start = start,
 		.count = count,
@@ -772,6 +784,7 @@ void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
 	*i = (struct iov_iter){
 		.iter_type = ITER_DISCARD,
 		.data_source = false,
+		.copy_mc = false,
 		.count = count,
 		.iov_offset = 0
 	};
-- 
2.35.3

