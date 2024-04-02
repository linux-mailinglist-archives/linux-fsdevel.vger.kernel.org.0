Return-Path: <linux-fsdevel+bounces-15891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA59D89589C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 17:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD4B1F22606
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A96A1332A9;
	Tue,  2 Apr 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PI5xi3Zy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340C131751;
	Tue,  2 Apr 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072932; cv=none; b=ak8xXkgXcZ/FTMVu1OXoCc9x1oRXLO2oA6utX9s4XlL0Awwy0f+iJaeraVH+4u+dMt7QHOxvFc630OVMfA/O4Vqv6oGLNYKH4Yv2LeR68xMaAy+UYwq1k5TZO14QBYAkGFAkvYR2MnrI6DDR9gpgMpKnzg86EmG/H2z5CWJoVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072932; c=relaxed/simple;
	bh=3Q4sw2WXlvOL56uRd8hcDkbPNnR7p5wFvWwXppPSe2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b+Kc+m5Awuz4DZD5oX/vW9MOTHcGbDc4LDtRXzcI2AE1SyIrYHqp2ZW5umNe9Ps0U2l9c8MZsC8DEdNKH3Bu2xiv6N6J3PaufLYvFIiqqrUQET2gYygHQJJ7fnWSVBXHVQkPGrXrBvrMfLVoozCXOnazxpZrAWBAQVQGWYnEBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PI5xi3Zy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712072928;
	bh=3Q4sw2WXlvOL56uRd8hcDkbPNnR7p5wFvWwXppPSe2U=;
	h=From:To:Cc:Subject:Date:From;
	b=PI5xi3ZycfvN4c9ep2fl6zXkWItHP4JowiwSlBcekvXuv+387JU5aaViZoOZiQxcY
	 KXPq0fzMtqwFNcYQdmx41zEs70JREAPN9TUs3o5ozIszcmS6Bptwi9z1Lu3ATVk4B6
	 MgqN8T5PoAbXhyNwEEjSucXtOtesYNy4HFvq25d1k33pXfm+4xTfeGVjIjdIDj/FHL
	 jFq1RxQ8Ai4ME2kV0BdRjMYOj+NTmtDibf+zOL6QI0UMXJKGa4ZvIrlqZbMOdTWulW
	 D3vawV71c3/oRq6OGFlpOr5rS9fuXPBvGiXFyWz/8IMW6jovaYklSo9TN83IgZW1hR
	 8ukjO3YmuytlQ==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8ACDD3780C39;
	Tue,  2 Apr 2024 15:48:47 +0000 (UTC)
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
	krisman@suse.de
Subject: [PATCH v15 0/9] Cache insensitive cleanup for ext4/f2fs
Date: Tue,  2 Apr 2024 18:48:33 +0300
Message-Id: <20240402154842.508032-1-eugen.hristev@collabora.com>
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
I did changes as requested and here is v15.

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
 fs/f2fs/recovery.c |   5 +-
 fs/f2fs/super.c    |   8 +--
 fs/libfs.c         |  77 +++++++++++++++++++++++++++
 include/linux/fs.h |   4 ++
 11 files changed, 210 insertions(+), 196 deletions(-)

-- 
2.34.1


