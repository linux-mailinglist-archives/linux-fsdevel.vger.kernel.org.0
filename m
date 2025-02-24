Return-Path: <linux-fsdevel+bounces-42528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7A3A42EEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B556C164A68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6EA201001;
	Mon, 24 Feb 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IT2aBw0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0181DB95E
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432057; cv=none; b=LGxgtKJXbSQbSGYMn6XTnu2WXERaPMEft32DbO8Z1Wh315dnvNCkE+ZZFki5Ja04kAy/C+T7N+n7+y78SZVy45iPpK63PJMAxiAtdAlwAPRKrAe9LmBPZOSRyByP684xu3AvyfW5OybI8yCWpOBk7IKSFBbAmy7eIQ34LyJcx/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432057; c=relaxed/simple;
	bh=2/QXtHLU9ehARia1kX8bsRUCiTiJ/mcEOpe5ZUu7OII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inu9jP6gNkqXyT2u1GlzCTIhoR9oOUS9uXiEfbhlGBqdMNKBTWmFtvEGQBUFJ4/Hb37ZlChx8V2DdKeqkEdL+l+2g6MHSJK65iXbXYTDofMkarQO2PJW0+/SdSt+p8cAUpVjrBCjgbh6uhf0A0UI8jN6hg3Qjqr6IGYaSjkP5i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IT2aBw0K; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=m50ym3+MGL2FOcGb7FkQYqb/iGBUcnFCwvaLBN6+K9g=; b=IT2aBw0KxSgaF06lyZ/WlafUS/
	149ogctKTyIYNNfCcoCSrsx2eCkWpny8OGgVHPonrrM5tW2LxGSL7W+svzW4q+wopRs7F62ENps3c
	/yt1UiBShUj40SCMbn0fI7p6NUPaVV2PFbrQR/g+WfJXGr7cTRri5BTVpgNOb/JPFxD8OPLhFuNT8
	gWZou4+Ykqd2Y/Mq7QqDlGsKiRdsUQFLHr6wthj6ZlSuYuYzKDzz6tIzF2eZ2LWkrrkb+CPpupqQb
	DBm2fI1Y8avVYjKHN4fm8ElGVnRngJZrJdIiAouTNCp20Gp2J5RNQU2EBNEgxPfj6NTS8HDLFQ5/g
	rxNXkbog==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsj-00000007Myt-0x5V;
	Mon, 24 Feb 2025 21:20:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 15/21] kill simple_dentry_operations
Date: Mon, 24 Feb 2025 21:20:45 +0000
Message-ID: <20250224212051.1756517-15-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/libfs.c         | 5 -----
 include/linux/fs.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index b15a2148714e..7eebaee9d082 100644
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
index 473a9de5fc8f..bdaf2f85e1ad 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3540,7 +3540,6 @@ extern const struct address_space_operations ram_aops;
 extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
 extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
-extern const struct dentry_operations simple_dentry_operations;
 
 extern struct dentry *simple_lookup(struct inode *, struct dentry *, unsigned int flags);
 extern ssize_t generic_read_dir(struct file *, char __user *, size_t, loff_t *);
-- 
2.39.5


