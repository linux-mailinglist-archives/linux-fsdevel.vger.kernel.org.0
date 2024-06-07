Return-Path: <linux-fsdevel+bounces-21188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4D6900352
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DEA31F2589F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA94915B0F8;
	Fri,  7 Jun 2024 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="YfSuLUDw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC63C190671;
	Fri,  7 Jun 2024 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762876; cv=none; b=bPinW5Am+0zN212GeROvMQqxN6rx4fDm3pFJCIflQDz5IHzyvJgkCH5CBZLcdTYgDblsNN2qUa6WIiAcYZBHLqZnWDO5cDv1A10eXC/a6801PsAqDuQCoV+K/nfB95E0vR6Z/Kru/2eHz0uQtvo+25U48FkzYc16CHTvkPVym/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762876; c=relaxed/simple;
	bh=/gK4O9KED9yrnf/gSG2DTQtU6MiwcridNdTEW7QxQwc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NEHXliyHz407NNY7+gVRBMV8bdOMXFWlcaqO0f6HjU0U5i5Yl0OSiFlgaOUvD0nmeipoJkPazD56AmLBnTZd9f8XFNQMm0be66aAi7Tb9TkJtoQxed3erc/r+niutPLpKPjRZWvHkGH39FOyKwOg4N++9doYXN7eHBmsuycwUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=YfSuLUDw; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8D16420F4;
	Fri,  7 Jun 2024 12:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762088;
	bh=4Ju74zVs6D+c25lpMht9yFcmUBTQmdjcClBi1c4dJYk=;
	h=From:To:CC:Subject:Date;
	b=YfSuLUDwlmCUs6TwfZspSCJUkGCmOjwWiZv9xL6eybA73A+1eHxCLlKq+V2KnRlVo
	 d6oU5PWmPuuuYnatcqEugJ0WMl3oqtkIK0f7uLQfniARuFcChvdvWyojEM4TQUESNw
	 B0F/dd1Py2jWxe9ON+rlMDEK/rO/8/NKZrKFJT+0=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:02 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 00/18] Bugfix​ and refactoring
Date: Fri, 7 Jun 2024 15:15:30 +0300
Message-ID: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Fixed the type identification of directory elements during enumeration.
Fixed the behavior under edge cases.
Added attr checks in log replay.
Removed unused function, MACRO.

Konstantin Komarov (18):
  fs/ntfs3: Remove unused function
  fs/ntfs3: Simplify initialization of $AttrDef and $UpCase
  fs/ntfs3: Fix transform resident to nonresident for compressed files
  fs/ntfs3: Deny getting attr data block in compressed frame
  fs/ntfs3: Missed NI_FLAG_UPDATE_PARENT setting
  fs/ntfs3: Fix getting file type
  fs/ntfs3: Add missing .dirty_folio in address_space_operations
  fs/ntfs3: Fix attr_insert_range at end of file
  fs/ntfs3: Replace inode_trylock with inode_lock
  fs/ntfs3: One more reason to mark inode bad
  fs/ntfs3: Correct undo if ntfs_create_inode failed
  fs/ntfs3: Add a check for attr_names and oatbl
  fs/ntfs3: Use macros NTFS_LABEL_MAX_LENGTH instead of hardcoded value
  fs/ntfs3: Merge synonym COMPRESSION_UNIT and NTFS_LZNT_CUNIT
  fs/ntfs3: Remove sync_blockdev_nowait()
  fs/ntfs3: Remove unused macros MAXIMUM_REPARSE_DATA_BUFFER_SIZE
  fs/ntfs3: Rename variables
  fs/ntfs3: Add some comments

 fs/ntfs3/attrib.c  | 36 ++++++++++++++++++++-----
 fs/ntfs3/dir.c     |  3 ++-
 fs/ntfs3/file.c    |  5 +---
 fs/ntfs3/frecord.c |  6 +++--
 fs/ntfs3/fslog.c   | 64 +++++++++++++++++++++++++++++++--------------
 fs/ntfs3/fsntfs.c  | 11 ++++----
 fs/ntfs3/inode.c   | 43 +++++++++++++++++-------------
 fs/ntfs3/ntfs.h    |  6 -----
 fs/ntfs3/ntfs_fs.h | 18 +------------
 fs/ntfs3/super.c   | 65 ++++++++++++++++++----------------------------
 10 files changed, 137 insertions(+), 120 deletions(-)

-- 
2.34.1


