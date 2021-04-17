Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421C4362CB1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 03:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhDQBbD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 21:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDQBbC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 21:31:02 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7D9C061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 18:30:37 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXZmw-005uUl-NV; Sat, 17 Apr 2021 01:30:22 +0000
Date:   Sat, 17 Apr 2021 01:30:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Xie Yongji <xieyongji@bytedance.com>, hch@infradead.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, hridya@google.com, surenb@google.com,
        sargun@sargun.me, keescook@chromium.org, jasowang@redhat.com,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] binder: Use receive_fd() to receive file from
 another process
Message-ID: <YHo6Ln9VI1T7RmLK@zeniv-ca.linux.org.uk>
References: <YGWYZYbBzglUCxB2@kroah.com>
 <20210401104034.52qaaoea27htkpbh@wittgenstein>
 <YHkedhnn1wdVFTV3@zeniv-ca.linux.org.uk>
 <YHkmxCyJ8yekgGKl@zeniv-ca.linux.org.uk>
 <20210416134252.v3zfjp36tpk33tqz@wittgenstein>
 <YHmanzAMdeCtZUjy@zeniv-ca.linux.org.uk>
 <20210416151310.nqkxfwocm32lnqfq@wittgenstein>
 <YHmu3/Cw4bUnTSH9@zeniv-ca.linux.org.uk>
 <20210416155815.ayjpnx37dv3a4jos@wittgenstein>
 <YHnJwRvUhaK3IM0l@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHnJwRvUhaK3IM0l@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 05:30:41PM +0000, Al Viro wrote:
> On Fri, Apr 16, 2021 at 05:58:15PM +0200, Christian Brauner wrote:
> 
> > They could probably refactor this but I'm not sure why they'd bother. If
> > they fail processing any of those files they end up aborting the
> > whole transaction.
> > (And the original code didn't check the error code btw.)
> 
> Wait a sec...  What does aborting the transaction do to descriptor table?
> <rereads>
> Oh, lovely...
> 
> binder_apply_fd_fixups() is deeply misguided.  What it should do is
> 	* go through t->fd_fixups, reserving descriptor numbers and
> putting them into t->buffer (and I'd probably duplicate them into
> struct binder_txn_fd_fixup).  Cleanup in case of failure: go through
> the list, releasing the descriptors we'd already reserved, doing
> fput() on fixup->file in all entries and freeing the entries as
> we go.
> 	* On success, go through the list, doing fd_install() and
> freeing the entries.

Something like this:

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c119736ca56a..b0c5f7e625f3 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2195,6 +2195,7 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
 	fixup->offset = fd_offset;
 	trace_binder_transaction_fd_send(t, fd, fixup->offset);
 	list_add_tail(&fixup->fixup_entry, &t->fd_fixups);
+	fixup->target_fd = -1;
 
 	return ret;
 
@@ -3707,25 +3708,10 @@ static int binder_wait_for_work(struct binder_thread *thread,
 	return ret;
 }
 
-/**
- * binder_apply_fd_fixups() - finish fd translation
- * @proc:         binder_proc associated @t->buffer
- * @t:	binder transaction with list of fd fixups
- *
- * Now that we are in the context of the transaction target
- * process, we can allocate and install fds. Process the
- * list of fds to translate and fixup the buffer with the
- * new fds.
- *
- * If we fail to allocate an fd, then free the resources by
- * fput'ing files that have not been processed and ksys_close'ing
- * any fds that have already been allocated.
- */
-static int binder_apply_fd_fixups(struct binder_proc *proc,
+static int binder_reserve_fds(struct binder_proc *proc,
 				  struct binder_transaction *t)
 {
-	struct binder_txn_fd_fixup *fixup, *tmp;
-	int ret = 0;
+	struct binder_txn_fd_fixup *fixup;
 
 	list_for_each_entry(fixup, &t->fd_fixups, fixup_entry) {
 		int fd = get_unused_fd_flags(O_CLOEXEC);
@@ -3734,42 +3720,55 @@ static int binder_apply_fd_fixups(struct binder_proc *proc,
 			binder_debug(BINDER_DEBUG_TRANSACTION,
 				     "failed fd fixup txn %d fd %d\n",
 				     t->debug_id, fd);
-			ret = -ENOMEM;
-			break;
+			return -ENOMEM;
 		}
 		binder_debug(BINDER_DEBUG_TRANSACTION,
 			     "fd fixup txn %d fd %d\n",
 			     t->debug_id, fd);
 		trace_binder_transaction_fd_recv(t, fd, fixup->offset);
-		fd_install(fd, fixup->file);
-		fixup->file = NULL;
+		fixup->target_fd = fd;
 		if (binder_alloc_copy_to_buffer(&proc->alloc, t->buffer,
 						fixup->offset, &fd,
-						sizeof(u32))) {
-			ret = -EINVAL;
-			break;
-		}
+						sizeof(u32)))
+			return -EINVAL;
 	}
-	list_for_each_entry_safe(fixup, tmp, &t->fd_fixups, fixup_entry) {
-		if (fixup->file) {
-			fput(fixup->file);
-		} else if (ret) {
-			u32 fd;
-			int err;
-
-			err = binder_alloc_copy_from_buffer(&proc->alloc, &fd,
-							    t->buffer,
-							    fixup->offset,
-							    sizeof(fd));
-			WARN_ON(err);
-			if (!err)
-				binder_deferred_fd_close(fd);
+	return 0;
+}
+
+/**
+ * binder_apply_fd_fixups() - finish fd translation
+ * @proc:         binder_proc associated @t->buffer
+ * @t:	binder transaction with list of fd fixups
+ *
+ * Now that we are in the context of the transaction target
+ * process, we can allocate fds. Process the list of fds to
+ * translate and fixup the buffer with the new fds.
+ *
+ * If we fail to allocate an fd, then free the resources by
+ * releasing fds we'd allocated.  Otherwise transfer all files
+ * from fixups to the descriptors we'd allocated for them.
+ *
+ * In either case, finish with freeing the fixups.
+ */
+static int binder_apply_fd_fixups(struct binder_proc *proc,
+				  struct binder_transaction *t)
+{
+	struct binder_txn_fd_fixup *fixup;
+	int err = binder_reserve_fds(proc, t);
+
+	if (unlikely(err)) {
+		list_for_each_entry(fixup, &t->fd_fixups, fixup_entry) {
+			if (fixup->target_fd >= 0)
+				put_unused_fd(fixup->target_fd);
+		}
+	} else {
+		list_for_each_entry(fixup, &t->fd_fixups, fixup_entry) {
+			fd_install(fixup->target_fd, fixup->file);
+			fixup->file = NULL;
 		}
-		list_del(&fixup->fixup_entry);
-		kfree(fixup);
 	}
-
-	return ret;
+	binder_free_txn_fixups(t);
+	return err;
 }
 
 static int binder_thread_read(struct binder_proc *proc,
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 6cd79011e35d..16ffc5f748ce 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -497,6 +497,7 @@ struct binder_txn_fd_fixup {
 	struct list_head fixup_entry;
 	struct file *file;
 	size_t offset;
+	int target_fd;
 };
 
 struct binder_transaction {
