Return-Path: <linux-fsdevel+bounces-35316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 748269D3988
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 12:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B51B3B248FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F87B19F41D;
	Wed, 20 Nov 2024 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMN4vY8N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F64017F7;
	Wed, 20 Nov 2024 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732102035; cv=none; b=fRXtUG5PVR6Wn/aoN3Ild/hf2gk7NrlXVODh4ngp1oSX6DVorQcTUuZllXfKaOskCE+gLiN9l2LuJHQ0d0z+u9OZzW6iizypJvG4LNcgAt1F/M6RCrOa7E2VAgaeq9MdMH9NQ0p82PIuZF/eKAFj/2W9Gwh4CZgEFR10UYfwsSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732102035; c=relaxed/simple;
	bh=fVB4sr8myBLJfYa/IzdwTPu1bY0trgjDwP3f1ZEQIgw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuWNLK8JikxqDei7a4Xu5TcVLinAvGNexpPU/bgDD4DHZyirVsb++Wupq1jDPVWkjS37Hwb1utusn2O2UDbhMymfN2xGyQ7R1cUTFXs1P0v/eyvvZbgQxIHYLAcaRhqJb+bE2qiJFZEvebSEm/HEVRk2sEqjs/n6AOlAGsv6Zok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMN4vY8N; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539fb49c64aso6516741e87.0;
        Wed, 20 Nov 2024 03:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732102032; x=1732706832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rUh3ZOg3iDk8G6w3pqn8/RhHpLtFzbMtwdyDsuIciPI=;
        b=cMN4vY8Nygb50OCDbYnjnEWaieuQ1f2n4aIgghOulZ2RcQn/fdQK6dwzgs/OA03jEo
         SXrhRa80WzUuk83kR+lh8VyFKYlt3SYL0gS+RhYfA4DE3n1IgqXEJkhyUPkSKe/znr0d
         dykHMw02QMDCIt2nOQjyuk6uLZfBoMUZU3v0oj0RcFVgVHdyCB7LCqUEqfUks5Nx4c0v
         0WcnJ5gZg9CGvGhlczKF8S78PSiPd+CkpsSeHXUVFOnPobDXIJlwBttX4TBSPDmWTYZh
         b3XPigvP0vQzLGveUNzJ4k9jtLB60UOEDWjCeqhDwNCOOlUiFqOqxYRCqhBbK80Ho2k6
         6tZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732102032; x=1732706832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUh3ZOg3iDk8G6w3pqn8/RhHpLtFzbMtwdyDsuIciPI=;
        b=f24+B4dIuKQ8SmODbhczVSZERbMRlhCfTyVe2tEKVAdgAQ/k3hfn4OWkYrZNf4xGRY
         DMi7V9PUaUGb+2mZoq2s22UPc/yOc64Ju+/o9UA43XSwXh3XIPzvKBwQRFDQRHkq/7pX
         efUV1g0LwRrJWCffpdVs1tctaY6vE4gPhrYyaj6hGHpVNTGaOTge3SqkDsrfAHLPJBbh
         4Wewrk+KvnJU4GgVSgAdEJ7xKc34SOf2B6mo8nl1YRmltrIe3wVfwFlUfNp94dT8toNE
         eamlxGs3Vg2GwMkMB69sMUsqud/eMwW1URZiSWnJqZ1cZyQ4J4FX8XcbIwRDN5Kt9qo+
         SBQw==
X-Forwarded-Encrypted: i=1; AJvYcCVlYq0lVE8ClwAAqg2jXx71E+wjek+5qMIQH7wb7VzIKQEq6ACgtqKwPkW/EKbrmwl4Vo8=@vger.kernel.org, AJvYcCWC2QzpU5tad2EFhnAIGVgjAafPDys/6DxrCwfU2bVSk5rWEdT69KmB9Gj4sKsexQ9AqGUJRJhgQ8JKow1D1w==@vger.kernel.org, AJvYcCXxP3XpzGOxXjIOs2iK1+B54ZeTcQZfz0ZF28+2264PzgnZeCGcQuVr8eb8+D5O1nmQJw46GR/0Zl9BvZRe@vger.kernel.org
X-Gm-Message-State: AOJu0YwITN45GtN8LPloSWecNyM5/Wfs3i21sOxqPDojEBKJTjmiXKsB
	3/JhTGQGdvZdfJTip/MVH0cewRS167GUthqStrkmIdaGb2lV+dag
X-Google-Smtp-Source: AGHT+IHituqktcw2a5659hU+lBMZQPvuukb41r3FxWGAWIW3IDgdH+qj/R2pgA4KWG97hyx1Fs046A==
X-Received: by 2002:a05:6512:a8e:b0:53d:a0a7:1a8d with SMTP id 2adb3069b0e04-53dc136377amr1710493e87.46.1732102031388;
        Wed, 20 Nov 2024 03:27:11 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df571a1sm760119766b.80.2024.11.20.03.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:27:11 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 20 Nov 2024 12:27:09 +0100
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, memxor@gmail.com,
	snorcht@gmail.com, brauner@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/5] selftests/bpf: Add tests for open-coded
 style process file iterator
Message-ID: <Zz3HjT24glXY-8AF@krava>
References: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50809E5CD1B8DE0225A85B6B99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB50809E5CD1B8DE0225A85B6B99202@AM6PR03MB5080.eurprd03.prod.outlook.com>

On Tue, Nov 19, 2024 at 05:53:59PM +0000, Juntong Deng wrote:

SNIP

> +static void subtest_task_file_iters(void)
> +{
> +	int prog_fd, child_pid, wstatus, err = 0;
> +	const int stack_size = 1024 * 1024;
> +	struct iters_task_file *skel;
> +	struct files_test_args args;
> +	struct bpf_program *prog;
> +	bool setup_end, test_end;
> +	char *stack;
> +
> +	skel = iters_task_file__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	if (!ASSERT_OK(skel->bss->err, "pre_test_err"))
> +		goto cleanup_skel;
> +
> +	prog = bpf_object__find_program_by_name(skel->obj, "test_bpf_iter_task_file");
> +	if (!ASSERT_OK_PTR(prog, "find_program_by_name"))
> +		goto cleanup_skel;
> +
> +	prog_fd = bpf_program__fd(prog);
> +	if (!ASSERT_GT(prog_fd, -1, "bpf_program__fd"))
> +		goto cleanup_skel;

I don't think you need to check on this once we did iters_task_file__open_and_load 

> +
> +	stack = (char *)malloc(stack_size);
> +	if (!ASSERT_OK_PTR(stack, "clone_stack"))
> +		goto cleanup_skel;
> +
> +	setup_end = false;
> +	test_end = false;
> +
> +	args.setup_end = &setup_end;
> +	args.test_end = &test_end;
> +
> +	/* Note that there is no CLONE_FILES */
> +	child_pid = clone(task_file_test_process, stack + stack_size, CLONE_VM | SIGCHLD, &args);
> +	if (!ASSERT_GT(child_pid, -1, "child_pid"))
> +		goto cleanup_stack;
> +
> +	while (!setup_end)
> +		;

I thin kthe preferred way is to synchronize through pipe,
you can check prog_tests/uprobe_multi_test.c

> +
> +	skel->bss->pid = child_pid;
> +
> +	err = bpf_prog_test_run_opts(prog_fd, NULL);
> +	if (!ASSERT_OK(err, "prog_test_run"))
> +		goto cleanup_stack;
> +
> +	test_end = true;
> +
> +	if (!ASSERT_GT(waitpid(child_pid, &wstatus, 0), -1, "waitpid"))
> +		goto cleanup_stack;
> +
> +	if (!ASSERT_OK(WEXITSTATUS(wstatus), "run_task_file_iters_test_err"))
> +		goto cleanup_stack;
> +
> +	ASSERT_OK(skel->bss->err, "run_task_file_iters_test_failure");

could the test check on that the iterated files were (or contained) the ones we expected?

thanks,
jirka


> +cleanup_stack:
> +	free(stack);
> +cleanup_skel:
> +	iters_task_file__destroy(skel);
> +}
> +
>  void test_iters(void)
>  {
>  	RUN_TESTS(iters_state_safety);
> @@ -315,5 +417,8 @@ void test_iters(void)
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
> index 000000000000..f14b473936c7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/iters_task_file.c
> @@ -0,0 +1,71 @@
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
> +int err, pid;
> +
> +SEC("syscall")
> +int test_bpf_iter_task_file(void *ctx)
> +{
> +	struct bpf_iter_task_file task_file_it;
> +	struct bpf_iter_task_file_item *item;
> +	struct task_struct *task;
> +
> +	task = bpf_task_from_vpid(pid);
> +	if (task == NULL) {
> +		err = 1;
> +		return 0;
> +	}
> +
> +	bpf_rcu_read_lock();
> +	bpf_iter_task_file_new(&task_file_it, task);
> +
> +	item = bpf_iter_task_file_next(&task_file_it);
> +	if (item == NULL) {
> +		err = 2;
> +		goto cleanup;
> +	}
> +
> +	if (item->fd != 0) {
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
> +	item = bpf_iter_task_file_next(&task_file_it);
> +	if (item == NULL) {
> +		err = 6;
> +		goto cleanup;
> +	}
> +
> +	if (item->fd != 2) {
> +		err = 7;
> +		goto cleanup;
> +	}
> +
> +	item = bpf_iter_task_file_next(&task_file_it);
> +	if (item != NULL)
> +		err = 8;
> +cleanup:
> +	bpf_iter_task_file_destroy(&task_file_it);
> +	bpf_rcu_read_unlock();
> +	bpf_task_release(task);
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

