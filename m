Return-Path: <linux-fsdevel+bounces-70553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EED77C9F03D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 13:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C92364E14CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 12:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D6A2E4258;
	Wed,  3 Dec 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="vMVf4Rgp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D08286D7C;
	Wed,  3 Dec 2025 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764765767; cv=none; b=pIcvmWnUjajyb3tBNKwF2Q5EpKz3wsOP5BN74lvkZKR/z89+yj4pXYy1Om4cbkzJTXU1OmmO0Nb6YcIGPNDD+BxORKLYoiAtD0cJu3xRFQy0lNCXXO6E6dgR6Fkp+uOEgJf5NtiVRfaO9uxjUpDRfG+LzfPEkuB8pNHPRcvco7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764765767; c=relaxed/simple;
	bh=T/GMN2CoicBMxKviotgm59sRN9N20o6l00AaDCeqqZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZZD9dgLNTrc7y3+qUIdpAjyzgMlfHslimE/5x+ASkZYJfIPldc4TwrLjs+ndgI/uK7E4hP6ptc3qNbdxawNUZcTj5/+ik9C7SIYa0XFeJWWKhwevQZ38xUmI7tzY6/t3DU055WOw+8x0N9Wuocw4mXfTBANhA87hkDssGQ9K8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=vMVf4Rgp; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id D3D55454;
	Wed,  3 Dec 2025 12:38:58 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=vMVf4Rgp;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 931E023A7;
	Wed,  3 Dec 2025 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1764765757;
	bh=tlGoE/4tQaTLBpIgMTrYF+GSd2ljfVvzSbK6eRlF3h0=;
	h=From:To:CC:Subject:Date;
	b=vMVf4RgpVyD+M2QyXNkVzDwVfnM+F+WS9yh9HmLrUl8tAVTlFUp0fvWft91TKCi92
	 feEWJ9lxclDblWXP5Vd44CyDph6/WS3uetY/4Y3n+3ZQ+6ETPUOr/3mQH9rl7VbmVn
	 iqU+Rwf30NoUklTwHOA9TU/CrxKkqFS1kDb87Qd4=
Received: from localhost.localdomain (172.30.20.142) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 3 Dec 2025 15:42:36 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ntfs3: bugfixes for 6.19
Date: Wed, 3 Dec 2025 13:42:28 +0100
Message-ID: <20251203124228.6082-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Please pull this branch containing ntfs3 code for 6.19. There are more 
patches than usual this time.

Regards,
Konstantin

----------------------------------------------------------------
The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.19

for you to fetch changes up to 1b2ae190ea43bebb8c73d21f076addc8a8c71849:

  fs/ntfs3: check for shutdown in fsync (2025-11-19 09:21:36 +0100)

----------------------------------------------------------------
Changes for 6.19-rc1

Added:
    support timestamps prior to epoch;
    do not overwrite uptodate pages;
    disable readahead for compressed files;
    setting of dummy blocksize to read boot_block when mounting;
    the run_lock initialization when loading $Extend;
    initialization of allocated memory before use;
    support for the NTFS3_IOC_SHUTDOWN ioctl;
    check for minimum alignment when performing direct I/O reads;
    check for shutdown in fsync.

Fixed:
    mount failure for sparse runs in run_unpack();
    use-after-free of sbi->options in cmp_fnames;
    KMSAN uninit bug after failed mi_read in mi_format_new;
    uninit error after buffer allocation by __getname();
    KMSAN uninit-value in ni_create_attr_list;
    double free of sbi->options->nls and ownership of fc->fs_private;
    incorrect vcn adjustments in attr_collapse_range();
    mode update when ACL can be reduced to mode;
    memory leaks in add sub record.

Changed:
    refactor code, updated terminology, spelling;
    do not kmap pages in (de)compression code;
    after ntfs_look_free_mft(), code that fails must put mi;
    default mount options for "acl" and "prealloc".

Replaced:
    use unsafe_memcpy() to avoid memcpy size warning;
    ntfs_bio_pages with page cache for compressed files.

----------------------------------------------------------------
Bartlomiej Kubik (1):
      fs/ntfs3: Initialize allocated memory before use

Colin Ian King (1):
      fs/ntfs3: Fix spelling mistake "recommened" -> "recommended"

Edward Adam Davis (3):
      ntfs3: init run lock for extend inode
      fs/ntfs3: out1 also needs to put mi
      fs/ntfs3: Prevent memory leaks in add sub record

Konstantin Komarov (11):
      fs/ntfs3: Support timestamps prior to epoch
      fs/ntfs3: Reformat code and update terminology
      fs/ntfs3: fix mount failure for sparse runs in run_unpack()
      fs/ntfs3: disable readahead for compressed files
      fs/ntfs3: remove ntfs_bio_pages and use page cache for compressed I/O
      fs/ntfs3: correct attr_collapse_range when file is too fragmented
      fs/ntfs3: implement NTFS3_IOC_SHUTDOWN ioctl
      fs/ntfs3: check minimum alignment for direct I/O
      fs/ntfs3: update mode in xattr when ACL can be reduced to mode
      fs/ntfs3: change the default mount options for "acl" and "prealloc"
      fs/ntfs3: check for shutdown in fsync

Lizhi Xu (1):
      ntfs3: avoid memcpy size warning

Matthew Wilcox (Oracle) (3):
      ntfs: Do not kmap pages used for reading from disk
      ntfs: Do not kmap page cache pages for compression
      ntfs: Do not overwrite uptodate pages

Nirbhay Sharma (1):
      fs/ntfs3: fix KMSAN uninit-value in ni_create_attr_list

Pedro Demarchi Gomes (1):
      ntfs: set dummy blocksize to read boot_block when mounting

Raphael Pinsonneault-Thibeault (1):
      ntfs3: fix uninit memory after failed mi_read in mi_format_new

Sidharth Seela (1):
      ntfs3: Fix uninit buffer allocated by __getname()

YangWen (2):
      ntfs3: fix use-after-free of sbi->options in cmp_fnames
      ntfs3: fix double free of sbi->options->nls and clarify ownership of fc->fs_private

 fs/ntfs3/attrib.c  |  88 ++++++++++-----------
 fs/ntfs3/dir.c     |   3 +-
 fs/ntfs3/file.c    | 109 ++++++++++++++++++++++----
 fs/ntfs3/frecord.c | 219 +++++++++++++++++++----------------------------------
 fs/ntfs3/fsntfs.c  | 132 +++++++++++++++-----------------
 fs/ntfs3/index.c   |   3 +-
 fs/ntfs3/inode.c   |  27 ++++---
 fs/ntfs3/namei.c   |   6 +-
 fs/ntfs3/ntfs_fs.h |  40 ++++++----
 fs/ntfs3/record.c  |   2 +-
 fs/ntfs3/run.c     |  17 ++++-
 fs/ntfs3/super.c   |  88 ++++++++++++++++-----
 fs/ntfs3/xattr.c   |  18 ++++-
 13 files changed, 421 insertions(+), 331 deletions(-)

