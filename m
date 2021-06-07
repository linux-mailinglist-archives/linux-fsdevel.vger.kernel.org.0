Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D739DF89
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 16:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhFGOyi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 10:54:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34746 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhFGOyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:54:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0464C21A9F;
        Mon,  7 Jun 2021 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623077558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vl6h8io6lSoWK7OIrnD7E7ya5J3bdZJ7HzP2D9qWuTI=;
        b=pKfvrYrcy1xAVtKNmw9VHwTemgYio9dqCCXj2qp2s2JWUKyLBGbU0ymRIUsFMTnem07EFP
        Rdc/QIuzF2BthdMO2sBS/L4z/rA/917Pf9sTft9oGj3xqIWDaTmw14BY3oBHj9U9ZUA7P4
        3CsHFNGPY7rieEn/jaNNM+eG7j7qPGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623077558;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vl6h8io6lSoWK7OIrnD7E7ya5J3bdZJ7HzP2D9qWuTI=;
        b=3pUZCLZilKHDEtXnzJoG6nngWw0wNgbZHlnJxu0cudCyLBIYO1DwS4rc3i5Vx4QUQ3xDzz
        VUH9U7p0kK3UXkCw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id DA79EA3B99;
        Mon,  7 Jun 2021 14:52:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C41211F2CC0; Mon,  7 Jun 2021 16:52:36 +0200 (CEST)
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
Date:   Mon,  7 Jun 2021 16:52:24 +0200
Message-Id: <20210607145236.31852-14-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210607144631.8717-1-jack@suse.cz>
References: <20210607144631.8717-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; h=from:subject; bh=yLMJejfXbe3cEmy2dQFvIvX02RxXlz2mOO0L4SMl8Co=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBgvjKnJxY3aOf0Uh04RpHAOh/EZgichtc+O2fd+Y+C czFMeL2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYL4ypwAKCRCcnaoHP2RA2Ue3B/ 9exfyIQAzlGqcG2osnZCouldM63nI3uW0xQ2C9f5oG2IPFvR9kW48iWOZvY8IeVLn/hDfPcumyTE3S rVE5Wb8HloLQVQrPKhUTw8U7QuIJVnxEWeBrOQRkcJm2p/i8DGH/tJK6Iw/z6QFn3oEoOyOT96u/HQ XvMcq+lNmKNSfUE9n6xOQJOdvYt2bMCS7UF3V1ONE8X1HkyUHJxDYBL+zW7gTkfxuBg+Ym0QIiNQzi zBwKLs2btjQxoUfPsSpa6AqqbGrmx+OjASJLWob322k8teI7Y8mEDXc6smlXTSonPzIEcQRXKvJoIG PzUylz0kA5utwu4PimVcuV48+9RTJg
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
index dd0eb665b680..e41ea254beaa 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3579,6 +3579,7 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
 		return rc;
 	}
 
+	filemap_invalidate_lock(inode->i_mapping);
 	/*
 	 * We implement the punch hole through ioctl, so we need remove the page
 	 * caches first, otherwise the data may be inconsistent with the server.
@@ -3596,6 +3597,7 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
 			sizeof(struct file_zero_data_information),
 			CIFSMaxBufSize, NULL, NULL);
 	free_xid(xid);
+	filemap_invalidate_unlock(inode->i_mapping);
 	return rc;
 }
 
-- 
2.26.2

