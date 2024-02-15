Return-Path: <linux-fsdevel+bounces-11631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5AA8559B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 05:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F2F290D41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 04:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEA68F61;
	Thu, 15 Feb 2024 04:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OA/uhMmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039B3FC2;
	Thu, 15 Feb 2024 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707971235; cv=none; b=T6rjws5H/JRZhzi1PaUkDuPNndGA/26/IXE2K1NRxuyBRSQ1+excY0QiaZpf1BFr3zSDMwwL2p59pZv8cQGRwfpKKUyNaYKMEXshYtVOn5vZc+3VM9dbAdPrelfojOP5Q38/UDkV+VwyeIkuX6qiq1FBhXbemHmRSzVfqWkb5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707971235; c=relaxed/simple;
	bh=tQGS++QsKX4V8fgN6HgD2SBMUmY3q2X6YeBS6EZkOno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gtdbug1DHJURIRVt3dSIyiwUjFnaLr9Qqgnt6BF1POwAKedDJwRyzspOQt32DAEDeg+QDnkwLQlU/ebB7W/M1wQfBgwkMGz/wV5xoaQFsG18a17HiP87n07QxvkYG9LVbwIz+bAzZWHIcZAYvtEknXETII46n3xakhpkRGd/rtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OA/uhMmf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707971231;
	bh=tQGS++QsKX4V8fgN6HgD2SBMUmY3q2X6YeBS6EZkOno=;
	h=From:To:Cc:Subject:Date:From;
	b=OA/uhMmfKTb+Iz2xz+8XQR2v5h6L+UVZQd3uJ/aJB+/Y2G7zxsw41lsJwHgkYUm20
	 1enisnrGRX+sCrZ0FzJMYPtbpZ6xyXM0dQ/zZpf+8hdvFTF6MDPighQY8W3AilG+wt
	 /Uf9OG/SrI8symQsoYkI+g82DfiplKVd+Pf5SNPqq1Wgq3l7mmdrFudPTguKzyM1da
	 Sxlq5jFQjfClSpTtfdTBq0QeUEgS8GRyc2DjuZNx7Yae0Y1IgEt5LFqJWZ5dbHJXL2
	 fFtZa3YcmBF6OXsNQ+rKCvuQ7lTwJbq8isWaA3TKuOYRoMuP9ghCYfBFFrvTwxlFOb
	 cPjIQfJJFFf6A==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 157A3378203F;
	Thu, 15 Feb 2024 04:27:06 +0000 (UTC)
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
Subject: [PATCH v10 0/8] 
Date: Thu, 15 Feb 2024 06:26:46 +0200
Message-Id: <20240215042654.359210-1-eugen.hristev@collabora.com>
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
I did changes as requesteid and here is v10.

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
 fs/f2fs/dir.c      | 105 +++++++++++-------------------------
 fs/f2fs/f2fs.h     |  17 +++++-
 fs/f2fs/namei.c    |  10 ++--
 fs/f2fs/recovery.c |   5 +-
 fs/f2fs/super.c    |   8 +--
 fs/libfs.c         |  80 ++++++++++++++++++++++++++++
 include/linux/fs.h |   4 ++
 11 files changed, 211 insertions(+), 205 deletions(-)

-- 
2.34.1


