Return-Path: <linux-fsdevel+bounces-36949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C395E9EB3BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 15:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C1C284196
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6AA1B6544;
	Tue, 10 Dec 2024 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dko6LHmG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88321B2195;
	Tue, 10 Dec 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841882; cv=none; b=ONww7PadaafP5QDat766YEXl/4fP77nEJchTRLPJ+fw3MbF/lezhk6uGdYthLtNgXq59wh48LdQ5v2d/kgcS1Gh5lDnmNggoFgyCun6OK3xNXXfrKAaMQpi2eevnV7HE9bQVjOnwvfGiNmtD1W6GhHyr15afHbo4G+ICVtv1DCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841882; c=relaxed/simple;
	bh=p92MSmrg16W+AvmipmOqXkEVwVKuNWKW3EymIxk3aYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugFVeVI5HH4L2fMjYos0dMhONHe/vKxli8qX24aD5lEvLaM8aIysiYueGGt8MzQ/8aF6KvSMcjzBqd+fJkv29l5iX4Jjjpbm330YMpVJTZZn9KD/fcvkjF/fRjbIdTV2WlJT58WiXjA4+LN2IIMxi6RgWv4Y2xbHpp1yaSieKZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dko6LHmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4006EC4CED6;
	Tue, 10 Dec 2024 14:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733841882;
	bh=p92MSmrg16W+AvmipmOqXkEVwVKuNWKW3EymIxk3aYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dko6LHmGKFs3oBZQ4HJ3a6GbYW3z7hfjfLQRNqS0+yJWfNCQHgyvuTgpqHV6JSYRZ
	 cxwCAfpzvZ1Vx5ClH+tc0Mkxeh0UGFoCCu81tDhcfpKoyo6/Qgsjz7/DQoVFJb2JR3
	 hR+H0d7z0BXhOEEwv7SdOPbxAiY1bH1bE3t4EXHcIYVrMtPhtXj4IxoT4r6SlLW03+
	 RJYwPdJ+Hg5JZ7WfkmLso4WLqhjDOY7ezgmkHn6wLQ396sNLtb+5HoHuMCvZ2VYQI/
	 iFOiImcEPB7wrskOfym5Yub/YOAaoXUwqh0rh5Y0EBAF3wHEWtHTtYj5D/IRw4fWV4
	 qaoB1U5qROEpA==
Date: Tue, 10 Dec 2024 15:44:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 0/5] bpf: Add open-coded style process file
 iterator and bpf_fget_task() kfunc
Message-ID: <20241210-geholfen-aufheben-b4b57524c00f@brauner>
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>

On Tue, Dec 10, 2024 at 02:01:53PM +0000, Juntong Deng wrote:
> This patch series adds open-coded style process file iterator
> bpf_iter_task_file and bpf_fget_task() kfunc, and corresponding
> selftests test cases.
> 
> In addition, since fs kfuncs is generic and useful for scenarios
> other than LSM, this patch makes fs kfuncs available for SYSCALL
> and TRACING program types [0].
> 
> [0]: https://lore.kernel.org/bpf/CAPhsuW6ud21v2xz8iSXf=CiDL+R_zpQ+p8isSTMTw=EiJQtRSw@mail.gmail.com/
> 
> Although iter/task_file already exists, for CRIB we still need the

What is CRIB?

> open-coded iterator style process file iterator, and the same is true
> for other bpf iterators such as iter/tcp, iter/udp, etc.
> 
> The traditional bpf iterator is more like a bpf version of procfs, but
> similar to procfs, it is not suitable for CRIB scenarios that need to
> obtain large amounts of complex, multi-level in-kernel information.
> 
> The following is from previous discussions [2].
> 
> [2]: https://lore.kernel.org/bpf/AM6PR03MB5848CA34B5B68C90F210285E99B12@AM6PR03MB5848.eurprd03.prod.outlook.com/
> 
> This is because the context of bpf iterators is fixed and bpf iterators
> cannot be nested. This means that a bpf iterator program can only
> complete a specific small iterative dump task, and cannot dump
> multi-level data.
> 
> An example, when we need to dump all the sockets of a process, we need
> to iterate over all the files (sockets) of the process, and iterate over
> the all packets in the queue of each socket, and iterate over all data
> in each packet.
> 
> If we use bpf iterator, since the iterator can not be nested, we need to
> use socket iterator program to get all the basic information of all
> sockets (pass pid as filter), and then use packet iterator program to
> get the basic information of all packets of a specific socket (pass pid,
> fd as filter), and then use packet data iterator program to get all the
> data of a specific packet (pass pid, fd, packet index as filter).
> 
> This would be complicated and require a lot of (each iteration)
> bpf program startup and exit (leading to poor performance).
> 
> By comparison, open coded iterator is much more flexible, we can iterate
> in any context, at any time, and iteration can be nested, so we can
> achieve more flexible and more elegant dumping through open coded
> iterators.
> 
> With open coded iterators, all of the above can be done in a single
> bpf program, and with nested iterators, everything becomes compact
> and simple.
> 
> Also, bpf iterators transmit data to user space through seq_file,
> which involves a lot of open (bpf_iter_create), read, close syscalls,
> context switching, memory copying, and cannot achieve the performance
> of using ringbuf.
> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
> v4 -> v5:
> * Add file type checks in test cases for process file iterator
>   and bpf_fget_task().
> 
> * Use fentry to synchronize tests instead of waiting in a loop.
> 
> * Remove path_d_path_kfunc_non_lsm test case.
> 
> * Replace task_lookup_next_fdget_rcu() with fget_task_next().
> 
> * Remove future merge conflict section in cover letter (resolved).
> 
> v3 -> v4:
> * Make all kfuncs generic, not CRIB specific.
> 
> * Move bpf_fget_task to fs/bpf_fs_kfuncs.c.
> 
> * Remove bpf_iter_task_file_get_fd and bpf_get_file_ops_type.
> 
> * Use struct bpf_iter_task_file_item * as the return value of
>   bpf_iter_task_file_next.
> 
> * Change fd to unsigned int type and add next_fd.
> 
> * Add KF_RCU_PROTECTED to bpf_iter_task_file_new.
> 
> * Make fs kfuncs available to SYSCALL and TRACING program types.
> 
> * Update all relevant test cases.
> 
> * Remove the discussion section from cover letter.
> 
> v2 -> v3:
> * Move task_file open-coded iterator to kernel/bpf/helpers.c.
> 
> * Fix duplicate error code 7 in test_bpf_iter_task_file().
> 
> * Add comment for case when bpf_iter_task_file_get_fd() returns -1.
> 
> * Add future plans in commit message of "Add struct file related
>   CRIB kfuncs".
> 
> * Add Discussion section to cover letter.
> 
> v1 -> v2:
> * Fix a type definition error in the fd parameter of
>   bpf_fget_task() at crib_common.h.
> 
> Juntong Deng (5):
>   bpf: Introduce task_file open-coded iterator kfuncs
>   selftests/bpf: Add tests for open-coded style process file iterator
>   bpf: Add bpf_fget_task() kfunc
>   bpf: Make fs kfuncs available for SYSCALL and TRACING program types
>   selftests/bpf: Add tests for bpf_fget_task() kfunc
> 
>  fs/bpf_fs_kfuncs.c                            |  42 ++++---
>  kernel/bpf/helpers.c                          |   3 +
>  kernel/bpf/task_iter.c                        |  92 ++++++++++++++
>  .../testing/selftests/bpf/bpf_experimental.h  |  15 +++
>  .../selftests/bpf/prog_tests/fs_kfuncs.c      |  46 +++++++
>  .../testing/selftests/bpf/prog_tests/iters.c  |  79 ++++++++++++
>  .../selftests/bpf/progs/fs_kfuncs_failure.c   |  33 +++++
>  .../selftests/bpf/progs/iters_task_file.c     |  88 ++++++++++++++
>  .../bpf/progs/iters_task_file_failure.c       | 114 ++++++++++++++++++
>  .../selftests/bpf/progs/test_fget_task.c      |  63 ++++++++++
>  .../selftests/bpf/progs/verifier_vfs_reject.c |  10 --
>  11 files changed, 559 insertions(+), 26 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/fs_kfuncs_failure.c
>  create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file.c
>  create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file_failure.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_fget_task.c
> 
> -- 
> 2.39.5
> 

