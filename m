Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC0FE6FFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 11:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbfJ1KxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 06:53:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33754 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731030AbfJ1KxN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:53:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id u23so6665769pgo.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 03:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=85uK5SPDrOSgd4/UZbXAWGK0mzidi8Z7PgS+mbnmLLg=;
        b=k+V7j4Dt1th3d0RcyGq6mbTtakcXti0F639aJaOZNiyvf5bhnkxiuv/lA3kS7KVJDc
         s1HTJAtb91zYGfsYHaVSk7jHL9NEsMclBo989U3p+vmGMy6wNdAs5WdtOCNJT2VJ/7Wy
         Vp/su5RO3XTGD4nDTlP2dXgVpFCt2bqmNmh96WX39id8d+uSnfFAGTjvUWyliDxadc9o
         eWm9l/kmv8AlvkV/cx/NEGpd0/OqkK6GbrlwOOcwPqUaqrya34fIcm13DYIrtiNR6FNE
         rGl31z99+1Ze0dmMk7UC9znKuAqoniBUHrgVvqCcIBEZXblJRnGPQR2rWuNGPExMcTDF
         v2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=85uK5SPDrOSgd4/UZbXAWGK0mzidi8Z7PgS+mbnmLLg=;
        b=NLY67/hA1ge+t5e5hb5st/gDsiFnV9O3Ky08Iu9goutACaKEGrBcziijsmTI/+NPBZ
         ZParEykHft2x/ug2jI8qytrwdlEZokSQnUCh6gMfak0t2K6Nb9L2EUXffqUA1NLxdOfP
         LOdzk1g/f1jRVQI9T5lQ7UHSP5pRbVNPvTQLfCRf5fISchNvQCya3nYr5ecLiQH+fMUt
         zehhShF1AgosL9CEqVm9rNlp8xE9wTT53/otiU+1lBywmsFXF/2XmgopvtSpKGRrGwEz
         7Hi/CGH8RzNzqS1uR+p5zh6QbZqhcZkhMQkS8J3Sz96N4xWB2oRHFyE8z93k1IvQPTLa
         +tqQ==
X-Gm-Message-State: APjAAAWEyg4LyZDLT1ek4k+ZeIEIOkOvhnU2lgZfjHisu68EtsahDcrQ
        TB5PjLQTEOI1D9AkEZhsRasm
X-Google-Smtp-Source: APXvYqzHDAKvvAZQN6/3ujQbMxPqjcELczXwIgD9GjZj/TPpo6JcMrbqPbq+ZU9nAm0PMXbH8G8Ekw==
X-Received: by 2002:a63:f050:: with SMTP id s16mr19972049pgj.261.1572259992721;
        Mon, 28 Oct 2019 03:53:12 -0700 (PDT)
Received: from poseidon.bobrowski.net (d114-78-127-22.bla803.nsw.optusnet.com.au. [114.78.127.22])
        by smtp.gmail.com with ESMTPSA id v68sm10648961pfv.47.2019.10.28.03.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 03:53:12 -0700 (PDT)
Date:   Mon, 28 Oct 2019 21:53:06 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v6 09/11] ext4: move inode extension check out from
 ext4_iomap_alloc()
Message-ID: <efb044a8a563c8a7de6a739b16388702214838d8.1572255426.git.mbobrowski@mbobrowski.org>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572255424.git.mbobrowski@mbobrowski.org>
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
index 7c21028760ee..2ca2e6e69344 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3454,7 +3454,6 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 			    unsigned int flags)
 {
 	handle_t *handle;
-	u8 blkbits = inode->i_blkbits;
 	int ret, dio_credits, retries = 0;
 
 	/*
@@ -3477,28 +3476,7 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
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

