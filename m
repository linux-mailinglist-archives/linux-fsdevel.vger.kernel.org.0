Return-Path: <linux-fsdevel+bounces-10955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1909E84F604
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D43BB26076
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 13:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B04D3F9CE;
	Fri,  9 Feb 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="FVzXbfAl";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="hZHTL1FN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6BB37703;
	Fri,  9 Feb 2024 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485399; cv=none; b=QuFI4QHIRL4zgzsipncTelU76nOVc7VW8ytrSANM3G/7NCcpv/bPSRSqxb+U8qMGAwnEcOT5ffBEKpGLPpW4AeD9qiJaIMk2X1CsYV5BouE7Nq/Nxx7lSQtNdc1R0xwdnXy3fkCA0WBTYINroGJlnE0x9ng//gU0lcf0t9wn5lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485399; c=relaxed/simple;
	bh=0SWT6R7olskxkBIvu3X8JlolZrl7KdkoDmusDzt+0fk=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=jlG8qJV1hjnzwWNo4FT2onna0/gekEhC5qupLYPOrV2TO2O3y55spGJFhbIC7a9MGxs3J8oc36mru1lI0NXHRew8XyL+O6imOqmMmFlKN2PD4FebR9sCG1Uut4v04uQFnLtZan/A4yjXWXkQSuQnE7W1KZuRbflQqW3y5comt3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=FVzXbfAl; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=hZHTL1FN; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E74842138;
	Fri,  9 Feb 2024 13:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1707484448;
	bh=uuYj/CcYFjQxlauFBkgaaaXBEDed4li6W5TordQET3o=;
	h=Date:To:CC:From:Subject;
	b=FVzXbfAlmVhsag5ff502I69Ah8zd+/Blpp4xzH8xqhaksH+jQ5p8qhLeFSBJVNW4U
	 8CUAXBR6oLF8LnPFKEVrWQVQofEwYr8p8noCmjEpLuHHTtBS7dmuXrZtuWmhbgKpOx
	 1n/O5Ret0V3o6H/rVf3jkBC+GhwBcU6Dhv+DIYmM=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id AA9AF21E2;
	Fri,  9 Feb 2024 13:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1707484863;
	bh=uuYj/CcYFjQxlauFBkgaaaXBEDed4li6W5TordQET3o=;
	h=Date:To:CC:From:Subject;
	b=hZHTL1FNyzbwt5yxm4eQ1cCdVJcRgjNhISS+RiqdVPNOeXufg9Eo06cJzaw5sowU4
	 HRcxivHSwIQ0ScYAxEeOFOGXYb6kkhCzvd1WEogqeebFXHGSckDad2YJCQa6sRNqfK
	 43+AKRDjTAZHyOgZABj+BgeCGNCtnTH4bZcuxuDo=
Received: from [192.168.211.75] (192.168.211.75) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 9 Feb 2024 16:21:03 +0300
Message-ID: <b586e5a4-5a12-412d-bed0-d3a8f630bbdb@paragon-software.com>
Date: Fri, 9 Feb 2024 16:21:02 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [GIT PULL] ntfs3: bugfixes for 6.8
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Hi Linus,

Please pull this branch containing ntfs3 code for 6.8.

Fixed:
- size update for compressed file;
- some logic errors, overflows;
- memory leak;
- some code was refactored.

Added:
- implement super_operations::shutdown.

Improved:
- alternative boot processing;
- reduced stack usage.

All changed code was in linux-next branch for at least week.

Regards,

Konstantin

----------------------------------------------------------------

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

    Linux 6.7-rc4 (Sun Dec 3 18:52:56 2023 +0900)

are available in the Git repository at:

    https://github.com/Paragon-Software-Group/linux-ntfs3.git ntfs3_for_6.8

for you to fetch changes up to 622cd3daa8eae37359a6fd3c07c36d19f66606b5:

    fs/ntfs3: Slightly simplify ntfs_inode_printk() (Fri Nov 10 20:59:22 
2023 +0100)

----------------------------------------------------------------

Christophe JAILLET (1):
   fs/ntfs3: Slightly simplify ntfs_inode_printk()

Dan Carpenter (1):
   fs/ntfs3: Fix an NULL dereference bug

Edward Adam Davis (1):
   fs/ntfs3: Fix oob in ntfs_listxattr

Ism Hong (1):
   fs/ntfs3: use non-movable memory for ntfs3 MFT buffer cache

Konstantin Komarov (23):
   fs/ntfs3: Improve alternative boot processing
   fs/ntfs3: Modified fix directory element type detection
   fs/ntfs3: Improve ntfs_dir_count
   fs/ntfs3: Correct hard links updating when dealing with DOS names
   fs/ntfs3: Print warning while fixing hard links count
   fs/ntfs3: Reduce stack usage
   fs/ntfs3: Fix multithreaded stress test
   fs/ntfs3: Fix detected field-spanning write (size 8) of single field 
"le->name"
   fs/ntfs3: Correct use bh_read
   fs/ntfs3: Add file_modified
   fs/ntfs3: Drop suid and sgid bits as a part of fpunch
   fs/ntfs3: Implement super_operations::shutdown
   fs/ntfs3: ntfs3_forced_shutdown use int instead of bool
   fs/ntfs3: Add and fix comments
   fs/ntfs3: Add NULL ptr dereference checking at the end of 
attr_allocate_frame()
   fs/ntfs3: Fix c/mtime typo
   fs/ntfs3: Disable ATTR_LIST_ENTRY size check
   fs/ntfs3: Use kvfree to free memory allocated by kvmalloc
   fs/ntfs3: Prevent generic message "attempt to access beyond end of 
device"
   fs/ntfs3: Use i_size_read and i_size_write
   fs/ntfs3: Correct function is_rst_area_valid
   fs/ntfs3: Fixed overflow check in mi_enum_attr()
   fs/ntfs3: Update inode->i_size after success write into compressed file

Nekun (1):
   fs/ntfs3: Add ioctl operation for directories (FITRIM)

  fs/ntfs3/attrib.c   |  45 +++++----
  fs/ntfs3/attrlist.c |  12 +--
  fs/ntfs3/bitmap.c   |   4 +-
  fs/ntfs3/dir.c      |  48 ++++++---
  fs/ntfs3/file.c     |  76 +++++++++++----
  fs/ntfs3/frecord.c  |  19 ++--
  fs/ntfs3/fslog.c    | 232 ++++++++++++++++++++------------------------
  fs/ntfs3/fsntfs.c   |  29 +++++-
  fs/ntfs3/index.c    |   8 +-
  fs/ntfs3/inode.c    |  32 ++++--
  fs/ntfs3/namei.c    |  12 +++
  fs/ntfs3/ntfs.h     |   4 +-
  fs/ntfs3/ntfs_fs.h  |  29 +++---
  fs/ntfs3/record.c   |  18 +++-
  fs/ntfs3/super.c    |  54 ++++++-----
  fs/ntfs3/xattr.c    |   6 ++
  16 files changed, 381 insertions(+), 247 deletions(-)



