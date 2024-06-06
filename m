Return-Path: <linux-fsdevel+bounces-21089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AF38FDFCC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 09:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D0F1C24655
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 07:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B410C13BC02;
	Thu,  6 Jun 2024 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Efc7Rcf4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DEA1F5F5;
	Thu,  6 Jun 2024 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717659278; cv=none; b=SWKnYgUWG3sPn0K5CA+G8fbpFHhIovVt08cEKKlSMwLIxCvo3a2DDjMsggbshGlA0TX4HtbfUpZR6Ojwzt8E0XGO5NP9V+y6DXwGpQwuUvnjvy5ClZW8vy5q9OvVPmuUw0/6HR22VP/QpWCrEp7vY94CLbL7c7+YBPqTQ6khCtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717659278; c=relaxed/simple;
	bh=tNn94IobQd/C8dlz5nPbMB5Ad685R1KlC03nWzyXv4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hsJmP1Ienqa7W43OQDwAth58TrW4bAM7ap6wCdvfCNwIM06g+6ud8VpOiciNibQoxh1HLBa9KrkZ6XUG02GSz6oXkJeqBwVsaSIY3dhZB8aL4gvpqB0P8Ii1cdO27IeQkWKf1un+Xtqyxyx5rxz72rMHK4JSlLwEHGCYnLT3Vlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Efc7Rcf4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717659274;
	bh=tNn94IobQd/C8dlz5nPbMB5Ad685R1KlC03nWzyXv4I=;
	h=From:To:Cc:Subject:Date:From;
	b=Efc7Rcf47ESRHoXu0+HlmK5cBJVdHWy5UR8IgXH8GbBe+p60/9hliZ/GLKYQwZ0sx
	 mO36fYGcqkzoR7m8wwcQ8ZecWfEjwrZpnsNVh2sPI5xyGb7CrGIaRK4RyZUWa25FQ0
	 aQVl/nhjCuN+NtrvvRqZ5JSqEUhQrtCHLfajBlDmGmDpTHtJqZJnTaB8j0VSjNAkNl
	 e504pZkKLpIfIDUYak+zdkVrJ3zeFsfW8//VAnp4vWD8nkO2SymQJArKkX1SGgdaL/
	 3QYO49kbNaw6A9KO5sc2PKhF9YD+R6OHvsvuKJXv0LvTk6ZFI8ASRmiNThlMk0+0Q4
	 CcjH8AMVlYaCg==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7332137821B7;
	Thu,  6 Jun 2024 07:34:33 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	adilger.kernel@dilger.ca,
	tytso@mit.edu
Cc: chao@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ebiggers@google.com,
	krisman@suse.de,
	kernel@collabora.com,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v18 0/7] Case insensitive cleanup for ext4/f2fs
Date: Thu,  6 Jun 2024 10:33:46 +0300
Message-Id: <20240606073353.47130-1-eugen.hristev@collabora.com>
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
I did changes as requested and here is v18.

Changes in v18:
- in patch 2/7 removed the check for folded_name->len
- in patch 4/7 simplified the use of generic_ci_match

Changes in v17:
- in patch 2/7 the case insensitive match helper, I modified the logic a bit,
memcmp params, and return errors properly, also removed patches for logging
errors as the message is now included in the helper itself.

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

Gabriel Krisman Bertazi (7):
  ext4: Simplify the handling of cached casefolded names
  f2fs: Simplify the handling of cached casefolded names
  libfs: Introduce case-insensitive string comparison helper
  ext4: Reuse generic_ci_match for ci comparisons
  f2fs: Reuse generic_ci_match for ci comparisons
  ext4: Move CONFIG_UNICODE defguards into the code flow
  f2fs: Move CONFIG_UNICODE defguards into the code flow

 fs/ext4/crypto.c   |  10 +---
 fs/ext4/ext4.h     |  35 ++++++++-----
 fs/ext4/namei.c    | 122 ++++++++++++++-------------------------------
 fs/ext4/super.c    |   4 +-
 fs/f2fs/dir.c      | 105 ++++++++++++--------------------------
 fs/f2fs/f2fs.h     |  16 +++++-
 fs/f2fs/namei.c    |  10 ++--
 fs/f2fs/recovery.c |   9 +---
 fs/f2fs/super.c    |   8 +--
 fs/libfs.c         |  74 +++++++++++++++++++++++++++
 include/linux/fs.h |   4 ++
 11 files changed, 195 insertions(+), 202 deletions(-)

-- 
2.34.1


