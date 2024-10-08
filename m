Return-Path: <linux-fsdevel+bounces-31350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16799995304
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 17:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A575B287C96
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260F51E0081;
	Tue,  8 Oct 2024 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="JfPyUFGZ";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="qJH6i1q7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C783BDF71;
	Tue,  8 Oct 2024 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400277; cv=none; b=HhdCz+R0zEAbiFCt9NuWNks84roYtU+Y7mIK94ftN1fIvLGbN7xU9PQhTSQantcc0QOrHocfv0Q3B1b/Rts6iblXFMeFY7HNr/1Y+xi/fHfCX7GSLgR5e7+ddBsZwURT3uvU71Mw7KGIi1qWpAYMlXJCX7Ylb41URMG4Kj0FMRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400277; c=relaxed/simple;
	bh=/O8v0DQ2GVRzc48m8wAHNCHFIAtYmj1AJQd9V2qu9/Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ltCc9FS+o/4wI1UBcZowMkPtm4SS7QEJHcmZOveLMiOp/910LlgV38kgcMsOeeuT2SHDAKz0W/eYFqe/XxHYVJW6eOpLYmivw/thCcLfAR7aTBdkKbIHfzuvswl8AfXfXgwqOjwieJ5WkzyJg/6wstVPEwLXa5MwsQjuh5l8F30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=JfPyUFGZ; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=qJH6i1q7; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E4C061FEC;
	Tue,  8 Oct 2024 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1728399324;
	bh=P9vUqHOsu28vLeBNL5YkhZnY7tqCTNGqt+mdS6UqDeI=;
	h=From:To:CC:Subject:Date;
	b=JfPyUFGZhpUK9bCQ/Zeq9DiFMkeq/58YGLmgKl1Re5YNkSGbf1M1OKEQQGr2jS/FQ
	 irH0qDUSakbUSPjsNtDyQQ8Do26jLyTjss1SaIrzHVNVTO5K7Awx9UBi9m5Msv2lsQ
	 ElH7FqjFJNF3zf2VrpjJGwqFrypKZwKPtPQCtXlg=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id A0341217E;
	Tue,  8 Oct 2024 15:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1728399779;
	bh=P9vUqHOsu28vLeBNL5YkhZnY7tqCTNGqt+mdS6UqDeI=;
	h=From:To:CC:Subject:Date;
	b=qJH6i1q7qiz1eLhjGnBNNn4uObWDmFJiy7C9aosAeMohhSdq4hEyP986qWSKcfuUQ
	 OjQ1W2o82oU62csX5vO09ryO1oL5UgCsH9LfzXdqwMhoF8MU8Dy+BYiqsEnegjbaeM
	 YSoceNUpg4az02YsAmyxIiicuCujI/d5LO98w9tU=
Received: from ntfs3vm.localdomain (192.168.211.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 8 Oct 2024 18:02:59 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ntfs3: bugfixes for 6.12
Date: Tue, 8 Oct 2024 18:02:47 +0300
Message-ID: <20241008150247.6972-1-almaz.alexandrovich@paragon-software.com>
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

Please pull this branch containing ntfs3 code for 6.12.

New:
	implement fallocate for compressed files;
	add support for the compression attribute;
	optimize large writes to sparse files.
Fixed:
	fix several potential deadlock scenarios;
	fix various internal bugs detected by syzbot;
	add checks before accessing NTFS structures during parsing;
	correct the format of output messages.
Refactored:
	replace fsparam_flag_no with fsparam_flag in options parser;
	remove unused functions and macros.

All changed code was in linux-next branch at least week (New/Refactored
changes much longer).

Regards,
Konstantin

----------------------------------------------------------------

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.12

for you to fetch changes up to 48dbc127836a6f311414bc03eae386023d05ed30:

  fs/ntfs3: Format output messages like others fs in kernel (2024-10-01 12:19:09 +0300)

----------------------------------------------------------------
Andrew Ballance (1):
      fs/ntfs3: Check if more than chunk-size bytes are written

Diogo Jahchan Koike (1):
      ntfs3: Change to non-blocking allocation in ntfs_d_hash

Dr. David Alan Gilbert (1):
      fs/ntfs3: Remove unused al_delete_le

Konstantin Komarov (20):
      fs/ntfs3: Do not call file_modified if collapse range failed
      fs/ntfs3: Optimize large writes into sparse file
      fs/ntfs3: Separete common code for file_read/write iter/splice
      fs/ntfs3: Fix sparse warning for bigendian
      fs/ntfs3: Fix warning possible deadlock in ntfs_set_state
      fs/ntfs3: Fix sparse warning in ni_fiemap
      fs/ntfs3: Refactor enum_rstbl to suppress static checker
      fs/ntfs3: Stale inode instead of bad
      fs/ntfs3: Add rough attr alloc_size check
      fs/ntfs3: Make checks in run_unpack more clear
      fs/ntfs3: Implement fallocate for compressed files
      fs/ntfs3: Add support for the compression attribute
      fs/ntfs3: Replace fsparam_flag_no -> fsparam_flag
      fs/ntfs3: Rename ntfs3_setattr into ntfs_setattr
      fs/ntfs3: Fix possible deadlock in mi_read
      fs/ntfs3: Additional check in ni_clear()
      fs/ntfs3: Sequential field availability check in mi_enum_attr()
      fs/ntfs3: Fix general protection fault in run_is_mapped_full
      fs/ntfs3: Additional check in ntfs_file_release
      fs/ntfs3: Format output messages like others fs in kernel

Thorsten Blum (1):
      fs/ntfs3: Use swap() to improve code

lei lu (1):
      ntfs3: Add bounds checking to mi_enum_attr()

 fs/ntfs3/attrib.c             |  96 +++++++++++++++++++---
 fs/ntfs3/attrlist.c           |  53 ------------
 fs/ntfs3/file.c               | 185 +++++++++++++++++++++++++++++++-----------
 fs/ntfs3/frecord.c            |  97 ++++++++++++++++++----
 fs/ntfs3/fslog.c              |  19 ++++-
 fs/ntfs3/inode.c              |  20 +++--
 fs/ntfs3/lib/lzx_decompress.c |   3 +-
 fs/ntfs3/lznt.c               |   3 +
 fs/ntfs3/namei.c              |  10 +--
 fs/ntfs3/ntfs_fs.h            |  10 +--
 fs/ntfs3/record.c             |  31 ++++---
 fs/ntfs3/run.c                |   8 +-
 fs/ntfs3/super.c              |  70 ++++++++--------
 fs/ntfs3/xattr.c              |   2 +-
 14 files changed, 410 insertions(+), 197 deletions(-)

