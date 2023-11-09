Return-Path: <linux-fsdevel+bounces-2464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 315CC7E62B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 04:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E251C2086F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 03:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF48E6AB7;
	Thu,  9 Nov 2023 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O+cLqZw7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F6566C
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 03:31:33 +0000 (UTC)
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [IPv6:2001:41d0:203:375::b5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015BE26B3
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 19:31:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699500363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2kk5g3tQ3UUIa7vViud2pPRUP19REPVC10h2UQ9aR4=;
	b=O+cLqZw78XMy/RUaAaJG1q1LYtKy68Wy9IpJueJN0f04+SHP2aLjD7VfxwdBnhr9sA4SZS
	0j10Fv6LvgoIO525gB/h9KeEijjA0eytpeZ6o/jCo5nhzAI+RRiJBSRloSgdFyomMDg3S9
	lSyyzdptnsa7UC71g413H54av3HNmfk=
From: Jeff Xie <jeff.xie@linux.dev>
To: akpm@linux-foundation.org,
	iamjoonsoo.kim@lge.com,
	vbabka@suse.cz,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	willy@infradead.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chensong_2000@189.cn,
	xiehuan09@gmail.com,
	Jeff Xie <jeff.xie@linux.dev>
Subject: [RFC][PATCH 3/4] filemap: implement filemap allocate post callback for page_owner
Date: Thu,  9 Nov 2023 11:25:20 +0800
Message-Id: <20231109032521.392217-4-jeff.xie@linux.dev>
In-Reply-To: <20231109032521.392217-1-jeff.xie@linux.dev>
References: <20231109032521.392217-1-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement the callback function filemap_alloc_post_page_owner for the page_owner
to make the owner of the file page clearer

For the pid 98:
[root@JeffXie ]# cat /proc/98/maps 
00400000-00401000 r--p 00000000 fd:00 1954	/test/mm/a.out
00401000-00499000 r-xp 00001000 fd:00 1954      /test/mm/a.out
00499000-004c2000 r--p 00099000 fd:00 1954      /test/mm/a.out
004c2000-004c6000 r--p 000c1000 fd:00 1954      /test/mm/a.out
004c6000-004c9000 rw-p 000c5000 fd:00 1954      /test/mm/a.out
004c9000-004ce000 rw-p 00000000 00:00 0 
01d97000-01db9000 rw-p 00000000 00:00 0                 [heap]
7f1588fc8000-7f1588fc9000 rw-p 00000000 fd:00 1945      /a.txt
7ffda207a000-7ffda209b000 rw-p 00000000 00:00 0         [stack]
7ffda2152000-7ffda2156000 r--p 00000000 00:00 0         [vvar]
7ffda2156000-7ffda2158000 r-xp 00000000 00:00 0         [vdso]
ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0 [vsyscall]

added: "FILE_PAGE dev 253:0 ino:1954 index:0xc1 mapcount:1 refcount:2 0x4c2000 - 0x4c3000"

Page allocated via order 0, mask 0x152c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE),\
 pid 98, tgid 98 (a.out), ts 28441476044 ns
FILE_PAGE dev 253:0 ino:1954 index:0xc1 mapcount:1 refcount:2 0x4c2000 - 0x4c3000
PFN 0x5be8e type Movable Block 735 type Movable Flags 0x1fffc0000020028(uptodate|lru|mappedtodisk|node=0|zone=1|lastcpupid=0x3fff)
 post_alloc_hook+0x77/0xf0
 get_page_from_freelist+0x58d/0x14e0
 __alloc_pages+0x1b2/0x380
 alloc_pages_mpol+0x97/0x1f0
 folio_alloc+0x18/0x50
 page_cache_ra_unbounded+0x9b/0x1a0
 filemap_fault+0x5f7/0xc20
 __do_fault+0x31/0xc0
 __handle_mm_fault+0x1333/0x1760
 handle_mm_fault+0xbc/0x2f0
 do_user_addr_fault+0x1f8/0x5e0
 exc_page_fault+0x73/0x170
 asm_exc_page_fault+0x26/0x30
Charged to memcg / 

Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
---
 include/linux/pagemap.h |  7 +++++++
 mm/filemap.c            | 44 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bcc1ea44b4e8..900aa136c71f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1514,4 +1514,11 @@ unsigned int i_blocks_per_page(struct inode *inode, struct page *page)
 {
 	return i_blocks_per_folio(inode, page_folio(page));
 }
+#ifndef CONFIG_PAGE_OWNER
+static inline int filemap_alloc_post_page_owner(struct folio *folio, struct task_struct *tsk,
+		void *data, char *kbuf, size_t count)
+{
+	return 0;
+}
+#endif
 #endif /* _LINUX_PAGEMAP_H */
diff --git a/mm/filemap.c b/mm/filemap.c
index 9710f43a89ac..0a346443309a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -45,6 +45,7 @@
 #include <linux/migrate.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/splice.h>
+#include <linux/page_owner.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -838,6 +839,48 @@ void replace_page_cache_folio(struct folio *old, struct folio *new)
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_folio);
 
+#ifdef CONFIG_PAGE_OWNER
+static int filemap_alloc_post_page_owner(struct folio *folio, struct task_struct *tsk,
+			void *data, char *kbuf, size_t count)
+{
+	int ret;
+	int mapcount;
+	dev_t s_dev;
+	struct inode *inode;
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+	unsigned long virtual_start = 0x0;
+	unsigned long virtual_end = 0x0;
+	struct address_space *mapping = data;
+
+	mapcount = folio_mapcount(folio);
+	if (mapcount && tsk && tsk->mm) {
+		mm = tsk->mm;
+		VMA_ITERATOR(vmi, mm, 0);
+		mmap_read_lock(mm);
+		for_each_vma(vmi, vma) {
+			if (page_mapped_in_vma(&folio->page, vma)) {
+				virtual_start = vma_address(&folio->page, vma);
+				virtual_end = virtual_start + folio_nr_pages(folio) * PAGE_SIZE;
+				break;
+			}
+		}
+		mmap_read_unlock(mm);
+	}
+
+	inode = mapping->host;
+	if (mapping->host->i_sb)
+		s_dev = mapping->host->i_sb->s_dev;
+	else
+		s_dev = mapping->host->i_rdev;
+	ret = scnprintf(kbuf, count, "FILE_PAGE dev %d:%d ino:%lu index:0x%lx mapcount:%d refcount:%d 0x%lx - 0x%lx\n",
+		MAJOR(s_dev), MINOR(s_dev), inode->i_ino, folio->index, mapcount, folio_ref_count(folio),
+		virtual_start, virtual_end);
+
+	return ret;
+}
+#endif
+
 noinline int __filemap_add_folio(struct address_space *mapping,
 		struct folio *folio, pgoff_t index, gfp_t gfp, void **shadowp)
 {
@@ -915,6 +958,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	if (xas_error(&xas))
 		goto error;
 
+	set_folio_alloc_post_page_owner(folio, filemap_alloc_post_page_owner, mapping);
 	trace_mm_filemap_add_to_page_cache(folio);
 	return 0;
 error:
-- 
2.34.1


