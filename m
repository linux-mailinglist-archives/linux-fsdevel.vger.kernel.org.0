Return-Path: <linux-fsdevel+bounces-27249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE06195FBA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39A9BB22224
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B80C19B3EE;
	Mon, 26 Aug 2024 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rnKPUDLT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65BF19ADA3;
	Mon, 26 Aug 2024 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707598; cv=none; b=nR7BxBX6YjttUD4biNdK9vtI7LYB+slK2jkZVPgNpWLVzShyOQBDR4gBU0Rz2zuPiVPPHxhCSvnt3CAk5mYY+qG1kKpd3xHAodUmhhAPm/v/lxJj6+Vf2Lh4Ptz91WgNrjFZfkYM9SyOZb5r43STP8/H0OAiMODRD7vAKNaJt2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707598; c=relaxed/simple;
	bh=qvjmJJgQtPjDMtqfjIJxK67KBl7YtXuc3OFHRtr+ipI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAOkMXPAJrA0IhDDI9Rh5clXhW3uhAxyunD9/2YJDWr9U0oGF8ITuD5X6c8e252HkMZHJaMoCVrscNmyVvRZgXZtkdo5PW3HzAlyKPYT+jQMLThyOf+0Zu5okm3zR8SVYDp9FN2xdgn/5kmMS+DH8c1/ClrQqfxfZaNk5Ygid1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rnKPUDLT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=vrbgItIhFVp8VTRThY9P9Y/8Xr6th1Cf9KBboFPHivY=; b=rnKPUDLTNuraOAPRCJswh1PbCb
	dHrd40I5m2qa3JXEupzea/d31NSfO9/veACmGAJpk0DSua1FpoGoy/N2wbs+C2nalavz6TAZjeqfA
	ykJ+kTpHjbcKAyFDnVwjmzAuSfOlpvTrERuKD0pNsNbta78R45KjUjWHPQb1SvWp4QqHDUHYz/hz2
	Dh8qXPlNlkGO+ySzzqDNZAQUCjpr8b10XtH6riT3iLo3+BZuwmfkr4QWdekbCI/oUGAoI9HRD1qsf
	CIUOiI1usitL0os7pglyu9FLTr2IIPwZToshM1HoCHUb/8snc+n5/id6aOuY/mb0D0aIWnUznGfq2
	v9tOMR4w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sihEP-00000008nxy-3pAV;
	Mon, 26 Aug 2024 21:26:33 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	djwong@kernel.org,
	sfr@canb.auug.org.au
Cc: p.raghav@samsung.com,
	dchinner@redhat.com,
	mcgrof@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: [PATCH] iomap: remove set_memor_ro() on zero page
Date: Mon, 26 Aug 2024 14:26:32 -0700
Message-ID: <20240826212632.2098685-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Stephen reported a boot failure on ppc power8 system where
set_memor_ro() on the new zero page failed [0]. Christophe Leroy
further clarifies we can't use this on on linear memory on ppc, and
so instead of special casing this just for PowerPC [2] remove the
call as suggested by Darrick.

[0] https://lore.kernel.org/all/20240826175931.1989f99e@canb.auug.org.au/T/#u
[1] https://lore.kernel.org/all/b0fe75b4-c1bb-47f7-a7c3-2534b31c1780@csgroup.eu/
[2] https://lore.kernel.org/all/ZszrJkFOpiy5rCma@bombadil.infradead.org/

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

This applies to the vfs.blocksize branch on the vfs tree.

 fs/iomap/direct-io.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c02b266bba52..f637aa0706a3 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -11,7 +11,6 @@
 #include <linux/iomap.h>
 #include <linux/backing-dev.h>
 #include <linux/uio.h>
-#include <linux/set_memory.h>
 #include <linux/task_io_accounting_ops.h>
 #include "trace.h"
 
@@ -781,8 +780,6 @@ static int __init iomap_dio_init(void)
 	if (!zero_page)
 		return -ENOMEM;
 
-	set_memory_ro((unsigned long)page_address(zero_page),
-		      1U << IOMAP_ZERO_PAGE_ORDER);
 	return 0;
 }
 fs_initcall(iomap_dio_init);
-- 
2.43.0


