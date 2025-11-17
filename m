Return-Path: <linux-fsdevel+bounces-68658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44506C6341E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CF0C4EE447
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C8332939A;
	Mon, 17 Nov 2025 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb+kywS9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A00D327798;
	Mon, 17 Nov 2025 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372052; cv=none; b=FeA5REk3/QSh8wOm81RCnmSV0zg/F8zVDBMI8xxnKBjDAH4dZd/Khin/E79bAVxBCOMQtH7/Vd5zCfi5qfKYAZvWg06wntbdBcf3OtDvNkYYuf9E8+pegwr3XefNnbkCopzHHn4VMSuBrLIuxJBUDtOx6CYr9t9wn28SBvKb3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372052; c=relaxed/simple;
	bh=C4csfGdfNeHOg7jfqeEjQl6Bulh64hMoaHvrlk5FKAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LYG6CdVPT/RP4lk/ZrtAvFvVljoehet5ty+LwxBQD/s1n77NqSsnV4BayO219wzKJQdD/aNi8hahKLS08J6k4WFUBwJZAaLxGGkz120hYs3b03vSBANbZ1+JYEq7ZGNM5KAszLvdr4V8F1ecjZ+xgsJRmoA68a6ZmwJ9zPqabCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb+kywS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868CFC2BCAF;
	Mon, 17 Nov 2025 09:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372051;
	bh=C4csfGdfNeHOg7jfqeEjQl6Bulh64hMoaHvrlk5FKAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nb+kywS9kC/Mw3fxRzQuBPVyPz/agtZoPsfRlsLkLvDrJ7MMIlwcMlkxtcSl08IgF
	 KhuJCJXRwiAPW6i3HTjCArr8hjC/vEoah/GFJD1fcGhzc/UC4DljWFwVddFWtzUgs4
	 LOHnHTHyWLiM9I+nMHEozGXhlk9seFVx/omBRseb8zFZuPYDK0BJ34fkKnfRookUpG
	 HLJTvqLo8W0wij4Wp2L9zQk9jGKQhPubyF3z6VLYUPdq9WRDS0hYj/aQ4+A7XXYaUe
	 JQHV3gxLV30ev2QDnWYkFJKZdUmlQTf9KJ79bVrukuEqak76q3kJ0EFeHvFmPPkWl6
	 OLfBnqkwpVhyw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:46 +0100
Subject: [PATCH v4 15/42] ovl: port ovl_permission() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-15-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260; i=brauner@kernel.org;
 h=from:subject:message-id; bh=C4csfGdfNeHOg7jfqeEjQl6Bulh64hMoaHvrlk5FKAA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf4ax9oZl3Xpg9S1BbnKN63+fpkv5rxEc2NFKfexk
 PdXkswLO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS78jwv35Lz52cJ91HZ6VN
 5BExUBJI3qyZnBEQekdMye5RFlP8Mob/SV7BD4RFLgZO/7v197mJl6tnXW5RtPAX+TjfN7TthdZ
 sPgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 00e1a47116d4..dca96db19f81 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -295,7 +295,6 @@ int ovl_permission(struct mnt_idmap *idmap,
 	struct inode *upperinode = ovl_inode_upper(inode);
 	struct inode *realinode;
 	struct path realpath;
-	const struct cred *old_cred;
 	int err;
 
 	/* Careful in RCU walk mode */
@@ -313,17 +312,15 @@ int ovl_permission(struct mnt_idmap *idmap,
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(inode->i_sb);
 	if (!upperinode &&
 	    !special_file(realinode->i_mode) && mask & MAY_WRITE) {
 		mask &= ~(MAY_WRITE | MAY_APPEND);
 		/* Make sure mounter can read file for copy up later */
 		mask |= MAY_READ;
 	}
-	err = inode_permission(mnt_idmap(realpath.mnt), realinode, mask);
-	ovl_revert_creds(old_cred);
 
-	return err;
+	with_ovl_creds(inode->i_sb)
+		return inode_permission(mnt_idmap(realpath.mnt), realinode, mask);
 }
 
 static const char *ovl_get_link(struct dentry *dentry,

-- 
2.47.3


