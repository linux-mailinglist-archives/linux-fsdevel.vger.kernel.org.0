Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD9637BE92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhELNrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:47:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:41664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231166AbhELNro (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:47:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD05EB1A6;
        Wed, 12 May 2021 13:46:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0930B1F2B6C; Wed, 12 May 2021 15:46:32 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 10/11] ceph: Fix race between hole punch and page fault
Date:   Wed, 12 May 2021 15:46:18 +0200
Message-Id: <20210512134631.4053-10-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210512101639.22278-1-jack@suse.cz>
References: <20210512101639.22278-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ceph has a following race between hole punching and page fault:

CPU1                                  CPU2
ceph_fallocate()
  ...
  ceph_zero_pagecache_range()
                                      ceph_filemap_fault()
                                        faults in page in the range being
                                        punched
  ceph_zero_objects()

And now we have a page in punched range with invalid data. Fix the
problem by using mapping->invalidate_lock similarly to other
filesystems. Note that using invalidate_lock also fixes a similar race
wrt ->readpage().

CC: Jeff Layton <jlayton@kernel.org>
CC: ceph-devel@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ceph/addr.c | 9 ++++++---
 fs/ceph/file.c | 2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index c1570fada3d8..6d868faf97b5 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1401,9 +1401,11 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		ret = VM_FAULT_SIGBUS;
 	} else {
 		struct address_space *mapping = inode->i_mapping;
-		struct page *page = find_or_create_page(mapping, 0,
-						mapping_gfp_constraint(mapping,
-						~__GFP_FS));
+		struct page *page;
+
+		down_read(&mapping->invalidate_lock);
+		page = find_or_create_page(mapping, 0,
+				mapping_gfp_constraint(mapping, ~__GFP_FS));
 		if (!page) {
 			ret = VM_FAULT_OOM;
 			goto out_inline;
@@ -1424,6 +1426,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		vmf->page = page;
 		ret = VM_FAULT_MAJOR | VM_FAULT_LOCKED;
 out_inline:
+		up_read(&mapping->invalidate_lock);
 		dout("filemap_fault %p %llu read inline data ret %x\n",
 		     inode, off, ret);
 	}
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 77fc037d5beb..91693d8b458e 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2083,6 +2083,7 @@ static long ceph_fallocate(struct file *file, int mode,
 	if (ret < 0)
 		goto unlock;
 
+	down_write(&inode->i_mapping->invalidate_lock);
 	ceph_zero_pagecache_range(inode, offset, length);
 	ret = ceph_zero_objects(inode, offset, length);
 
@@ -2095,6 +2096,7 @@ static long ceph_fallocate(struct file *file, int mode,
 		if (dirty)
 			__mark_inode_dirty(inode, dirty);
 	}
+	up_write(&inode->i_mapping->invalidate_lock);
 
 	ceph_put_cap_refs(ci, got);
 unlock:
-- 
2.26.2

