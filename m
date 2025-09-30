Return-Path: <linux-fsdevel+bounces-63117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BECDBBACFD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 15:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BA53AD8D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 13:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D6F30217C;
	Tue, 30 Sep 2025 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="f8asWyTT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A82D7DDF;
	Tue, 30 Sep 2025 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238061; cv=none; b=GogrIxqBE8nC07OOs7zWQ4eBupKzKqrgOjc/8w93XdsQJcV8c24RsgICNINla1muC14o6KjLphpWZSnxpq/DiNr/bX5YgdCBXPKnZK7iP/9838YamfV44iK1P/C9EgFRAncCXeSR83i2TG6KUlSWX9UYzcH9N4VJ44ot5SBuzjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238061; c=relaxed/simple;
	bh=9yEJzMwJrg8nW2CWuxK9n2LKu9lVJL5AAGsW7FMdtwk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NFv0H63SdLgS40770U1/S4fGB7yLcNrKacTRLDFqqCn5M6sL4FnNUXxk8aB5QH1lvwO6jQViESHuJ1wAYO9+NGutWe87ktgdEmt2LV9BGayZNg+RsLppIb3tWPoRLWHhnESuRlmb/u/RVFH+OWokbCUd6P4c+OhXZ4s3rSvot90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=f8asWyTT; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 460CA1D11;
	Tue, 30 Sep 2025 13:06:07 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=f8asWyTT;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 4902721EA;
	Tue, 30 Sep 2025 13:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1759237723;
	bh=jPuqJGVAy7IKIL7V2PDzHuE8jtrLL6h8srVPH7bCEBc=;
	h=From:To:CC:Subject:Date;
	b=f8asWyTTpS/z54T9m4sjy7uZteYwrsN/zcm3qtWshBoxZ+7LiHbQGOqn5wNAdxNVE
	 19/hI0ZtxbpXuFgZ7IYVT0EHMMfm3uiB+WO417pYi+6GFBJ1YAiwZVUo8SUdLLIoke
	 TaJ4DL9+pm8NfnVC4umixgWEnb2q6S92VpIDsosI=
Received: from localhost.localdomain (172.30.20.168) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 30 Sep 2025 16:08:42 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ntfs3: bugfixes for 6.18
Date: Tue, 30 Sep 2025 15:08:33 +0200
Message-ID: <20250930130833.4866-1-almaz.alexandrovich@paragon-software.com>
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

Please pull this branch containing ntfs3 code for 6.18.

Regards,
Konstantin

----------------------------------------------------------------
The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.18

for you to fetch changes up to 7d460636b6402343ca150682f7bae896c4ff2a76:

  ntfs3: stop using write_cache_pages (2025-09-10 11:01:41 +0200)

----------------------------------------------------------------
Changes for 6.18-rc1

Added:
    support for FS_IOC_{GET,SET}FSLABEL ioctl;
    reject index allocation if $BITMAP is empty but blocks exist.

Fixed:
    integer overflow in run_unpack();
    resource leak bug in wnd_extend().

Changed:
    pretend $Extend records as regular files;
    stop using write_cache_pages.

----------------------------------------------------------------
Christoph Hellwig (1):
      ntfs3: stop using write_cache_pages

Ethan Ferguson (3):
      ntfs3: transition magic number to shared constant
      ntfs3: add FS_IOC_GETFSLABEL ioctl
      ntfs3: add FS_IOC_SETFSLABEL ioctl

Haoxiang Li (1):
      fs/ntfs3: Fix a resource leak bug in wnd_extend()

Moon Hee Lee (1):
      fs/ntfs3: reject index allocation if $BITMAP is empty but blocks exist

Tetsuo Handa (1):
      ntfs3: pretend $Extend records as regular files

Vitaly Grigoryev (1):
      fs: ntfs3: Fix integer overflow in run_unpack()

 fs/ntfs3/bitmap.c  |  1 +
 fs/ntfs3/file.c    | 28 ++++++++++++++++++++++++++++
 fs/ntfs3/index.c   | 10 ++++++++++
 fs/ntfs3/inode.c   | 16 +++++++++++-----
 fs/ntfs3/ntfs_fs.h |  2 +-
 fs/ntfs3/run.c     | 12 +++++++++---
 6 files changed, 60 insertions(+), 9 deletions(-)

