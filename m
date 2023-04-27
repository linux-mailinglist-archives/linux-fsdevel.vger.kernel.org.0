Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4001F6F01F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 09:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243027AbjD0HjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 03:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242942AbjD0HjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:39:13 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F13010CE;
        Thu, 27 Apr 2023 00:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GdU5FoKu7yLnuisAr9WoCgOQAJmwwb/1wW92ruUjEhM=; b=hyqqSIpiYHg7CzOeMm3Fp8GFeI
        9KKep0l7So3ftxaId13cGGf8z44uSE/5WsUjs/VNAHeFw73Ox3McanB4Qu4l6b/+PZJ8O33z11iZN
        pvwlIHE2SB71X3GmwZKuhjKOw+76GhDOjWDAEOpWsENZejZwmQq1zYJGxoD1sdypq3dsG2cslDK64
        g8ZyVyyVGIuhm3o9+Omxnt3nRqW3yaAndYsU539T5nC7f2L85PUwzzkjr4fO5ZGvJDRXIeoS41PFn
        yOS8iqn6Lrz211uQ/aa6GWgsif+V38qh7jPR080v2MNHNExjm6QOs9doS7uUQX0wTMZTHDw3QrBhN
        5o107RyQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1prwDc-00D5sK-2h;
        Thu, 27 Apr 2023 07:39:08 +0000
Date:   Thu, 27 Apr 2023 08:39:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pidfd updates
Message-ID: <20230427073908.GA3390869@ZenIV>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV>
 <20230425-sturheit-jungautor-97d92d7861e2@brauner>
 <20230427010715.GX3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427010715.GX3390869@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 27, 2023 at 02:07:15AM +0100, Al Viro wrote:
> On Tue, Apr 25, 2023 at 02:34:15PM +0200, Christian Brauner wrote:
> 
> 
> > struct fd_file {
> > 	struct file *file;
> > 	int fd;
> > 	int __user *fd_user;
> 
> Why is it an int?  Because your case has it that way?
> 
> We have a bunch of places where we have an ioctl with
> a field in some structure filled that way; any primitive
> that combines put_user() with descriptor handling is
> going to cause trouble as soon as somebody deals with
> a structure where such member is unsigned long.  Gets
> especially funny on 64bit big-endian...
> 
> And that objection is orthogonal to that 3-member structure -
> even if you pass int __user * as an explicit argument into
> your helper, the same trouble will be there.
> 
> Al, still going through that zoo...

FWIW, surprisingly large part of messy users in ioctls might get
simplified nicely if we add something along the lines of

int delayed_dup(struct file *file, unsigned flags)
{
	struct delayed_dup *p = kmalloc(sizeof(struct delayed_dup), GFP_KERNEL);
	int fd;

	if (likely(p))
		fd = p->fd = get_unused_fd_flags(flags);
	else
		fd = -ENOMEM;
	if (likely(fd >= 0)) {
		p->file = file;
		init_task_work(&p->work, __do_delayed_dup);
		if (!task_work_add(&p, TWA_RESUME))
			return fd;
		put_unused_fd(fd);
		fd = -EINVAL;
	}
	fput(file);
	kfree(p);
	return fd;
}

with

struct delayed_dup {
	struct callback_head work;
	struct file *file;
	unsigned fd;
};

static void __do_delayed_dup(struct callback_head *work)
{
	struct delayed_dup *p = container_of(work, struct delayed_dup, work);

	if (!syscall_get_error(current, current_pt_regs())) {
		fd_install(p->fd, p->file);
	} else {
		put_unused_fd(p->fd);
		fput(p->file);
	}
	kfree(p);
}

Random example (completely untested - I'm not even sure it compiles):

diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index af57799c86ce..7c62becfddc9 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -207,55 +207,34 @@ static __poll_t sync_file_poll(struct file *file, poll_table *wait)
 static long sync_file_ioctl_merge(struct sync_file *sync_file,
 				  unsigned long arg)
 {
-	int fd = get_unused_fd_flags(O_CLOEXEC);
 	int err;
 	struct sync_file *fence2, *fence3;
+	struct sync_merge_data __user *argp = (void *)arg;
 	struct sync_merge_data data;
 
-	if (fd < 0)
-		return fd;
-
-	if (copy_from_user(&data, (void __user *)arg, sizeof(data))) {
-		err = -EFAULT;
-		goto err_put_fd;
-	}
+	if (copy_from_user(&data, argp, sizeof(data)))
+		return -EFAULT;
 
-	if (data.flags || data.pad) {
-		err = -EINVAL;
-		goto err_put_fd;
-	}
+	if (data.flags || data.pad)
+		return -EINVAL;
 
 	fence2 = sync_file_fdget(data.fd2);
-	if (!fence2) {
-		err = -ENOENT;
-		goto err_put_fd;
-	}
+	if (!fence2)
+		return -ENOENT;
 
 	data.name[sizeof(data.name) - 1] = '\0';
 	fence3 = sync_file_merge(data.name, sync_file, fence2);
-	if (!fence3) {
+	if (fence3)
+		err = delayed_dup(fence3->file, O_CLOEXEC);
+	else
 		err = -ENOMEM;
-		goto err_put_fence2;
-	}
 
-	data.fence = fd;
-	if (copy_to_user((void __user *)arg, &data, sizeof(data))) {
-		err = -EFAULT;
-		goto err_put_fence3;
+	if (err >= 0) {
+		data.fence = err;
+		err = copy_to_user(argp, &data, sizeof(data)) ? -EFAULT : 0;
 	}
 
-	fd_install(fd, fence3->file);
-	fput(fence2->file);
-	return 0;
-
-err_put_fence3:
-	fput(fence3->file);
-
-err_put_fence2:
 	fput(fence2->file);
-
-err_put_fd:
-	put_unused_fd(fd);
 	return err;
 }
 

IMO it's much easier to follow that way, and that's a fairly typical
example.  One primitive call instead of three, *much* simpler handling
of failure exits, no need to deal with unroll on copy_to_user() failures
(here those were handled; most of the drivers/gpu/drm stuff is buried
quite a few call levels deeper than the place where copyout is done,
so currently it doesn't even try to DTRT in that respect).

It's not a panacea - for that to be useful we need
	* no side effects of file opening that wouldn't be undone by fput()
	* enough work done to make the overhead negligible
	* moderate amount of files opened in one call
	* a pattern that could be massaged into "open file, then deal with
inserting it into descriptor table".

There's a plenty of fd_install() users that match that pattern.
Certainly not all of them, but almost everything in drivers does.

I'm still digging through the rest - there's a couple of other patterns
that seem to be common, but I'm not through the entire pile yet.
