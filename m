Return-Path: <linux-fsdevel+bounces-66042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9535DC17ACC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF3F3AEADA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160F32D73BC;
	Wed, 29 Oct 2025 00:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAmoLZsL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA02D0C84;
	Wed, 29 Oct 2025 00:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699323; cv=none; b=FD5waEUGfaiZK4WM0MAfftqXXq3FvTdLEGlQFAbBHpv94yE3o8R8MOLMUmNZQmrjvNSLMS9h/ZWQ3Bb69OPJhO5DJHLf/Mc5KQy1XYRlCZKGiBI8rZRKGO7R5al2fW/SPGhUuZSaS+1PthQk+P3zDOGxs6RDFlcQ2Xt3plKZek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699323; c=relaxed/simple;
	bh=qdQdi2Mn5V6iK1+dtENwOXo5QvJaXWwcTVJu2RlbUyQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/mnTiHKH185vFutJLin8O7IZd2Ug93zBe/vHZ2jiK297M6seu45/6C588b9xkKSflsk31jMwZVsSJ+o85ixIzr65rVNFAbSLY6FbYqmKcRq4jfx5krtIDYonwBtKY+Fec6cWh8DYnLAdu3QA27uZ6HvdfSBo2dKap5iiD1fVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAmoLZsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E86C4CEE7;
	Wed, 29 Oct 2025 00:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699323;
	bh=qdQdi2Mn5V6iK1+dtENwOXo5QvJaXWwcTVJu2RlbUyQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bAmoLZsLvCgoA3FwAFnrXhutY1lQqXstB+Qf883H/i6QeVaPdQhtw+8tew0d4doEf
	 OIjE95nXlQ9MKoolXxIF21ba+lxvIcSh7HGX1iSMA5qii0xrPLUYiL9UenxldxiCLR
	 g9R/aUOtzOqakgEXUIGcTICvgJx45H4zBsLnlYLPrIvWFnDokfmZNcBbyy6NwH+LKi
	 QzDmMA/V/qd+li05xsqDqUrihXA9eu/crqsDO9Us6oGaPgKJKewm8uXUcEoh/I7IZg
	 2LZc7atSd7A9Xn1VNBTzgp6COOihCqg8udV8QrYlCr0CAAM1wSQjgVfidOAx6bJAkb
	 huEa8ZO8sCBDg==
Date: Tue, 28 Oct 2025 17:55:22 -0700
Subject: [PATCH 6/9] fuse: let the kernel handle KILL_SUID/KILL_SGID for iomap
 filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169811721.1426244.10570675160710429432.stgit@frogsfrogsfrogs>
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

Let the kernel handle killing the suid/sgid bits because the
write/falloc/truncate/chown code already does this, and we don't have to
worry about external modifications that are only visible to the fuse
server (i.e. we're not a cluster fs).

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 135c601230e547..9435d6b8d14ea4 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2261,6 +2261,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	struct inode *inode = d_inode(entry);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct file *file = (attr->ia_valid & ATTR_FILE) ? attr->ia_file : NULL;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	int ret;
 
 	if (fuse_is_bad(inode))
@@ -2269,15 +2270,19 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	if (!fuse_allow_current_process(get_fuse_conn(inode)))
 		return -EACCES;
 
-	if (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID)) {
+	if (!is_iomap &&
+	    (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))) {
 		attr->ia_valid &= ~(ATTR_KILL_SUID | ATTR_KILL_SGID |
 				    ATTR_MODE);
 
 		/*
 		 * The only sane way to reliably kill suid/sgid is to do it in
-		 * the userspace filesystem
+		 * the userspace filesystem if this isn't an iomap file.  For
+		 * iomap filesystems we let the kernel kill the setuid/setgid
+		 * bits.
 		 *
-		 * This should be done on write(), truncate() and chown().
+		 * This should be done on write(), truncate(), chown(), and
+		 * fallocate().
 		 */
 		if (!fc->handle_killpriv && !fc->handle_killpriv_v2) {
 			/*


