Return-Path: <linux-fsdevel+bounces-56034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C875B11FB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 16:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B091A1CC52C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 14:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7241DE896;
	Fri, 25 Jul 2025 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="EHENJhpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9710510F1;
	Fri, 25 Jul 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452078; cv=none; b=eizwXm4x40YWLAkLZ4g3BW87TAMtXVgW/M77oyCfzHElDM+Dt0TsLBlAXAwmf9CslSulBE2Kv1WcqvxMbHCPUep94xRiDS3hITI2ZVnSfed+3GMaji/zGwObWVL2k7nspjkahWlRS8bZ4gBfI84ULerm3dXiLrbBUp+QxYQJ1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452078; c=relaxed/simple;
	bh=CU/ofPcM/4/31XAsGzsSMeFb1aVoCrvt6kL7NaWtHiU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B+MnTXuSv5ioR4HEr9GJVn3tHDaMxX4T5NDqJ6/PEGHsqG+QiB/nK70Yq/ITTrb19gIiNoNGuLySOBcNd1TG4r/keaojmEUD4I3a2eMBi7cwpjglNXxJdCpn+QYZqyiOSWe6GyC+oHO46xvSNnM56adu5HIy6VANmlFQhWn2bBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=EHENJhpt; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E69301D1A;
	Fri, 25 Jul 2025 13:52:57 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=EHENJhpt;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id C7FA12302;
	Fri, 25 Jul 2025 13:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1753451661;
	bh=XERKZUg/mSTGqo3b6VJtn4q+/PRdwVrweknVT9vWgnc=;
	h=From:To:CC:Subject:Date;
	b=EHENJhpt+Erc+3kdzeeDpP8aVnliX60cIimbGnBxooKRug3QbnmrkyHP+JBDTpBqL
	 VKtASoDe/nfYuyGEEoEH7H0ATe17p0bHnwr38TbyRqnAGn1LWXsfGV900XCzxLHcSb
	 hscmdNckkIWUi+eVsPhHyV+BPLXG6Noo118Vf4oI=
Received: from localhost.localdomain (172.30.20.191) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 25 Jul 2025 16:54:20 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ntfs3: bugfixes for 6.17
Date: Fri, 25 Jul 2025 15:54:11 +0200
Message-ID: <20250725135411.4064-1-almaz.alexandrovich@paragon-software.com>
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

Please pull this branch containing ntfs3 code for 6.17.

Regards,
Konstantin

----------------------------------------------------------------
The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.17

for you to fetch changes up to a49f0abd8959048af18c6c690b065eb0d65b2d21:

  Revert "fs/ntfs3: Replace inode_trylock with inode_lock" (2025-07-08 09:42:21 +0200)

----------------------------------------------------------------
Changes for 6.17-rc1

Added:
    sanity check for file name;
    mark live inode as bad and avoid any operations.

Fixed:
    handling of symlinks created in windows;
    creation of symlinks for relative path.

Changed:
    cancel setting inode as bad after removing name fails;
    revert "replace inode_trylock with inode_lock".

----------------------------------------------------------------
Edward Adam Davis (1):
      fs/ntfs3: cancle set bad inode after removing name fails

Konstantin Komarov (2):
      fs/ntfs3: Exclude call make_bad_inode for live nodes.
      Revert "fs/ntfs3: Replace inode_trylock with inode_lock"

Lizhi Xu (1):
      fs/ntfs3: Add sanity check for file name

Rong Zhang (2):
      fs/ntfs3: fix symlinks cannot be handled correctly
      fs/ntfs3: correctly create symlink for relative path

 fs/ntfs3/dir.c     |  6 ++--
 fs/ntfs3/file.c    | 37 +++++++++++++++++++++-
 fs/ntfs3/frecord.c | 31 +++++++++++++------
 fs/ntfs3/fsntfs.c  |  6 +++-
 fs/ntfs3/inode.c   | 91 ++++++++++++++++++++++++++++++++++--------------------
 fs/ntfs3/namei.c   | 26 +++++++++++-----
 fs/ntfs3/ntfs.h    |  3 +-
 fs/ntfs3/ntfs_fs.h | 17 ++++++++--
 fs/ntfs3/xattr.c   | 22 +++++++++++--
 9 files changed, 178 insertions(+), 61 deletions(-)

