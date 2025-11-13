Return-Path: <linux-fsdevel+bounces-68325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 527B9C59251
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C550563BCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E4A368292;
	Thu, 13 Nov 2025 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvadlOWC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE1722A7E0;
	Thu, 13 Nov 2025 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051909; cv=none; b=hPPSVzAAuAn/apByY2jxI6jW+IdznI/P8gQA3547TBkTutilf9dDN8HxMXoTyq6cUxbcyYthqQhkRR1RlCyZhdEpCazwD3iF1PcK7s7giyUO+0a7t9yaKxBRT5VRns0raMyuFZhuN5+7qUnbU2mcEh9gApBag4hQIB8ixzZkgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051909; c=relaxed/simple;
	bh=kxc/34kQAyJLo9q3omEGto3SC3v5HpX/Ue7tk4m6IyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O9ty3qIiGn2TP8Ea2qWffm2lgCgYJsice488QLGSqnT/hXl53n/n1utIRgxUE/sGYLHC+J2+I8oUHtH4IQzn08MRxIuUjTulaaH3b50JLf+9a+2aepOhwOJrDdNJzptTX+69+a02RAYA6lvW+1mYzA3ltjt8/pmerQ3wKOjUB9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvadlOWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65E6C4CEF8;
	Thu, 13 Nov 2025 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051909;
	bh=kxc/34kQAyJLo9q3omEGto3SC3v5HpX/Ue7tk4m6IyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UvadlOWCrl6lVRFCZZRJrJu/6P0xT7ZbMj+IFtBOH8MDeweNIg0A0fhVkfCs1tymN
	 OTUC0wgwe5SmAw97uFMzsMomjjL74poJljpkwJQIF3ZxqCrYZMFn0GUhtj2c+htG2q
	 g5PCQneV87UONo04Ik8q553EzA/VfupZvhLX/uvsxcs2MXv0dZKHAeSrHv5538vtDK
	 3J7C05aiBhOn3CFeL/qv43g0z4lG3mNIqAjdzdQIuah/NOID7bBj8sap8KkUrULtQ2
	 lC966bgAJ8E6vOhxMKy4k3m7g4hLGa5vQSNazb+ojTh7MY0HB5050kt645uSgrn674
	 8IWOF1lU7clQw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:37 +0100
Subject: [PATCH v2 32/42] ovl: port ovl_listxattr() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-32-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=764; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kxc/34kQAyJLo9q3omEGto3SC3v5HpX/Ue7tk4m6IyI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbrfd+PZo7Jg56sL2gGPdE3bCxfx77S7uMRqTR1bI
 ttZqWnLOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCLcjwP4etzd/g+fTJFcr3
 mqfu8j/9gEclJs2aZfa/u1t3RrJkfmZkuMb3LvaypOQF11NzVpoan6tfdyagOiuv77yMV+T6kP4
 XjAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/xattrs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 788182fff3e0..aa95855c7023 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -109,12 +109,10 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 	ssize_t res;
 	size_t len;
 	char *s;
-	const struct cred *old_cred;
 	size_t prefix_len, name_len;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	with_ovl_creds(dentry->d_sb)
 		res = vfs_listxattr(realdentry, list, size);
-	ovl_revert_creds(old_cred);
 	if (res <= 0 || size == 0)
 		return res;
 

-- 
2.47.3


