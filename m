Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4E83AE133
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 02:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhFUAsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Jun 2021 20:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhFUAsr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Jun 2021 20:48:47 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D04C061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Jun 2021 17:46:33 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lv858-00AcjT-1a; Mon, 21 Jun 2021 00:46:30 +0000
Date:   Mon, 21 Jun 2021 00:46:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YM/hZgxPM+2cP+I7@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	dde0c2e79848 "fs: add IOCB_SYNC and IOCB_DSYNC" had
done this
+       if ((file->f_flags & O_DSYNC) || IS_SYNC(file->f_mapping->host))
+               res |= IOCB_DSYNC;

in iocb_flags().  The first half is not a problem.  However,
if you look at the second one, you'll see fetches from
file->f_mapping->host->i_flags and, worse yet,
file->f_mapping->host->i_sb->s_flags.  Now, ->f_mapping might
be within the cacheline we'd already fetched from.  However,
->f_mapping->host and ->f_mapping->host->i_flags are in
different cachelines (i_data.host and i_flags in some struct inode
instance).  ->host->i_sb is in the same cacheline as ->host->i_flags,
but ->host->i_sb->s_flags is certain to bring yet another cacheline
into the picture.

IOW, it's not going to be cheap, no matter what we do.  Moreover,
that thing used to live in generic_write_sync() and used only by
the ->write_iter() instances that knew they would care about it.
Now it's used by all ->write_iter() and ->read_iter() callers.

How about the following:
	* new flag: IOCB_DSYNC_KNOWN
	* in iocb_flags(), O_DSYNC => IOCB_SYNC_KNOWN | IOCB_DSYNC
	* ditto for places explicitly setting IOCB_DSYNC
	* places checking IOCB_DSYNC use
static inline bool iocb_is_dsync(struct kiocb *iocb)
{
	if (likely(iocb->ki_flags & IOCB_DSYNC_KNOWN))
		return iocb->ki_flags & IOCB_DSYNC;
	if (unlikely(IS_SYNC(iocb->ki_filp->f_mapping->host))
		iocb->ki_flags |= IOCB_DSYNC_KNOWN | IOCB_DSYNC;
		return true;
	}
	iocb->ki_flags |= IOCB_DSYNC_KNOWN;
	return false;
}
instead
	That way init_sync_kiocb() becomes much lighter, especially
if we cache its value in struct file - there are very few places where
it can change.  Comments?
