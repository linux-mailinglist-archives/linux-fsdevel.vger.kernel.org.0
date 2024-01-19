Return-Path: <linux-fsdevel+bounces-8290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D455832670
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 10:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E28286078
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 09:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C992577F;
	Fri, 19 Jan 2024 09:20:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F21324B47;
	Fri, 19 Jan 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705656042; cv=none; b=NlkFjJvZkBT9APqP8EBDL6yjn381RJvWGmwD4PC1C4sXwml43Jyma6wtF5qnegYWQboaJekYn1oVqmH9hyPa7xe8UVmG1cm0++FN/3U1iyJZaAgdgcJk90gw98Li5OUp0w6/v4b/rk0w4Cn0k97yChm5pg5IJGbmavF+cGONpqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705656042; c=relaxed/simple;
	bh=5lhZbcEGn0NQj1sHNsX4+q8+NPZ4dOfrvxPX0NrOHrQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F2q3lQvhpKtXVaA2x6Xd6kZqESlHNYxIQwSL/YC6CMMaH2nEJOcDWcNSWRJ5ANjmqTNHFFoPgwcFl3sIJByxGQlY0cLZ0g6UD8tDtVye4g3YhaS8CmfrzhLrpMJLha+jXiGZ78dp+KIS0/K+ecvpOm0KeVKZR+/2pO4rmNBreeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TGYwM6SnmzWjww;
	Fri, 19 Jan 2024 17:19:31 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E2BE180073;
	Fri, 19 Jan 2024 17:20:31 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 17:20:29 +0800
From: Peng Zhang <zhangpeng362@huawei.com>
To: <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <willy@infradead.org>, <akpm@linux-foundation.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <arjunroy@google.com>, <wangkefeng.wang@huawei.com>
Subject: [RFC PATCH] filemap: add mapping_mapped check in filemap_unaccount_folio()
Date: Fri, 19 Jan 2024 17:20:24 +0800
Message-ID: <20240119092024.193066-1-zhangpeng362@huawei.com>
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
 kwepemm600020.china.huawei.com (7.193.23.147)

From: ZhangPeng <zhangpeng362@huawei.com>

Recently, we discovered a syzkaller issue that triggers
VM_BUG_ON_FOLIO in filemap_unaccount_folio() with CONFIG_DEBUG_VM
enabled, or bad page without CONFIG_DEBUG_VM.

The specific scenarios are as follows:
(1) mmap: Use socket fd to create a TCP VMA.
(2) open(O_CREAT) + fallocate + sendfile: Read the ext4 file and create
the page cache. The mapping of the page cache is ext4 inode->i_mapping.
Send the ext4 page cache to the socket fd through sendfile.
(3) getsockopt TCP_ZEROCOPY_RECEIVE: Receive the ext4 page cache and use
vm_insert_pages() to insert the ext4 page cache to the TCP VMA. In this
case, mapcount changes from - 1 to 0. The page cache mapping is ext4
inode->i_mapping, but the VMA of the page cache is the TCP VMA and
folio->mapping->i_mmap is empty.
(4) open(O_TRUNC): Deletes the ext4 page cache. In this case, the page
cache is still in the xarray tree of mapping->i_pages and these page
cache should also be deleted. However, folio->mapping->i_mmap is empty.
Therefore, truncate_cleanup_folio()->unmap_mapping_folio() can't unmap
i_mmap tree. In filemap_unaccount_folio(), the mapcount of the folio is
0, causing BUG ON.

Syz log that can be used to reproduce the issue:
r3 = socket$inet_tcp(0x2, 0x1, 0x0)
mmap(&(0x7f0000ff9000/0x4000)=nil, 0x4000, 0x0, 0x12, r3, 0x0)
r4 = socket$inet_tcp(0x2, 0x1, 0x0)
bind$inet(r4, &(0x7f0000000000)={0x2, 0x4e24, @multicast1}, 0x10)
connect$inet(r4, &(0x7f00000006c0)={0x2, 0x4e24, @empty}, 0x10)
r5 = openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)='./file0\x00',
0x181e42, 0x0)
fallocate(r5, 0x0, 0x0, 0x85b8)
sendfile(r4, r5, 0x0, 0x8ba0)
getsockopt$inet_tcp_TCP_ZEROCOPY_RECEIVE(r4, 0x6, 0x23,
&(0x7f00000001c0)={&(0x7f0000ffb000/0x3000)=nil, 0x3000, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0}, &(0x7f0000000440)=0x40)
r6 = openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)='./file0\x00',
0x181e42, 0x0)

In the current TCP zerocopy scenario, folio will be released normally .
When the process exits, if the page cache is truncated before the
process exits, BUG ON or Bad page occurs, which does not meet the
expectation.
To fix this issue, the mapping_mapped() check is added to
filemap_unaccount_folio(). In addition, to reduce the impact on
performance, no lock is added when mapping_mapped() is checked.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 mm/filemap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ea49677c6338..6a669eb24816 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -148,10 +148,11 @@ static void page_cache_delete(struct address_space *mapping,
 static void filemap_unaccount_folio(struct address_space *mapping,
 		struct folio *folio)
 {
+	bool mapped = folio_mapped(folio) && mapping_mapped(mapping);
 	long nr;
 
-	VM_BUG_ON_FOLIO(folio_mapped(folio), folio);
-	if (!IS_ENABLED(CONFIG_DEBUG_VM) && unlikely(folio_mapped(folio))) {
+	VM_BUG_ON_FOLIO(mapped, folio);
+	if (!IS_ENABLED(CONFIG_DEBUG_VM) && unlikely(mapped)) {
 		pr_alert("BUG: Bad page cache in process %s  pfn:%05lx\n",
 			 current->comm, folio_pfn(folio));
 		dump_page(&folio->page, "still mapped when deleted");
-- 
2.25.1


