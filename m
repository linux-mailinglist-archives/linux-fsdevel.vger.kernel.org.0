Return-Path: <linux-fsdevel+bounces-42227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C7A3F599
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDF9861A1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD6220F08B;
	Fri, 21 Feb 2025 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpkLgh7V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DFF20E71C
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143618; cv=none; b=qQ8a5NWk0A/rUAo4Cfy9rrzJvVAkOEejXwitPl4MEpXlF2nbyIDtJc71Hk6yT3NRPVwIpk2CtksAaku65dULj3mUH5Yj3mhPeSxH4dPRk53WJY+hqWy9OlqDR0O/sgp669vB8vnda0qcOZe2+ZcAYfLmaz6daSRAZyTpX7VFvxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143618; c=relaxed/simple;
	bh=sUx1KsWjN5QnSOgaKX8WVsvVMrJf1Jc/YDPu/z6mW28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H2kYxXDzWXB4LnwZIXgVIdm9AadGMs6qeJAPl4KrrCcIecFWKwQGZNFC7s8CmXsBKUp8/zcdWFjwckiEYFPVWGeK0GKd6/uT90qlhD4qI1YKmtDjASmVJqWDGsykOokyW23F1Stosdts/Qw/ZzS5eTEw8b9R/qlhRkKUb/dSDTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpkLgh7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70E3C4CEE7;
	Fri, 21 Feb 2025 13:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143617;
	bh=sUx1KsWjN5QnSOgaKX8WVsvVMrJf1Jc/YDPu/z6mW28=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UpkLgh7VjBHgkBRcrRK+O+jzFVRh9CE/JhQ/A0r/0AhZ08NLbD3k8yR/XEzdBhWRy
	 xtgX+OC89Eg4FXZPINxIPw9Rh+ADlD28h8W7XyV4fwgXHjncJGFVKDvJNd8ol0Nbg9
	 hgeeiKDlflf9f1JWPnlshLBuAQyJ2Hl9IPbZpCvY4jfAZMrauwZdTGR8ZmRPUkvVMO
	 aYdoxUcpsqegIcOP/bQbJjXU5flrI1d/PZg4JAEEo5E5E/MFynAu+N1FoKHdIrUQFI
	 160Z6g+1vdwPXmDSngg0r+S5bXwdwonmL7v+p7lr6pNAxRo65WxU91Lh0oImOu1e6W
	 Qiw0+RCwwmZ9w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Feb 2025 14:13:01 +0100
Subject: [PATCH RFC 02/16] fs: add mnt_ns_empty() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-brauner-open_tree-v1-2-dbcfcb98c676@kernel.org>
References: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
In-Reply-To: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sUx1KsWjN5QnSOgaKX8WVsvVMrJf1Jc/YDPu/z6mW28=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqP51dskqowXmf/88aClQErqzrrBlbf+VgJsXmo1s2
 B2Df7QbdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk+g+G/9W+rdO6Ax817lO2
 jHhy4Dtf/qnJ1vc4pmq7TGb+1MNnc4nhv8+VI10eHYLmB0QW/g/M5PH34Wv/eLMs7VuvFJu9X5U
 bJwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a helper that checks whether a give mount namespace is empty instead
of open-coding the specific data structure check. This also be will be
used in follow-up patches.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mount.h     | 5 +++++
 fs/namespace.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 820a79f1f735..e2501a724688 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -157,6 +157,11 @@ static inline bool mnt_ns_attached(const struct mount *mnt)
 	return !RB_EMPTY_NODE(&mnt->mnt_node);
 }
 
+static inline bool mnt_ns_empty(const struct mnt_namespace *ns)
+{
+	return RB_EMPTY_ROOT(&ns->mounts);
+}
+
 static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
 {
 	struct mnt_namespace *ns = mnt->mnt_ns;
diff --git a/fs/namespace.c b/fs/namespace.c
index 9bcfb405b02b..1d3b524ef878 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5313,7 +5313,7 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
 	 * We have to find the first mount in our ns and use that, however it
 	 * may not exist, so handle that properly.
 	 */
-	if (RB_EMPTY_ROOT(&ns->mounts))
+	if (mnt_ns_empty(ns))
 		return -ENOENT;
 
 	first = child = ns->root;
@@ -5338,7 +5338,7 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	int err;
 
 	/* Has the namespace already been emptied? */
-	if (mnt_ns_id && RB_EMPTY_ROOT(&ns->mounts))
+	if (mnt_ns_id && mnt_ns_empty(ns))
 		return -ENOENT;
 
 	s->mnt = lookup_mnt_in_ns(mnt_id, ns);

-- 
2.47.2


