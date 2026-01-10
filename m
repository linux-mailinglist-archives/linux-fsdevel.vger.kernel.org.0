Return-Path: <linux-fsdevel+bounces-73113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC47ED0CE5F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E75A230131DF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0959327B50C;
	Sat, 10 Jan 2026 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SxSiiOot"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA4523EAA0;
	Sat, 10 Jan 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017664; cv=none; b=r1dDuG30FUT9IyjitDbFmg2yE/CRGcY1C0VSRTBVvEU96jGZB6NwLXEm6/85bMd0dc5uhEs5dnP1xPdPZiDuTA89r5PhkAGl19bxLEj2AwF9QSjkLm4isbrVhgEPoTN7HTCsYVHXuJZQFQbTphZhIH84szQLA0gDJ8JqJ03bWhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017664; c=relaxed/simple;
	bh=O4u0xjxsdKbS8YkQu1uKS+MgZTwPfSlRodR8Tchnb9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrAnpNqtDBdKyCQx/vD+8vrQNlQgh1DabVgyUyEeTrGMCAYbs601q3EmfwuOdqXhOQk5D8oefyIIpgLhjRWqO1nquYrZarEWrwEUfMyjrK68ODT7ckm197FJBgN1GmEpOYtm1PwxeV+7eWoXMDcRdt4Pxk6lUZdy1xkWwn43oZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SxSiiOot; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=W8Fdz/ANVjFzaC5C2LEX2ZRigSyjCLczPh/9G8T8FCI=; b=SxSiiOot8AA10l4sV3FTpcNVzq
	ZE0zHgefZleVJgi6kBLkLofKrHPFazzukPus92tmZxNb5439rkcKmReOtnbF+5Q3lbm97QlLUTupS
	ic7hmMaryQL9yU95IjWGQ2xIYSp+NkXLaZtUR0LjAtizMR+fJQ/p7+4Sn5dTBqhye+EKo3k0824WB
	3hWOEbzWMIaNo3kSKqmDqd71OIHpwQGrz4NH97LPBhdRgKC5UiM30ovJtgU+H/4ivS34HkRlBvtKE
	xfHp0U4XFPRWVzxYbbhOZm6aeA+lmMhcu4x4sNd+RGXv3GAhl9KO6H6WPagEoVPs3BDQxqOwq6MVd
	RcYsnavg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veQB8-000000085ZK-2mo4;
	Sat, 10 Jan 2026 04:02:18 +0000
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
Subject: [RFC PATCH 03/15] make mnt_cache static-duration
Date: Sat, 10 Jan 2026 04:02:05 +0000
Message-ID: <20260110040217.1927971-4-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c58674a20cad..9a9882df463d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -34,6 +34,7 @@
 #include <linux/mnt_idmapping.h>
 #include <linux/pidfs.h>
 #include <linux/nstree.h>
+#include <linux/slab-static.h>
 
 #include "pnode.h"
 #include "internal.h"
@@ -85,7 +86,8 @@ static u64 mnt_id_ctr = MNT_UNIQUE_ID_OFFSET;
 
 static struct hlist_head *mount_hashtable __ro_after_init;
 static struct hlist_head *mountpoint_hashtable __ro_after_init;
-static struct kmem_cache *mnt_cache __ro_after_init;
+static struct kmem_cache_opaque __mnt_cache;
+#define mnt_cache to_kmem_cache(&__mnt_cache)
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
@@ -5997,7 +5999,7 @@ void __init mnt_init(void)
 {
 	int err;
 
-	mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct mount),
+	kmem_cache_setup(mnt_cache, "mnt_cache", sizeof(struct mount),
 			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);
 
 	mount_hashtable = alloc_large_system_hash("Mount-cache",
-- 
2.47.3


