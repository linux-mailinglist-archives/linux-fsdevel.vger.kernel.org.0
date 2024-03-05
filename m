Return-Path: <linux-fsdevel+bounces-13594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B8F871AFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 11:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259B21F22062
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 10:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79017612C2;
	Tue,  5 Mar 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hIASFsMv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907F60DF7;
	Tue,  5 Mar 2024 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633786; cv=none; b=ceF6LcZmqkznQHPw/RgExQaMsx/pQrZa85y8uS8Y9QbwGN/xmdMROSzcyU6RZvHUamoBjXqIZf5+EfLj8MK5a2LFZXEwyH1uXEEAla/GS5Ao49dAaeJuQdDcMEsXARykjzMOYsE00uqp08E5psqqYw77VvXUv5C5PzMOwTTMeek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633786; c=relaxed/simple;
	bh=i/9ZW+kNqpZnJVbMsf5b8+hAV2dVj/G+FqywABYCn2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hgVdTT077j5Lcufn/jcEexBl4meETuJJrt8rtTjFuBrh5ImsuZ82hKRr+zk7pBFCiQ4cjWNSCPEoIiRRr1qgIISsi0g/cY1psfq1bE5zgmOKOfBR16Az5de5bhXPADBNXKa2eWJ21n/saTQi454+Z+mN8VPFUwXYgkmc/CW7GDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hIASFsMv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709633783;
	bh=i/9ZW+kNqpZnJVbMsf5b8+hAV2dVj/G+FqywABYCn2o=;
	h=From:To:Cc:Subject:Date:From;
	b=hIASFsMvENDZkfwrWl7aEgXOJK9SjbtAmPR07fRshhtuD4+jt406NG79i5DYiWELf
	 Xghf/2KavoY3OIpydipg6j2iPOav0POFQALRPe2b6KL9SqfIkjMnhal0MOooaKAz3X
	 VVy452exObbp+l5etRpn4D7aeBGDLeeVWGIrBIZOCHpgE+hhVB/9oS3m86etzuSuPD
	 ILWevtXYjMl1kkw3yXnqC02zM1pt+jg5UfZfrcuHK5Tbn9549J+sOGID56mgnk3nk/
	 gD3KKHQf0fVPxu9lo3KdqF9ur4kdK856U/2dS1h3R8oBvKifVOmpARUqEOOyJ+jLS0
	 oFFRcSeC5P6EQ==
Received: from eugen-station.domain.com (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 355D9378045F;
	Tue,  5 Mar 2024 10:16:20 +0000 (UTC)
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
Subject: [PATCH v13 0/9] Cache insensitive cleanup for ext4/f2fs
Date: Tue,  5 Mar 2024 12:15:59 +0200
Message-Id: <20240305101608.67943-1-eugen.hristev@collabora.com>
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
I did changes as requested and here is v13.

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
 fs/f2fs/dir.c      | 112 ++++++++++++++-------------------------
 fs/f2fs/f2fs.h     |  16 +++++-
 fs/f2fs/namei.c    |  10 ++--
 fs/f2fs/recovery.c |   5 +-
 fs/f2fs/super.c    |   8 +--
 fs/libfs.c         |  81 ++++++++++++++++++++++++++++
 include/linux/fs.h |   4 ++
 11 files changed, 219 insertions(+), 204 deletions(-)

-- 
2.34.1


