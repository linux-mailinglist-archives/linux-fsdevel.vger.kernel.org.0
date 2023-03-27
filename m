Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05FE6C9ECD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 11:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjC0JDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 05:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjC0JDE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:03:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483DB7A89;
        Mon, 27 Mar 2023 02:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA80061147;
        Mon, 27 Mar 2023 09:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950AAC433D2;
        Mon, 27 Mar 2023 09:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679907671;
        bh=ulak5wtyiQ4tNHvUePs8KMYfCLZkRQN1k1n818e0xfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHgELZK5b3dPPohgvz4/Ntoi0Hr0Kr1wg97opwEiGqA1m/ITRmWBpGzvZMxcRQ/SO
         BZQg2aaBVc/eoUkbtPAsYHrX7hG5qbG/eGYOK4SwWJ8K27PgRJOjDtnmX631tSTLpl
         KoFafui0vN3xZBSsDRLL5qksRXPOTGk46gRhD5RRB1pqmxx+CTzTCDAoKVMZXRQnG/
         brh17kxidevKbNBBNx/9ECm3Y4Z/w/b8l76NH6Y4valaWK+8fRE/WSxqNZbcxRia69
         Drjj7XHr8VsrwUsUp/mgtzg8cce0AqhhB5ThSnssgBoz35BI3s8uQfsIAorj39SNOW
         34Lx271kejJ/Q==
Date:   Mon, 27 Mar 2023 11:01:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     aloktiagi <aloktiagi@gmail.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org, David.Laight@aculab.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, hch@infradead.org
Subject: Re: [RFC v4 2/2] file, epoll: Implement do_replace() and
 eventpoll_replace()
Message-ID: <20230327090106.zylztuk77vble7ye@wittgenstein>
References: <20230324063422.1031181-2-aloktiagi@gmail.com>
 <ZBzRfDnHaEycE72s@ip-172-31-38-16.us-west-2.compute.internal>
 <20230324082344.xgze2vu3ds2kubcz@wittgenstein>
 <ZB2o8cs+VTQlz5GA@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZB2o8cs+VTQlz5GA@tycho.pizza>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 07:43:13AM -0600, Tycho Andersen wrote:
> On Fri, Mar 24, 2023 at 09:23:44AM +0100, Christian Brauner wrote:
> > On Thu, Mar 23, 2023 at 10:23:56PM +0000, Alok Tiagi wrote:
> > > On Mon, Mar 20, 2023 at 03:51:03PM +0100, Christian Brauner wrote:
> > > > On Sat, Mar 18, 2023 at 06:02:48AM +0000, aloktiagi wrote:
> > > > > Introduce a mechanism to replace a file linked in the epoll interface or a file
> > > > > that has been dup'ed by a file received via the replace_fd() interface.
> > > > > 
> > > > > eventpoll_replace() is called from do_replace() and finds all instances of the
> > > > > file to be replaced and replaces them with the new file.
> > > > > 
> > > > > do_replace() also replaces the file in the file descriptor table for all fd
> > > > > numbers referencing it with the new file.
> > > > > 
> > > > > We have a use case where multiple IPv6 only network namespaces can use a single
> > > > > IPv4 network namespace for IPv4 only egress connectivity by switching their
> > > > > sockets from IPv6 to IPv4 network namespace. This allows for migration of
> > > > > systems to IPv6 only while keeping their connectivity to IPv4 only destinations
> > > > > intact.
> > > > > 
> > > > > Today, we achieve this by setting up seccomp filter to intercept network system
> > > > > calls like connect() from a container in a container manager which runs in an
> > > > > IPv4 only network namespace. The container manager creates a new IPv4 connection
> > > > > and injects the new file descriptor through SECCOMP_NOTIFY_IOCTL_ADDFD replacing
> > > > > the original file descriptor from the connect() call. This does not work for
> > > > > cases where the original file descriptor is handed off to a system like epoll
> > > > > before the connect() call. After a new file descriptor is injected the original
> > > > > file descriptor being referenced by the epoll fd is not longer valid leading to
> > > > > failures. As a workaround the container manager when intercepting connect()
> > > > > loops through all open socket file descriptors to check if they are referencing
> > > > > the socket attempting the connect() and replace the reference with the to be
> > > > > injected file descriptor. This workaround is cumbersome and makes the solution
> > > > > prone to similar yet to be discovered issues.
> > > > > 
> > > > > The above change will enable us remove the workaround in the container manager
> > > > > and let the kernel handle the replacement correctly.
> > > > > 
> > > > > Signed-off-by: aloktiagi <aloktiagi@gmail.com>
> > > > > ---
> > > > >  fs/eventpoll.c                                | 38 ++++++++
> > > > >  fs/file.c                                     | 54 +++++++++++
> > > > >  include/linux/eventpoll.h                     | 18 ++++
> > > > >  include/linux/file.h                          |  1 +
> > > > >  tools/testing/selftests/seccomp/seccomp_bpf.c | 97 +++++++++++++++++++
> > > > >  5 files changed, 208 insertions(+)
> > > > > 
> > > > > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > > > > index 64659b110973..958ad995fd45 100644
> > > > > --- a/fs/eventpoll.c
> > > > > +++ b/fs/eventpoll.c
> > > > > @@ -935,6 +935,44 @@ void eventpoll_release_file(struct file *file)
> > > > >  	mutex_unlock(&epmutex);
> > > > >  }
> > > > >  
> > > > > +static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
> > > > > +			struct file *tfile, int fd, int full_check);
> > > > > +
> > > > > +/*
> > > > > + * This is called from eventpoll_replace() to replace a linked file in the epoll
> > > > > + * interface with a new file received from another process. This is useful in
> > > > > + * cases where a process is trying to install a new file for an existing one
> > > > > + * that is linked in the epoll interface
> > > > > + */
> > > > > +void eventpoll_replace_file(struct file *toreplace, struct file *file)
> > > > > +{
> > > > > +	int fd;
> > > > > +	struct eventpoll *ep;
> > > > > +	struct epitem *epi;
> > > > > +	struct hlist_node *next;
> > > > > +	struct epoll_event event;
> > > > > +
> > > > > +	if (!file_can_poll(file))
> > > > > +		return;
> > > > > +
> > > > > +	mutex_lock(&epmutex);
> > > > > +	if (unlikely(!toreplace->f_ep)) {
> > > > > +		mutex_unlock(&epmutex);
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	hlist_for_each_entry_safe(epi, next, toreplace->f_ep, fllink) {
> > > > > +		ep = epi->ep;
> > > > > +		mutex_lock(&ep->mtx);
> > > > > +		fd = epi->ffd.fd;
> > > > > +		event = epi->event;
> > > > > +		ep_remove(ep, epi);
> > > > > +		ep_insert(ep, &event, file, fd, 1);
> > > > 
> > > > So, ep_remove() can't fail but ep_insert() can. Maybe that doesn't
> > > > matter...
> > > > 
> > > > > +		mutex_unlock(&ep->mtx);
> > > > > +	}
> > > > > +	mutex_unlock(&epmutex);
> > > > > +}
> > > > 
> > > > Andrew carries a patchset that may impact the locking here:
> > > > 
> > > > https://lore.kernel.org/linux-fsdevel/323de732635cc3513c1837c6cbb98f012174f994.1678312201.git.pabeni@redhat.com
> > > > 
> > > > I have to say that this whole thing has a very unpleasant taste to it.
> > > > Replacing a single fd from seccomp is fine, wading through the fdtable
> > > > to replace all fds referencing the same file is pretty nasty. Especially
> > > > with the global epoll mutex involved in all of this.
> > > > 
> > > > And what limits this to epoll. I'm seriously asking aren't there
> > > > potentially issues for fds somehow referenced in io_uring instances as
> > > > well?
> > > > 
> > > > I'm not convinced this belongs here yet...
> > > 
> > > Thank you for reviewing and proving a link to Andrew's patch.
> > > 
> > > I think just replacing a single fd from seccomp leaves this feature in an
> > > incomplete state. As a user of this feature, it means I need to figure out what
> > > all file descriptors are referencing this file eg. epoll, dup'ed fds etc. This
> > > patch is an attempt to complete this seccomp feature and also move the logic of
> > > figuring out the references to the kernel.
> > 
> > I'm still not convinced.
> > 
> > You're changing the semantics of the replace file feature in seccomp
> > drastically. Whereas now it means replace the file a single fd refers to
> > you're now letting it replace multiple fds.
> 
> Yes; the crux of the patch is really the epoll part, not the multiple
> replace part. IMO, we should drop the multiple replace bit, as I agree
> it is a pretty big change.
> 
> The change in semantics w.r.t. epoll() (and eventually others),
> though, is important. The way it currently works is not really
> helpful.
> 
> Perhaps we could add a flag that people could set from SECCOMP_ADDFD
> asking for this extra behavior?

So I've been thinking about this. I still maintain that fdtable helpers
such as replace_fd() are the wrong place to solve any of this. Again,
they shouldn't interfer with other subsystems like epoll or io_uring in
any semantically fundamental way. The exception I can see is that when
the type of fd/file requires specific actions to be performed during
replace such as sockets.

The reason why I keep stressing this is because you'll almost certainly
will come around the corner with more patches in the future to update
other places where the replaced fd implicitly references the old file
even though the fdtable has already been updated to point to the new
file. And if you don't someone else might.

And that to me implies that we want per-subsystem helpers to update the
old file references. What references to update should be selectable by
the supervisor for backward compatibility.

I think that's cleaner API wise and doesn't violate layering quite as badly.

Another thing that struck me is that you don't require none of the
fdtable locks to do other updates. So here's my
UNTESTED+NON-COMPILING+DRAFT+STRAWMAN+SKETCH proposal:

        diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
        index 0fdc6ef02b94..82beca4c24da 100644
        --- a/include/uapi/linux/seccomp.h
        +++ b/include/uapi/linux/seccomp.h
        @@ -118,6 +118,13 @@ struct seccomp_notif_resp {
         /* valid flags for seccomp_notif_addfd */
         #define SECCOMP_ADDFD_FLAG_SETFD       (1UL << 0) /* Specify remote fd */
         #define SECCOMP_ADDFD_FLAG_SEND                (1UL << 1) /* Addfd and return it, atomically */
        +#define SECCOMP_ADDFD_FLAG_EPOLL       (1UL << 2) /* Update epoll references */
        +#define SECCOMP_ADDFD_FLAG_IOURING     (1UL << 3) /* Update io_uring references */
        +#define SECCOMP_ADDFD_FLAG_FANOTIFY    (1UL << 4) /* Update fanotify references (probably nonsensical, but just here for illustration purposes) */
        +
        +#define SECOMP_ADDFD_FLAG_EVENTS                                 \
        +       (SECCOMP_ADDFD_FLAG_EPOLL | SECCOMP_ADDFD_FLAG_IOURING | \
        +        SECCOMP_ADDFD_FLAG_FANOTIFY)
        
         /**
          * struct seccomp_notif_addfd
        diff --git a/kernel/seccomp.c b/kernel/seccomp.c
        index cebf26445f9e..02f8b67a9ba2 100644
        --- a/kernel/seccomp.c
        +++ b/kernel/seccomp.c
        @@ -1066,6 +1066,24 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_kn
                        fd = receive_fd(addfd->file, addfd->flags);
                else
                        fd = receive_fd_replace(addfd->fd, addfd->file, addfd->flags);
        +
        +       if (fd > 0 && addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_EPOLL) {
        +               /*
        +                * - retrieve old struct file that addfd->fd refered to if any.
        +                * - call your epoll seccomp api to update the references in the epoll instance
        +                */
			epoll_seccomp_notify()
        +       }
        +
        +       if (fd > 0 && addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_IO_URING) {
        +               /*
        +                * - call your io_uring seccomp api to update the references in the io_uring instance
        +                */
			io_uring_seccomp_notify()
        +       }
        +
        +       .
        +       . I WILL DEFO NOT COMPILE
        +       .
        +
                addfd->ret = fd;
        
                if (addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_SEND) {
        @@ -1613,12 +1631,16 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
                if (addfd.newfd_flags & ~O_CLOEXEC)
                        return -EINVAL;
        
        -       if (addfd.flags & ~(SECCOMP_ADDFD_FLAG_SETFD | SECCOMP_ADDFD_FLAG_SEND))
        +       if (addfd.flags & ~(SECCOMP_ADDFD_FLAG_SETFD | SECCOMP_ADDFD_FLAG_SEND |
        +                           SECCOMP_ADDFD_FLAG_EPOLL))
                        return -EINVAL;
        
                if (addfd.newfd && !(addfd.flags & SECCOMP_ADDFD_FLAG_SETFD))
                        return -EINVAL;
        
        +       if ((flags & SECCOMP_ADDFD_FLAG_EPOLL) && !add.newfd)
        +               return -EINVAL;
        +
                kaddfd.file = fget(addfd.srcfd);
                if (!kaddfd.file)
                        return -EBADF;

You might want to add a new member to struct seccomp_kaddfd so when you replace
the file you can stash the reference to the old file and pass it to the helpers
where things get updated:

        struct seccomp_kaddfd {
               struct file *file;
        +      struct file *old_file;
               int fd;
               unsigned int flags;
               __u32 ioctl_flags;

With this added you can int the future go to each subsystem and ask them to
expose you a function to update file references after you updated it in
the caller's fdtable. But the VFS/fdtable needs nothing to do with this
after replace_fd() has been called.

So then we can place all of these updates under new addfd flags and
maintain backward compatibility for older seccomp clients which I
pointed out in the other mail (So basically yes, we should do flags as
you also asked/suggested in your reply.).

For convenience we can expose defines like SECOMP_ADDFD_FLAG_EVENTS that
allow userspace to specify that they want the full shebang update.

Since the seccomp addfd uapi struct is extensible you should be pretty
much future prove as well.

I'm sure there's subtleties I miss but I think that's a better way forward.

> 
> > > 
> > > The epmutex is taken when the file is replaced in the epoll interface. This is
> > > similar to what would happen when eventpoll_release would be called for this
> > > same file when it is ultimately released from __fput().
> > > 
> > > This is indeed not limited to epoll and the file descriptor table, but this
> > > current patch addresses is limited to these interfaces. We can create a separate
> > > one for io_uring.
> > 
> > The criteria for when it's sensible to update an fd to refer to the new
> > file and when not are murky here and tailored to this very specific
> > use-case. We shouldn't be involved in decisions like that. Userspace is
> > in a much better position to know when it's sensible to replace an fd.
> > 
> > The fdtable is no place to get involved in a game of "if the fd is in a
> > epoll instance, update the epoll instance, if it's in an io_uring
> > instance, update the io_uring instance, ...". That's a complete
> > layerying violation imho.
> > 
> > And even if you'd need to get sign off on this from epoll and io_uring
> > folks as well before we can just reach into other subsytems from the
> > fdtable.
> 
> Yep, agreed.
> 
> > I'm sorry but this all sounds messy. You can do this just fine in
> > userspace, so please do it in userspace. This all sound very NAKable
> > right now.
> 
> We have added lots of APIs for things that are possible from userspace
> already that are made easier with a nice API. The seccomp forwarding
> functionality itself, pidfd_getfd(), etc. I don't see this particular
> bit as a strong argument against.

It's always a question of how much burden we shift into the kernel or a
specific subsystem. IOW, if this results in really clunky apis then it's
probably not something we should o.
