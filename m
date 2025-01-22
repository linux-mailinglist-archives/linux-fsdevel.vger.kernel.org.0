Return-Path: <linux-fsdevel+bounces-39832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1963AA19290
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 14:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810113A69D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E370238DF9;
	Wed, 22 Jan 2025 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlSHPHio"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5064E1CA
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552700; cv=none; b=kHqbOVMUwAZI/59ZxQwt3xiyD7jZb0YAm1lRDatDyC8dUpRVOJJio4SxezNezKdV/yVAoXcPM+IHFHDqnxKprnm5C50pAJzFmmriZW5i/WQkj2wlZTf3NKpwPn+b60dhVSqR6en/0Qdla1bCSunsb3htRy2DbXwXMuJoIosdaJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552700; c=relaxed/simple;
	bh=YP/ngZMQ8vdSb0pFgVM4TvVl9qohNjo+HbHs4kxc0DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nr+xhMz3mqb6iY1qvqHwaHU8dcKbJ/d+nk1gQkSXNDiqU+picXIxeak/U2rnrUq3kmAaNZTKeYP2Xk870tbzqeNmOEdaog/eMWTFa3vYmDTVcYJpFyZ+Kv9ThGyboVIgwEfi6pqytCltYh9NO5oRY48aX9Lw/SQo/3DK/miLnuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlSHPHio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC10EC4CED6;
	Wed, 22 Jan 2025 13:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737552699;
	bh=YP/ngZMQ8vdSb0pFgVM4TvVl9qohNjo+HbHs4kxc0DU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jlSHPHioMdKeqaC/ZGi1lZkWHwneKwwcNguipmcR25kU/8jZ8dhhljhAbWyeDILB5
	 1xw8pOVgvADQkHsrqnNIkn2cqBZYnFLTwPKPCwrnnH76C+SgZREeYpoRkXsaOWlpqG
	 EzVGKrqEiTn0ZmxWNSkbT7yK9m5ntoagOYnG3rkGgsRMYdQ6hohhiO2x6PjWWsVE+r
	 wWU/y0M13x49peJ8FTvQ6+xXJYZ8a4/ajjYA9rRQkabnlp/QInxd0/gwvDOzH3EcqB
	 ZgQWqTwI+vegHyiZDzSspYlCBAmGA+iCuXt32uCVU9v7v/Uyt4s+moT2oj9Afwm8eL
	 sUA4EIe4110/Q==
Date: Wed, 22 Jan 2025 14:31:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kir Kolyshkin <kolyshkin@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrei Vagin <avagin@google.com>
Subject: Re: Bug with splice to a pipe preventing a process exit
Message-ID: <20250122-lenkung-gasthaus-faf0b8609790@brauner>
References: <20250122020850.2175427-1-kolyshkin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122020850.2175427-1-kolyshkin@gmail.com>

On Tue, Jan 21, 2025 at 06:08:41PM -0800, Kir Kolyshkin wrote:
> While checking if the tool I'm co-maintaining [1] works OK when compiled
> with the future release of golang (1.24, tested with go1.24rc2), I found
> out it's not [2], and the issue is caused by Go using sendfile more [3].
> 
> I came up with the following simple reproducer:
> 
> #define _GNU_SOURCE
> #include <fcntl.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/sendfile.h>
> #include <sys/wait.h>
> #include <sys/socket.h>
> #include <sys/un.h>
> 
> int main() {
> 	int sks[2];
> 	int pipefd[2];
> 	if (pipe(pipefd) == -1) {
> 		perror("pipe");
> 		exit(1);
> 	}
> 
> 	pid_t pid = fork();
> 	if (pid == -1) {
> 		perror("fork");
> 		exit(1);
> 	}
> 
> 	if (pid == 0) {
> 		// Child process.
> 		close(pipefd[1]); // Close write end.
> 
> 		// Minimal process that just exits after some time.
> 		sleep(1);
> 
> 		_exit(0); // <-- The child hangs here.
> 	}
> 
> 	// Parent process.
> 	close(pipefd[0]);  // Close read end.
> 
> 	printf("PID1=%d\n", getpid());
> 	printf("PID2=%d\n", pid);
> 	printf("ps -f  -p $PID1,$PID2\n");
> 	printf("sudo tail /proc/{$PID1,$PID2}/{stack,syscall}\n");
> 
> #ifdef TEST_USE_STDIN
> 	int in_fd = STDIN_FILENO;
> #else
> 	socketpair(AF_UNIX, SOCK_STREAM, 0, sks);
> 	int in_fd = sks[0];
> #endif
> 	// Copy from in_fd to pipe.
> 	ssize_t ret = sendfile(pipefd[1], in_fd, 0, 1 << 22);
> 	if (ret == -1) {
> 		perror("sendfile");
> 	}
> 
> 	// Wait for child
> 	int status;
> 	waitpid(pid, &status, 0);
> 
> 	close(pipefd[1]); // Close write end.
> 	return 0;
> }
> 
> To reproduce, compile and run the above code, and when it hangs (instead
> of exiting), copy its output to a shell in another terminal. Here's what
> I saw:
> 
> [kir@kir-tp1 linux]$ PID1=2174401
> PID2=2174402
> ps -f  -p $PID1,$PID2
> sudo tail /proc/{$PID1,$PID2}/{stack,syscall}
> UID          PID    PPID  C STIME TTY          TIME CMD
> kir      2174401   63304  0 17:34 pts/1    00:00:00 ./repro
> kir      2174402 2174401  0 17:34 pts/1    00:00:00 [repro]
> ==> /proc/2174401/stack <==
> [<0>] unix_stream_read_generic+0x792/0xc90
> [<0>] unix_stream_splice_read+0x6f/0xb0
> [<0>] splice_file_to_pipe+0x65/0xd0
> [<0>] do_sendfile+0x176/0x440
> [<0>] __x64_sys_sendfile64+0xb3/0xd0
> [<0>] do_syscall_64+0x82/0x160
> [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> ==> /proc/2174401/syscall <==
> 40 0x4 0x3 0x0 0x400000 0x64 0xfffffff9 0x7fff2ab3fc58 0x7f265ed6ca3e
> 
> ==> /proc/2174402/stack <==
> [<0>] pipe_release+0x1f/0x100
> [<0>] __fput+0xde/0x2a0
> [<0>] task_work_run+0x59/0x90
> [<0>] do_exit+0x309/0xab0
> [<0>] do_group_exit+0x30/0x80
> [<0>] __x64_sys_exit_group+0x18/0x20
> [<0>] x64_sys_call+0x14b4/0x14c0
> [<0>] do_syscall_64+0x82/0x160
> [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> ==> /proc/2174402/syscall <==
> 231 0x0 0xffffffffffffff88 0xe7 0x0 0x0 0x7f265eea01a0 0x7fff2ab3fc58 0x7f265ed43acd
> 
> Presumably, what happens here is the child process is stuck in the
> exit_group syscall, being blocked by parent's splice which holds the
> lock to the pipe (in splice_file_to_pipe).

Splice is notoriously problematic when interacting with pipes due to how
it holds the pipe lock. We've had handwavy discussions how to improve
this but nothing ever materialized.

The gist here seems to me that unix_stream_read_generic() is waiting on
data to read from the write-side of the socketpair(). Until you close
that fd or provide data you'll simply hang forever.

Similar with STDIN_FILENO fwiw. If you never enter any character you
simply hang forever waiting for input.

So imho the way the program is written is buggy.
But Jens might be able to provide more details.

> 
> To me, the code above looks valid, and the kernel behavior seems to
> be a bug. In particular, if the process is exiting, the pipe it was
> using is now being closed, and splice (or sendfile) should return.
> 
> If this is not a kernel bug, then the code above is not correct; in
> this case, please suggest how to fix it.
> 
> Regards,
>   Kir.
> 
> ----
> [1]: https://github.com/opencontainers/runc
> [2]: https://github.com/opencontainers/runc/pull/4598
> [3]: https://go-review.googlesource.com/c/go/+/603295

