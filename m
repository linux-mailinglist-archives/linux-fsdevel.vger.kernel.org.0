Return-Path: <linux-fsdevel+bounces-40357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4264EA22842
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 05:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5B4164401
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 04:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBDD70814;
	Thu, 30 Jan 2025 04:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kDUiWKAc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B704D52F88;
	Thu, 30 Jan 2025 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738211834; cv=none; b=RGiCNlBnzLoXaoHI2uVGjy1UndyF0AUZOEA9FVpVtrOwnLcg/XPlnqxkLfcJMVqbaMfaGWKDjC7V54eDP5N9pA1FPzysNL9kxQDkLa/8nkhDT84zIrOGB246st/Ogq1p37f0UJdzbXecHIziOFhyT0WvlHa+MPbYjaI94gxX45k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738211834; c=relaxed/simple;
	bh=fOYB9cwracAF9d9oO3jOOBKrIscIPgA3lyn5FdZChZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plntIBIYAA4Fw+LRh8PP9nFXyzFy2KVXElau9tmOgksHocfSbCm8+zHbuh7diIiJ99fP6DpEPbKlD0R8QltLFFMp2HeIi1vJvGwVo2at3xvN74EQFfT3UN64w7Iljrjln1NnS+G59MOCQH8ugYzISkdxSs3SUdsUL9nnX62ZaQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kDUiWKAc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=btqWBd+W4Aie/QFtGi+Ld4IVWHpJBAF5I5E+W0qtXak=; b=kDUiWKAciDXVeGs8Z0Yemu6bz9
	kWrYyI3qvmdIKgXDJj8ynwDtl3pPO90nWDlLE7oyK3V0j4ulLJn3udClEfh16EXKiqCY5huC4bNPd
	5WQoEo9XQ89HOf8eMoKtg2/+dgpcXTTSs1GjTqFh5b7ws386/icsUTfV7sGGvgG8GqQLEHHGiqsa/
	OTk4kw7PhmYOlX/VvlMosecDeO3Uu/ZfCUFPOuxwQB1IGfoNuVqUPXcobwcNWCxVubfk/QuwlbBHj
	SvmojnEBnbq6krAfMX5ByuuHpnLL9xzziCVQGCr4bpWu4nrndd9j3+HI+pYUSnyTMMnJIIkCPGQo0
	Ymrakyiw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdMId-0000000FrF3-3ess;
	Thu, 30 Jan 2025 04:37:07 +0000
Date: Thu, 30 Jan 2025 04:37:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] d_revalidate pile (v2)
Message-ID: <20250130043707.GT1977892@ZenIV>
References: <20250127044721.GD1977892@ZenIV>
 <Z5fAOpnFoXMgpCWb@lappy>
 <20250127173634.GF1977892@ZenIV>
 <Z5fyAPnvtNPPF5L3@lappy>
 <20250127213456.GH1977892@ZenIV>
 <20250127224059.GI1977892@ZenIV>
 <Z5gWQnUDMyE5sniC@lappy>
 <20250128002659.GJ1977892@ZenIV>
 <20250128003155.GK1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128003155.GK1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

->d_revalidate() series, along with ->d_iname preliminary work.
One trivial conflict in fs/afs/dir.c - afs_do_lookup_one() has lost
one argument in mainline and switched another from dentry to qstr
in this series.

Change since the previous variant: made external_name.name word-aligned
and explicitly documented the layout constraints for struct external_name.

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-revalidate

for you to fetch changes up to 30d61efe118cad1a73ad2ad66a3298e4abdf9f41:

  9p: fix ->rename_sem exclusion (2025-01-27 19:25:24 -0500)

----------------------------------------------------------------
Provide stable parent and name to ->d_revalidate() instances

Most of the filesystem methods where we care about dentry name
and parent have their stability guaranteed by the callers;
->d_revalidate() is the major exception.

It's easy enough for callers to supply stable values for
expected name and expected parent of the dentry being
validated.  That kills quite a bit of boilerplate in
->d_revalidate() instances, along with a bunch of races
where they used to access ->d_name without sufficient
precautions.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (20):
      make sure that DNAME_INLINE_LEN is a multiple of word size
      dcache: back inline names with a struct-wrapped array of unsigned long
      make take_dentry_name_snapshot() lockless
      dissolve external_name.u into separate members
      ext4 fast_commit: make use of name_snapshot primitives
      generic_ci_d_compare(): use shortname_storage
      Pass parent directory inode and expected name to ->d_revalidate()
      afs_d_revalidate(): use stable name and parent inode passed by caller
      ceph_d_revalidate(): use stable parent inode passed by caller
      ceph_d_revalidate(): propagate stable name down into request encoding
      fscrypt_d_revalidate(): use stable parent inode passed by caller
      exfat_d_revalidate(): use stable parent inode passed by caller
      vfat_revalidate{,_ci}(): use stable parent inode passed by caller
      fuse_dentry_revalidate(): use stable parent inode and name passed by caller
      gfs2_drevalidate(): use stable parent inode and name passed by caller
      nfs{,4}_lookup_validate(): use stable parent inode passed by caller
      nfs: fix ->d_revalidate() UAF on ->d_name accesses
      ocfs2_dentry_revalidate(): use stable parent inode and name passed by caller
      orangefs_d_revalidate(): use stable parent inode and name passed by caller
      9p: fix ->rename_sem exclusion

 Documentation/filesystems/locking.rst        |   7 +-
 Documentation/filesystems/porting.rst        |  16 +++++
 Documentation/filesystems/vfs.rst            |  24 ++++++-
 fs/9p/v9fs.h                                 |   2 +-
 fs/9p/vfs_dentry.c                           |  26 ++++++-
 fs/afs/dir.c                                 |  40 ++++-------
 fs/ceph/dir.c                                |  25 ++-----
 fs/ceph/mds_client.c                         |   9 ++-
 fs/ceph/mds_client.h                         |   2 +
 fs/coda/dir.c                                |   3 +-
 fs/crypto/fname.c                            |  22 ++----
 fs/dcache.c                                  | 103 ++++++++++++++++-----------
 fs/ecryptfs/dentry.c                         |  18 +++--
 fs/exfat/namei.c                             |  11 +--
 fs/ext4/fast_commit.c                        |  29 ++------
 fs/ext4/fast_commit.h                        |   3 +-
 fs/fat/namei_vfat.c                          |  19 +++--
 fs/fuse/dir.c                                |  20 +++---
 fs/gfs2/dentry.c                             |  31 ++++----
 fs/hfs/sysdep.c                              |   3 +-
 fs/jfs/namei.c                               |   3 +-
 fs/kernfs/dir.c                              |   3 +-
 fs/libfs.c                                   |  15 ++--
 fs/namei.c                                   |  18 ++---
 fs/nfs/dir.c                                 |  62 +++++++---------
 fs/nfs/namespace.c                           |   2 +-
 fs/nfs/nfs3proc.c                            |   5 +-
 fs/nfs/nfs4proc.c                            |  20 +++---
 fs/nfs/proc.c                                |   6 +-
 fs/ocfs2/dcache.c                            |  14 ++--
 fs/orangefs/dcache.c                         |  22 +++---
 fs/overlayfs/super.c                         |  22 +++++-
 fs/proc/base.c                               |   6 +-
 fs/proc/fd.c                                 |   3 +-
 fs/proc/generic.c                            |   6 +-
 fs/proc/proc_sysctl.c                        |   3 +-
 fs/smb/client/dir.c                          |   3 +-
 fs/tracefs/inode.c                           |   3 +-
 fs/vboxsf/dir.c                              |   3 +-
 include/linux/dcache.h                       |  23 ++++--
 include/linux/fscrypt.h                      |   7 +-
 include/linux/nfs_xdr.h                      |   2 +-
 tools/testing/selftests/bpf/progs/find_vma.c |   2 +-
 43 files changed, 359 insertions(+), 307 deletions(-)

