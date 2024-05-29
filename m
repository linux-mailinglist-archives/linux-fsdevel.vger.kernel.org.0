Return-Path: <linux-fsdevel+bounces-20415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA30B8D3147
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 10:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960D8294DED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 08:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C0816A374;
	Wed, 29 May 2024 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qh6rb3WP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF22215B0E0;
	Wed, 29 May 2024 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971209; cv=none; b=ABSAhqlEx+tXrUr2sxCNEIps5OKEE66STgKRBSkozkm8Z2z/OdSs6o7N0v4Y3vGBq/TdrYZOUhRlZF2QCSEJ/TVsABaOext3yNdvCNCT83RaOvpXfqT3ND2waC9grAdHLFtBvWmkjVvoXoZp8ajF4YKCcccCuI0NunU0IL8VhDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971209; c=relaxed/simple;
	bh=8DvYsg/j4JRyj6ZyJVoopmP3oTEFO0NjYisKzyNxqSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KjsQe6qN0JKzdP+knb6W9wxEWJmfrc4cqgO5SiOiJnc7TXdtq/OnE/yur/nBuEuEVGkfkDm6cYLWWCXUM7XlWOJn+6kYTScf0urvANc6TuzbbyJEpTfWPeZxx8HO0vPRQrLpsfZgkEbzNJTKcHiRqPZ5nR38+ehYc+H6zzu82uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qh6rb3WP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716971205;
	bh=8DvYsg/j4JRyj6ZyJVoopmP3oTEFO0NjYisKzyNxqSI=;
	h=From:To:Cc:Subject:Date:From;
	b=qh6rb3WPLPrJoI4vPSUcHSsfx4xXvHSNZE78X2QGYjPweOAkLp+9FK1WwovZCoNZR
	 TGwMK4TPCngnbTlRB/taqO5ZaWl0ec/oJDJvyAU4FNF569nO5XE6A10S3qWdcsZjCw
	 Q3fnc7G85Pm8X004BLEyY/JZdfXQo1QeplmvUHrosA3DXMtsqkpfrBk1HoYAMIzmqM
	 Vih5bf1TNOzMRZkf2kunuQGXTt82Qv0PQLYWCcji0LqnVHIhjbOo1US9bimQDy99wi
	 hQH52+ruIctn0Fd9np2EWN4zsjZltxr4bbD/RDHxGv4+Zh5TU5Zo0e0AYHZhMHOe1R
	 og081qT8b8zQw==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C7FC5378000A;
	Wed, 29 May 2024 08:26:44 +0000 (UTC)
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
Subject: [PATCH v17 0/7] Case insensitive cleanup for ext4/f2fs
Date: Wed, 29 May 2024 11:26:27 +0300
Message-Id: <20240529082634.141286-1-eugen.hristev@collabora.com>
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
I did changes as requested and here is v17.

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
 fs/ext4/namei.c    | 126 +++++++++++++++------------------------------
 fs/ext4/super.c    |   4 +-
 fs/f2fs/dir.c      | 105 +++++++++++--------------------------
 fs/f2fs/f2fs.h     |  16 +++++-
 fs/f2fs/namei.c    |  10 ++--
 fs/f2fs/recovery.c |   9 +---
 fs/f2fs/super.c    |   8 +--
 fs/libfs.c         |  74 ++++++++++++++++++++++++++
 include/linux/fs.h |   4 ++
 11 files changed, 200 insertions(+), 201 deletions(-)

-- 
2.34.1


