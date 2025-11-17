Return-Path: <linux-fsdevel+bounces-68687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BABAC634ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B648D35787E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1824432E75A;
	Mon, 17 Nov 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDerhXlV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763125A357;
	Mon, 17 Nov 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372105; cv=none; b=dg0ADuOt9U6Tn8wpx5aK+k7gTv/acSBvzwEXXo6GC+TJvhBHAMVwiuFwfNMAX5tmnsVID8E8TUC985kMT8UAiRvHSSR5QF0ooeytz5aAlbkRK4phRfA0yJ6fttz7TvHuBKhqhROYrvAB3IQb7T0RJ5556eDj2lrWZXoAyYn0BCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372105; c=relaxed/simple;
	bh=I1i8onXB37+uwRKKx66LPP+W/17f1M+QdYONWP7kTtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QwntwRDri7tGivrta9mzVy8XNpy+wdWYt631zooAyse+buMLiFQ6XHLczzaUTEorcwlfq7Mlgm5vSKRHQbTwa+lzKgMgUC+j4wiklKR5Xwlaw2HIjyWI6+JBs5yVGSen8/g82ecb0Q2QdQw7cPiJzUe+eyp52xOebONoXv2YJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDerhXlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE23C4CEF5;
	Mon, 17 Nov 2025 09:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372105;
	bh=I1i8onXB37+uwRKKx66LPP+W/17f1M+QdYONWP7kTtk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RDerhXlVw26GkZBYwwBFphIGlIJZsl2S2UhQYIrGX4IUKELUFKBGxDbrFPCY7Iv66
	 6hU7UkTewFAYRW9y3AtmHV19DVwOj61WTHxmLBAKM2sEIbZ8b6SLsMg2GwPf5daPyV
	 6wDmZllPtNNcVPmDxd/orLbNzeGMkB1zNxhfP4bJ5iE6ukeCcogDVOMKj6f9TOuNbb
	 8xE5gGgAvGTiHf80yEZim71bogKrE6B6AdKAX+p97hE1pbM9g5hcHJm4mHiqJnKOco
	 RsxBnRUqEuSx/xy/xn0zw6siNcU07br/tjoawL8qwg+T0Oh77Ox9o0zx+c2AJjQjwY
	 WoZfRdnHlVK6g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:38 +0100
Subject: [PATCH v2 1/6] ovl: add ovl_override_creator_creds cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-prepare-v2-1-bd1c97a36d7b@kernel.org>
References: <20251117-work-ovl-cred-guard-prepare-v2-0-bd1c97a36d7b@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-prepare-v2-0-bd1c97a36d7b@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2504; i=brauner@kernel.org;
 h=from:subject:message-id; bh=I1i8onXB37+uwRKKx66LPP+W/17f1M+QdYONWP7kTtk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvXHtfby+8fiFWScKl2SVPLKSDnuTz/xTSmB2+QKpx
 GImA8a8jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImcFGBkWGetvfT9qXeOF3+U
 37FeHK7G8KTH6NTjKM6z169ZcYgffcjwP6ZAZ3XklVma1cvuR8Y581q8E+rsy/g8we5NSNqf/kN
 KTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The current code to override credentials for creation operations is
pretty difficult to understand. We effectively override the credentials
twice:

(1) override with the mounter's credentials
(2) copy the mounts credentials and override the fs{g,u}id with the inode {u,g}id

And then we elide the revert because it would be an idempotent revert.
That elision doesn't buy us anything anymore though because I've made it
all work without any reference counting anyway. All it does is mix the
two credential overrides together.

We can use a cleanup guard to clarify the creation codepaths and make
them easier to understand.

This just introduces the cleanup guard keeping the patch reviewable.
We'll convert the caller in follow-up patches and then drop the
duplicated code.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 4fd6ddd6f4ef..3eb0bb0b8f3b 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -575,6 +575,42 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	goto out_dput;
 }
 
+static const struct cred *ovl_override_creator_creds(struct dentry *dentry, struct inode *inode, umode_t mode)
+{
+	int err;
+
+	if (WARN_ON_ONCE(current->cred != ovl_creds(dentry->d_sb)))
+		return ERR_PTR(-EINVAL);
+
+	CLASS(prepare_creds, override_cred)();
+	if (!override_cred)
+		return ERR_PTR(-ENOMEM);
+
+	override_cred->fsuid = inode->i_uid;
+	override_cred->fsgid = inode->i_gid;
+
+	err = security_dentry_create_files_as(dentry, mode, &dentry->d_name,
+					      current->cred, override_cred);
+	if (err)
+		return ERR_PTR(err);
+
+	return override_creds(no_free_ptr(override_cred));
+}
+
+static void ovl_revert_creator_creds(const struct cred *old_cred)
+{
+	const struct cred *override_cred;
+
+	override_cred = revert_creds(old_cred);
+	put_cred(override_cred);
+}
+
+DEFINE_CLASS(ovl_override_creator_creds,
+	     const struct cred *,
+	     if (!IS_ERR_OR_NULL(_T)) ovl_revert_creator_creds(_T),
+	     ovl_override_creator_creds(dentry, inode, mode),
+	     struct dentry *dentry, struct inode *inode, umode_t mode)
+
 static const struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
 						    struct inode *inode,
 						    umode_t mode,

-- 
2.47.3


