Return-Path: <linux-fsdevel+bounces-11444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B51853D4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B0529017C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F8062146;
	Tue, 13 Feb 2024 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb+F8d6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC5D612FE;
	Tue, 13 Feb 2024 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860262; cv=none; b=ol3klbs8h7D8Ghp2YGu7mzah7RXB1SSLXT65UTcggiUnSrnlR1x7n4SggOzpGP/VXKHK3d9ObOMfsFXz8nKwn7g5UwdEXfaH2A7mpioeFxvQrI9nmY+a7RIbVPGijuYxNPvhe5NCqJlvZeB3uJ/E05NQ89W+IuO3VaYxxFAoc10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860262; c=relaxed/simple;
	bh=Mc8iA4R+RvlCogjizmfuBdLaRuEY94aY5Pgh2nLn8ac=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iArl/XWpnrGqAwYGOoH1E5ISwibdm2IP2szQjsYMEzSjoavM8GGt58NSnzTQrVNgRz+85Z2CzFSkBekd2mGb194Kn7eIvoC0lXOMWulxgQ90/7HVWtotCWyqTtwOqoX56EuO4WMQlZV4Fa3Ym96oZuvvOKV3cRQds025+cfjyeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb+F8d6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1874C433C7;
	Tue, 13 Feb 2024 21:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707860261;
	bh=Mc8iA4R+RvlCogjizmfuBdLaRuEY94aY5Pgh2nLn8ac=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Sb+F8d6imFeQ45gYeWAN4/BMaT90jG5csQsCSot0PbyMT88i+74CZeUtTPvUxmuUP
	 t7FsY5dTvXbuSKoD8EVHTD8zCxRCTcuApqgMgZ21lhygy+SW4ZxqjBJsTye+y9s532
	 2VQycVXwzvuXfNBx7QujixZBOFpQ2k+da0/+MZ5FsbBHbiJ8Y7tUguIoLfpsAiomNz
	 6mFTz8/lMazFoYkJqBJagtYvSSnkHH7k2ksf24CyKW+70KC7jCqYsBGrvQtH3C0jxc
	 G2qH/gokXheDzLuRZiLeolXi1GnEcqa3Y+gPx9AVvs6JbEzWwH8p7cstiyVtjXES19
	 iDaqW0CwmhJ/A==
Subject: [PATCH RFC 3/7] libfs: Add simple_offset_empty()
From: Chuck Lever <cel@kernel.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 hughd@google.com, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 oliver.sang@intel.com, feng.tang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Date: Tue, 13 Feb 2024 16:37:39 -0500
Message-ID: 
 <170786025969.11135.16880338029664682984.stgit@91.116.238.104.host.secureserver.net>
In-Reply-To: 
 <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
References: 
 <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

For simple filesystems that use directory offset mapping, rely
strictly on the directory offset map to tell when a directory has
no children.

After this patch is applied, the emptiness test holds only the RCU
read lock when the directory being tested has no children.

In addition, this adds another layer of confirmation that
simple_offset_add/remove() are working as expected.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c         |   32 ++++++++++++++++++++++++++++++++
 include/linux/fs.h |    1 +
 mm/shmem.c         |    4 ++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index a38af72f4719..3cf773950f93 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -313,6 +313,38 @@ void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
 	offset_set(dentry, 0);
 }
 
+/**
+ * simple_offset_empty - Check if a dentry can be unlinked
+ * @dentry: dentry to be tested
+ *
+ * Returns 0 if @dentry is a non-empty directory; otherwise returns 1.
+ */
+int simple_offset_empty(struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+	struct offset_ctx *octx;
+	struct dentry *child;
+	unsigned long index;
+	int ret = 1;
+
+	if (!inode || !S_ISDIR(inode->i_mode))
+		return ret;
+
+	index = 2;
+	octx = inode->i_op->get_offset_ctx(inode);
+	xa_for_each(&octx->xa, index, child) {
+		spin_lock(&child->d_lock);
+		if (simple_positive(child)) {
+			spin_unlock(&child->d_lock);
+			ret = 0;
+			break;
+		}
+		spin_unlock(&child->d_lock);
+	}
+
+	return ret;
+}
+
 /**
  * simple_offset_rename_exchange - exchange rename with directory offsets
  * @old_dir: parent of dentry being moved
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..03d141809a2c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3267,6 +3267,7 @@ struct offset_ctx {
 void simple_offset_init(struct offset_ctx *octx);
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
+int simple_offset_empty(struct dentry *dentry);
 int simple_offset_rename_exchange(struct inode *old_dir,
 				  struct dentry *old_dentry,
 				  struct inode *new_dir,
diff --git a/mm/shmem.c b/mm/shmem.c
index d7c84ff62186..6fed524343cb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3374,7 +3374,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 
 static int shmem_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	if (!simple_empty(dentry))
+	if (!simple_offset_empty(dentry))
 		return -ENOTEMPTY;
 
 	drop_nlink(d_inode(dentry));
@@ -3431,7 +3431,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 		return simple_offset_rename_exchange(old_dir, old_dentry,
 						     new_dir, new_dentry);
 
-	if (!simple_empty(new_dentry))
+	if (!simple_offset_empty(new_dentry))
 		return -ENOTEMPTY;
 
 	if (flags & RENAME_WHITEOUT) {



