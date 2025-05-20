Return-Path: <linux-fsdevel+bounces-49474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15B7ABCE77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 07:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656993AAA85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 05:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8695925A347;
	Tue, 20 May 2025 05:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l+7XOLPd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A034F1C6BE
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747718172; cv=none; b=HmQ3GnuXETG1Ni9mWOCDfo1SyPfLw5r2g4ULvPxxuEglGK6s1S/9Ryx4aEELmshpp9U9gdMxHzaWCqQs7Rl9i6exZVxLJtJMooxvjxGHHALzqUztsiDuPg5ng27QmxuuGeF4OP0mxDAH9umbdDdIV7tIuKRTZojRKT74ihDwDWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747718172; c=relaxed/simple;
	bh=pOeLJYgVVwY6Qw6KFmNhBVQUpZ19g+EsZnha/9udttY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bofOk8B0rXJJHI/iVMkq2NxFYtBT2o5no5Wj+hBVp4q1cxiUr5u8bSxtuZ/ZMfDprqhZoaUuO/oX714/cEVUtldnVxYGyyPipwLn/rtLM9YTlnZqyugxAooqKIYZDDj1j7DC9+LK8gLaaeWPPK0Bz0k3ujp5Ji54L5qcmo048Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l+7XOLPd; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747718167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Dgf3nS6gL7uN94ZVb9SokCJOHrb/S37y754RGVpO+Q=;
	b=l+7XOLPdWR54LJe45UA1vxDQgnJwwtduhI5d2JfuQatCJWWxI9ncGrov+OXBckkNgyt6RZ
	lwiuVsPrrOuMVtb7jQOP2JywmqgYpNYOi2ELRVqukio1ezSn9IW6Ckpv+lbtibXwO8wpU7
	/sAFoNU+1G2MOQxh1AzuaYjfgOx4rqY=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/6] overlayfs + casefolding
Date: Tue, 20 May 2025 01:15:52 -0400
Message-ID: <20250520051600.1903319-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series allows overlayfs and casefolding to safely be used on the
same filesystem by providing exclusion to ensure that overlayfs never
has to deal with casefolded directories.

Currently, overlayfs can't be used _at all_ if a filesystem even
supports casefolding, which is really nasty for users.

Components:

- filesystem has to track, for each directory, "does any _descendent_
  have casefolding enabled"

- new inode flag to pass this to VFS layer

- new dcache methods for providing refs for overlayfs, and filesystem
  methods for safely clearing this flag

- new superblock flag for indicating to overlayfs & dcache "filesystem
  supports casefolding, it's safe to use provided new dcache methods are
  used"

Kent Overstreet (6):
  bcachefs: BCH_INODE_has_case_insensitive
  darray: lift from bcachefs
  fs: SB_CASEFOLD
  fs: dcache locking for exlusion between overlayfs, casefolding
  bcachefs: Hook up d_casefold_enable()
  overlayfs: Support casefolded filesystems

 MAINTAINERS                             |   7 +
 fs/bcachefs/Makefile                    |   1 -
 fs/bcachefs/bcachefs_format.h           |   3 +-
 fs/bcachefs/btree_node_scan_types.h     |   2 +-
 fs/bcachefs/btree_types.h               |   2 +-
 fs/bcachefs/btree_update.c              |   1 +
 fs/bcachefs/btree_write_buffer_types.h  |   2 +-
 fs/bcachefs/disk_accounting_types.h     |   2 +-
 fs/bcachefs/fs.c                        |  45 +++++-
 fs/bcachefs/fsck.c                      |  12 +-
 fs/bcachefs/inode.c                     |   8 +-
 fs/bcachefs/inode.h                     |   2 +-
 fs/bcachefs/inode_format.h              |   7 +-
 fs/bcachefs/journal_io.h                |   2 +-
 fs/bcachefs/journal_sb.c                |   2 +-
 fs/bcachefs/namei.c                     | 166 +++++++++++++++++++++-
 fs/bcachefs/namei.h                     |   5 +
 fs/bcachefs/rcu_pending.c               |   3 +-
 fs/bcachefs/sb-downgrade.c              |   9 +-
 fs/bcachefs/sb-errors_format.h          |   4 +-
 fs/bcachefs/sb-errors_types.h           |   2 +-
 fs/bcachefs/sb-members.h                |   3 +-
 fs/bcachefs/snapshot_types.h            |   3 +-
 fs/bcachefs/subvolume.h                 |   1 -
 fs/bcachefs/thread_with_file_types.h    |   2 +-
 fs/bcachefs/util.h                      |  28 +---
 fs/dcache.c                             | 177 ++++++++++++++++++++++++
 fs/libfs.c                              |   1 +
 fs/overlayfs/params.c                   |  20 ++-
 fs/overlayfs/util.c                     |  19 ++-
 {fs/bcachefs => include/linux}/darray.h |  70 +++++-----
 include/linux/darray_types.h            |  33 +++++
 include/linux/dcache.h                  |  10 ++
 include/linux/fs.h                      |   4 +
 lib/Makefile                            |   2 +-
 {fs/bcachefs => lib}/darray.c           |   9 +-
 36 files changed, 571 insertions(+), 98 deletions(-)
 rename {fs/bcachefs => include/linux}/darray.h (64%)
 create mode 100644 include/linux/darray_types.h
 rename {fs/bcachefs => lib}/darray.c (75%)

-- 
2.49.0


