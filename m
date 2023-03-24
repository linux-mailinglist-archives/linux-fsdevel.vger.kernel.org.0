Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1A76C79A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 09:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjCXIX4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 04:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjCXIXy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:23:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9272E1BD;
        Fri, 24 Mar 2023 01:23:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EFD76297C;
        Fri, 24 Mar 2023 08:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF33C433A0;
        Fri, 24 Mar 2023 08:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679646231;
        bh=ibjEq9zqgHBGwxseo0ipHccN0gJTj7wmmV6WDAZxWRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BiolOJ7sWQjfWCLjYjtr/Qd8dOye4kx1Ad4WjivteFm2rOb7waiDPze6/iigtM+OT
         LoWYUH9KTXdAwOVheQxYjUcS9dcdZR2U7hV22FgnGvFakiJR/nyhbHEyhiF1ctZYqr
         QX5otE2XHyfS+TzOzNzpE485KwNNL+ed0EtwiVwtZJHMP1Rh/vqfki+pU2A1oz9RhA
         mj2CVtFGmhBQzrt68t+94a+TDtgBO30qio9oDlAhv6HQEjhIXG1SrODAgYLmzfdsbM
         49oJ8pioYgixNN5c1/28VPvgOj20Rd5dht3DgzaVfXGmHm1hOEqsgsBCxLXGpIjHdF
         FkRDydFRFpHAA==
Date:   Fri, 24 Mar 2023 09:23:44 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     aloktiagi <aloktiagi@gmail.com>
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David.Laight@ACULAB.COM, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        hch@infradead.org, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [RFC v4 2/2] file, epoll: Implement do_replace() and
 eventpoll_replace()
Message-ID: <20230324082344.xgze2vu3ds2kubcz@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230324063422.1031181-2-aloktiagi@gmail.com>
 <ZBzRfDnHaEycE72s@ip-172-31-38-16.us-west-2.compute.internal>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 10:23:56PM +0000, Alok Tiagi wrote:
> On Mon, Mar 20, 2023 at 03:51:03PM +0100, Christian Brauner wrote:
> > On Sat, Mar 18, 2023 at 06:02:48AM +0000, aloktiagi wrote:
> > > Introduce a mechanism to replace a file linked in the epoll interface or a file
> > > that has been dup'ed by a file received via the replace_fd() interface.
> > > 
> > > eventpoll_replace() is called from do_replace() and finds all instances of the
> > > file to be replaced and replaces them with the new file.
> > > 
> > > do_replace() also replaces the file in the file descriptor table for all fd
> > > numbers referencing it with the new file.
> > > 
> > > We have a use case where multiple IPv6 only network namespaces can use a single
> > > IPv4 network namespace for IPv4 only egress connectivity by switching their
> > > sockets from IPv6 to IPv4 network namespace. This allows for migration of
> > > systems to IPv6 only while keeping their connectivity to IPv4 only destinations
> > > intact.
> > > 
> > > Today, we achieve this by setting up seccomp filter to intercept network system
> > > calls like connect() from a container in a container manager which runs in an
> > > IPv4 only network namespace. The container manager creates a new IPv4 connection
> > > and injects the new file descriptor through SECCOMP_NOTIFY_IOCTL_ADDFD replacing
> > > the original file descriptor from the connect() call. This does not work for
> > > cases where the original file descriptor is handed off to a system like epoll
> > > before the connect() call. After a new file descriptor is injected the original
> > > file descriptor being referenced by the epoll fd is not longer valid leading to
> > > failures. As a workaround the container manager when intercepting connect()
> > > loops through all open socket file descriptors to check if they are referencing
> > > the socket attempting the connect() and replace the reference with the to be
> > > injected file descriptor. This workaround is cumbersome and makes the solution
> > > prone to similar yet to be discovered issues.
> > > 
> > > The above change will enable us remove the workaround in the container manager
> > > and let the kernel handle the replacement correctly.
> > > 
> > > Signed-off-by: aloktiagi <aloktiagi@gmail.com>
> > > ---
> > >  fs/eventpoll.c                                | 38 ++++++++
> > >  fs/file.c                                     | 54 +++++++++++
> > >  include/linux/eventpoll.h                     | 18 ++++
> > >  include/linux/file.h                          |  1 +
> > >  tools/testing/selftests/seccomp/seccomp_bpf.c | 97 +++++++++++++++++++
> > >  5 files changed, 208 insertions(+)
> > > 
> > > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > > index 64659b110973..958ad995fd45 100644
> > > --- a/fs/eventpoll.c
> > > +++ b/fs/eventpoll.c
> > > @@ -935,6 +935,44 @@ void eventpoll_release_file(struct file *file)
> > >  	mutex_unlock(&epmutex);
> > >  }
> > >  
> > > +static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
> > > +			struct file *tfile, int fd, int full_check);
> > > +
> > > +/*
> > > + * This is called from eventpoll_replace() to replace a linked file in the epoll
> > > + * interface with a new file received from another process. This is useful in
> > > + * cases where a process is trying to install a new file for an existing one
> > > + * that is linked in the epoll interface
> > > + */
> > > +void eventpoll_replace_file(struct file *toreplace, struct file *file)
> > > +{
> > > +	int fd;
> > > +	struct eventpoll *ep;
> > > +	struct epitem *epi;
> > > +	struct hlist_node *next;
> > > +	struct epoll_event event;
> > > +
> > > +	if (!file_can_poll(file))
> > > +		return;
> > > +
> > > +	mutex_lock(&epmutex);
> > > +	if (unlikely(!toreplace->f_ep)) {
> > > +		mutex_unlock(&epmutex);
> > > +		return;
> > > +	}
> > > +
> > > +	hlist_for_each_entry_safe(epi, next, toreplace->f_ep, fllink) {
> > > +		ep = epi->ep;
> > > +		mutex_lock(&ep->mtx);
> > > +		fd = epi->ffd.fd;
> > > +		event = epi->event;
> > > +		ep_remove(ep, epi);
> > > +		ep_insert(ep, &event, file, fd, 1);
> > 
> > So, ep_remove() can't fail but ep_insert() can. Maybe that doesn't
> > matter...
> > 
> > > +		mutex_unlock(&ep->mtx);
> > > +	}
> > > +	mutex_unlock(&epmutex);
> > > +}
> > 
> > Andrew carries a patchset that may impact the locking here:
> > 
> > https://lore.kernel.org/linux-fsdevel/323de732635cc3513c1837c6cbb98f012174f994.1678312201.git.pabeni@redhat.com
> > 
> > I have to say that this whole thing has a very unpleasant taste to it.
> > Replacing a single fd from seccomp is fine, wading through the fdtable
> > to replace all fds referencing the same file is pretty nasty. Especially
> > with the global epoll mutex involved in all of this.
> > 
> > And what limits this to epoll. I'm seriously asking aren't there
> > potentially issues for fds somehow referenced in io_uring instances as
> > well?
> > 
> > I'm not convinced this belongs here yet...
> 
> Thank you for reviewing and proving a link to Andrew's patch.
> 
> I think just replacing a single fd from seccomp leaves this feature in an
> incomplete state. As a user of this feature, it means I need to figure out what
> all file descriptors are referencing this file eg. epoll, dup'ed fds etc. This
> patch is an attempt to complete this seccomp feature and also move the logic of
> figuring out the references to the kernel.

I'm still not convinced.

You're changing the semantics of the replace file feature in seccomp
drastically. Whereas now it means replace the file a single fd refers to
you're now letting it replace multiple fds.

If a the caller has 10 fds open and some of them in epoll instance and
all reference the same file: What if the caller wants 5 of them to refer
to the old file and only 5 of them to be updated? The kernel can't now this.

Callers that now rely on a single fd being replaced and want the other
fds to be left alone will suddenly see all of the references change.

> 
> The epmutex is taken when the file is replaced in the epoll interface. This is
> similar to what would happen when eventpoll_release would be called for this
> same file when it is ultimately released from __fput().
> 
> This is indeed not limited to epoll and the file descriptor table, but this
> current patch addresses is limited to these interfaces. We can create a separate
> one for io_uring.

The criteria for when it's sensible to update an fd to refer to the new
file and when not are murky here and tailored to this very specific
use-case. We shouldn't be involved in decisions like that. Userspace is
in a much better position to know when it's sensible to replace an fd.

The fdtable is no place to get involved in a game of "if the fd is in a
epoll instance, update the epoll instance, if it's in an io_uring
instance, update the io_uring instance, ...". That's a complete
layerying violation imho.

And even if you'd need to get sign off on this from epoll and io_uring
folks as well before we can just reach into other subsytems from the
fdtable.

There's other worries: what if someone registers the file in another
notification mechanism that doesn't keep a reference to the fd and then
we can't update it from replace_fd() so you'll need yet another
mechanism to update it.

I'm sorry but this all sounds messy. You can do this just fine in
userspace, so please do it in userspace. This all sound very NAKable
right now.
