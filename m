Return-Path: <linux-fsdevel+bounces-52698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB884AE5F50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0088D161DA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E0C25A349;
	Tue, 24 Jun 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBNRlSwC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED5259CBB;
	Tue, 24 Jun 2025 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753780; cv=none; b=ZoKv/N2emNyA1zoMzUbMGflsoENxT3KWMmw4JgqfanwYcHEmSlBKNztZzfp3HejqE6PoAE279FXTiqZYFBddX5mqP09fBdUMWiKO7x1c9aPN/W5hRzwbiMQGvPSBX+wAeTrj164UcuNtYGduzG1NFJ1wBojJzZW7HdSMclQr9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753780; c=relaxed/simple;
	bh=nqx0NXJEaqMSklZtswxe5+5ca0D36szeZ9yYydMDAvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mDu04HyJDhygn7Gof0c0s026Sr73+Dl/li+WVgIHn1vj4gOyv6DtxE6+OkHyiehHxHK04+c8Stzb8cVpvrO14KIwDAxBVMWPo3+qRBMeBqeWm4LqFpAYNIdHrYJ4X+cdZIX952NW/8vPvLXU5tDkEjcMfPt9++x04H7ZsICk4Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBNRlSwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7C6C4CEF1;
	Tue, 24 Jun 2025 08:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753777;
	bh=nqx0NXJEaqMSklZtswxe5+5ca0D36szeZ9yYydMDAvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UBNRlSwCwqUq75IKmhLn1WA3OfJOXPOcMZrQCXcAceuKFXoKROT0+w2MidM3yi/Y8
	 a1K9HkBt0pgcR1q3Dx/7pCp+yJx9EvLYVGn+BWu6ar3SH8wNNiBx/tipgdxKW19Mwr
	 Jge9VFo564VRxb2Ji/HTjveoCQxVRjBV2VyF8DHkvwVcBzlaPbitqXqe3BZP1BWF1W
	 ugpH6VatHjA3rnwJ3AWYmwjYzl8W0AOtpUF7ERtgjz2Rc9tS59a3Cg6uxu/vWEC4fQ
	 iYKYK8Wkp5wIO/pX+BH43xziuu+HL6ALQFMyHU1rM2aYsoQDFVYfPZqdDGLUYs6TVA
	 GV2d/76yRsBlA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Jun 2025 10:29:06 +0200
Subject: [PATCH v2 03/11] fhandle: rename to get_path_anchor()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-work-pidfs-fhandle-v2-3-d02a04858fe3@kernel.org>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
In-Reply-To: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nqx0NXJEaqMSklZtswxe5+5ca0D36szeZ9yYydMDAvA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREJb7Ivjq155117OsTEhsXv+5denvbZZbdV74aTvjGn
 qdtPHGfckcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEFlUx/FN4EutzafPfnZ4d
 +1od2N0mLpWVs5/L+Nbrx1uXPRd+l+UwMuyU27TPTCjTf2Ivv99CH+WX2Qc9PlSXRl5y6nacesa
 mkxUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rename as we're going to expand the function in the next step. The path
just serves as the anchor tying the decoding to the filesystem.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 73f56f8e7d5d..d8d32208c621 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -168,7 +168,7 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
 	return err;
 }
 
-static int get_path_from_fd(int fd, struct path *root)
+static int get_path_anchor(int fd, struct path *root)
 {
 	if (fd == AT_FDCWD) {
 		struct fs_struct *fs = current->fs;
@@ -338,7 +338,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	    FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_USER_FLAGS)
 		return -EINVAL;
 
-	retval = get_path_from_fd(mountdirfd, &ctx.root);
+	retval = get_path_anchor(mountdirfd, &ctx.root);
 	if (retval)
 		return retval;
 

-- 
2.47.2


