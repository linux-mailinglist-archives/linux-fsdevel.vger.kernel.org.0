Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631402568DD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 17:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgH2Pze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 11:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgH2Pz3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 11:55:29 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DDFC061236;
        Sat, 29 Aug 2020 08:55:29 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kC3CG-0074dV-TG; Sat, 29 Aug 2020 15:55:16 +0000
Date:   Sat, 29 Aug 2020 16:55:16 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+c92c93d1f1aaaacdb9db@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, oleg@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at fs/inode.c:LINE! (2)
Message-ID: <20200829155516.GO1236603@ZenIV.linux.org.uk>
References: <000000000000c8fcd905adefe24b@google.com>
 <20200828153825.GI1236603@ZenIV.linux.org.uk>
 <20200828175413.GL1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828175413.GL1236603@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 28, 2020 at 06:54:13PM +0100, Al Viro wrote:
> On Fri, Aug 28, 2020 at 04:38:25PM +0100, Al Viro wrote:
> > On Fri, Aug 28, 2020 at 06:18:17AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    d012a719 Linux 5.9-rc2
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=15aa650e900000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
> > > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ecb939900000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140a19a9900000
> > 
> > Trying to reproduce...
> 
> OK, I think I see what's going on.  ep_loop_check_proc() runs into an already
> doomed file that has already committed to getting killed (->f_count is already
> at 0), but still hadn't gotten through its epitems removal (e.g. has its
> eventpoll_release_file() sitting there trying to get epmutex).
> 
> Blindly bumping refcount here is worse than useless.  Try this, to verify that
> this is what's going on; it's _not_ a proper fix, but it should at least tell
> if we have something else going on.

... and what I think is the right way to fix the original race is (on top of
mainline) this:

[PATCH] Use list_empty_careful() in eventpoll_release()

... to avoid races with list_del_init() in clear_tfile_check_list().
Get rid of pinning files on check list in eventpoll.c - it's not needed
there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index e0decff22ae2..39eae45bff18 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1995,7 +1995,6 @@ static int ep_loop_check_proc(void *priv, void *cookie, int call_nests)
 			 * during ep_insert().
 			 */
 			if (list_empty(&epi->ffd.file->f_tfile_llink)) {
-				get_file(epi->ffd.file);
 				list_add(&epi->ffd.file->f_tfile_llink,
 					 &tfile_check_list);
 			}
@@ -2042,7 +2041,6 @@ static void clear_tfile_check_list(void)
 		file = list_first_entry(&tfile_check_list, struct file,
 					f_tfile_llink);
 		list_del_init(&file->f_tfile_llink);
-		fput(file);
 	}
 	INIT_LIST_HEAD(&tfile_check_list);
 }
@@ -2206,7 +2204,6 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 				if (ep_loop_check(ep, tf.file) != 0)
 					goto error_tgt_fput;
 			} else {
-				get_file(tf.file);
 				list_add(&tf.file->f_tfile_llink,
 							&tfile_check_list);
 			}
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 8f000fada5a4..e2bdefd90cf8 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -46,11 +46,9 @@ static inline void eventpoll_release(struct file *file)
 	 * Fast check to avoid the get/release of the semaphore. Since
 	 * we're doing this outside the semaphore lock, it might return
 	 * false negatives, but we don't care. It'll help in 99.99% of cases
-	 * to avoid the semaphore lock. False positives simply cannot happen
-	 * because the file in on the way to be removed and nobody ( but
-	 * eventpoll ) has still a reference to this file.
+	 * to avoid the semaphore lock.
 	 */
-	if (likely(list_empty(&file->f_ep_links)))
+	if (likely(list_empty_careful(&file->f_ep_links)))
 		return;
 
 	/*
