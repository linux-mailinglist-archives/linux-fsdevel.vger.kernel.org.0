Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931B56C15A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 15:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjCTOxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 10:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjCTOxN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:53:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED3F2941C;
        Mon, 20 Mar 2023 07:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAB2861537;
        Mon, 20 Mar 2023 14:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08797C433EF;
        Mon, 20 Mar 2023 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679323869;
        bh=reJZP/VffWowvyIkvazOhs7Ua2A75AKX5elZQ6LYThQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qvPLJSD1IalOQ0Gt69Tk/+lNf+zaaIRSCZq2q70IBCQvR/3qzVmBHGBu0P9Y6a4ff
         wkXB5d8IqYvH0l60mTcJ5P1CXa8yAdodekrlsPSdfWpYO9MjwmlAWl8AzUf3m3oGYy
         iEZ51Sm/xXsaw7UstSElEf4uUdkC11Qc8hCBTKASoIMZycRbppDreGC9bNOya4+wAF
         lWnyaOQE0atNikocvsipUUlaIBR17R1PhhMePK0aE4I11BQ8Rm0B8T6uvz/z9LObOV
         vTLmvD1+jCckZLHafvVvRGwgZn4SKXfWQYnPYhOisjTlfJvOctRs79oCXGKyOHpWVh
         whuDEB9EqUVsQ==
Date:   Mon, 20 Mar 2023 15:51:03 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     aloktiagi <aloktiagi@gmail.com>
Cc:     viro@zeniv.linux.org.uk, David.Laight@ACULAB.COM,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, hch@infradead.org,
        Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [RFC v2 3/3] file, epoll: Implement do_replace() and
 eventpoll_replace()
Message-ID: <20230320145103.grajefm7rs3dmj4e@wittgenstein>
References: <20230318060248.848099-1-aloktiagi@gmail.com>
 <20230318060248.848099-3-aloktiagi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230318060248.848099-3-aloktiagi@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 18, 2023 at 06:02:48AM +0000, aloktiagi wrote:
> Introduce a mechanism to replace a file linked in the epoll interface or a file
> that has been dup'ed by a file received via the replace_fd() interface.
> 
> eventpoll_replace() is called from do_replace() and finds all instances of the
> file to be replaced and replaces them with the new file.
> 
> do_replace() also replaces the file in the file descriptor table for all fd
> numbers referencing it with the new file.
> 
> We have a use case where multiple IPv6 only network namespaces can use a single
> IPv4 network namespace for IPv4 only egress connectivity by switching their
> sockets from IPv6 to IPv4 network namespace. This allows for migration of
> systems to IPv6 only while keeping their connectivity to IPv4 only destinations
> intact.
> 
> Today, we achieve this by setting up seccomp filter to intercept network system
> calls like connect() from a container in a container manager which runs in an
> IPv4 only network namespace. The container manager creates a new IPv4 connection
> and injects the new file descriptor through SECCOMP_NOTIFY_IOCTL_ADDFD replacing
> the original file descriptor from the connect() call. This does not work for
> cases where the original file descriptor is handed off to a system like epoll
> before the connect() call. After a new file descriptor is injected the original
> file descriptor being referenced by the epoll fd is not longer valid leading to
> failures. As a workaround the container manager when intercepting connect()
> loops through all open socket file descriptors to check if they are referencing
> the socket attempting the connect() and replace the reference with the to be
> injected file descriptor. This workaround is cumbersome and makes the solution
> prone to similar yet to be discovered issues.
> 
> The above change will enable us remove the workaround in the container manager
> and let the kernel handle the replacement correctly.
> 
> Signed-off-by: aloktiagi <aloktiagi@gmail.com>
> ---
>  fs/eventpoll.c                                | 38 ++++++++
>  fs/file.c                                     | 54 +++++++++++
>  include/linux/eventpoll.h                     | 18 ++++
>  include/linux/file.h                          |  1 +
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 97 +++++++++++++++++++
>  5 files changed, 208 insertions(+)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 64659b110973..958ad995fd45 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -935,6 +935,44 @@ void eventpoll_release_file(struct file *file)
>  	mutex_unlock(&epmutex);
>  }
>  
> +static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
> +			struct file *tfile, int fd, int full_check);
> +
> +/*
> + * This is called from eventpoll_replace() to replace a linked file in the epoll
> + * interface with a new file received from another process. This is useful in
> + * cases where a process is trying to install a new file for an existing one
> + * that is linked in the epoll interface
> + */
> +void eventpoll_replace_file(struct file *toreplace, struct file *file)
> +{
> +	int fd;
> +	struct eventpoll *ep;
> +	struct epitem *epi;
> +	struct hlist_node *next;
> +	struct epoll_event event;
> +
> +	if (!file_can_poll(file))
> +		return;
> +
> +	mutex_lock(&epmutex);
> +	if (unlikely(!toreplace->f_ep)) {
> +		mutex_unlock(&epmutex);
> +		return;
> +	}
> +
> +	hlist_for_each_entry_safe(epi, next, toreplace->f_ep, fllink) {
> +		ep = epi->ep;
> +		mutex_lock(&ep->mtx);
> +		fd = epi->ffd.fd;
> +		event = epi->event;
> +		ep_remove(ep, epi);
> +		ep_insert(ep, &event, file, fd, 1);

So, ep_remove() can't fail but ep_insert() can. Maybe that doesn't
matter...

> +		mutex_unlock(&ep->mtx);
> +	}
> +	mutex_unlock(&epmutex);
> +}

Andrew carries a patchset that may impact the locking here:

https://lore.kernel.org/linux-fsdevel/323de732635cc3513c1837c6cbb98f012174f994.1678312201.git.pabeni@redhat.com

I have to say that this whole thing has a very unpleasant taste to it.
Replacing a single fd from seccomp is fine, wading through the fdtable
to replace all fds referencing the same file is pretty nasty. Especially
with the global epoll mutex involved in all of this.

And what limits this to epoll. I'm seriously asking aren't there
potentially issues for fds somehow referenced in io_uring instances as
well?

I'm not convinced this belongs here yet...

> +
>  static int ep_alloc(struct eventpoll **pep)
>  {
>  	int error;
> diff --git a/fs/file.c b/fs/file.c
> index 1716f07103d8..ce691dae1f0e 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -20,10 +20,18 @@
>  #include <linux/spinlock.h>
>  #include <linux/rcupdate.h>
>  #include <linux/close_range.h>
> +#include <linux/eventpoll.h>
>  #include <net/sock.h>
>  
>  #include "internal.h"
>  
> +struct replace_filefd {
> +        struct files_struct *files;
> +        unsigned fd;
> +        struct file *fdfile;
> +        struct file *file;
> +};
> +
>  unsigned int sysctl_nr_open __read_mostly = 1024*1024;
>  unsigned int sysctl_nr_open_min = BITS_PER_LONG;
>  /* our min() is unusable in constant expressions ;-/ */
> @@ -1133,6 +1141,50 @@ __releases(&files->file_lock)
>  	return -EBUSY;
>  }
>  
> +static int do_replace_fd_array(const void *v, struct file *tofree, unsigned int n)
> +{
> +	struct replace_filefd *ffd = (void *)v;
> +	struct fdtable *fdt;
> +
> +	fdt = files_fdtable(ffd->files);
> +
> +	if ((n != ffd->fd) && (tofree == ffd->fdfile)) {
> +		get_file(ffd->file);
> +		rcu_assign_pointer(fdt->fd[n], ffd->file);
> +		tofree = pick_file(ffd->files, n);
> +		filp_close(tofree, ffd->files);
> +	}
> +	return 0;
> +}
> +
> +static void do_replace(struct files_struct *files,
> +        struct file *file, unsigned fd, struct file *fdfile)
> +{
> +	unsigned n = 0;
> +	struct replace_filefd ffd = {
> +		.files = files,
> +		.fd = fd,
> +		.fdfile = fdfile,
> +		.file = file
> +	};
> +
> +	/*
> +	 * Check if the file referenced by the fd number is linked to the epoll
> +	 * interface. If yes, replace the reference with the received file in
> +	 * the epoll interface.
> +	 */
> +	if (fdfile && fdfile->f_ep) {
> +		eventpoll_replace(fdfile, file);
> +	}
> +	/*
> +	 * Install the received file in the file descriptor table for all fd
> +	 * numbers referencing the same file as the one we are trying to
> +	 * replace. Do not install it for the fd number received since that is
> +	 * handled in do_dup2()
> +	 */
> +	iterate_fd_locked(files, n, do_replace_fd_array, &ffd);
> +}
> +
>  int replace_fd(unsigned fd, struct file *file, unsigned flags)
>  {
>  	int err;
> @@ -1150,8 +1202,10 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
>  	if (unlikely(err < 0))
>  		goto out_unlock;
>  	err = do_dup2(files, file, fd, &fdfile, flags);
> +	do_replace(files, file, fd, fdfile);

I might be missing context here but from what I can see:

Above you call iterate_fd_locked() in do_replace() implying that the
caller is holding spin_lock(&files->file_lock) from my reading.
But you call do_replace() after do_dup2() which drops
spin_lock(&files->file_lock).
So spin_lock(&files->file_lock) isn't held anymore and you call
iterate_fd_locked() non-locked. So it seems misnamed?

But then, I documented that pick_file() requires
spin_lock(&files->file_lock) to be held but then you don't seem to be
holding it. And I wonder why that's safe.

Then you call
get_file(ffd->file)
...
filp_close(tofree)

in do_replace_fd_array()

So if you call filp_close you might be hitting a filesystems' ->flush()
method (nfs, cifs, etc...) and cifs for example calls
filemap_write_and_wait(). And iirc that can take a while. So even if you
know that there are still references to the file and so you won't be
doing the final fput() you might still end up waiting which would get
you into issues if you have to be holding spin_lock(&files->file_lock).

>  	if (fdfile)
>  		filp_close(fdfile, files);
> +
>  	return err;
>  
>  out_unlock:
> diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
> index 3337745d81bd..38904fce3840 100644
> --- a/include/linux/eventpoll.h
> +++ b/include/linux/eventpoll.h
> @@ -25,6 +25,8 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long t
>  /* Used to release the epoll bits inside the "struct file" */
>  void eventpoll_release_file(struct file *file);
>  
> +void eventpoll_replace_file(struct file *toreplace, struct file *file);
> +
>  /*
>   * This is called from inside fs/file_table.c:__fput() to unlink files
>   * from the eventpoll interface. We need to have this facility to cleanup
> @@ -53,6 +55,22 @@ static inline void eventpoll_release(struct file *file)
>  	eventpoll_release_file(file);
>  }
>  
> +
> +/*
> + * This is called from fs/file.c:do_replace() to replace a linked file in the
> + * epoll interface with a new file received from another process. This is useful
> + * in cases where a process is trying to install a new file for an existing one
> + * that is linked in the epoll interface
> + */
> +static inline void eventpoll_replace(struct file *toreplace, struct file *file)
> +{
> +	/*
> +	 * toreplace is the file being replaced. Install the new file for the
> +	 * existing one that is linked in the epoll interface
> +	 */
> +	eventpoll_replace_file(toreplace, file);
> +}
> +
>  int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
>  		 bool nonblock);
>  
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 39704eae83e2..80e56b2b44fb 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -36,6 +36,7 @@ struct fd {
>  	struct file *file;
>  	unsigned int flags;
>  };
> +
>  #define FDPUT_FPUT       1
>  #define FDPUT_POS_UNLOCK 2
>  
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 61386e499b77..caf68682519c 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -47,6 +47,7 @@
>  #include <linux/kcmp.h>
>  #include <sys/resource.h>
>  #include <sys/capability.h>
> +#include <sys/epoll.h>
>  
>  #include <unistd.h>
>  #include <sys/syscall.h>
> @@ -4179,6 +4180,102 @@ TEST(user_notification_addfd)
>  	close(memfd);
>  }
>  
> +TEST(user_notification_addfd_with_epoll_replace)
> +{
> +	char c;
> +	pid_t pid;
> +	long ret;
> +	int status, listener, fd;
> +	int efd, sfd[4];
> +	struct epoll_event e;
> +	struct seccomp_notif_addfd addfd = {};
> +	struct seccomp_notif req = {};
> +	struct seccomp_notif_resp resp = {};
> +
> +	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> +	ASSERT_EQ(0, ret) {
> +		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
> +	}
> +
> +	listener = user_notif_syscall(__NR_getppid,
> +				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
> +
> +	/* Create two socket pairs sfd[0] <-> sfd[1] and sfd[2] <-> sfd[3] */
> +	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[0]), 0);
> +	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[2]), 0);
> +
> +	pid = fork();
> +	ASSERT_GE(pid, 0);
> +
> +	if (pid == 0) {
> +		efd = epoll_create(1);
> +		if (efd == -1)
> +			exit(1);
> +
> +		e.events = EPOLLIN;
> +		if (epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e) != 0)
> +			exit(1);
> +
> +		/*
> +		 * fd will be added here to replace an existing one linked
> +		 * in the epoll interface.
> +		 */
> +		if (syscall(__NR_getppid) != USER_NOTIF_MAGIC)
> +			exit(1);
> +
> +		/*
> +		 * Write data to the sfd[3] connected to sfd[2], but due to
> +		 * the swap, we should see data on sfd[0]
> +		 */
> +		if (write(sfd[3], "w", 1) != 1)
> +			exit(1);
> +
> +		if (epoll_wait(efd, &e, 1, 0) != 1)
> +			exit(1);
> +
> +		if (read(sfd[0], &c, 1) != 1)
> +			exit(1);
> +
> +		if ('w' != c)
> +			exit(1);
> +
> +		if (epoll_ctl(efd, EPOLL_CTL_DEL, sfd[0], &e) != 0)
> +			exit(1);
> +
> +		close(efd);
> +		close(sfd[0]);
> +		close(sfd[1]);
> +		close(sfd[2]);
> +		close(sfd[3]);
> +		exit(0);
> +	}
> +
> +	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
> +
> +	addfd.srcfd = sfd[2];
> +	addfd.newfd = sfd[0];
> +	addfd.id = req.id;
> +	addfd.flags = SECCOMP_ADDFD_FLAG_SETFD;
> +	addfd.newfd_flags = O_CLOEXEC;
> +
> +	/*
> +	 * Verfiy we can install and replace a file that is linked in the
> +	 * epoll interface. Replace the socket sfd[0] with sfd[2]
> +	 */
> +	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
> +	EXPECT_EQ(fd, sfd[0]);
> +
> +	resp.id = req.id;
> +	resp.error = 0;
> +	resp.val = USER_NOTIF_MAGIC;
> +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
> +
> +	/* Wait for child to finish. */
> +	EXPECT_EQ(waitpid(pid, &status, 0), pid);
> +	EXPECT_EQ(true, WIFEXITED(status));
> +	EXPECT_EQ(0, WEXITSTATUS(status));
> +}
> +
>  TEST(user_notification_addfd_rlimit)
>  {
>  	pid_t pid;
> -- 
> 2.34.1
> 
