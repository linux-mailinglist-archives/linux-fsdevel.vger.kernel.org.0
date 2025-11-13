Return-Path: <linux-fsdevel+bounces-68398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEA6C5A392
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BED984F748F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C79329E5C;
	Thu, 13 Nov 2025 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7kxPAqz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912A329E55;
	Thu, 13 Nov 2025 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069607; cv=none; b=pbcj7EMfGVkRZNMMonEwYimB+9o9pIchYgBfpnCHpjW+mPepQIdfLvKYBXXOWlisv8xxxQQcE21gUAMNZw2CSK1pOVOEXch9Rpf3YHkPxIZ2C091vmfSURKQMkD/7EgzlwV/hP63dT9w/SHE6HliKi5xQ6K/eb4+tM/KkFKIFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069607; c=relaxed/simple;
	bh=ULK38kqJjMiA+l8RFycLI4QMy+N0BxTIEV+IiefQ7LY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dwkgrsoru+7gFIs+aEqeJM5j9nY8GsrWk10ftUd89QY01y2recx60rxihXXLe57j3Sjn1sbwKncCWp3AHcrkswP43bt7ksADoRDaWBcj8Su5SwraDMhAWt2PHJdyNkl6H/VIqPrmFJier3+R9jwGCbWONCD5dxHgr3ZJXgW+gAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7kxPAqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D4BC4CEF7;
	Thu, 13 Nov 2025 21:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069607;
	bh=ULK38kqJjMiA+l8RFycLI4QMy+N0BxTIEV+IiefQ7LY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u7kxPAqzFjv0XhtLwcWgtD1/om8F6MhEfuw3lX2Ibh2ZsWT4g9YUSvwqR+Zpj0T2y
	 0fazGzIMuqlNNrZhq+v1i68twdJUtHwhKfZ3W8atBZwR7iGsmHSO6BEwKBtftA9P3e
	 QIz/9PGupYsLFudsOPlyk+MQR315MJbdbtlDwZyVVcGhJ7kYCAuuDy84UYj1wm+fnq
	 6elOok2TwC4B8u7QK/xTbx2Dlhr3HxQm/tWE8gIgeNmA07DCVsn5dS0LTkDtAwQhpm
	 5W1gFflDp3BlVmmxBZm46R42P+mXbnQH+sGw4l/RNAL4xu/BTtjxT6NdNd9INBNuF9
	 QPsO7SUbpVQRg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:25 +0100
Subject: [PATCH v3 42/42] ovl: remove ovl_revert_creds()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-42-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ULK38kqJjMiA+l8RFycLI4QMy+N0BxTIEV+IiefQ7LY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+UW4nlea8ozv9yK/s0pu1+w1HkzJ0f+0P3z1hK+2n
 Eo9foImHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5fYPhf2Du9GnFGoYGhz9e
 uf2g/dXMhUGP3gYIrHGxjTHwvS7TPo2RYaY0U/+5a/LMFsEvAr0uap3eaZqU/n/6k/vKoQte8Rd
 n8QIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The wrapper isn't needed anymore. Overlayfs completely relies on its
cleanup guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/overlayfs.h | 1 -
 fs/overlayfs/util.c      | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index eeace590ba57..41a3c0e9595b 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -437,7 +437,6 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
-void ovl_revert_creds(const struct cred *old_cred);
 
 EXTEND_CLASS(override_creds, _ovl, ovl_override_creds(sb), struct super_block *sb)
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index e2f2e0d17f0b..dc521f53d7a3 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -69,11 +69,6 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 	return override_creds(ofs->creator_cred);
 }
 
-void ovl_revert_creds(const struct cred *old_cred)
-{
-	revert_creds(old_cred);
-}
-
 /*
  * Check if underlying fs supports file handles and try to determine encoding
  * type, in order to deduce maximum inode number used by fs.

-- 
2.47.3


