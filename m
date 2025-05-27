Return-Path: <linux-fsdevel+bounces-49921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D07DAC529C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 18:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DE3171367
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBA027CCC8;
	Tue, 27 May 2025 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="MSSiP6/0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A5A13D8A3;
	Tue, 27 May 2025 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361787; cv=none; b=fEMgwzvK5vziYFAmwmzIvlCcGOLhgAORQunGUHvK5j2+3ulAu6Uu6B6fbvS/giPP4ES86XVUNnEoF6Qn9SqVoYuPgjmfvUcaeZgnzOTKdP1RYk1Rx3d2QtHMqaustMHG9/DbBSaf2/NlPxjPSFQsOZrE0e4/5fQ5Eig+tEOh/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361787; c=relaxed/simple;
	bh=RAAFafTxFaWgifvm1k7r2nbdZcKd8n1FQZLnD8uIB+I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G3hF6Uyeu/bTR1aCp4v0H1y/JJlYtb39nWhtsefVSEJyYGUm1X8gUF7g9Rc7Jr9wzHPxEEjkNrIFRVW5fNsH7EYelwpyA1L5hmk0x665uX/i65NIhJ3AHVH3NKyQlRugTKP10NWHgBnwUG/7gXEf3fMVTEEWqPSUVXTfH7X9SP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=MSSiP6/0; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 6E96A439;
	Tue, 27 May 2025 16:02:37 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=MSSiP6/0;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id CD9F92113;
	Tue, 27 May 2025 16:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1748361777;
	bh=ou71YzW4j0nqWyyVs7p+K5QW8WwlJdR4S0UwE0D+L18=;
	h=From:To:CC:Subject:Date;
	b=MSSiP6/0j7e3fh+0P/5pTZWh3PPXKuxNRdjSTB04iUjTIx9x1rzTbccnwvmI7MzSj
	 ZbbUIs0GzE98VPL+g2SC74nvA/6JsAss9uOfC+J3AqlUqZ0DRKCwOjrcneZi0+wti0
	 IHxbq++RZ/QhRn9fCGc6i3r08TFtZYQH6leRbvig=
Received: from localhost.localdomain (172.30.20.214) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 27 May 2025 19:02:56 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ntfs3: bugfixes for 6.16
Date: Tue, 27 May 2025 18:02:46 +0200
Message-ID: <20250527160246.6905-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
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

Please pull this branch containing ntfs3 code for 6.16.

In commit "remove ability to change compression on mounted volume" many removals are present. This is because it's not safe and not maintainable to change compression on the fly. Detailed description can be found in this letter [1].

[1] https://lore.kernel.org/ntfs3/Z7Qlh9856tVuzrYK@dread.disaster.area/  

Regards,
Konstantin
 
----------------------------------------------------------------

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.16

for you to fetch changes up to eeb0819318cc0c30161821d429ca022dfbedc6ac:

  fs/ntfs3: remove ability to change compression on mounted volume (2025-05-19 11:17:33 +0200)

----------------------------------------------------------------
Changes for 6.16-rc1

Added:
    missing direct_IO in ntfs_aops_cmpr;
    handling of hdr_first_de() return value.

Fixed:
    handling of InitializeFileRecordSegment operation.

Removed:
    ability to change compression on mounted volume;
    redundant NULL check.

----------------------------------------------------------------
Andrey Vatoropin (2):
      fs/ntfs3: Drop redundant NULL check
      fs/ntfs3: handle hdr_first_de() return value

Konstantin Komarov (2):
      fs/ntfs3: Fix handling of InitializeFileRecordSegment
      fs/ntfs3: remove ability to change compression on mounted volume

Lizhi Xu (1):
      fs/ntfs3: Add missing direct_IO in ntfs_aops_cmpr

 fs/ntfs3/attrib.c  | 72 --------------------------------------------
 fs/ntfs3/file.c    | 87 ------------------------------------------------------
 fs/ntfs3/frecord.c | 74 ----------------------------------------------
 fs/ntfs3/fslog.c   | 32 ++++++++++----------
 fs/ntfs3/index.c   |  8 +++++
 fs/ntfs3/inode.c   |  5 ++++
 fs/ntfs3/namei.c   |  2 --
 fs/ntfs3/ntfs_fs.h |  5 ----
 8 files changed, 28 insertions(+), 257 deletions(-)

