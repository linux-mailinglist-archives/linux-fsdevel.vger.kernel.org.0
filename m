Return-Path: <linux-fsdevel+bounces-21371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C72902EDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 05:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99DC8B21E2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 03:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CFB16F8F1;
	Tue, 11 Jun 2024 03:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4n/lf1oW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E716F8ED;
	Tue, 11 Jun 2024 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074929; cv=none; b=pOP8C+VdwcPuo2h7tfgruuR/aXWy8+unKSaMyXS8px7/Sj0j0s/gsDOkgN+aZ95eHyOucnmUhfYj4+JYGs5jkcRDNUYc4DdP3NfOlBe1fOdxEXti3gQQ+QeVgCZd2h18ZMhLLsmYRpIX97UzIlE4NTLRqwj3nFb5N3i4BEMeMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074929; c=relaxed/simple;
	bh=8HieL99fPB/44ZCN7pPqBHLa6P03m/YeyuM2SfLaML4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tWK40DZLh6CR5tSfbmRk3XP0Yw+xI+43Q6/cixTtGyFyZSlvFqJPX/rMyHMWWowBu4bq0TUnxJlBY2weitOPPmmF0SBz2Cbc0uKzbK0Hb+qlz2Q20rD42nto3e5EDE0cyGme2KvPJ/J+R5hVd/7ZG2w2cpSQI17yTMv4J5sEoLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4n/lf1oW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9RM3vjzmjAobwuLxz8ZQRvUyOdPhKCxxjyRaVyb0Z5A=; b=4n/lf1oWQH5UU/63ZEnWp1yh3i
	+//Jt2MNPNW7NX2depPPwAHGhixJkiy6ylNRAjp4VEBktfwLjhguZ7oW5x28+7ZjRgx5q2qJUNjvg
	irCOgK/E29G/7G7ctxb0VExdKu7VAyUePtdikaJezav1lgvgZBNQXPtEqh+eZv8OulpP98QDLaLrt
	+WOMdyi0K+1Oru3fl5EbAj7cagJ/IkZUf87EdI77OPusl0qp02WyK70DmJSuj+yCQIa6DGgQAjX2o
	scvBOckbWKE95rtL/QML7dVAw7ogMdpTOgVlZiDGzqhUnFQKSAAHzWLFYwOghe546ErEr4UPdFYJ6
	uBlcRQew==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGrls-00000007DDE-1UsV;
	Tue, 11 Jun 2024 03:02:04 +0000
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
Subject: [PATCH 0/5] fstests: add some new LBS inspired tests
Date: Mon, 10 Jun 2024 20:01:57 -0700
Message-ID: <20240611030203.1719072-1-mcgrof@kernel.org>
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

This adds 3 new test to help reproduce these issues right away. One test
reproduces an otherwise extremely difficult to reproduce deadlock, we have one
patch fix already merged to help with that deadlock, however the test also
also gives us more homework todo, as more deadlocks are still possible with that
test even on v6.10-rc2.

The mmap page boundary test let's us discover that a patch on the LBS series
fixes the mmap page boundary restriction when huge pages are enabled on tmpfs.
This is a corner case POSIX semantic issue, so likley not critical to most users.

The fsstress + compaction test reproduces a really difficult to reproduce hang
which is possible without some recent fixes, however the test reveals there is
yet more work is left to do.

The stress truncation + writeback test is the only test in this series specific
to LBS, but likely will be useful later for other future uses in the kernel.

Luis Chamberlain (5):
  common: move mread() to generic helper _mread()
  fstests: add mmap page boundary tests
  fstests: add fsstress + compaction test
  _require_debugfs(): simplify and fix for debian
  fstests: add stress truncation + writeback test

 common/rc             |  54 +++++++++-
 tests/generic/574     |  36 +------
 tests/generic/749     | 238 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/749.out |   2 +
 tests/generic/750     |  62 +++++++++++
 tests/generic/750.out |   2 +
 tests/generic/751     | 127 ++++++++++++++++++++++
 tests/generic/751.out |   2 +
 8 files changed, 490 insertions(+), 33 deletions(-)
 create mode 100755 tests/generic/749
 create mode 100644 tests/generic/749.out
 create mode 100755 tests/generic/750
 create mode 100644 tests/generic/750.out
 create mode 100755 tests/generic/751
 create mode 100644 tests/generic/751.out

-- 
2.43.0


