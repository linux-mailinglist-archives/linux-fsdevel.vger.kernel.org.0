Return-Path: <linux-fsdevel+bounces-69524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 538A5C7E39F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4A784E29F5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38472296BC1;
	Sun, 23 Nov 2025 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZtyiJAS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FFE22B594
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915618; cv=none; b=Zr8hvMEFTweWGq1yxZxRxeNQvXL4BFEU1R3FHz8PpeAEbtRtP2VSVuhsH/4J1mhwYdi5kgxVt1/zf2gBBdmDHxW3jTKNJ4Y07Ye14Xjwsvvog9sZ+DfEJmYl6faDqHWnfuGGf9bRDN4tUPTIE5lAt9Txn3gl/gUaxHFyDdrulAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915618; c=relaxed/simple;
	bh=o+woxW9TmTIMpXPy4XyvkgxWm1MX9UEwxeyU1S2o/QQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QVV/qNkl+T+6wNMtEcCodJkVTDr4h9F210F/lTYEVFoF06iu3jpH7uA4cVdDlySryrnDQzFpz4Ze8Hx/tBWaY/LeBQmFlvwZ3wRkz3aW87GTApDQECP0Wop4G7zsnhsOWiQOKKhKqVoM+uoguMf09Iv8ZZU5ro/xog5BSlxN0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZtyiJAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22BEC16AAE;
	Sun, 23 Nov 2025 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915618;
	bh=o+woxW9TmTIMpXPy4XyvkgxWm1MX9UEwxeyU1S2o/QQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rZtyiJASnNa8VOPpG355Kt7VVzS7wFfMIYqoVN0RGeSXXALWQfSAiWcxIjJ3CoIvJ
	 uvMsNoO+C3+oHHiQBKw7Xmd18vqc8+/WRRpWmoa4fY08/rP06eFg/fTYRPFgIV7OTC
	 esXu2FCwtdEiXYY156pcuR5fPw1xenuIFm1tkUgYnRqkRNIJntybFAHZ7tBtUOB0gZ
	 imTHZMQkFv5tzDoWXMY0TF+ilZFgb1c2AQcNlA8DB4xf5/XBiWc6E8QqCpZTfiex8x
	 ieDIVIRCKtbdY0TSBAJhUNPBCPtx93Ed0XQRWlggIaf34P/h0lkZjabB/PGxjdxMjp
	 CCHYvd1oa0CLg==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:20 +0100
Subject: [PATCH v4 02/47] anon_inodes: convert to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-2-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003; i=brauner@kernel.org;
 h=from:subject:message-id; bh=o+woxW9TmTIMpXPy4XyvkgxWm1MX9UEwxeyU1S2o/QQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0ck8mzU7V67uqjEeVNQk8pyjfV8E9KN7tx5KW6eI
 zFJ/L5DRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESWLGX4Z2VzNq/mzq1JezaF
 b5BdEGBiMGun4/ZXHLGtbx31XdT9fjAyfD6/21cz407jmyNhP55fPvw4dw/HpaLX93/a1k+9cM/
 cnAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/anon_inodes.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 180a458fc4f7..b8381c7fb636 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -280,27 +280,8 @@ static int __anon_inode_getfd(const char *name,
 			      const struct inode *context_inode,
 			      bool make_inode)
 {
-	int error, fd;
-	struct file *file;
-
-	error = get_unused_fd_flags(flags);
-	if (error < 0)
-		return error;
-	fd = error;
-
-	file = __anon_inode_getfile(name, fops, priv, flags, context_inode,
-				    make_inode);
-	if (IS_ERR(file)) {
-		error = PTR_ERR(file);
-		goto err_put_unused_fd;
-	}
-	fd_install(fd, file);
-
-	return fd;
-
-err_put_unused_fd:
-	put_unused_fd(fd);
-	return error;
+	return FD_ADD(flags, __anon_inode_getfile(name, fops, priv, flags,
+						  context_inode, make_inode));
 }
 
 /**

-- 
2.47.3


