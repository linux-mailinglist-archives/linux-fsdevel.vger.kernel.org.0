Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A43D3621D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 16:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbhDPOKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 10:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbhDPOKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:10:44 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C31C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 07:10:19 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXPA7-005m1v-Sf; Fri, 16 Apr 2021 14:09:35 +0000
Date:   Fri, 16 Apr 2021 14:09:35 +0000
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
Message-ID: <YHmanzAMdeCtZUjy@zeniv-ca.linux.org.uk>
References: <20210401090932.121-1-xieyongji@bytedance.com>
 <20210401090932.121-3-xieyongji@bytedance.com>
 <YGWYZYbBzglUCxB2@kroah.com>
 <20210401104034.52qaaoea27htkpbh@wittgenstein>
 <YHkedhnn1wdVFTV3@zeniv-ca.linux.org.uk>
 <YHkmxCyJ8yekgGKl@zeniv-ca.linux.org.uk>
 <20210416134252.v3zfjp36tpk33tqz@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416134252.v3zfjp36tpk33tqz@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 03:42:52PM +0200, Christian Brauner wrote:
> > > are drivers/dma-buf/sw_sync.c and drivers/dma-buf/sync_file.c, etc.
> > 
> > FWIW, pretty much all ioctls that return descriptor as part of a structure
> > stored to user-supplied address tend to be that way; some don't have any
> > other output fields (in which case they probably would've been better off
> > with just passing the descriptor as return value of ioctl(2)).  Those
> > might be served by that receive_fd_user() helper; anything that has several
> > outputs won't be.  The same goes for anything that has hard-to-undo
> > operations as part of what they need to do:
> > 	reserve fd
> > 	set file up
> > 	do hard-to-undo stuff
> > 	install into descriptor table
> > is the only feasible order of operations - reservation can fail, so
> > it must go before the hard-to-undo part and install into descriptor
> > table can't be undone at all, so it must come last.  Looks like
> > e.g. drivers/virt/nitro_enclaves/ne_misc_dev.c case might be of
> > that sort...
> 
> If receive_fd() or your receive_fd_user() proposal can replace a chunk

My what proposal?  The thing is currently in linux/file.h, put there
by Kees half a year ago...

> of open-coded places in modules where the split between reserving the
> file descriptor and installing it is pointless it's probably already
> worth it.

A helper for use in some of the simplest cases, with big fat warnings
not to touch if the things are not entirely trivial - sure, why not,
same as we have anon_inode_getfd().  But that's a convenience helper,
not a general purpose primitive.

> Random example from io_uring where the file is already opened
> way before (which yes, isn't a module afaik but another place where we
> have that pattern):
> 
> static int io_uring_install_fd(struct io_ring_ctx *ctx, struct file *file)
> {
> 	int ret, fd;
> 
> 	fd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
> 	if (fd < 0)
> 		return fd;
> 
> 	ret = io_uring_add_task_file(ctx);

Huh?  It's
        ret = io_uring_add_task_file(ctx, file);
in the mainline and I don't see how that sucker could work without having
file passed to it.

> 	if (ret) {
> 		put_unused_fd(fd);
> 		return ret;
> 	}
> 	fd_install(fd, file);
> 	return fd;
> }

... and that's precisely the situation where we have something that is
not obvious how to undo; look into io_uring_add_task_file()...

We have three things to do: (1) reserve a descriptor, (2) io_uring_add_task_file(),
(3) install the file.  (1) and (2) may fail, (1) is trivial to undo, (2) might be
not, (3) is impossible to undo.  So I'd say that in this particular case
io_uring is being perfectly reasonable...
