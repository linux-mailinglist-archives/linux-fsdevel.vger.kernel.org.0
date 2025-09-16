Return-Path: <linux-fsdevel+bounces-61547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF81B589C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B69F1692F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CC61A5B92;
	Tue, 16 Sep 2025 00:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtoPHCpT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B2883CC7;
	Tue, 16 Sep 2025 00:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983104; cv=none; b=lOy2jJZ3Mte1dtkcidOJPXbkXez/IcNPPydtl/+YwHbuCT7TXMXWkPmFbwQYbbcCZtrWyAGf5Bw5MGfTo0SiauFe197X7VQa+q9MTIMwDmAVC4Hh0Koyo29CCNxoUyoaI2B9vV0BI+ECBonrzzJB+0zOU9qc1lMyCKC0OmMsFMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983104; c=relaxed/simple;
	bh=3nil/SjhzZUF2NpKlnlRNEiOKIhI/wVSc+GatzRUoGk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQvZ+y5sCRQiGaL6i4FftMRVJifud0jLB329db4+Is46EF8gD7+3UEbtrvAoCXHQu4Oj9ZqljAfDnx7/ghR4Kh1aFF09ls/ZwLEle2C1Wi5LxQgXNZs068FQ0meSDeFQOxnWS7Kl4Qq31paerkfSjIKKhCIOTberQV6014I0HxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtoPHCpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588FCC4CEF1;
	Tue, 16 Sep 2025 00:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983104;
	bh=3nil/SjhzZUF2NpKlnlRNEiOKIhI/wVSc+GatzRUoGk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KtoPHCpTr003dwBzY1+CpzKeZr/thPAkBxsF4Tf/Tnn/RMBlBnvJ3MzxgfzUWuZKT
	 cfN9s2T+FVKIAia3G+qPzuNib6H4obF3ZaP1E7d/h9/UfUe1UQOm6Ei33up6uTabqf
	 SX4PWMGdK0VnxYkp4n/Ehzf1XkI0KBN5pimjaQ42ueo6Zqo9z2ChJBvRrCI4k/g0uZ
	 HWxh/tA6UN+60gtYDzp8TqbojLpm7icNmqJILPC4GcCjhY8JKhcDB5/xwrKvGDVt3K
	 tHEyJrO6Js2VXbp2wEof74IVsFoiYQ39jVH/9vZqk1uKB1aCBx84EDu/oNdTDxQHZ7
	 TNYtcQeOc/dtQ==
Date: Mon, 15 Sep 2025 17:38:23 -0700
Subject: [PATCH 9/9] fuse: always cache ACLs when using iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152630.383971.6290283198961069676.stgit@frogsfrogsfrogs>
In-Reply-To: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
References: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Keep ACLs cached in memory when we're using iomap, so that we don't have
to make a round trip to the fuse server.  This might want to become a
FUSE_ATTR_ flag.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/acl.c     |   12 +++++++++---
 fs/fuse/dir.c     |   11 ++++++++---
 fs/fuse/readdir.c |    3 ++-
 3 files changed, 19 insertions(+), 7 deletions(-)


diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 9b24c53b510405..a9f152ddc1faec 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -210,10 +210,16 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (fc->posix_acl) {
 		/*
 		 * Fuse daemons without FUSE_POSIX_ACL never cached POSIX ACLs
-		 * and didn't invalidate attributes. Retain that behavior.
+		 * and didn't invalidate attributes. Retain that behavior
+		 * except for iomap, where we assume that only the source of
+		 * ACL changes is userspace.
 		 */
-		forget_all_cached_acls(inode);
-		fuse_invalidate_attr(inode);
+		if (!ret && is_iomap) {
+			set_cached_acl(inode, type, acl);
+		} else {
+			forget_all_cached_acls(inode);
+			fuse_invalidate_attr(inode);
+		}
 	}
 
 	return ret;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 58106f49395697..9adaf262bda975 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -261,7 +261,8 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 		    fuse_stale_inode(inode, outarg.generation, &outarg.attr))
 			goto invalid;
 
-		forget_all_cached_acls(inode);
+		if (!fuse_inode_has_iomap(inode))
+			forget_all_cached_acls(inode);
 		fuse_change_attributes(inode, &outarg.attr, NULL,
 				       ATTR_TIMEOUT(&outarg),
 				       attr_version);
@@ -1470,7 +1471,8 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 		sync = time_before64(fi->i_time, get_jiffies_64());
 
 	if (sync) {
-		forget_all_cached_acls(inode);
+		if (!fuse_inode_has_iomap(inode))
+			forget_all_cached_acls(inode);
 		/* Try statx if a field not covered by regular stat is wanted */
 		if (!fc->no_statx && (request_mask & ~STATX_BASIC_STATS)) {
 			err = fuse_do_statx(idmap, inode, file, stat);
@@ -1648,6 +1650,9 @@ static int fuse_access(struct inode *inode, int mask)
 
 static int fuse_perm_getattr(struct inode *inode, int mask)
 {
+	if (fuse_inode_has_iomap(inode))
+		return 0;
+
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
@@ -2325,7 +2330,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 		 * If filesystem supports acls it may have updated acl xattrs in
 		 * the filesystem, so forget cached acls for the inode.
 		 */
-		if (fc->posix_acl)
+		if (fc->posix_acl && !is_iomap)
 			forget_all_cached_acls(inode);
 
 		/* Directory mode changed, may need to revalidate access */
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 45dd932eb03a5e..f7c2a45f23678e 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -224,7 +224,8 @@ static int fuse_direntplus_link(struct file *file,
 		fi->nlookup++;
 		spin_unlock(&fi->lock);
 
-		forget_all_cached_acls(inode);
+		if (!fuse_inode_has_iomap(inode))
+			forget_all_cached_acls(inode);
 		fuse_change_attributes(inode, &o->attr, NULL,
 				       ATTR_TIMEOUT(o),
 				       attr_version);


