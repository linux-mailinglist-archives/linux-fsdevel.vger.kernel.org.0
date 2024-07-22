Return-Path: <linux-fsdevel+bounces-24053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABD9938C99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 11:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7B81C23BF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 09:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C165B16DC19;
	Mon, 22 Jul 2024 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="eeof3l0V";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="rBuwuXjf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995816DC14;
	Mon, 22 Jul 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641607; cv=none; b=r9GXatnLZeSjT3t2ajnESe48L03K3sVHg9DGlIlFXIKIUIKYFFLnd/hDD54dh54Uarmyrr3arXIftmPiFGDiJqsqlPzXhDECXDFrqG3m+sOa0BvoKYb7qa5RZk6zY3+VQdb/1K5xzUcdjI0Ym/luwWUaJjI7kyNiDCOgcaoeRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641607; c=relaxed/simple;
	bh=Kt7HXDwiBElWrJm6zss/fQS8BGnuWpL711k4K31mkrM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nsAG8bRyuPVsQbogMCsIxwBGeQHiGHTjQc4Yam74bIWoVdrbOpmiWfYW2j4GYSvMMHHAX7jti72MyO2/GcyUd5TVv+zDsoRkBcPR+5YCPOaFRg3IJTU5dWOUGD1RWHOd5kFvKXLnN4pdQ0yQYqVDSiH6eRpNZNMBMawE+a5AM+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=eeof3l0V; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=rBuwuXjf; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 85FC72112;
	Mon, 22 Jul 2024 09:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1721640731;
	bh=46lCVp8tQR5E4Pu8GCe1wMNMKnaWMfCUEAu6zS+CavQ=;
	h=From:To:CC:Subject:Date;
	b=eeof3l0VLtUkU1jCO9RBU1lDU8NMpCRE9JqcTj5VIcWlwbrVsUs1JvBH/T3DNr5Ao
	 qWXd/pc1wTGm0Cn8272Ma/oQQpIyEml4SA9qsGrw5OI8OTEsS/cbTd57hhSQnWXpYQ
	 vy8zfGpoS/hWabDh1BlJnLiLCYYQuPtyte6A5Mm4=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 5E8672185;
	Mon, 22 Jul 2024 09:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1721641227;
	bh=46lCVp8tQR5E4Pu8GCe1wMNMKnaWMfCUEAu6zS+CavQ=;
	h=From:To:CC:Subject:Date;
	b=rBuwuXjfdhdjnkH3sLz46Txhw+ac3EIeqZuqugNb8BsWZr2nk5KiLGEDqIZcZgpJf
	 OcYc0BlN/hNQTtSk0tmbW/K+GRJRmWGLu/Xjqzq7x0FeSTE4Bt7N/JG9SSaoExPTZa
	 9mDRWu/m/VgBHxSO2MSz7PZJI2pqliWpo6my2izo=
Received: from ntfs3vm.paragon-software.com (192.168.211.13) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 22 Jul 2024 12:40:26 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ntfs3: bugfixes for 6.11
Date: Mon, 22 Jul 2024 12:40:14 +0300
Message-ID: <20240722094014.16888-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Please pull this branch containing ntfs3 code for 6.11.

All changed code was in linux-next branch for several weeks.
 
Regards,
Konstantin

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.11

for you to fetch changes up to 911daf695a740d9a58daef65dabfb5f69f18190f:

  fs/ntfs3: Fix formatting, change comments, renaming (2024-07-11 12:19:46 +0300)

----------------------------------------------------------------
ntfs3 changes for 6.11-rc1

Added:
    simple fileattr has been implement.
Fixed:
    transform resident to nonresident for compressed files;
    the format of the "nocase" mount option;
    getting file type;
    many other internal bugs.
Refactored:
    unused function and macros have been removed;
    partial transition from page to folio (suggested by Matthew Wilcox);
    legacy ntfs support.

----------------------------------------------------------------
Andy Shevchenko (1):
      fs/ntfs3: Drop stray '\' (backslash) in formatting string

Huacai Chen (1):
      fs/ntfs3: Update log->page_{mask,bits} if log->page_size changed

Konstantin Komarov (29):
      fs/ntfs3: Remove unused function
      fs/ntfs3: Merge synonym COMPRESSION_UNIT and NTFS_LZNT_CUNIT
      fs/ntfs3: Simplify initialization of $AttrDef and $UpCase
      fs/ntfs3: Use macros NTFS_LABEL_MAX_LENGTH instead of hardcoded value
      fs/ntfs3: Remove unused macros MAXIMUM_REPARSE_DATA_BUFFER_SIZE
      fs/ntfs3: Fix transform resident to nonresident for compressed files
      fs/ntfs3: Deny getting attr data block in compressed frame
      fs/ntfs3: Missed NI_FLAG_UPDATE_PARENT setting
      fs/ntfs3: Fix getting file type
      fs/ntfs3: Remove sync_blockdev_nowait()
      fs/ntfs3: Add missing .dirty_folio in address_space_operations
      fs/ntfs3: Fix attr_insert_range at end of file
      fs/ntfs3: Replace inode_trylock with inode_lock
      fs/ntfs3: One more reason to mark inode bad
      fs/ntfs3: Correct undo if ntfs_create_inode failed
      fs/ntfs3: Add a check for attr_names and oatbl
      fs/ntfs3: Rename variables
      fs/ntfs3: Add some comments
      fs/ntfs3: Fix field-spanning write in INDEX_HDR
      fs/ntfs3: Fix the format of the "nocase" mount option
      fs/ntfs3: Missed error return
      fs/ntfs3: Keep runs for $MFT::$ATTR_DATA and $MFT::$ATTR_BITMAP
      fs/ntfs3: Do copy_to_user out of run_lock
      fs/ntfs3: Check more cases when directory is corrupted
      fs/ntfs3: Minor ntfs_list_ea refactoring
      fs/ntfs3: Use function file_inode to get inode from file
      fs/ntfs3: Redesign legacy ntfs support
      fs/ntfs3: Implement simple fileattr
      fs/ntfs3: Fix formatting, change comments, renaming

Matthew Wilcox (Oracle) (10):
      ntfs3: Convert ntfs_read_folio to use a folio
      ntfs3: Convert ntfs_write_begin to use a folio
      ntfs3: Convert attr_data_read_resident() to take a folio
      ntfs3: Convert ntfs_write_end() to work on a folio
      ntfs3: Convert attr_data_write_resident to use a folio
      ntfs3: Convert attr_make_nonresident to use a folio
      ntfs3: Remove calls to set/clear the error flag
      ntfs3: Convert ntfs_get_frame_pages() to use a folio
      ntfs3: Convert ni_readpage_cmpr() to take a folio
      ntfs3: Convert attr_wof_frame_info() to use a folio

lei lu (1):
      fs/ntfs3: Validate ff offset

 fs/ntfs3/attrib.c  | 132 ++++++++++++++++++++++++++++-------------------------
 fs/ntfs3/bitmap.c  |   2 +-
 fs/ntfs3/dir.c     |  57 ++++++++++++++---------
 fs/ntfs3/file.c    | 124 +++++++++++++++++++++++++++++++++++++------------
 fs/ntfs3/frecord.c | 110 +++++++++++++++++++++++++++++++++++---------
 fs/ntfs3/fslog.c   |  77 +++++++++++++++++++++----------
 fs/ntfs3/fsntfs.c  |  11 +++--
 fs/ntfs3/index.c   |   4 +-
 fs/ntfs3/inode.c   | 119 ++++++++++++++++++++++++-----------------------
 fs/ntfs3/namei.c   |   6 +--
 fs/ntfs3/ntfs.h    |  15 ++----
 fs/ntfs3/ntfs_fs.h |  36 ++++++---------
 fs/ntfs3/super.c   |  71 +++++++++++-----------------
 fs/ntfs3/xattr.c   |  25 +++++-----
 14 files changed, 480 insertions(+), 309 deletions(-)

