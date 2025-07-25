Return-Path: <linux-fsdevel+bounces-56019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A52B11D7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4465A454C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFA02E7F36;
	Fri, 25 Jul 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJbIzDAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7936F2E7BC7;
	Fri, 25 Jul 2025 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442850; cv=none; b=YtkJA818g2Kdv1pvfRc5vnKzz5FaQwCsFl8qeucMujvS6lGO3zqM/fkpPrHEFtvWWWu7mWv+okNvkL/2yUiMzJQQIUpf6FD9tmW54QKrnxrN8SKfSQ2WNsOJv4fjInLWdIrSVTLsJ0FPhd29IoP4ZuwOvJkdpID5YVcsZybhL8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442850; c=relaxed/simple;
	bh=HZwh4c+fkgcKBPBtLMT9ShOkxcenjbKQ37mhazSa3HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJAgrqU/wtipy/tMszQSwUcN6/KghnIf9zBh7n3tkYZpqqXdMF5gjWWyc7kaU7iItBumDNz/i2WALs6AhTZ9Wa1AAwp7amthwtsTiOhwOSphbpjKqBdt8Fojnzl8bgp7P4LZX5rcYci24DYH5LSBmpN9MTRysTZIzuaFuHcjucQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJbIzDAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58E4C4CEE7;
	Fri, 25 Jul 2025 11:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753442850;
	bh=HZwh4c+fkgcKBPBtLMT9ShOkxcenjbKQ37mhazSa3HY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJbIzDAepKL8puC9RJT+QimrRCU1Vn03X4AXOA6zFHl009ZqSDKJLmpcQAAkW3AJA
	 xPmsHU61MFDzOXqyf3EfVnH13Dp/nNcgnoqpxjPyLJ8o0/1wH1GyBOKHJ27Yn+fKuR
	 XZsaC1WF3N3UqzKIz6KNfJ12iZ5Zkaqa02UTuJUSAPK+APYMQqqRsPaNkVa6bjundX
	 IvaQwRaqlwHLyQAeYkDfiTGQEwDczskJ4HaEAqtJprqHRx0oVXqpW15dDJIeFQQcmH
	 qw0/EWLv+9+V5o13710FaHFQ54VMtS6YzDtbYyLJuXnvKd8qzcn+KOpacC2Fy5ZJbB
	 QYSYSSKOmoOgA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 05/14 for v6.17] vfs async dir
Date: Fri, 25 Jul 2025 13:27:14 +0200
Message-ID: <20250725-vfs-async-dir-c1ddd69d8fd4@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2060; i=brauner@kernel.org; h=from:subject:message-id; bh=HZwh4c+fkgcKBPBtLMT9ShOkxcenjbKQ37mhazSa3HY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0Z4kwH1l4fle06bkorq7ATgOLdqmFFx0y8iYEc/9hX hQ67/qbjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlIbmD4p2G2aurLA0+MOFp3 OfC8W/HZoi991fKU5s2flW/u2VF+woPhf8DKfS35StkMAimHJJ5aav8+UKU7X2fVdEsmD7Vja26 z8QEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains preparatory changes for the asynchronous directory locking
scheme. While the locking scheme is still very much controversial and
we're still far away from landing any actual changes in that area the
preparatory work that we've been upstreaming for a while now has been
very useful. This is another set of minor changes and cleanups.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.async.dir

for you to fetch changes up to d4db71038ff592aa4bc954d6bbd10be23954bb98:

  Merge patch series "Minor cleanup preparation for some dir-locking API changes" (2025-06-11 13:44:21 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc1.async.dir tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc1.async.dir

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "Minor cleanup preparation for some dir-locking API changes"

NeilBrown (4):
      VFS: merge lookup_one_qstr_excl_raw() back into lookup_one_qstr_excl()
      VFS: Minor fixes for porting.rst
      coda: use iterate_dir() in coda_readdir()
      exportfs: use lookup_one_unlocked()

 Documentation/filesystems/porting.rst |  3 ---
 fs/coda/dir.c                         | 12 ++----------
 fs/exportfs/expfs.c                   |  4 +---
 fs/namei.c                            | 37 +++++++++++++----------------------
 4 files changed, 17 insertions(+), 39 deletions(-)

