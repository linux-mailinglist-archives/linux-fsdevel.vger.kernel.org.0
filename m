Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50CEDD5D61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 10:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbfJNI0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 04:26:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:60208 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730381AbfJNI0N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:26:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CD0EB4FC;
        Mon, 14 Oct 2019 08:26:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B006F1E4A86; Mon, 14 Oct 2019 10:26:10 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, darrick.wong@oracle.com,
        <linux-xfs@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2 v3] iomap: Waiting for IO in iomap_dio_rw()
Date:   Mon, 14 Oct 2019 10:26:01 +0200
Message-Id: <20191014082418.13885-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

here is new version of the series with the small change requested by Darrick.

Changes since v2:
* Changed iomap_dio_rw() to return -EIO in case caller doesn't ask it to wait
  for sync kiocb.

Changes since v1:
* The new function argument of iomap_dio_rw() does not get overridden by
 is_sync_kiocb() the caller is responsible for this.

---
Original motivation:

when doing the ext4 conversion of direct IO code to iomap, we found it very
difficult to handle inode extension with what iomap code currently provides.
Ext4 wants to do inode extension as sync IO (so that the whole duration of
IO is protected by inode->i_rwsem), also we need to truncate blocks beyond
end of file in case of error or short write. Now in ->end_io handler we don't
have the information how long originally the write was (to judge whether we
may have allocated more blocks than we actually used) and in ->write_iter
we don't know whether / how much of the IO actually succeeded in case of AIO.

Thinking about it for some time I think iomap code makes it unnecessarily
complex for the filesystem in case it decides it doesn't want to perform AIO
and wants to fall back to good old synchronous IO. In such case it is much
easier for the filesystem if it just gets normal error return from
iomap_dio_rw() and not just -EIOCBQUEUED.

The first patch in the series adds argument to iomap_dio_rw() to wait for IO
completion (internally iomap_dio_rw() already supports this!) and the second
patch converts XFS waiting for unaligned DIO write to this new API.

								Honza 

Previous versions:
Link: http://lore.kernel.org/r/20191009202736.19227-1-jack@suse.cz
Link: http://lore.kernel.org/r/20191011125520.11697-1-jack@suse.cz
