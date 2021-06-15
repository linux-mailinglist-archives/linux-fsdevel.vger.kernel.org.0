Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD673A7A2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 11:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhFOJUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 05:20:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54754 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhFOJUX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:20:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4DD37219DB;
        Tue, 15 Jun 2021 09:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623748695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2y4ATobPVnEcMEJhABd7mhzgYGQRV2///C8khknCrDI=;
        b=jkrSgf91dMSZKGLpwFnVzcX+RniA5lrBYoOpTKdscfVANjpzuygwReWX45ijFTqHWI/oP5
        6SIc40rlo9wSEueoc+eqxwrP39o9wT6pJo8bu1eWvP00C5ncP2WlrT27Hw1Zb0tWoxQpYR
        LvbV9V92glyJeD13FUgXPPVcUCYib8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623748695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2y4ATobPVnEcMEJhABd7mhzgYGQRV2///C8khknCrDI=;
        b=8JAptZxj9cSPv7QkSZ+GkFGANKcsiSwNgVsiI14DugpGsIS+68yIl+moQjnMjZBiYkk9h+
        Z1VMWYbCuGHWBYAw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 36F8FA3BA4;
        Tue, 15 Jun 2021 09:18:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5BFB01F2CC7; Tue, 15 Jun 2021 11:18:14 +0200 (CEST)
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
Subject: [PATCH 14/14] cifs: Fix race between hole punch and page fault
Date:   Tue, 15 Jun 2021 11:18:04 +0200
Message-Id: <20210615091814.28626-14-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210615090844.6045-1-jack@suse.cz>
References: <20210615090844.6045-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; h=from:subject; bh=ZCABbWCWKurwj2pIQo6pZPjhdXQ595KGSFP8UTIZMfk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBgyHBM5bKiu8eYGM3Nz8nWQKIiVrKQrT6ftatfT6be 2XeiCXeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYMhwTAAKCRCcnaoHP2RA2di6B/ 45mhRVQnW7UEq8suFiCGDgISonzDUeQNVWEgcLjdXBZEIDbjCB7lYGsbJf/2IQcCDyAp1zJtKbAA97 LKvEdr6VjgcXgV5+oiI4V26Eg4SeicN83dDn0lmsYHvEt32v8FDDtMnb3ANMlKSUEqBQNhPBKvF0Hu 7oan61Xlt9SjuKtR2DNIo6BnoW+d3ctXdP54jBT2o81yaKbIQNLQF1CkZsz+XDP8ihnmg7st97ymKU TPRJSfingbG2ZM2Sp63ozFihnFywZI3GwOjoVYCxmX8taZ69x0x3a1KarULQ8O4uuVOhr+9KDsEgoq Py6BTeucaRFVJYzpQRsDWUnDh/IZou
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cifs has a following race between hole punching and page fault:

CPU1                                            CPU2
smb3_fallocate()
  smb3_punch_hole()
    truncate_pagecache_range()
                                                filemap_fault()
                                                  - loads old data into the
                                                    page cache
    SMB2_ioctl(..., FSCTL_SET_ZERO_DATA, ...)

And now we have stale data in the page cache. Fix the problem by locking
out faults (as well as reads) using mapping->invalidate_lock while hole
punch is running.

CC: Steve French <sfrench@samba.org>
CC: linux-cifs@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/cifs/smb2ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 21ef51d338e0..07c9ec047020 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3581,6 +3581,7 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
 		return rc;
 	}
 
+	filemap_invalidate_lock(inode->i_mapping);
 	/*
 	 * We implement the punch hole through ioctl, so we need remove the page
 	 * caches first, otherwise the data may be inconsistent with the server.
@@ -3598,6 +3599,7 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
 			sizeof(struct file_zero_data_information),
 			CIFSMaxBufSize, NULL, NULL);
 	free_xid(xid);
+	filemap_invalidate_unlock(inode->i_mapping);
 	return rc;
 }
 
-- 
2.26.2

