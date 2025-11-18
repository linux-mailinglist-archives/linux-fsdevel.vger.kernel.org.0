Return-Path: <linux-fsdevel+bounces-68961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69307C6A6C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E38794EF83C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89667368273;
	Tue, 18 Nov 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzUH0cTs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60121FF25
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480982; cv=none; b=q5Lz1tQL5ejVA+iOlnnFfiC3nR2ZrvbwfFL8w7EjN/I/AYGWCmA7Ax35Vd7rSm4GoYNRNdSOOvZ6+tu56Ru46a8JxTR+E/AmHGeoEPQ6WSUDYk/CWwAeNYgLwlCj7js88YFeuGLdWNAjvBiLywBKlqHLmQJqhX0u352neHW+0Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480982; c=relaxed/simple;
	bh=ItJZh4A8NGwbne8slv1wFuIEOw/1o50+xQTg0pOawOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tqRZV3xEV0n5JC5BO626SwJeFWW9TH7Ic1YTbU1RLaCLz4dJUkmD/YKQdmw8b53BqglNrGXB9BdFif3+J/ti6urqvyXepnf0nMnYo7ND3B+YIp7s+sRzKb2ujbuPZ0ixJP50emsMaKTYC4nb/zyTGurSar86R+joU4dzSJXRxIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzUH0cTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578E5C16AAE;
	Tue, 18 Nov 2025 15:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763480981;
	bh=ItJZh4A8NGwbne8slv1wFuIEOw/1o50+xQTg0pOawOs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lzUH0cTsEHhk+Oyqvp0VXoqrDjqxA20tO9pPN7ezFvsACn6qFIJQZJzU8V/aJOPeL
	 TAkTkMrpSt2A4cd+J7NgRjusaPMMnmUCxOdotv5/YCnpkcLEmKnBwnRTE1FQPxKRZb
	 brQenRuRE8BFZg8V5UBq21cbYB6wJ86zNUPvGxrfdVyOgqQBMnGlIV6yzMjE/M/7Qv
	 k20sqAiD4BCn6JnC4QixzU01YtWcnWdvIVTxHF86xX8lrVDMFiRt87vSluYVwYRMmT
	 Y8HUSRZQIHQyvUNIUZmDqeyjchBg5ClYKOLN/f+Nb5MxP2yi3u3XAbFPsXqJdDfPtf
	 DmlA1Tlf3XXnA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:42 +0100
Subject: [PATCH DRAFT RFC UNTESTED 02/18] fs: anon_inodes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-2-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ItJZh4A8NGwbne8slv1wFuIEOw/1o50+xQTg0pOawOs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO07qmJ+4Ez1Lemb0kvktXhE5jB5z4rRYGkq6tuzi
 XVlKytjRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETi4xn+maoxTn3U/2PDdtec
 qzdWRTj843nX9P761N9qPirB/OVrfRn+p72UPvhUQPLoehndJvM1JXPKnxy5cF7OM1CgpaPqOlc
 XKwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/anon_inodes.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 180a458fc4f7..ab891cc84d2c 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -280,27 +280,13 @@ static int __anon_inode_getfd(const char *name,
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
+	FD_PREPARE(fdprep, flags,
+		   __anon_inode_getfile(name, fops, priv, flags,
+					context_inode, make_inode));
+	if (fd_prepare_failed(fdprep))
+		return fd_prepare_error(fdprep);
 
-err_put_unused_fd:
-	put_unused_fd(fd);
-	return error;
+	return fd_publish(fdprep);
 }
 
 /**

-- 
2.47.3


