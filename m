Return-Path: <linux-fsdevel+bounces-8031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351CB82EA5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 08:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DA5284FBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 07:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC040111AC;
	Tue, 16 Jan 2024 07:53:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA61111A0;
	Tue, 16 Jan 2024 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W-lNVmJ_1705391621;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W-lNVmJ_1705391621)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 15:53:42 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: improve dump_mapping() robustness
Date: Tue, 16 Jan 2024 15:53:35 +0800
Message-Id: <937ab1f87328516821d39be672b6bc18861d9d3e.1705391420.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We met a kernel crash issue when running stress-ng testing, and the
system crashes when printing the dentry name in dump_mapping().

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
pc : dentry_name+0xd8/0x224
lr : pointer+0x22c/0x370
sp : ffff800025f134c0
......
Call trace:
  dentry_name+0xd8/0x224
  pointer+0x22c/0x370
  vsnprintf+0x1ec/0x730
  vscnprintf+0x2c/0x60
  vprintk_store+0x70/0x234
  vprintk_emit+0xe0/0x24c
  vprintk_default+0x3c/0x44
  vprintk_func+0x84/0x2d0
  printk+0x64/0x88
  __dump_page+0x52c/0x530
  dump_page+0x14/0x20
  set_migratetype_isolate+0x110/0x224
  start_isolate_page_range+0xc4/0x20c
  offline_pages+0x124/0x474
  memory_block_offline+0x44/0xf4
  memory_subsys_offline+0x3c/0x70
  device_offline+0xf0/0x120
  ......

The root cause is that, one thread is doing page migration, and we will
use the target page's ->mapping field to save 'anon_vma' pointer between
page unmap and page move, and now the target page is locked and refcount
is 1.

Currently, there is another stress-ng thread performing memory hotplug,
attempting to offline the target page that is being migrated. It discovers
that the refcount of this target page is 1, preventing the offline operation,
thus proceeding to dump the page. However, page_mapping() of the target
page may return an incorrect file mapping to crash the system in dump_mapping(),
since the target page->mapping only saves 'anon_vma' pointer without setting
PAGE_MAPPING_ANON flag.

The page migration issue has been fixed by commit d1adb25df711 ("mm: migrate:
fix getting incorrect page mapping during page migration"). In addition,
Matthew suggested we should also improve dump_mapping()'s robustness to
resilient against the kernel crash [1].

With checking the 'dentry.parent' and 'dentry.d_name.name' used by
dentry_name(), I can see dump_mapping() will output the invalid dentry
instead of crashing the system when this issue is reproduced again.

[12211.189128] page:fffff7de047741c0 refcount:1 mapcount:0 mapping:ffff989117f55ea0 index:0x1 pfn:0x211dd07
[12211.189144] aops:0x0 ino:1 invalid dentry:74786574206e6870
[12211.189148] flags: 0x57ffffc0000001(locked|node=1|zone=2|lastcpupid=0x1fffff)
[12211.189150] page_type: 0xffffffff()
[12211.189153] raw: 0057ffffc0000001 0000000000000000 dead000000000122 ffff989117f55ea0
[12211.189154] raw: 0000000000000001 0000000000000001 00000001ffffffff 0000000000000000
[12211.189155] page dumped because: unmovable page

[1] https://lore.kernel.org/all/ZXxn%2F0oixJxxAnpF@casper.infradead.org/
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 fs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 99d8754a74a3..3093e3b3fd12 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -589,7 +589,8 @@ void dump_mapping(const struct address_space *mapping)
 	}
 
 	dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
-	if (get_kernel_nofault(dentry, dentry_ptr)) {
+	if (get_kernel_nofault(dentry, dentry_ptr) ||
+	    !dentry.d_parent || !dentry.d_name.name) {
 		pr_warn("aops:%ps ino:%lx invalid dentry:%px\n",
 				a_ops, ino, dentry_ptr);
 		return;
-- 
2.39.3


