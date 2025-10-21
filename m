Return-Path: <linux-fsdevel+bounces-64814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6900EBF4D4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2232460321
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 07:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EAE274B5A;
	Tue, 21 Oct 2025 07:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="HVC87p1a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18CC25A623;
	Tue, 21 Oct 2025 07:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.74.81.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030554; cv=none; b=StjrkF2+zizVPYASEiz7WaDfXVYhDVhYOe5v38c1HIub5nemvq8iW+Xc9H0D8tSM5swpPxlV304AEn7jOgvYe4sD8FKFHmlCZvw2sUghB7pZ8B0mhxlA5ndmBNeL5hFCSO8H7cX8ZDzKEwFySKPzuWva56QNNh4aUSll7XnGZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030554; c=relaxed/simple;
	bh=hV+SdjKKzEi70TyGpPZCe2pK7qZK2WxjRRL1B1KcNTM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GieyvBiGRqXfJyvizVr3dcB54JKhpnnuNkk8OiGfPa1Z1cQh0If02pE4kAkRP8YF7M95PuJ8KJOWS9wSczzoQ6rEu0gyruQ9pHQtHMGm2ju6vCT/PMtwYJZSUHdupmZTdGFLYZGEQ5/ko80HPGBgruO4G9tq5XunfR43lKSw4j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=HVC87p1a; arc=none smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1761030552; x=1792566552;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4aKg8jaea9UUgjVGAZ9pvPl/2rw7Jg81FmzroUsdh8U=;
  b=HVC87p1aBmQ4gE7O4jCj6ingqjU5/wx1ks+x6YUQxcnxcz7KPdkYbbS6
   y0y6AgAOA1l0fSqRJzp6YLtPL3bBk+w2Lauh57SSZGBd4rfmq3XL9a9l2
   mFPvdsmpoAARb7rBeD2K7SGt0N8t7twqpPQMCFdWr2zC86pHJ5FQtHbhT
   cEvYGqIkY4hpeWaNIdDHpZmEx5kjzNOz4v69Hl6YtS2Gr8IoznIFZLB8J
   Y5OZZ85SUSbuOufHNLsB7dlJ/vL+9c+mdNMYY1Ck5vPn3hCxfE3r3vAAT
   84Dtrj753DUrD6Gc307KTN0K1q49/fN/PeWCTu3gGxIqN8yJCoNUNDtaE
   A==;
X-CSE-ConnectionGUID: xhZ9wZyxSpmrCzcqqePl8A==
X-CSE-MsgGUID: 8WykqeV0SPuRFwAH0TlCVw==
X-IronPort-AV: E=Sophos;i="6.19,244,1754956800"; 
   d="scan'208";a="3934174"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 07:08:59 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:10631]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.15.22:2525] with esmtp (Farcaster)
 id 3750a0e3-50a3-4ee5-985b-1ddb7d86a82d; Tue, 21 Oct 2025 07:08:59 +0000 (UTC)
X-Farcaster-Flow-ID: 3750a0e3-50a3-4ee5-985b-1ddb7d86a82d
Received: from EX19D013EUB004.ant.amazon.com (10.252.51.92) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 07:08:58 +0000
Received: from dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com
 (10.253.107.175) by EX19D013EUB004.ant.amazon.com (10.252.51.92) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 21 Oct 2025
 07:08:50 +0000
From: Mahmoud Adam <mngyadam@amazon.de>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <nagy@khwaternagy.com>, Jens Axboe
	<axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov
	<idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
	<adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu
	<chao@kernel.org>, Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong"
	<djwong@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, "Anna
 Schumaker" <anna@kernel.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Hannes Reinecke <hare@suse.de>, Damien Le Moal
	<dlemoal@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ceph-devel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-xfs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-nilfs@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH 6.1 0/8] Backporting CVE-2025-38073 fix patch
Date: Tue, 21 Oct 2025 09:03:35 +0200
Message-ID: <20251021070353.96705-2-mngyadam@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D013EUB004.ant.amazon.com (10.252.51.92)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series aims to fix the CVE-2025-38073 for 6.1 LTS. Which is fixed
by c0e473a0d226 ("block: fix race between set_blocksize and read
paths"). This patch is built on top multiple refactors that where
merged on 6.6. The needed dependecies are:

  - e003f74afbd2 ("filemap: add a kiocb_invalidate_pages helper")
  - c402a9a9430b ("filemap: add a kiocb_invalidate_post_direct_write
    helper")
  - 182c25e9c157 ("filemap: update ki_pos in generic_perform_write")
  - 44fff0fa08ec ("fs: factor out a direct_write_fallback helper")
  - 727cfe976758 ("block: open code __generic_file_write_iter for
    blkdev writes")

Also backport follow up fixes:
- fb881cd76045 ("nilfs2: fix deadlock warnings caused by lock
  dependency in init_nilfs()").
- 8287474aa5ff ("direct_write_fallback(): on error revert the ->ki_pos
  update from buffered write")

Thanks,
MNAdam

Al Viro (1):
  direct_write_fallback(): on error revert the ->ki_pos update from
    buffered write

Christoph Hellwig (5):
  filemap: add a kiocb_invalidate_pages helper
  filemap: add a kiocb_invalidate_post_direct_write helper
  filemap: update ki_pos in generic_perform_write
  fs: factor out a direct_write_fallback helper
  block: open code __generic_file_write_iter for blkdev writes

Darrick J. Wong (1):
  block: fix race between set_blocksize and read paths

Ryusuke Konishi (1):
  nilfs2: fix deadlock warnings caused by lock dependency in
    init_nilfs()

 block/bdev.c            |  17 +++++
 block/blk-zoned.c       |   5 +-
 block/fops.c            |  61 +++++++++++++++-
 block/ioctl.c           |   6 ++
 fs/ceph/file.c          |   2 -
 fs/direct-io.c          |  10 +--
 fs/ext4/file.c          |   9 +--
 fs/f2fs/file.c          |   1 -
 fs/iomap/direct-io.c    |  12 +---
 fs/libfs.c              |  42 +++++++++++
 fs/nfs/file.c           |   1 -
 fs/nilfs2/the_nilfs.c   |   3 -
 include/linux/fs.h      |   7 +-
 include/linux/pagemap.h |   2 +
 mm/filemap.c            | 154 +++++++++++++++++-----------------------
 15 files changed, 205 insertions(+), 127 deletions(-)

-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


