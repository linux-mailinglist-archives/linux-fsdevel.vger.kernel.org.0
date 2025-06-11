Return-Path: <linux-fsdevel+bounces-51254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566A9AD4D98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DEA53A38A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C521024677F;
	Wed, 11 Jun 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QkOvUCHM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B22A23C4F3
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628483; cv=none; b=TMNpI5ukYoVYn5pgd8ma/Lt8Azzx1cNo1pIl2yeX+zXREDCY5MaWJ0wQ/eeDSnPISUpVCl5VOEXPI1yrOhWYuHIQ5gj8IlMkOrcPR7WFEX/s0DKspI31KJACO91vlAwoCT8AYUeGQKzqZ46016rDDVEY44om1FNAwu3vGeJWVp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628483; c=relaxed/simple;
	bh=LYyJa3bbU/PeJ387PCvjRc5+Npyhdv54NF/D6w+X1ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rD/sr3lqhH0ix+d4WFrbTmbGS2QOsZu5ZEh12rLkWV/YduME6DXNNU+BUn5hS+i5Dxno9ni68hvrTszV1A+M6mLCqBdNxWEEePoodttB/eJ3HKvhbJ48yzGnRGz2EXwuY/Su7oarg7pGFsacL2QSeynYImZAREyalr7Pe7IirEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QkOvUCHM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Q1iWHnFO4mTQdr8nQH8k3iNrtZR6emLghsXeVThHFlI=; b=QkOvUCHMubBB3Z0bCVw+gilAgl
	RBg24KCCqxZFklrKBUvSKI0lSad5MDTrgoPKQudNGmEXqYcqX1d79Y2jv6RVBjTdHJRb/xRrN/O4U
	nTVI20ewMjzTcC1eduDM9p6yUDiH8ia33E22FCWhDHw/lvgGuh/JGcefWkDZsG049BwIlwEjGl0ww
	Wtp5wJfQaAk8YjMBjTVE5v7ZRnX11xmflFzJMrD72KMXcIVmy9jsGsva1FBPn70S7i6rQrB2LCKy2
	Ar35+G84bUJZh74sAEIEcrxiSGGvFMSI98NZOlBYTypVAFnAu1gc7qV0gKkM+qosZ10NHb2DNKUmY
	TIY6MAXw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIB-0000000HTy5-4Af9;
	Wed, 11 Jun 2025 07:54:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 15/21] kill simple_dentry_operations
Date: Wed, 11 Jun 2025 08:54:31 +0100
Message-ID: <20250611075437.4166635-15-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
References: <20250611075023.GJ299672@ZenIV>
 <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

No users left and anything that wants it would be better off just
setting DCACHE_DONTCACHE in their ->s_d_flags.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/libfs.c         | 5 -----
 include/linux/fs.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 19cc12651708..3051211998b6 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -62,11 +62,6 @@ int always_delete_dentry(const struct dentry *dentry)
 }
 EXPORT_SYMBOL(always_delete_dentry);
 
-const struct dentry_operations simple_dentry_operations = {
-	.d_delete = always_delete_dentry,
-};
-EXPORT_SYMBOL(simple_dentry_operations);
-
 /*
  * Lookup the data. This is trivial - if the dentry didn't already
  * exist, we know it is negative.  Set d_op to delete negative dentries.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 65548e70e596..d58bbb8262e8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3606,7 +3606,6 @@ extern const struct address_space_operations ram_aops;
 extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
 extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
-extern const struct dentry_operations simple_dentry_operations;
 
 extern struct dentry *simple_lookup(struct inode *, struct dentry *, unsigned int flags);
 extern ssize_t generic_read_dir(struct file *, char __user *, size_t, loff_t *);
-- 
2.39.5


