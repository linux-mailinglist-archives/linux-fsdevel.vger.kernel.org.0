Return-Path: <linux-fsdevel+bounces-12709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7025086299B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 08:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69BF282459
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 07:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82447D527;
	Sun, 25 Feb 2024 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6w0L5D5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C3A7460
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708845334; cv=none; b=sycN3r8n3l75MAoNPk4g34noeMsGcYVDPA3PPQrGfpGym9lzaVcYl4YJcO1lT7im8ZvEq2cdUWlS00uoDolP4F6b31BikinjcMZxIODzVM4vGNm9xVrnobfHOPncDcnZBBSz0V/QGFjKs64HSDI2UBB01rF/xGT8Prp/2d+bSds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708845334; c=relaxed/simple;
	bh=nhrrUivA9IryEWFcNfl97N1h8vW+XWCcOEZrVD8w9n8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HcBI10yzhvRo5b2SR21dlbJsIYn1rPMHfmXrf0ZawYfgDdQdWIQoOST0hQEDpWgh3ajmlnSVcpC9iBlLvkt7+jRnOCienSZmbZm21D3hnVjd+oRJ92X/QhEXYEhSKkDtAMpQqwqS+TGQQtohOevZY8yOuuAjwM3Yh7TdXGNgiIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6w0L5D5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249B8C433C7;
	Sun, 25 Feb 2024 07:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708845333;
	bh=nhrrUivA9IryEWFcNfl97N1h8vW+XWCcOEZrVD8w9n8=;
	h=Date:From:To:Cc:Subject:From;
	b=d6w0L5D5XyiKakRFqNirS3F/MLzbex/XQDSM/LkAyEQsIAQ17mdXeYHUYLiZEjgzG
	 ueOGwHmOPdTj2ntNuvhuL/um9MXnaX0nxOEM5j1hXoibO9vCRZ+UzrSUhJVxHHWqtb
	 cJMvKruHXhzzc7z/xAC4RjxUHy4K+EDZV7yft4Trf/CYJE32I8D9lrE/zpxJ7NohDt
	 ScANBNLRiPxhGwaHYxfq4WD1yWNkbq9UTbgXrli47zKhQDXQO0QllSc6UUW42UDlo5
	 NlcYNL58c5AANgNDSbnaUK/41L9SZa8Vc0wXz2j62+yZwVfEQijZv16pGrCsXK6jdU
	 1h6cgG7MxEewg==
Date: Sun, 25 Feb 2024 02:16:46 -0500
From: Al Viro <viro@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] rcu pathwalk fixes
Message-ID: <ZdrpXmWQYzExV5m3@duke.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[as posted on Feb 4, with accumulated acked-by/reviewed-by added; the original
branch is also tagged (pull-fixes.pathwalk-rcu), the only difference is in the
added lines in commit messages and resulting update of commit dates]

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes.pathwalk-rcu-2

for you to fetch changes up to 9fa8e282c2bfe93338e81a620a49f5903a745231:

  ext4_get_link(): fix breakage in RCU mode (2024-02-25 02:10:32 -0500)

----------------------------------------------------------------
We still have some races in filesystem methods when exposed to RCU
pathwalk.  This series is a result of code audit (the second round
of it) and it should deal with most of that stuff.  Exceptions: ntfs3
->d_hash()/->d_compare() and ceph_d_revalidate().  Up to maintainers (a
note for NTFS folks - when documentation says that a method may not block,
it *does* imply that blocking allocations are to be avoided.  Really).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (13):
      fs/super.c: don't drop ->s_user_ns until we free struct super_block itself
      rcu pathwalk: prevent bogus hard errors from may_lookup()
      affs: free affs_sb_info with kfree_rcu()
      exfat: move freeing sbi, upcase table and dropping nls into rcu-delayed helper
      hfsplus: switch to rcu-delayed unloading of nls and freeing ->s_fs_info
      afs: fix __afs_break_callback() / afs_drop_open_mmap() race
      nfs: make nfs_set_verifier() safe for use in RCU pathwalk
      nfs: fix UAF on pathwalk running into umount
      procfs: move dropping pde and pid from ->evict_inode() to ->free_inode()
      procfs: make freeing proc_fs_info rcu-delayed
      fuse: fix UAF in rcu pathwalks
      cifs_get_link(): bail out in unsafe case
      ext4_get_link(): fix breakage in RCU mode

 fs/affs/affs.h            |  1 +
 fs/affs/super.c           |  2 +-
 fs/afs/file.c             |  8 ++++++--
 fs/exfat/exfat_fs.h       |  1 +
 fs/exfat/nls.c            | 14 ++++----------
 fs/exfat/super.c          | 20 +++++++++++---------
 fs/ext4/symlink.c         |  8 +++++---
 fs/fuse/cuse.c            |  3 +--
 fs/fuse/fuse_i.h          |  1 +
 fs/fuse/inode.c           | 15 +++++++++++----
 fs/hfsplus/hfsplus_fs.h   |  1 +
 fs/hfsplus/super.c        | 12 +++++++++---
 fs/namei.c                |  6 +++++-
 fs/nfs/client.c           | 13 ++++++++++---
 fs/nfs/dir.c              |  4 ++--
 fs/proc/base.c            |  2 --
 fs/proc/inode.c           | 19 ++++++++-----------
 fs/proc/root.c            |  2 +-
 fs/smb/client/cifsfs.c    |  3 +++
 fs/super.c                | 13 ++++---------
 include/linux/nfs_fs_sb.h |  2 ++
 include/linux/proc_fs.h   |  1 +
 22 files changed, 88 insertions(+), 63 deletions(-)

