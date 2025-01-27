Return-Path: <linux-fsdevel+bounces-40135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9016DA1D06F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 05:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF42D166042
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 04:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE081FC0E4;
	Mon, 27 Jan 2025 04:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rJA0XLgd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81F4433CE;
	Mon, 27 Jan 2025 04:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737953247; cv=none; b=KBeOfIGH14+y31xq8LUEu/UEjrmbDiG3UPYy66wFkClsc0GofisLYE1z7okJQd5ySAUMQNcKtmOvFBsE0CUknWqtoddK+i/UAJtcOw17dfidJL6xMZIqm6DsITmdt0CX89vFPNMcF3ArzRQ0NHfHy5bF+Df3LSfHQSlHGMpcE70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737953247; c=relaxed/simple;
	bh=WOET3+WbZGbtQ7sJs0e9MZLjGBT6cIOmHPs605LSAXU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D9PKDu/Yirk0MCPvQRyuDDxMErok7dMe8Pj0hhHqoc5nqmn3Es2blWMOb0GRS49X0Im3bjuPpxa9Mu0DIynpBycGydytBIw/lJ7dGktAtvEmiRMf603P7WG95L9wfwWL5BZdgTjDg5ARZzzaTSLbzE0y7/L7879F0rgw+b+KBzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rJA0XLgd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ev8TnygpaDr4yF2/c3TBKgTbR9Cd9AXaLDIlqoNiskk=; b=rJA0XLgdWoELLv7dg3BNlKDpff
	8SaO86t4OAn9RptOrwxvcnC0WGwO5bQo+7oBO6rVYwKrsoHHz9kuIp+IuFghNOrMttUtJcsg4T1dc
	m6RoXzTebeNKfrvpa4Vr9OVU7WIFCYlXQ0//7m1dNlVuxk3gPrNrzgI49QMpk7AZN4l3/Qgo0g0Qw
	KIijIdJuQuaWUEcaf5H2ch0hGTt4GVLXHN/guOIK1hyN1rell7KkVUUYO+2IHsKOVSzRzJtai8Czf
	xwDBZAR1iNQ/GAFsE94TVBv6zEmBtC9ek/x68zgaut61W32BQvb9h4tyb9Hram7AoM45QKnboyPWo
	k7TPcAew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcH1t-0000000CsDn-109Z;
	Mon, 27 Jan 2025 04:47:21 +0000
Date: Mon, 27 Jan 2025 04:47:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] d_revalidate pile
Message-ID: <20250127044721.GD1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

->d_revalidate() series, along with ->d_iname preliminary work.
One trivial conflict in fs/afs/dir.c - afs_do_lookup_one() has lost
one argument in mainline and switched another from dentry to qstr
in this series.

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-revalidate

for you to fetch changes up to a8ea90bfec66b239dad9a478fc444aa32d3961bc:

  9p: fix ->rename_sem exclusion (2025-01-25 11:51:57 -0500)

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

 Documentation/filesystems/locking.rst        |  7 +-
 Documentation/filesystems/porting.rst        | 16 +++++
 Documentation/filesystems/vfs.rst            | 24 ++++++-
 fs/9p/v9fs.h                                 |  2 +-
 fs/9p/vfs_dentry.c                           | 26 +++++++-
 fs/afs/dir.c                                 | 40 ++++--------
 fs/ceph/dir.c                                | 25 ++------
 fs/ceph/mds_client.c                         |  9 ++-
 fs/ceph/mds_client.h                         |  2 +
 fs/coda/dir.c                                |  3 +-
 fs/crypto/fname.c                            | 22 ++-----
 fs/dcache.c                                  | 95 ++++++++++++++++------------
 fs/ecryptfs/dentry.c                         | 18 ++++--
 fs/exfat/namei.c                             | 11 +---
 fs/ext4/fast_commit.c                        | 29 ++-------
 fs/ext4/fast_commit.h                        |  3 +-
 fs/fat/namei_vfat.c                          | 19 +++---
 fs/fuse/dir.c                                | 20 +++---
 fs/gfs2/dentry.c                             | 31 ++++-----
 fs/hfs/sysdep.c                              |  3 +-
 fs/jfs/namei.c                               |  3 +-
 fs/kernfs/dir.c                              |  3 +-
 fs/libfs.c                                   | 15 +++--
 fs/namei.c                                   | 18 +++---
 fs/nfs/dir.c                                 | 62 ++++++++----------
 fs/nfs/namespace.c                           |  2 +-
 fs/nfs/nfs3proc.c                            |  5 +-
 fs/nfs/nfs4proc.c                            | 20 +++---
 fs/nfs/proc.c                                |  6 +-
 fs/ocfs2/dcache.c                            | 14 ++--
 fs/orangefs/dcache.c                         | 22 +++----
 fs/overlayfs/super.c                         | 22 ++++++-
 fs/proc/base.c                               |  6 +-
 fs/proc/fd.c                                 |  3 +-
 fs/proc/generic.c                            |  6 +-
 fs/proc/proc_sysctl.c                        |  3 +-
 fs/smb/client/dir.c                          |  3 +-
 fs/tracefs/inode.c                           |  3 +-
 fs/vboxsf/dir.c                              |  3 +-
 include/linux/dcache.h                       | 23 +++++--
 include/linux/fscrypt.h                      |  7 +-
 include/linux/nfs_xdr.h                      |  2 +-
 tools/testing/selftests/bpf/progs/find_vma.c |  2 +-
 43 files changed, 352 insertions(+), 306 deletions(-)

