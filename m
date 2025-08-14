Return-Path: <linux-fsdevel+bounces-57932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD70B26D8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 19:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C037AA52A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EC82FCC1B;
	Thu, 14 Aug 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="opJpljK7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC410233722;
	Thu, 14 Aug 2025 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192154; cv=none; b=Q4aa+j8WxqsU4cGAj7zwoGlVeOxWKiEEwQf7rzbQsA6AAsKQ/ijVoMdmG09POJk42fCfthIsx6S3hv2I7I2NWHPfJEm8Hqt/7K9O75EgBFMbE0hPfOCt1XDV1Vjw6G+GugFkw+x7HF2VJI/fOkbM6rcA7UcLsv77cfaz8JdKNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192154; c=relaxed/simple;
	bh=UzPGXxWtSLl6dkMZ/OxsArS5sqWjErOD9GoboqA0IMU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o+QRy1HFLuQjRSQD8OG69q621b6dzZTjX1zSvUuJtcjc2QWxGtkvk6MX/r5JZHuJIkPskbtPsZjuGUDkuJD7gtrVPG8RkXi4QlJV/kcmskVcAe/g8qorQt42JZGh2MMZCDzjk3FSX+jA1HNEQFOPPqknajNiCRre8Hgs29cMa8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=opJpljK7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7B4MWsEAjG9JgxSLiy4JzuaRiaP4gSjgkoVCn/un/Lw=; b=opJpljK7e16zjbg9GQgbSo08pi
	8jVL1emdv9pEl69Gy0Kgcwxse3dYToJk+bHwAkCISZ1E0XvgQgQ7J8S59abaFMSys/1JwmGgzXU3o
	14GcLEW9DeAGv9ES1FCgV/rP3h1hupgohYGeKTZ56NuqMo02yHN+RZDheACbQp2G3a2+PtQPuc4FL
	rYUEMfZxxIm630Jfcb8q8z60axRexiUpOIB+xu6T66X0T8zwpFk1/nAFYdCAt5jnY9xHqj7/fZHxu
	jRdwbRyYfURjLLDIa14UQWwUw1JMlc4tAj/c9VlgJoHKQliO4Sc+bdYHrPZTiu5bgr1w9RNltgWYS
	wqGZpEhA==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umbef-00EDyT-8e; Thu, 14 Aug 2025 19:22:21 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 0/9] ovl: Enable support for casefold layers
Date: Thu, 14 Aug 2025 14:22:11 -0300
Message-Id: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEMbnmgC/3XOzQ7CIAzA8VcxnMVQPubw5HsYD3UrStRhwBAXs
 3eXeVFDPP6b9Nc+WaLoKbHN4skiZZ98GEqY5YJ1JxyOxH1fmkkhjdDC8nsYxjMPmeIFR5e4seA
 M6V6LNbKydYvk/OMt7valTz7dQxzfBzLM0/9WBi64shYaaBxZVFt/xIvHVReubMay/ACtMDUgC
 yDIaNlCjwraClDfQFsDav5AOHsgLZsD1oD+AkDVgJ4Bs+46Jwkk9j/ANE0vgdR0RHIBAAA=
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
 fs/overlayfs/dir.c       |   6 +++
 fs/overlayfs/inode.c     |   1 +
 fs/overlayfs/namei.c     |  17 +++----
 fs/overlayfs/overlayfs.h |   8 ++--
 fs/overlayfs/ovl_entry.h |   1 +
 fs/overlayfs/params.c    |  15 +++++--
 fs/overlayfs/params.h    |   1 +
 fs/overlayfs/readdir.c   | 115 +++++++++++++++++++++++++++++++++++++++--------
 fs/overlayfs/super.c     |  51 +++++++++++++++++++++
 fs/overlayfs/util.c      |   8 ++--
 include/linux/fs.h       |  27 ++++++++++-
 12 files changed, 213 insertions(+), 39 deletions(-)
---
base-commit: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
change-id: 20250409-tonyk-overlayfs-591f5e4d407a

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


