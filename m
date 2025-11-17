Return-Path: <linux-fsdevel+bounces-68678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC242C63361
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 604DB28A8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FF132E699;
	Mon, 17 Nov 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJywXVu+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4D329C75;
	Mon, 17 Nov 2025 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372089; cv=none; b=ki2QB5eIf+AMUIc1mfpvkyN649/l33vqYPQuAXPygfbhqWJzixhkzKPbmfAPCqXbJ8nwv61AV6i9/Q+Ze2hFhN2Y8zJ8HasB5+VcEANEewwJp2g66KO872Iq5wViEO6O/wrXCiU38TdeuJCshZroRlAy3eelegXkaxw4jYJnDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372089; c=relaxed/simple;
	bh=lyu6vcks5WeowdDtzkpH236RP/LHscuF4A7OeNmFdj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jbnlRVRgpL8HHYXC+EPPak80P8abak51wnrk/6tPY/i8vhLqTaalfigItp+wCcb6U9G1mpg3efqdys+n6Tn/69kvqMxZN9nc+3HNABROrz89GqbPaWFDVCKx8Y75i/HALo5ke19dgrelNaKq2g0+Op8tIOXngdZRLvXo1JlxfB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJywXVu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1B9C19424;
	Mon, 17 Nov 2025 09:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372089;
	bh=lyu6vcks5WeowdDtzkpH236RP/LHscuF4A7OeNmFdj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uJywXVu+930EQST15FwQhLlrOQo7jglYsHPlKvnhOtAJ+UfV5xcTVUb5sSVyhJC0T
	 TOG8GRMcvk4D+060xesgl+gt7iW8QT17LXM2aUDFgI0SrBYqLJJpE9q/a5TOau82mq
	 LL6IwqpC4A//dPTFYIxLIxHXhjWNVD/YfhxYFGHQvtSMPdzoSLMlOcax9z1jRa5dOA
	 5sAiYU9naoucdH5opK4h4hD8sB1WKmA7Ej3WzvR0LKD+qrcLk0J9Xyr4kcEWGD4lks
	 JPoo1voI0Pn0+FLJLITY1D13T0O1wcn83S0b3jpkuRlXUV95FW4x5iSnPpV4hEr98n
	 mw0Dn0v4JNuAA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:07 +0100
Subject: [PATCH v4 36/42] ovl: port ovl_copyfile() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-36-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lyu6vcks5WeowdDtzkpH236RP/LHscuF4A7OeNmFdj4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf72bHbzl7N3Hez588WPSB5oYFvy437XFbm8yvz2q
 iWH1r9y6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI0lJGhitHW91+/DFo6ftq
 qf7x22LHA1X8fe//LOaewCb07eyVlbcZ/scxqTRss2mU2VYaf/ull+dDxe3mS612GF0y26TAujL
 HkgkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index e375c7306051..42a77876a36d 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -531,7 +531,6 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 {
 	struct inode *inode_out = file_inode(file_out);
 	struct file *realfile_in, *realfile_out;
-	const struct cred *old_cred;
 	loff_t ret;
 
 	inode_lock(inode_out);
@@ -553,25 +552,27 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	if (IS_ERR(realfile_in))
 		goto out_unlock;
 
-	old_cred = ovl_override_creds(file_inode(file_out)->i_sb);
+	with_ovl_creds(file_inode(file_out)->i_sb) {
 		switch (op) {
 			case OVL_COPY:
 				ret = vfs_copy_file_range(realfile_in, pos_in,
-					  realfile_out, pos_out, len, flags);
+							  realfile_out, pos_out,
+							  len, flags);
 				break;
 
 			case OVL_CLONE:
 				ret = vfs_clone_file_range(realfile_in, pos_in,
-					   realfile_out, pos_out, len, flags);
+							   realfile_out,
+							   pos_out, len, flags);
 				break;
 
 			case OVL_DEDUPE:
 				ret = vfs_dedupe_file_range_one(realfile_in, pos_in,
-						realfile_out, pos_out, len,
-						flags);
+								realfile_out, pos_out,
+								len, flags);
 				break;
 		}
-	ovl_revert_creds(old_cred);
+	}
 
 	/* Update size */
 	ovl_file_modified(file_out);

-- 
2.47.3


