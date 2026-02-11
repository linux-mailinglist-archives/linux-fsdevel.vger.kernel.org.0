Return-Path: <linux-fsdevel+bounces-76914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCyGDeHRi2mgbgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 01:48:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA231205E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 01:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3755130557E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 00:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2631F5821;
	Wed, 11 Feb 2026 00:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG/ChHGK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2401FB1;
	Wed, 11 Feb 2026 00:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770770901; cv=none; b=p5cBPsGv2AgqxVNsPMkX0+NL/mY2y5HtULqRKtnKyjAwoKaOLtd+dWsh9ZOiGnFe8cp1FwIMe3NRc4+q3Cw+fdQFJlpwJcux4FKhXocJTNUNdIvungfA0GJkOd3iEzaViIuKyhnVJFqKB/PCIZDdMMv2mpnjMcWAUfCM828fU2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770770901; c=relaxed/simple;
	bh=iCffL0xzUPUG3BJfbMxK8tI4lDRi9xgWQfS/pTIlq1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SYR6UV3jLB3fHMYrWH4IlhpeGyk6fP0lH0gntmCj3MhbsqJ1203ugGf+V/QKlG+Gvp1Fu0N0RBEtu41lOiX4lAjioI78tlYLyh3zBWnRSDS5wAff6CY5OU9ep6ndHRN3AafYiHlAl5YUFN4dcQvOxOsz5foEdu1OIvzzAON/sFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG/ChHGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86EDC19423;
	Wed, 11 Feb 2026 00:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770770900;
	bh=iCffL0xzUPUG3BJfbMxK8tI4lDRi9xgWQfS/pTIlq1g=;
	h=From:To:Cc:Subject:Date:From;
	b=HG/ChHGKKmMIKjJM7JRwB/IQoS0qJwmGjRtfoBuBf7cI5azTlKq4Fg5V61GAB9AQJ
	 rOllaK0kLA9e8UXHBLjmvpE31q3p4SAmeHC/rz6ZqHmpxxAOVHoSN1F/HtBvzQcEuC
	 FjVPlUITGO0EU8IRgrNPYrLI8YHxf3Nn2ut6G7bxthCAnuLFXWCrRrSu0tu7aWNN7r
	 MYM0k7ZXSa75MaS+3tx2zKLIG9NZJ2euvYRt5D92RZG8JDUaU1ph4Hls/eW6qNFNu8
	 gUnDTUfegSW/BLXmVBLyxAb0n5JtE+8K1qIzkQWJ4zE1m2O5b8RChf1/ooPM5tuOva
	 D7j34eIuCDm0A==
From: Kees Cook <kees@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <kees@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] fs: Keep long filenames in isolated slab buckets
Date: Tue, 10 Feb 2026 16:48:15 -0800
Message-Id: <20260211004811.work.981-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3518; i=kees@kernel.org; h=from:subject:message-id; bh=iCffL0xzUPUG3BJfbMxK8tI4lDRi9xgWQfS/pTIlq1g=; b=owGbwMvMwCVmps19z/KJym7G02pJDJndF88zuvi51p0ynLXriX6b6MVK4aBt7zg0K1/8nBG46 M427zrujlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIlsKmL4Xy79K37vIfH3+j+f ZJ03lj8v3TXT6eXNJdf8tGbfyX7VuY+RYVfYck43zg9Grz8vSjLPs7m4c4/r0eqdr/e+s+cxmT9 RihsA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76914-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FA231205E3
X-Rspamd-Action: no action

A building block of Use-After-Free heap memory corruption attacks is
using userspace controllable kernel allocations to fill specifically sized
kmalloc regions with specific contents. The most powerful of these kinds
of primitives is arbitrarily controllable contents with arbitrary size.
Keeping these kinds of allocations out of the general kmalloc buckets is
needed to harden the kernel against such manipulations, so this is why
these sorts of "copy data from userspace into kernel heap" situations are
expected to use things like memdup_user(), which keeps the allocations
in their own set of slab buckets. However, using memdup_user() is not
always appropriate, so in those cases, kmem_buckets can used directly.

Filenames used to be isolated in their own (fixed size) slab cache so
they would not end up in the general kmalloc buckets (which made them
unusable for the heap grooming method described above). After commit
8c888b31903c ("struct filename: saner handling of long names"), filenames
were being copied into arbitrarily sized kmalloc regions in the general
kmalloc buckets. Instead, like memdup_user(), use a dedicated set of
kmem buckets for long filenames so we do not introduce a new way for
attackers to place arbitrary contents into the general kmalloc buckets.

Fixes: 8c888b31903c ("struct filename: saner handling of long names")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Also, from the same commit, is the loss of SLAB_HWCACHE_ALIGN|SLAB_PANIC
for filename allocations relavant at all? It could be added back for
these buckets if desired, but I left it default in this patch.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: <linux-fsdevel@vger.kernel.org>
---
 fs/namei.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 8e7792de0000..a901733380cd 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -128,6 +128,8 @@
 /* SLAB cache for struct filename instances */
 static struct kmem_cache *__names_cache __ro_after_init;
 #define names_cache	runtime_const_ptr(__names_cache)
+/* SLAB buckets for long names */
+static kmem_buckets *names_buckets __ro_after_init;
 
 void __init filename_init(void)
 {
@@ -135,6 +137,8 @@ void __init filename_init(void)
 			 SLAB_HWCACHE_ALIGN|SLAB_PANIC, offsetof(struct filename, iname),
 			 EMBEDDED_NAME_MAX, NULL);
 	runtime_const_init(ptr, __names_cache);
+
+	names_buckets = kmem_buckets_create("names_bucket", 0, 0, PATH_MAX, NULL);
 }
 
 static inline struct filename *alloc_filename(void)
@@ -156,7 +160,7 @@ static inline void initname(struct filename *name)
 static int getname_long(struct filename *name, const char __user *filename)
 {
 	int len;
-	char *p __free(kfree) = kmalloc(PATH_MAX, GFP_KERNEL);
+	char *p __free(kfree) = kmem_buckets_alloc(names_buckets, PATH_MAX, GFP_KERNEL);
 	if (unlikely(!p))
 		return -ENOMEM;
 
@@ -264,14 +268,14 @@ static struct filename *do_getname_kernel(const char *filename, bool incomplete)
 
 	if (len <= EMBEDDED_NAME_MAX) {
 		p = (char *)result->iname;
-		memcpy(p, filename, len);
 	} else {
-		p = kmemdup(filename, len, GFP_KERNEL);
+		p = kmem_buckets_alloc(names_buckets, len, GFP_KERNEL);
 		if (unlikely(!p)) {
 			free_filename(result);
 			return ERR_PTR(-ENOMEM);
 		}
 	}
+	memcpy(p, filename, len);
 	result->name = p;
 	initname(result);
 	if (likely(!incomplete))
-- 
2.34.1


