Return-Path: <linux-fsdevel+bounces-20150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6268CEE1C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 09:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED88281FA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 07:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E80611CA0;
	Sat, 25 May 2024 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="R1XLHEd8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5757BE55;
	Sat, 25 May 2024 07:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716621070; cv=none; b=T6dIBAiu+LOYE1roqxTwfyW/WK1qyyYpa44ye73zdDL0ccnVdkKVRg4ch332VuUyIZ/Re4bIKu9njYiHlqGthiD5wvR52yK3etUhMmMd2neX8e52QPsPbpICpn1d2v45Nvx9fagcLYMtT5wAcI8SIr751bpUaK1Pd12m1kiS4yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716621070; c=relaxed/simple;
	bh=lbX4qDZgejEpytYpq0C8e8qHHrz0f/oVYAcVWcvT//I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dHDzQ0tvbRBIcxeBPj2ILGVd8sUDt7/JIOqZ9dBdztqJ999ncectX7n5/oe8OaoxczqOgH4heZVjllzFbH4Gg4O5K1Dm60ShFAEgOBJXQ9l0yMqFvEc5JQ6NYw0jDhphclwLKD4aZA9i+QQgM8z35jivRI7QYoPlX38NmJfzG5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=R1XLHEd8; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 0716B21E0;
	Sat, 25 May 2024 06:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1716620148;
	bh=wAw8ojUEEw2Xao242PKV2SRrDojzhXxyksnFr9vSu20=;
	h=From:To:CC:Subject:Date;
	b=R1XLHEd8tmYjPbegYdniTMPyhN02afp2CBkM5p1wu5a9Z0uOjVm3UL42461NdEWw7
	 z731GZOb3bz/pCl+mIKEDknWzSkNMKVUURTscRcpR9LCixgeTWn6F0Nfda79cLHtPc
	 fDb5un0GdngbMIQ8MkSw4nCXCHqz9Sr3d2MrXfLg=
Received: from ntfs3vm.paragon-software.com (192.168.211.122) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 25 May 2024 10:03:35 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ntfs3: bugfixes for 6.10
Date: Sat, 25 May 2024 10:03:23 +0300
Message-ID: <20240525070323.6106-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
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

Please pull this branch containing ntfs3 code for 6.10.

Fixed:
- reusing of the file index (could cause the file to be trimmed) [1];
- infinite dir enumeration [2];
- taking DOS names into account during link counting;
- le32_to_cpu conversion, 32 bit overflow, NULL check;
- some code was refactored.

Changed:
- removed max link count info display during driver init.

Removed:
- atomic_open has been removed for lack of use.

All changed code (except [1] and [2]) was in linux-next branch for several weeks.

[1] https://lore.kernel.org/ntfs3/20240516122041.5759-1-almaz.alexandrovich@paragon-software.com/
[2] https://lore.kernel.org/ntfs3/20240516120029.5113-1-almaz.alexandrovich@paragon-software.com/
These two patches fix a critical bug, so I've added them to this request.

Regards,
Konstantin

----------------------------------------------------------------

The following changes since commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.10

for you to fetch changes up to 302e9dca8428979c9c99f2dbb44dc1783f5011c3:

  fs/ntfs3: Break dir enumeration if directory contents error (2024-05-24 12:50:12 +0300)

----------------------------------------------------------------

Jeff Layton (1):
      fs/ntfs3: remove atomic_open

Konstantin Komarov (11):
      fs/ntfs3: Taking DOS names into account during link counting
      fs/ntfs3: Remove max link count info display during driver init
      fs/ntfs3: Missed le32_to_cpu conversion
      fs/ntfs3: Check 'folio' pointer for NULL
      fs/ntfs3: Use 64 bit variable to avoid 32 bit overflow
      fs/ntfs3: Use variable length array instead of fixed size
      fs/ntfs3: Redesign ntfs_create_inode to return error code instead of inode
      fs/ntfs3: Always make file nonresident on fallocate call
      fs/ntfs3: Mark volume as dirty if xattr is broken
      fs/ntfs3: Fix case when index is reused during tree transformation
      fs/ntfs3: Break dir enumeration if directory contents error

Lenko Donchev (1):
      fs/ntfs3: use kcalloc() instead of kzalloc()

 fs/ntfs3/attrib.c  |  32 ++++++++++++++
 fs/ntfs3/dir.c     |   1 +
 fs/ntfs3/file.c    |   9 ++++
 fs/ntfs3/frecord.c |   2 +-
 fs/ntfs3/fslog.c   |   5 ++-
 fs/ntfs3/index.c   |   6 +++
 fs/ntfs3/inode.c   |  46 +++++++++++---------
 fs/ntfs3/namei.c   | 121 ++++-------------------------------------------------
 fs/ntfs3/ntfs.h    |   2 +-
 fs/ntfs3/ntfs_fs.h |  10 ++---
 fs/ntfs3/record.c  |  11 +----
 fs/ntfs3/super.c   |   2 -
 fs/ntfs3/xattr.c   |   5 ++-
 13 files changed, 98 insertions(+), 154 deletions(-)

