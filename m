Return-Path: <linux-fsdevel+bounces-36071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7AD9DB6A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 12:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08882817D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE3E1991B4;
	Thu, 28 Nov 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="dLAqs+XF";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="VDnqac7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78761146D59;
	Thu, 28 Nov 2024 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732794112; cv=none; b=VN7i6ANDjP+8df6Qre1VIXGpfX26yetTdBcIP0OWxVfTati0hIf8IjsKRk0+V/f9l8y4Y5Ss7nBO+wVgSPd2zMldf9IHdiGt/uRh8jsd4rZILZmdb//cYGB6Y6qcFkadmggrA6IdUxw/qvEuYzrwdyZcJoWRlMqO4go5RtbaIIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732794112; c=relaxed/simple;
	bh=tmX7xoY3LX01MewSUUympU6UrXICAWr6yUSpwT8AOB4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sFmY1UsoO4SeHRmnpPaVvRqJF4iZnnqkPeVDwcCtUQAGJ0RUZ8Pr5HGDaneu+sKNxTbgkp+zImHbmccyQ01X0Zbg38bCiFobMCc7xdEka5avm3Er6KXlT1K+wx7ti2x7iIUc14Qn6EBINUMK0F9kBq2AI9lWQGULgN1yijQGxRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=dLAqs+XF; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=VDnqac7T; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id AFF352305;
	Thu, 28 Nov 2024 11:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1732793255;
	bh=NqIAAeMDOoiqx41SDJtqResr0fd/wauc47erVyXIRo8=;
	h=From:To:CC:Subject:Date;
	b=dLAqs+XFvU6d1m6sSnMojhXikiNGL0Pvl32PURkr1VeKtOk3ZzhUhAYbPxogU1M1h
	 8lv3kQyzUfdHxtP57050wFl+n9opeRQH+zNtvtWdZ5LVaM7yAVn1aGXtnXrXtphwGC
	 ZWXa24ON3zuLPxZA/4tKfpr2k3wB47gX+ooWCw5k=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 3E528F7;
	Thu, 28 Nov 2024 11:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1732793738;
	bh=NqIAAeMDOoiqx41SDJtqResr0fd/wauc47erVyXIRo8=;
	h=From:To:CC:Subject:Date;
	b=VDnqac7TagIho2HX6XSrmwjK+Q3bdwudAwC0/nMrb9bCLflQleOAPb5Uqb3fUOs9c
	 YsRCvnzDUI7dEdNSDRLCPGHtvpO4SYcKG967nqF1dRo14TXXWJ0qud3UL7q7NBQuP6
	 huDGDyLpmYQ6Q/5U+tWv/5ecQRRzs5JxUlmlaUGU=
Received: from ntfs3vm.paragon-software.com (192.168.211.21) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 28 Nov 2024 14:35:37 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ntfs3: bugfixes for 6.13
Date: Thu, 28 Nov 2024 14:35:05 +0300
Message-ID: <20241128113505.44406-1-almaz.alexandrovich@paragon-software.com>
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

Please pull this branch containing ntfs3 code for 6.13.

All changed code was in linux-next branch at 2 weeks.

Regards,
Konstantin

----------------------------------------------------------------

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.13

for you to fetch changes up to bac89bb33d91cdd75092e15cf59fe6be34571142:

  fs/ntfs3: Accumulated refactoring changes (2024-11-01 11:19:53 +0300)

----------------------------------------------------------------
Changes for 6.13-rc1

Fixed:
	additional checks have been added to address issues identified by syzbot.
Refactored:
	continuation of the transition from 'page' to 'folio'.

----------------------------------------------------------------
Konstantin Komarov (7):
      fs/ntfs3: Fix warning in ni_fiemap
      fs/ntfs3: Fix case when unmarked clusters intersect with zone
      fs/ntfs3: Equivalent transition from page to folio
      fs/ntfs3: Add more checks in mi_enum_attr (part 2)
      fs/ntfs3: Add check in ntfs_extend_initialized_size
      fs/ntfs3: Switch to folio to release resources
      fs/ntfs3: Accumulated refactoring changes

 fs/ntfs3/attrib.c  |   9 +++--
 fs/ntfs3/bitmap.c  |  62 +++++++++-----------------------
 fs/ntfs3/file.c    |  34 +++++++++++-------
 fs/ntfs3/frecord.c | 104 ++++++++---------------------------------------------
 fs/ntfs3/fsntfs.c  |   2 +-
 fs/ntfs3/ntfs_fs.h |   3 +-
 fs/ntfs3/record.c  |  16 +++++++--
 fs/ntfs3/run.c     |  40 +++++++++++++++------
 8 files changed, 103 insertions(+), 167 deletions(-)

