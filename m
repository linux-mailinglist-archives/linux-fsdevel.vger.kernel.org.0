Return-Path: <linux-fsdevel+bounces-51652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A74FAD9A4E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 08:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3A07ACFC7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 06:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBBB1E411C;
	Sat, 14 Jun 2025 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="r17P1CJ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9811C54AF
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749880954; cv=none; b=pJuYTXKMOvk8y6wVFpg+aoZzVZbPkyPrCbohtljhIWvHgrDkkddAW+rx3hrSlUavXQauKXndGv8n2arGLPwUgNTEegd6Q/tykByMi21gS8NUY28cYUz9y5/QND+wYWoNvITnWNUP9jumeekfdNfDiZJXfjjGlYDfqBGDhIHnpDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749880954; c=relaxed/simple;
	bh=vHUXLbp1sGXuX4+35l347HqozQ/7NCpSK9ITICu1lU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sF1ACFLQaE/7CWCSSb7W9/lEJIpoHFctMyuegkDwpEFoTk1g0vp08qgJ9/0ouryJsxEhczRDAlXrfoFvgkC/vPuiBMdkfe19n7stFFk95vDk8ezvAaoUyp45sFtjVtC7T+p9LIYa726Sm11WliAun98GozZpb7COw2AcOEHohAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=r17P1CJ4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kkTNxDPuumzgKB+NRw9BuBoSnSrifp1YcvxXA8F4v7U=; b=r17P1CJ4IHt+jRJc33ts+A8H4B
	ThT9OITTy5y1mQaUsx2IUg4x9Uj9F9cJCj36gvdWfmvkjUx+5PJhTlyvpuv5/ftzjE7PCVcj1gJW5
	vdL8rXjCJoHY52+DkkHuYSW9g53pCjTWTFf5KiIqrlzHhLohUK4DJhkektNxwIRCRe3GMf2uCx69T
	2S5qWl3UudOEnT4kTW8K6QBkYDqaaWelVFXx0jbeXlPP2I8otdecxlYCzoKguf+z9fXh4Xrldym1k
	E4R4bvvVy8whNgeR0FBBphR9GpFTWnRQkft8fUJcjoMo2QtOn8hAaNNZS/ENKe9AvAov2o/m8yFgt
	HT5Yd9Ew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQJyI-000000022pM-3GvU;
	Sat, 14 Jun 2025 06:02:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: neil@brown.name,
	torvalds@linux-foundation.org,
	brauner@kernel.org
Subject: [PATCH 2/8] add locked_recursive_removal()
Date: Sat, 14 Jun 2025 07:02:24 +0100
Message-ID: <20250614060230.487463-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614060230.487463-1-viro@zeniv.linux.org.uk>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

simple_recursive_removal() assumes that parent is not locked and
locks it when it finally gets to removing the victim itself.
Usually that's what we want, but there are places where the
parent is *already* locked and we need it to stay that way.
In those cases simple_recursive_removal() would, of course,
deadlock, so we have to play racy games with unlocking/relocking
the parent around the call or open-code the entire thing.

A better solution is to provide a variant that expects to
be called with the parent already locked by the caller.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/libfs.c         | 24 ++++++++++++++++++++----
 include/linux/fs.h |  2 ++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 42e226af6095..d0f934f0e541 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -605,8 +605,9 @@ struct dentry *find_next_child(struct dentry *parent, struct dentry *prev)
 }
 EXPORT_SYMBOL(find_next_child);
 
-void simple_recursive_removal(struct dentry *dentry,
-                              void (*callback)(struct dentry *))
+static void __simple_recursive_removal(struct dentry *dentry,
+                              void (*callback)(struct dentry *),
+			      bool locked)
 {
 	struct dentry *this = dget(dentry);
 	while (true) {
@@ -625,7 +626,8 @@ void simple_recursive_removal(struct dentry *dentry,
 			victim = this;
 			this = this->d_parent;
 			inode = this->d_inode;
-			inode_lock(inode);
+			if (!locked || victim != dentry)
+				inode_lock(inode);
 			if (simple_positive(victim)) {
 				d_invalidate(victim);	// avoid lost mounts
 				if (callback)
@@ -638,7 +640,8 @@ void simple_recursive_removal(struct dentry *dentry,
 						      inode_set_ctime_current(inode));
 				if (d_is_dir(dentry))
 					drop_nlink(inode);
-				inode_unlock(inode);
+				if (!locked)
+					inode_unlock(inode);
 				dput(dentry);
 				return;
 			}
@@ -647,8 +650,21 @@ void simple_recursive_removal(struct dentry *dentry,
 		this = child;
 	}
 }
+
+void simple_recursive_removal(struct dentry *dentry,
+                              void (*callback)(struct dentry *))
+{
+	return __simple_recursive_removal(dentry, callback, false);
+}
 EXPORT_SYMBOL(simple_recursive_removal);
 
+void locked_recursive_removal(struct dentry *dentry,
+                              void (*callback)(struct dentry *))
+{
+	return __simple_recursive_removal(dentry, callback, true);
+}
+EXPORT_SYMBOL(locked_recursive_removal);
+
 static const struct super_operations simple_super_operations = {
 	.statfs		= simple_statfs,
 };
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96c7925a6551..4f0c6bf8d652 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3595,6 +3595,8 @@ extern int simple_rename(struct mnt_idmap *, struct inode *,
 			 unsigned int);
 extern void simple_recursive_removal(struct dentry *,
                               void (*callback)(struct dentry *));
+extern void locked_recursive_removal(struct dentry *,
+                              void (*callback)(struct dentry *));
 extern int noop_fsync(struct file *, loff_t, loff_t, int);
 extern ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int simple_empty(struct dentry *);
-- 
2.39.5


