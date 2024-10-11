Return-Path: <linux-fsdevel+bounces-31665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B16999D52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 09:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3181F2214B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 07:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7C8209F59;
	Fri, 11 Oct 2024 06:59:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F77209F46
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629978; cv=none; b=meIUQbo+auNIsmyM4sfj9OK8797HaWrDthF/2gUtCuKPp8VX6Tq3ZYEW5BVNZHXmpQ85e9HeSjoy/hTd+suKNfCxmGv6vvK3lZH/I0m/OTDbJVE9f/yuEV2EovgFyVyROX5dAhnL9wQeTCWlwyCSR/T0UVk+MF3BmG1XIY2Yr2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629978; c=relaxed/simple;
	bh=Ck5Esa2vmgtP4xq3lOrk7s8bQW6iT67oGUmwVy/evdg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubeud0UFLZrpbGRnapPv2/EUofNzfK4eQmKiNvrG4E1PDVd3Tz1NtDI1l11wyi0nLv0C3w/32rC+u1zGEvFFniBI0jRnhiTFtC4/SmH/09u36eIjpepd0DtAeiHVH32pxxCrMU0WQu8RIkkkZf1MayqzibxVmMkXomT8xHggPLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPyBh4TKBz1j9gm;
	Fri, 11 Oct 2024 14:58:20 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 12F8D140361;
	Fri, 11 Oct 2024 14:59:28 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Oct 2024 14:59:27 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox
	<willy@infradead.org>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand
	<david@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3] tmpfs: don't enable large folios if not supported
Date: Fri, 11 Oct 2024 14:59:19 +0800
Message-ID: <20241011065919.2086827-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240920143654.1008756-1-wangkefeng.wang@huawei.com>
References: <20240920143654.1008756-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100008.china.huawei.com (7.185.36.138)

The tmpfs could support large folio, but there is some configurable
options(mount options and runtime deny/force) to enable/disable large
folio allocation, so there is a performance issue when perform write
without large folio, the issue is similar to commit 4e527d5841e2
("iomap: fault in smaller chunks for non-large folio mappings").

Don't call mapping_set_large_folios() in __shmem_get_inode() when
large folio is disabled to fix it.

Fixes: 9aac777aaf94 ("filemap: Convert generic_perform_write() to support large folios")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---

v3:
- don't enable large folio suppport in __shmem_get_inode() if disabled,
  suggested by Matthew.

v2:
- Don't use IOCB flags

 mm/shmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0a2f78c2b919..2b859ac4ddc5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2850,7 +2850,10 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	cache_no_acl(inode);
 	if (sbinfo->noswap)
 		mapping_set_unevictable(inode->i_mapping);
-	mapping_set_large_folios(inode->i_mapping);
+
+	if ((sbinfo->huge && shmem_huge != SHMEM_HUGE_DENY) ||
+	    shmem_huge == SHMEM_HUGE_FORCE)
+		mapping_set_large_folios(inode->i_mapping);
 
 	switch (mode & S_IFMT) {
 	default:
-- 
2.27.0


