Return-Path: <linux-fsdevel+bounces-52499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9C9AE394B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FDAB174840
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 09:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C4B231848;
	Mon, 23 Jun 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRxt/xcy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5A23371F;
	Mon, 23 Jun 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669303; cv=none; b=LhBLoxezdIq9K/BKnsyo/sljOXLTmeqNfAxazlWUZlH0N4EplUJ97Xvv6xJ9or5LL34DwZNIBMriRiPlJeSV1L8ENLj0t0PNzAW1oJQtNPe5okJ9nWiRFZIZ4+OJR8xk0/6qEjYusHrptFFKXoiHUeyNClCdB8fmWKo4xDhjhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669303; c=relaxed/simple;
	bh=nqx0NXJEaqMSklZtswxe5+5ca0D36szeZ9yYydMDAvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZN3BN7wHWzxRN0sxYaH9J+DdyaIuHKRhmTZWoQ7CBahLXFgbgax4a2Zr6J1h4obzhuPd/e3NK+i+SkPp6+q9QZ302Ev5wIyUgB/Q3McrofdyK5IZqXtbaa0fry9iGomMDIW9R9OJa3bB11turS+Onk4lvla4h+uhePUNki7exI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRxt/xcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2D8C4CEED;
	Mon, 23 Jun 2025 09:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750669302;
	bh=nqx0NXJEaqMSklZtswxe5+5ca0D36szeZ9yYydMDAvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sRxt/xcyAT4cAPdZtTQRVHf/VbNGWmMYnaWGvPPzS6u63tIW+HOcMejbvaUTKBQSm
	 Dc1IjEQacOvx+mygJ1ZPTta5CIO6iJHNWWtUSMcl9dyntdkzvY8VQxkS0484DPMS6Z
	 qgbq1dHNGlDaR3B306Dha3ud5Pkzo/HhnsaQnRZ231uPMoD5c5UPOc6FtvyrYnUSLk
	 jdpnsVJAWRm41VePbM08Ouyae148uIPGYm9GcvrNdtldcHInZMBsmZmr2gri/7s8/F
	 jhVBj3jjq8R71JEE6h+oHOKv6vBReF60S0DjnvpyKjWJ699hWnWNTug4lciSMcLPYJ
	 U7FwKkqkkRdkw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Jun 2025 11:01:25 +0200
Subject: [PATCH 3/9] fhandle: rename to get_path_anchor()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-work-pidfs-fhandle-v1-3-75899d67555f@kernel.org>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
In-Reply-To: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nqx0NXJEaqMSklZtswxe5+5ca0D36szeZ9yYydMDAvA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREir/e+WhDbb/Plin1FjUnuZuNj0iGp+SmLphbtv77g
 csPlyjf6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI6S2Gf/Yen93muYc42Urd
 7bGwWF7UmbB8xhxBp07V6zs/PdCespXhf+l8ob7zy65Gca7q8Ji3S5VZec3qhn8zjpm/XyHwwq1
 biB0A
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


