Return-Path: <linux-fsdevel+bounces-73123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E37D0CEB3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00CE830ACE0A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E38298CA3;
	Sat, 10 Jan 2026 04:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JuDAyOtt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17D28000F;
	Sat, 10 Jan 2026 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017666; cv=none; b=TAQ/iYu2MCJmqS3EA8KRFn01BJuJzWihjmwd4mCOldhVurwCg9LbTg1LrV6zRRxrmSMrc55fbilX7mritFm5JFousjh2Hyy4W054Coht3OpXSkClSttS6ADFfEu3FTCalP03xBWDkZA91OwRQwqS5tTJyYgS9uTPXsSdGkPSsjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017666; c=relaxed/simple;
	bh=nDDYa9kywW5zHPIcGx5PvS5DCNEit9wcqj0oxAhsAuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPdyvKWkW9BpUzGK+aWetgBqmhCQjytFZ4jRb1JEX7iiOSbk8mRWF7ZcI5rTbJ1UBg6Yma9ywggZ8TgfCOHrYFerjbTkWqD5fxHuNTCJrsuZaPgEgcAoq4rDV9FCsK0auWXeroOSV7yWBXKKOPBzBN+KHFACiivU81e2sW9Rgk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JuDAyOtt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UhChjjCCXpU6xJa0nBtwbeFUsSVl7UkLK9s6DFk/TOI=; b=JuDAyOttjDWAomFXe/G26EAstH
	eziFSZvGfJLCNUkI3ZhzWZrXM+ggkH2+DrfPYk9cP5NDfTLY3GYpQL2FEe4dpHA7Fy9ELsmhRXw2s
	vwduAcN6U0XxZoXkdDG8vpryGRGUmhMk3NQTkwBfB8rPvT53/EyjGrU5HKfbWuRPo2QTAZki5lPXH
	C7L+6BSbR2jJELUCuMh5MKbXAL4WUltdf2XVZIJzFFDNKJUbx2eY326t2QM6LI3tRucSvmOra7cHP
	TUE4Ek2tzoqwLNaq+hP+bZHVdc51V73kqKeGlgawrINN2Z4wb74+9mjzrwy+n85obY3QDmx3fYLp4
	N9YNaYhw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veQB9-000000085a8-1yly;
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
Subject: [RFC PATCH 10/15] turn sighand_cache static-duration
Date: Sat, 10 Jan 2026 04:02:12 +0000
Message-ID: <20260110040217.1927971-11-viro@zeniv.linux.org.uk>
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
 include/linux/signal.h | 3 ++-
 kernel/fork.c          | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index f19816832f05..a0c7fee8b22a 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -323,7 +323,8 @@ static inline void disallow_signal(int sig)
 	kernel_sigaction(sig, SIG_IGN);
 }
 
-extern struct kmem_cache *sighand_cachep;
+extern struct kmem_cache_opaque sighand_cache;
+#define sighand_cachep to_kmem_cache(&sighand_cache)
 
 extern bool unhandled_signal(struct task_struct *tsk, int sig);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 8c4d9a81ef42..d5b7e4d51596 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -469,7 +469,7 @@ static struct kmem_cache_opaque signal_cache;
 #define signal_cachep to_kmem_cache(&signal_cache)
 
 /* SLAB cache for sighand_struct structures (tsk->sighand) */
-struct kmem_cache *sighand_cachep;
+struct kmem_cache_opaque sighand_cache;
 
 /* SLAB cache for files_struct structures (tsk->files) */
 struct kmem_cache_opaque files_cache;
@@ -3021,7 +3021,7 @@ void __init mm_cache_init(void)
 
 void __init proc_caches_init(void)
 {
-	sighand_cachep = kmem_cache_create("sighand_cache",
+	kmem_cache_setup(sighand_cachep, "sighand_cache",
 			sizeof(struct sighand_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
 			SLAB_ACCOUNT, sighand_ctor);
-- 
2.47.3


