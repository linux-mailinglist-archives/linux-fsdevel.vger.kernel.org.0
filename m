Return-Path: <linux-fsdevel+bounces-40241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237B1A20EB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 17:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489C1188926E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 16:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C65E1DE2D8;
	Tue, 28 Jan 2025 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j3G8bueP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A41A9B2B
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082209; cv=none; b=hhqHIOkJGHUm+XXvuQjA07U39ZzT03vFL0WdnfGxUNttNHtVKy8+QwsS9NnTugugC10W+1s5p69jnszKlo2An+Tu5bVbqoDBXi8mzUOEfxqn9ofG5xICdDWANSwd87UZJi+31hebSugcuInbI/lAEw6cBmoqnYYlh+HEjDj1Hp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082209; c=relaxed/simple;
	bh=EnxntvKNmoagnWjIx906DezslAW/5eTvg4ViQ66PFiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nb8FMRx0Th5bjzLfgWEQ19Qt0h2Adv71FgyA7opZs95ZC8QrLDzjxKl0pMrbODZxoS/ZuH2O0YYSHbUCD2hkATK2lVczHzodYSscOFD0NdXKaJ0o9z67rjU6pxF0Op/Swd2nPj5En2p3GPo3NXD6glIK/lvEJ8ZvlVzoiU/ThAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j3G8bueP; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so137645ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 08:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738082207; x=1738687007; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rq4swQdTpymDwjatGlXMKWkMWHKrCj9VsWwXSXdt0/Q=;
        b=j3G8buePJadFDNtB2s2einnMdLRl6wH8vRP0TmCF91HMQ50H2o+fOIll5OD2FT/fQj
         BUiqucqs/0AFAYlr/GOwdy6+ynJtYHiULWYSAciuoUJWmBmTg6Mif76Sqd5WqY6iFsJu
         IQqTDnadPxuROWXWP7JFeH4KOV9VR+Gp1DfN0XfmlAHiJWQ6gJDU7x454mCxLyvknFJz
         F8KvMgkpYktcT4GCTpvSn3txSFUXqB+oE59arlQ2bfipGUb2zGbM9HAceAfVahEWRgD4
         OU0sR8Cvt3acm/CWOTxWevE6Skc/QRb1MXzoLfw4p96bFkrl8mmGmK3RC28k8cb7ncuz
         Sbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738082207; x=1738687007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rq4swQdTpymDwjatGlXMKWkMWHKrCj9VsWwXSXdt0/Q=;
        b=v4sBjywrPCvwOqnkfkVVB4QKd/ZsfZ59UUepq2eouMnniQiGFBctvNZfyOnyWwXYxy
         2BQ4YMfFslFj44wgrrAn0clO5DvC8/AskZBG/PDbsA1tLjWQsYvS10v/ljLhke8MPQu3
         JJie1YMlPLp4+fdGsuIFEhKd8Q9KshgHCCPKbWy3c2Pn27oSPo43gzO0sRGdoHJYHViK
         3fYja1grrcWTuTUUHZ7onYEeR7L6YNJg4XagVRFYZZAEKJP6FCTCzmCd0KdQFkk82i3m
         lrotDXxO2EDTzCkTiWsWEoBwAuzCnoWs3oZQOHb9dufRy6IoDPz6W1QCbGTcD41zn1+c
         jWSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQKc5wwJJYNuUqKKIWcnEqh9S9i6KJtRr05SbIT/y3w9YJXDV0m0X8bA9E5yasaX6D2NHx4kuXRDMgWt2s@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FmwYtXQizHzb5rKsjIP6R4Q5Xv9IqIYkXJ0wRx58SqKTelee
	hgc3wOgn6VIXCUbT8hwzCgdaFszj+74BvLVtJWCyrRKGg0uPBQAd1ClMaUWgXgQvWyyeOcVlv8X
	KoRJC
X-Gm-Gg: ASbGncsRbaeIdORQMDHZhvfy/NOzh2anSpC9a6Chzdxqu2zVNZO9PscQykQRL6atQ0M
	bwBUtgWsyxZRH9E7JFgOD66ni9I94M0nN2OzWPYBP2tAx1b8WjgclvT57YoGB+94tsNejts6BU+
	Pv2zaQGA4GZ06r+lY3Naj5TM5tgOkW64cwTScTE54z6CuK/xH433E3BhN9K5cMgNYNgmxKOl4/H
	QUVcLG9XswdLh0/9Hgt/w24tiEsMZgA9ozUKW76CiYc1FKXfBRHfs+cmsThVofXAH18SroWQcqV
	uP6h9UpTjE7ZtY7baZ8JmoZOzI/QJSP0uER9EB+xrEZbCA==
X-Google-Smtp-Source: AGHT+IGcjiQgmbLSS0Fan0TbyB8mRRFp+c4NCMFuveE8UQwn+ckL7ROo1iFIBX9QN6JJEgAo0DFW0g==
X-Received: by 2002:a05:6e02:1fe9:b0:3cf:a4e4:8f89 with SMTP id e9e14a558f8ab-3cff4895ba8mr4619545ab.4.1738082206625;
        Tue, 28 Jan 2025 08:36:46 -0800 (PST)
Received: from google.com (41.25.70.34.bc.googleusercontent.com. [34.70.25.41])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1db6da2esm3156836173.77.2025.01.28.08.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:36:46 -0800 (PST)
Date: Tue, 28 Jan 2025 16:36:43 +0000
From: Andrei Vagin <avagin@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Kir Kolyshkin <kolyshkin@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Bug with splice to a pipe preventing a process exit
Message-ID: <Z5kHmzL9vS9whMIA@google.com>
References: <20250122020850.2175427-1-kolyshkin@gmail.com>
 <20250122-lenkung-gasthaus-faf0b8609790@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122-lenkung-gasthaus-faf0b8609790@brauner>

On Wed, Jan 22, 2025 at 02:31:35PM +0100, Christian Brauner wrote:
> On Tue, Jan 21, 2025 at 06:08:41PM -0800, Kir Kolyshkin wrote:
> > While checking if the tool I'm co-maintaining [1] works OK when compiled
> > with the future release of golang (1.24, tested with go1.24rc2), I found
> > out it's not [2], and the issue is caused by Go using sendfile more [3].
> > 
> > I came up with the following simple reproducer:
> > 
> > #define _GNU_SOURCE
> > #include <fcntl.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <unistd.h>
> > #include <sys/sendfile.h>
> > #include <sys/wait.h>
> > #include <sys/socket.h>
> > #include <sys/un.h>
> > 
> > int main() {
> > 	int sks[2];
> > 	int pipefd[2];
> > 	if (pipe(pipefd) == -1) {
> > 		perror("pipe");
> > 		exit(1);
> > 	}
> > 
> > 	pid_t pid = fork();
> > 	if (pid == -1) {
> > 		perror("fork");
> > 		exit(1);
> > 	}
> > 
> > 	if (pid == 0) {
> > 		// Child process.
> > 		close(pipefd[1]); // Close write end.
> > 
> > 		// Minimal process that just exits after some time.
> > 		sleep(1);
> > 
> > 		_exit(0); // <-- The child hangs here.
> > 	}
> > 
> > 	// Parent process.
> > 	close(pipefd[0]);  // Close read end.
> > 
> > 	printf("PID1=%d\n", getpid());
> > 	printf("PID2=%d\n", pid);
> > 	printf("ps -f  -p $PID1,$PID2\n");
> > 	printf("sudo tail /proc/{$PID1,$PID2}/{stack,syscall}\n");
> > 
> > #ifdef TEST_USE_STDIN
> > 	int in_fd = STDIN_FILENO;
> > #else
> > 	socketpair(AF_UNIX, SOCK_STREAM, 0, sks);
> > 	int in_fd = sks[0];
> > #endif
> > 	// Copy from in_fd to pipe.
> > 	ssize_t ret = sendfile(pipefd[1], in_fd, 0, 1 << 22);
> > 	if (ret == -1) {
> > 		perror("sendfile");
> > 	}
> > 
> > 	// Wait for child
> > 	int status;
> > 	waitpid(pid, &status, 0);
> > 
> > 	close(pipefd[1]); // Close write end.
> > 	return 0;
> > }
> > 
> > To reproduce, compile and run the above code, and when it hangs (instead
> > of exiting), copy its output to a shell in another terminal. Here's what
> > I saw:
> > 
> > [kir@kir-tp1 linux]$ PID1=2174401
> > PID2=2174402
> > ps -f  -p $PID1,$PID2
> > sudo tail /proc/{$PID1,$PID2}/{stack,syscall}
> > UID          PID    PPID  C STIME TTY          TIME CMD
> > kir      2174401   63304  0 17:34 pts/1    00:00:00 ./repro
> > kir      2174402 2174401  0 17:34 pts/1    00:00:00 [repro]
> > ==> /proc/2174401/stack <==
> > [<0>] unix_stream_read_generic+0x792/0xc90
> > [<0>] unix_stream_splice_read+0x6f/0xb0
> > [<0>] splice_file_to_pipe+0x65/0xd0
> > [<0>] do_sendfile+0x176/0x440
> > [<0>] __x64_sys_sendfile64+0xb3/0xd0
> > [<0>] do_syscall_64+0x82/0x160
> > [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > 
> > ==> /proc/2174401/syscall <==
> > 40 0x4 0x3 0x0 0x400000 0x64 0xfffffff9 0x7fff2ab3fc58 0x7f265ed6ca3e
> > 
> > ==> /proc/2174402/stack <==
> > [<0>] pipe_release+0x1f/0x100
> > [<0>] __fput+0xde/0x2a0
> > [<0>] task_work_run+0x59/0x90
> > [<0>] do_exit+0x309/0xab0
> > [<0>] do_group_exit+0x30/0x80
> > [<0>] __x64_sys_exit_group+0x18/0x20
> > [<0>] x64_sys_call+0x14b4/0x14c0
> > [<0>] do_syscall_64+0x82/0x160
> > [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > 
> > ==> /proc/2174402/syscall <==
> > 231 0x0 0xffffffffffffff88 0xe7 0x0 0x0 0x7f265eea01a0 0x7fff2ab3fc58 0x7f265ed43acd
> > 
> > Presumably, what happens here is the child process is stuck in the
> > exit_group syscall, being blocked by parent's splice which holds the
> > lock to the pipe (in splice_file_to_pipe).
> 
> Splice is notoriously problematic when interacting with pipes due to how
> it holds the pipe lock. We've had handwavy discussions how to improve
> this but nothing ever materialized.
> 
> The gist here seems to me that unix_stream_read_generic() is waiting on
> data to read from the write-side of the socketpair(). Until you close
> that fd or provide data you'll simply hang forever.
> 
> Similar with STDIN_FILENO fwiw. If you never enter any character you
> simply hang forever waiting for input.
> 
> So imho the way the program is written is buggy.
> But Jens might be able to provide more details.

Christian,

This is just a reproducer for the problem. I can easily imagine a real
life use case where this issue will be triggered. Basically, we have
one task that calls sendfile or splice to the pipe and another task
reading from the other end of the pipe. Then something (like OOM) kills
the second task, but it doesn’t exit and it is stuck in an uncertain
state.  IMHO, this is the kernel issue that has to be fixed.

Here is another issue with this pipe lock. One task calls `write` to a
pipe while another task is blocked in `sendfile` to the same pipe.  The
second task holds the pipe lock and the first task is waiting for it in
the TASK_UNINTERRUPTIBLE state. It will be unkillable and it will be
impossible to attach to the first task with ptrace to find out what it
is doing... This looks like an even more critical issue.

One possible solution is splitting the splice process into two stages.
The first stage does splice in non-blocking mode. The second stage polls
file descriptors and re-executes the first stage when both are ready.
Polling doesn't take locks, and while a small race condition exists
between stages, any descriptor state change triggers just another
iteration.

Here is a draft patch just to demonstate the idea. There are still a few
things to be adjusted. For example, SPLICE_F_NONBLOCK doesn't gurante
that do_splice_read will not block. It works for sockets, but it doesn't
work for tty-s right now.  I'd like to know if the overall idea looks
reasonable.

---

diff --git a/fs/internal.h b/fs/internal.h
index e7f02ae1e098..8022055fc997 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -254,8 +254,7 @@ int do_statx_fd(int fd, unsigned int flags, unsigned int mask,
 /*
  * fs/splice.c:
  */
-ssize_t splice_file_to_pipe(struct file *in,
-			    struct pipe_inode_info *opipe,
+ssize_t splice_file_to_pipe(struct file *in, struct file *out,
 			    loff_t *offset,
 			    size_t len, unsigned int flags);
 
diff --git a/fs/read_write.c b/fs/read_write.c
index a6133241dfb8..2f69039ec978 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1366,7 +1366,7 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		if (fd_file(out)->f_flags & O_NONBLOCK)
 			fl |= SPLICE_F_NONBLOCK;
 
-		retval = splice_file_to_pipe(fd_file(in), opipe, &pos, count, fl);
+		retval = splice_file_to_pipe(fd_file(in), fd_file(out), &pos, count, fl);
 	}
 
 	if (retval > 0) {
diff --git a/fs/splice.c b/fs/splice.c
index 2898fa1e9e63..61fc419e87a9 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1282,18 +1282,75 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			       struct pipe_inode_info *opipe,
 			       size_t len, unsigned int flags);
 
-ssize_t splice_file_to_pipe(struct file *in,
-			    struct pipe_inode_info *opipe,
+struct splice_poll_wait {
+	poll_table pt;
+	wait_queue_entry_t wait;
+	wait_queue_head_t *wait_address;
+};
+
+static void spw_queue(struct file *file, wait_queue_head_t *wqh, poll_table *pt)
+{
+	struct splice_poll_wait *spw;
+
+	spw = container_of(pt, struct splice_poll_wait, pt);
+	spw->wait_address = wqh;
+	add_wait_queue(wqh, &spw->wait);
+}
+
+static int spw_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
+{
+	return default_wake_function(wait, mode, sync, key);
+}
+
+ssize_t splice_file_to_pipe(struct file *in, struct file *out,
 			    loff_t *offset,
 			    size_t len, unsigned int flags)
 {
+	struct pipe_inode_info *opipe = get_pipe_info(out, true);
+	unsigned poll_flag = 0;
 	ssize_t ret;
 
+	if (file_can_poll(in) && !(in->f_flags & O_NONBLOCK) &&
+	    !(flags & SPLICE_F_NONBLOCK))
+		poll_flag = SPLICE_F_NONBLOCK;
+
+try_again:
 	pipe_lock(opipe);
-	ret = wait_for_space(opipe, flags);
+	ret = wait_for_space(opipe, flags | poll_flag);
 	if (!ret)
-		ret = do_splice_read(in, offset, opipe, len, flags);
+		ret = do_splice_read(in, offset, opipe, len, flags | poll_flag);
 	pipe_unlock(opipe);
+
+	if (ret == -EAGAIN && poll_flag) {
+		struct splice_poll_wait spw_in, spw_out;
+		__poll_t in_events, out_events;
+
+		init_waitqueue_func_entry(&spw_in.wait, spw_wakeup);
+		spw_in.wait.private = current;
+		init_poll_funcptr(&spw_in.pt, spw_queue);
+
+		init_waitqueue_func_entry(&spw_out.wait, spw_wakeup);
+		spw_out.wait.private = current;
+		init_poll_funcptr(&spw_out.pt, spw_queue);
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			goto out;
+		}
+		in_events = vfs_poll(in, &spw_in.pt);
+		out_events = vfs_poll(out, &spw_out.pt);
+		if ((in_events & (EPOLLIN | POLLRDHUP | POLLERR)) == 0 ||
+		    (out_events & (EPOLLOUT | POLLERR)) == 0) {
+			schedule();
+		}
+
+		remove_wait_queue(spw_in.wait_address, &spw_in.wait);
+		remove_wait_queue(spw_out.wait_address, &spw_out.wait);
+		__set_current_state(TASK_RUNNING);
+		goto try_again;
+	}
+out:
 	if (ret > 0)
 		wakeup_pipe_readers(opipe);
 	return ret;
@@ -1376,7 +1433,7 @@ ssize_t do_splice(struct file *in, loff_t *off_in, struct file *out,
 		if (out->f_flags & O_NONBLOCK)
 			flags |= SPLICE_F_NONBLOCK;
 
-		ret = splice_file_to_pipe(in, opipe, &offset, len, flags);
+		ret = splice_file_to_pipe(in, out, &offset, len, flags);
 
 		if (!off_in)
 			in->f_pos = offset;

