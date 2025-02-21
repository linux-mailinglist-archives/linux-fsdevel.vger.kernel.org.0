Return-Path: <linux-fsdevel+bounces-42230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FB6A3F5A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F563189771B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1658720FA94;
	Fri, 21 Feb 2025 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4yDhtb8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4420B812
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143624; cv=none; b=pSV26DrLFRUAptzPE93HtY3hnDFIlkI5u0ZecSr04TRv4nEFQoi4bWLrva9gnMyxk0E+Jf6rtd9EymzBp8GPZcEdDXQv4qTup9dxEtjxWGj7GHXTx/6iwkg+LmRBkvJYazUmhS3oMdPaRudFafEMLFERsXLNjlCBoexfMbvSa2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143624; c=relaxed/simple;
	bh=S7vIZ3NberhRHRff0PuGILeschmdcS78Pf1BjJ8FqL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=slqlwwTt6URtV7KdYQMJT4vRl8GvN9pisXkxFYxHsq+UCiuf6Ts3p5N1TieP8Xqb6gzfH2JCMAjZC8cI10pGwCmo0l8aoTQ7Pd5G1goWXIQ8RkoW6GBdOekjtH6ycoJmknqhf5mBNL1XaM3LQ6zbLoOYo+MYkaoMeXofznxvU2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4yDhtb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675EAC4CED6;
	Fri, 21 Feb 2025 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143624;
	bh=S7vIZ3NberhRHRff0PuGILeschmdcS78Pf1BjJ8FqL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E4yDhtb8OFcvYzU5aAZFQV/dbmwowKvEpKjHkilYSVVwDttNMGboBbDSHlbteLgs3
	 V59944gF66dCfEKIjTnDgiI5aPA+bdfukemKNLHaBW75AgC2yLiWq4OfhV1a9x+wKG
	 w5RZWTLNOH0gSOifUjkVYCSPjoX08sMMx7+mKuB09smSDK/Dqbdi/cCwUKFZMwhkWr
	 FLPi9TmaE+rhzBxce4IyWVX+5DudXcKpttkPblf40GlWq+X6Qnz0t0E98o49EbUVDs
	 Pyt+Ry8jKNiRwym088W3ob6sFnwS76UBSNEGxepCNJHGHlEZ0d4ormjXepUGbsg1Fp
	 vOSJmxd3iupDg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Feb 2025 14:13:04 +0100
Subject: [PATCH RFC 05/16] fs: add may_copy_tree()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-brauner-open_tree-v1-5-dbcfcb98c676@kernel.org>
References: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
In-Reply-To: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2274; i=brauner@kernel.org;
 h=from:subject:message-id; bh=S7vIZ3NberhRHRff0PuGILeschmdcS78Pf1BjJ8FqL0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqP6lZ9F4olyi7A6vuTWHo0vcpDviap1pqU8ErXtXV
 3/QzFjRUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBGtI4wMJzvOLb3HE/797pRV
 8U82uDd/4L2j08bzqy7HOD5g02GJD4wMh3mK5gjP4eZzLRFIueZ05vbZFXoKrYXyDYEzWyxE8/N
 YAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a helper that verifies whether a caller may copy a given mount tree.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2cffcda8a48e..c61b9704499a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2808,6 +2808,41 @@ static int do_change_type(struct path *path, int ms_flags)
 	return err;
 }
 
+/* may_copy_tree() - check if a mount tree can be copied
+ * @path: path to the mount tree to be copied
+ *
+ * This helper checks if the caller may copy the mount tree starting
+ * from @path->mnt. The caller may copy the mount tree under the
+ * following circumstances:
+ *
+ * (1) The caller is located in the mount namespace of the mount tree.
+ *     This also implies that the mount does not belong to an anonymous
+ *     mount namespace.
+ * (2) The caller tries to copy an nfs mount referring to a mount
+ *     namespace, i.e., the caller is trying to copy a mount namespace
+ *     entry from nsfs.
+ * (3) The caller tries to copy a pidfs mount referring to a pidfd.
+ *
+ * Returns true if the mount tree can be copied, false otherwise.
+ */
+static inline bool may_copy_tree(struct path *path)
+{
+	struct mount *mnt = real_mount(path->mnt);
+	const struct dentry_operations *d_op;
+
+	if (check_mnt(mnt))
+		return true;
+
+	d_op = path->dentry->d_op;
+	if (d_op == &ns_dentry_operations)
+		return true;
+
+	if (d_op == &pidfs_dentry_operations)
+		return true;
+
+	return false;
+}
+
 static struct mount *__do_loopback(struct path *old_path, int recurse)
 {
 	struct mount *mnt = ERR_PTR(-EINVAL), *old = real_mount(old_path->mnt);
@@ -2815,13 +2850,8 @@ static struct mount *__do_loopback(struct path *old_path, int recurse)
 	if (IS_MNT_UNBINDABLE(old))
 		return mnt;
 
-	if (!check_mnt(old)) {
-		const struct dentry_operations *d_op = old_path->dentry->d_op;
-
-		if (d_op != &ns_dentry_operations &&
-		    d_op != &pidfs_dentry_operations)
-			return mnt;
-	}
+	if (!may_copy_tree(old_path))
+		return mnt;
 
 	if (!recurse && has_locked_children(old, old_path->dentry))
 		return mnt;

-- 
2.47.2


