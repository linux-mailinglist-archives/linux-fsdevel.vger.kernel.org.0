Return-Path: <linux-fsdevel+bounces-68317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B8EC58EF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCF5427526
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F42368267;
	Thu, 13 Nov 2025 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnjBYVkj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84B2F5316;
	Thu, 13 Nov 2025 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051894; cv=none; b=o3wjzTDcE4hFzzoMQ6s+nSxL2FH0+fFlWKOWDbcFjOoqJp1GT4hhLyCkwLde7VTfdwLMTvsJ2eM8oaE1Ik0kCmV90ueR0qvixtiHBfPKSrCMV4RQ4RUYRgdAMbNulfYAIGIO3aEI+TRb4Suu5AkPwgM4H8j8Xk1xVwgFVJMOnT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051894; c=relaxed/simple;
	bh=oLWJCOoirB81PvWPQsj4tHBL9mWmJKgCn7/tar7A83U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AEkJwv5p+fj0OvI5h7AdXuKmVLDstTCtFM6NXajPAKdo4GYcNCG6oMDZVu1zPdXW4xhrMQ1dl1DhbSu8uWFZ8VckmSxaodaa4OavrrnQ/p3AYyIUEFqlN9g2Bk4f8pHaq59HWL8vcdEqVRiTwXBvNqHYPUn40357gLWaFWWFjzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnjBYVkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B4FC4CEF1;
	Thu, 13 Nov 2025 16:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051894;
	bh=oLWJCOoirB81PvWPQsj4tHBL9mWmJKgCn7/tar7A83U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tnjBYVkjqYwiLbDq6BRkWz51BFK3Qd+j/ctU5iGSxGFmaC9TNsKXkV+Gh7/EYi8sR
	 Vbez/M1cXRDBAz1WuIODF9/efRrFMqechs7aIyPcjXkoLc5j3tlICJPr4MAfVkQuzD
	 IQtPfaXlFn7uxD4DxeVmEn4ax0gaSHcR+pX1qq8uInGoHK9n97HiaqyFP0XnPSuyxC
	 OaflI6Mslrp9GKs7g1tPifB/4gTBdwL/IT/Z404W2ifJn7OvaAZsRS6YLPPSDGc5tf
	 /E+F7HquQOeiQK6ZYLV7nv+cZM3Ks933EL6wwazkTfQfzwlkSUBtutYhD/Bm6I3PH9
	 gmvRQ7cN97zbg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:29 +0100
Subject: [PATCH v2 24/42] ovl: don't override credentials for
 ovl_check_whiteouts()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-work-ovl-cred-guard-v2-24-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2721; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oLWJCOoirB81PvWPQsj4tHBL9mWmJKgCn7/tar7A83U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbo5aJl41k56+FVdaSPnpRiua7k9gsJMJdeTLr3eE
 euc+SWgo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCItTgz/nc5kVy26deWP0NRe
 5aw/Sg/cb5+yPeG3Ncr186UFWRK9WxgZfhn+KRPdcyz1k62rbbLVDav/Jgt/7gs+LLKnu2Ghkpk
 SBwA=
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


