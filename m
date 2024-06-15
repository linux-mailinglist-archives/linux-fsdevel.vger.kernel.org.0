Return-Path: <linux-fsdevel+bounces-21736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D64909515
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 02:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAEB1F2297D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 00:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA24FDDBE;
	Sat, 15 Jun 2024 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bixN2wSh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB45B1361;
	Sat, 15 Jun 2024 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718411382; cv=none; b=EYAX0yd0KfC94YdXyeJfaNhISXMbDXktWRCDBDSmeq/Hp0YCuHsgEfX8YEvNDiqIIuLNfRlUMQpK52SwZCbzeLXlN6TGM6+qLhiS8tXoikdKWfozFzqBBqySSHym7jPSotgSKwniCFspyeBENfxXuQ2As8C5mdkLFyy9RKb4FY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718411382; c=relaxed/simple;
	bh=vtz42luEAJn0VhLOUkv2/QP5NNZipfjnEVBsxy/fZy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ueDgwav9MN9ObFoh28PiD097ywH7hFdfrrli9xfwdOEXsJ0mvNbAI3FmcslFeV+m3oQNY4K7lVvoVsmjsnT/3N37yeaScLAbw6MDPKVVC0zSRtDQsbLilfUIssmX3k95G4R4FkIPwRPgAr+vRuXnzCgSc1TXbKq1/ivUzzcePkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bixN2wSh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KMlKjNaY/F8QL3qECnT8EKms3WZs5CznUIuEAKsL0wI=; b=bixN2wShYjRMBjSUYnaQovwNZk
	EEqsZMmtJGDJBNqorl/0WokkuKb8uhDH+ctYRXT2Cxc2cx32L98paVDX2qpolK0cPMIPcz6Ilpymb
	KD6FYBQFvNwNhpsl5fdtdvw1CKziq78+ykStUytje7gPA2Xqm5WQvPA8HfCTUt8tQ5bnrO1QpJ4TV
	JHCU1kWSzBgrxKujcf2nydpnuTEy6geOcIr7UynmlkCtTQ4gfJ+zz6gI5vRvYpGsVSFY1wZCySEfr
	GDb4cToeKC+23QpY9TGiqK85ZZNvJkLf7bxx6XIoelh7dIJvmEVtqbq/4uSF/zM/i2F4OJ3hFe81g
	sluCwWBw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIHIV-00000004KkG-3N4C;
	Sat, 15 Jun 2024 00:29:35 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: patches@lists.linux.dev,
	fstests@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org,
	ziy@nvidia.com,
	vbabka@suse.cz,
	seanjc@google.com,
	willy@infradead.org,
	david@redhat.com,
	hughd@google.com,
	linmiaohe@huawei.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	hare@suse.de,
	john.g.garry@oracle.com,
	mcgrof@kernel.org
Subject: [PATCH v2 0/5] fstests: add some new LBS inspired tests
Date: Fri, 14 Jun 2024 17:29:29 -0700
Message-ID: <20240615002935.1033031-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

While working on LBS we've come accross some existing issues, some of them deal
existing kernels without LBS, while the only new corner case specific to LBS is
the xarray bug Willy fixed to help with truncation to larger order folios and
races with writeback.                                                                                                                                                                         
                                                                                                                                                                                              
This adds 3 new tests to help reproduce these issues right away. One test
reproduces an otherwise extremely difficult to reproduce deadlock, we have one
patch fix already merged to help with that deadlock, however the test also
also gives us more homework todo, as more deadlocks are still possible with that
test even on v6.10-rc2.

The 3 tests are:

1) mmap():

The mmap page boundary test let's us discover that a patch on the LBS series
fixes the mmap page boundary restriction when huge pages are enabled on tmpfs
with a 4k base page size system (x86). This is a corner case POSIX semantic
issue, so likley not critical to most users.

2) fsstress + compaction

The fsstress + compaction test reproduces a really difficult to reproduce hang
which is possible without some recent fixes. However the test reveals there is
yet more work is left to do to fix all posssible deadlocks. To be clear these
issues are reproducible without LBS, on a plain 4k block size XFS filesystem.

3) stress truncation + writeback                                                                                                                                                                                              
The stress truncation + writeback test is the only test in this series specific
to LBS, but likely will be useful later for other future uses in the kernel.

Changes on this v2:

- Few cleanups suggested
- Renamed routines as suggested
- Used helpers for proc vmstat as suggested
- Made the mmap() test continue so we can just count the number of failures
  of the test
- Made the fio test ignore out of space issues, we care to just blast
  the page cache, and detect write errors or crashes. This test now goes also
  tested with tmpfs.
- Minor commit log enhancements

Luis Chamberlain (5):
  common: move mread() to generic helper _mread()
  fstests: add mmap page boundary tests
  fstests: add fsstress + compaction test
  _require_debugfs(): simplify and fix for debian
  fstests: add stress truncation + writeback test

 common/rc             |  54 ++++++++-
 tests/generic/574     |  36 +-----
 tests/generic/749     | 256 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/749.out |   2 +
 tests/generic/750     |  63 +++++++++++
 tests/generic/750.out |   2 +
 tests/generic/751     | 170 ++++++++++++++++++++++++++++
 tests/generic/751.out |   2 +
 8 files changed, 552 insertions(+), 33 deletions(-)
 create mode 100755 tests/generic/749
 create mode 100644 tests/generic/749.out
 create mode 100755 tests/generic/750
 create mode 100644 tests/generic/750.out
 create mode 100755 tests/generic/751
 create mode 100644 tests/generic/751.out

-- 
2.43.0


