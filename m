Return-Path: <linux-fsdevel+bounces-28295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 866DC969025
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 00:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF3A284541
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 22:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3399A18BB8A;
	Mon,  2 Sep 2024 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GuwXvrTW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0E18951F;
	Mon,  2 Sep 2024 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317749; cv=none; b=FONap8lKZfvdTz+ofBBn1iSzUXoUyoaNjS5ch+n7vZ3nbl8I8amBI2Qvi8kMpTgfZIflH6LGOYhhmgmItwNub8WpexYvuHfW9+dhWlL/Oohxk2k0XLT1IJV51KGgseD7oTcduq2R21sHSiR3Zjr7D+2Kllswsk15BeLo4uUt3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317749; c=relaxed/simple;
	bh=VsKenrm66uYwWw2jmnOrbYi+q0p3xovfWDh8+dC/3iU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BYBIo2wWaK8iCNT/xiAQGMpTxpqsGWXZAGSognp51h9lzuA2RYapPdb6k7iW564fhC1l6F41c8yue8+Lw6qMws7jbFT/NsvMDl0atWFatEZ7TpVIHuZl7nJbNNJYFWvQUZGHAtxS67+7nCoJ63O35G7bF1v62R3pkM7873UVgZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GuwXvrTW; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UaY8kTz9kpyX3qxIM+DomGqW9miwbtabmAU032CdbN0=; b=GuwXvrTWencirwTezu0wssyUFu
	8qlqA6/LpqupRS+C8t1WLBODgZYybbupRlVArbtf6WE+rmSfndfd+jhW9D8N7RrGY6tJ7rfOGQfOB
	VCfLyRnOSUF6gX7QPVmrBXKZ7LnjMO71ejTgTU1VcGgLH5QDzUhLfSB6GRetVy9ux1L6D3le5YtGP
	M6eCmg01xK+N4qPeu0h4BoneFdTQoNL76fKmeqaxYvvVjLsRSvwerPc2gewt96s6R/K7Ow4nRlXaN
	TwwbutKYcDtKGR6ouXuSoB3LlYDs6zdLwyT7hcmKKxOOewTY9D7ELutYDr0qz3nzSkfhDx450CwfH
	6etb1RBA==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1slFxA-008VrL-Ap; Tue, 03 Sep 2024 00:55:20 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 0/8] tmpfs: Add case-insesitive support for tmpfs
Date: Mon,  2 Sep 2024 19:55:02 -0300
Message-ID: <20240902225511.757831-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series is based on [0].

This patchset adds support for case-insesitive file names lookups in tmpfs. The
main difference from other casefold filesystems is that tmpfs has no information
on disk, just on RAM, so we can't use mkfs to create a case-insensitive tmpfs.
For this implementation, I opted to have a mount option for casefolding. The
rest of the patchset follows a similar approach as ext4 and f2fs.

* Use case (from the original cover letter)

The use case for this feature is similar to the use case for ext4, to
better support compatibility layers (like Wine), particularly in
combination with sandboxing/container tools (like Flatpak). Those
containerization tools can share a subset of the host filesystem with an
application. In the container, the root directory and any parent
directories required for a shared directory are on tmpfs, with the
shared directories bind-mounted into the container's view of the
filesystem.

If the host filesystem is using case-insensitive directories, then the
application can do lookups inside those directories in a
case-insensitive way, without this needing to be implemented in
user-space. However, if the host is only sharing a subset of a
case-insensitive directory with the application, then the parent
directories of the mount point will be part of the container's root
tmpfs. When the application tries to do case-insensitive lookups of
those parent directories on a case-sensitive tmpfs, the lookup will
fail.

For example, if /srv/games is a case-insensitive directory on the host,
then applications will expect /srv/games/Steam/Half-Life and
/srv/games/steam/half-life to be interchangeable; but if the
container framework is only sharing /srv/games/Steam/Half-Life and
/srv/games/Steam/Portal (and not the rest of /srv/games) with the
container, with /srv, /srv/games and /srv/games/Steam as part of the
container's tmpfs root, then making /srv/games a case-insensitive
directory inside the container would be necessary to meet that
expectation.

* Testing

I send a patch for xfstests to enable the casefold test (generic/556) for tmpfs.[1]
The test succeed.

You can test this patchset using:

  sudo mount -t tmpfs -o casefold=utf8-12.1.0 tmpfs mnt/

And making a dir case-insesitive:

  mkdir mnt/dir
  chattr +F mnt/dir

[0] https://lore.kernel.org/linux-fsdevel/20210323195941.69720-1-andrealmeid@collabora.com/
[1] https://lore.kernel.org/fstests/20240823173008.280917-1-andrealmeid@igalia.com/

Changes in v2:
 - Found and fixed a bug in utf8_load()
 - Created a helper for checking strict file names (Krisman)
 - Merged patch 1/ and 3/ together (Krisman)
 - Reworded the explanation about d_compare (Krisman)
 - Removed bool casefold from shmem_sb_info (Krisman)
 - Reworked d_add(dentry, NULL) to be called as d_add(dentry, inode) (Krisman)
 - Moved utf8_parse_version to common unicode code
 - Fixed some smatch/sparse warnings (kernel test bot/Dan Carpenter)
 v1: https://lore.kernel.org/linux-fsdevel/20240823173332.281211-1-andrealmeid@igalia.com/

André Almeida (8):
  unicode: Fix utf8_load() error path
  unicode: Create utf8_check_strict_name
  ext4: Use utf8_check_strict_name helper
  unicode: Recreate utf8_parse_version()
  tmpfs: Add casefold lookup support
  tmpfs: Add flag FS_CASEFOLD_FL support for tmpfs dirs
  tmpfs: Expose filesystem features via sysfs
  docs: tmpfs: Add casefold options

 Documentation/filesystems/tmpfs.rst |  37 ++++++
 fs/ext4/namei.c                     |   3 +-
 fs/unicode/utf8-core.c              |  58 ++++++++-
 include/linux/shmem_fs.h            |   6 +-
 include/linux/unicode.h             |   5 +
 mm/shmem.c                          | 192 ++++++++++++++++++++++++++--
 6 files changed, 284 insertions(+), 17 deletions(-)

-- 
2.46.0


