Return-Path: <linux-fsdevel+bounces-73109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C611D0CE5C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA49030082F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3F926E6F8;
	Sat, 10 Jan 2026 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CtBErUQT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC524886E;
	Sat, 10 Jan 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017663; cv=none; b=RNotleiCT/UgIJSLqABgEUNzupdrJ87ORK+e+XuPPkWMkskrY6EbX3Q2EqIizSG4cgMORcsK4l5V6+ouPJkJioCS7uPheF893Ve+GDGU6eAwS2t+UVciL3IEjQpbIh8YWgR1QXX+d+Tii9v+rNTTQqiQGS+vlpqnKy369+wFAKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017663; c=relaxed/simple;
	bh=IAZXWAAcaNEVY8U33HnNuOqtDlieHsk/IADRiAay1vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoQzFru/ma7h9SohcqK/+R79O94Dpjwdvm5x8/QcJa8+ymOVwBslpaiAcr9w3oF/Ihll4Eg/ZkcJzV/pqEiRb973zJYTJr7ERDeO+B/NoKp7VTVaAnVjSMgEONWd+NU/v4OJW+Cs6fh4D2vO9QAUAPC1PtygpUQtWqQxTpPkV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CtBErUQT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FrXzQAEQRN298A9NQXfa3gY+X4zzBUHVMqaG/R1D29c=; b=CtBErUQTAXH/3cLPj67RwvcyhW
	ryWQnyPYSRafAowodNlS0AvWy733kBuE9+h7IhJiHjAQ9iU/yzwCBuEe8F9jJckk+7N3MRq5J+Cnc
	6IwEOdL3DsgX8jug7rORJZdd8zNsU4/hbYM8jU8H3QZKyBgAiYLrC9TVmW8ZVYszNLtwTgdYBxV0b
	nVsa1mbnwlBePuWqPJGK4vsLG5AP55DHst4o9End3tQgKWjANgtlkKkqy4fHB9DRjGYfXl5WXsOb+
	tJnj58l3hruE99YoqpFDJxbiiAcPgVIcDL78yinTJkivfey8BoG2BHhvIRtgq7o9XpLtFHn3xyIgt
	J6F7Pp9g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veQB9-000000085b2-38Zo;
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
Subject: [RFC PATCH 13/15] turn fs_cachep static-duration
Date: Sat, 10 Jan 2026 04:02:15 +0000
Message-ID: <20260110040217.1927971-14-viro@zeniv.linux.org.uk>
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
 include/linux/fs_struct.h | 3 ++-
 kernel/fork.c             | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 0070764b790a..e8c9fac5b7b7 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -15,7 +15,8 @@ struct fs_struct {
 	struct path root, pwd;
 } __randomize_layout;
 
-extern struct kmem_cache *fs_cachep;
+extern struct kmem_cache_opaque fs_struct_cache;
+#define fs_cachep to_kmem_cache(&fs_struct_cache)
 
 extern void exit_fs(struct task_struct *);
 extern void set_fs_root(struct fs_struct *, const struct path *);
diff --git a/kernel/fork.c b/kernel/fork.c
index 8f0dfefd82f0..7262abd0d2a4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -476,7 +476,7 @@ struct kmem_cache_opaque sighand_cache;
 struct kmem_cache_opaque files_cache;
 
 /* SLAB cache for fs_struct structures (tsk->fs) */
-struct kmem_cache *fs_cachep;
+struct kmem_cache_opaque fs_struct_cache;
 
 /* SLAB cache for mm_struct structures (tsk->mm) */
 static struct kmem_cache_opaque mm_cache;
@@ -3035,7 +3035,7 @@ void __init proc_caches_init(void)
 			sizeof(struct files_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
-	fs_cachep = kmem_cache_create("fs_cache",
+	kmem_cache_setup(fs_cachep, "fs_cache",
 			sizeof(struct fs_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
-- 
2.47.3


