Return-Path: <linux-fsdevel+bounces-11978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01507859D38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 08:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4111C21C39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 07:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A151520DF0;
	Mon, 19 Feb 2024 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ebj5/Qha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA220DC3;
	Mon, 19 Feb 2024 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328712; cv=none; b=gDRa4KzQ95R8tQjEDnyNo2J9FBSMV0Dp/xTqjDdxVFZcc5joPlBrDO5StWxpEdovQPoTaTpv/4imddAq5E6ZWzK5t+zM7DlrjssmLs5VB8+mmn7WfJ+jLe1kXH3QCAZjnXxyxSsn2ZC7fRoth9MKHMTJyDBZ2pc63m9scZ0H05g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328712; c=relaxed/simple;
	bh=dkkqNU9Xxp9enfjdxL9e7K/3u9KUJSsAKMkxSSoP1Io=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l3oLbLw11hkUwBxleotg9VnJdicW4IjW5AQPmp7SAhQJTvgXBdNaEPHejmmsf7TSFHsbHFR3QcChz4xTwEWvXsJsb2bsPJntu5WzMF7SX/jnibSlBc0Q7YZ67UjgfzvA1QsKem1RsiCNEh+iRnz7UgLfNwyyQ8bjorHEfJJhX6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ebj5/Qha; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708328708;
	bh=dkkqNU9Xxp9enfjdxL9e7K/3u9KUJSsAKMkxSSoP1Io=;
	h=From:To:Cc:Subject:Date:From;
	b=Ebj5/QhaG3HZApjRYhlACf8z7GHZNT2N4R7cgEf5Du3xszCv3ScZA5bW28/VjjHHv
	 cIhomjRJMA/KDIV3lLn9SepLrO3oyVo16DYbwFYG0QfTNnouVUhD/H9BpmceceeQ/A
	 XENaX+Nt6iuglJ1Ehr6elVvHwska+T73u2dGKdDz2jtZ2wLZM3PeKWaqztGteFkbOx
	 ZzdUWEaMhk65Er2YA4aT5J5RGOFUV13mMsMLbc98JJis/G7+0KTVqV9Khk8Q5J1I14
	 OD3nk/I+YqgUCH//F0J/gHQXsuqR7ndjAsP2B/a7KU6GajL9/DZF0eoRNAeRZ7C/s9
	 9RpOdi4Bhbymg==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3118E378003D;
	Mon, 19 Feb 2024 07:45:04 +0000 (UTC)
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
Subject: [PATCH v11 0/8] Cache insensitive cleanup for ext4/f2fs
Date: Mon, 19 Feb 2024 09:44:49 +0200
Message-Id: <20240219074457.24578-1-eugen.hristev@collabora.com>
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
I did changes as requested and here is v11.

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
 fs/libfs.c         |  67 +++++++++++++++++++++++
 include/linux/fs.h |   4 ++
 11 files changed, 198 insertions(+), 205 deletions(-)

-- 
2.34.1


