Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4157751962
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 09:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjGMHKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 03:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjGMHKI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:10:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF8D119;
        Thu, 13 Jul 2023 00:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A44861A32;
        Thu, 13 Jul 2023 07:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AB0C433C7;
        Thu, 13 Jul 2023 07:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689232205;
        bh=RdIQiT2khPXP/ZV8I8C1KhIFPpD6kEkdeGs7E9vow6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AlkISGn4AVDhzQEbV/iMmIX1OWP82xTmrRzfje2dEKwnbm7RGHbUCcNtl0f08mPZk
         bjBPNITTikVDboOkAnaOL6/Dauvun9Of6D+48ECFH6q32PVJeXjrj9EVBn2HeF+/Nw
         KUEvKwpMAnTIi0zY0hXUXY4SwTv5IFIwb//8J/sy3ki0cRlxaAu6b7xZWJjuZjbzj7
         SSLHLCSlFH1Jbz6XFHbKLUTDIhVKf3anDoNNr8COuKaXzt6oboQyiNq6b7p+tYJXO9
         xIWU52KB8NsKZV5AZfjU5RVgky/xPz5xTzivSUEPkwQ0winHzRZGUHQBeelSIGmmcq
         UtZGnp74bvs5w==
Date:   Thu, 13 Jul 2023 09:10:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Hao Xu <hao.xu@linux.dev>
Cc:     io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>
Subject: Re: [PATCH 3/3] io_uring: add support for getdents
Message-ID: <20230713-sitzt-zudem-67bc5d860cb4@brauner>
References: <20230711114027.59945-1-hao.xu@linux.dev>
 <20230711114027.59945-4-hao.xu@linux.dev>
 <20230712-alltag-abberufen-67a615152bee@brauner>
 <bb2aa872-c3fb-93f0-c0da-3a897f39347d@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb2aa872-c3fb-93f0-c0da-3a897f39347d@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 12:35:07PM +0800, Hao Xu wrote:
> On 7/12/23 23:27, Christian Brauner wrote:
> > On Tue, Jul 11, 2023 at 07:40:27PM +0800, Hao Xu wrote:
> > > From: Hao Xu <howeyxu@tencent.com>
> > > 
> > > This add support for getdents64 to io_uring, acting exactly like the
> > > syscall: the directory is iterated from it's current's position as
> > > stored in the file struct, and the file's position is updated exactly as
> > > if getdents64 had been called.
> > > 
> > > For filesystems that support NOWAIT in iterate_shared(), try to use it
> > > first; if a user already knows the filesystem they use do not support
> > > nowait they can force async through IOSQE_ASYNC in the sqe flags,
> > > avoiding the need to bounce back through a useless EAGAIN return.
> > > 
> > > Co-developed-by: Dominique Martinet <asmadeus@codewreck.org>
> > > Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> > > Signed-off-by: Hao Xu <howeyxu@tencent.com>
> > > ---
> > >   include/uapi/linux/io_uring.h |  7 ++++
> > >   io_uring/fs.c                 | 60 +++++++++++++++++++++++++++++++++++
> > >   io_uring/fs.h                 |  3 ++
> > >   io_uring/opdef.c              |  8 +++++
> > >   4 files changed, 78 insertions(+)
> > > 
> > > diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> > > index 08720c7bd92f..6c0d521135a6 100644
> > > --- a/include/uapi/linux/io_uring.h
> > > +++ b/include/uapi/linux/io_uring.h
> > > @@ -65,6 +65,7 @@ struct io_uring_sqe {
> > >   		__u32		xattr_flags;
> > >   		__u32		msg_ring_flags;
> > >   		__u32		uring_cmd_flags;
> > > +		__u32		getdents_flags;
> > >   	};
> > >   	__u64	user_data;	/* data to be passed back at completion time */
> > >   	/* pack this to avoid bogus arm OABI complaints */
> > > @@ -235,6 +236,7 @@ enum io_uring_op {
> > >   	IORING_OP_URING_CMD,
> > >   	IORING_OP_SEND_ZC,
> > >   	IORING_OP_SENDMSG_ZC,
> > > +	IORING_OP_GETDENTS,
> > >   	/* this goes last, obviously */
> > >   	IORING_OP_LAST,
> > > @@ -273,6 +275,11 @@ enum io_uring_op {
> > >    */
> > >   #define SPLICE_F_FD_IN_FIXED	(1U << 31) /* the last bit of __u32 */
> > > +/*
> > > + * sqe->getdents_flags
> > > + */
> > > +#define IORING_GETDENTS_REWIND	(1U << 0)
> > > +
> > >   /*
> > >    * POLL_ADD flags. Note that since sqe->poll_events is the flag space, the
> > >    * command flags for POLL_ADD are stored in sqe->len.
> > > diff --git a/io_uring/fs.c b/io_uring/fs.c
> > > index f6a69a549fd4..77f00577e09c 100644
> > > --- a/io_uring/fs.c
> > > +++ b/io_uring/fs.c
> > > @@ -47,6 +47,13 @@ struct io_link {
> > >   	int				flags;
> > >   };
> > > +struct io_getdents {
> > > +	struct file			*file;
> > > +	struct linux_dirent64 __user	*dirent;
> > > +	unsigned int			count;
> > > +	int				flags;
> > > +};
> > > +
> > >   int io_renameat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> > >   {
> > >   	struct io_rename *ren = io_kiocb_to_cmd(req, struct io_rename);
> > > @@ -291,3 +298,56 @@ void io_link_cleanup(struct io_kiocb *req)
> > >   	putname(sl->oldpath);
> > >   	putname(sl->newpath);
> > >   }
> > > +
> > > +int io_getdents_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> > > +{
> > > +	struct io_getdents *gd = io_kiocb_to_cmd(req, struct io_getdents);
> > > +
> > > +	if (READ_ONCE(sqe->off) != 0)
> > > +		return -EINVAL;
> > > +
> > > +	gd->dirent = u64_to_user_ptr(READ_ONCE(sqe->addr));
> > > +	gd->count = READ_ONCE(sqe->len);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int io_getdents(struct io_kiocb *req, unsigned int issue_flags)
> > > +{
> > > +	struct io_getdents *gd = io_kiocb_to_cmd(req, struct io_getdents);
> > > +	struct file *file;
> > > +	unsigned long getdents_flags = 0;
> > > +	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
> > > +	bool should_lock = false;
> > > +	int ret;
> > > +
> > > +	if (force_nonblock) {
> > > +		if (!(req->file->f_mode & FMODE_NOWAIT))
> > > +			return -EAGAIN;
> > > +
> > > +		getdents_flags = DIR_CONTEXT_F_NOWAIT;
> > 
> > I mentioned this on the other patch but it seems really pointless to
> > have that extra flag. I would really like to hear a good reason for
> > this.
> > 
> > > +	}
> > > +
> > > +	file = req->file;
> > > +	if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
> > > +		if (file_count(file) > 1)
> > 
> > Assume we have a regular non-threaded process that just opens an fd to a
> > file. The process registers an async readdir request via that fd for the
> > file with io_uring and goes to do other stuff while waiting for the
> > result.
> > 
> > Some time later, io_uring gets to io_getdents() and the task is still
> > single threaded and the file hasn't been shared in the meantime. So
> > io_getdents() doesn't take the lock and starts the readdir() call.
> > 
> > Concurrently, the process that registered the io_uring request was free
> > to do other stuff and issued a synchronous readdir() system call which
> > calls fdget_pos(). Since the fdtable still isn't shared it doesn't
> > increment f_count and doesn't acquire the mutex. Now there's another
> > concurrent readdir() going on.
> > 
> > (Similar thing can happen if the process creates a thread for example.)
> > 
> > Two readdir() requests now proceed concurrently which is not intended.
> > Now to verify that this race can't happen with io_uring:
> > 
> > * regular fds:
> >    It seems that io_uring calls fget() on each regular file descriptor
> >    when an async request is registered. So that means that io_uring
> >    always hold its own explicit reference here.
> >    So as long as the original task is alive or another thread is alive
> >    f_count is guaranteed to be > 1 and so the mutex would always be
> >    acquired.
> > 
> >    If the registering process dies right before io_uring gets to the
> >    io_getdents() request no other process can steal the fd anymore and in
> >    that case the readdir call would not lock. But that's fine.
> > 
> > * fixed fds:
> >    I don't know the reference counting rules here. io_uring would need to
> >    ensure that it's impossible for two async readdir requests via a fixed
> >    fd to race because f_count is == 1.
> > 
> >    Iiuc, if a process registers a file it opened as a fixed file and
> >    immediately closes the fd afterwards - without anyone else holding a
> >    reference to that file - and only uses the fixed fd going forward, the
> >    f_count of that file in io_uring's fixed file table is always 1.
> > 
> >    So one could issue any number of concurrent readdir requests with no
> >    mutual exclusion. So for fixed files there definitely is a race, no?
> 
> Hi Christian,
> The ref logic for fixed file is that it does fdget() when registering

It absolutely can't be the case that io_uring uses fdget()/fdput() for
long-term file references. fdget() internally use __fget_light() which
avoids taking a reference on the file if the file table isn't shared. So
should that file be stashed anywhere for async work its a UAF waiting to
happen.

> the file, and fdput() when unregistering it. So the ref in between is
> always > 1. The fixed file feature is to reduce frequent fdget/fdput,
> but it does call them at the register/unregister time.

So consider:

// Caller opens some file.
fd_register = open("/some/file", ...); // f_count == 1

// Caller registers that file as a fixed file
IORING_REGISTER_FILES
-> io_sqe_files_register()
   -> fget(fd_register) // f_count == 2
   -> io_fixed_file_set()

// Caller trades regular fd reference for fixed file reference completely.
close(fd_register);
-> close_fd(fd_register)
   -> file = pick_file()
   -> filp_close(file)
      -> fput(file)    // f_count == 1


// Caller spawns a second thread. Both treads issue async getdents via
// fixed file.
T1                                              T2
IORING_OP_GETDENTS                              IORING_OP_GETDENTS

// At some point io_assign_file() must be called which has:

          if (req->flags & REQ_F_FIXED_FILE)
                  req->file = io_file_get_fixed(req, req->cqe.fd, issue_flags);
          else
                  req->file = io_file_get_normal(req, req->cqe.fd);

// Since this is REQ_F_FIXED_FILE f_count == 1

if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
        if (file_count(file) > 1)

// No lock is taken; T1 and T2 issue getdents concurrently without any
// locking. -> race on f_pos

I'm happy to be convinced that this is safe, but please someone explain
in detail why this can't happen and where that extra f_count reference
for fixed files that this code wants to rely on is coming from.

Afaik, the whole point is that fixed files don't ever call fget()/fput()
after having been registered anymore. Consequently, f_count should be 1
once io_uring has taken full ownership of the file and the file can only
be addressed via a fixed file reference.

> 
> 
> > 
> > All of that could ofc be simplified if we could just always acquire the
> > mutex in fdget_pos() and other places and drop that file_count(file) > 1
> > optimization everywhere. But I have no idea if the optimization for not
> > acquiring the mutex if f_count == 1 is worth it?
> > 
> > I hope I didn't confuse myself here.
> > 
> > Jens, do yo have any input here?
> > 
> > > +			should_lock = true;
> > > +	}
> > > +	if (should_lock) {
> > > +		if (!force_nonblock)
> > > +			mutex_lock(&file->f_pos_lock);
> > > +		else if (!mutex_trylock(&file->f_pos_lock))
> > > +			return -EAGAIN;
> > > +	}
> > 
> > Open-coding this seems extremely brittle with an invitation for subtle
> > bugs.
> 
> Could you elaborate on this, I'm not sure that I understand it quite
> well. Sorry for my poor English.

No need to apologize. I'm wondering whether this should be moved into a
tiny helper and actually be exposed via a vfs header if we go this
route is all.
