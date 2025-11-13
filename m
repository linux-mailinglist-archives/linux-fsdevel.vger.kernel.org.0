Return-Path: <linux-fsdevel+bounces-68219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E04C5787E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 73C253552EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC9F35293A;
	Thu, 13 Nov 2025 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJfHQHZy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC580352958;
	Thu, 13 Nov 2025 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038955; cv=none; b=RQ83UYCYk+TzSRBaGKPyffxWG2UjTt0rMpLAPKbPqeCaG6e7u3Ro00KogUznqAQ9sX13nFYrY+tskntAQF32WRIqZtGIL2TsjHI585EXvi/PJqs2O4bbUiVohWlB9YKPEaLnedFav8a1JrNANxTuNFhEllxVjVko5v19LY5dres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038955; c=relaxed/simple;
	bh=UeehkHvvNTbaqgg+xShVplwguUOZZTEwr2y6Newl/4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MGvW4ZPQihRLUlwCB2a4Lz50AcGvr4Jrx4m6U3s6Y/oCnx8CU4L9Hui4AnfI2yJRvIC+RwrP1BnKMyrWe8kzO+7Smd2KoEyyz6nYf6dyN8YnkMzRLnvZcHUfkrEyXL0luLOyLlqlOeKrwuZRk/zCF+zAyzN6/aRgU0CySW/FXLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJfHQHZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1277BC116D0;
	Thu, 13 Nov 2025 13:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038954;
	bh=UeehkHvvNTbaqgg+xShVplwguUOZZTEwr2y6Newl/4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EJfHQHZyIrHqb4FTQclHHHeHeaq6eQZI80WfidimwFfg8NtX/yOv6CqS6+1hMIEKq
	 kbQJD8y9yUhuBxTvlulvroWqGzWFIOJSXZ1cWGGkCkB87Mz2sAV+22jNOoTN0rOOZz
	 L3cJ1y4X4UGo45Lgb9Lbbrq+9XEHkG1ciXWxEAXI6IW8vXb90J5U8fs3df95zpw7nx
	 kbNxAZZWE4C88hqyWm80RDZQ4P5/YjhA6S/f5RppgZsSJ5YsH9aQzZ4BNX8PQijn/a
	 PD+tvZNoByDQw59N9ScbrqW+oWQhhacKT/ZYU62v8ZCgMn9zJo09sGbZMOtEpoyIp/
	 +DDyhJEys6I1w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:22 +0100
Subject: [PATCH RFC 02/42] ovl: port ovl_copy_up_flags() to cred guards
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-2-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1230; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UeehkHvvNTbaqgg+xShVplwguUOZZTEwr2y6Newl/4w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnvU8NXh0seVkkr3ak6r3HAWdnJ4I7Kj9qrc/hqB9
 ieiUY8COkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZisIXhr9Sv0AOb2motJNp2
 GSjOW7siYXHl3KjVCuo2LwV3p/z5os/wV66uwJyDY/ntOy0mHzfNenB7wY9Jhl9WhX33e3H4LU/
 EHCYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/copy_up.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 604a82acd164..bb0231fc61fc 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -1214,7 +1214,6 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 {
 	int err = 0;
-	const struct cred *old_cred;
 	bool disconnected = (dentry->d_flags & DCACHE_DISCONNECTED);
 
 	/*
@@ -1234,7 +1233,6 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
 	while (!err) {
 		struct dentry *next;
 		struct dentry *parent = NULL;
@@ -1254,12 +1252,12 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 			next = parent;
 		}
 
-		err = ovl_copy_up_one(parent, next, flags);
+		with_ovl_creds(dentry->d_sb)
+			err = ovl_copy_up_one(parent, next, flags);
 
 		dput(parent);
 		dput(next);
 	}
-	ovl_revert_creds(old_cred);
 
 	return err;
 }

-- 
2.47.3


