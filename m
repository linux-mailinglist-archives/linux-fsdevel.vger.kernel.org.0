Return-Path: <linux-fsdevel+bounces-39815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57122A189CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 03:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FF616B552
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 02:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DB7137775;
	Wed, 22 Jan 2025 02:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwW2LiGy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068E817BB6
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 02:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737511762; cv=none; b=IltOKOfdzuf02Q2f6E02nLIuBskmpW/we20fAaicoAUOv6YAVKH/kM8mJGW23vdePYj2WS470YoPbAVHFkGYurFCE6B0X0AObWyg1420rMCRs44NHZ+bc5IhJ+uhFNvDJoewd4qkeedv9kbB5Ow/Kr60FZxc7hWKrdLBMDBOuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737511762; c=relaxed/simple;
	bh=wKnNYNQonzIXr9EES+JmSueZ6uZOiK0Rx65Pro1OFXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQL1Wly3ZmNi7JS5W3jsJLNgJrNRanbk008fqySiR5sJ+RtaMeUoc7vTC8R/j2c5NffUq9i0QRVcLArXijkVAweWdWnuu9bpzKCOHK0G0NXqKg2DHQ+37cqls4m6juOZcOw8II52WCXaxipDMB9DknYkZPQQwPahJKaFxZPz5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwW2LiGy; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ddcff5a823so49781636d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 18:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737511760; x=1738116560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jnVRXcC+aPHbUl8fbMQchZlA9SXRnElohEoGC9Z3Wa8=;
        b=cwW2LiGyCz3ZjMM8Kcs97Fq0FdS7enGT93Bh/N5Q4yvDXnVBYQM9AMbVOnC1HcTRaQ
         sR+Ab/g+SQ86kWXFivF7ag3C8SB8XLvaS8eLjX7ktguDRSd1oL1cINlaZtYdvG6+OcSS
         fI8C5Xg3xAsaknASrokNDf47pewGEyLX12VpU6XyM6EYqE6Y/GvL6Nzu8B6ljBcDU/E1
         fa2fSAmBRgZrYcqyrpk2bxxeF3SSsQ9EeEkWDjEKBamR5NqaRiLcWsKQ6S80pjBNphLw
         TWp/xD3ODjh7FT9rcPcT8KC0QtxqDTn6mDaU6x022cQSdzym92eQ5wppCbqKxofZ9Tsm
         mcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737511760; x=1738116560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnVRXcC+aPHbUl8fbMQchZlA9SXRnElohEoGC9Z3Wa8=;
        b=ub4WNm33D8zY251Ct/DTcQezL3X1abmmEvH2H32Zb2hgvl4yQmmMooyME4ogwGnCnG
         /cgIRcrGL6vRYr+5lXhta63Z/tOOY1UtemTimz2GFwUzFm/8FfJOn/Lr7DxyYMr75Q0a
         HRE0R0PTOhqHV0s/4GAyQ/GxbhNeScwThUI74ox9XoZs7qCp/7Yu6UoG7LsJP3yuRyMU
         3axeAlsaDypCVJvNxfMDyiZfsHcObZgpb0U07cYBZDt9tUpGYDrHtnNDLmvr+GbNDCch
         Fxunu5EBl/O/RRB4+Ki5Hi/N2Z0pTwZRwXtqFjDJWusREbt72HamIau4YnV4V9rCebXw
         LMyw==
X-Forwarded-Encrypted: i=1; AJvYcCVcvqRs1NlrnTTaiQZITamgvNJZv+M2cxWEfl8k2j0O4uA4hYvUVxWAyCV9RhHkt3MF/cOMuOPER4QzXvwD@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz8CUatgOrKJAjCp+YFRprjnZJtFkk28Lmx4wzarGPbYD0XVRX
	/sve9Sppgjg/U1ZZHByzSRPVXRHrPfNnn04D1QTFiKEoqtmAI2gM
X-Gm-Gg: ASbGncslvQthGAc6uYSzHbevD8QsUWBim0FJ+ZgFwMYC4cjqHpdBN0xHDf2JaTlSlXs
	BSPSir0jcnrAgK3kHyrZZS1TCECXuidAOSIMY3nlsQ4iE6ihiTjjpang0SLuuTqHg49oYKIRSUC
	8klbCRgEW9FdkyubHTeH9pw/74b7UhIjnyiWuQDfNFl6uuTpaqwhN0+1KNQZhfWJCTFDFeAI6wq
	Ej9bSQONHcyTd+svZrc/QPfF7oKtPv+0nO7ckUK4Hr8wjfQqyfZTbbLSlRzfUkawRjz06XeMq5Z
	Zk9pB+pScx64FiXT44gwghhemzKc1SeU7LDgJz+afow=
X-Google-Smtp-Source: AGHT+IE5zmLMRm+6iMr1/viBo0XnM1xJC5fBExYAqXg9S9PyLk7nlK5B4onGNBAAGsFc3D8kMoQFkw==
X-Received: by 2002:a05:6214:5d87:b0:6d8:9ab7:adcc with SMTP id 6a1803df08f44-6e1b218a45emr315820006d6.22.1737511759784;
        Tue, 21 Jan 2025 18:09:19 -0800 (PST)
Received: from kir-tp1.redhat.com (c-73-221-161-193.hsd1.wa.comcast.net. [73.221.161.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1e64ca517sm10307516d6.41.2025.01.21.18.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 18:09:19 -0800 (PST)
From: Kir Kolyshkin <kolyshkin@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Kir Kolyshkin <kolyshkin@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrei Vagin <avagin@google.com>
Subject: Bug with splice to a pipe preventing a process exit
Date: Tue, 21 Jan 2025 18:08:41 -0800
Message-ID: <20250122020850.2175427-1-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While checking if the tool I'm co-maintaining [1] works OK when compiled
with the future release of golang (1.24, tested with go1.24rc2), I found
out it's not [2], and the issue is caused by Go using sendfile more [3].

I came up with the following simple reproducer:

#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/sendfile.h>
#include <sys/wait.h>
#include <sys/socket.h>
#include <sys/un.h>

int main() {
	int sks[2];
	int pipefd[2];
	if (pipe(pipefd) == -1) {
		perror("pipe");
		exit(1);
	}

	pid_t pid = fork();
	if (pid == -1) {
		perror("fork");
		exit(1);
	}

	if (pid == 0) {
		// Child process.
		close(pipefd[1]); // Close write end.

		// Minimal process that just exits after some time.
		sleep(1);

		_exit(0); // <-- The child hangs here.
	}

	// Parent process.
	close(pipefd[0]);  // Close read end.

	printf("PID1=%d\n", getpid());
	printf("PID2=%d\n", pid);
	printf("ps -f  -p $PID1,$PID2\n");
	printf("sudo tail /proc/{$PID1,$PID2}/{stack,syscall}\n");

#ifdef TEST_USE_STDIN
	int in_fd = STDIN_FILENO;
#else
	socketpair(AF_UNIX, SOCK_STREAM, 0, sks);
	int in_fd = sks[0];
#endif
	// Copy from in_fd to pipe.
	ssize_t ret = sendfile(pipefd[1], in_fd, 0, 1 << 22);
	if (ret == -1) {
		perror("sendfile");
	}

	// Wait for child
	int status;
	waitpid(pid, &status, 0);

	close(pipefd[1]); // Close write end.
	return 0;
}

To reproduce, compile and run the above code, and when it hangs (instead
of exiting), copy its output to a shell in another terminal. Here's what
I saw:

[kir@kir-tp1 linux]$ PID1=2174401
PID2=2174402
ps -f  -p $PID1,$PID2
sudo tail /proc/{$PID1,$PID2}/{stack,syscall}
UID          PID    PPID  C STIME TTY          TIME CMD
kir      2174401   63304  0 17:34 pts/1    00:00:00 ./repro
kir      2174402 2174401  0 17:34 pts/1    00:00:00 [repro]
==> /proc/2174401/stack <==
[<0>] unix_stream_read_generic+0x792/0xc90
[<0>] unix_stream_splice_read+0x6f/0xb0
[<0>] splice_file_to_pipe+0x65/0xd0
[<0>] do_sendfile+0x176/0x440
[<0>] __x64_sys_sendfile64+0xb3/0xd0
[<0>] do_syscall_64+0x82/0x160
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

==> /proc/2174401/syscall <==
40 0x4 0x3 0x0 0x400000 0x64 0xfffffff9 0x7fff2ab3fc58 0x7f265ed6ca3e

==> /proc/2174402/stack <==
[<0>] pipe_release+0x1f/0x100
[<0>] __fput+0xde/0x2a0
[<0>] task_work_run+0x59/0x90
[<0>] do_exit+0x309/0xab0
[<0>] do_group_exit+0x30/0x80
[<0>] __x64_sys_exit_group+0x18/0x20
[<0>] x64_sys_call+0x14b4/0x14c0
[<0>] do_syscall_64+0x82/0x160
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

==> /proc/2174402/syscall <==
231 0x0 0xffffffffffffff88 0xe7 0x0 0x0 0x7f265eea01a0 0x7fff2ab3fc58 0x7f265ed43acd

Presumably, what happens here is the child process is stuck in the
exit_group syscall, being blocked by parent's splice which holds the
lock to the pipe (in splice_file_to_pipe).

To me, the code above looks valid, and the kernel behavior seems to
be a bug. In particular, if the process is exiting, the pipe it was
using is now being closed, and splice (or sendfile) should return.

If this is not a kernel bug, then the code above is not correct; in
this case, please suggest how to fix it.

Regards,
  Kir.

----
[1]: https://github.com/opencontainers/runc
[2]: https://github.com/opencontainers/runc/pull/4598
[3]: https://go-review.googlesource.com/c/go/+/603295

