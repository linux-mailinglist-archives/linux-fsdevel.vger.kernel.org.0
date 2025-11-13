Return-Path: <linux-fsdevel+bounces-68372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89816C5A2CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 066674EA947
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B8532695C;
	Thu, 13 Nov 2025 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFWrDEpy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4AD2C3245;
	Thu, 13 Nov 2025 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069559; cv=none; b=C4958vUN18jFofdlJ/IBzVNqMvk052P22e2qQNXzkBPW+95WiHlNZ2rThHn27OSnftQMBq/l+EPg6DPCWUZ+hnee21LVLVwI4LdsOHV55sDUISvz1PNqQX+e71E6kDBGJJjVAwVrDq9gMGGIzPqIk999qGDOxcjOZJw2pKbRol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069559; c=relaxed/simple;
	bh=5iO55r6K1T90vIhDiacs7KryoGerPeGY2kAmXKHg1MA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6VBApk1BJDhERLxuI5Y/VusQRW6u2BZhCK+Gs1TEGMBAfuZl6UJImdGxRU9nISUgRFlw5xNiha2X8K0WWo0mUpXhHsOI709/qNmdJ6cym6TQVmUE2NqzlqHdUkEkcjSFkwaVrDmyvvO05ThkxlpWMN33gut9Vib43H/8hdbiwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFWrDEpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CC7C4CEF7;
	Thu, 13 Nov 2025 21:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069559;
	bh=5iO55r6K1T90vIhDiacs7KryoGerPeGY2kAmXKHg1MA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GFWrDEpy32mE0ql+WF3f2Z9QK+ETvuKwJDBBk+jHQ9rFsM8CO1Bwqfc07ctKuFGhZ
	 C6VMZ2VCQzP0K7sp+hdvzJJxe5/TRGVj2RVtr9zXJyg22EIL+LYvG80L15KGwQp3WG
	 ZpIKZ/L8CrVWgvVScUt+MEdHOwJCDG7sUHImhN2B+4RBtwPjlVETHYmLLJEpEGC6ig
	 z6c9NVJuHB0wnOkrMPaT9GkDSiz+fBjh94/vobo2MkAi8pKH2OxG7jc61nIT/zlZsv
	 y73xnMOL5jW+RTscUBQxICLpFFcc6PijNQwhrurE7e2igvqZEhVOBLb5i+kPu+lc9A
	 Y/ArXKOLnlQtg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:31:59 +0100
Subject: [PATCH v3 16/42] ovl: port ovl_get_link() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-16-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5iO55r6K1T90vIhDiacs7KryoGerPeGY2kAmXKHg1MA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YWF3NxpGLDLJaM//aZff11/7t8ClWOrDig2H3lmH
 GnT5baoo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJs+xkZpq6yb12b9zt79oWJ
 YVwrNueJnhfXmqn47Jquxt5n6hlJvxgZzt87oMz5ItBmXcrsyZzFVnmbHzZ5bY7/Yb54tajEr//
 iTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index dca96db19f81..3a35f9b125f4 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -327,16 +327,11 @@ static const char *ovl_get_link(struct dentry *dentry,
 				struct inode *inode,
 				struct delayed_call *done)
 {
-	const struct cred *old_cred;
-	const char *p;
-
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	p = vfs_get_link(ovl_dentry_real(dentry), done);
-	ovl_revert_creds(old_cred);
-	return p;
+	with_ovl_creds(dentry->d_sb)
+		return vfs_get_link(ovl_dentry_real(dentry), done);
 }
 
 #ifdef CONFIG_FS_POSIX_ACL

-- 
2.47.3


