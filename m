Return-Path: <linux-fsdevel+bounces-60097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80859B413F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012321BA14FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5E02DAFCB;
	Wed,  3 Sep 2025 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Qb9TrAP4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B790C2D94BE
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875351; cv=none; b=TJ1D+wkY6hu97+bJb//MvE+OgY3EyLba4/eqkxICL37/1/0DgidiPyML/2LJJ4XSqLGhdRLUnrpV9EYCAPyaxQ5mBzLeW9jnpRPctfMtuyUfrAJIrnZIDCxF36h0hvw1+dgdluPotkob+plzeHqsX5hZ55SCRTkrsw+hiWTcv2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875351; c=relaxed/simple;
	bh=15oAtulvsFJCo/+IicyGqOD6AG/uB3/D4IlAy2oYUTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwSAEWavzSy7MW7uA1NDXvS1Tfg8sW0/XJq6bm4xPw5HF8Yg/WGl4kOJFKKcbYHsGe4QGLBHzKZ0PcpUS5W9M+eA+CLew0FTqooOL2E89f7eE0ZzL4owjWZNm8EYrcsz1cBdUwRcdxYcNZaHrDegvjLTT6Rg5T9o7ZIA3J7AnI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Qb9TrAP4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=W2lYo70hlURjDYQIzlNkIrWt/LG5M68Hh67/j5mMQkQ=; b=Qb9TrAP4OX+mj9fmWXELXYBm3J
	HrG9XATw0xUVZGp3Pa0xSm+LJJYH+MJ4FcIcitUl6zY2ZJdob1cnzV5BAPPD95FfPjijlqDZe1unZ
	KwJ1dgXQCnzw86l3VFDt3JI28/QzacFkwKSTIdui6tDxr3flj50jJrOuCRd0zI3hNv5YHZPiHp81V
	gvdZixaLvnqNoHXPN0LH5mS1Uu1obnc/8WWrxVWQY8XYHtS/joQSF7e2ScbtX4d37jOAGwQAJa+wt
	oiK/mNLEz1vN0I+UVH5Xs1ueM8zohloy7KCEEXy/l8kM7JBfgfqEgDrwPSEQf81rz2kOI+jOgwhX5
	aNjshIWA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX9-0000000ApFT-3i3F;
	Wed, 03 Sep 2025 04:55:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 53/65] fs/namespace.c: sanitize descriptions for {__,}lookup_mnt()
Date: Wed,  3 Sep 2025 05:55:15 +0100
Message-ID: <20250903045537.2579614-54-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
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
index 0900fd7456a9..a195e25a5d61 100644
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


