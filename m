Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0044112030E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 11:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfLPK6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 05:58:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:35672 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727403AbfLPK6L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:58:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC33AACA7;
        Mon, 16 Dec 2019 10:58:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 803C11E0B2E; Mon, 16 Dec 2019 11:58:07 +0100 (CET)
Date:   Mon, 16 Dec 2019 11:58:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     syzbot <syzbot+bea68382bae9490e7dd6@syzkaller.appspotmail.com>,
        darrick.wong@oracle.com, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-ext4@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: KASAN: use-after-free Read in iov_iter_alignment
Message-ID: <20191216105807.GB23120@quack2.suse.cz>
References: <000000000000ad9f910598bbb867@google.com>
 <20191202211037.GF2695@dread.disaster.area>
 <20191216104836.GA23120@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20191216104836.GA23120@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 16-12-19 11:48:36, Jan Kara wrote:
> On Tue 03-12-19 08:10:37, Dave Chinner wrote:
> > [cc linux-ext4@vger.kernel.org - this is reported from the new ext4
> > dio->iomap code]
> > 
> > On Mon, Dec 02, 2019 at 09:15:08AM -0800, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following crash on:
> > > 
> > > HEAD commit:    b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=135a8d7ae00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e464ae414aee8c
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=bea68382bae9490e7dd6
> > > compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> > > 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1135cb36e00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e90abce00000
> > > 
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+bea68382bae9490e7dd6@syzkaller.appspotmail.com
> > > 
...

> > Looks like buffered read IO on a loopback device on an ext4 image
> > file, and something is being tripped over in the new ext4 direct IO
> > path.  Might be an iomap issue, might be an ext4 issue, but it looks
> > like the buffered read bio completion is running while the iov is
> > still being submitted...
> 
> Looking a bit more into this, I'm pretty sure this is caused by commit
> 8cefc107ca54c "pipe: Use head and tail pointers for the ring, not cursor
> and length". The pipe dereference it has added to iov_iter_alignment() is
> just bogus for all iter types except for pipes. I'll send a fix.

For reference the fix I've sent is attached.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--y0ulUmNC+osPPQO6
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-pipe-Fix-bogus-dereference-in-iov_iter_alignment.patch"

From bc27e20fdd29b97b45015e1443128b4d3ff9455e Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 16 Dec 2019 11:44:14 +0100
Subject: [PATCH] pipe: Fix bogus dereference in iov_iter_alignment()

We cannot look at 'i->pipe' unless we know the iter is a pipe. Move the
ring_size load to a branch in iov_iter_alignment() where we've already
checked the iter is a pipe to avoid bogus dereference.

Reported-by: syzbot+bea68382bae9490e7dd6@syzkaller.appspotmail.com
Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not cursor and length")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/iov_iter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

 Al, David, not sure who's going to merge this so sending to both :).

								Honza

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index fb29c02c6a3c..51595bf3af85 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1222,11 +1222,12 @@ EXPORT_SYMBOL(iov_iter_discard);
 
 unsigned long iov_iter_alignment(const struct iov_iter *i)
 {
-	unsigned int p_mask = i->pipe->ring_size - 1;
 	unsigned long res = 0;
 	size_t size = i->count;
 
 	if (unlikely(iov_iter_is_pipe(i))) {
+		unsigned int p_mask = i->pipe->ring_size - 1;
+
 		if (size && i->iov_offset && allocated(&i->pipe->bufs[i->head & p_mask]))
 			return size | i->iov_offset;
 		return size;
-- 
2.16.4


--y0ulUmNC+osPPQO6--
