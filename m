Return-Path: <linux-fsdevel+bounces-32199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C9F9A24D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 16:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EFD28B062
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 14:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DB91DE3BC;
	Thu, 17 Oct 2024 14:18:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8661E1D47B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174696; cv=none; b=dzNPkzloy586QLqldnjY33vc7371Pogrmo+rx8G8W4J3frw1135rQd9bCTuJxijFSq0oMy0I8A0IHGQGxUUMrGaL3xfEmyn+s8nQANOdMck7nc2FdMbqvryK9OEJ1kKhG6wSmuyGkl5jZZWWi3OzVATq+Nx+78EjIDAZLqjDIPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174696; c=relaxed/simple;
	bh=QYx23lgloKkQTs0Lbw+eJlediI5bOtAeZOs1qIFzjMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geBFC+k2I3YF1Qlb5T+XSWiberCXn8mNcpQyDXypUeazReCwV+a276/iChwELooKbQBTozypwUGPCL5ilEh0PoWbY4WoWu52XUDxEhk+YrykO7ML+uG93dj+lDhqChlKgVFEW4ESLQsazv1L0QxQtOelx25EedR0mHhjcFmc/Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XTqd96wrRz1T8g6;
	Thu, 17 Oct 2024 22:16:13 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id F0ED2140135;
	Thu, 17 Oct 2024 22:18:07 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Oct 2024 22:18:07 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox
	<willy@infradead.org>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand
	<david@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4] tmpfs: don't enable large folios if not supported
Date: Thu, 17 Oct 2024 22:17:42 +0800
Message-ID: <20241017141742.1169404-1-wangkefeng.wang@huawei.com>
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
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100008.china.huawei.com (7.185.36.138)

The tmpfs could support large folio, but there is some configurable
options(mount options and runtime deny/force) to enable/disable large
folio allocation, so there is a performance issue when perform write
without large folio, the issue is similar to commit 4e527d5841e2
("iomap: fault in smaller chunks for non-large folio mappings").

Since 'deny' for emergencies and 'force' for testing, performence issue
should not be a problem in the real production environments, so only
don't call mapping_set_large_folios() in __shmem_get_inode() when
large folio is disabled with mount huge=never option(default policy).

Fixes: 9aac777aaf94 ("filemap: Convert generic_perform_write() to support large folios")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v4:
- only fix mount huge=never since runtime deny/force just for
  emergencies/testing, suggested by Baolin
v3:
- don't enable large folio suppport in __shmem_get_inode() if disabled,
  suggested by Matthew.
v2:
- Don't use IOCB flags

 mm/shmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e933327d8dac..74ef214dc1a7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2827,7 +2827,10 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	cache_no_acl(inode);
 	if (sbinfo->noswap)
 		mapping_set_unevictable(inode->i_mapping);
-	mapping_set_large_folios(inode->i_mapping);
+
+	/* Don't consider 'deny' for emergencies and 'force' for testing */
+	if (sbinfo->huge)
+		mapping_set_large_folios(inode->i_mapping);
 
 	switch (mode & S_IFMT) {
 	default:
-- 
2.27.0


