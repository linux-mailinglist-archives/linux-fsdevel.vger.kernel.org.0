Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B26724E56E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 06:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgHVEfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 00:35:25 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63061 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgHVEfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:35:25 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 07M4Yrhk074116;
        Sat, 22 Aug 2020 13:34:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Sat, 22 Aug 2020 13:34:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 07M4Yq9E074110
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 22 Aug 2020 13:34:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [RFC PATCH] pipe: make pipe_release() deferrable.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+96cc7aba7e969b1d305c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <00000000000045b3fe05abcced2f@google.com>
 <fc097a54-0384-9d21-323f-c3ca52cdb956@I-love.SAKURA.ne.jp>
 <CAHk-=wj15SDiHjP2wPiC=Ru-RrUjOuT4AoULj6N_9pVvSXaWiw@mail.gmail.com>
 <20200807053148.GA10409@redhat.com>
 <e673cccb-1b67-802a-84e3-6aeea4513a09@i-love.sakura.ne.jp>
 <20200810192941.GA16925@redhat.com>
 <d1e83b55-eb09-45e0-95f1-ece41251b036@i-love.sakura.ne.jp>
 <dc9b2681-3b84-eb74-8c88-3815beaff7f8@i-love.sakura.ne.jp>
Message-ID: <7ba35ca4-13c1-caa3-0655-50d328304462@i-love.sakura.ne.jp>
Date:   Sat, 22 Aug 2020 13:34:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <dc9b2681-3b84-eb74-8c88-3815beaff7f8@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot is reporting hung task at pipe_write() [1], for __pipe_lock() from
pipe_write() by task-A can be blocked forever waiting for
handle_userfault() from copy_page_from_iter() from pipe_write() by task-B
to complete and call __pipe_unlock().

Since the problem is that we can't enforce task-B to immediately complete
handle_userfault() (this is effectively returning to userspace with locks
held), we won't be able to avoid this hung task report unless we convert
all pipe locks to killable (because khungtaskd does not warn stalling
killable waits).

Linus Torvalds commented that we could introduce timeout for
handle_userfault(), and Andrea Arcangeli responded that too short timeout
can cause problems (e.g. breaking qemu's live migration) [2], and we can't
guarantee that khungtaskd's timeout is longer than timeout for
multiple handle_userfault() events.

Since Andrea commented that we will be able to avoid this hung task report
if we convert pipe locks to killable, I tried a feasibility test [3].
While it is not difficult to make some of pipe locks killable, there
are subtle or complicated locations (e.g. pipe_wait() users).

syzbot already reported that even pipe_release() is subjected to this hung
task report [4]. While the cause of [4] is that splice() from pipe to file
hit an infinite busy loop bug after holding pipe lock, it is a sign that
we have to care about __pipe_lock() in pipe_release() even if pipe_read()
or pipe_write() is stalling due to page fault handling.

Therefore, this patch tries to convert __pipe_lock() in pipe_release() to
killable, by deferring to a workqueue context when __pipe_lock_killable()
failed.

(a) Do you think that we can make all pipe locks killable?
(b) Do you think that we can introduce timeout for handling page faults?
(c) Do you think that we can avoid page faults with pipe locks held?

[1] https://syzkaller.appspot.com/bug?id=ab3d277fa3b068651edb7171a1aa4f78e5eacf78
[2] https://lkml.kernel.org/r/CAHk-=wj15SDiHjP2wPiC=Ru-RrUjOuT4AoULj6N_9pVvSXaWiw@mail.gmail.com
[3] https://lkml.kernel.org/r/dc9b2681-3b84-eb74-8c88-3815beaff7f8@i-love.sakura.ne.jp
[4] https://syzkaller.appspot.com/bug?id=2ccac875e85dc852911a0b5b788ada82dc0a081e

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/pipe.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 60dbee457143..a64c7fc1794f 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -87,6 +87,11 @@ static inline void __pipe_lock(struct pipe_inode_info *pipe)
 	mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
 }
 
+static inline int __pipe_lock_killable(struct pipe_inode_info *pipe)
+{
+	return mutex_lock_killable_nested(&pipe->mutex, I_MUTEX_PARENT);
+}
+
 static inline void __pipe_unlock(struct pipe_inode_info *pipe)
 {
 	mutex_unlock(&pipe->mutex);
@@ -714,15 +719,12 @@ static void put_pipe_info(struct inode *inode, struct pipe_inode_info *pipe)
 		free_pipe_info(pipe);
 }
 
-static int
-pipe_release(struct inode *inode, struct file *file)
+/* Caller holds pipe->mutex. */
+static void do_pipe_release(struct inode *inode, struct pipe_inode_info *pipe, fmode_t f_mode)
 {
-	struct pipe_inode_info *pipe = file->private_data;
-
-	__pipe_lock(pipe);
-	if (file->f_mode & FMODE_READ)
+	if (f_mode & FMODE_READ)
 		pipe->readers--;
-	if (file->f_mode & FMODE_WRITE)
+	if (f_mode & FMODE_WRITE)
 		pipe->writers--;
 
 	/* Was that the last reader or writer, but not the other side? */
@@ -732,9 +734,48 @@ pipe_release(struct inode *inode, struct file *file)
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 	}
+}
+
+struct pipe_release_data {
+	struct work_struct work;
+	struct inode *inode;
+	struct pipe_inode_info *pipe;
+	fmode_t f_mode;
+};
+
+static void deferred_pipe_release(struct work_struct *work)
+{
+	struct pipe_release_data *w = container_of(work, struct pipe_release_data, work);
+	struct inode *inode = w->inode;
+	struct pipe_inode_info *pipe = w->pipe;
+
+	__pipe_lock(pipe);
+	do_pipe_release(inode, pipe, w->f_mode);
 	__pipe_unlock(pipe);
 
 	put_pipe_info(inode, pipe);
+	iput(inode); /* pipe_release() called ihold(inode). */
+	kfree(w);
+}
+
+static int pipe_release(struct inode *inode, struct file *file)
+{
+	struct pipe_inode_info *pipe = file->private_data;
+	struct pipe_release_data *w;
+
+	if (likely(__pipe_lock_killable(pipe) == 0)) {
+		do_pipe_release(inode, pipe, file->f_mode);
+		__pipe_unlock(pipe);
+		put_pipe_info(inode, pipe);
+		return 0;
+	}
+	w = kmalloc(sizeof(*w), GFP_KERNEL | __GFP_NOFAIL);
+	ihold(inode); /* deferred_pipe_release() will call iput(inode). */
+	w->inode = inode;
+	w->pipe = pipe;
+	w->f_mode = file->f_mode;
+	INIT_WORK(&w->work, deferred_pipe_release);
+	queue_work(system_wq, &w->work);
 	return 0;
 }
 
-- 
2.18.4


