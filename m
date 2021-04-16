Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D623536239C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 17:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343554AbhDPPQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 11:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245295AbhDPPN7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:13:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6142E61026;
        Fri, 16 Apr 2021 15:13:13 +0000 (UTC)
Date:   Fri, 16 Apr 2021 17:13:10 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Xie Yongji <xieyongji@bytedance.com>, hch@infradead.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, hridya@google.com, surenb@google.com,
        sargun@sargun.me, keescook@chromium.org, jasowang@redhat.com,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] binder: Use receive_fd() to receive file from
 another process
Message-ID: <20210416151310.nqkxfwocm32lnqfq@wittgenstein>
References: <20210401090932.121-1-xieyongji@bytedance.com>
 <20210401090932.121-3-xieyongji@bytedance.com>
 <YGWYZYbBzglUCxB2@kroah.com>
 <20210401104034.52qaaoea27htkpbh@wittgenstein>
 <YHkedhnn1wdVFTV3@zeniv-ca.linux.org.uk>
 <YHkmxCyJ8yekgGKl@zeniv-ca.linux.org.uk>
 <20210416134252.v3zfjp36tpk33tqz@wittgenstein>
 <YHmanzAMdeCtZUjy@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHmanzAMdeCtZUjy@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 02:09:35PM +0000, Al Viro wrote:
> On Fri, Apr 16, 2021 at 03:42:52PM +0200, Christian Brauner wrote:
> > > > are drivers/dma-buf/sw_sync.c and drivers/dma-buf/sync_file.c, etc.
> > > 
> > > FWIW, pretty much all ioctls that return descriptor as part of a structure
> > > stored to user-supplied address tend to be that way; some don't have any
> > > other output fields (in which case they probably would've been better off
> > > with just passing the descriptor as return value of ioctl(2)).  Those
> > > might be served by that receive_fd_user() helper; anything that has several
> > > outputs won't be.  The same goes for anything that has hard-to-undo
> > > operations as part of what they need to do:
> > > 	reserve fd
> > > 	set file up
> > > 	do hard-to-undo stuff
> > > 	install into descriptor table
> > > is the only feasible order of operations - reservation can fail, so
> > > it must go before the hard-to-undo part and install into descriptor
> > > table can't be undone at all, so it must come last.  Looks like
> > > e.g. drivers/virt/nitro_enclaves/ne_misc_dev.c case might be of
> > > that sort...
> > 
> > If receive_fd() or your receive_fd_user() proposal can replace a chunk
> 
> My what proposal?  The thing is currently in linux/file.h, put there
> by Kees half a year ago...

Yeah, I know. I was just referring to that line:

> > > might be served by that receive_fd_user() helper; anything that has several

I wasn't trying to imply you were the author or instigator of the api.

> 
> > of open-coded places in modules where the split between reserving the
> > file descriptor and installing it is pointless it's probably already
> > worth it.
> 
> A helper for use in some of the simplest cases, with big fat warnings
> not to touch if the things are not entirely trivial - sure, why not,
> same as we have anon_inode_getfd().  But that's a convenience helper,
> not a general purpose primitive.
> 
> > Random example from io_uring where the file is already opened
> > way before (which yes, isn't a module afaik but another place where we
> > have that pattern):
> > 
> > static int io_uring_install_fd(struct io_ring_ctx *ctx, struct file *file)
> > {
> > 	int ret, fd;
> > 
> > 	fd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
> > 	if (fd < 0)
> > 		return fd;
> > 
> > 	ret = io_uring_add_task_file(ctx);
> 
> Huh?  It's
>         ret = io_uring_add_task_file(ctx, file);
> in the mainline and I don't see how that sucker could work without having
> file passed to it.

My point here was more that the _file_ has already been opened _before_
that call to io_uring_add_task_file(). But any potential non-trivial
side-effects of opening that file that you correctly pointed out in an
earlier mail has already happened by that time. Granted there are more
obvious examples, e.g. the binder stuff.

		int fd = get_unused_fd_flags(O_CLOEXEC);

		if (fd < 0) {
			binder_debug(BINDER_DEBUG_TRANSACTION,
				     "failed fd fixup txn %d fd %d\n",
				     t->debug_id, fd);
			ret = -ENOMEM;
			break;
		}
		binder_debug(BINDER_DEBUG_TRANSACTION,
			     "fd fixup txn %d fd %d\n",
			     t->debug_id, fd);
		trace_binder_transaction_fd_recv(t, fd, fixup->offset);
		fd_install(fd, fixup->file);
		fixup->file = NULL;
		if (binder_alloc_copy_to_buffer(&proc->alloc, t->buffer,
						fixup->offset, &fd,
						sizeof(u32))) {
			ret = -EINVAL;
			break;
		}
