Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073073C9FD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 15:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbhGONnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 09:43:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55812 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbhGONnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 09:43:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 861F422A7F;
        Thu, 15 Jul 2021 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626356433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blXH/6I2F2wS3AR3z8Jn+sP5qB3/RsNTR1FPrDAVGAo=;
        b=wKNzZoaLDjhipnh8ttsBgje5D0Ok3rqr4tTSatFCIsiR8C0wwioWb9OQ7GyVYuO3zx7s/o
        x66RWB/W4cf+VKAQtsyhs1yitLudsWYgZeLsq3s1PjdlcmTX/TmHeiL7rk7tTdnBvLbdG3
        glpPwHOWpQ5LyLWndaVoXIq96AxjLgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626356433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blXH/6I2F2wS3AR3z8Jn+sP5qB3/RsNTR1FPrDAVGAo=;
        b=3IDWz7NTfWFD9C5Lyl1NHQ8/UihGE3JVo7rfCzqxP17la0uNiEHKtrXZPHB3iHx+qY8G4o
        pjuUCLnJZ/JHKEBw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 73768A3BA6;
        Thu, 15 Jul 2021 13:40:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 31F8B1E10FD; Thu, 15 Jul 2021 15:40:33 +0200 (CEST)
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
Date:   Thu, 15 Jul 2021 15:40:23 +0200
Message-Id: <20210715134032.24868-13-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210715133202.5975-1-jack@suse.cz>
References: <20210715133202.5975-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2465; h=from:subject; bh=YtbsQ0zyJQcvofUJ0OfZKBGWEvBnT2OBf1X3WQMmS78=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg8DrGAjeBC3GigbXzTaUkkhsP7h/tHN+6ua4RThYv n77PQ8aJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYPA6xgAKCRCcnaoHP2RA2Uk5B/ wIPJb+pvH9ICTCScS6xTQ9YeFoVZSSLdhM5PjEAGgZTtYWqHre6ndf2vXYsaKDMJy69rgTLxtrpQpa /AJgkGaTIuip7mdIFkbLA1UvsUdX+crmGVYg6QE04F6VKiTuy5EqSb1h0Y9YsDBVxwjHuqb4bECYq4 VbxzLGyeS1KMWDBuJizggPabh3yL9EC1NyWmQ/da2wqqlCtgOlTUxIcmsg1po0j7nJUAgn0dJcA3d4 tbTVc7ltQH+OvEN4CrDutgB4RtaiyttV4pmFYF7AL/F6U9L0vSlNC0yXHNFjKanGlbKvK/3sD6Lw6S JoKKNO5Us08YCrHUyo8hNTs/Q3SX3W
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

