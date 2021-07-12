Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5343C6146
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 18:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbhGLRAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 13:00:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54494 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbhGLQ7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:59:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 477E51FFD8;
        Mon, 12 Jul 2021 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626108970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blXH/6I2F2wS3AR3z8Jn+sP5qB3/RsNTR1FPrDAVGAo=;
        b=iTYcqzKzVW0oBJ2ZSeBcw/3PSPPBIqymjzPuCMxKiy4ll/cAyuHykJMMhDGWNBhKCo9N6d
        JoKyDS1Vf/98lmBfMmGXVFVyohSVi0TCOIKxSEx2HfKnzIB6DVdHCaNV5uQEvNnGJJDYe5
        BXJCgmkJRcXuloEW//0bAGfTMDLnT84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626108970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blXH/6I2F2wS3AR3z8Jn+sP5qB3/RsNTR1FPrDAVGAo=;
        b=TnUFj81r13w/wYsLizGkWgSqGm0ypAYnVLlQkqfeg3A6rxOUXmyJxudAqkSb53M7c4aI3M
        nbJlAd4Nq/JTdXCQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 31F9AA3B8B;
        Mon, 12 Jul 2021 16:56:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E69101F2CE4; Mon, 12 Jul 2021 18:56:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 13/14] ceph: Fix race between hole punch and page fault
Date:   Mon, 12 Jul 2021 18:56:04 +0200
Message-Id: <20210712165609.13215-13-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210712163901.29514-1-jack@suse.cz>
References: <20210712163901.29514-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2465; h=from:subject; bh=YtbsQ0zyJQcvofUJ0OfZKBGWEvBnT2OBf1X3WQMmS78=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7HQkAjeBC3GigbXzTaUkkhsP7h/tHN+6ua4RThYv n77PQ8aJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOx0JAAKCRCcnaoHP2RA2dqDCA DMUmz3eKJXbKKMC35HDOwmLy0OWr2Q8JYrx2Zz9UI2uWVgU2WhLn/rATSlXPJNOvCBhNAHNerq4wgy 7PpwNJ+yrODpsPqO9TtPc9TkVC09gzyMEBd7zFvNwNo1HSBgCVqkhQDsIsoQ5qYKhnwXBcwUfe/jAG OrGz+CGinBfxWyd84sxZK5OI0xEsc+l1VRkwKNZvv3KZkwMMU2svJg7cL9j9hj9YAxiLuU5ZW8QGZ1 y6+a4hpeY6Y2uHEbvy2hQDJINGnW0A2SLcRYSknpM1/xzmH9sXxuLWPXAHMMnoILkmldGX6mMn95IT DMYouVz+KM3O+Gd6ROohEGhW/OH/mN
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ceph/addr.c | 9 ++++++---
 fs/ceph/file.c | 2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index a1e2813731d1..7e7a897ae0d3 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1395,9 +1395,11 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		ret = VM_FAULT_SIGBUS;
 	} else {
 		struct address_space *mapping = inode->i_mapping;
-		struct page *page = find_or_create_page(mapping, 0,
-						mapping_gfp_constraint(mapping,
-						~__GFP_FS));
+		struct page *page;
+
+		filemap_invalidate_lock_shared(mapping);
+		page = find_or_create_page(mapping, 0,
+				mapping_gfp_constraint(mapping, ~__GFP_FS));
 		if (!page) {
 			ret = VM_FAULT_OOM;
 			goto out_inline;
@@ -1418,6 +1420,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		vmf->page = page;
 		ret = VM_FAULT_MAJOR | VM_FAULT_LOCKED;
 out_inline:
+		filemap_invalidate_unlock_shared(mapping);
 		dout("filemap_fault %p %llu read inline data ret %x\n",
 		     inode, off, ret);
 	}
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d1755ac1d964..e1d605a02d4a 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2088,6 +2088,7 @@ static long ceph_fallocate(struct file *file, int mode,
 	if (ret < 0)
 		goto unlock;
 
+	filemap_invalidate_lock(inode->i_mapping);
 	ceph_zero_pagecache_range(inode, offset, length);
 	ret = ceph_zero_objects(inode, offset, length);
 
@@ -2100,6 +2101,7 @@ static long ceph_fallocate(struct file *file, int mode,
 		if (dirty)
 			__mark_inode_dirty(inode, dirty);
 	}
+	filemap_invalidate_unlock(inode->i_mapping);
 
 	ceph_put_cap_refs(ci, got);
 unlock:
-- 
2.26.2

