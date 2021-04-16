Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E692F362510
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbhDPQBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 12:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239252AbhDPQBM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:01:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4241A6113D;
        Fri, 16 Apr 2021 16:00:42 +0000 (UTC)
Date:   Fri, 16 Apr 2021 18:00:38 +0200
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
Message-ID: <20210416160038.ojbhqf73dkrl4dk6@wittgenstein>
References: <20210401090932.121-3-xieyongji@bytedance.com>
 <YGWYZYbBzglUCxB2@kroah.com>
 <20210401104034.52qaaoea27htkpbh@wittgenstein>
 <YHkedhnn1wdVFTV3@zeniv-ca.linux.org.uk>
 <YHkmxCyJ8yekgGKl@zeniv-ca.linux.org.uk>
 <20210416134252.v3zfjp36tpk33tqz@wittgenstein>
 <YHmanzAMdeCtZUjy@zeniv-ca.linux.org.uk>
 <20210416151310.nqkxfwocm32lnqfq@wittgenstein>
 <YHmu3/Cw4bUnTSH9@zeniv-ca.linux.org.uk>
 <20210416155815.ayjpnx37dv3a4jos@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210416155815.ayjpnx37dv3a4jos@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 05:58:25PM +0200, Christian Brauner wrote:
> On Fri, Apr 16, 2021 at 03:35:59PM +0000, Al Viro wrote:
> > On Fri, Apr 16, 2021 at 05:13:10PM +0200, Christian Brauner wrote:
> > 
> > > My point here was more that the _file_ has already been opened _before_
> > > that call to io_uring_add_task_file(). But any potential non-trivial
> > > side-effects of opening that file that you correctly pointed out in an
> > > earlier mail has already happened by that time.
> > 
> > The file comes from io_uring_get_file(), the entire thing is within the
> > io_ring_ctx constructor and the only side effect there is ->ring_sock
> > creation.  And that stays until the io_ring_ctx is freed.  I'm _not_
> > saying I like io_uring style in general, BTW - in particular,
> > ->ring_sock->file handling is a kludge (as is too much of interation
> > with AF_UNIX machinery there).  But from side effects POV we are fine
> > there.
> > 
> > > Granted there are more
> > > obvious examples, e.g. the binder stuff.
> > > 
> > > 		int fd = get_unused_fd_flags(O_CLOEXEC);
> > > 
> > > 		if (fd < 0) {
> > > 			binder_debug(BINDER_DEBUG_TRANSACTION,
> > > 				     "failed fd fixup txn %d fd %d\n",
> > > 				     t->debug_id, fd);
> > > 			ret = -ENOMEM;
> > > 			break;
> > > 		}
> > > 		binder_debug(BINDER_DEBUG_TRANSACTION,
> > > 			     "fd fixup txn %d fd %d\n",
> > > 			     t->debug_id, fd);
> > > 		trace_binder_transaction_fd_recv(t, fd, fixup->offset);
> > > 		fd_install(fd, fixup->file);
> > > 		fixup->file = NULL;
> > > 		if (binder_alloc_copy_to_buffer(&proc->alloc, t->buffer,
> > > 						fixup->offset, &fd,
> > > 						sizeof(u32))) {
> > > 			ret = -EINVAL;
> > > 			break;
> > > 		}
> > 
> > ... and it's actually broken, since this
> >         /* All copies must be 32-bit aligned and 32-bit size */
> > 	if (!check_buffer(alloc, buffer, buffer_offset, bytes))
> > 		return -EINVAL;
> > in binder_alloc_copy_to_buffer() should've been done *before*
> > fd_install().  If anything, it's an example of the situation when
> > fd_receive() would be wrong...
> 
> They could probably refactor this but I'm not sure why they'd bother. If
> they fail processing any of those files they end up aborting the
> whole transaction.
> (And the original code didn't check the error code btw.)

(dma_buf_fd() seems like another good candidate. But again, I don't have
any plans to shove this down anyone's throat.)
