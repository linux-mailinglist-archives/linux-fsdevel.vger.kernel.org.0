Return-Path: <linux-fsdevel+bounces-73119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1732AD0CE9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 180523072E84
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020EF28506A;
	Sat, 10 Jan 2026 04:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ph0ALkCK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB3257821;
	Sat, 10 Jan 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017665; cv=none; b=fD9+gJRBVyIz9VgYmHxT9Fz2dZG2eGRwbj7VMMbzhuSxjT8rIhLtKFmH3zPb1M4J0QNqTac9V9drucY5Hqlj+71VfzZkKtV4Obeb2a9juAPpCyYRqA2NghB2jXnv4Q3pJmqO14u/hVLZOMpxFmDVcVTLy8ONE9afpH1qxrlAl+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017665; c=relaxed/simple;
	bh=nIq7e+rawtNUm9rzBQBhgYlmP2Kc8+05Ksj6TyvdJPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxBfOxELbjhjpbHo2QJ4XKWdUMsXH3Q12URz2vfbGx4iOD5GXaH6CwWQaZp5gujdOO5z/Q74mjRB8V87Dptd9lG0D3wXrtkcqf/qn5Hda0nwwqdIF0LhUj8uKhsLgO7urnS3Mj3Ghb4D8JqmpQ5vnjEnT2XglzrLzi6CvQeW1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ph0ALkCK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yUfjq/cQTQJkqeTRHOq+fL1zvjNTzJMLDYauRTOdnO4=; b=Ph0ALkCKCYTptUv3Vhh2Nuf1mQ
	UzC/xvzrJz+R3J3N/IkPvbgNT1VUADc/P60p4M/p/Tfq6b9AXo6PGR3Of00BGb+nbV9qVolGywIbS
	4qlo33yOoLuLmpyw2pOMWqa7n9v2oYj6UNpSK8TyJ6IALmXPL1V6S4wGvXIRu3c2PHMAszgXra1Zx
	RDyZOAVhrtqim+rwGW5UZwP8r462a3XK7qSyBsjUm18blsC9tazRwWxQ0q9Xo3rZJ1umbB3Y4ABzA
	Ng6Ot50qgrd/rdusNTPlFmP8ns+Dg58Djbg2pW6P5sCBpbxN/X4RCmKJDjInPW6qJ88rFRRYXE8Rh
	V7y4NNhA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veQB9-000000085Zl-0In6;
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
Subject: [RFC PATCH 07/15] turn dentry_cache static-duration
Date: Sat, 10 Jan 2026 04:02:09 +0000
Message-ID: <20260110040217.1927971-8-viro@zeniv.linux.org.uk>
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

No need to bother with runtime_const() for it anymore...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c                       | 8 ++++----
 include/asm-generic/vmlinux.lds.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index dc2fff4811d1..43d3b4fbedcc 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/slab-static.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -86,8 +87,8 @@ __cacheline_aligned_in_smp DEFINE_SEQLOCK(rename_lock);
 
 EXPORT_SYMBOL(rename_lock);
 
-static struct kmem_cache *__dentry_cache __ro_after_init;
-#define dentry_cache runtime_const_ptr(__dentry_cache)
+static struct kmem_cache_opaque __dentry_cache;
+#define dentry_cache to_kmem_cache(&__dentry_cache)
 
 const struct qstr empty_name = QSTR_INIT("", 0);
 EXPORT_SYMBOL(empty_name);
@@ -3265,10 +3266,9 @@ static void __init dcache_init(void)
 	 * but it is probably not worth it because of the cache nature
 	 * of the dcache.
 	 */
-	__dentry_cache = KMEM_CACHE_USERCOPY(dentry,
+	KMEM_CACHE_SETUP_USERCOPY(dentry_cache, dentry,
 		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_ACCOUNT,
 		d_shortname.string);
-	runtime_const_init(ptr, __dentry_cache);
 
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8ca130af301f..6997f6301260 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -971,8 +971,7 @@
 
 #define RUNTIME_CONST_VARIABLES						\
 		RUNTIME_CONST(shift, d_hash_shift)			\
-		RUNTIME_CONST(ptr, dentry_hashtable)			\
-		RUNTIME_CONST(ptr, __dentry_cache)
+		RUNTIME_CONST(ptr, dentry_hashtable)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
-- 
2.47.3


