Return-Path: <linux-fsdevel+bounces-66045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B25C17AE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C81174F6CF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6E7283124;
	Wed, 29 Oct 2025 00:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URmmCKOB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F212D6E52;
	Wed, 29 Oct 2025 00:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699371; cv=none; b=iljVZGUnf0IDlDWGDN0I4mvOL/C9sX41IrzreIoDUs/o6GZFnbOxOWM5tttmM/b2zGtVwau8iiZfdq5xv9Hg/ZtSULR1Ebg4giuvPAhqWKrMvYyGkLEEZ+7PBBWNqfwGawpO9/3PWIjPptJ+9VL1nq3o00n8e12NlUxi5252yUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699371; c=relaxed/simple;
	bh=EwlQqZwMF8og8fyrn3UebAlAr8Dma2gtQGsGHHMAh3A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADVTNYMAgrQ8HJ2Q9t1H/9dRTYYQZD81XSVm+dDVaZuJOv5HRlLxwo1rNjKFYNASVmn2Sq87tKgL7gc3G++Hn7BQzaTfIEWfQ56hucLbRN9FetrU6q9YeWJD+ZJuqBrWkeWxhIcRnMzxJrccVH58gpARA3raRyObo1qgGF0Mw1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URmmCKOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40368C4CEE7;
	Wed, 29 Oct 2025 00:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699371;
	bh=EwlQqZwMF8og8fyrn3UebAlAr8Dma2gtQGsGHHMAh3A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=URmmCKOB/dEBtt5/FcP1tK7Qc4m106KrK6vdPGLjMc8F6YLfJ119kpOy8d06t2RGe
	 /pnNYzsZ3Shju0NshMDVgBX1L0Iso7hGtFL6rIypCXmk9NK1FP7WenmfLVvrHqFWZB
	 ljKnxH/LiOOBRBptMkea+WcXCfS2wgRD9TWX1mYTgi5UBjkMlM78OumcnklQpyg8nk
	 sK9JaHfAZKixtayIqeZcIWgg+G8YatVacGY7xg+Obhzzh1tRdDj1K8Bi37Mo2OJYVc
	 W9I/5kyh0M3P9xJ6n3bXzKTbXV8vN1cUDmTYScvPBJamIcqU/YCweoBUSk91d2q03F
	 cDPtjM7LdiNkA==
Date: Tue, 28 Oct 2025 17:56:10 -0700
Subject: [PATCH 9/9] fuse: always cache ACLs when using iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169811785.1426244.13970477450791549525.stgit@frogsfrogsfrogs>
In-Reply-To: <176169811533.1426244.7175103913810588669.stgit@frogsfrogsfrogs>
References: <176169811533.1426244.7175103913810588669.stgit@frogsfrogsfrogs>
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
index bdd209b9908c2d..633a73be710b2f 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -213,10 +213,16 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
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
index 4fc66ff0231089..55a46612e3677c 100644
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
@@ -1463,7 +1464,8 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 		sync = time_before64(fi->i_time, get_jiffies_64());
 
 	if (sync) {
-		forget_all_cached_acls(inode);
+		if (!fuse_inode_has_iomap(inode))
+			forget_all_cached_acls(inode);
 		/* Try statx if a field not covered by regular stat is wanted */
 		if (!fc->no_statx && (request_mask & ~STATX_BASIC_STATS)) {
 			err = fuse_do_statx(idmap, inode, file, stat);
@@ -1641,6 +1643,9 @@ static int fuse_access(struct inode *inode, int mask)
 
 static int fuse_perm_getattr(struct inode *inode, int mask)
 {
+	if (fuse_inode_has_iomap(inode))
+		return 0;
+
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
@@ -2318,7 +2323,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
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


