Return-Path: <linux-fsdevel+bounces-40394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 338CCA23094
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 15:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D9D3A6117
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 14:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A741E991B;
	Thu, 30 Jan 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="PgQ3pS82";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="YRke6YLq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476661DDD1;
	Thu, 30 Jan 2025 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248415; cv=none; b=pVWm4m1NEdf6FoQyggCNQeIm9hJgfKNBpzZT65q1A7xO9Ba4XmJBlCCN9TUbx2a7UvzLhIwTiS+sPek9iEZujVxVsw0nkMYv+y21o7oNpodHotvVNzrFas07eezF8mOmboOzN9BgmJw9DMldgD8Hcbso8u2U1bRYWjBBqqg66Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248415; c=relaxed/simple;
	bh=yJQ9Ec7Wtppumvnk8gqi3gtE+QnLHfkHnm3I43faK+c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qd3rOWq+5ofMLptnfmSLfASMwRs7xupIDlSx/BIZvgT2XTt3ZNLAaFdpBtVz3bRMgndEMEPjKfGS2l3b3tv9vMINVgtoCiv/L/2j2vG/BZWy67/mc0/eqyjtYO1ccLSTrKJyzIntcQGlCX7MCJKz/nL8HcCT1vycZK7IeRXZe1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=PgQ3pS82; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=YRke6YLq; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id C6353267C;
	Thu, 30 Jan 2025 14:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1738248343;
	bh=OBpOpBgKzWM6sU2BYByW+VXK9rhad0Cd52Gc1oTJfmg=;
	h=From:To:CC:Subject:Date;
	b=PgQ3pS82Wb1Tn8c5uRbAXayICn/nYgF8aHlDkVeviyAj/kansoy5Fu6bcThC7aJqk
	 gu3ByODVNHhAWjaCmWBGfOet9gISZ3LILhvZXuD5bwvSOTj+XdZO9HJSoATxvSP5QK
	 mwdBcvQWYqwmXbtySA3dAuyGvEL4MiT4+PVGdTFk=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 10E8526CF;
	Thu, 30 Jan 2025 14:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1738248404;
	bh=OBpOpBgKzWM6sU2BYByW+VXK9rhad0Cd52Gc1oTJfmg=;
	h=From:To:CC:Subject:Date;
	b=YRke6YLq7dFxklAwCC7rU1pZ++oq6Cj2e65hOUq0KZuU7rceZmN1Ws+r7XQTY4rqt
	 yGRXa7iYMw2noSyXLstTotbSEFjpV/0eTJ4TqOq+jskGbz2gHIrbldsGIGTjoo8gIk
	 OF25mQCoUPNFzl5Nan1hbTSn8YoWO4DjMwVUHeQU=
Received: from ntfs3vm.paragon-software.com (192.168.211.120) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 30 Jan 2025 17:46:43 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ntfs3: bugfixes for 6.14
Date: Thu, 30 Jan 2025 17:46:32 +0300
Message-ID: <20250130144632.22506-1-almaz.alexandrovich@paragon-software.com>
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

Please pull this branch containing ntfs3 code for 6.14.

Only one change from me this time.

Regards,
Konstantin

----------------------------------------------------------------
The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.14

for you to fetch changes up to 55ad333de0f80bc0caee10c6c27196cdcf8891bb:

  fs/ntfs3: Unify inode corruption marking with _ntfs_bad_inode() (2024-12-30 11:37:40 +0300)

----------------------------------------------------------------
Changes for 6.14-rc1

Refactored:
	unify inode corruption marking and mark them as bad immediately
	upon detection of an error in attribute enumeration.

----------------------------------------------------------------
Konstantin Komarov (2):
      fs/ntfs3: Mark inode as bad as soon as error detected in mi_enum_attr()
      fs/ntfs3: Unify inode corruption marking with _ntfs_bad_inode()

Matthew Wilcox (Oracle) (1):
      ntfs3: Remove an access to page->index

 fs/ntfs3/attrib.c  | 15 ++++++-----
 fs/ntfs3/dir.c     |  2 +-
 fs/ntfs3/frecord.c | 74 +++++++++++++++++++++++++++-----------------------
 fs/ntfs3/fsntfs.c  |  6 ++++-
 fs/ntfs3/index.c   |  6 ++---
 fs/ntfs3/inode.c   |  3 +++
 fs/ntfs3/ntfs_fs.h | 21 ++++++++-------
 fs/ntfs3/record.c  | 79 +++++++++++++++++++++++++++++-------------------------
 8 files changed, 112 insertions(+), 94 deletions(-)

