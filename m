Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667F95F5A38
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 20:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiJES5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 14:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiJES5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:57:17 -0400
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CFE7FE53
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Oct 2022 11:57:15 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MjP2K5sDWzMqW4W;
        Wed,  5 Oct 2022 20:57:13 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MjP2K1zJRzMpnPc;
        Wed,  5 Oct 2022 20:57:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1664996233;
        bh=gfbjZCGaoWDDixy3buW/DN9CPUJWe7eBmnD67qFzLtI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YTCycN96tKqEYiNqEtaVgrRrEOuwmZX+OJNBbOXbkmI92fkPHVeJ4H0CNbRuCw+16
         xRU3Mu+HfRBoSwcMBM/Txe/jf82E4ZOvjReJqEBLJ0rlVe9O8Y82/tWJD3gfKpWmSC
         3frviJKjj8d1AUuUmKTVmyW31geJOOrOEpfD6bb0=
Message-ID: <ffacf78b-991f-3476-b3b8-9d8b847141fb@digikod.net>
Date:   Wed, 5 Oct 2022 20:57:12 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v8 7/9] selftests/landlock: Test FD passing from a
 Landlock-restricted to an unrestricted process
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
 <20221001154908.49665-8-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221001154908.49665-8-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for this refactoring.

We need a shorter subject though. ;)


On 01/10/2022 17:49, Günther Noack wrote:
> A file descriptor created in a restricted process carries Landlock
> restrictions with it which will apply even if the same opened file is
> used from an unrestricted process.
> 
> This change extracts suitable FD-passing helpers from base_test.c and
> moves them to common.h. We use the fixture variants from the ftruncate
> fixture to exercise the same scenarios as in the open_and_ftruncate
> test, but doing the Landlock restriction and open() in a different
> process than the ftruncate() call.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   tools/testing/selftests/landlock/base_test.c | 36 +----------
>   tools/testing/selftests/landlock/common.h    | 67 ++++++++++++++++++++
>   tools/testing/selftests/landlock/fs_test.c   | 62 ++++++++++++++++++
>   3 files changed, 132 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 72cdae277b02..6d1b6eedb432 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -263,23 +263,6 @@ TEST(ruleset_fd_transfer)
>   		.allowed_access = LANDLOCK_ACCESS_FS_READ_DIR,
>   	};
>   	int ruleset_fd_tx, dir_fd;
> -	union {
> -		/* Aligned ancillary data buffer. */
> -		char buf[CMSG_SPACE(sizeof(ruleset_fd_tx))];
> -		struct cmsghdr _align;
> -	} cmsg_tx = {};
> -	char data_tx = '.';
> -	struct iovec io = {
> -		.iov_base = &data_tx,
> -		.iov_len = sizeof(data_tx),
> -	};
> -	struct msghdr msg = {
> -		.msg_iov = &io,
> -		.msg_iovlen = 1,
> -		.msg_control = &cmsg_tx.buf,
> -		.msg_controllen = sizeof(cmsg_tx.buf),
> -	};
> -	struct cmsghdr *cmsg;
>   	int socket_fds[2];
>   	pid_t child;
>   	int status;
> @@ -298,33 +281,20 @@ TEST(ruleset_fd_transfer)
>   				    &path_beneath_attr, 0));
>   	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
>   
> -	cmsg = CMSG_FIRSTHDR(&msg);
> -	ASSERT_NE(NULL, cmsg);
> -	cmsg->cmsg_len = CMSG_LEN(sizeof(ruleset_fd_tx));
> -	cmsg->cmsg_level = SOL_SOCKET;
> -	cmsg->cmsg_type = SCM_RIGHTS;
> -	memcpy(CMSG_DATA(cmsg), &ruleset_fd_tx, sizeof(ruleset_fd_tx));
> -
>   	/* Sends the ruleset FD over a socketpair and then close it. */
>   	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0,
>   				socket_fds));
> -	ASSERT_EQ(sizeof(data_tx), sendmsg(socket_fds[0], &msg, 0));
> +	ASSERT_EQ(0, send_fd(socket_fds[0], ruleset_fd_tx));
>   	ASSERT_EQ(0, close(socket_fds[0]));
>   	ASSERT_EQ(0, close(ruleset_fd_tx));
>   
>   	child = fork();
>   	ASSERT_LE(0, child);
>   	if (child == 0) {
> -		int ruleset_fd_rx;
> +		int ruleset_fd_rx = recv_fd(socket_fds[1]);

We can now make it const.


>   
> -		*(char *)msg.msg_iov->iov_base = '\0';
> -		ASSERT_EQ(sizeof(data_tx),
> -			  recvmsg(socket_fds[1], &msg, MSG_CMSG_CLOEXEC));
> -		ASSERT_EQ('.', *(char *)msg.msg_iov->iov_base);
> +		ASSERT_LE(0, ruleset_fd_rx);
>   		ASSERT_EQ(0, close(socket_fds[1]));
> -		cmsg = CMSG_FIRSTHDR(&msg);
> -		ASSERT_EQ(cmsg->cmsg_len, CMSG_LEN(sizeof(ruleset_fd_tx)));
> -		memcpy(&ruleset_fd_rx, CMSG_DATA(cmsg), sizeof(ruleset_fd_tx));
>   
>   		/* Enforces the received ruleset on the child. */
>   		ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
> index 7d34592471db..15149d34e43b 100644
> --- a/tools/testing/selftests/landlock/common.h
> +++ b/tools/testing/selftests/landlock/common.h
> @@ -10,6 +10,7 @@
>   #include <errno.h>
>   #include <linux/landlock.h>
>   #include <sys/capability.h>
> +#include <sys/socket.h>
>   #include <sys/syscall.h>
>   #include <sys/types.h>
>   #include <sys/wait.h>
> @@ -189,3 +190,69 @@ static void __maybe_unused clear_cap(struct __test_metadata *const _metadata,
>   {
>   	_effective_cap(_metadata, caps, CAP_CLEAR);
>   }
> +
> +/* Receives an FD from a UNIX socket. Returns the received FD, -1 on error. */
> +static int __maybe_unused recv_fd(int usock)
> +{
> +	int fd_rx;
> +	union {
> +		/* Aligned ancillary data buffer. */
> +		char buf[CMSG_SPACE(sizeof(fd_rx))];
> +		struct cmsghdr _align;
> +	} cmsg_rx = {};
> +	char data = '\0';
> +	struct iovec io = {
> +		.iov_base = &data,
> +		.iov_len = sizeof(data),
> +	};
> +	struct msghdr msg = {
> +		.msg_iov = &io,
> +		.msg_iovlen = 1,
> +		.msg_control = &cmsg_rx.buf,
> +		.msg_controllen = sizeof(cmsg_rx.buf),
> +	};
> +	struct cmsghdr *cmsg;
> +	int res;
> +
> +	res = recvmsg(usock, &msg, MSG_CMSG_CLOEXEC);
> +	if (res < 0)
> +		return -1;

It could be useful to return -errno for recv_fd() and send_fd(), and 
update the description accordingly. That would enable to quickly know 
the error with the ASSERT_*() calls.


> +
> +	cmsg = CMSG_FIRSTHDR(&msg);
> +	if (cmsg->cmsg_len != CMSG_LEN(sizeof(fd_rx)))
> +		return -1;
> +
> +	memcpy(&fd_rx, CMSG_DATA(cmsg), sizeof(fd_rx));
> +	return fd_rx;
> +}
> +
> +/* Sends an FD on a UNIX socket. Returns 0 on success or -1 on error. */
> +static int __maybe_unused send_fd(int usock, int fd_tx)
> +{
> +	union {
> +		/* Aligned ancillary data buffer. */
> +		char buf[CMSG_SPACE(sizeof(fd_tx))];
> +		struct cmsghdr _align;
> +	} cmsg_tx = {};
> +	char data_tx = '.';
> +	struct iovec io = {
> +		.iov_base = &data_tx,
> +		.iov_len = sizeof(data_tx),
> +	};
> +	struct msghdr msg = {
> +		.msg_iov = &io,
> +		.msg_iovlen = 1,
> +		.msg_control = &cmsg_tx.buf,
> +		.msg_controllen = sizeof(cmsg_tx.buf),
> +	};
> +	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
> +
> +	cmsg->cmsg_len = CMSG_LEN(sizeof(fd_tx));
> +	cmsg->cmsg_level = SOL_SOCKET;
> +	cmsg->cmsg_type = SCM_RIGHTS;
> +	memcpy(CMSG_DATA(cmsg), &fd_tx, sizeof(fd_tx));
> +
> +	if (sendmsg(usock, &msg, 0) < 0)
> +		return -1;
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 308f6f36e8c0..93ed80a25a74 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -3541,6 +3541,68 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
>   	}
>   }
>   
> +TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
> +{
> +	int child, fd, status;
> +	int socket_fds[2];
> +
> +	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0,
> +				socket_fds));
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		/*
> +		 * Enable Landlock in the child process, open a file descriptor

"Enables"…


> +		 * where truncation is forbidden and send it to the
> +		 * non-landlocked parent process.
> +		 */
> +		const char *const path = file1_s1d1;
> +		const struct rule rules[] = {
> +			{
> +				.path = path,
> +				.access = variant->permitted,
> +			},
> +			{},
> +		};
> +		int fd, ruleset_fd;
> +
> +		/* Enable Landlock. */

This comment is not necessary.


> +		ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
> +		ASSERT_LE(0, ruleset_fd);
> +		enforce_ruleset(_metadata, ruleset_fd);
> +		ASSERT_EQ(0, close(ruleset_fd));
> +
> +		fd = open(path, O_WRONLY);
> +		ASSERT_EQ(variant->expected_open_result, (fd < 0 ? errno : 0));
> +
> +		if (fd >= 0) {
> +			ASSERT_EQ(0, send_fd(socket_fds[0], fd));
> +			ASSERT_EQ(0, close(fd));
> +		}
> +
> +		ASSERT_EQ(0, close(socket_fds[0]));
> +
> +		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);

You might want to add a "return" here to help the compiler (and the reader).


> +	}
> +
> +	if (variant->expected_open_result == 0) {
> +		fd = recv_fd(socket_fds[1]);
> +		ASSERT_LE(0, fd);
> +
> +		EXPECT_EQ(variant->expected_ftruncate_result,
> +			  test_ftruncate(fd));
> +		ASSERT_EQ(0, close(fd));
> +	}
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	ASSERT_EQ(1, WIFEXITED(status));
> +	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
> +
> +	ASSERT_EQ(0, close(socket_fds[0]));
> +	ASSERT_EQ(0, close(socket_fds[1]));
> +}
> +
>   /* clang-format off */
>   FIXTURE(layout1_bind) {};
>   /* clang-format on */
