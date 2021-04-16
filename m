Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C90362147
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 15:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhDPNnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 09:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233995AbhDPNnZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:43:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64BE361152;
        Fri, 16 Apr 2021 13:42:56 +0000 (UTC)
Date:   Fri, 16 Apr 2021 15:42:52 +0200
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
Message-ID: <20210416134252.v3zfjp36tpk33tqz@wittgenstein>
References: <20210401090932.121-1-xieyongji@bytedance.com>
 <20210401090932.121-3-xieyongji@bytedance.com>
 <YGWYZYbBzglUCxB2@kroah.com>
 <20210401104034.52qaaoea27htkpbh@wittgenstein>
 <YHkedhnn1wdVFTV3@zeniv-ca.linux.org.uk>
 <YHkmxCyJ8yekgGKl@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHkmxCyJ8yekgGKl@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 05:55:16AM +0000, Al Viro wrote:
> On Fri, Apr 16, 2021 at 05:19:50AM +0000, Al Viro wrote:
> > On Thu, Apr 01, 2021 at 12:40:34PM +0200, Christian Brauner wrote:
> 
> > > and see whether all of them can be switched to simply using
> > > receive_fd(). I did a completely untested rough sketch to illustrate
> > > what I meant by using binder and devpts Xie seems to have just picked
> > > those two. But the change is obviously only worth it if all or nearly
> > > all callers can be switched over without risk of regression.
> > > It would most likely simplify quite a few codepaths though especially in
> > > the error paths since we can get rid of put_unused_fd() cleanup.
> > > 
> > > But it requires buy in from others obviously.
> > 
> > Opening a file can have non-trivial side effects; reserving a descriptor
> > can't.  Moreover, if you look at the second hit in your list, you'll see
> > that we do *NOT* want that combined thing there - fd_install() is
> > completely irreversible, so we can't do that until we made sure the
> > reply (struct vtpm_proxy_new_dev) has been successfully copied to
> > userland.  No, your receive_fd_user() does not cover that.
> > 
> > There's a bunch of other cases like that - the next ones on your list
> > are drivers/dma-buf/sw_sync.c and drivers/dma-buf/sync_file.c, etc.
> 
> FWIW, pretty much all ioctls that return descriptor as part of a structure
> stored to user-supplied address tend to be that way; some don't have any
> other output fields (in which case they probably would've been better off
> with just passing the descriptor as return value of ioctl(2)).  Those
> might be served by that receive_fd_user() helper; anything that has several
> outputs won't be.  The same goes for anything that has hard-to-undo
> operations as part of what they need to do:
> 	reserve fd
> 	set file up
> 	do hard-to-undo stuff
> 	install into descriptor table
> is the only feasible order of operations - reservation can fail, so
> it must go before the hard-to-undo part and install into descriptor
> table can't be undone at all, so it must come last.  Looks like
> e.g. drivers/virt/nitro_enclaves/ne_misc_dev.c case might be of
> that sort...

If receive_fd() or your receive_fd_user() proposal can replace a chunk
of open-coded places in modules where the split between reserving the
file descriptor and installing it is pointless it's probably already
worth it. Random example from io_uring where the file is already opened
way before (which yes, isn't a module afaik but another place where we
have that pattern):

static int io_uring_install_fd(struct io_ring_ctx *ctx, struct file *file)
{
	int ret, fd;

	fd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
	if (fd < 0)
		return fd;

	ret = io_uring_add_task_file(ctx);
	if (ret) {
		put_unused_fd(fd);
		return ret;
	}
	fd_install(fd, file);
	return fd;
}

A practical question also is whether the security receive hook thing
actually belongs into the receive_fd() and receive_fd_user() helpers for
the general case or whether that's just something that very few callers
would want. But in any case I'm unlikely to have time on my hands to
play with sm like this any time soon.

Christian
