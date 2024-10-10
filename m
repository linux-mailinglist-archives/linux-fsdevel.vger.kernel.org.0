Return-Path: <linux-fsdevel+bounces-31645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D499995A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 01:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78FF1F23D3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 23:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1DD1E6DD4;
	Thu, 10 Oct 2024 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FI30Cdod"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E9D18DF81
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728602187; cv=none; b=eWh/XosfLXeY5mv9/bP5uh/Y+a5H+Q89eu/33M+/qVceBLv2n48DPcBIRdsC9XA+78wlNGSkyShYNzHm46L9MUgnDWvZmORLVhVHF6G0fGLvavKoxyFXTO79xgRo68tpUPDnpw2cnphcmnJ/BxTLgOLoCQVzYrbvr6F+Et2JZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728602187; c=relaxed/simple;
	bh=KvTHna+ZtApDPOmd2a40igweP/Dy8M0dpMij23VQIYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oW39aXlEyjCLwXqIQeD0mjV2/7Bhqv5xQDM0ezEuwRAET+uL30qOTOQVW+/ENshYBcl2xHWfdcX7g/fDdVEqRaV3sS+LRyQ1YcVf8m8t49epQJRqKVGx2repuAZO5AqlzFmTjo4v+HhkEbmxyDvKYNwjZJpymzI0tMnr0W9QX1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FI30Cdod; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-835453714cfso64367339f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 16:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728602184; x=1729206984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MjTbqXkgY8LUStOR5rf/WpaxQMK/Kx6NjYvjTVOb6hc=;
        b=FI30CdodrY/KFtsa4CUr5RKJyO2qtLJ1FU/+aMOnWzLx6zCsqEPGQG2OyntXZ+EUSF
         KTO/KhGXpBilXGJfUQlcnwDy2CHeQcfVVKqy4M2MsGwR9kDoYvBPU32XBIuqNsebYCUw
         k4K8rJ5+mPT/jhX2Py6Xf6cwb7FRK7qpEF6dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728602184; x=1729206984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MjTbqXkgY8LUStOR5rf/WpaxQMK/Kx6NjYvjTVOb6hc=;
        b=A23VRYGRXQrUKuPZ7cgnNLvjL1eNF63Cy5rla0kOkMr22yDeUqmfK+2FJt4z2+fWR0
         dsddVffXJjRvF8eeqflUdW09Ofazkl6zzgqHvM9MFE3sNGGvIBTlhyVCGRvq4kkpK0P9
         PISyufh173Q8/F2Bsl+oO39oQw1shRWWulEOXcsfLpnImV0W0SeEW6stB20Lhjog4DG1
         laPnc43KKEYrHjMFhGN754TSGG47XGdftPbZHo8lAYgQTzhSpi0Ycq6MFi+gpm8UoosN
         jwbslNKiJU2mjSGTueOlPWTxYiaPxY0efMMXv4uh2uimmT/A+ZAV2LTgOfGsdGKrXVqm
         1cSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXjxDy1MWCLJ/zhW+IJw3hgQ4TOkzyH7MIDjc0b9+mAOrJhlmNgE/y+e84pqYCVAvIJSco+jHsNnBVPOmq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwj0QYnzRJ/wnzgurmx6sIN5wyfZ/lJwmIougwjpEOxEpghbeR
	dQcHnvPg63Tq+EEYtl/u36ao/Paw3/iJd/mnh72Hg5YWGGc83DV+vFKHtl6ThX0=
X-Google-Smtp-Source: AGHT+IFlVbQGSILLXeO5nvykYOl8M4yjUO6AwPJGeeduUP5DYUvTqoxodwU5XfkR5e84yQ696UHUgw==
X-Received: by 2002:a05:6602:6413:b0:835:359b:8a07 with SMTP id ca18e2360f4ac-837952203bdmr45601839f.16.1728602183521;
        Thu, 10 Oct 2024 16:16:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8354b8dfcd1sm45225439f.3.2024.10.10.16.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 16:16:23 -0700 (PDT)
Message-ID: <1d1190be-f74f-45ab-ac6c-2251d0bec1bc@linuxfoundation.org>
Date: Thu, 10 Oct 2024 17:16:22 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1728578231.git.lorenzo.stoakes@oracle.com>
 <8917d809e1509c4e0bce02436a493db29e2115b3.1728578231.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <8917d809e1509c4e0bce02436a493db29e2115b3.1728578231.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 12:15, Lorenzo Stoakes wrote:
> Add tests to assert that PIDFD_SELF_* correctly refers to the current
> thread and process.
> 
> This is only practically meaningful to pidfd_send_signal() and
> pidfd_getfd(), but also explicitly test that we disallow this feature for
> setns() where it would make no sense.
> 
> We cannot reasonably wait on ourself using waitid(P_PIDFD, ...) so while in
> theory PIDFD_SELF_* would work here, we'd be left blocked if we tried it.
> 
> We defer testing of mm-specific functionality which uses pidfd, namely
> process_madvise() and process_mrelease() to mm testing (though note the
> latter can not be sensibly tested as it would require the testing process
> to be dying).
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   tools/testing/selftests/pidfd/pidfd.h         |   8 ++
>   .../selftests/pidfd/pidfd_getfd_test.c        | 136 ++++++++++++++++++
>   .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
>   tools/testing/selftests/pidfd/pidfd_test.c    |  67 +++++++--
>   4 files changed, 213 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> index 88d6830ee004..1640b711889b 100644
> --- a/tools/testing/selftests/pidfd/pidfd.h
> +++ b/tools/testing/selftests/pidfd/pidfd.h
> @@ -50,6 +50,14 @@
>   #define PIDFD_NONBLOCK O_NONBLOCK
>   #endif
>   
> +/* System header file may not have this available. */
> +#ifndef PIDFD_SELF_THREAD
> +#define PIDFD_SELF_THREAD -100
> +#endif
> +#ifndef PIDFD_SELF_THREAD_GROUP
> +#define PIDFD_SELF_THREAD_GROUP -200
> +#endif
> +

Can't we pick these up from linux/pidfd.h - patch 2/3 adds
them.

>   /*
>    * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
>    * That means, when it wraps around any pid < 300 will be skipped.
> diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
> index cd51d547b751..10793fc845ed 100644
> --- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
> @@ -6,6 +6,7 @@
>   #include <limits.h>
>   #include <linux/types.h>
>   #include <poll.h>
> +#include <pthread.h>
>   #include <sched.h>
>   #include <signal.h>
>   #include <stdio.h>
> @@ -15,6 +16,7 @@
>   #include <sys/prctl.h>
>   #include <sys/wait.h>
>   #include <unistd.h>
> +#include <sys/mman.h>
>   #include <sys/socket.h>
>   #include <linux/kcmp.h>
>   
> @@ -114,6 +116,89 @@ static int child(int sk)
>   	return ret;
>   }
>   
> +static int __pidfd_self_thread_worker(unsigned long page_size)
> +{
> +	int memfd;
> +	int newfd;
> +	char *ptr;
> +	int ret = 0;
> +
> +	/*
> +	 * Unshare our FDs so we have our own set. This means
> +	 * PIDFD_SELF_THREAD_GROUP will fail.
> +	 */
> +	if (unshare(CLONE_FILES) < 0) {
> +		ret = -errno;
> +		goto exit;
> +	}
> +
> +	/* Truncate, map in and write to our memfd. */
> +	memfd = sys_memfd_create("test_self_child", 0);

Missing eror check.

> +	if (ftruncate(memfd, page_size)) {
> +		ret = -errno;
> +		goto exit;

Hmm. you probably need scoped cleanup paths. "exit" closes
memfd and newfd which isn't open yet and sys_memfd_create()
could fail and memfd doesn't need closing?

> +	}
> +
> +	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> +		   MAP_SHARED, memfd, 0);
> +	if (ptr == MAP_FAILED) {
> +		ret = -errno;
> +		goto exit;
> +	}
> +	ptr[0] = 'y';
> +	if (munmap(ptr, page_size)) {
> +		ret = -errno;
> +		goto exit;
> +	}
> +
> +	/* Get a thread-local duplicate of our memfd. */
> +	newfd = sys_pidfd_getfd(PIDFD_SELF_THREAD, memfd, 0);
> +	if (newfd < 0) {
> +		ret = -errno;
> +		goto exit;

Same comment here - "exit" closes newfd

> +	}
> +
> +	if (memfd == newfd) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	/* Map in new fd and make sure that the data is as expected. */
> +	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> +		   MAP_SHARED, newfd, 0);
> +	if (ptr == MAP_FAILED) {
> +		ret = -errno;
> +		goto exit;
> +	}
> +
> +	if (ptr[0] != 'y') {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (munmap(ptr, page_size)) {
> +		ret = -errno;
> +		goto exit;
> +	}
> +
> +exit:
> +	/* Cleanup. */
> +	close(newfd);
> +	close(memfd);
> +
> +	return ret;
> +}
> +
> +static void *pidfd_self_thread_worker(void *arg)
> +{
> +	unsigned long page_size = (unsigned long)arg;
> +	int ret;
> +
> +	ret = __pidfd_self_thread_worker(page_size);

Don't you want to check error here?

> +
> +	return (void *)(intptr_t)ret;
> +}
> +
>   FIXTURE(child)
>   {
>   	/*
> @@ -264,6 +349,57 @@ TEST_F(child, no_strange_EBADF)
>   	EXPECT_EQ(errno, ESRCH);
>   }
>   
> +TEST(pidfd_self)
> +{
> +	int memfd = sys_memfd_create("test_self", 0);
> +	unsigned long page_size = sysconf(_SC_PAGESIZE);
> +	int newfd;
> +	char *ptr;
> +	pthread_t thread;
> +	void *res;
> +	int err;
> +
> +	ASSERT_GE(memfd, 0);
> +	ASSERT_EQ(ftruncate(memfd, page_size), 0);
> +
> +	/*
> +	 * Map so we can assert that the duplicated fd references the same
> +	 * memory.
> +	 */
> +	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> +		   MAP_SHARED, memfd, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +	ptr[0] = 'x';
> +	ASSERT_EQ(munmap(ptr, page_size), 0);
> +
> +	/* Now get a duplicate of our memfd. */
> +	newfd = sys_pidfd_getfd(PIDFD_SELF_THREAD_GROUP, memfd, 0);
> +	ASSERT_GE(newfd, 0);
> +	ASSERT_NE(memfd, newfd);
> +
> +	/* Now map duplicate fd and make sure it references the same memory. */
> +	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> +		   MAP_SHARED, newfd, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +	ASSERT_EQ(ptr[0], 'x');
> +	ASSERT_EQ(munmap(ptr, page_size), 0);
> +
> +	/* Cleanup. */
> +	close(memfd);
> +	close(newfd);
> +
> +	/*
> +	 * Fire up the thread and assert that we can lookup the thread-specific
> +	 * PIDFD_SELF_THREAD (also aliased by PIDFD_SELF).
> +	 */
> +	ASSERT_EQ(pthread_create(&thread, NULL, pidfd_self_thread_worker,
> +				 (void *)page_size), 0);
> +	ASSERT_EQ(pthread_join(thread, &res), 0);
> +	err = (int)(intptr_t)res;
> +
> +	ASSERT_EQ(err, 0);
> +}
> +
>   #if __NR_pidfd_getfd == -1
>   int main(void)
>   {
> diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
> index 7c2a4349170a..bbd39dc5ceb7 100644
> --- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
> @@ -752,4 +752,15 @@ TEST(setns_einval)
>   	close(fd);
>   }
>   
> +TEST(setns_pidfd_self_disallowed)
> +{
> +	ASSERT_EQ(setns(PIDFD_SELF_THREAD, 0), -1);
> +	EXPECT_EQ(errno, EBADF);
> +
> +	errno = 0;
> +
> +	ASSERT_EQ(setns(PIDFD_SELF_THREAD_GROUP, 0), -1);
> +	EXPECT_EQ(errno, EBADF);
> +}
> +
>   TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
> index 9faa686f90e4..ab5caa0368a1 100644
> --- a/tools/testing/selftests/pidfd/pidfd_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_test.c
> @@ -42,12 +42,41 @@ static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
>   #endif
>   }
>   
> -static int signal_received;
> +static pthread_t signal_received;
>   
>   static void set_signal_received_on_sigusr1(int sig)
>   {
>   	if (sig == SIGUSR1)
> -		signal_received = 1;
> +		signal_received = pthread_self();
> +}
> +
> +static int send_signal(int pidfd)
> +{
> +	int ret = 0;
> +
> +	if (sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0) < 0) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (signal_received != pthread_self()) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +exit:
> +	signal_received = 0;
> +	return ret;
> +}
> +
> +static void *send_signal_worker(void *arg)
> +{
> +	int pidfd = (int)(intptr_t)arg;
> +	int ret;
> +
> +	ret = send_signal(pidfd);
> +

Same here - don't you have to check ret?

> +	return (void *)(intptr_t)ret;
>   }
>   
>   /*
> @@ -56,8 +85,11 @@ static void set_signal_received_on_sigusr1(int sig)
>    */
>   static int test_pidfd_send_signal_simple_success(void)
>   {
> -	int pidfd, ret;
> +	int pidfd;
>   	const char *test_name = "pidfd_send_signal send SIGUSR1";
> +	pthread_t thread;
> +	void *thread_res;
> +	int res;
>   
>   	if (!have_pidfd_send_signal) {
>   		ksft_test_result_skip(
> @@ -74,17 +106,34 @@ static int test_pidfd_send_signal_simple_success(void)
>   
>   	signal(SIGUSR1, set_signal_received_on_sigusr1);
>   
> -	ret = sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0);
> +	send_signal(pidfd);
>   	close(pidfd);
> -	if (ret < 0)
> -		ksft_exit_fail_msg("%s test: Failed to send signal\n",
> +
> +	/* Now try the same thing only using PIDFD_SELF_THREAD_GROUP. */
> +	res = send_signal(PIDFD_SELF_THREAD_GROUP);
> +	if (res)
> +		ksft_exit_fail_msg(
> +			"%s test: Error %d on PIDFD_SELF_THREAD_GROUP signal\n",
> +			test_name, res);
> +
> +	/*
> +	 * Now try the same thing in a thread and assert thread ID is equal to
> +	 * worker thread ID.
> +	 */
> +	if (pthread_create(&thread, NULL, send_signal_worker,
> +			   (void *)(intptr_t)PIDFD_SELF_THREAD))
> +		ksft_exit_fail_msg("%s test: Failed to create thread\n",
>   				   test_name);
>   
> -	if (signal_received != 1)
> -		ksft_exit_fail_msg("%s test: Failed to receive signal\n",
> +	if (pthread_join(thread, &thread_res))
> +		ksft_exit_fail_msg("%s test: Failed to join thread\n",
>   				   test_name);
> +	res = (int)(intptr_t)thread_res;
> +	if (res)
> +		ksft_exit_fail_msg(
> +			"%s test: Error %d on PIDFD_SELF_THREAD signal\n",
> +			test_name, res);
>   
> -	signal_received = 0;
>   	ksft_test_result_pass("%s test: Sent signal\n", test_name);
>   	return 0;
>   }

thanks,
-- Shuah

