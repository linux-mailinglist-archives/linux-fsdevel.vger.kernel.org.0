Return-Path: <linux-fsdevel+bounces-15177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080E8887DD2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 18:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EC92816BD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 17:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D2141232;
	Sun, 24 Mar 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aca0wll7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3706A3FB1D;
	Sun, 24 Mar 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299997; cv=none; b=Nj55HtGWkGkEGAlltn/2cswkkNqrm+SATd+U5ifHB6WRWXsJcA5/8tRtyd8DvsChnxxf0FBDG0uldgwoVbmabW4XLoI2UQqt7EiC2zNolQnGcoF14UMczOgOooyNvDMA32cAqCvQCsKY9onL4rytEFfSn8dQovs+MeandysP844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299997; c=relaxed/simple;
	bh=qbSukr1xjfbCNHH5Hna8EvkRe9LoXvD/qru4UF7SU6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udIwKTux2v+PmlEMF+tSpZqIzfj0b6mb3nqjYckqHRCXEJ6Bwb6IRkkbOj1FhCooUJKednXHPO9P3nvf7EQ1wKDhrTMJrErvfozgB8CtZ11UkyVXzi8ZPJ9bCuKPl1Al6R9IweFEwiBhAeWL6xRi+HtpO4sToLufEvysO760nF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aca0wll7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C9EC43394;
	Sun, 24 Mar 2024 17:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299997;
	bh=qbSukr1xjfbCNHH5Hna8EvkRe9LoXvD/qru4UF7SU6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aca0wll7y7chuo72LEwigEfLz1T4ClmYdeXRQs9GBWWeyYgStSS6d0wPE2dqYAjif
	 HDKY9sgyeOgV8oex01pIFR3oon456C1YwJdbtaWVQayMw7LYthaj6eti2PojRdHYYY
	 j4KiJhEsIRW+WeLhn60nDcc7enzwlcOua5D+wyXJB2mH7AEcFZqUJ1CqNrwis6CHWe
	 maeW7ToRBli5vvhdESwBHyXoxl7wekvMHd90XcmGgyiXYjc8INJn4AIud1LL/8OGOM
	 WAI2MZiMM/XPf3/WY/pWdr0ZHjwsZVto8AVQErWVmL7pQxkT5P/VqVTnyhoVnRrfU2
	 KSJ1V+uKQZlSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 09/11] fs: improve dump_mapping() robustness
Date: Sun, 24 Mar 2024 13:06:12 -0400
Message-ID: <20240324170619.545975-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170619.545975-1-sashal@kernel.org>
References: <20240324170619.545975-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.10
Content-Transfer-Encoding: 8bit

From: Baolin Wang <baolin.wang@linux.alibaba.com>

[ Upstream commit 8b3d838139bcd1e552f1899191f734264ce2a1a5 ]

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
Link: https://lore.kernel.org/r/937ab1f87328516821d39be672b6bc18861d9d3e.1705391420.git.baolin.wang@linux.alibaba.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index f238d987dec90..fd50a85f2c730 100644
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
2.43.0


