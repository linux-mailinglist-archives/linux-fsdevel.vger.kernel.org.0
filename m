Return-Path: <linux-fsdevel+bounces-66044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA9FC17ADB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD1804E13A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788F12D7386;
	Wed, 29 Oct 2025 00:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avTNAAz8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0BB283124;
	Wed, 29 Oct 2025 00:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699355; cv=none; b=coXaFiAoCm0hL+/r6ch0/sN8T8cCstYdYYKghH35lRsZx65fMzNprXiiG9DcVPVAAgFZEhbCXWFj/XiV2DER9Y0gxANwSbdxz7Ikpx5GLJGMOkn1bm8BXIctaInprl/C5ZIElQ3e0QufDRn9tzbRHCamxJthXM7rSUdwr7dasQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699355; c=relaxed/simple;
	bh=7g+5/4r3I8rw3h4kyv1UhF40zToYoORq9Z2w4GKbh9w=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/FrypKxUmr31LX29hh5M0OBgdrhQJRfdAQ0D6Q915/7Vzqq8Qoe0Srhp8vCTnfrO18eAZKImLnCM1oxo0VfeO0VRIOySvVH24aoXGmnmRZqBxRYgDIMqZj+eq8UUvDSno86n8TSWfHvUdAZhQ2kVo26trBe0C3geowsSmH//KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avTNAAz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A0DC4CEE7;
	Wed, 29 Oct 2025 00:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699355;
	bh=7g+5/4r3I8rw3h4kyv1UhF40zToYoORq9Z2w4GKbh9w=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=avTNAAz8QjLCKoRiUb+iLj0HPktBuO6xl8FCND8wfjdRAp8/wcdMlN+9TOvxJkL7w
	 BHzdzf25htr+QdMuSpaKM1I4C7SDY7SYnIusacOBZt1Offa5wXKNvDNp0G4wEY9Ctl
	 Ict+753XZtpFw18PfXbwDpctzCGG84d54+y5G+2sldyBlpN9ZMdiM7kzuQvla2GyNb
	 L3T+9vLGuRZVX9dVyKWla6KHN93ogBxLyw5NbW1Jj1hd94VbGI01SsHx3wCfz2MotW
	 ObBg5+TCxffwdxAi+ew29xcFrtkY0saNfPPsmwh+4KfCwIfe/NxHm9pHLlcMpvWHrb
	 SgpzHPM1And5Q==
Date: Tue, 28 Oct 2025 17:55:55 -0700
Subject: [PATCH 8/9] fuse: update ctime when updating acls on an iomap inode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169811764.1426244.5194845806307778812.stgit@frogsfrogsfrogs>
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

In iomap mode, the fuse kernel driver is in charge of updating file
attributes, so we need to update ctime after an ACL change.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/acl.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 4ba65ded008649..bdd209b9908c2d 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -111,6 +111,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	const char *name;
 	umode_t mode = inode->i_mode;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	int ret;
 
 	if (fuse_is_bad(inode))
@@ -182,10 +183,24 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			ret = 0;
 	}
 
-	/* If we scheduled a mode update above, push that to userspace now. */
 	if (!ret) {
 		struct iattr attr = { };
 
+		/*
+		 * When we're running in iomap mode, we need to update mode and
+		 * ctime ourselves instead of letting the fuse server figure
+		 * that out.
+		 */
+		if (is_iomap) {
+			attr.ia_valid |= ATTR_CTIME;
+			inode_set_ctime_current(inode);
+			attr.ia_ctime = inode_get_ctime(inode);
+		}
+
+		/*
+		 * If we scheduled a mode update above, push that to userspace
+		 * now.
+		 */
 		if (mode != inode->i_mode) {
 			attr.ia_valid |= ATTR_MODE;
 			attr.ia_mode = mode;


