Return-Path: <linux-fsdevel+bounces-59590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EE0B3AE3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2B6162A32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F953002BB;
	Thu, 28 Aug 2025 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="f6EvHyGh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9AF2F3C13
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422500; cv=none; b=qgEAGTU/GskjAtYZz20aXAV/QIbwzLezbXp2oWQSkL+qYOo9QLoqORTzCRbzih8wINZe8cfYWvfIdPo5XVWVgpe48LTIrN6bND8ZTfPHtLYnvDdxCWY2JQQolyY0xTvwSHvSypy6H7aoXp3aXH+oYf4UgTZK2LiBbH9sQfpP3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422500; c=relaxed/simple;
	bh=Iaj1ZeQ5mHyM/rwm4Rd9Xto/Liqb9MwtJCaMfhRXiPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+sGUvZCDS7GZMGhuFg8e+NzZC76tex+EFyHv9Lt8QROCfGOAWlYYsoZug8DpwpO0X+MXNkKpPS3MbMMyRoeHOIwg1RcSgrR2O4mQqVMnMzxjyjonJ9tp/bIg8p2YV++SnSBVt/4D+jdjLCxvw3ohs1T/uDutThdDCp7u+j3jkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=f6EvHyGh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mBvwKN/LpxenLBpv8lgy8lgfU4jSbYXFQ8NcJ4UiPKE=; b=f6EvHyGhjdPOGcqxOIIzxLYI7c
	aMH7Ug49sYWFnJUgDCHm0Aj7w5bUKSVJnONbfO7IftGGCTfiZEppfxV8JLL6Yorw8n3Bs6Ysj+VOl
	nToAgL9Kq0RN7Sd0wwtIVkmz8uEuOm/NioC/8T2OFR/2GdfRWW1cWMUXwLVHA06H927uCrZD5HKNq
	YftNWfN1T589hs8bQ0kEaUSQ+c9IsFLXufL6scpDjWX5aWferN/wi/ZT4RS+U7TrtOgxg/GorYHnt
	3G5LRTU0RiV686BfxBWipT8r84m9BpjOxdf93wyH2DqHv0LQ8oDPe5xuKczFOYL/vdy7b4RHdDOEE
	asCti+GA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj4-0000000F29t-1qef;
	Thu, 28 Aug 2025 23:08:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 53/63] fs/namespace.c: sanitize descriptions for {__,}lookup_mnt()
Date: Fri, 29 Aug 2025 00:07:56 +0100
Message-ID: <20250828230806.3582485-53-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Comments regarding "shadow mounts" were stale - no such thing anymore.
Document the locking requirements for __lookup_mnt().

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index de9a88f45dc1..2e35f5eb4f81 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -825,24 +825,16 @@ static bool legitimize_mnt(struct vfsmount *bastard, unsigned seq)
 }
 
 /**
- * __lookup_mnt - find first child mount
+ * __lookup_mnt - mount hash lookup
  * @mnt:	parent mount
- * @dentry:	mountpoint
+ * @dentry:	dentry of mountpoint
  *
- * If @mnt has a child mount @c mounted @dentry find and return it.
+ * If @mnt has a child mount @c mounted on @dentry find and return it.
+ * Caller must either hold the spinlock component of @mount_lock or
+ * hold rcu_read_lock(), sample the seqcount component before the call
+ * and recheck it afterwards.
  *
- * Note that the child mount @c need not be unique. There are cases
- * where shadow mounts are created. For example, during mount
- * propagation when a source mount @mnt whose root got overmounted by a
- * mount @o after path lookup but before @namespace_sem could be
- * acquired gets copied and propagated. So @mnt gets copied including
- * @o. When @mnt is propagated to a destination mount @d that already
- * has another mount @n mounted at the same mountpoint then the source
- * mount @mnt will be tucked beneath @n, i.e., @n will be mounted on
- * @mnt and @mnt mounted on @d. Now both @n and @o are mounted at @mnt
- * on @dentry.
- *
- * Return: The first child of @mnt mounted @dentry or NULL.
+ * Return: The child of @mnt mounted on @dentry or %NULL.
  */
 struct mount *__lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
 {
@@ -855,21 +847,12 @@ struct mount *__lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
 	return NULL;
 }
 
-/*
- * lookup_mnt - Return the first child mount mounted at path
- *
- * "First" means first mounted chronologically.  If you create the
- * following mounts:
- *
- * mount /dev/sda1 /mnt
- * mount /dev/sda2 /mnt
- * mount /dev/sda3 /mnt
- *
- * Then lookup_mnt() on the base /mnt dentry in the root mount will
- * return successively the root dentry and vfsmount of /dev/sda1, then
- * /dev/sda2, then /dev/sda3, then NULL.
+/**
+ * lookup_mnt - Return the child mount mounted at given location
+ * @path:	location in the namespace
  *
- * lookup_mnt takes a reference to the found vfsmount.
+ * Acquires and returns a new reference to mount at given location
+ * or %NULL if nothing is mounted there.
  */
 struct vfsmount *lookup_mnt(const struct path *path)
 {
-- 
2.47.2


