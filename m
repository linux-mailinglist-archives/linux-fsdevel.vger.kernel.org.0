Return-Path: <linux-fsdevel+bounces-60440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89598B46A9B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF055C1B19
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0C92D23BC;
	Sat,  6 Sep 2025 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JopBwkoJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6683C28A3EF
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149905; cv=none; b=aOrGt6hZQAMK8S4ocF4l6uXzzuv5AS+qSwnbgUHnnBcQvcojq7yB49yiFOOrMMJOQdAWpNw+ErLYp3bDN+HnW0Gox55+UJoJJtMSDPQyNgosqScY+/yC1SXFC4X5Cz1hQrJ+nY2zL2OpIFlOfCywqe4EbcTUPIdC9hNEWy/jATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149905; c=relaxed/simple;
	bh=5v0xUkIP4DRbii5qFDw+QYilIN2R1YoUmDe4e5YieD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQHvQgzCnwxe6iA9cV6qomYnVZ55KBPhAyNJhal7DqSjv8WAfzOPNnHS0e/Ymuz0PIGnLas3Fo5Sb2tYX9aof9y1g3wBua9ZbRJPojJJKEy3WJnZKUnWXmCmKM8hmwTvAoeoNrRhA96MHzyppqDZQXhHw27L2TebrJnZTUJ6Ogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JopBwkoJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mxwBVaN9F5gE2u4lTfT+lDjZZaElRVxBIBlX07ZgRyc=; b=JopBwkoJwkWPIvUbMprTR2ff7g
	7EFRqtlIMeQhiQ0ZAEpYNI7OnDEL64jdIG1Rg0Wlzge2NWuTot7j88EQ9BJDUHd5vUVXMitFatR7w
	7p8rb9sRmJYj/iA/B6V22u/ie7lPDlbKSUx8K1eLPw1tl1ObASt/h23+HcqpUy0ijs9YNf9bj8joo
	DkFAx1RXCnPWvBXpVIlHQpq2B4uiDWs6wqbaL8ij6BGD7qjSm2mbTLAnCzL0dB59eODhZfKQ5voY6
	h9qmFf67vvnEIbD22MiICb89r8kqsB0313W1F082M0L6vnbB3jKLqBePG4TfvA/OvIiwTLzvurV+3
	CZtn3R4w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxP-00000000Osw-29qU;
	Sat, 06 Sep 2025 09:11:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 11/21] ksmbd_vfs_kern_path_unlock(): constify path argument
Date: Sat,  6 Sep 2025 10:11:27 +0100
Message-ID: <20250906091137.95554-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
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
 fs/smb/server/vfs.c | 2 +-
 fs/smb/server/vfs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 9f45c6ced854..1d9694578bff 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1306,7 +1306,7 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *filepath,
 				     caseless, true);
 }
 
-void ksmbd_vfs_kern_path_unlock(struct path *path)
+void ksmbd_vfs_kern_path_unlock(const struct path *path)
 {
 	/* While lock is still held, ->d_parent is safe */
 	inode_unlock(d_inode(path->dentry->d_parent));
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index d47472f3e30b..35725abf4f92 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -123,7 +123,7 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
 int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 			       unsigned int flags,
 			       struct path *path, bool caseless);
-void ksmbd_vfs_kern_path_unlock(struct path *path);
+void ksmbd_vfs_kern_path_unlock(const struct path *path);
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  const char *name,
 					  unsigned int flags,
-- 
2.47.2


