Return-Path: <linux-fsdevel+bounces-60066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BFBB413DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460655462FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF162D7DD3;
	Wed,  3 Sep 2025 04:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GTUw4MFc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940E42D5423
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875345; cv=none; b=JozbBBXCcsBP4xg8Qy/NR8sNx69ZNwINVOwo/v0ZpkUQY95p95sWmdx/dpl3wCRammgtknSbyghsNBSLsSaZX7pB2f598tiuzx9V/Oh3bm58MOnGm00aE+l0DkDhxO6waXC6IxtexXNyqXHdmSp+fADUaMGAuaBbBYzyXRnrU3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875345; c=relaxed/simple;
	bh=hLPA0g5bdVcxOpf0rWWQb3tdQkqypKwSNmWId//ZO9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFeUutUskJDBf4mYxUmIveEfISAgUGKbIRRYPDs+4mrY2hUIChZY/ROdQSn+M7xbAaugIQjwHnjk5zxrNiIX1afR0ZrixxlFN/VU0Z4STr3y7pOMdnUZOwXKONK/RtX/rJpL+XVVLgmCV9YqsmPAr0G+ptO9GTumqVqZNgt09bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GTUw4MFc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KAdTlyjWeXNNBo+7mLiJz2PwuoktGV0Qq2wIz6AHAjM=; b=GTUw4MFcVs3zuhuUkRMuRweAba
	6SxsJjIXzyzvDlCkb0e8GOqdHpKE9XnsNj8i05DlLXx5e346YzrESMlU0GhBe/M55sw8je2fI6IBQ
	YIzsAcqiSG1IO4HxbadR5hQ5rbxnHtHQF00vC3h/3rIBOlHCfxftbnymJHkzptkKs3z3nCXOlVooT
	PdIdFQVRUTrH5R6N3hOSp8jg/MHzZ2LhHFtQ18pKF97w76njKzR1OrOrIHPP7HhVF42a9fqT9IgU3
	HVkmh0B5LfcJy6Gyw/hWtWW/2AqiJiRnPhHG6z0hTkMmJrDPOKxj5zp4tf0Kt86spT1hmCvZVJhZw
	9YuW8+DA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX3-0000000Ap9E-3Cb9;
	Wed, 03 Sep 2025 04:55:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 24/65] pivot_root(2): use __free() to deal with struct path in it
Date: Wed,  3 Sep 2025 05:54:45 +0100
Message-ID: <20250903045537.2579614-24-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

preparations for making unlock_mount() a __cleanup();
can't have path_put() inside mount_lock scope.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 245cf2d19a6b..90b62ee882da 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4622,7 +4622,9 @@ EXPORT_SYMBOL(path_is_under);
 SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 		const char __user *, put_old)
 {
-	struct path new, old, root;
+	struct path new __free(path_put) = {};
+	struct path old __free(path_put) = {};
+	struct path root __free(path_put) = {};
 	struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent, *ex_parent;
 	struct pinned_mountpoint old_mp = {};
 	int error;
@@ -4633,21 +4635,21 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	error = user_path_at(AT_FDCWD, new_root,
 			     LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &new);
 	if (error)
-		goto out0;
+		return error;
 
 	error = user_path_at(AT_FDCWD, put_old,
 			     LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &old);
 	if (error)
-		goto out1;
+		return error;
 
 	error = security_sb_pivotroot(&old, &new);
 	if (error)
-		goto out2;
+		return error;
 
 	get_fs_root(current->fs, &root);
 	error = lock_mount(&old, &old_mp);
 	if (error)
-		goto out3;
+		return error;
 
 	error = -EINVAL;
 	new_mnt = real_mount(new.mnt);
@@ -4705,13 +4707,6 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	error = 0;
 out4:
 	unlock_mount(&old_mp);
-out3:
-	path_put(&root);
-out2:
-	path_put(&old);
-out1:
-	path_put(&new);
-out0:
 	return error;
 }
 
-- 
2.47.2


