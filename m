Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9319E3C9FB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 15:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbhGONnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 09:43:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59720 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbhGONn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 09:43:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8C5E920303;
        Thu, 15 Jul 2021 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626356433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHhQqe8KTjBCv9r4mi6xe2At5YRjoevCFxA6zjCOvEc=;
        b=RuJfucQ18UcdWSlSoKBS0R02LQqU1/2ikN5fVOsUopTm5nVBDrhxzwoexmEPqEfDpiFR/f
        h+qcLI/KXCIM5K9dG6BkjTUF9Jd4Z85o20OQyK28wK2Z/X0BOJ8jCdlBKz20WHBt1bCCVb
        moM3VmI061wTH+Chtl1RODrrlZNEyR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626356433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHhQqe8KTjBCv9r4mi6xe2At5YRjoevCFxA6zjCOvEc=;
        b=okfc6hssx0z1h1XKdCgUrgiqbuGqpuR+6jkXPziR0sbZUxXCsDdVf5LpJxwHEQW8SJ8h69
        h5gs7zxRdmnrUeCg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 75781A3B9B;
        Thu, 15 Jul 2021 13:40:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 34DDA1E110A; Thu, 15 Jul 2021 15:40:33 +0200 (CEST)
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
        Steve French <sfrench@samba.org>
Subject: [PATCH 14/14] cifs: Fix race between hole punch and page fault
Date:   Thu, 15 Jul 2021 15:40:24 +0200
Message-Id: <20210715134032.24868-14-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210715133202.5975-1-jack@suse.cz>
References: <20210715133202.5975-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; h=from:subject; bh=1e9BARQoajJDSgUdYORenFPF3ecMZ7Jduf79ehs8h7w=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGBI+WB1n1Ns3Y96Kydy5/1TSyzp5XkorV0pMDjoluy51bumy pHq5TkZjFgZGDgZZMUWW1ZEXta/NM+raGqohAzOIlQlkCgMXpwBMZOcODoZWJVaREsa87UFlLCyKym 6Jz7/Om7Llk3eCg4bKo9Mz5yQv57j/oybvSLtrzHthh0TB2CtnGXOMp2jfvbtdVV/OezJjU7votVnG llXaMuz16cwaKVErlmcwc4VzuIdkbl1902Oq6ZOkT8+s+dUE8pe2Nt9tuBa4U21Oycx5efGnpy855L RFINhWyEgzMmXDxUCTm0cq2aS+nGqerlR/7EpmjLGTVcWK6GtLV8TYd8XMF9/G6rZlz8qXj1k/yy04 L/70Rm151ZWv8u8jkhOtnzn1qzf+lBRWTmXmyBF9tOJVo+OL20Kxc9zFGqZFbTe1Tpx7f6aT79Rz5+ KYW3iC+t5EbhGRPfjkj5xdzfJSAA==
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
index e4c8f603dd58..458c546ce8cd 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3588,6 +3588,7 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
 		return rc;
 	}
 
+	filemap_invalidate_lock(inode->i_mapping);
 	/*
 	 * We implement the punch hole through ioctl, so we need remove the page
 	 * caches first, otherwise the data may be inconsistent with the server.
@@ -3605,6 +3606,7 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
 			sizeof(struct file_zero_data_information),
 			CIFSMaxBufSize, NULL, NULL);
 	free_xid(xid);
+	filemap_invalidate_unlock(inode->i_mapping);
 	return rc;
 }
 
-- 
2.26.2

