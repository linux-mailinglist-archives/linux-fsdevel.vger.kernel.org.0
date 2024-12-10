Return-Path: <linux-fsdevel+bounces-36947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A3F9EB387
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 15:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F74E2811A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5411B21A0;
	Tue, 10 Dec 2024 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+kfIN9f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D291A704C;
	Tue, 10 Dec 2024 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841456; cv=none; b=hLiG4w17I52nc9TYG1FP3e2p1GZ4M9kr7igtK1/D0d2t3hc655j4HbQrVEzQH0tyLdq6wdjC1UzdLDJoQx408fntA+8UgbkhLSRaLktsF7Yo0OKf3s9meUc07n5+AF9hGezl5+msOjuuVfNBkHsSI2aNx4j/Qofh5dmEnZzac6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841456; c=relaxed/simple;
	bh=FWcePg+GluBvZ898xyCFwEYhWE6m0NH3BK+Gv6nnVrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBKGpCUrBqWYrj9j8Af7KtMcjA+rZI+0lAl079DTkG+tw1bcgoLCSXKWJuJEfg+6egsv+4ZieYQHI+nc7gDcsImtmTIeRxMDj0ZnNPznOYnfc+CvxQTvstcJjTnTAWbclHvvU/59BetpYW7/2TCIruEEFOVHw8Pn1sQuG+JwYbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+kfIN9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B460BC4CED6;
	Tue, 10 Dec 2024 14:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733841456;
	bh=FWcePg+GluBvZ898xyCFwEYhWE6m0NH3BK+Gv6nnVrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+kfIN9fKGsk6iD9RaeSr967r8KqlMYqMYpLr7K6ihvn41ALkpw55iJnIfrD3dG4u
	 53rCJTchn4qqt2ZgLdqG9+8V9ys0c704sJJYEBm2LhCi/yIhrN+TTw1I942/y1PqQD
	 KQKp9+ePJ9YRb4iJTpA+qaeR9bsloGIwfHur03isFwqoeDotWxHLKwjvjpI8Ihbafz
	 0Eo98Y25lSanLSFLN4j+4BTlqeAc6exdqtMfg2/0ah/sp0kGGRTBDkOZMqksLE9JaI
	 7w6nZ5JOUfDZM5CLL/WJzIxDJJdGggRmK9wTNTpbgeYajmPV3ZipHZAA1r9AX6fhv/
	 Y5DelZKv718mA==
Date: Tue, 10 Dec 2024 15:37:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 2/5] selftests/bpf: Add tests for open-coded
 style process file iterator
Message-ID: <20241210-zustehen-skilift-44ba2f53ceca@brauner>
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080756ABBCCCBF664B374EB993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR03MB5080756ABBCCCBF664B374EB993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>

On Tue, Dec 10, 2024 at 02:03:51PM +0000, Juntong Deng wrote:
> This patch adds test cases for open-coded style process file iterator.
> 
> Test cases related to process files are run in the newly created child
> process. Close all opened files inherited from the parent process in
> the child process to avoid the files opened by the parent process
> affecting the test results.
> 
> In addition, this patch adds failure test cases where bpf programs
> cannot pass the verifier due to uninitialized or untrusted
> arguments, or not in RCU CS, etc.
> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  .../testing/selftests/bpf/bpf_experimental.h  |   7 ++
>  .../testing/selftests/bpf/prog_tests/iters.c  |  79 ++++++++++++
>  .../selftests/bpf/progs/iters_task_file.c     |  88 ++++++++++++++
>  .../bpf/progs/iters_task_file_failure.c       | 114 ++++++++++++++++++
>  4 files changed, 288 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file.c
>  create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file_failure.c
> 
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index cd8ecd39c3f3..ce1520c56b55 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -588,4 +588,11 @@ extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it) __weak __ksym
>  extern struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_cache *it) __weak __ksym;
>  extern void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it) __weak __ksym;
>  
> +struct bpf_iter_task_file;
> +struct bpf_iter_task_file_item;
> +extern int bpf_iter_task_file_new(struct bpf_iter_task_file *it, struct task_struct *task) __ksym;
> +extern struct bpf_iter_task_file_item *
> +bpf_iter_task_file_next(struct bpf_iter_task_file *it) __ksym;
> +extern void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it) __ksym;
> +
>  #endif
> diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
> index 3cea71f9c500..cfe5b56cc027 100644
> --- a/tools/testing/selftests/bpf/prog_tests/iters.c
> +++ b/tools/testing/selftests/bpf/prog_tests/iters.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>  
> +#define _GNU_SOURCE
> +#include <sys/socket.h>
>  #include <sys/syscall.h>
>  #include <sys/mman.h>
>  #include <sys/wait.h>
> @@ -16,11 +18,13 @@
>  #include "iters_num.skel.h"
>  #include "iters_testmod.skel.h"
>  #include "iters_testmod_seq.skel.h"
> +#include "iters_task_file.skel.h"
>  #include "iters_task_vma.skel.h"
>  #include "iters_task.skel.h"
>  #include "iters_css_task.skel.h"
>  #include "iters_css.skel.h"
>  #include "iters_task_failure.skel.h"
> +#include "iters_task_file_failure.skel.h"
>  
>  static void subtest_num_iters(void)
>  {
> @@ -291,6 +295,78 @@ static void subtest_css_iters(void)
>  	iters_css__destroy(skel);
>  }
>  
> +static int task_file_test_process(void *args)
> +{
> +	int pipefd[2], sockfd, err = 0;
> +
> +	/* Create a clean file descriptor table for the test process */
> +	close_range(0, ~0U, 0);
> +
> +	if (pipe(pipefd) < 0)
> +		return 1;
> +
> +	sockfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> +	if (sockfd < 0) {
> +		err = 2;
> +		goto cleanup_pipe;
> +	}
> +
> +	usleep(1);
> +
> +	close(sockfd);
> +cleanup_pipe:
> +	close(pipefd[0]);
> +	close(pipefd[1]);
> +	return err;
> +}
> +
> +static void subtest_task_file_iters(void)
> +{
> +	const int stack_size = 1024 * 1024;
> +	struct iters_task_file *skel;
> +	int child_pid, wstatus, err;
> +	char *stack;
> +
> +	skel = iters_task_file__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	if (!ASSERT_OK(skel->bss->err, "pre_test_err"))
> +		goto cleanup_skel;
> +
> +	skel->bss->parent_pid = getpid();
> +	skel->bss->count = 0;
> +
> +	err = iters_task_file__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto cleanup_skel;
> +
> +	stack = (char *)malloc(stack_size);
> +	if (!ASSERT_OK_PTR(stack, "clone_stack"))
> +		goto cleanup_attach;
> +
> +	/* Note that there is no CLONE_FILES */
> +	child_pid = clone(task_file_test_process, stack + stack_size, CLONE_VM | SIGCHLD, NULL);
> +	if (!ASSERT_GT(child_pid, -1, "child_pid"))
> +		goto cleanup_stack;
> +
> +	if (!ASSERT_GT(waitpid(child_pid, &wstatus, 0), -1, "waitpid"))
> +		goto cleanup_stack;
> +
> +	if (!ASSERT_OK(WEXITSTATUS(wstatus), "run_task_file_iters_test_err"))
> +		goto cleanup_stack;
> +
> +	ASSERT_EQ(skel->bss->count, 1, "run_task_file_iters_test_count_err");
> +	ASSERT_OK(skel->bss->err, "run_task_file_iters_test_failure");
> +
> +cleanup_stack:
> +	free(stack);
> +cleanup_attach:
> +	iters_task_file__detach(skel);
> +cleanup_skel:
> +	iters_task_file__destroy(skel);
> +}
> +
>  void test_iters(void)
>  {
>  	RUN_TESTS(iters_state_safety);
> @@ -315,5 +391,8 @@ void test_iters(void)
>  		subtest_css_task_iters();
>  	if (test__start_subtest("css"))
>  		subtest_css_iters();
> +	if (test__start_subtest("task_file"))
> +		subtest_task_file_iters();
>  	RUN_TESTS(iters_task_failure);
> +	RUN_TESTS(iters_task_file_failure);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/iters_task_file.c b/tools/testing/selftests/bpf/progs/iters_task_file.c
> new file mode 100644
> index 000000000000..81bcd20041d8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/iters_task_file.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +#include "bpf_experimental.h"
> +#include "task_kfunc_common.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int err, parent_pid, count;
> +
> +extern const void pipefifo_fops __ksym;
> +extern const void socket_file_ops __ksym;
> +
> +SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> +int test_bpf_iter_task_file(void *ctx)
> +{
> +	struct bpf_iter_task_file task_file_it;
> +	struct bpf_iter_task_file_item *item;
> +	struct task_struct *task;
> +
> +	task = bpf_get_current_task_btf();
> +	if (task->parent->pid != parent_pid)
> +		return 0;
> +
> +	count++;
> +
> +	bpf_rcu_read_lock();

What does the RCU read lock do here exactly?

> +	bpf_iter_task_file_new(&task_file_it, task);
> +
> +	item = bpf_iter_task_file_next(&task_file_it);
> +	if (item == NULL) {
> +		err = 1;
> +		goto cleanup;
> +	}
> +
> +	if (item->fd != 0) {
> +		err = 2;
> +		goto cleanup;
> +	}
> +
> +	if (item->file->f_op != &pipefifo_fops) {
> +		err = 3;
> +		goto cleanup;
> +	}
> +
> +	item = bpf_iter_task_file_next(&task_file_it);
> +	if (item == NULL) {
> +		err = 4;
> +		goto cleanup;
> +	}
> +
> +	if (item->fd != 1) {
> +		err = 5;
> +		goto cleanup;
> +	}
> +
> +	if (item->file->f_op != &pipefifo_fops) {
> +		err = 6;
> +		goto cleanup;
> +	}
> +
> +	item = bpf_iter_task_file_next(&task_file_it);
> +	if (item == NULL) {
> +		err = 7;
> +		goto cleanup;
> +	}
> +
> +	if (item->fd != 2) {
> +		err = 8;
> +		goto cleanup;
> +	}
> +
> +	if (item->file->f_op != &socket_file_ops) {
> +		err = 9;
> +		goto cleanup;
> +	}
> +
> +	item = bpf_iter_task_file_next(&task_file_it);
> +	if (item != NULL)
> +		err = 10;
> +cleanup:
> +	bpf_iter_task_file_destroy(&task_file_it);
> +	bpf_rcu_read_unlock();
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/iters_task_file_failure.c b/tools/testing/selftests/bpf/progs/iters_task_file_failure.c
> new file mode 100644
> index 000000000000..c3de9235b888
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/iters_task_file_failure.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +#include "bpf_experimental.h"
> +#include "task_kfunc_common.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("syscall")
> +__failure __msg("expected an RCU CS when using bpf_iter_task_file")
> +int bpf_iter_task_file_new_without_rcu_lock(void *ctx)
> +{
> +	struct bpf_iter_task_file task_file_it;
> +	struct task_struct *task;
> +
> +	task = bpf_get_current_task_btf();
> +
> +	bpf_iter_task_file_new(&task_file_it, task);
> +
> +	bpf_iter_task_file_destroy(&task_file_it);
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__failure __msg("expected uninitialized iter_task_file as arg #1")
> +int bpf_iter_task_file_new_inited_iter(void *ctx)
> +{
> +	struct bpf_iter_task_file task_file_it;
> +	struct task_struct *task;
> +
> +	task = bpf_get_current_task_btf();
> +
> +	bpf_rcu_read_lock();
> +	bpf_iter_task_file_new(&task_file_it, task);
> +
> +	bpf_iter_task_file_new(&task_file_it, task);
> +
> +	bpf_iter_task_file_destroy(&task_file_it);
> +	bpf_rcu_read_unlock();
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__failure __msg("Possibly NULL pointer passed to trusted arg1")
> +int bpf_iter_task_file_new_null_task(void *ctx)
> +{
> +	struct bpf_iter_task_file task_file_it;
> +	struct task_struct *task = NULL;
> +
> +	bpf_rcu_read_lock();
> +	bpf_iter_task_file_new(&task_file_it, task);
> +
> +	bpf_iter_task_file_destroy(&task_file_it);
> +	bpf_rcu_read_unlock();
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__failure __msg("R2 must be referenced or trusted")
> +int bpf_iter_task_file_new_untrusted_task(void *ctx)
> +{
> +	struct bpf_iter_task_file task_file_it;
> +	struct task_struct *task;
> +
> +	task = bpf_get_current_task_btf()->parent;
> +
> +	bpf_rcu_read_lock();
> +	bpf_iter_task_file_new(&task_file_it, task);
> +
> +	bpf_iter_task_file_destroy(&task_file_it);
> +	bpf_rcu_read_unlock();
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__failure __msg("Unreleased reference")
> +int bpf_iter_task_file_no_destory(void *ctx)
> +{
> +	struct bpf_iter_task_file task_file_it;
> +	struct task_struct *task;
> +
> +	task = bpf_get_current_task_btf();
> +
> +	bpf_rcu_read_lock();
> +	bpf_iter_task_file_new(&task_file_it, task);
> +
> +	bpf_rcu_read_unlock();
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__failure __msg("expected an initialized iter_task_file as arg #1")
> +int bpf_iter_task_file_next_uninit_iter(void *ctx)
> +{
> +	struct bpf_iter_task_file task_file_it;
> +
> +	bpf_iter_task_file_next(&task_file_it);
> +
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__failure __msg("expected an initialized iter_task_file as arg #1")
> +int bpf_iter_task_file_destroy_uninit_iter(void *ctx)
> +{
> +	struct bpf_iter_task_file task_file_it;
> +
> +	bpf_iter_task_file_destroy(&task_file_it);
> +
> +	return 0;
> +}
> -- 
> 2.39.5
> 

