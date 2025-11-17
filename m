Return-Path: <linux-fsdevel+bounces-68667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BCBC63499
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 439C64F0CAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C799932D7C8;
	Mon, 17 Nov 2025 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1xcfgh6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264E1329C5E;
	Mon, 17 Nov 2025 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372068; cv=none; b=ns2KSEyQV7B2Vngz4SwrP+IihknH7Lr5wvOiD8JqqxPGHaQU0lqHEk8lbUKYDK61aec3Cur52/3mSIHJTBaPt19Xr6ngesClgm3jKNPUyB2QDkdIwphDYjD8i+0TolkJzJoaBcCMMJE9+a1UM9SWN0juuqj/jMysyV8VRap1/Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372068; c=relaxed/simple;
	bh=x47wWXm0SAXLXjBdYUYX5UkIQZeYmHvPYN3XPLiGrjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aFfSjyrWb3FvObiALFTNJj2ZCMNOC6A39DNP/cF1KU2WybLGaaeWxzeGqWWfvUz9PqAPcko/g/WfMs8mtfA8h063NHmAS6H7zWTk6Y1G7KZ4KiCtzwpt56OhnMgUj69qPs2fAK0AetihTgX539ZdCCstloELqhfasuJzmOabScQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1xcfgh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21B1C4CEF1;
	Mon, 17 Nov 2025 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372068;
	bh=x47wWXm0SAXLXjBdYUYX5UkIQZeYmHvPYN3XPLiGrjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G1xcfgh6gEuoKnSxYhieOA9DxX+j5ee8/SzvgP0PKsB2kosuYpAIgam9VKiRL0QKL
	 9NgsNn7UglZmrmUMRJ/Sn/KpC3zO3UUFY+kKmvKelyGzGSLSTVTM1fGynHDeEIoavt
	 heQhOV3TxN2Haf1jYcRQnPMWmLGmVtSPki29mn9nXmFGe7K+zu8u8NGpjHgmkCnu/l
	 F7TaNBEfXWrm2VZdRSXLuRqUyv2VO4gz0m/RB/yNDyB1W+llWHFl7KioZEr1gu9Ji1
	 dMFu/1fLdpF5wtO+Z6zZ2fREuHiMeOnc9aPMRVSMKZr0EvfPRRuVIKSF+VrE/9Va1U
	 r0OLhpD29Uybg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:55 +0100
Subject: [PATCH v4 24/42] ovl: don't override credentials for
 ovl_check_whiteouts()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251117-work-ovl-cred-guard-v4-24-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2771; i=brauner@kernel.org;
 h=from:subject:message-id; bh=x47wWXm0SAXLXjBdYUYX5UkIQZeYmHvPYN3XPLiGrjE=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGka6/XIrQEhmDc3bNi9c3ZXMDe9wToYhsLS0nPSnWYfAeoyk
 Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmka6/UACgkQkcYbwGV43KI2XAEAu0KG
 c6LjVwdHyFFNzH3iGwmiQ3/B4K64u4j2qZWbqoAA+QFC1gb5GNOFImr2cu3UAQ6mBNIUze9dCkV
 n6WxjLGwD
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The function is only called when rdd->dentry is non-NULL:

if (!err && rdd->first_maybe_whiteout && rdd->dentry)
    err = ovl_check_whiteouts(realpath, rdd);

| Caller                        | Sets rdd->dentry? | Can call ovl_check_whiteouts()? |
|-------------------------------|-------------------|---------------------------------|
| ovl_dir_read_merged()         | ✓ Yes (line 430)  | ✓ YES                           |
| ovl_dir_read_impure()         | ✗ No              | ✗ NO                            |
| ovl_check_d_type_supported()  | ✗ No              | ✗ NO                            |
| ovl_workdir_cleanup_recurse() | ✗ No              | ✗ NO                            |
| ovl_indexdir_cleanup()        | ✗ No              | ✗ NO                            |

VFS layer (.iterate_shared file operation)
  → ovl_iterate()
      [CRED OVERRIDE]
      → ovl_cache_get()
          → ovl_dir_read_merged()
              → ovl_dir_read()
                  → ovl_check_whiteouts()
      [CRED REVERT]

ovl_unlink()
  → ovl_do_remove()
      → ovl_check_empty_dir()
          [CRED OVERRIDE]
          → ovl_dir_read_merged()
              → ovl_dir_read()
                  → ovl_check_whiteouts()
          [CRED REVERT]

ovl_rename()
  → ovl_check_empty_dir()
      [CRED OVERRIDE]
      → ovl_dir_read_merged()
          → ovl_dir_read()
              → ovl_check_whiteouts()
      [CRED REVERT]

All valid callchains already override credentials so drop the override.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/readdir.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 1e9792cc557b..12f0bb1480d7 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -348,11 +348,7 @@ static bool ovl_fill_merge(struct dir_context *ctx, const char *name,
 
 static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data *rdd)
 {
-	int err = 0;
 	struct dentry *dentry, *dir = path->dentry;
-	const struct cred *old_cred;
-
-	old_cred = ovl_override_creds(rdd->dentry->d_sb);
 
 	while (rdd->first_maybe_whiteout) {
 		struct ovl_cache_entry *p =
@@ -365,13 +361,11 @@ static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data
 			p->is_whiteout = ovl_is_whiteout(dentry);
 			dput(dentry);
 		} else if (PTR_ERR(dentry) == -EINTR) {
-			err = -EINTR;
-			break;
+			return -EINTR;
 		}
 	}
-	ovl_revert_creds(old_cred);
 
-	return err;
+	return 0;
 }
 
 static inline int ovl_dir_read(const struct path *realpath,

-- 
2.47.3


