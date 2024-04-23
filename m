Return-Path: <linux-fsdevel+bounces-17462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 506518ADDA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 08:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47B11F21F44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 06:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B8C2C190;
	Tue, 23 Apr 2024 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="duK+jLT4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A322EF0;
	Tue, 23 Apr 2024 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854705; cv=none; b=SD8tG73QAEYJjVTdi5J7V/Vk6XMCpLoV8q9mR0LAOc764Jcr0TtG+uAx7ySLK70RIrkw0rx0azhIXc5Ub6xnSmjNov2jaWHeUKSzppExXw5ISnjnqJusu+enrQKS7ZrD3FOYYgTGFrfxNEDwM1EmEyKEEoQJAig3UWo1tFDoiJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854705; c=relaxed/simple;
	bh=yHYr9NZjTLV0KVkaIOczsUbndTX5BtsZ0/S7Jb6UjRc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YMrFoYuOWbVSr9fuxMYbRCUQSKUa48gRB4ISZj1+QcOT++dm7rLCcofqeUX2bO7/vNDDS7bmYsB4YPrFD0yjNSvTwet2shXhPsv5JjHq2vE3Xz6a8I11b+3kbeYX9Mdfhc11JXbQglV7V9W0+fxy0JTzkr1j716TLcBViC7GJ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=duK+jLT4; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 336401E80;
	Tue, 23 Apr 2024 06:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713854243;
	bh=UmmlvBrk+NXAV/C0GvIsRMJbpjN8Ah/dZtXPiVlu6rQ=;
	h=From:To:CC:Subject:Date;
	b=duK+jLT4mqOFh4/ba2+8zXBJSlzAzybg0zVDV0WpOU4hrxjViTssHSMHd75r6bUZb
	 Pc0Qb7rV5SHUR3b3b2xsozcRE5nca3OUdapgpFLGv5U2kEaLuUT66C1NkRhC3SlnQU
	 Nu0HEMV1/4DWeYPMZXewqPFgZrx4io8+bIpMq09g=
Received: from ntfs3vm.paragon-software.com (192.168.211.160) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 23 Apr 2024 09:44:54 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v2 0/9] Bugfix and refactoring
Date: Tue, 23 Apr 2024 09:44:19 +0300
Message-ID: <20240423064428.8289-1-almaz.alexandrovich@paragon-software.com>
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

v1->v2:
Here is a reworked series of patches with corrected formatting and layout:
- two patches have been removed for finalization;
- proper commit messages were added;
- important patches have been moved to the beginning of the series
(refactoring at the end).

This series contains various fixes and refactoring for ntfs3.
Fixed problem with incorrect link counting for files with DOS names.

Konstantin Komarov (9):
  fs/ntfs3: Taking DOS names into account during link counting
  fs/ntfs3: Remove max link count info display during driver init
  fs/ntfs3: Missed le32_to_cpu conversion
  fs/ntfs3: Check 'folio' pointer for NULL
  fs/ntfs3: Use 64 bit variable to avoid 32 bit overflow
  fs/ntfs3: Use variable length array instead of fixed size
  fs/ntfs3: Redesign ntfs_create_inode to return error code instead of
    inode
  fs/ntfs3: Always make file nonresident on fallocate call
  fs/ntfs3: Mark volume as dirty if xattr is broken

 fs/ntfs3/attrib.c  | 32 ++++++++++++++++++++++++++++++++
 fs/ntfs3/file.c    |  9 +++++++++
 fs/ntfs3/fslog.c   |  5 +++--
 fs/ntfs3/inode.c   | 46 ++++++++++++++++++++++++++--------------------
 fs/ntfs3/namei.c   | 31 ++++++++-----------------------
 fs/ntfs3/ntfs.h    |  2 +-
 fs/ntfs3/ntfs_fs.h | 10 +++++-----
 fs/ntfs3/record.c  | 11 ++---------
 fs/ntfs3/super.c   |  2 --
 fs/ntfs3/xattr.c   |  5 ++++-
 10 files changed, 90 insertions(+), 63 deletions(-)

-- 
2.34.1


