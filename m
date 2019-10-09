Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B38D19B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 22:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfJIUlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 16:41:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:46526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730955AbfJIUlc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:41:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 759F7AF6B;
        Wed,  9 Oct 2019 20:41:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1CB231E422A; Wed,  9 Oct 2019 22:41:30 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, darrick.wong@oracle.com,
        <linux-xfs@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] iomap: Waiting for IO in iomap_dio_rw()
Date:   Wed,  9 Oct 2019 22:41:24 +0200
Message-Id: <20191009202736.19227-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

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

What do people think?

								Honza 
