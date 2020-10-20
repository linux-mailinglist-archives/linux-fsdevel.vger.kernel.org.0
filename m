Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77AF293EC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 16:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408128AbgJTOcN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 10:32:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48168 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbgJTOcN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:32:13 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kUsgN-0000qz-BC; Tue, 20 Oct 2020 14:32:11 +0000
Date:   Tue, 20 Oct 2020 16:32:10 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux@rasmusvillemoes.dk,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 2/2] selftests: add tests for CLOSE_RANGE_CLOEXEC
Message-ID: <20201020143210.uwwdinaj45iom4oi@wittgenstein>
References: <20201019102654.16642-1-gscrivan@redhat.com>
 <20201019102654.16642-3-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019102654.16642-3-gscrivan@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

First, thank you for the selftests. That's great to see!

Could you please add a short explanation what you're testing here to the
commit message?

On Mon, Oct 19, 2020 at 12:26:54PM +0200, Giuseppe Scrivano wrote:
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
>  .../testing/selftests/core/close_range_test.c | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
> index c99b98b0d461..c9db282158bb 100644
> --- a/tools/testing/selftests/core/close_range_test.c
> +++ b/tools/testing/selftests/core/close_range_test.c
> @@ -11,6 +11,7 @@
>  #include <string.h>
>  #include <syscall.h>
>  #include <unistd.h>
> +#include <sys/resource.h>
>  
>  #include "../kselftest_harness.h"
>  #include "../clone3/clone3_selftests.h"
> @@ -23,6 +24,10 @@
>  #define CLOSE_RANGE_UNSHARE	(1U << 1)
>  #endif
>  
> +#ifndef CLOSE_RANGE_CLOEXEC
> +#define CLOSE_RANGE_CLOEXEC	(1U << 2)
> +#endif
> +
>  static inline int sys_close_range(unsigned int fd, unsigned int max_fd,
>  				  unsigned int flags)
>  {
> @@ -224,4 +229,73 @@ TEST(close_range_unshare_capped)
>  	EXPECT_EQ(0, WEXITSTATUS(status));
>  }
>  
> +TEST(close_range_cloexec)
> +{
> +	int i, ret;
> +	int open_fds[101];
> +	struct rlimit rlimit;
> +
> +	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
> +		int fd;
> +
> +		fd = open("/dev/null", O_RDONLY);
> +		ASSERT_GE(fd, 0) {
> +			if (errno == ENOENT)
> +				XFAIL(return, "Skipping test since /dev/null does not exist");
> +		}
> +
> +		open_fds[i] = fd;
> +	}
> +
> +	ret = sys_close_range(1000, 1000, CLOSE_RANGE_CLOEXEC);
> +	if (ret < 0) {
> +		if (errno == ENOSYS)
> +			XFAIL(return, "close_range() syscall not supported");
> +		if (errno == EINVAL)
> +			XFAIL(return, "close_range() doesn't support CLOSE_RANGE_CLOEXEC");
> +	}
> +
> +	/* Ensure the FD_CLOEXEC bit is set also with a resource limit in place.  */
> +	EXPECT_EQ(0, getrlimit(RLIMIT_NOFILE, &rlimit));
> +	rlimit.rlim_cur = 25;
> +	EXPECT_EQ(0, setrlimit(RLIMIT_NOFILE, &rlimit));

I usually prefer to call ASSERT_* to abort at the first true failure
before moving on. And I think all the EXPECT_*()s here should be
ASSERT_*()s because that are all hard failures imho.

Apart from that this looks good.

> +
> +	/* Set close-on-exec for two ranges: [0-50] and [75-100].  */
> +	ret = sys_close_range(open_fds[0], open_fds[50], CLOSE_RANGE_CLOEXEC);
> +	EXPECT_EQ(0, ret);
> +	ret = sys_close_range(open_fds[75], open_fds[100], CLOSE_RANGE_CLOEXEC);
> +	EXPECT_EQ(0, ret);
> +
> +	for (i = 0; i <= 50; i++) {
> +		int flags = fcntl(open_fds[i], F_GETFD);
> +
> +		EXPECT_GT(flags, -1);
> +		EXPECT_EQ(flags & FD_CLOEXEC, FD_CLOEXEC);
> +	}
> +
> +	for (i = 51; i <= 74; i++) {
> +		int flags = fcntl(open_fds[i], F_GETFD);
> +
> +		EXPECT_GT(flags, -1);
> +		EXPECT_EQ(flags & FD_CLOEXEC, 0);
> +	}
> +
> +	for (i = 75; i <= 100; i++) {
> +		int flags = fcntl(open_fds[i], F_GETFD);
> +
> +		EXPECT_GT(flags, -1);
> +		EXPECT_EQ(flags & FD_CLOEXEC, FD_CLOEXEC);
> +	}
> +
> +	/* Test a common pattern.  */
> +	ret = sys_close_range(3, UINT_MAX, CLOSE_RANGE_CLOEXEC);
> +	for (i = 0; i <= 100; i++) {
> +		int flags = fcntl(open_fds[i], F_GETFD);
> +
> +		EXPECT_GT(flags, -1);
> +		EXPECT_EQ(flags & FD_CLOEXEC, FD_CLOEXEC);
> +	}
> +}
> +
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.26.2
> 
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers
