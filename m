Return-Path: <linux-fsdevel+bounces-31626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF60F9992C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 21:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5431C203A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247BF1E5015;
	Thu, 10 Oct 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZiTJG6Nz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E67B1A01B9;
	Thu, 10 Oct 2024 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589271; cv=none; b=okWbnuGAAJJBwz44x4HIysAyJSN3oK+UIDpcwr+Y1n68fbYqY6XX6ruJlviNuTsbDCKGxMyJT0d6KA36Jui7oEeWsY82wCMyo2MjSiYhSATRcOTwT3gMcPuvhQznQxJRKHJHEx9So7gDHvbwIhn6CaHfChK56fCDDErvGmLP3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589271; c=relaxed/simple;
	bh=MK88nhn1oQ7OMjkxgADNCjkPzV+bAEJrglSsBKJJrqo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=thOC9AS3FSvByap3+9pqVA9ghgPpzFMLToFZ2n9sMp89bAM4dRONria2OT5UXNrTxl03Q1EtSl+rZrjc1tA/2jIESw3x07ybrcK3ofhIit8Co0rCwZh1H7ow9gZY4wgzlYsJoK6C6kVaNaoekIOhQvdeGplxiuj+YAAWBgfR0TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZiTJG6Nz; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=09iDL1axmjrQDK0WLyH9ikUE9Gcp6sSd7bv4iS9IhBM=; b=ZiTJG6NzvItlCYUUoKNFotHlTC
	wTRRu93p2T6Vj5ZwwttyWGXHm295exVkVXgTcN+RieoPmCiQLSyFoYfNHu17NkTY5rDVxpAsiYCDg
	pNi3d+AehnJrvn8Tjt6BR6MHInjD+eQgXCOA1eU+UGmGwkHwYHuO1NPE+colgtMPc0pShAoloVXdx
	HI67LCm81xTigYHkmIvpFNOx/H7a9awRU5IZcyoYf4H5bqhtP29IDquq1nEOwpkwtDul3ul/dGUv6
	PJtjjfLKI8/xGI7fLmJMVePALWsVjJAtUizTGiGYAOP/t3S6EZzUvwC2vKQUlDMlfXjIRG0/sGfRg
	YHrbE7og==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syz1u-007SHz-2w; Thu, 10 Oct 2024 21:40:58 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v6 00/10] tmpfs: Add case-insensitive support for tmpfs
Date: Thu, 10 Oct 2024 16:39:35 -0300
Message-Id: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHctCGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHQUlJIzE
 vPSU3UzU4B8JSMDIxNDA0MD3ZL8vMps3ZLcgrRi3bQUk1RDC0NLQ+MUIyWgjoKi1LTMCrBp0bG
 1tQC++7WtXQAAAA==
X-Change-ID: 20241010-tonyk-tmpfs-fd4e181913d2
To: Gabriel Krisman Bertazi <krisman@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 Gabriel Krisman Bertazi <krisman@suse.de>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

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

Changes in v6:
 - Fixed kernel bot warning 'shmem_ci_dentry_ops' defined but not used
 v5: https://lore.kernel.org/lkml/20241002234444.398367-1-andrealmeid@igalia.com/

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

---
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

 Documentation/filesystems/tmpfs.rst |  24 ++++
 fs/ext4/namei.c                     |   5 +-
 fs/libfs.c                          |  12 +-
 fs/unicode/utf8-core.c              |  26 +++++
 fs/unicode/utf8-selftest.c          |   3 -
 include/linux/fs.h                  |  49 ++++++++
 include/linux/shmem_fs.h            |   6 +-
 include/linux/unicode.h             |   4 +
 mm/shmem.c                          | 226 ++++++++++++++++++++++++++++++++++--
 9 files changed, 332 insertions(+), 23 deletions(-)
---
base-commit: eb952c47d154ba2aac794b99c66c3c45eb4cc4ec
change-id: 20241010-tonyk-tmpfs-fd4e181913d2

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


