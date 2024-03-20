Return-Path: <linux-fsdevel+bounces-14865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16072880D71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 09:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462F11C22747
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 08:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D967038394;
	Wed, 20 Mar 2024 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vgH8rb+F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBFB374C3;
	Wed, 20 Mar 2024 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924393; cv=none; b=JMSWw184Wcl4Stp7U69+23Fss1eSL00EAkslJbClFmb2WN6sftvrPBDdgkTVXikxRA4WPlOzzcy+RqNe6cZsEOHwsVEl/HXd+PYWwoa3fQatn39dIJiM1TyCieiRBA+yc7/nHwUBnzXRS3tzG7s/DUodwWDs1cRwoBzzMy3h7vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924393; c=relaxed/simple;
	bh=zuy5H3kjE6h+YGeQcgMBnZvub2JXu5ROBo/NuKBSpTY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i3if1AjIdlVWuFo7i+VuS/62zjBvTTD/JAo8OuwfXvj86Vk8lhLe4p91bhH+yaCb2S0uQkjXEOga7GHg6AKB+Z2Qs32sAIhE82Xz2qVvh6dXVqfYFb1Yal5T9MG+BV10qAI+hAprO8MG4pZUB2ujohC3NHowGMlS5Nn5ai/WUOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vgH8rb+F; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710924389;
	bh=zuy5H3kjE6h+YGeQcgMBnZvub2JXu5ROBo/NuKBSpTY=;
	h=From:To:Cc:Subject:Date:From;
	b=vgH8rb+FjmfT8b92uELhZxxMMc16iAIh1vH7pak+nAveO/uGoh2wwSvKMY4JUcyax
	 zVaA93BTka8+2Ko0QZwbUfNeJrYvUUFVgG7A4RsPSFHQU5sihe3bSO/sNwUbUMSxaz
	 xioOlpttkIABc4wtH9iBUJFe2Qe/trhMLxDcolDFrkPffH4bX9pyc/MTN1bDRa71QC
	 ZZhk34apxk+wa2yZJhHifXETYs5+fSV9xNLZLxi682jCcnJOsCJ/08GHCnYpSH54iC
	 vZfx2SfTsmkfq+463uIGCedWjrgRLdAdPO4ERU3FJb2u9uOf4HEZwkbBSm+iwbeup5
	 zzgbzpRot2/Yw==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3337C37820DE;
	Wed, 20 Mar 2024 08:46:27 +0000 (UTC)
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
Subject: [PATCH v14 0/9] Cache insensitive cleanup for ext4/f2fs
Date: Wed, 20 Mar 2024 10:46:13 +0200
Message-Id: <20240320084622.46643-1-eugen.hristev@collabora.com>
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
I did changes as requested and here is v14.

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

 fs/ext4/crypto.c   |  19 ++-----
 fs/ext4/ext4.h     |  35 +++++++-----
 fs/ext4/namei.c    | 129 ++++++++++++++++-----------------------------
 fs/ext4/super.c    |   4 +-
 fs/f2fs/dir.c      | 114 ++++++++++++++-------------------------
 fs/f2fs/f2fs.h     |  16 +++++-
 fs/f2fs/namei.c    |  10 ++--
 fs/f2fs/recovery.c |   5 +-
 fs/f2fs/super.c    |   8 +--
 fs/libfs.c         |  77 +++++++++++++++++++++++++++
 include/linux/fs.h |   4 ++
 11 files changed, 217 insertions(+), 204 deletions(-)

-- 
2.34.1


