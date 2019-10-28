Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEFBE6FEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 11:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbfJ1KvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 06:51:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43486 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388297AbfJ1KvY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:51:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id l24so6627154pgh.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G6CFq/h8k/c9oWEGqBl9JxHFVW55BNMnE9xk8vXWFJc=;
        b=J4jFXinLsX5dmwoyvFzhhoocnfyONCPBLWxTe23x2/t4nHuRk8IBRma6i1y4Dg11rG
         1y5wXczUJYFBHaTrmnR00M5mGOqtXLrLxyJfj9ox5qp5NiEiba9hADYVBYcbucKgpKrt
         2I8ght4J88dXiNHUUtNhHTk0Ty9oYuLaTXNGpELwJf0NOA2mZ8Qk4CLGn6lNhXkwsqM4
         o+QjUrX17iHQrfNJgIjEdHO+3LN6Ag7v/LiUZlxSQsIUK9+YOdzCzZkG1vDAGWHNbR0y
         0Yd0zVxM0Ms7CAs4o1mlkzjqGhotCuYv2FYuSxNt2z+rtNXIsbK/WZHM+QYC2Hy82LTp
         DJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G6CFq/h8k/c9oWEGqBl9JxHFVW55BNMnE9xk8vXWFJc=;
        b=MZ0PlhCokHgNzwnjiodblk5//Xu+/0k0SEZHmqCvmU+sw/3JlQy9Ll+j8C2zrT2Pho
         /cmJGdv71BW1mI4bnfncOG7uXojw0MBlR/HOB8z+oMkHAji6sapZagAv1lPrZ72QI4DB
         ecmWe5YUn1yqpnL0d5ENz3HWqS6y1jDILC6/6NHjhX27jGLE1IcCUF1CgjEBZx3sPEoy
         RImtam4FHnQsIFvjzOCEQp5ouwNiZ/Mt8CiIIypQMp9N8YX/C+/qD5a7ZEuPe46/yEy/
         msDMyXU50DFz3VrYgj1QJCHhlurWlcEBNumtqji0YdePYSo1zNExRINzgI9CkznfMBmq
         Fj7Q==
X-Gm-Message-State: APjAAAWTQuqi7v6OHejStW/rFOq9cx/4+t7BTTVRU1ZzUo9dPE8NxyOb
        eNTrJmycRT3wJ9Z4FcIwZ6Xr
X-Google-Smtp-Source: APXvYqwS8C4L1744maTaOYKwBZ7s1w5VWttnJ10FMSz29wrbBk64/wb4Cwe8o07TuyVhG9UTfc0Q6A==
X-Received: by 2002:a63:c40e:: with SMTP id h14mr19858935pgd.254.1572259883449;
        Mon, 28 Oct 2019 03:51:23 -0700 (PDT)
Received: from poseidon.bobrowski.net (d114-78-127-22.bla803.nsw.optusnet.com.au. [114.78.127.22])
        by smtp.gmail.com with ESMTPSA id m4sm8948764pjs.8.2019.10.28.03.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 03:51:22 -0700 (PDT)
Date:   Mon, 28 Oct 2019 21:51:16 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v6 03/11] ext4: iomap that extends beyond EOF should be
 marked dirty
Message-ID: <2c5b5fc06d1ba70676f09dfc5430ea1c4bafc631.1572255425.git.mbobrowski@mbobrowski.org>
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

This patch addresses what Dave Chinner had discovered and fixed within
commit: 7684e2c4384d. This changes does not have any user visible
impact for ext4 as none of the current users of ext4_iomap_begin()
that extend files depend on IOMAP_F_DIRTY.

When doing a direct IO that spans the current EOF, and there are
written blocks beyond EOF that extend beyond the current write, the
only metadata update that needs to be done is a file size extension.

However, we don't mark such iomaps as IOMAP_F_DIRTY to indicate that
there is IO completion metadata updates required, and hence we may
fail to correctly sync file size extensions made in IO completion when
O_DSYNC writes are being used and the hardware supports FUA.

Hence when setting IOMAP_F_DIRTY, we need to also take into account
whether the iomap spans the current EOF. If it does, then we need to
mark it dirty so that IO completion will call generic_write_sync() to
flush the inode size update to stable storage correctly.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0a9ea291cfab..da2ca81e3d9c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3523,8 +3523,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			return ret;
 	}
 
+	/*
+	 * Writes that span EOF might trigger an I/O size update on completion,
+	 * so consider them to be dirty for the purposes of O_DSYNC, even if
+	 * there is no other metadata changes being made or are pending here.
+	 */
 	iomap->flags = 0;
-	if (ext4_inode_datasync_dirty(inode))
+	if (ext4_inode_datasync_dirty(inode) ||
+	    offset + length > i_size_read(inode))
 		iomap->flags |= IOMAP_F_DIRTY;
 	iomap->bdev = inode->i_sb->s_bdev;
 	iomap->dax_dev = sbi->s_daxdev;
-- 
2.20.1

