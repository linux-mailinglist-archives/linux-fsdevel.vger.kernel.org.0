Return-Path: <linux-fsdevel+bounces-73110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A1D0CE6E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E86C303B7B3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA90E279DC9;
	Sat, 10 Jan 2026 04:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UCQfyOdz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AA9264612;
	Sat, 10 Jan 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017664; cv=none; b=T0JEky1itfShpnvX07tJp7xJdkpiGQIApTqVwEFTvlaeQGn1NvyaqwuKc8V6lVeDG/1XWG0myd4FRu706VUSnvZvrQmf/omwAuy47F66fIm8XSX7qBDh1zr29niyDvWKRWdylsXVW7JaAEePto98t0NKeaQlS/r0zIWst0I3HmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017664; c=relaxed/simple;
	bh=R3+dA4EAyRwrgvNP9FBPFL2sJ7/lrZCYooL51j5axck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQozPgniysSSd5e2MBI7oGPzwcoefZUUVG78QC1+Ko4UTRzPQAiorWhzwH8cYmdAJMxcXyhD0KRFJi6jvXzwnWetSyCj9qiy03FqIzvZ8kg/rMnGO2pPKyW9b2zP1KDsVQtuj8Y2ASyYbou0rqD+onQDAferSbb8sMg+V6sMvb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UCQfyOdz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QCWdpDl4N4sktQZ+Ts9iZqQsXsj7d3665CaBWGAPwDA=; b=UCQfyOdzDZjFMBc1nym2fqKTz5
	hEis14KZ+aFKVUiJ55w1Cjubl5boGYR+H5HZkYXoBp7+H7nn0gsaIrIRZuuItBCfabpEFtRGS9NCS
	ImpKNwREPXgDlx4eUtYTNsxxQPZgnDet1kk77OBiNPZkxlZakSP+5VRmE6oX3Ymnd1wrcf5d4wyRP
	dJprEz1xZYAvWD4W3XCZ7t/2QBEutEByZGtcso5I1zhbQg1+vZnJ3glOMXCTpmZ5Gy7DAzYj58Mb7
	WeAv16ORuWZtjaZDHIBVFSaMqScRQJaM3cCP02UwkfY1xAuAmST5nTeyS60QfTLoKZuQR7UwH7iDE
	d5ileZTw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veQB9-000000085bK-3zxy;
	Sat, 10 Jan 2026 04:02:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mguzik@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 15/15] turn ufs_inode_cache static-duration
Date: Sat, 10 Jan 2026 04:02:17 +0000
Message-ID: <20260110040217.1927971-16-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

A modular example I used for testing...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/super.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 6e4585169f94..440229a5b6c9 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -90,6 +90,7 @@
 #include <linux/log2.h>
 #include <linux/seq_file.h>
 #include <linux/iversion.h>
+#include <linux/slab-static.h>
 
 #include "ufs_fs.h"
 #include "ufs.h"
@@ -1354,7 +1355,8 @@ static int ufs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-static struct kmem_cache * ufs_inode_cachep;
+static struct kmem_cache_opaque ufs_inode_cache;
+#define ufs_inode_cachep to_kmem_cache(&ufs_inode_cache)
 
 static struct inode *ufs_alloc_inode(struct super_block *sb)
 {
@@ -1384,16 +1386,13 @@ static void init_once(void *foo)
 
 static int __init init_inodecache(void)
 {
-	ufs_inode_cachep = kmem_cache_create_usercopy("ufs_inode_cache",
+	return kmem_cache_setup_usercopy(ufs_inode_cachep, "ufs_inode_cache",
 				sizeof(struct ufs_inode_info), 0,
 				(SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT),
 				offsetof(struct ufs_inode_info, i_u1.i_symlink),
 				sizeof_field(struct ufs_inode_info,
 					i_u1.i_symlink),
 				init_once);
-	if (ufs_inode_cachep == NULL)
-		return -ENOMEM;
-	return 0;
 }
 
 static void destroy_inodecache(void)
-- 
2.47.3


