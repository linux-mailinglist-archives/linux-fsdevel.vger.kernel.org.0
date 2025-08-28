Return-Path: <linux-fsdevel+bounces-59551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 584C0B3AE15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17AD7988437
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F84F2D060B;
	Thu, 28 Aug 2025 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ggc3NcB6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597A52D542F
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422493; cv=none; b=U8r72IpFD33XYNUEUiBGj29J1HUpKmX7KQMpflOcIY1bCeGf1jD0YJXlGaJ/yoARzM41kdz9MAom3+gbulnh0rnJU0aTIZ/IpqQoLjKfWQes7zPxiHibBilFDDmQe26iyvY0pFRTNPUL4WRG3rXkwfr+EW9B5u+2vVnxHkE0LNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422493; c=relaxed/simple;
	bh=hLPA0g5bdVcxOpf0rWWQb3tdQkqypKwSNmWId//ZO9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krJdlReKdXzOQglt10dgqZ724dGCxjYd3hejlowGGyKNx69VO2DCEMkin/cCG11CY0nz6l/sr2yHAURrBJV5Mb/O8sNMsx0CfRdpQyLdwTJNksxQHMVLPckZVpdq81HYuTfjcZy5F+obtv7/iDqXwaD0ZU356y/FjgSYfPdICII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ggc3NcB6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KAdTlyjWeXNNBo+7mLiJz2PwuoktGV0Qq2wIz6AHAjM=; b=ggc3NcB6PmAKpOo+eawGrDnSvj
	33zydUHNg8/ZIWEGNMp/4bCso30ErohAY1zptEbg5wU96AVVMG32cy7wpPCEpFXPIKS0SPilDIOTp
	FNPTXcFdLvuUr55MmiqTc4pc2GPc/Av6IGLHUmwljtOR+qU0VbBZeU7OC4sWFgiZYqHFxulYC+bqy
	86jLi+ph5wTni3tVzn/HwYwJvCz8YhhN1za6jg3RueX0HM6rpMDi0AiGDbxqTCILf7SSLHXAjYTO3
	ulIrjJ9p4DN1ECaWlus/3dmQmWr8xJkUXZ+W2xXuAZawYM5cfUMjzJZ1EBu4cxSvoX2P/ln6ZO+ME
	ACEcK55A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliz-0000000F24L-2mWy;
	Thu, 28 Aug 2025 23:08:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 24/63] pivot_root(2): use __free() to deal with struct path in it
Date: Fri, 29 Aug 2025 00:07:27 +0100
Message-ID: <20250828230806.3582485-24-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
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


