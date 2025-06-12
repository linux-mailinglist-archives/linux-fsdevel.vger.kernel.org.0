Return-Path: <linux-fsdevel+bounces-51380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D97AD65EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 05:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7755517AB61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 03:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98231DE4EC;
	Thu, 12 Jun 2025 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SiOAZI/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67D61C7008;
	Thu, 12 Jun 2025 03:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749697796; cv=none; b=ZL7i3myO3g3gfJUW5qZ0DpXpYHvDS9iRFGewkC1gvgzxq9Zu1vKD0dsbtZfvQMzLbRzGK/rMsa6rkmQfoLf1htfGhMxJqFr3VwpqEI0aNNIK3MWikO4ZgV8dF7tNVdV0SfjvofNIk+joT947Zu1TqMntXN8k73nzF/e4vF94aSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749697796; c=relaxed/simple;
	bh=DEAKxwEP0f97ZC25btcEwMtoF6tf89fUMdG3w9mXM3M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eqe/ZrDJH9+I/BtbxYg3HM9KoinEiCu/zFXi2A65OVU2NDi4hNujiGyffDB6E2nk9qJ2cRdIxpFNCqpN5NHwwJR/rmdba06bvXaZXZPXHE/vOwML8TrvV4cFNJLiW8YwNPVl5HgJV0ljLIoegv3g3Evpy9kIG0EiSb2IgG4qzLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SiOAZI/F; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=BXA36KNPQbEEnyh5QTb1TwGxDDi7cVRqZPTBPSEO0/0=; b=SiOAZI/FSHrpWKypCGTjk7p7U3
	a7wVK+o9W2wEdpfqqGRW1L9a3jHxv98L2R2nApIHNHIc0L4Ep/a2Lln5fE2I7HhNYDvb3HzFV+3fH
	NmlnL2093VK+gaVxC/gcGFnV2fODnpX6/YIzzXOfPbjEdocVOy4T/akvgezPoEhQCrLNpMrSfdQMW
	Ppqj2PbZ3QMxOOzfoFIJu7CpcNhm3xgBkzktfdrisAZg3bh+s20aB3C8ie7IE9RYQpYip5fglYQ8h
	FQNJ1Lewfq6OGUUIyjUtmhmp+YooBsRxyRPKG0rR3+PHSWpS5EWUnH6DMZCt/1RoKR+GWg8PmGe1O
	6wNzqGqA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPYK7-00000009fQA-0j2w;
	Thu, 12 Jun 2025 03:09:51 +0000
Date: Thu, 12 Jun 2025 04:09:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-security-module@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCHES][CFR][CFT] securityfs cleanups and fixes
Message-ID: <20250612030951.GC1647736@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Resurrected and somewhat fixed series of securityfs
cleanups and fixes:

* one extra reference is enough to pin a dentry down; no need
for two.  Switch to regular scheme, similar to shmem, debugfs,
etc. - that fixes securityfs_recursive_remove() dentry leak,
among other things.

* we need to have the filesystem pinned to prevent the contents
disappearing; what we do not need is pinning it for each file.
Doing that only for files and directories in the root is enough.

* the previous two changes allow to get rid of the racy kludges
in efi_secret_unlink(), where we can use simple_unlink() instead
of securityfs_remove().  Which does not require unlocking and
relocking the parent, with all deadlocks that invites.

* Make securityfs_remove() take the entire subtree out, turning
securityfs_recursive_remove() into its alias.  Makes a lot more
sense for callers and fixes a mount leak, while we are at it.

* Making securityfs_remove() remove the entire subtree allows for
much simpler life in most of the users - efi_secret, ima_fs,
evm, ipe, tmp get cleaner.  I hadn't touched apparmor use of
securityfs, but I suspect that it would be useful there as well.

Branch (6.16-rc1-based) lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.securityfs
Individual patches in followups.

Help with testing and review would be very welcome.

Shortlog:
      securityfs: don't pin dentries twice, once is enough...
      securityfs: pin filesystem only for objects directly in root
      fix locking in efi_secret_unlink()
      make securityfs_remove() remove the entire subtree
      efi_secret: clean securityfs use up
      ima_fs: don't bother with removal of files in directory we'll be removing
      ima_fs: get rid of lookup-by-dentry stuff
      evm_secfs: clear securityfs interactions
      ipe: don't bother with removal of files in directory we'll be removing
      tpm: don't bother with removal of files in directory we'll be removing

Diffstat:

 drivers/char/tpm/eventlog/common.c        |  46 +++-------
 drivers/virt/coco/efi_secret/efi_secret.c |  47 ++--------
 include/linux/security.h                  |   3 +-
 include/linux/tpm.h                       |   2 +-
 security/inode.c                          |  62 +++++---------
 security/integrity/evm/evm_secfs.c        |  15 ++--
 security/integrity/ima/ima_fs.c           | 137 +++++++-----------------------
 security/ipe/fs.c                         |  32 +++----
 security/ipe/policy_fs.c                  |   4 +-
 9 files changed, 97 insertions(+), 251 deletions(-)


