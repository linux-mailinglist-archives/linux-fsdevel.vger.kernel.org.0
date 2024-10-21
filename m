Return-Path: <linux-fsdevel+bounces-32501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F3E9A6FBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 18:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA3E1C22AF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 16:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61EB1EBA03;
	Mon, 21 Oct 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YM+Fk8f2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7BA1CC161;
	Mon, 21 Oct 2024 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528671; cv=none; b=s6q2Im/+eTqoW0cbY+W7uK4LVlOtS83QWayAur281nW6iaMXmPEz/Oc4k/De/+ra650J3MZNVF20GlCwFslE5MTdMDOU1m+U+gmM+ejImgcGCtCOYz2KCJRrYlH2qyHIfsh7cbR1NvElIcdaqWaL4XJVbpCyTnrJHsrYKwgoPH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528671; c=relaxed/simple;
	bh=RAgYZnrIrqFDaCV13D9wM2RPAwJKU7jzNut1HhSVN8o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LLtYiIaOb7+EVUPhqIKl8JpngWjDF2RQGdkZ0kS3o0R5W2H3jas3OAuuZOXyWslOqb2dT4wykiK7RdUlJVgV4DW0nKsuL9Ulv6bgdsMwyjMAamNNq4Gqj5eKrDi4VyTfKQZk5g85UTTRUVLc/mMOY9qW7FJR1X6ZJ0wVOZc3r2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YM+Fk8f2; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bE1HISIArA2j2KViABaSmRyrQJHUPNILIjYajIv+hcs=; b=YM+Fk8f2LsrGy9bK0lw0CK0g75
	9U9CDU/m8f5rPnvZTajKVE58IsaiDnNXzCOOqXoxj0PktrcZHklDo7ikMQAC8xq3K5UPmisqUpIkx
	ewfURecokPYR9UQCAiwJMB0WdbrvupzHH0ZhZkyQW2JE8uLd+YBC3peBunhK/T0M1oR7GZBvFwsVL
	MFrQqDS8FCQKKpnR0Q2ARsGWME0eJOUFohyqlUPyY2AKL37ad8eUsgdZW5y4N9emYFtqKwH7f9IGH
	WRqHWf7wuolItIytRyzUerSY6V9PzY+3DaxYWHN5cMOl3YuLKsR9DM/OslEg0UD5hAlK/wM5a0ClK
	ntcS4T9A==;
Received: from [191.204.195.205] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t2vPV-00DECf-4w; Mon, 21 Oct 2024 18:37:37 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v8 0/9] tmpfs: Add case-insensitive support for tmpfs
Date: Mon, 21 Oct 2024 13:37:16 -0300
Message-Id: <20241021-tonyk-tmpfs-v8-0-f443d5814194@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADyDFmcC/23MQQ6DIBRF0a0YxqUBtAKOuo+mA4If/WkVA4bUG
 PdedFSTDt9Lzl1JhIAQSVOsJEDCiH7MQ10KYnszdkCxzZsIJirOOKOzH5cXnYfJReraCrjimpe
 tIFlMARx+jtrjmXePcfZhOeKp3t//nVRTRqV2zAATUFl1x8680VytH8geSvIXyzOWGRtt2a12q
 tTcnfC2bV+tYmn55AAAAA==
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
 Gabriel Krisman Bertazi <gabriel@krisman.be>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Randy Dunlap <rdunlap@infradead.org>
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

Changes in v8:
 - Fix docs typo (Randy)
 - Consistently guard `encoding` and `strict_encoding` fields from struct
   shmem_options, so those fields only exists with CONFIG_UNICODE (Brauner)
 v7: https://lore.kernel.org/r/20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com

Changes in v7:
 - Fixed generic_ci_validate_strict_name()
 - Dropped patch "tmpfs: Always set simple_dentry_operations as dentry ops"
 - Re-place generic_ci_validate_strict_name() before inode creation
 v6: https://lore.kernel.org/r/20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com

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
André Almeida (9):
      libfs: Create the helper function generic_ci_validate_strict_name()
      ext4: Use generic_ci_validate_strict_name helper
      unicode: Export latest available UTF-8 version number
      unicode: Recreate utf8_parse_version()
      libfs: Export generic_ci_ dentry functions
      tmpfs: Add casefold lookup support
      tmpfs: Add flag FS_CASEFOLD_FL support for tmpfs dirs
      tmpfs: Expose filesystem features via sysfs
      docs: tmpfs: Add casefold options

 Documentation/filesystems/tmpfs.rst |  24 ++++
 fs/ext4/namei.c                     |   5 +-
 fs/libfs.c                          |  12 +-
 fs/unicode/utf8-core.c              |  26 ++++
 fs/unicode/utf8-selftest.c          |   3 -
 include/linux/fs.h                  |  49 ++++++++
 include/linux/shmem_fs.h            |   6 +-
 include/linux/unicode.h             |   4 +
 mm/shmem.c                          | 234 ++++++++++++++++++++++++++++++++++--
 9 files changed, 340 insertions(+), 23 deletions(-)
---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241010-tonyk-tmpfs-fd4e181913d2

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


