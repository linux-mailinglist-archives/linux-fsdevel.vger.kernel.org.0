Return-Path: <linux-fsdevel+bounces-58815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A495B31B36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467933BC831
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FA0305E0C;
	Fri, 22 Aug 2025 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pRjWWfv5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B559D2D7DC1;
	Fri, 22 Aug 2025 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872243; cv=none; b=Bia7JM+2zlCvKJ2om4fUSJZcvNL6IbtuJxVGyQKLf/jK1DpZeS+wPYLp06DGgHqYq8KeuJ/rpCHHbKUsVo6ZF9F9dGjiZq99S2k5mq1DPl5maTNIlBMlLID1T0TPh+t1zDJl00BAzfuQechirFMpFa3HqCHqjG9a3UIQqyeyRoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872243; c=relaxed/simple;
	bh=W/ysbPNXe11SC7kv7ZEq98YT9giZAAu8j9o/5LDhClY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aF0BST4PtKsrsU7I1vU4mbxie6yO2wNBMTpjg3lPnN64OZduGlISwlZ99Gqirm6yphrozAP7A3DOGKgRIsdyGF2za7tXjQJSwdDbfwTwvX0Ybj6nbF3BLGLmck6uFA0sqpcbOJA79/58ZtbQqIdiqeYAydNfn3Lg9PGYfxrTm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pRjWWfv5; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5bOxD2Wqy5HeOygP2zNQvO+EIdXg5Q08XFx0iUAK7tg=; b=pRjWWfv5OD8VJ4S0raXIKNiosm
	oWiU54uyMW4GlLJDzg7LLlzYT7Po65+Dp2553jBgkYZ8cI6UU/JXKn9bOXVm+L2f2JydkHHtSjKOA
	mpwCt40umOunPBahzwm90yq6s4W7O6acW5jv6PbxYzXyRXYGqsIfooZDJZ9lfq4NpmFU0RT0vhani
	eE1wunCjIEu/Ggdc3wtommTFTsImRTexHb/f/GEhAI7VIQ7T2XqzIOG9giaWsffCB2oyjhP4XZp3W
	wenw2moDEaI1My44AG+61OQiyyEfDe+4oaZJmmmvpiYXdg07litCphh9olyQ+fbpvoctF93ZNxPv7
	lgCSCTrg==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1upSZv-0008Fn-HP; Fri, 22 Aug 2025 16:17:15 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v6 0/9] ovl: Enable support for casefold layers
Date: Fri, 22 Aug 2025 11:17:03 -0300
Message-Id: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN97qGgC/3XOzW7DIAzA8VepOI/JfKWw095j6sEhpkXrwgQVa
 lTl3Ud6WSa049+Sf/aDFcqRCns7PFimGktMc4vh5cD8Becz8Ti1ZhKkAQ2O39K8fPJUKV9xCYU
 bJ4IhPWk4Imtb35lCvD/Fj1PrSyy3lJfngSq26f9WFRy4ck4MYgjkUL3HM14jvvr0xTasyl/Ag
 ukB2QAgo6UVEyphO0DtAdsDavsAghtJy2HEHtA7QKge0Btgjt4HSULi1AFmD+geMA3wZrSADpw
 f/wLruv4ANFkdd7MBAAA=
X-Change-ID: 20250409-tonyk-overlayfs-591f5e4d407a
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Hi all,

We would like to support the usage of casefold layers with overlayfs to
be used with container tools. This use case requires a simple setup,
where every layer will have the same encoding setting (i.e. Unicode
version and flags), using one upper and one lower layer.

* Implementation

When merge layers, ovl uses a red-black tree to check if a given dentry
name from a lower layers already exists in the upper layer. For merging
case-insensitive names, we need to store then in tree casefolded.
However, when displaying to the user the dentry name, we need to respect
the name chosen when the file was created (e.g. Picture.PNG, instead of
picture.png). To achieve this, I create a new field for cache entries
that stores the casefolded names and a function ovl_strcmp() that uses
this name for searching the rb_tree. For composing the layer, ovl uses
the original name, keeping it consistency with whatever name the user
created.

The rest of the patches are mostly for checking if casefold is being
consistently used across the layers and dropping the mount restrictions
that prevented case-insensitive filesystems to be mounted.

Thanks for the feedback!

---
Changes in v6:
- Change pr_warn_ratelimited() message for ovl_create_real()
- Fixed kernel bot warning: "unused variable 'ofs'"
- Last version was using `strncmp(... tmp->len)` which was causing
  xfstests regressions. It should be `strncmp(... len)`.
- Use c_len for tree operation: (cmp < 0 || len < tmp->c_len)
- Remove needless kfree(cf_name)
- Fix mounting layers without casefold enabled in ovl_dentry_weird()
v5: https://lore.kernel.org/r/20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com

Changes in v5:
- Reordered commits. libfs commits come earlier in the series
- First ovl commit just prepare and create ofs->casefold. The proper
  enablement is done in the last commit
- Rework ovl_casefold() consumer/free buffer logic out to the caller
- Replace `const char *aux` with `const char *c_name`
- Add pr_warn_ratelimited() for ovl_create_real() error
- Replace "filesystems" with "layers" in the commit messages
- Add "Testing" section to cover letter
v4: https://lore.kernel.org/r/20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com

Changes in v4:
- Split patch "ovl: Support case-insensitive lookup" and move patch that
  creates ofs->casefold to the begging of the series
- Merge patch "Store casefold name..." and "Create ovl_casefold()..."
- Make encoding restrictions apply just when casefold is enabled
- Rework set_d_op() with new helper
- Set encoding and encoding flags inside of ovl_get_layers()
- Rework how inode flags are set and checked
v3: https://lore.kernel.org/r/20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com

Changes in v3:
- Rebased on top of vfs-6.18.misc branch
- Added more guards for casefolding things inside of IS_ENABLED(UNICODE)
- Refactor the strncmp() patch to do a single kmalloc() per rb_tree operation
- Instead of casefolding the cache entry name everytime per strncmp(),
  casefold it once and reuse it for every strncmp().
- Created ovl_dentry_ci_operations to not override dentry ops set by
  ovl_dentry_operations
- Instead of setting encoding just when there's a upper layer, set it
  for any first layer (ofs->fs[0].sb), regardless of it being upper or
  not.
- Rewrote the patch that set inode flags
- Check if every dentry is consistent with the root dentry regarding
  casefold
v2: https://lore.kernel.org/r/20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com

Changes in v2:
- Almost a full rewritten from the v1.
v1: https://lore.kernel.org/lkml/20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com/

---
André Almeida (9):
      fs: Create sb_encoding() helper
      fs: Create sb_same_encoding() helper
      ovl: Prepare for mounting case-insensitive enabled layers
      ovl: Create ovl_casefold() to support casefolded strncmp()
      ovl: Ensure that all layers have the same encoding
      ovl: Set case-insensitive dentry operations for ovl sb
      ovl: Add S_CASEFOLD as part of the inode flag to be copied
      ovl: Check for casefold consistency when creating new dentries
      ovl: Support mounting case-insensitive enabled layers

 fs/overlayfs/copy_up.c   |   2 +-
 fs/overlayfs/dir.c       |   7 +++
 fs/overlayfs/inode.c     |   1 +
 fs/overlayfs/namei.c     |  17 +++----
 fs/overlayfs/overlayfs.h |   8 ++--
 fs/overlayfs/ovl_entry.h |   1 +
 fs/overlayfs/params.c    |  15 +++++--
 fs/overlayfs/params.h    |   1 +
 fs/overlayfs/readdir.c   | 113 +++++++++++++++++++++++++++++++++++++++--------
 fs/overlayfs/super.c     |  51 +++++++++++++++++++++
 fs/overlayfs/util.c      |  10 +++--
 include/linux/fs.h       |  27 ++++++++++-
 12 files changed, 213 insertions(+), 40 deletions(-)
---
base-commit: 3b7f28e441a100531fa9eff20e011a42376ca7d5
change-id: 20250409-tonyk-overlayfs-591f5e4d407a

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


