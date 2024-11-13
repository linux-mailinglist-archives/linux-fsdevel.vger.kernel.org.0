Return-Path: <linux-fsdevel+bounces-34683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ADF9C7A89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 19:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E46B33B64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 17:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A039206E7F;
	Wed, 13 Nov 2024 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="TxHuHcLT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VgAfNE+C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF02038D4;
	Wed, 13 Nov 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520538; cv=none; b=ng+HkfcQq4QobDUKs/5A1l9eFBpcXi54/85whN21ogxb5U6Rw0Y+e7LwXVzwmNP7pyuYlEBQUYGj+lQXHlmMyuQNrILKvX3wxPv5hha0z9RUwbKnpN4Skot+YnHbrdbty2+kRyQdnwau9hfRh5rHjDWrxbv2977wVY8QnNG2QvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520538; c=relaxed/simple;
	bh=9z0fkUawtgFOBoM9gsarHEhrMu7s9nLWUAKQBM2JJCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXlR+VZYYZGpeyEfeon+sIHR7q5hM+OewO+1+5kmA6njAi30oDLWyjCixKvv55TaYAH2LScOjU775hPL+ds0Bz3f0AWKmCCtAAkIwK01Bc1HwPHzXfcAVjXh91pCLVv3bYW3ea51mRIQ//xgUUp2CEsSSXpACdkc1T00BVCn4eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=TxHuHcLT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VgAfNE+C; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 80D6311401EC;
	Wed, 13 Nov 2024 12:55:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 13 Nov 2024 12:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731520534;
	 x=1731606934; bh=AfsdjGskH8G9xKz2wh5f7jewD2z4hb6EP8wjUyjgt1k=; b=
	TxHuHcLTfRP9eZBLr3Sg/hs6Sin7aQv1OIYPVoAzkHohXmPf+1+o1zpfOlKHub/3
	/MTtiCxAiOB5w/s7j0HsCFJYPThhthfcnbOwspKet/ig+wNF19ulfaYCQg/7jYo/
	Rirvp/DJGwFGq/yEX+w9LvJTRe1sfmv9765i1URDnanb551K1GsgUeNNlyoj8O2R
	iVtRfHxUsa7D46VBFi2Q3jl8b5vHIyma9oXEtb5RcN1QYsXaW9ELmqWHQMrXFtz2
	LcE+9FoD6zTwRnEdh/XKaTrYCt0GYrSTumIeQbjmynZsUuhxx9BEdhhgE3JxTKV8
	LXKu7HxJfLHB5FSwNjqFaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731520534; x=
	1731606934; bh=AfsdjGskH8G9xKz2wh5f7jewD2z4hb6EP8wjUyjgt1k=; b=V
	gAfNE+CzvoiRVjpQYVVsd9mo009KQ9e9JWXqRhPio4sP36u4aKu8P/+E9ljmbmjB
	5Hb88YqSgUK/uWrg32jKNMaHsuVfErzJIGQg6W/b1gMylbCBZZcotjb/4NZIl84V
	XS1Bob76/wn9IxmPr1jCRBq1jeY8HJ9YGzlO72IqOCZtYZn+WetS9xMoipEJ0Gtv
	Oh3sLetNwJB8KJ6q8ryFxpvUVDTRlu7xeb1EufveSKiZosnW2gEPCDlOhW9i9var
	S8kU7+QWTUxLNfAB3vc8A+CIZ8pTYMieoN98z/HV51upxLmyvE7GqaA+o7F0/ca6
	KhuZivgTMe6mjCe3Fd1SA==
X-ME-Sender: <xms:Fug0Z2sNf5MMIhj_Fhnd6RrXVz4oQHRFnnUCKqU7tad4jhzL98GehA>
    <xme:Fug0Z7f0wGPdwABm89EPucqWkpV1h_3cRJXLZUOlsvs1JA89LSlPR6jyHnkuAvSF9
    wsNHu-pBfnf8YcxZj8>
X-ME-Received: <xmr:Fug0Zxz0GBeESgh-QSIi7NsYwOIcOzvMtGgQHwUw9y6ukETGt7OkouRwGtfdCOb8x54y0uft_8w2tYwI-dym2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefgrhhinhcuufhhvghphhgvrhguuceovghrihhnrdhshhgvphhhvghrug
    esvgegfedrvghuqeenucggtffrrghtthgvrhhnpeegvdffgedugfeiveeifffggefhvddu
    uedvkefgvdduueeuheffgffftddtffeuveenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegvrhhinhdrshhhvghphhgvrhgusegvgeefrdgvuhdp
    nhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmh
    hirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhu
    khdprhgtphhtthhopegvrhhinhdrshhhvghphhgvrhgusegvgeefrdgvuhdprhgtphhtth
    hopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:Fug0ZxOEpNddg0a0VKHePCw2D-qjtxE-3l9hUYA9SyKpuAZSCs1F9w>
    <xmx:Fug0Z28SfRc4NQdkgcllIKl_krxzIOVVG3bYSkFaLHzrSnfHUr88aQ>
    <xmx:Fug0Z5UvCyAT8SIUlY0un4P_hf5LOL4_MGF0eHW-RIqL86lBUQmj2Q>
    <xmx:Fug0Z_exfDetFgO2O-vbFYCdOuq2ZMiH6YjMeJCeZUPcsWTAfckejA>
    <xmx:Fug0Z30emXvq_LYfzCNVD1XmDddFZHMxSniiLQqhfTA9F3k26_VAVbD0>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 12:55:33 -0500 (EST)
From: Erin Shepherd <erin.shepherd@e43.eu>
Date: Wed, 13 Nov 2024 17:55:25 +0000
Subject: [PATCH v2 3/3] pidfs: implement file handle support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-pidfs_fh-v2-3-9a4d28155a37@e43.eu>
References: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
In-Reply-To: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 linux-nfs@vger.kernel.org, Erin Shepherd <erin.shepherd@e43.eu>
X-Mailer: b4 0.14.2

On 64-bit platforms, userspace can read the pidfd's inode in order to
get a never-repeated PID identifier. On 32-bit platforms this identifier
is not exposed, as inodes are limited to 32 bits. Instead expose the
identifier via export_fh, which makes it available to userspace via
name_to_handle_at

In addition we implement fh_to_dentry, which allows userspace to
recover a pidfd from a PID file handle.

We stash the process' PID in the root pid namespace inside the handle,
and use that to recover the pid (validating that pid->ino matches the
value in the handle, i.e. that the pid has not been reused).

We use the root namespace in order to ensure that file handles can be
moved across namespaces; however, we validate that the PID exists in
the current namespace before returning the inode.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
---
 fs/pidfs.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 80675b6bf88459c22787edaa68db360bdc0d0782..0684a9b8fe71c5205fb153b2714bc9c672045fd5 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/anon_inodes.h>
+#include <linux/exportfs.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/magic.h>
@@ -347,11 +348,69 @@ static const struct dentry_operations pidfs_dentry_operations = {
 	.d_prune	= stashed_dentry_prune,
 };
 
+#define PIDFD_FID_LEN 3
+
+struct pidfd_fid {
+	u64 ino;
+	s32 pid;
+} __packed;
+
+static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
+			   struct inode *parent)
+{
+	struct pid *pid = inode->i_private;
+	struct pidfd_fid *fid = (struct pidfd_fid *)fh;
+
+	if (*max_len < PIDFD_FID_LEN) {
+		*max_len = PIDFD_FID_LEN;
+		return FILEID_INVALID;
+	}
+
+	fid->ino = pid->ino;
+	fid->pid = pid_nr(pid);
+	*max_len = PIDFD_FID_LEN;
+	return FILEID_INO64_GEN;
+}
+
+static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
+					 struct fid *gen_fid,
+					 int fh_len, int fh_type)
+{
+	int ret;
+	struct path path;
+	struct pidfd_fid *fid = (struct pidfd_fid *)gen_fid;
+	struct pid *pid;
+
+	if (fh_type != FILEID_INO64_GEN || fh_len < PIDFD_FID_LEN)
+		return NULL;
+
+	scoped_guard(rcu) {
+		pid = find_pid_ns(fid->pid, &init_pid_ns);
+		if (!pid || pid->ino != fid->ino || pid_vnr(pid) == 0)
+			return NULL;
+
+		pid = get_pid(pid);
+	}
+
+	ret = path_from_stashed(&pid->stashed, pidfs_mnt, pid, &path);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	mntput(path.mnt);
+	return path.dentry;
+}
+
+static const struct export_operations pidfs_export_operations = {
+	.encode_fh = pidfs_encode_fh,
+	.fh_to_dentry = pidfs_fh_to_dentry,
+	.flags = EXPORT_OP_UNRESTRICTED_OPEN,
+};
+
 static int pidfs_init_inode(struct inode *inode, void *data)
 {
 	inode->i_private = data;
 	inode->i_flags |= S_PRIVATE;
-	inode->i_mode |= S_IRWXU;
+	inode->i_mode |= S_IRWXU | S_IRWXG | S_IRWXO;
 	inode->i_op = &pidfs_inode_operations;
 	inode->i_fop = &pidfs_file_operations;
 	/*
@@ -382,6 +441,7 @@ static int pidfs_init_fs_context(struct fs_context *fc)
 		return -ENOMEM;
 
 	ctx->ops = &pidfs_sops;
+	ctx->eops = &pidfs_export_operations;
 	ctx->dops = &pidfs_dentry_operations;
 	fc->s_fs_info = (void *)&pidfs_stashed_ops;
 	return 0;

-- 
2.46.1


