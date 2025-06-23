Return-Path: <linux-fsdevel+bounces-52501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE1EAE394A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669D21895AE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 09:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955442367AC;
	Mon, 23 Jun 2025 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNidijTF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1702235BEE;
	Mon, 23 Jun 2025 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669308; cv=none; b=b8s3EI0XjaGzli9eaCnPtXfGyy8NuOhnEgNYe41tjsIarqJqrDRnsHQOCrkjQeCPbCIZVB+s/rwLApJQ4LAa7ZYNxx8jgRwpRvmfUIsV74EPya3ONNaiJWAWVh2+AkujXh3Y2sPRxYfICJlTemx9E3FtZIGE/lXhXvZxCom4Nuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669308; c=relaxed/simple;
	bh=Hc3TRmXhULM3h3L+tzT/hGDoCeXvIUnhOOWQn7CK14Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FYrjp/EPnHkaSYcUPv+UaMKFn8N67kgFkTtJ+c7KuCjz1FolvgAmXZZ1lSslgc0wg1D/6GoMWHRXZk9n2hO5QFxlo3Gg0JzwNCwVjeSz8wlJZILWcOejEsfquYHdksflp1e67XVy2uS9bA26KeyTv8U1xCvAW8eEtSF4PDpNyEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNidijTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5506C4CEF1;
	Mon, 23 Jun 2025 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750669307;
	bh=Hc3TRmXhULM3h3L+tzT/hGDoCeXvIUnhOOWQn7CK14Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iNidijTFJ29EWRadgiGMkHCyZn+yoCa7faiY825IWdYp07bwalYE6qtdkvX2IWPXZ
	 7GJjSgOz2ef60HaF6KVEtazzwAy24Cytj+Z4DdVnp/CIAypNdsHFh1RT1X5NMjYfAc
	 e/5mhIgqt1NTKSztzlnTbZTFfNY7L/V2sT2bWVtCo97tpi4zbdW/ivt9y/4/Fg/iak
	 PahRH5jBYql9Y3EvNJyyS3qoeoWiSwlCv5jgjA/GTMYsiVoQZ1+cWVh3rZhg0zbWux
	 UOAK+9C0W4vnOVt07zHrXmcre43AkZRiYKfVN4njo5OBmd4iWQHQkmk8wzRTmGciYl
	 Sjp/uPsc//h6A==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Jun 2025 11:01:27 +0200
Subject: [PATCH 5/9] fhandle: reflow get_path_anchor()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-work-pidfs-fhandle-v1-5-75899d67555f@kernel.org>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
In-Reply-To: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Hc3TRmXhULM3h3L+tzT/hGDoCeXvIUnhOOWQn7CK14Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREir8OEnj7sKpDlF9PQu5Nm3264ra9e5ZknKsTqV1Ss
 mvGlFt8HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5VcXwTyl4cZld5rboMMOJ
 x/MZt8h2p6+6IH/38+JP/lI1UleNjzAy3PBUfuDNd1LyV9vuNe71nl+XlEp2fW6Z/mnH+U/2z8W
 u8wMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Switch to a more common coding style.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index d8d32208c621..22edced83e4c 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -170,18 +170,22 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
 
 static int get_path_anchor(int fd, struct path *root)
 {
+	if (fd >= 0) {
+		CLASS(fd, f)(fd);
+		if (fd_empty(f))
+			return -EBADF;
+		*root = fd_file(f)->f_path;
+		path_get(root);
+		return 0;
+	}
+
 	if (fd == AT_FDCWD) {
 		struct fs_struct *fs = current->fs;
 		spin_lock(&fs->lock);
 		*root = fs->pwd;
 		path_get(root);
 		spin_unlock(&fs->lock);
-	} else {
-		CLASS(fd, f)(fd);
-		if (fd_empty(f))
-			return -EBADF;
-		*root = fd_file(f)->f_path;
-		path_get(root);
+		return 0;
 	}
 
 	return 0;

-- 
2.47.2


