Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE99EEFCDE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 13:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfKEMCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 07:02:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40728 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfKEMCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:02:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id e3so7177675plt.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Nov 2019 04:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C4JTtLfW0Tocso0HHtIJVM1LwapQ7u0zpOXtwObQFvU=;
        b=mYAc6W7nwc4HxmM0tO6mmTrtCouBkNtp3MTioj+dDnC69pgwP4DOdEqBXSrz0287UW
         BWdFgzGMK/pCscuI3gI/11GR1CgmTp7qNI8BdLGgqY6vo8jdfAEgEUHmtCLZHMr/7rL1
         4SWPJJ24UfORj7boiOKhQDhyac/DQfPYtRJfOa34y0nPxRVXJzaTbuBgTLpWSuBibR+E
         e1KEgHlgEhym9Qm7hpAhfHgvL0SJnE71JlQ4Fo4wqKgObhlrglsXS1iVC+QoP5umpD8l
         Dox8qpIpnceY3spsnuu1jHc22fOSAjCrWNY3t0GXGIkGcM/tndmHHZ+yCB88JT5akqCK
         eI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C4JTtLfW0Tocso0HHtIJVM1LwapQ7u0zpOXtwObQFvU=;
        b=gWFTjW/mv/yZfQh8LO7yGtkxLHf0/bUGw+JBXj1UBtFPKFSmN1D3WD2ztVR6m3WlHy
         tbxF2cSse+c3Ppzuw4AiTAyjM4+ioX2TRAv7eM0MIi6FVaMqW0nFu9cevtAk9a+lf0No
         yA3f/BEREUxMFPTGx/0i1bG52Yju6FE3d/lx/i8qYKNJq2MGE4+l0pX36NMDCIjeiUaS
         MD4PiINfMAVwYeZYqOHlm4CbjGs6rN11ZoGDnBrDTVVX3lBBtA6elao1Od85j1x047HX
         Q7IMUy5V+g9XGBSWDeAJ9erhlx+1ttuK7CtsPkWc5BZlZyqA+PpFiYxRR5iYv4oiiaGf
         nLrA==
X-Gm-Message-State: APjAAAWeFQ9WMnE64wKrT2Yo7mU7Oma2Ya5UzLeJIp6f7lO0imZfs1pI
        YJB9tW937XsGbwyjRpxw9g9E
X-Google-Smtp-Source: APXvYqw91hnJKX/xpc0YJQ3Cr+NkpzwXHzeGyCUvxHp8dDVV4Mvzz1qbgM1xnVoXlWFZItA1S0JWGA==
X-Received: by 2002:a17:902:bcc7:: with SMTP id o7mr33399536pls.333.1572955335852;
        Tue, 05 Nov 2019 04:02:15 -0800 (PST)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id j14sm19921156pje.17.2019.11.05.04.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 04:02:14 -0800 (PST)
Date:   Tue, 5 Nov 2019 23:02:08 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: [PATCH v7 09/11] ext4: move inode extension check out from
 ext4_iomap_alloc()
Message-ID: <fd5c84db25d5d0da87d97ed4c36fd844f57da759.1572949325.git.mbobrowski@mbobrowski.org>
References: <cover.1572949325.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572949325.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Lift the inode extension/orphan list handling code out from
ext4_iomap_alloc() and apply it within the ext4_dax_write_iter().

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/file.c  | 24 +++++++++++++++++++++++-
 fs/ext4/inode.c | 22 ----------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index ec54fec96a81..83ef9c9ed208 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -323,6 +323,8 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t ret;
 	size_t count;
 	loff_t offset;
+	handle_t *handle;
+	bool extend = false;
 	struct inode *inode = file_inode(iocb->ki_filp);
 
 	if (!inode_trylock(inode)) {
@@ -342,8 +344,28 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	offset = iocb->ki_pos;
 	count = iov_iter_count(from);
+
+	if (offset + count > EXT4_I(inode)->i_disksize) {
+		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+		if (IS_ERR(handle)) {
+			ret = PTR_ERR(handle);
+			goto out;
+		}
+
+		ret = ext4_orphan_add(handle, inode);
+		if (ret) {
+			ext4_journal_stop(handle);
+			goto out;
+		}
+
+		extend = true;
+		ext4_journal_stop(handle);
+	}
+
 	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
-	ret = ext4_handle_inode_extension(inode, offset, ret, count);
+
+	if (extend)
+		ret = ext4_handle_inode_extension(inode, offset, ret, count);
 out:
 	inode_unlock(inode);
 	if (ret > 0)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 071a1f976aab..392085aa7809 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3494,7 +3494,6 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 			    unsigned int flags)
 {
 	handle_t *handle;
-	u8 blkbits = inode->i_blkbits;
 	int ret, dio_credits, retries = 0;
 
 	/*
@@ -3517,28 +3516,7 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 		return PTR_ERR(handle);
 
 	ret = ext4_map_blocks(handle, inode, map, EXT4_GET_BLOCKS_CREATE_ZERO);
-	if (ret < 0)
-		goto journal_stop;
-
-	/*
-	 * If we've allocated blocks beyond EOF, we need to ensure that they're
-	 * truncated if we crash before updating the inode size metadata within
-	 * ext4_iomap_end(). For faults, we don't need to do that (and cannot
-	 * due to orphan list operations needing an inode_lock()). If we happen
-	 * to instantiate blocks beyond EOF, it is because we race with a
-	 * truncate operation, which already has added the inode onto the
-	 * orphan list.
-	 */
-	if (!(flags & IOMAP_FAULT) && map->m_lblk + map->m_len >
-	    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
-		int err;
-
-		err = ext4_orphan_add(handle, inode);
-		if (err < 0)
-			ret = err;
-	}
 
-journal_stop:
 	ext4_journal_stop(handle);
 	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry;
-- 
2.20.1

