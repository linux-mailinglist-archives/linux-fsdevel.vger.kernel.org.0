Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0B374A4B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 22:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjGFUPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 16:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjGFUPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:15:18 -0400
Received: from out-33.mta0.migadu.com (out-33.mta0.migadu.com [IPv6:2001:41d0:1004:224b::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481491BFF
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 13:15:17 -0700 (PDT)
Date:   Thu, 6 Jul 2023 16:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688674514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xg4a3bKTtPaDruKIY+OrNPd5TyNn8inVhCSohpZyrtg=;
        b=tvOEyJ5uncEH0GYVNP2UIVx+eSBBbVrlfcxAJsSTaxcX62Kj1lH72b0QePxu5OUOYI49qC
        Z/4UmDO95izQaJdJhuHlCMfmPXivu2tEq81CYTJes61DollcTv1FOJQRcAWz/25wXEgBJZ
        n29M9QDUI/mWek3/u3i16kJNGu8blME=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230706201510.sh5ukzfsf5vdxvrf@moria.home.lan>
References: <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <4b863e62-4406-53e4-f96a-f4d1daf098ab@kernel.dk>
 <20230628175204.oeek4nnqx7ltlqmg@moria.home.lan>
 <e1570c46-68da-22b7-5322-f34f3c2958d9@kernel.dk>
 <2e635579-37ba-ddfc-a2ab-e6c080ab4971@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e635579-37ba-ddfc-a2ab-e6c080ab4971@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 03:17:43PM -0600, Jens Axboe wrote:
> On 6/28/23 2:44?PM, Jens Axboe wrote:
> > On 6/28/23 11:52?AM, Kent Overstreet wrote:
> >> On Wed, Jun 28, 2023 at 10:57:02AM -0600, Jens Axboe wrote:
> >>> I discussed this with Christian offline. I have a patch that is pretty
> >>> simple, but it does mean that you'd wait for delayed fput flush off
> >>> umount. Which seems kind of iffy.
> >>>
> >>> I think we need to back up a bit and consider if the kill && umount
> >>> really is sane. If you kill a task that has open files, then any fput
> >>> from that task will end up being delayed. This means that the umount may
> >>> very well fail.
> >>>
> >>> It'd be handy if we could have umount wait for that to finish, but I'm
> >>> not at all confident this is a sane solution for all cases. And as
> >>> discussed, we have no way to even identify which files we'd need to
> >>> flush out of the delayed list.
> >>>
> >>> Maybe the test case just needs fixing? Christian suggested lazy/detach
> >>> umount and wait for sb release. There's an fsnotify hook for that,
> >>> fsnotify_sb_delete(). Obviously this is a bit more involved, but seems
> >>> to me that this would be the way to make it more reliable when killing
> >>> of tasks with open files are involved.
> >>
> >> No, this is a real breakage. Any time we introduce unexpected
> >> asynchrony there's the potential for breakage: case in point, there was
> >> a filesystem that made rm asynchronous, then there were scripts out
> >> there that deleted until df showed under some threshold.. whoops...
> > 
> > This is nothing new - any fput done from an exiting task will end up
> > being deferred. The window may be a bit wider now or a bit different,
> > but it's the same window. If an application assumes it can kill && wait
> > on a task and be guaranteed that the files are released as soon as wait
> > returns, it is mistaken. That is NOT the case.
> 
> Case in point, just changed my reproducer to use aio instead of
> io_uring. Here's the full script:
> 
> #!/bin/bash
> 
> DEV=/dev/nvme1n1
> MNT=/data
> ITER=0
> 
> while true; do
> 	echo loop $ITER
> 	sudo mount $DEV $MNT
> 	fio --name=test --ioengine=aio --iodepth=2 --filename=$MNT/foo --size=1g --buffered=1 --overwrite=0 --numjobs=12 --minimal --rw=randread --output=/dev/null &
> 	Y=$(($RANDOM % 3))
> 	X=$(($RANDOM % 10))
> 	VAL="$Y.$X"
> 	sleep $VAL
> 	ps -e | grep fio > /dev/null 2>&1
> 	while [ $? -eq 0 ]; do
> 		killall -9 fio > /dev/null 2>&1
> 		echo will wait
> 		wait > /dev/null 2>&1
> 		echo done waiting
> 		ps -e | grep "fio " > /dev/null 2>&1
> 	done
> 	sudo umount /data
> 	if [ $? -ne 0 ]; then
> 		break
> 	fi
> 	((ITER++))
> done
> 
> and if I run that, fails on the first umount attempt in that loop:
> 
> axboe@m1max-kvm ~> bash test2.sh
> loop 0
> will wait
> done waiting
> umount: /data: target is busy.

Your test fails because fio by default spawns off multiple processes,
and just calling wait does not wait for the subprocesses.

When I pass --thread to fio, your test passes.

I have a patch to avoid use of the delayed_fput list in the aio path,
but curiously it seems not to be needed - perhaps there's some other
synchronization I haven't found yet. I'm including the patch below in
case the technique is useful for io_uring:

diff --git a/fs/aio.c b/fs/aio.c
index b3e14a9fe3..00cb953efa 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -211,6 +211,7 @@ struct aio_kiocb {
 						 * for cancellation */
 	refcount_t		ki_refcnt;
 
+	struct task_struct	*ki_task;
 	/*
 	 * If the aio_resfd field of the userspace iocb is not zero,
 	 * this is the underlying eventfd context to deliver events to.
@@ -321,7 +322,7 @@ static void put_aio_ring_file(struct kioctx *ctx)
 		ctx->aio_ring_file = NULL;
 		spin_unlock(&i_mapping->private_lock);
 
-		fput(aio_ring_file);
+		__fput_sync(aio_ring_file);
 	}
 }
 
@@ -1068,6 +1069,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 	INIT_LIST_HEAD(&req->ki_list);
 	refcount_set(&req->ki_refcnt, 2);
 	req->ki_eventfd = NULL;
+	req->ki_task = get_task_struct(current);
 	return req;
 }
 
@@ -1104,8 +1106,9 @@ static inline void iocb_destroy(struct aio_kiocb *iocb)
 	if (iocb->ki_eventfd)
 		eventfd_ctx_put(iocb->ki_eventfd);
 	if (iocb->ki_filp)
-		fput(iocb->ki_filp);
+		fput_for_task(iocb->ki_filp, iocb->ki_task);
 	percpu_ref_put(&iocb->ki_ctx->reqs);
+	put_task_struct(iocb->ki_task);
 	kmem_cache_free(kiocb_cachep, iocb);
 }
 
diff --git a/fs/file_table.c b/fs/file_table.c
index 372653b926..137f87f55e 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -367,12 +367,13 @@ EXPORT_SYMBOL_GPL(flush_delayed_fput);
 
 static DECLARE_DELAYED_WORK(delayed_fput_work, delayed_fput);
 
-void fput(struct file *file)
+void fput_for_task(struct file *file, struct task_struct *task)
 {
 	if (atomic_long_dec_and_test(&file->f_count)) {
-		struct task_struct *task = current;
+		if (!task && likely(!in_interrupt() && !(current->flags & PF_KTHREAD)))
+			task = current;
 
-		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
+		if (task) {
 			init_task_work(&file->f_rcuhead, ____fput);
 			if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))
 				return;
@@ -388,6 +389,11 @@ void fput(struct file *file)
 	}
 }
 
+void fput(struct file *file)
+{
+	fput_for_task(file, NULL);
+}
+
 /*
  * synchronous analog of fput(); for kernel threads that might be needed
  * in some umount() (and thus can't use flush_delayed_fput() without
@@ -405,6 +411,7 @@ void __fput_sync(struct file *file)
 	}
 }
 
+EXPORT_SYMBOL(fput_for_task);
 EXPORT_SYMBOL(fput);
 EXPORT_SYMBOL(__fput_sync);
 
diff --git a/include/linux/file.h b/include/linux/file.h
index 39704eae83..667a68f477 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -12,7 +12,9 @@
 #include <linux/errno.h>
 
 struct file;
+struct task_struct;
 
+extern void fput_for_task(struct file *, struct task_struct *);
 extern void fput(struct file *);
 
 struct file_operations;
