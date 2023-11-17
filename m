Return-Path: <linux-fsdevel+bounces-3038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A307EF5F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 17:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB40280FA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0552B3EA8E;
	Fri, 17 Nov 2023 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SY3gTiTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700DC196
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 08:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=M8tcrjn8J3mAVtHdNJxXIwwBJZthYabYLJRVFBqKzTc=; b=SY3gTiTV79l8O4Ss4E5KcaLsWw
	c/mTm3pDFVfZtoPBYeOI0beecuGWq/RPzxAQOtMKbCelZzN/3TKR3vQkSzT2aDOoigBuNUAjEEvmu
	F8Wu6cCCHyAATta0Ds7kVHMGb+RDA/uuBB7BCvjoMEq5kXZNdyb9GY7XbliXk8LpZ98MJ5Xy9gfYA
	jRRjGKJykJpmG2CVVyk6Ck1wDPJoz2jKLS0Ou7qByvYLB+H7CzDBjieCW0z1n2/GPDyahenZfS7Nc
	21opa64JfAgeDZBGHWVHaDp1GWsZu4ozqjKLxGDNfu2g3g0KXDvwDAk4vBiaiTIAk6nykh3nAxveE
	OTeL7ONA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r41Uc-00AKVL-DQ; Fri, 17 Nov 2023 16:14:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/6] Convert aops->error_remove_page to ->error_remove_folio
Date: Fri, 17 Nov 2023 16:14:41 +0000
Message-Id: <20231117161447.2461643-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While this affects every filesystem, it's generally in a trivial way,
so I haven't cc'd the maintainers as it won't affect them.  Really,
this is a memory-failure patch series which converts a lot of uses of
page APIs into folio APIs with the usual benefits.

It is only compile tested.  Nothing here should change any user-visible
behaviour.

Matthew Wilcox (Oracle) (6):
  memory-failure: Use a folio in me_pagecache_clean()
  memory-failure: Use a folio in me_pagecache_dirty()
  memory-failure: Convert delete_from_lru_cache() to take a folio
  memory-failure: Use a folio in me_huge_page()
  memory-failure: Convert truncate_error_page to truncate_error_folio
  fs: Convert error_remove_page to error_remove_folio

 Documentation/filesystems/locking.rst |  4 +-
 Documentation/filesystems/vfs.rst     |  6 +--
 block/fops.c                          |  2 +-
 fs/afs/write.c                        |  2 +-
 fs/bcachefs/fs.c                      |  2 +-
 fs/btrfs/inode.c                      |  2 +-
 fs/ceph/addr.c                        |  4 +-
 fs/ext2/inode.c                       |  2 +-
 fs/ext4/inode.c                       |  6 +--
 fs/f2fs/compress.c                    |  2 +-
 fs/f2fs/inode.c                       |  2 +-
 fs/gfs2/aops.c                        |  4 +-
 fs/hugetlbfs/inode.c                  |  6 +--
 fs/nfs/file.c                         |  2 +-
 fs/ntfs/aops.c                        |  6 +--
 fs/ocfs2/aops.c                       |  2 +-
 fs/xfs/xfs_aops.c                     |  2 +-
 fs/zonefs/file.c                      |  2 +-
 include/linux/fs.h                    |  2 +-
 include/linux/mm.h                    |  3 +-
 mm/memory-failure.c                   | 63 +++++++++++++--------------
 mm/shmem.c                            |  6 +--
 mm/truncate.c                         |  9 ++--
 virt/kvm/guest_memfd.c                |  9 ++--
 24 files changed, 75 insertions(+), 75 deletions(-)

-- 
2.42.0


