Return-Path: <linux-fsdevel+bounces-45424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324AAA77893
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 12:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF423AB996
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 10:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B849A1F0982;
	Tue,  1 Apr 2025 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="SVbcjRmk";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="U9sHrC78"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08B1E0E13;
	Tue,  1 Apr 2025 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743502511; cv=none; b=BgpEkBDGtkV1KAWigBM158L4f9b5RwBv1oYmR7OQqOVUZyQmdWpd2y0dIvRZrkciKOLiwBOVzkjXVoKd6xOS3F5KQvHoiJNJmVV5YKTDfgLw4FA7Fee5/pLJX7tX+XLXm/9zCEWPQ1cfnqERPFgqAFy5mRBtdeh6lkBKD0ZW2X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743502511; c=relaxed/simple;
	bh=F2vsjXDI66wiWMktYwJdPzRHIUvzmNJpS21AxKHlksE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YwYt2X2IlfvM0lBLSNXdKw7Dq6nM/pL+FONcnfRE5o+Q12bI6L2AWVQitD+zmfLxcSA74Qu4cnXQXPlnEUY1xGpNo+NC6T88C5su/610MrET3rcXv1CJjuolGy5U95rZ1BxBHvjsVGy9OeSccZzoyJro2Rg+d1uG9yYeWZL5h7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=SVbcjRmk; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=U9sHrC78; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id AD80D212F;
	Tue,  1 Apr 2025 10:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1743501997;
	bh=DsaYEb2nVtRuXrpsaOjMkKiSqaCyerjUxjRkdWT/QIE=;
	h=From:To:CC:Subject:Date;
	b=SVbcjRmk0v+p81nQYTrHsDqOw4sB68NfiaiS7vQTtas9YnSkSIxrdnRoixhYJxKgP
	 Sxo9p3rddh4luaQkP4djQ5SKLvi8CQXTlkNG4GGMCREUWgSy6rWaq5de6kwQTtpKn9
	 wroUd7ErWN/hasuD1sQiSMwpXpQ3XPQYR5q9GeXg=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 6E78A25C5;
	Tue,  1 Apr 2025 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1743502123;
	bh=DsaYEb2nVtRuXrpsaOjMkKiSqaCyerjUxjRkdWT/QIE=;
	h=From:To:CC:Subject:Date;
	b=U9sHrC78BSVZ/eVDUxCts0ocSBo+monJg7oaO6lj+swHxijFk0mIlJo9yqquiTQWq
	 j3ip7hMhgdAxM9jn0JrFdG6d6Jf5Sl9TampSrjIIrBRApKIeE8iBJSIxWYjpp2AwEk
	 OIAXOwNSVRvHNA3y7mw0ITx5ad84sMtRAlc/Uuw8=
Received: from ntfs3vm.localdomain (192.168.211.33) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 1 Apr 2025 13:08:42 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ntfs3: bugfixes for 6.15
Date: Tue, 1 Apr 2025 13:08:22 +0300
Message-ID: <20250401100822.40050-1-almaz.alexandrovich@paragon-software.com>
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

Please pull this branch containing ntfs3 code for 6.15.

Regards,
Konstantin

----------------------------------------------------------------
The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.15

for you to fetch changes up to 8b12017c1b9582db8c5833cf08d610e8f810f4b3:

  fs/ntfs3: Remove unused ntfs_flush_inodes (2025-03-06 19:53:28 +0300)

----------------------------------------------------------------
Changes for 6.15-rc1

Fixed:
  integer overflows on 32-bit systems;
  integer overflow in hdr_first_de();
  'proc_info_root' leak when NTFS initialization failed.

Removed:
  unused functions ni_load_attr, ntfs_sb_read, ntfs_flush_inodes.

Changed:
  updated inode->i_mapping->a_ops on compression state;
  ensured atomicity of write operations;
  refactored ntfs_{create/remove}_procdir();
  refactored ntfs_{create/remove}_proc_root().

----------------------------------------------------------------
Dan Carpenter (2):
      fs/ntfs3: Fix a couple integer overflows on 32bit systems
      fs/ntfs3: Prevent integer overflow in hdr_first_de()

Dr. David Alan Gilbert (3):
      fs/ntfs3: Remove unused ni_load_attr
      fs/ntfs3: Remove unused ntfs_sb_read
      fs/ntfs3: Remove unused ntfs_flush_inodes

Edward Adam Davis (1):
      fs/ntfs3: Fix WARNING in ntfs_extend_initialized_size

Konstantin Komarov (1):
      fs/ntfs3: Update inode->i_mapping->a_ops on compression state

Lizhi Xu (1):
      fs/ntfs3: Keep write operations atomic

Ye Bin (3):
      fs/ntfs3: Factor out ntfs_{create/remove}_procdir()
      fs/ntfs3: Factor out ntfs_{create/remove}_proc_root()
      fs/ntfs3: Fix 'proc_info_root' leak when init ntfs failed

 fs/ntfs3/attrib.c  |  3 +-
 fs/ntfs3/file.c    | 42 +++++++++++++++++++-------
 fs/ntfs3/frecord.c | 63 +++-----------------------------------
 fs/ntfs3/fsntfs.c  | 28 -----------------
 fs/ntfs3/index.c   |  4 +--
 fs/ntfs3/inode.c   | 40 ------------------------
 fs/ntfs3/ntfs.h    |  2 +-
 fs/ntfs3/ntfs_fs.h |  6 ----
 fs/ntfs3/super.c   | 89 ++++++++++++++++++++++++++++++++++--------------------
 9 files changed, 96 insertions(+), 181 deletions(-)

