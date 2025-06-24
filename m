Return-Path: <linux-fsdevel+bounces-52700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B27FAE5F55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEE74068FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25A525A357;
	Tue, 24 Jun 2025 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxrKTbG8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EE52580CA;
	Tue, 24 Jun 2025 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753782; cv=none; b=iPEgyO+5DOYY7dkEyGydD+V/LKwJXiGGQzaIqNuZf7bhLPP0YuB1L4jHoC4d4kdIEIx3wmmZg7r0qHsBMDe/tHdYwS/3pL32ayF0fY0edaEgvDYtUxJCE/uj30Wv2aGPMISK/Qy/NOwmHlilvG2h6wan7Ih91M4XLXn6lmGWDDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753782; c=relaxed/simple;
	bh=Hc3TRmXhULM3h3L+tzT/hGDoCeXvIUnhOOWQn7CK14Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OLOcUArEl2OiOIfZ/z2ReJcz5XlUa9VeDr4MIl1H0dQ2bYLREiNL0JzKFsc9JyNs96Dn/oAiqBWjGEEbgD5FfxwfQCwp+DBiKOCcTpClWS9zLwWe2ikAZtIywfnRwWuKUsvi2avJeQlXD4l/OigFd4zQlqR0YxdhtBmQCcnh9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxrKTbG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F47C4CEF2;
	Tue, 24 Jun 2025 08:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753781;
	bh=Hc3TRmXhULM3h3L+tzT/hGDoCeXvIUnhOOWQn7CK14Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kxrKTbG8UKkurfMkI939SJmlxYl4WVx3Rtv8WE5UohbX4MsJVKhtBOPXZ7k3wnrXf
	 ug5L80jlAzcf6jhIziGfTCztN6biuoADXnq7CFCRZmjgOyOEKA1sKhttm5ZPFB12Yn
	 yXh5yVrTUSJhSepzx8fOOK4dZ3uZfQTLTul/hxBKC0uRMoiZIV8EyV088TDTbxgTty
	 g56lfTGlkNJc8gcA+9XxGYMeS8lfJuPagXY9uhhrVku5kJxir/+s8BzR057aOrwTy8
	 t/UEqkzj3KCEH6ULpJZwiFLkBk8XdtXxqvT8nqoepXzHTsYEGeB98+OhmSgkZX/sTW
	 KmnGgAahqdkHg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Jun 2025 10:29:08 +0200
Subject: [PATCH v2 05/11] fhandle: reflow get_path_anchor()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-work-pidfs-fhandle-v2-5-d02a04858fe3@kernel.org>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
In-Reply-To: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Hc3TRmXhULM3h3L+tzT/hGDoCeXvIUnhOOWQn7CK14Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREJb5IeSG3fNPvqryXLIqv4/b/bYlxeGjJeMj1VHLHs
 ce6qactOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSq8bIMKlIYDMPm/xXLvON
 onXTkxgzAl/2T3jB/MkyVfo8t47XVoZ/Vq/+HHgdUZN01WrKs9Tkf3fWuJYrPNgw88ca5vUKCRp
 n+AA=
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


