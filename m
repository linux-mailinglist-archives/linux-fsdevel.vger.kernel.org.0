Return-Path: <linux-fsdevel+bounces-58474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA916B2E9F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10062170752
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878AB20F07C;
	Thu, 21 Aug 2025 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6U/+MlN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87654315A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738067; cv=none; b=hRW1yufot7MI7pNbSTj7GJ9DVH8KBn/ttSfWMsadD8SFhwxCtBa39xCN39GFyoC/5BdismGYnsyFUHb6mmjqIezJnlyBuUSn3S7i+EfGPEKsUuIRzEzcnc28hGE4iAKu4dzBa69oTsDaumQdQCOHe41uFMn9ztuig3QdTWWI/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738067; c=relaxed/simple;
	bh=z+igCugG5Vx+cJalg7kpO2eeC6mrx8/lNy3aMXBh3PA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpT+YcV262UzRAC1ofYOIzL1PQU4fjZQMnvG9whfM0DTFejxhgmthkRV4JH9T5Gkt8qwXbFBcNARSzBGuEuCtn+/hgoyp1iITYCX6P+pYj2dxf/z9RvZJvDHmEOrrIKV4izdqsP4PFxkwy4qAhJyXUAJr2/cz2PFCV1SKQfxoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6U/+MlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4577C4CEE7;
	Thu, 21 Aug 2025 01:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738066;
	bh=z+igCugG5Vx+cJalg7kpO2eeC6mrx8/lNy3aMXBh3PA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=N6U/+MlNUUmvchBd3G4t8G+kZxAtb0W4wLvRmcRxkNt0M8baA2t/O6SW2Q31F58It
	 BBZdEhGv8Rwzl7Errv16RSsKnr0/eDVwl5l9YWY7dQ2yew4S7I726AILKqfaxIS4DK
	 scY21TElU5GhT3MAfJelx7TgWRuDGZjc8jcDjq710cnkSOOXhWjh/4Wu4lIVvew2Md
	 haZfxTnm5W0gYcBac+EEHZGZVdIcAWFvfIrfqlDDWG30S+HK45rakuc3qELc4EaME6
	 56e5EXDraPUe/J44ZJe4dNt2SeNSy9q218nnym3580JY/sujoCw0nzdcFGC/ZbYL0L
	 nYH4gxNnUlcCA==
Date: Wed, 20 Aug 2025 18:01:06 -0700
Subject: [PATCH 6/6] fuse: always cache ACLs when using iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573710310.18622.14742297929459257374.stgit@frogsfrogsfrogs>
In-Reply-To: <175573710148.18622.12330106999267016022.stgit@frogsfrogsfrogs>
References: <175573710148.18622.12330106999267016022.stgit@frogsfrogsfrogs>
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
 fs/fuse/acl.c     |    8 ++++++--
 fs/fuse/dir.c     |   11 ++++++++---
 fs/fuse/readdir.c |    3 ++-
 3 files changed, 16 insertions(+), 6 deletions(-)


diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index efab333415131c..404c96ad68ea66 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -201,8 +201,12 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * Fuse daemons without FUSE_POSIX_ACL never cached POSIX ACLs
 		 * and didn't invalidate attributes. Retain that behavior.
 		 */
-		forget_all_cached_acls(inode);
-		fuse_invalidate_attr(inode);
+		if (!ret && fuse_has_iomap(inode)) {
+			set_cached_acl(inode, type, acl);
+		} else {
+			forget_all_cached_acls(inode);
+			fuse_invalidate_attr(inode);
+		}
 	}
 
 	return ret;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e8eef46d8e1b52..d317b7965a8259 100644
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
@@ -1468,7 +1469,8 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 		sync = time_before64(fi->i_time, get_jiffies_64());
 
 	if (sync) {
-		forget_all_cached_acls(inode);
+		if (!fuse_inode_has_iomap(inode))
+			forget_all_cached_acls(inode);
 		/* Try statx if a field not covered by regular stat is wanted */
 		if (!fc->no_statx && (request_mask & ~STATX_BASIC_STATS)) {
 			err = fuse_do_statx(idmap, inode, file, stat);
@@ -1645,6 +1647,9 @@ static int fuse_access(struct inode *inode, int mask)
 
 static int fuse_perm_getattr(struct inode *inode, int mask)
 {
+	if (fuse_inode_has_iomap(inode))
+		return 0;
+
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
@@ -2321,7 +2326,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 		 * If filesystem supports acls it may have updated acl xattrs in
 		 * the filesystem, so forget cached acls for the inode.
 		 */
-		if (fc->posix_acl)
+		if (fc->posix_acl && !fuse_inode_has_iomap(inode))
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


