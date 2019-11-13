Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1C9DFB6F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 19:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfKMSAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 13:00:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:43264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbfKMSAf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:00:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0135DADE4;
        Wed, 13 Nov 2019 18:00:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 731841E1498; Wed, 13 Nov 2019 19:00:32 +0100 (CET)
Date:   Wed, 13 Nov 2019 19:00:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>
Subject: Splice & iomap dio problems
Message-ID: <20191113180032.GB12013@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I've spent today tracking down the syzkaller report of a WARN_ON hit in
iov_iter_pipe() [1]. The immediate problem is that syzkaller reproducer
(calling sendfile(2) from different threads at the same time a file to the
same file in rather evil way) results in splice code leaking pipe pages
(nrbufs doesn't return to 0 after read+write in the splice) and eventually
we run out of pipe pages and hit the warning in iov_iter_pipe(). The
problem is not specific to ext4, I can see in my tracing that when the
underlying filesystem is XFS, we can leak the pipe pages in the same way
(but for XFS somehow the problem doesn't happen as often).  Rather the
problem seems to be in how iomap direct IO code, pipe iter code, and splice
code interact.

So the problematic situation is when we do direct IO read into pipe pages
and the read hits EOF which is not on page boundary. Say the file has 4608
(4096+512) bytes, block size == page size == 4096. What happens is that iomap
code maps the extent, gets that the extent size is 8192 (mapping ignores
i_size). Then we call iomap_dio_bio_actor(), which creates its private
iter, truncates it to 8192, and calls bio_iov_iter_get_pages(). That
eventually results in preparing two pipe buffers with length 4096 to accept
the read. Then read completes, in iomap_dio_complete() we truncate the return
value from 8192 (which was the real amount of IO we performed) to 4608. Now
this amount (4608) gets passed through splice code to
iter_file_splice_write(), we write out that amount, but then when cleaning
up pipe buffers, the last pipe buffer has still 3584 unused so we leave
the pipe buffer allocated and effectively leak it.

Now I was also investigating why the old direct IO code doesn't leak pipe
buffers like this and the trick is done by the iov_iter_revert() call
generic_file_read_iter(). This results in setting iter position right to
the position where direct IO read reported it ended (4608) and truncating
pipe buffers after this point. So splice code then sees the second pipe
buffer has length only 512 which matches the amount it was asked to write
and so the pipe buffer gets freed after the write in
iter_file_splice_write().

The question is how to best fix this. The quick fix is to add
iov_iter_revert() call to iomap_dio_rw() so that in case of sync IO (we
always do only sync IO to pipes), we properly set iter position in case of
short read / write. But it looks somewhat hacky to me and this whole
interaction of iter and pipes looks fragile to me.

Another option I can see is to truncate the iter to min(i_size-pos, length) in
iomap_dio_bio_actor() which *should* do the trick AFAICT. But I'm not sure
if it won't break something else.

Any other ideas?

As a side note the logic copying iter in iomap_dio_bio_actor() looks
suspicious. We copy 'dio->submit.iter' to 'iter' but then in the loop we call
iov_iter_advance() on dio->submit.iter. So if bio_iov_iter_get_pages()
didn't return enough pages and we loop again, 'iter' will have stale
contents and things go sideways from there? What am I missing? And why do
we do that strange copying of iter instead of using iov_iter_truncate() and
iov_iter_reexpand() on the 'dio->submit.iter' directly?

								Honza

[1] https://lore.kernel.org/lkml/000000000000d60aa50596c63063@google.com

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
