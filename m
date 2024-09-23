Return-Path: <linux-fsdevel+bounces-29906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 825F0983927
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 23:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D53F1F2113A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 21:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCD284A5C;
	Mon, 23 Sep 2024 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uglJm802"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9947784A39
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727127546; cv=none; b=ckqwZdGc4gR0Up4Qa2eqcMv3DMYGaOlagimESSe8ug/RH5eN70I6MDxM1yZ6yI60+Yn2U197RjCn5/ka6kXkArAiQk7oMkgT1K5iyNvOviDQ5wC0sqMND5/CO7PN2iiY4plfeAiGr7YwWbLGVgl8x4LtVMsgBT7XM9fNg1jWIxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727127546; c=relaxed/simple;
	bh=CIAmwH5w2lemgVuk+LSWKZ7kjucZ30DR67FASCJrLFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dUmfJukWsnD/KJkKewWVTdKw6kQNsc0gteJhkoqtgKNvpLzppVydPVaxeKKLWcVLzlr3T8UTvUS/di151DadQ9xjtYlDc5ePoM1F0zveYSEV4nG+PkyYZ1JYsK150eDw9cFiu4Q1erZCujXbxUdshmcXaucX7uWWLHipGfT1l/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uglJm802; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727127541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=62KlqbPZ9Ib5OCAMDtbI8BWE4ivcuPsfM3EIKFb3Nzg=;
	b=uglJm802VKhrOMUKbCyDm4eKbiUfgy86PP75GCLuKzvde/YDYNxQ8Ee8caoPCqL4MAPTKj
	HwbXkJOqCy8hBHAWfjaSysqJ5dr1VEMwZ4nrKgQO9HXVzjQtjcKHhcFFox5DFGeZM+vBJ0
	d30AeKp7zVgMNzybZL2hGZhTXM4yHv4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] acl: Annotate struct posix_acl with __counted_by()
Date: Mon, 23 Sep 2024 23:38:05 +0200
Message-ID: <20240923213809.235128-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by compiler attribute to the flexible array member
a_entries to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Use struct_size() to calculate the number of bytes to allocate for new
and cloned acls and remove the local size variables.

Change the posix_acl_alloc() function parameter count from int to
unsigned int to match posix_acl's a_count data type. Add identifier
names to the function definition to silence two checkpatch warnings.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/posix_acl.c            | 13 ++++++-------
 include/linux/posix_acl.h |  4 ++--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 6c66a37522d0..4050942ab52f 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -200,11 +200,11 @@ EXPORT_SYMBOL(posix_acl_init);
  * Allocate a new ACL with the specified number of entries.
  */
 struct posix_acl *
-posix_acl_alloc(int count, gfp_t flags)
+posix_acl_alloc(unsigned int count, gfp_t flags)
 {
-	const size_t size = sizeof(struct posix_acl) +
-	                    count * sizeof(struct posix_acl_entry);
-	struct posix_acl *acl = kmalloc(size, flags);
+	struct posix_acl *acl;
+
+	acl = kmalloc(struct_size(acl, a_entries, count), flags);
 	if (acl)
 		posix_acl_init(acl, count);
 	return acl;
@@ -220,9 +220,8 @@ posix_acl_clone(const struct posix_acl *acl, gfp_t flags)
 	struct posix_acl *clone = NULL;
 
 	if (acl) {
-		int size = sizeof(struct posix_acl) + acl->a_count *
-		           sizeof(struct posix_acl_entry);
-		clone = kmemdup(acl, size, flags);
+		clone = kmemdup(acl, struct_size(acl, a_entries, acl->a_count),
+				flags);
 		if (clone)
 			refcount_set(&clone->a_refcount, 1);
 	}
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 0e65b3d634d9..83b2c5fba1d9 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -30,7 +30,7 @@ struct posix_acl {
 	refcount_t		a_refcount;
 	struct rcu_head		a_rcu;
 	unsigned int		a_count;
-	struct posix_acl_entry	a_entries[];
+	struct posix_acl_entry	a_entries[] __counted_by(a_count);
 };
 
 #define FOREACH_ACL_ENTRY(pa, acl, pe) \
@@ -62,7 +62,7 @@ posix_acl_release(struct posix_acl *acl)
 /* posix_acl.c */
 
 extern void posix_acl_init(struct posix_acl *, int);
-extern struct posix_acl *posix_acl_alloc(int, gfp_t);
+extern struct posix_acl *posix_acl_alloc(unsigned int count, gfp_t flags);
 extern struct posix_acl *posix_acl_from_mode(umode_t, gfp_t);
 extern int posix_acl_equiv_mode(const struct posix_acl *, umode_t *);
 extern int __posix_acl_create(struct posix_acl **, gfp_t, umode_t *);
-- 
2.46.1


