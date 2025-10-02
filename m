Return-Path: <linux-fsdevel+bounces-63210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C4EBB299B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 08:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC634211C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 06:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DA328D8E8;
	Thu,  2 Oct 2025 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="esLpOTAI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778E62882A6
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385389; cv=none; b=tFxAu/HpG0QceDNsuZ99zHoYVAFtVZKoWXc+kioemS/JCW8DKGXv6vD4653YpKNJWHZrCvOLfxf8pZfN7OUl4NCBUY7+NXP4d+jvOdpAq1+gSxLzoP2iqY2ynixgkUirYntA5SI2CWxCxrZYfj8/ZfcJujPIbpeuCE+G8+30Zjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385389; c=relaxed/simple;
	bh=cT/6S7idR6rfV262PVGnliBCTEXdCt68B95yJlAmt7s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KdrY0a5xfQ4+KgfsV6eVElhXdR8NWRT0hxd5okuZoEmaylG4PbfBlTcnWaroRe2BXmOMeWzVs42RAWMGgpOfiq1odCIEsvVrynmAduIlz8dI6zFO4VbOK81/FJf6R6JiJhwyxr64ZrB2TJVDwFA0OyMC5CBG1WOfTp8NqaMFCUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=esLpOTAI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=zwAGJJvt05VnQt5M/K/pSi8J2hsHBU7Ntzhkq1bg1jo=; b=esLpOTAI23d13KahUAmID0jZI9
	aKhAuG4BRe4ODdrRlbJVawla+RFFo/fq1y7Mb70x3rEss9pAjAewTWU4R1j4vJX9b8dvg4OW0N93G
	yliJa8i1eKi2kvBcPujUGwHitTeS7VnYMCQK4PR3JphXfvMmdcVDaMDrF4N36WVUPUpPsLe/fcnaz
	DGUuJfdziWSc0bTVStAHevMZzWDSGy4q9st0U8WOHgW1EsnvZtU/PFZdXXKNhv81Amb/xeAcU5jqc
	xTgaTxL97ine+OjZ5h3hFuygzntbD1KYWtEx99/PWnD+7tNwORzCX8o0W3wZYrK9/dtRxwgIkYPt0
	xkC/FIRQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4CVc-0000000CY6S-2eqt;
	Thu, 02 Oct 2025 06:09:44 +0000
Date: Thu, 2 Oct 2025 07:09:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [git pull] pile 5: simplifying ->d_name audits, easy part
Message-ID: <20251002060944.GK39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The last vfs-related pull request for tonight; there's an ->f_path counterpart
of that one, but I'd rather leave it for tomorrow - it's trickier and it would
be easier to deal with once work.mount gets merged.

A trivial conflict in fs/afs/internal.h...

The following changes since commit b320789d6883cc00ac78ce83bccbfe7ed58afcf0:

  Linux 6.17-rc4 (2025-08-31 15:33:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-qstr

for you to fetch changes up to 180a9cc3fd6a020746fbd7f97b9b62295a325fd2:

  make it easier to catch those who try to modify ->d_name (2025-09-15 21:08:33 -0400)

----------------------------------------------------------------
	Simplifying ->d_name audits, easy part.

Turn dentry->d_name into an anon union of const struct qsrt (d_name
itself) and a writable alias (__d_name).  With constification of some
struct qstr * arguments of functions that get &dentry->d_name passed
to them, that ends up with all modifications provably done only in
fs/dcache.c (and a fairly small part of it).

Any new places doing modifications will be easy to find - grep for
__d_name will suffice.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (6):
      security_dentry_init_security(): constify qstr argument
      exfat_find(): constify qstr argument
      afs_edit_dir_{add,remove}(): constify qstr argument
      afs_dir_search: constify qstr argument
      generic_ci_validate_strict_name(): constify name argument
      make it easier to catch those who try to modify ->d_name

 fs/afs/dir_edit.c             |  4 ++--
 fs/afs/dir_search.c           |  2 +-
 fs/afs/internal.h             |  6 +++---
 fs/dcache.c                   | 26 +++++++++++++-------------
 fs/exfat/namei.c              |  2 +-
 include/linux/dcache.h        |  5 ++++-
 include/linux/fs.h            |  6 ++++--
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/security.h      |  4 ++--
 security/security.c           |  2 +-
 security/selinux/hooks.c      |  2 +-
 security/smack/smack_lsm.c    |  2 +-
 12 files changed, 34 insertions(+), 29 deletions(-)

