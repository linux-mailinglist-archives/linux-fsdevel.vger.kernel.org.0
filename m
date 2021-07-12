Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F8D3C6149
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhGLRAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 13:00:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34630 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbhGLQ7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:59:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4BC5F2212F;
        Mon, 12 Jul 2021 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626108970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHhQqe8KTjBCv9r4mi6xe2At5YRjoevCFxA6zjCOvEc=;
        b=ZESWo0+jV0zYOW8UBnDvLHP40wD4Mizkdi3GL2a5tQw4l+5H/3r+WCw8lG38ognWMuzAir
        tcOcmkCMPX37xr1NU0VCTckY3UvvDDj7tTD3Bu1lsU8C3dGjMa8KO/+dkjOoL7uaQvat0m
        liWED2/F46K5fur5cg9oAjmpvcw++80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626108970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHhQqe8KTjBCv9r4mi6xe2At5YRjoevCFxA6zjCOvEc=;
        b=nwaFUtZvJiGfTCuyP2yCuDyUqORKcbdPqKWTp4GjFiBFK+dHUOfXJaNP2sLvWW4bNywxzi
        Vs5yDOLGBuV5+AAg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 34EB6A3B8C;
        Mon, 12 Jul 2021 16:56:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EADE31F2CE6; Mon, 12 Jul 2021 18:56:09 +0200 (CEST)
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
Date:   Mon, 12 Jul 2021 18:56:05 +0200
Message-Id: <20210712165609.13215-14-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210712163901.29514-1-jack@suse.cz>
References: <20210712163901.29514-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; h=from:subject; bh=1e9BARQoajJDSgUdYORenFPF3ecMZ7Jduf79ehs8h7w=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7HQkAS6+mJ6okwtt/iRndokM6RsjeRiTUsodrmWd daZifx6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOx0JAAKCRCcnaoHP2RA2a2dB/ sGPl7L7iNC+Ygp3aaAb8TuC+CK7Fa16RT+41tzwVRlQcnfmi7CVZIqfg9wn8dFg+Rwo985dKOjqKBC Rkbj05bjkHH9zmlZ5YZ+X92bgSHksva5hcdPkI3PM5v6sCXvIMGdeKJvQ7OUyLqoS8vAwHFZCA6FfN oKBhzEjKFekquNo/8GdftAgbDSO70kSs2v1iR2SpAHq/DWr1NsJ0/SUel0YbkYCJVK/t1Jybo0fOS3 hzlpdrYgSafKZV1HZ762tDktI+gjO6r/m5sW8bVZitIHHqVxrctKOIPAGfL2NMRnxMzWVNlMBMdoo7 Y6A0YzNG5g9ezVbk8Vutbf63fL3esc
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

