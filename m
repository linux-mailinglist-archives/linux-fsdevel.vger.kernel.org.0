Return-Path: <linux-fsdevel+bounces-16181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163BC899C90
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 14:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A7D1C230A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D736D16D303;
	Fri,  5 Apr 2024 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iGQlbNEX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F516C852;
	Fri,  5 Apr 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319246; cv=none; b=EEVmpaEaLYXwOBQ3gGfREdaVG15ZLNzUQnVmT/T6+TLLegeWoGqByd4e56RCzU+acf76neD4Sf9cE0uf5Bc5TDr1s36FzRHsj6wFLzixRUepmxtqUxOU0646J47mgwwFK3z6dQgItxB/TFTWMsm/2j5/MgZxwuaTGzcY5tZ0lmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319246; c=relaxed/simple;
	bh=2daGheRm0uXiCuDJJyljgieXxs67abLqxPGSfK/8mhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z3436wa33JnilVM5CvHnZY9hfkakcPpFCu4hGezuQd67LjpbAhQ89gEH07Pl8Yq4n5kvfxLRr5iv3YiUv3JiXoVkA3xlIT+c5ZSVtMGJwNeQ3hHehoC1P0Xuz4q1/keh/wei4CLRmVCyMNW76SjVJTopCNtBoYOc2o3SwNOt3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iGQlbNEX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712319241;
	bh=2daGheRm0uXiCuDJJyljgieXxs67abLqxPGSfK/8mhY=;
	h=From:To:Cc:Subject:Date:From;
	b=iGQlbNEXxP5v0qaD7xtPldYxUHkT7lbfQj62HSkTccTr/2WeJpRCxCD9/BthkOzRG
	 TgUbetxkDo9pLtb1hPSYsn83K/1KKkKKQRBpReW5EKnNyFIoLkEScDzlkTRA1UJ9Mr
	 DWVKUHEB/zobSNALpWsyvoxlQlJvsUun0VxtF1VAOcbj8IMMFhhrI9l2aX6Zjy6xuK
	 jH7YA9ygISpfpa8rWriqCfj2Y4jcLxMqRxy8YKdB7yYqc/MYo9vsdpOdR/A1OSHRip
	 SjvKLvx/R57WKy8poxdO8+TeszWDZcMUcF4YNi1PUeivj/XQfeCvlXTnWjl0F7/gks
	 KQoNRs0F1K3QQ==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2DF77378212E;
	Fri,  5 Apr 2024 12:14:00 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	eugen.hristev@collabora.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	krisman@suse.de,
	ebiggers@kernel.org
Subject: [PATCH v16 0/9] Cache insensitive cleanup for ext4/f2fs
Date: Fri,  5 Apr 2024 15:13:23 +0300
Message-Id: <20240405121332.689228-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I am trying to respin the series here :
https://www.spinics.net/lists/linux-ext4/msg85081.html

I resent some of the v9 patches and got some reviews from Gabriel,
I did changes as requested and here is v16.

Changes in v16:
- rewrote patch 2/9 without `match`
- changed to return value in generic_ci_match coming from utf8 compare only in
strict mode.
- changed f2fs_warn to *_ratelimited in 7/9
- removed the declaration of f2fs_cf_name_slab in recovery.c as it's no longer
needed.

Changes in v15:
- fix wrong check `ret<0` in 7/9
- fix memleak reintroduced in 8/9

Changes in v14:
- fix wrong kfree unchecked call
- changed the return code in 3/8

Changes in v13:
- removed stray wrong line in 2/8
- removed old R-b as it's too long since they were given
- removed check for null buff in 2/8
- added new patch `f2fs: Log error when lookup of encoded dentry fails` as suggested
- rebased on unicode.git for-next branch

Changes in v12:
- revert to v10 comparison with propagating the error code from utf comparison

Changes in v11:
- revert to the original v9 implementation for the comparison helper.

Changes in v10:
- reworked a bit the comparison helper to improve performance by
first performing the exact lookup.


* Original commit letter

The case-insensitive implementations in f2fs and ext4 have quite a bit
of duplicated code.  This series simplifies the ext4 version, with the
goal of extracting ext4_ci_compare into a helper library that can be
used by both filesystems.  It also reduces the clutter from many
codeguards for CONFIG_UNICODE; as requested by Linus, they are part of
the codeflow now.

While there, I noticed we can leverage the utf8 functions to detect
encoded names that are corrupted in the filesystem. Therefore, it also
adds an ext4 error on that scenario, to mark the filesystem as
corrupted.

This series survived passes of xfstests -g quick.

Eugen Hristev (1):
  f2fs: Log error when lookup of encoded dentry fails

Gabriel Krisman Bertazi (8):
  ext4: Simplify the handling of cached insensitive names
  f2fs: Simplify the handling of cached insensitive names
  libfs: Introduce case-insensitive string comparison helper
  ext4: Reuse generic_ci_match for ci comparisons
  f2fs: Reuse generic_ci_match for ci comparisons
  ext4: Log error when lookup of encoded dentry fails
  ext4: Move CONFIG_UNICODE defguards into the code flow
  f2fs: Move CONFIG_UNICODE defguards into the code flow

 fs/ext4/crypto.c   |  10 +---
 fs/ext4/ext4.h     |  35 +++++++-----
 fs/ext4/namei.c    | 129 ++++++++++++++++-----------------------------
 fs/ext4/super.c    |   4 +-
 fs/f2fs/dir.c      | 108 ++++++++++++-------------------------
 fs/f2fs/f2fs.h     |  16 +++++-
 fs/f2fs/namei.c    |  10 ++--
 fs/f2fs/recovery.c |   9 +---
 fs/f2fs/super.c    |   8 +--
 fs/libfs.c         |  73 +++++++++++++++++++++++++
 include/linux/fs.h |   4 ++
 11 files changed, 206 insertions(+), 200 deletions(-)

-- 
2.34.1


