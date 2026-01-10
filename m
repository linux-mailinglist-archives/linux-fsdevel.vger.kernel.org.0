Return-Path: <linux-fsdevel+bounces-73120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC49D0CEA7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEF4E307C4DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D64286D5E;
	Sat, 10 Jan 2026 04:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fZ4Ftxdd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9EB21CC62;
	Sat, 10 Jan 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017665; cv=none; b=GD1woIepOAYEMFsk6h55wESKccdJzXUwQY35fL6Wsqxnpk6W5VODhjWrSxf548G8NbHlcHw+eHEZsP9Dbqfmbx1CMqjH7deaO3S0OQr8KvONfxeCKfHFA3rPXMEYCLvX/K79BTLWAwCd2W24g/a1BEpBKO/ILDGCShOvjJLVuQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017665; c=relaxed/simple;
	bh=/Fxeuk3ccHNpOshNBMvbMMZnp2Y6kg7XC0l52OcvO5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biCEeBQbOS0IK6eR352pvxcHc8814hNn6qEU+K6Sc21gNqhJ34FA3LaP9IDnNgif8wsB8HjOukT55Dr+gkFKn4HaymnAlvZ/3znZvQEL4dua8CqmHMHexIj0AWX6TYWIpfo3U7F7gFjUqmrq7vICNubOIpKz7WMYM2uHkoyyd1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fZ4Ftxdd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CTpW02raswBuv7j7RpZQuDcsunwQZN7ImQgsqrvpB7w=; b=fZ4FtxddXrGcwLpzr5s/FIqFbB
	tMxLMY7PP8xJ+h3pkLDGWDJvBfoOPykJWICv5M7n6CLyrscU/1vvKkICS5fMdQLksiYTpks+lAT/j
	yaf2Nck2v1MEaSrOQ51NyY9XDb4xxQCLA4120symgE1+/jEwVxScShqAC9f52Ssn/Yv35gz0uT5aM
	M2ial3P8740gYYBH5gtpEAtVq+7kXYjvo+u2th+jqNf5tw4iZBYAspR/JZzscHqYDZD8wYhS4d7T1
	TbgyA/Y7GhBQsaDBIzXriLR41PDddd4ajz3E3AFYlJQiaiDAbjN8IqxW+ZvLCB0UcR/sHIicmC8d8
	Ustmky9w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veQB9-000000085Zv-10L5;
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
Subject: [RFC PATCH 08/15] turn files_cachep static-duration
Date: Sat, 10 Jan 2026 04:02:10 +0000
Message-ID: <20260110040217.1927971-9-viro@zeniv.linux.org.uk>
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
 include/linux/fdtable.h | 3 ++-
 kernel/fork.c           | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index c45306a9f007..f2d553f99c58 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -113,6 +113,7 @@ int iterate_fd(struct files_struct *, unsigned,
 extern int close_fd(unsigned int fd);
 extern struct file *file_close_fd(unsigned int fd);
 
-extern struct kmem_cache *files_cachep;
+extern struct kmem_cache_opaque files_cache;
+#define files_cachep to_kmem_cache(&files_cache)
 
 #endif /* __LINUX_FDTABLE_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 23ed80d0d6d0..8c4d9a81ef42 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -472,7 +472,7 @@ static struct kmem_cache_opaque signal_cache;
 struct kmem_cache *sighand_cachep;
 
 /* SLAB cache for files_struct structures (tsk->files) */
-struct kmem_cache *files_cachep;
+struct kmem_cache_opaque files_cache;
 
 /* SLAB cache for fs_struct structures (tsk->fs) */
 struct kmem_cache *fs_cachep;
@@ -3029,7 +3029,7 @@ void __init proc_caches_init(void)
 			sizeof(struct signal_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
-	files_cachep = kmem_cache_create("files_cache",
+	kmem_cache_setup(files_cachep, "files_cache",
 			sizeof(struct files_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
-- 
2.47.3


