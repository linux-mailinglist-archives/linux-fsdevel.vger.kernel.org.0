Return-Path: <linux-fsdevel+bounces-64823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF22BF4EA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EE62504DC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 07:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FF827A917;
	Tue, 21 Oct 2025 07:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="ZFYESqTi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BB625D540;
	Tue, 21 Oct 2025 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.237.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030790; cv=none; b=q8AX6M2lA9qJQFVkpMPaMJu1mCNUzSfCbnGOUdQ0IptHpP5hm19rjDSuQYELpGR0g2lI77+prFplQ7fHNAtEJuk4iWZB8fofTP16ZNlPTolZ35jXBse1V//HEeZ/66DSi9EOi3mTYkL5gcMcv1hhUYldspp6kkwopOT44ohwz9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030790; c=relaxed/simple;
	bh=YYP+JvL1Azmf39UNxyLGq9iTQvod6ds7wDUTSE8XiV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mANOf2I/adJ3RK0mightC62I+YHhDWpXs99XVYEd6lzctln/mdcQ0MeIFDvO/Pdv0TBdJ2kqyHQwwnL26/wUyu15btV060PEP9FhSjjZj9GBux+jHrsZyfRNzPSd3cEVsYTJq1R2MnFmaoduQFjvcNw/EZTru7nTaDfYew4lV0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=ZFYESqTi; arc=none smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1761030788; x=1792566788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JG6/21Kc3LPmm7ifFU0zEa7/qVfomGnzIkk8iphJ08Q=;
  b=ZFYESqTis0Cp8Ld/BdgJrwAS7Y6xqQIo5/P0c4kFTT3BPHa3kHCGZPm3
   3VqqweZuZTlQpC/Y7lipA6uFG+gY+O4NKr3Q0BSyMrv3//GR2NdIGE7U5
   23qj2egJCXzUn9G8zJtR1BV0MJz4a1UVGM0tJFPwwD4RXd8qFJjZLBEKk
   cCf3rg11OJYRtoK9QTDfSdoVilAY7cnIzjyeUV2gPD0Wr58OwuhlDnip9
   8fFtABBR6m1CrXMY7itaGZfEFjI+WZ8VfrH340ODVjnX2b3wfXIx1T6Bs
   GOMhN3eRhFSBUBaka6JliQY6q9xZFFiwHk8BwEDup6FnkVRc59ARIYapa
   Q==;
X-CSE-ConnectionGUID: 9ajDuW3IRAqJTQOmqwROGg==
X-CSE-MsgGUID: w3M+VODYSFGUxfTSLykcsw==
X-IronPort-AV: E=Sophos;i="6.19,244,1754956800"; 
   d="scan'208";a="3832773"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 07:12:56 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:1068]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.47.14:2525] with esmtp (Farcaster)
 id 1553515b-eb11-4da4-8ddb-b9d47464950e; Tue, 21 Oct 2025 07:12:56 +0000 (UTC)
X-Farcaster-Flow-ID: 1553515b-eb11-4da4-8ddb-b9d47464950e
Received: from EX19D013EUB004.ant.amazon.com (10.252.51.92) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 07:12:55 +0000
Received: from dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com
 (10.253.107.175) by EX19D013EUB004.ant.amazon.com (10.252.51.92) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 21 Oct 2025
 07:12:46 +0000
From: Mahmoud Adam <mngyadam@amazon.de>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <nagy@khwaternagy.com>, Ryusuke Konishi
	<konishi.ryusuke@gmail.com>,
	<syzbot+00f7f5b884b117ee6773@syzkaller.appspotmail.com>,
	<syzbot+f30591e72bfc24d4715b@syzkaller.appspotmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Xiubo Li
	<xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jeff Layton
	<jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o
	<tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim
	<jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Christoph Hellwig
	<hch@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ceph-devel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-xfs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-nilfs@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH 6.1 8/8] nilfs2: fix deadlock warnings caused by lock dependency in init_nilfs()
Date: Tue, 21 Oct 2025 09:03:43 +0200
Message-ID: <20251021070353.96705-10-mngyadam@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021070353.96705-2-mngyadam@amazon.de>
References: <20251021070353.96705-2-mngyadam@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D013EUB004.ant.amazon.com (10.252.51.92)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit fb881cd7604536b17a1927fb0533f9a6982ffcc5 upstream.

After commit c0e473a0d226 ("block: fix race between set_blocksize and read
paths") was merged, set_blocksize() called by sb_set_blocksize() now locks
the inode of the backing device file.  As a result of this change, syzbot
started reporting deadlock warnings due to a circular dependency involving
the semaphore "ns_sem" of the nilfs object, the inode lock of the backing
device file, and the locks that this inode lock is transitively dependent
on.

This is caused by a new lock dependency added by the above change, since
init_nilfs() calls sb_set_blocksize() in the lock section of "ns_sem".
However, these warnings are false positives because init_nilfs() is called
in the early stage of the mount operation and the filesystem has not yet
started.

The reason why "ns_sem" is locked in init_nilfs() was to avoid a race
condition in nilfs_fill_super() caused by sharing a nilfs object among
multiple filesystem instances (super block structures) in the early
implementation.  However, nilfs objects and super block structures have
long ago become one-to-one, and there is no longer any need to use the
semaphore there.

So, fix this issue by removing the use of the semaphore "ns_sem" in
init_nilfs().

Link: https://lkml.kernel.org/r/20250503053327.12294-1-konishi.ryusuke@gmail.com
Fixes: c0e473a0d226 ("block: fix race between set_blocksize and read paths")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+00f7f5b884b117ee6773@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=00f7f5b884b117ee6773
Tested-by: syzbot+00f7f5b884b117ee6773@syzkaller.appspotmail.com
Reported-by: syzbot+f30591e72bfc24d4715b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f30591e72bfc24d4715b
Tested-by: syzbot+f30591e72bfc24d4715b@syzkaller.appspotmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Mahmoud Adam <mngyadam@amazon.de>
---
 fs/nilfs2/the_nilfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index be41e26b782469..05fdbbc63e1f5f 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -680,8 +680,6 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 	int blocksize;
 	int err;
 
-	down_write(&nilfs->ns_sem);
-
 	blocksize = sb_min_blocksize(sb, NILFS_MIN_BLOCK_SIZE);
 	if (!blocksize) {
 		nilfs_err(sb, "unable to set blocksize");
@@ -757,7 +755,6 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 	set_nilfs_init(nilfs);
 	err = 0;
  out:
-	up_write(&nilfs->ns_sem);
 	return err;
 
  failed_sbh:
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


