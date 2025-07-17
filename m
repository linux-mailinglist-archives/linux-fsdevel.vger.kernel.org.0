Return-Path: <linux-fsdevel+bounces-55345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E7B09817
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6605A2CD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7144E23ABB7;
	Thu, 17 Jul 2025 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/cVWO2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D612523643E
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795265; cv=none; b=Ffz78PgYEfG9YfNyO6TcAR3tDtiewmwrMN5o8LJfcvFzWlSSOgJYBlYWevDsEHdLok6kkpH8biqPXHgssufZwoRfxiuhF4etQP9U/2ts4FN1uh+TMDYN0wE0yHSga/W0Tq0PoZmizfxFMPxYz0khkug2CDaDR28GKFzUW23PhrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795265; c=relaxed/simple;
	bh=y5v6mKEtGZv4G1ZcHcfb95OfCs+s0Vbfi+X6MdKrxX4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQ+1Uesp1Fx+6FTOGGaXyvmatmwTgNDwwcyIHiHRK7jfUJWNa5vJjyq+tt4RFRjHYF7+eIVmPTGFG/GDpz+T3L0Y+WYbEiJvDbSWAOvdbP/ZntqySkMNAs+AsJZz96TKAAGrRltqfWUzwCLpjwiGq9AG1jUxFimzVxYNGZNXuMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/cVWO2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610E4C4CEE3;
	Thu, 17 Jul 2025 23:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795265;
	bh=y5v6mKEtGZv4G1ZcHcfb95OfCs+s0Vbfi+X6MdKrxX4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C/cVWO2VccWxsMxGslWokaGGJY6hLmc9HyfiqyZaCaZmBMWztOyteMS7yNFuNXAu3
	 HI0DeIvs9TCnUlmGLk3BSG+/08TdsedjnEXS82SomD3oBVDWpbi3F5DufQxfAzm9pb
	 8jbBgju6vBFnAjQbinYtvbz612y3Jwg5PXYm1h5rGFFM8FSgEFLKpXmRTNG7VGtMsW
	 9jMuw4POWg/IoInoQsCtAHV68NWEXwgoqfMgEN+OOM8d0MX8Ni56GyHGXezax9YJ6n
	 4uzFrszq834N5+0cCS0mvn+I9Tg+7d/IJ3BVMZtUsqsV6ymyFF3D/2/8CskBqjJTfj
	 5QbuG+4GGhRQQ==
Date: Thu, 17 Jul 2025 16:34:24 -0700
Subject: [PATCH 7/7] fuse: update ctime when updating acls on an iomap inode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450932.713693.1905268585773224481.stgit@frogsfrogsfrogs>
In-Reply-To: <175279450745.713693.16690872492281672288.stgit@frogsfrogsfrogs>
References: <175279450745.713693.16690872492281672288.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In iomap mode, the fuse kernel driver is in charge of updating file
attributes, so we need to update ctime after an ACL change.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/acl.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)


diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 26776e7a0b88fa..578b139a1d3380 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -99,6 +99,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	const char *name;
 	umode_t mode = inode->i_mode;
+	bool is_iomap = fuse_has_iomap(inode);
 	int ret;
 
 	if (fuse_is_bad(inode))
@@ -121,8 +122,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	 * ACL implementation was merged, so that's why it's gated on regular
 	 * iomap.  XXX: This should be some sort of separate flag?
 	 */
-	if (acl && type == ACL_TYPE_ACCESS &&
-	    fuse_has_iomap(inode) && fc->posix_acl) {
+	if (acl && type == ACL_TYPE_ACCESS && is_iomap && fc->posix_acl) {
 		ret = posix_acl_update_mode(idmap, inode, &mode, &acl);
 		if (ret)
 			return ret;
@@ -172,13 +172,22 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			ret = 0;
 	}
 
-	/* If we scheduled a mode update above, push that to userspace now. */
-	if (!ret && mode != inode->i_mode) {
+	/*
+	 * When we're running in iomap mode, we need to update mode and ctime
+	 * ourselves instead of letting the fuse server figure that out.
+	 */
+	if (!ret && is_iomap) {
 		struct iattr attr = {
-			.ia_valid = ATTR_MODE,
-			.ia_mode = mode,
+			.ia_valid = ATTR_CTIME,
 		};
 
+		inode_set_ctime_current(inode);
+		attr.ia_ctime = inode_get_ctime(inode);
+		if (mode != inode->i_mode) {
+			attr.ia_valid |= ATTR_MODE;
+			attr.ia_mode = mode;
+		}
+
 		ret = fuse_do_setattr(idmap, dentry, &attr, NULL);
 	}
 


