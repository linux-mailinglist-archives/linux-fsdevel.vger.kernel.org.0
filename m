Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E39110296D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 17:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfKSQcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 11:32:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:58046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727299AbfKSQcS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:32:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88061C132;
        Tue, 19 Nov 2019 16:32:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C062F1E3C3C; Tue, 19 Nov 2019 17:32:14 +0100 (CET)
Date:   Tue, 19 Nov 2019 17:32:14 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>
Subject: Re: Splice & iomap dio problems
Message-ID: <20191119163214.GC2440@quack2.suse.cz>
References: <20191113180032.GB12013@quack2.suse.cz>
 <20191113184403.GM6235@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113184403.GM6235@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-11-19 10:44:03, Darrick J. Wong wrote:
> On Wed, Nov 13, 2019 at 07:00:32PM +0100, Jan Kara wrote:
> > Hello,
> > 
> > I've spent today tracking down the syzkaller report of a WARN_ON hit in
> > iov_iter_pipe() [1]. The immediate problem is that syzkaller reproducer
> > (calling sendfile(2) from different threads at the same time a file to the
> > same file in rather evil way) results in splice code leaking pipe pages
> > (nrbufs doesn't return to 0 after read+write in the splice) and eventually
> > we run out of pipe pages and hit the warning in iov_iter_pipe(). The
> > problem is not specific to ext4, I can see in my tracing that when the
> > underlying filesystem is XFS, we can leak the pipe pages in the same way
> > (but for XFS somehow the problem doesn't happen as often).  Rather the
> > problem seems to be in how iomap direct IO code, pipe iter code, and splice
> > code interact.
> > 
> > So the problematic situation is when we do direct IO read into pipe pages
> > and the read hits EOF which is not on page boundary. Say the file has 4608
> > (4096+512) bytes, block size == page size == 4096. What happens is that iomap
> > code maps the extent, gets that the extent size is 8192 (mapping ignores
> 
> I wonder, would this work properly if the read side returns a 4608-byte
> mapping instead of an 8192-byte mapping?  It doesn't make a lot of sense
> (to me, anyway) for a read mapping to go beyond EOF.

The slight concern I have with this is that that would change e.g. the
behavior of IOMAP_REPORT. We could specialcase IOMAP_REPORT but then it
gets kind of ugly. And it seems kind of fuzzy when do we truncate the
extent with i_size and when not... Generally i_size is kind of a side-band
thing for block mapping operations so if we could leave it out of
->iomap_begin I'd find that nicer.

> > i_size). Then we call iomap_dio_bio_actor(), which creates its private
> > iter, truncates it to 8192, and calls bio_iov_iter_get_pages(). That
> > eventually results in preparing two pipe buffers with length 4096 to accept
> > the read. Then read completes, in iomap_dio_complete() we truncate the return
> > value from 8192 (which was the real amount of IO we performed) to 4608. Now
> > this amount (4608) gets passed through splice code to
> > iter_file_splice_write(), we write out that amount, but then when cleaning
> > up pipe buffers, the last pipe buffer has still 3584 unused so we leave
> > the pipe buffer allocated and effectively leak it.
> > 
> > Now I was also investigating why the old direct IO code doesn't leak pipe
> > buffers like this and the trick is done by the iov_iter_revert() call
> > generic_file_read_iter(). This results in setting iter position right to
> > the position where direct IO read reported it ended (4608) and truncating
> > pipe buffers after this point. So splice code then sees the second pipe
> > buffer has length only 512 which matches the amount it was asked to write
> > and so the pipe buffer gets freed after the write in
> > iter_file_splice_write().
> > 
> > The question is how to best fix this. The quick fix is to add
> > iov_iter_revert() call to iomap_dio_rw() so that in case of sync IO (we
> > always do only sync IO to pipes), we properly set iter position in case of
> > short read / write. But it looks somewhat hacky to me and this whole
> > interaction of iter and pipes looks fragile to me.
> > 
> > Another option I can see is to truncate the iter to min(i_size-pos, length) in
> > iomap_dio_bio_actor() which *should* do the trick AFAICT. But I'm not sure
> > if it won't break something else.
> 
> Do the truncation in ->iomap_begin on the read side, as I suggested above?

Yes, that would be equivalent for this case.

> > Any other ideas?
> > 
> > As a side note the logic copying iter in iomap_dio_bio_actor() looks
> > suspicious. We copy 'dio->submit.iter' to 'iter' but then in the loop we call
> > iov_iter_advance() on dio->submit.iter. So if bio_iov_iter_get_pages()
> > didn't return enough pages and we loop again, 'iter' will have stale
> > contents and things go sideways from there? What am I missing? And why do
> > we do that strange copying of iter instead of using iov_iter_truncate() and
> > iov_iter_reexpand() on the 'dio->submit.iter' directly?
> 
> I'm similarly puzzled; I would've thought that we'd need to advance the
> private @iter too.  Or just truncate and reexpand the dio->submit.iter
> and not have the private one.
> 
> With any luck hch will have some ideas? :/

Christoph seems to be busy with something else. So I'll just write patches,
run them through fstests and see if something blows up.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
