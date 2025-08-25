Return-Path: <linux-fsdevel+bounces-58950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B877B33594
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51CE1B23CCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1477A285CAD;
	Mon, 25 Aug 2025 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oLUDPI2L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729C267B90
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097046; cv=none; b=CZtEhqweDPgxfbbKDwln5V+llQFgxHGnl5FhaRGl/hplFYZnTk06B5/u273ur8adtb2ROC0gICKr0q9fb9XdXBPEPV260wpPQcvV876J7/vtoNo2GLqvXWx9lCI06zFS5ZqKViixgoBzJgrmkG1sCBjkcxMKOkrmuCT70LQAB1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097046; c=relaxed/simple;
	bh=PnsSPbb5lr8fTf6CHWqeYNvI4WZdn8NCjFqDEIzaYdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBzI8VvaRv0gGR3y8fU/7G8giZamskh3nl5+1S8eANJZjCdG3E3XMoftjpFxnX+cr/Vi50FEY7NMNT22PsiSo/eyERYIHqYrZ3EsnPPQjH873h2Ktx+5VKU8YKpyKvBw4VjQhSxRzwuD4eHKicv9DMHxs9Sil5+EGj7N2oNwQvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oLUDPI2L; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5XRJskihhLRpaj5d+ADekVWOnIqzfFDLhDWIXe0OIPY=; b=oLUDPI2Lr0z7chmyX1pv3ztQiY
	MLcjQpD2+PfPo9ee5s8soj4LrXK3q0QFi1awI1K+uky1vxpn01xX/P0VyOENVf9eLOcjsEhV+9OAw
	BUQN8brIxwPWBxOe9dDhacTsjAvJIod3fE2ToZsSAcm7nhJFpieCi+CiUZ/E1gZ88xDiQ3FWgXeGJ
	LnFnToEyoMJehYnxLbe43tpfF6T99EZuF+KMtyt81Vp8TFdlzf86y/1wH1dn1hdVuT4SbMD8qgGv7
	Nrew/Bqr6zECB7xivVbZMCTaoKzXHAx5EbZ78din+D7ww/OWI5BSvJEyLhHtdzcszWEehFGasFtJX
	z60qVCMQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3q-00000006TGE-0uw3;
	Mon, 25 Aug 2025 04:44:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 52/52] fs/namespace.c: sanitize descriptions for {__,}lookup_mnt()
Date: Mon, 25 Aug 2025 05:43:55 +0100
Message-ID: <20250825044355.1541941-52-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 82cab5459ec7..538313b3b7d9 100644
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


