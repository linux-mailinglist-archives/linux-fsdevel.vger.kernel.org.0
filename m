Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D19813086A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 15:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAEOUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 09:20:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47783 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgAEOUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 09:20:37 -0500
Received: from [172.58.27.182] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1io6lb-0001nF-EZ; Sun, 05 Jan 2020 14:20:32 +0000
Date:   Sun, 5 Jan 2020 15:20:23 +0100
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
Message-ID: <20200105142019.umls5ff4b5433u6k@wittgenstein>
References: <20200103162928.5271-1-sargun@sargun.me>
 <20200103162928.5271-4-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200103162928.5271-4-sargun@sargun.me>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 03, 2020 at 08:29:28AM -0800, Sargun Dhillon wrote:
> The following tests:
>   * Fetch FD, and then compare via kcmp
>   * Make sure getfd can be blocked by blocking ptrace_may_access
>   * Making sure fetching bad FDs fails
>   * Make sure trying to set flags to non-zero results in an EINVAL
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  tools/testing/selftests/pidfd/.gitignore      |   1 +
>  tools/testing/selftests/pidfd/Makefile        |   4 +-
>  .../selftests/pidfd/pidfd_getfd_test.c        | 227 ++++++++++++++++++
>  3 files changed, 230 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/pidfd/pidfd_getfd_test.c
> 
> diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
> index 8d069490e17b..3a779c084d96 100644
> --- a/tools/testing/selftests/pidfd/.gitignore
> +++ b/tools/testing/selftests/pidfd/.gitignore
> @@ -2,3 +2,4 @@ pidfd_open_test
>  pidfd_poll_test
>  pidfd_test
>  pidfd_wait
> +pidfd_getfd_test
> diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
> index 43db1b98e845..2071f7ab5dc9 100644
> --- a/tools/testing/selftests/pidfd/Makefile
> +++ b/tools/testing/selftests/pidfd/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -CFLAGS += -g -I../../../../usr/include/ -pthread
> +CFLAGS += -g -I../../../../usr/include/ -pthread -Wall
>  
> -TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test pidfd_poll_test pidfd_wait
> +TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test pidfd_poll_test pidfd_wait pidfd_getfd_test
>  
>  include ../lib.mk
>  
> diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
> new file mode 100644
> index 000000000000..26ca75597812
> --- /dev/null
> +++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <linux/types.h>
> +#include <sched.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <syscall.h>
> +#include <sys/prctl.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <sys/socket.h>
> +#include <linux/kcmp.h>
> +
> +#include "pidfd.h"
> +#include "../kselftest.h"
> +#include "../kselftest_harness.h"
> +
> +/*
> + * UNKNOWN_FD is an fd number that should never exist in the child, as it is
> + * used to check the negative case.
> + */
> +#define UNKNOWN_FD 111
> +
> +static int sys_kcmp(pid_t pid1, pid_t pid2, int type, unsigned long idx1,
> +		    unsigned long idx2)
> +{
> +	return syscall(__NR_kcmp, pid1, pid2, type, idx1, idx2);
> +}
> +
> +static int sys_pidfd_getfd(int pidfd, int fd, int flags)
> +{
> +	return syscall(__NR_pidfd_getfd, pidfd, fd, flags);
> +}

I think you can move this to the pidfd.h header as:

static inline int sys_pidfd_getfd(int pidfd, int fd, int flags)
{
	return syscall(__NR_pidfd_getfd, pidfd, fd, flags);
}

Note, this also needs an

#ifndef __NR_pidfd_getfd
__NR_pidfd_getfd -1
#endif
so that compilation doesn't fail.

> +
> +static int sys_memfd_create(const char *name, unsigned int flags)
> +{
> +	return syscall(__NR_memfd_create, name, flags);
> +}
> +
> +static int __child(int sk, int memfd)
> +{
> +	int ret;
> +	char buf;
> +
> +	/*
> +	 * Ensure we don't leave around a bunch of orphaned children if our
> +	 * tests fail.
> +	 */
> +	ret = prctl(PR_SET_PDEATHSIG, SIGKILL);
> +	if (ret) {
> +		fprintf(stderr, "%s: Child could not set DEATHSIG\n",
> +			strerror(errno));
> +		return EXIT_FAILURE;

return -1

> +	}
> +
> +	ret = send(sk, &memfd, sizeof(memfd), 0);
> +	if (ret != sizeof(memfd)) {
> +		fprintf(stderr, "%s: Child failed to send fd number\n",
> +			strerror(errno));
> +		return EXIT_FAILURE;

return -1

> +	}
> +
> +	while ((ret = recv(sk, &buf, sizeof(buf), 0)) > 0) {
> +		if (buf == 'P') {
> +			ret = prctl(PR_SET_DUMPABLE, 0);
> +			if (ret < 0) {
> +				fprintf(stderr,
> +					"%s: Child failed to disable ptrace\n",
> +					strerror(errno));
> +				return EXIT_FAILURE;

return -1

> +			}
> +		} else {
> +			fprintf(stderr, "Child received unknown command %c\n",
> +				buf);
> +			return EXIT_FAILURE;

return -1

> +		}
> +		ret = send(sk, &buf, sizeof(buf), 0);
> +		if (ret != 1) {
> +			fprintf(stderr, "%s: Child failed to ack\n",
> +				strerror(errno));
> +			return EXIT_FAILURE;

return -1

> +		}
> +	}
> +
> +	if (ret < 0) {
> +		fprintf(stderr, "%s: Child failed to read from socket\n",
> +			strerror(errno));

Is this intentional that this is no failure?

> +	}
> +
> +	return EXIT_SUCCESS;

return 0

> +}
> +
> +static int child(int sk)
> +{
> +	int memfd, ret;
> +
> +	memfd = sys_memfd_create("test", 0);
> +	if (memfd < 0) {
> +		fprintf(stderr, "%s: Child could not create memfd\n",
> +			strerror(errno));
> +		ret = EXIT_FAILURE;

ret = -1;

> +	} else {
> +		ret = __child(sk, memfd);
> +		close(memfd);
> +	}
> +
> +	close(sk);
> +	return ret;
> +}
> +
> +FIXTURE(child)
> +{
> +	pid_t pid;
> +	int pidfd, sk, remote_fd;
> +};
> +
> +FIXTURE_SETUP(child)
> +{
> +	int ret, sk_pair[2];
> +
> +	ASSERT_EQ(0, socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair))
> +	{
> +		TH_LOG("%s: failed to create socketpair", strerror(errno));
> +	}
> +	self->sk = sk_pair[0];
> +
> +	self->pid = fork();
> +	ASSERT_GE(self->pid, 0);
> +
> +	if (self->pid == 0) {
> +		close(sk_pair[0]);
> +		exit(child(sk_pair[1]));

if (child(sk_pair[1]))
	_exit(EXIT_FAILURE);
_exit(EXIT_SUCCESS);

I would like to only use exit macros where one actually calls
{_}exit()s. It makes the logic easier to follow and ensures that one
doesn't accidently do an exit(-21345) or something (e.g. when adding new
code).

> +	}
> +
> +	close(sk_pair[1]);
> +
> +	self->pidfd = sys_pidfd_open(self->pid, 0);
> +	ASSERT_GE(self->pidfd, 0);
> +
> +	/*
> +	 * Wait for the child to complete setup. It'll send the remote memfd's
> +	 * number when ready.
> +	 */
> +	ret = recv(sk_pair[0], &self->remote_fd, sizeof(self->remote_fd), 0);
> +	ASSERT_EQ(sizeof(self->remote_fd), ret);
> +}
> +
> +FIXTURE_TEARDOWN(child)
> +{
> +	int status;
> +
> +	EXPECT_EQ(0, close(self->pidfd));
> +	EXPECT_EQ(0, close(self->sk));
> +
> +	EXPECT_EQ(waitpid(self->pid, &status, 0), self->pid);
> +	EXPECT_EQ(true, WIFEXITED(status));
> +	EXPECT_EQ(0, WEXITSTATUS(status));
> +}
> +
> +TEST_F(child, disable_ptrace)
> +{
> +	int uid, fd;
> +	char c;
> +
> +	/*
> +	 * Turn into nobody if we're root, to avoid CAP_SYS_PTRACE
> +	 *
> +	 * The tests should run in their own process, so even this test fails,
> +	 * it shouldn't result in subsequent tests failing.
> +	 */
> +	uid = getuid();
> +	if (uid == 0)
> +		ASSERT_EQ(0, seteuid(USHRT_MAX));

Hm, isn't it safer to do 65535 explicitly? Since USHRT_MAX can
technically be greater than 65535.

> +
> +	ASSERT_EQ(1, send(self->sk, "P", 1, 0));
> +	ASSERT_EQ(1, recv(self->sk, &c, 1, 0));
> +
> +	fd = sys_pidfd_getfd(self->pidfd, self->remote_fd, 0);
> +	EXPECT_EQ(-1, fd);
> +	EXPECT_EQ(EPERM, errno);
> +
> +	if (uid == 0)
> +		ASSERT_EQ(0, seteuid(0));
> +}
> +
> +TEST_F(child, fetch_fd)
> +{
> +	int fd, ret;
> +
> +	fd = sys_pidfd_getfd(self->pidfd, self->remote_fd, 0);
> +	ASSERT_GE(fd, 0);
> +
> +	EXPECT_EQ(0, sys_kcmp(getpid(), self->pid, KCMP_FILE, fd, self->remote_fd));

So most of these tests seem to take place when the child has already
called exit() - or at least it's very likely that the child has already
called exit() - and remains a zombie. That's not ideal because
that's not the common scenario/use-case. Usually the task of which we
want to get an fd will be alive. Also, if the child has already called
exit(), by the time it returns to userspace it should have already
called exit_files() and so I wonder whether this test would fail if it's
run after the child has exited. Maybe I'm missing something here... Is
there some ordering enforced by TEST_F()?

Also, what does self->pid point to? The fd of the already exited child?
