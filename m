Return-Path: <linux-fsdevel+bounces-30813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A5D98E73D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 01:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 562EEB24DA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47C419F111;
	Wed,  2 Oct 2024 23:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GvKN74QA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B88B1991A9;
	Wed,  2 Oct 2024 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912716; cv=none; b=N4B3xAjqOa0F/uKymHcwr9lvj75PPT2M1JatMrMKBkbONn+2Ly1DvQvK9d0c1fgqP7oE6nzHTIJTcDq5oF/8cPY8CmbatDsY670jNAOUwerycaC2m3GaVR3Z8uCAFwlhzy/ueH77BT1gUgFzrlhsXfnZt31xJVt9bAat7flZx+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912716; c=relaxed/simple;
	bh=C5PGpC6pnWKx6IbsYaMl+hW4V+6xPJJmkirZRMzcrQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J8l8sxkJD0qH60rzbSL6vGyr5ZcDU041T4pw9VWiWjMl4j2yvhMNh/ldz1F/TXWB5Ougduz2fKDpejr9NYowkNx9SyrWi3ZLloDCy8PcU9H2CVKJerXXHvVSD9Xm+b5IrGy8I9SbPXbg0OyHaeZzgTTtafI+bVjkg5hDQ8jNy4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GvKN74QA; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kj7oVNFXBHyRs7B0iMgteogxKX3su9r74K3KaL3e4KM=; b=GvKN74QA18wBN9dzszPvApYpMT
	xXSMBzdxoZNJVxGCDghI4infFlHUSKbBT84HZjWY2ZMVXKovWm4WBknybp9kjlh+lVpl1m0eupTns
	MDfdXJlUwEx77as+qiIyt7ZNSN3UoQ0yUdE62M1xY1iMTr4nd8yVL9SyC+sr1o1BYBbxv7x0AKd46
	BwuSvvo59M0hJUiKXgKJXDdObGuptXFO3MC8Wjh31Rw9PfvjprnIHvO0t0g72SR/cdvr4mE7HLvWq
	PwpTVJ9Cu+FwTBLQVi3LyZzfkPDY3/G5ec1le9lWwVf1oGS0NhyICLaqbFrN2LDJFZGv/FoDCFy02
	xqfhKIjw==;
Received: from [187.57.199.212] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sw91e-0045tc-Qk; Thu, 03 Oct 2024 01:44:59 +0200
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
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 00/10] tmpfs: Add case-insensitive support for tmpfs
Date: Wed,  2 Oct 2024 20:44:34 -0300
Message-ID: <20241002234444.398367-1-andrealmeid@igalia.com>
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

This patchset adds support for case-insensitive file names lookups in
tmpfs. The main difference from other casefold filesystems is that tmpfs
has no information on disk, just on RAM, so we can't use mkfs to create a
case-insensitive tmpfs.  For this implementation, I opted to have a mount
option for casefolding. The rest of the patchset follows a similar approach
as ext4 and f2fs.

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

I send a patch for xfstests to enable the casefold test (generic/556) for
tmpfs.[1] The test succeed.

You can test this patchset using:

  sudo mount -t tmpfs -o casefold tmpfs mnt/

And making a dir case-insensitive:

  mkdir mnt/dir
  chattr +F mnt/dir

[1] https://lore.kernel.org/fstests/20240823173008.280917-1-andrealmeid@igalia.com/

Changes in v5:
 - New patch "Always set simple_dentry_operations as dentry ops"
 - "Squashed libfs: Check for casefold dirs on simple_lookup()" into "tmpfs: Add
    casefold lookup support"
 - Fail to mount if strict_encoding is used without encoding
 - Inlined generic_ci_validate_strict_name()
 - Added IS_ENABLED(UNICODE) guards to public generic_ci_ funcs
 - Dropped .d_revalidate = fscrypt_d_revalidate, tmpfs doesn't support it
 v4: https://lore.kernel.org/lkml/20240911144502.115260-1-andrealmeid@igalia.com/

Changes in v4:
 - Got rid of shmem_lookup() and changed simple_lookup() to cover casefold use
   case
 - Simplified shmem_parse_opt_casefold() and how it handle the lastest_version
   option
 - Simplified utf8_parse_version() to return the version in one variable instead
   of three
 - Rewrote part of the documentation patch
 - Make sure that d_sb->s_d_op is set during mount time
 - Moved `generic_ci_always_del_dentry_ops` to mm/shmem.c as `shmem_ci_dentry_ops`
v3: https://lore.kernel.org/lkml/20240905190252.461639-1-andrealmeid@igalia.com/

Changes in v3:
 - Renamed utf8_check_strict_name() to generic_ci_validate_strict_name(), and
 reworked the big if(...) to be more clear
 - Expose the latest UTF-8 version in include/linux/unicode.h
 - shmem_lookup() now sets d_ops
 - reworked shmem_parse_opt_casefold()
 - if `mount -o casefold` has no param, load latest UTF-8 version
 - using (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir) when possible
 - Fixed bug when adding a non-casefold flag in a non-empty dir
v2: https://lore.kernel.org/lkml/20240902225511.757831-1-andrealmeid@igalia.com/

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

André Almeida (10):
  libfs: Create the helper function generic_ci_validate_strict_name()
  ext4: Use generic_ci_validate_strict_name helper
  unicode: Export latest available UTF-8 version number
  unicode: Recreate utf8_parse_version()
  libfs: Export generic_ci_ dentry functions
  tmpfs: Always set simple_dentry_operations as dentry ops
  tmpfs: Add casefold lookup support
  tmpfs: Add flag FS_CASEFOLD_FL support for tmpfs dirs
  tmpfs: Expose filesystem features via sysfs
  docs: tmpfs: Add casefold options

 Documentation/filesystems/tmpfs.rst |  24 +++
 fs/ext4/namei.c                     |   5 +-
 fs/libfs.c                          |  12 +-
 fs/unicode/utf8-core.c              |  26 ++++
 fs/unicode/utf8-selftest.c          |   3 -
 include/linux/fs.h                  |  49 ++++++
 include/linux/shmem_fs.h            |   6 +-
 include/linux/unicode.h             |   4 +
 mm/shmem.c                          | 226 ++++++++++++++++++++++++++--
 9 files changed, 332 insertions(+), 23 deletions(-)

-- 
2.46.0


