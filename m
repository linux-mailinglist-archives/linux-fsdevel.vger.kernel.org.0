Return-Path: <linux-fsdevel+bounces-73112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DB4D0CE77
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 215FF30142DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019DF27B33B;
	Sat, 10 Jan 2026 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EWcjovho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CE41F099C;
	Sat, 10 Jan 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017664; cv=none; b=VhurK6BhL9t0rNFHilsi9RkEChIwpGFxgiclpHrxt5l2ZttzpkzelGMX2ftRGfc3xpc3yVCv+fQkg4jg9J7uzltBu5p9ugjwk79+zocu2xDiwiKXDzrYCIoEdRZsZvjn7Q4mOVnnSx5a2G59iq8lVCRzFGl078+fyMGVA6AbZgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017664; c=relaxed/simple;
	bh=5SW9UpEv0nLK1coY4sVVriH3zUD3HiwNzi3GEA3rco4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZhK0PjvyAubEPwBm2p3A+AAxKriH0OvXWxSsrKZMiHYhclcpv4Lh0tGwKf6bwClYkLekTiN/kixo75YnfwGLqSrQikTKan8lhq1Z/tLmzLVGnX6bczDkNfZrf8K/Op2z/SfYcIEJdZK2BDiSNm6jfspSiI3lSDEb91X6+JA9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EWcjovho; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=x+neKtrh0OJd7QapgofbeDN3yfzvNs3usU5t8bvxpKQ=; b=EWcjovhosAsZq5017xsM1Oft92
	V/GTFzIUMfeDDs7239l/el5uh/Cs+WzxyiLaXiMlERUrz/B80QmG3x/pUh1w9B2ygcQoS0S2z8cdl
	Ke8FCpzvFyuooLXf7Rnspy1z4Wb7bRF9XKK7a1DZrVKyOy1x44fWvOk+ME3BhrPhfpevGW7svE4PI
	/M53EWbRUU644eS1Sy7xFkXyIVHeTYjLnYw1TGSGytr3GpgqTqryoQWrTFljJvN16EgDBmQKh6s8M
	+E4X4cx0Y2kwNCxutzyCvR8U/pFxAJiPsHWuL3hlt9U7UhhO7/Edd/w+6drozjnuw3lTY9J84Jwbp
	utsmtJyg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veQB9-000000085Zy-1Thv;
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
Subject: [RFC PATCH 09/15] make filp and bfilp caches static-duration
Date: Sat, 10 Jan 2026 04:02:11 +0000
Message-ID: <20260110040217.1927971-10-viro@zeniv.linux.org.uk>
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

As much as I hate it, the name "filp" is a part of userland ABI at this
point - scripts grepping for it in /proc/slabinfo do exist ;-/

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file_table.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index cd4a3db4659a..18a992b40109 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -27,6 +27,7 @@
 #include <linux/task_work.h>
 #include <linux/swap.h>
 #include <linux/kmemleak.h>
+#include <linux/slab-static.h>
 
 #include <linux/atomic.h>
 
@@ -38,8 +39,10 @@ static struct files_stat_struct files_stat = {
 };
 
 /* SLAB cache for file structures */
-static struct kmem_cache *filp_cachep __ro_after_init;
-static struct kmem_cache *bfilp_cachep __ro_after_init;
+static struct kmem_cache_opaque file_cache;
+static struct kmem_cache_opaque backing_file_cache;
+#define filp_cachep to_kmem_cache(&file_cache)
+#define bfilp_cachep to_kmem_cache(&backing_file_cache)
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
@@ -587,19 +590,20 @@ void fput_close(struct file *file)
 
 void __init files_init(void)
 {
-	struct kmem_cache_args args = {
-		.use_freeptr_offset = true,
-		.freeptr_offset = offsetof(struct file, f_freeptr),
-	};
-
-	filp_cachep = kmem_cache_create("filp", sizeof(struct file), &args,
-				SLAB_HWCACHE_ALIGN | SLAB_PANIC |
-				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU);
+	__KMEM_CACHE_SETUP(filp_cachep, "filp", sizeof(struct file),
+			   SLAB_HWCACHE_ALIGN | SLAB_PANIC |
+			   SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU,
+			   .use_freeptr_offset = true,
+			   .freeptr_offset = offsetof(struct file,
+						      f_freeptr));
+
+	__KMEM_CACHE_SETUP(bfilp_cachep, "bfilp", sizeof(struct backing_file),
+			   SLAB_HWCACHE_ALIGN | SLAB_PANIC |
+			   SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU,
+			   .use_freeptr_offset = true,
+			   .freeptr_offset = offsetof(struct backing_file,
+						      bf_freeptr));
 
-	args.freeptr_offset = offsetof(struct backing_file, bf_freeptr);
-	bfilp_cachep = kmem_cache_create("bfilp", sizeof(struct backing_file),
-				&args, SLAB_HWCACHE_ALIGN | SLAB_PANIC |
-				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU);
 	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
 }
 
-- 
2.47.3


