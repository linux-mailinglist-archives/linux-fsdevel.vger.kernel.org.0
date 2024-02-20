Return-Path: <linux-fsdevel+bounces-12115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCC185B618
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF49F1C20C16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 08:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D575F54D;
	Tue, 20 Feb 2024 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="agU7DtJt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB8B5F47B;
	Tue, 20 Feb 2024 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419171; cv=none; b=t3RUdGTz1ewVYxPvtkrXQUCsA42dC/yt2FjrwTSWAqHFPASt7SCyvLCcnH60BGrjrNr67CIYRFM/UOXQn1Ky2MBHANM6ula4oe6Mglro++dq/sJBgem02lyHpWMFdO5cFlpE9MVOovcfL85Ysqv6PGq+4hYNjFbhTggkAcGBWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419171; c=relaxed/simple;
	bh=GJYdAbM7ewpjFdjHz6ASYR5VJQe0AeyNeMR8SotvnjM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k+30sM2GIdFoW4HgisvDinpj2JecY3mPZ6pifInhMoiqwK3ZrEoJJKERa4BxtGa2OEQMivqHmZuGt4ZJVmEIL9jTp+USU3foKQs2T0hP8vYhfgXOJo2irYde8LaPPalo9LftPF/B0VNNb808uT9VCooxgj/c0YtmIBN2b/s46qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=agU7DtJt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708419167;
	bh=GJYdAbM7ewpjFdjHz6ASYR5VJQe0AeyNeMR8SotvnjM=;
	h=From:To:Cc:Subject:Date:From;
	b=agU7DtJtNyjiDYeOcxIKd0T+lvhUMiG8t991Z/M4d+omokWz5meUew8yNVUG8wbgA
	 6wODkWyARKHOBCjerxxUEZl4TM4uuMV5v2UURHfnrN6T0uR5iI7hvPieoKSufGXFJK
	 Q5zhMZL6Dbvj07p1qvSfDpXb1gQ8nbIWP9ZBUsribkldyNxFH3436/V8aAy9DD4FIT
	 plbjxC49tNUljgps8Cq9GOUPjS/X5Gtl6dIHchiB4JxsUz2Wp9VQHzuhA4QJWcurcw
	 4eUV9+xQpklWiriJMG4z6Xcwjb2NIykZINb2ftjOJR6aFp29EO6bzyA+yFTqla6P4r
	 Gm1iVHLpzxSdg==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DB6B73782080;
	Tue, 20 Feb 2024 08:52:43 +0000 (UTC)
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
Subject: [PATCH v12 0/8] Cache insensitive cleanup for ext4/f2fs
Date: Tue, 20 Feb 2024 10:52:27 +0200
Message-Id: <20240220085235.71132-1-eugen.hristev@collabora.com>
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
I did changes as requested and here is v12.

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
 fs/libfs.c         |  85 +++++++++++++++++++++++++++++
 include/linux/fs.h |   4 ++
 11 files changed, 216 insertions(+), 205 deletions(-)

-- 
2.34.1


