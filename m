Return-Path: <linux-fsdevel+bounces-68380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B477C5A353
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70DC44F3277
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AC73277B1;
	Thu, 13 Nov 2025 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELPuQ1lS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1D1325700;
	Thu, 13 Nov 2025 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069574; cv=none; b=CdtYsNsxH0oFfBG9QRwarv+SZr1xdSB6e+4GxZ7xIEfQaVOD3nh+4FO/6lxS5JytShBZKe4ZuQsZuWoGx6i4SwhBi3ylEHGLTCuJ/fIbxZPrHFqSSeMfGScthme6BgRlNUa7j3KmvQewKycjdqDo/qbO6/3HBPQwwyiRuPvJFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069574; c=relaxed/simple;
	bh=x47wWXm0SAXLXjBdYUYX5UkIQZeYmHvPYN3XPLiGrjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eKoNAfO8CKTTy1cwqq1ATb9uodwlrC7nbMaijaKj3zXu5p11jdUXfbDlLqL6IKn6u1zTfzeMXtpn+ybBfMsCFovYXiANwSOjSIDmXrYqQAykQy9xHafNyayXkLf16h2Un533QTiREiPObQhS4RDrocAItsMedwocBau9Bw+J5j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELPuQ1lS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7B5C4CEF5;
	Thu, 13 Nov 2025 21:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069573;
	bh=x47wWXm0SAXLXjBdYUYX5UkIQZeYmHvPYN3XPLiGrjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ELPuQ1lSCzWTp4Ux3NUHFe+CQJ+p38zsZuMCwWYJPLC0CwPnq+AMa5yGhI6QnkfWg
	 35AfAMmURGKjVySrKupR325HC6KYhEJT4naUhtmfLkQFpE+o4eupVxSiChAwNs73uB
	 SPDE/eRRr+wIx/IJYpBNZKni7547G+LQ+N1j9K1p709YPG6Iwjl8Etx7xh+BehhjzJ
	 8qSh5Wk3iVz4sgjVNPglOrVtehlL/iCnKAC/c72p2x50NLRq0ILwdB0Bg9uKrHkq5P
	 WtC3jvI+40dIOqFA9xgg//AYP6+SEJBMFlS9QfmaZteVQBnSbbcsCwjoc1py40VK6O
	 ceSII7gybSBHA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:07 +0100
Subject: [PATCH v3 24/42] ovl: don't override credentials for
 ovl_check_whiteouts()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-work-ovl-cred-guard-v3-24-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2771; i=brauner@kernel.org;
 h=from:subject:message-id; bh=x47wWXm0SAXLXjBdYUYX5UkIQZeYmHvPYN3XPLiGrjE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YU7b53FvKn1u9HNwODvxw5+Eny1OWdSpU1GU5a6w
 +ma3mUTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZykJORYfrE4HePnt13D+OT
 Ovq+zEvXufOC1nv5ILOme4Z2wedEXjAyzGIUFl4szXlkU9PaDwUsbxbr919wU2B4fyJsok5/GPs
 7LgA=
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


