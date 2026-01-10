Return-Path: <linux-fsdevel+bounces-73121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D61D0CEA4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8671030285D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CCB286410;
	Sat, 10 Jan 2026 04:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="f7gmULfr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C6A1E5B95;
	Sat, 10 Jan 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017665; cv=none; b=epO55RM8p/PGZQc8fwlw5ml1Yz5y+5f1ZwtbhMfYQyTpS9I3yez2fTgKa3a4bagMGnq8OwZbiQ1cpXd48e4FqcelikzGCwGnvHAGMok7QnOJIMtyP5ff4SDxEPWH2jBc9uhrnInC+z47BWMAjmZdtNH58xFjJEl3iwL+HTD7uYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017665; c=relaxed/simple;
	bh=1EBxgGRCUwO9vaV3rC9PJKIwxsWCiMe5NYVBWFnMIbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xpi83ge56fLSqk0XmxlcVgNQi765VYgtfcsxIQSC6+N+7lF//yaFzbDGQhBNf1DRVN2FK9nZrp05HpKYlZhtsLeVgt8l9Z+IE0lu007qHm3eglq9ZrF5CItSyu6ovsqLj2Olzu3O1BIKGmTfsqXBy5nkauZhDEpV72O5nyxQguE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=f7gmULfr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=l2LUE689TUBjRJhqWoI4FSTJJqCMuaDthYKZkiYtSho=; b=f7gmULfr1QczamnpQvpHORoB4Y
	cZlsW62CiHl2hZNjtSkrAMYnzAg+3ee4NzKQD0cwRhquSK8F9gIfJ55AnPDVTVn9irnM/Z4tVByIo
	mNFfBFW/wtmlpUsXUkMbOAMkVaYS+Plk/C56B9IAwv6/tGEwb/U8D4KAW4Rmy84/s1u/9SnOxy/Yg
	OW32w/DQT73dGjLsm4GxcsQqJZJEflD08QiKHs0aH4w1/hmnRzseN7XuTSLbTjuX3oWpFMtUSiJhS
	xuXBl4Li9Uu6V4rIOFZ2+yJcSbT9wwml/ntSivby0LL+rtss9AuCL2xRHuodRJy6wp38eRtGM5k4a
	Qj0W5Xpw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veQB9-000000085aJ-2fZG;
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
Subject: [RFC PATCH 12/15] turn task_struct_cachep static-duration
Date: Sat, 10 Jan 2026 04:02:14 +0000
Message-ID: <20260110040217.1927971-13-viro@zeniv.linux.org.uk>
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
 kernel/fork.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index f83ca2f5826f..8f0dfefd82f0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -178,7 +178,8 @@ void __weak arch_release_task_struct(struct task_struct *tsk)
 {
 }
 
-static struct kmem_cache *task_struct_cachep;
+static struct kmem_cache_opaque task_struct_cache;
+#define task_struct_cachep to_kmem_cache(&task_struct_cache)
 
 static inline struct task_struct *alloc_task_struct_node(int node)
 {
@@ -860,7 +861,7 @@ void __init fork_init(void)
 
 	/* create a slab on which task_structs can be allocated */
 	task_struct_whitelist(&useroffset, &usersize);
-	task_struct_cachep = kmem_cache_create_usercopy("task_struct",
+	kmem_cache_setup_usercopy(task_struct_cachep, "task_struct",
 			arch_task_struct_size, align,
 			SLAB_PANIC|SLAB_ACCOUNT,
 			useroffset, usersize, NULL);
-- 
2.47.3


