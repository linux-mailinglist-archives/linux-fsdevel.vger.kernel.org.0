Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972D639DF7D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhFGOyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 10:54:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51740 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhFGOyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:54:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0DA7F1FDD6;
        Mon,  7 Jun 2021 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623077558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5hN9VihgYabPzS6M/DoMuNHHykbae3N2/E4zCgl0t4=;
        b=NFenYZndzTQCSEs0kiVAUsrK4q4SXXp9cvTfVysJCl9S8OYKpb3mep2Wudp9TVce+rKAos
        ADmLsAgkFnGXxOPA69oYb85BUicyV5sjjgoWrMhz6Wpq7+ACrl16M4hl2VwI4wW/Ld4Gho
        I9oJu7DPonRpgXb0g9RDbabMD167D1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623077558;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5hN9VihgYabPzS6M/DoMuNHHykbae3N2/E4zCgl0t4=;
        b=YpALarJquUvnyzCPi/IGQR1z3cZ2is7/Uh27Kg/PZfUSGOrH9/QH4sHHGmPwz8dPsIyLwH
        UR1UQkMjNEdHi2Bw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id DA68DA3B92;
        Mon,  7 Jun 2021 14:52:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C03301F2CBF; Mon,  7 Jun 2021 16:52:36 +0200 (CEST)
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
Subject: [PATCH 13/14] ceph: Fix race between hole punch and page fault
Date:   Mon,  7 Jun 2021 16:52:23 +0200
Message-Id: <20210607145236.31852-13-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210607144631.8717-1-jack@suse.cz>
References: <20210607144631.8717-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2465; h=from:subject; bh=Sp8IgV3mV8zmiY5I9Wbg4z0IgLX0J9niLgWRID5omWo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBgvjKmt/G434Rs9ZHmHm4m7KwtsKNjseeQr2d06yTU b1jblrKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYL4ypgAKCRCcnaoHP2RA2XPBB/ 0WRyE3RzVXQo4gUS7mKGJPyff+S+h8thH32QhOWZDXf4WYznPoJ+G3wFt5xde4p7HM3U7v4hpB7tQ8 EygfikeupmDm5O4NkUcQX/1NsWO5mf1y1khgu8KW9yas0wO4nNDvfUKTZj+5HUQukNJRO9ns9dIP+i ZHpf05z3tet5psuGs9y6FwuZstNgxlaQ9J8UOjG7fthTYQQ84eb7tMDli7aa2ogiQCpEULtSaR2KZq oSaXwXuly1pLWQKgrrob8K3/TVpt+5qVCPl0s81BB5Lp+mP2VILVhXd3lUp0wCBKewMTkqSdkyuX4i GM5IPBYS2vNK7LNSJvGIyk6io3Qiy/
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
index c1570fada3d8..4664b93a32db 100644
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
+		filemap_invalidate_lock_shared(mapping);
+		page = find_or_create_page(mapping, 0,
+				mapping_gfp_constraint(mapping, ~__GFP_FS));
 		if (!page) {
 			ret = VM_FAULT_OOM;
 			goto out_inline;
@@ -1424,6 +1426,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		vmf->page = page;
 		ret = VM_FAULT_MAJOR | VM_FAULT_LOCKED;
 out_inline:
+		filemap_invalidate_unlock_shared(mapping);
 		dout("filemap_fault %p %llu read inline data ret %x\n",
 		     inode, off, ret);
 	}
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 77fc037d5beb..e826b1b1e4af 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2083,6 +2083,7 @@ static long ceph_fallocate(struct file *file, int mode,
 	if (ret < 0)
 		goto unlock;
 
+	filemap_invalidate_lock(inode->i_mapping);
 	ceph_zero_pagecache_range(inode, offset, length);
 	ret = ceph_zero_objects(inode, offset, length);
 
@@ -2095,6 +2096,7 @@ static long ceph_fallocate(struct file *file, int mode,
 		if (dirty)
 			__mark_inode_dirty(inode, dirty);
 	}
+	filemap_invalidate_unlock(inode->i_mapping);
 
 	ceph_put_cap_refs(ci, got);
 unlock:
-- 
2.26.2

