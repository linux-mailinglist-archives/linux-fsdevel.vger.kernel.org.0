Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB5C1321B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 09:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgAGIzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 03:55:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46343 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgAGIzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:55:50 -0500
Received: from ip-109-41-1-227.web.vodafone.de ([109.41.1.227] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iokeQ-0003oe-Cm; Tue, 07 Jan 2020 08:55:46 +0000
Date:   Tue, 7 Jan 2020 09:55:47 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: Re: [PATCH v8 3/3] test: Add test for pidfd getfd
Message-ID: <20200107085546.jr4mlusloraejish@wittgenstein>
References: <20200103162928.5271-1-sargun@sargun.me>
 <20200103162928.5271-4-sargun@sargun.me>
 <20200105142019.umls5ff4b5433u6k@wittgenstein>
 <20200105190812.GC8522@ircssh-2.c.rugged-nimbus-611.internal>
 <20200106171940.vjo2w5o6cqw2kkuk@wittgenstein>
 <20200106210647.GA30920@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200106210647.GA30920@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 06, 2020 at 09:06:47PM +0000, Sargun Dhillon wrote:
> On Mon, Jan 06, 2020 at 06:19:41PM +0100, Christian Brauner wrote:
> > On Sun, Jan 05, 2020 at 07:08:13PM +0000, Sargun Dhillon wrote:
> > > On Sun, Jan 05, 2020 at 03:20:23PM +0100, Christian Brauner wrote:
> > > > On Fri, Jan 03, 2020 at 08:29:28AM -0800, Sargun Dhillon wrote:
> > > > > +static int sys_pidfd_getfd(int pidfd, int fd, int flags)
> > > > > +{
> > > > > +	return syscall(__NR_pidfd_getfd, pidfd, fd, flags);
> > > > > +}
> > > > 
> > > > I think you can move this to the pidfd.h header as:
> > > > 
> > > > static inline int sys_pidfd_getfd(int pidfd, int fd, int flags)
> > > > {
> > > > 	return syscall(__NR_pidfd_getfd, pidfd, fd, flags);
> > > > }
> > > > 
> > > > Note, this also needs an
> > > > 
> > > > #ifndef __NR_pidfd_getfd
> > > > __NR_pidfd_getfd -1
> > > > #endif
> > > > so that compilation doesn't fail.
> > > > 
> > > I'll go ahead and move this into pidfd.h, and follow the pattern there. I
> > > don't think it's worth checking if each time the return code is ENOSYS.
> > > 
> > > Does it make sense to add something like:
> > > #ifdef __NR_pidfd_getfd
> > > TEST_HARNESS_MAIN
> > > #else
> > > int main(void)
> > > {
> > > 	fprintf(stderr, "pidfd_getfd syscall not supported\n");
> > > 	return KSFT_SKIP;
> > > }
> > > #endif
> > > 
> > > to short-circuit the entire test suite?
> > 
> > You mean the getfd testsuite? If so and that works, then sounds like a
> > good idea to me.
> > 
> > > 
> > > 
> > > 
> > > > 
> > > > Hm, isn't it safer to do 65535 explicitly? Since USHRT_MAX can
> > > > technically be greater than 65535.
> > > > 
> > > I borrowed this from the BPF tests. I can hardcode something like:
> > > #define NOBODY_UID 65535
> > > and setuid to that, if you think it's safer?
> > 
> > If you want to specifically seteuid() to 65535 then yes, using the
> > hard-coded number or using a dedicated macro seems better.
> > 
> > > 
> > > > > +
> > > > > +	ASSERT_EQ(1, send(self->sk, "P", 1, 0));
> > > > > +	ASSERT_EQ(1, recv(self->sk, &c, 1, 0));
> > > > > +
> > > > > +	fd = sys_pidfd_getfd(self->pidfd, self->remote_fd, 0);
> > > > > +	EXPECT_EQ(-1, fd);
> > > > > +	EXPECT_EQ(EPERM, errno);
> > > > > +
> > > > > +	if (uid == 0)
> > > > > +		ASSERT_EQ(0, seteuid(0));
> > > > > +}
> > > > > +
> > > > > +TEST_F(child, fetch_fd)
> > > > > +{
> > > > > +	int fd, ret;
> > > > > +
> > > > > +	fd = sys_pidfd_getfd(self->pidfd, self->remote_fd, 0);
> > > > > +	ASSERT_GE(fd, 0);
> > > > > +
> > > > > +	EXPECT_EQ(0, sys_kcmp(getpid(), self->pid, KCMP_FILE, fd, self->remote_fd));
> > > > 
> > > > So most of these tests seem to take place when the child has already
> > > > called exit() - or at least it's very likely that the child has already
> > > > called exit() - and remains a zombie. That's not ideal because
> > > > that's not the common scenario/use-case. Usually the task of which we
> > > > want to get an fd will be alive. Also, if the child has already called
> > > > exit(), by the time it returns to userspace it should have already
> > > > called exit_files() and so I wonder whether this test would fail if it's
> > > > run after the child has exited. Maybe I'm missing something here... Is
> > > > there some ordering enforced by TEST_F()?
> > > Yeah, I think perhaps I was being too clever.
> > > The timeline roughly goes something like this:
> > > 
> > > # Fixture bringup
> > > [parent] creates socket_pair
> > > [parent] forks, and passes pair down to child
> > > [parent] waits to read sizeof(int) from the sk_pair
> > > [child] creates memfd 
> > > [__child] sends local memfd number to parent via sk_pair
> > > [__child] waits to read from sk_pair
> > > [parent] reads remote memfd number from socket
> > > # Test
> > > [parent] performs tests
> > > # Fixture teardown
> > > [parent] closes sk_pair
> > > [__child] reads 0 from recv on sk_pair, implies the other end is closed
> > > [__child] Returns / exits 0
> > > [parent] Reaps child / reads exit code
> > > 
> > > ---
> > > The one case where this is not true, is if the parent sends 'P' to the sk pair,
> > > it triggers setting PR_SET_DUMPABLE to 0, and then resumes waiting for the fd to 
> > > close.
> > > 
> > > Maybe I'm being too clever? Instead, the alternative was to send explicit stop / 
> > > start messages across the sk_pair, but that got kind of ugly. Do you have a 
> > > better suggestion?
> > 
> > If I understand correctly you just need to block the child to stop it
> > from exiting. Couldn't you do this by simply calling recv() on the
> > socket in the child thereby blocking it? At the end you just send a
> > final message to proceed and if that doesn't work SIGKILL it?
> > 
> This already exists in:
> while ((ret = recv(sk, &buf, sizeof(buf), 0)) > 0) {
> 	if (buf == 'P') {
> 		ret = prctl(PR_SET_DUMPABLE, 0);
> 		if (ret < 0) {
> 			fprintf(stderr,
> 				"%s: Child failed to disable ptrace\n",
> 				strerror(errno));
> 			return -1;
> 		}
> 	} else {
> 		fprintf(stderr, "Child received unknown command %c\n",
> 			buf);
> 		return -1;
> 	}
> 	ret = send(sk, &buf, sizeof(buf), 0);
> 	if (ret != 1) {
> 		fprintf(stderr, "%s: Child failed to ack\n",
> 			strerror(errno));
> 		return -1;
> 	}
> }
> ----
> This will block until the close(self->sk) in the fixture teardown. Then ret
> returns 0, and the child should exit. Maybe a comment like:
> /*
>  * The fixture setup is completed at this point. The tests will run.
>  *
>  * Either we will read 'P' off of the sk, indicating that we need
>  * to disable ptrace, or if the other side of the socket is closed
>  * recv will return 0-bytes. This indicates that the fixture teardown
>  * has occured, and the child should exit.
>  */
> would be useful?

Ah yeah, that would be helpful. I missed that while reading the code. So
the child is definitely still alive when te tests are run, it seems.
That explains why this didn't fail. :)

> 
> > > 
> > > > 
> > > > Also, what does self->pid point to? The fd of the already exited child?
> > > It's just the pid of the child. pidfd is the fd of the (unexited) child.
> I have no idea if it's pro / against the commenting style to blow up that
> structure:

I think it's fine to comment it like that.

Thanks!
Christian
