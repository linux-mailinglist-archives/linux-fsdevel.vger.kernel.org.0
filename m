Return-Path: <linux-fsdevel+bounces-55314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2D5B097D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBB51895DCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3894925A33F;
	Thu, 17 Jul 2025 23:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNBTF2VD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96517241667
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794799; cv=none; b=AyhR5rJaeTAytNWVWS3XxkKIytlNZt3qJc8hm3J/nQLfPc7JwJ1ohTzrxAFGcQT65sq90gjqkerPT/pl6zlQk5h9ukBJBsibCQ8kY8Kp+bgkzjDPFD8aDIH8j6A9ef9Jmq2/szH1aPyleEFtTB1PB6WmbnhMpFXcgb1dorRdUEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794799; c=relaxed/simple;
	bh=AEYPHnhz1GLfPcMcRaLMGL99irRtb/YWuN1tn/K3BsA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0/Zn44P+JE3584LSJ06KQtH8K/R1/P+2mj9fgMHIguVO1O032gu9rY0PhkM8eKvTLRj3QXfulhDftfDqZImKgo9r3EV976ijjz/iEiGcYC9P3MUHsYjlORzqxS7O2D/7mfGkj97myaw/WUhy3frS6QQ5Kmu6AjlxmwSuUL2s3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNBTF2VD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EC5C4CEE3;
	Thu, 17 Jul 2025 23:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794796;
	bh=AEYPHnhz1GLfPcMcRaLMGL99irRtb/YWuN1tn/K3BsA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YNBTF2VD919Hv9vIT0TrE1jPOl6ubiJ3xzKCQhZrXpZwI3iRwyabeJAM3eX3PEdE3
	 tjdJ3mLdRciXtnz0TqPInz3gafZu7NnT+OFK645n3Iv1jcfn7m6Xr5S7G/cRpE+Y8I
	 rVIQ4lV/KmJ832iMiMq7iep9bFo1mIFpfR22jh9nZtedgIimopYOnbicALwHQS6G2f
	 OVFiKJifFWBYPKGKWJ8MByJQBOfHIZ0avdqieoFUcOJkJ9ZZNOnRJnL8AW5WyjQiwJ
	 lUaROjMEfGnGeonXnTLfouLQEwOBwYrOhXBxjg6JIXrqy0N/YBO4f1NTtdgMBvevWd
	 a+k0hfzGBoHkA==
Date: Thu, 17 Jul 2025 16:26:35 -0700
Subject: [PATCH 1/7] fuse: fix livelock in synchronous file put from fuseblk
 workers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279449480.710975.8767104113054819157.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

I observed a hang when running generic/323 against a fuseblk server.
This test opens a file, initiates a lot of AIO writes to that file
descriptor, and closes the file descriptor before the writes complete.
Unsurprisingly, the AIO exerciser threads are mostly stuck waiting for
responses from the fuseblk server:

# cat /proc/372265/task/372313/stack
[<0>] request_wait_answer+0x1fe/0x2a0 [fuse]
[<0>] __fuse_simple_request+0xd3/0x2b0 [fuse]
[<0>] fuse_do_getattr+0xfc/0x1f0 [fuse]
[<0>] fuse_file_read_iter+0xbe/0x1c0 [fuse]
[<0>] aio_read+0x130/0x1e0
[<0>] io_submit_one+0x542/0x860
[<0>] __x64_sys_io_submit+0x98/0x1a0
[<0>] do_syscall_64+0x37/0xf0
[<0>] entry_SYSCALL_64_after_hwframe+0x4b/0x53

But the /weird/ part is that the fuseblk server threads are waiting for
responses from itself:

# cat /proc/372210/task/372232/stack
[<0>] request_wait_answer+0x1fe/0x2a0 [fuse]
[<0>] __fuse_simple_request+0xd3/0x2b0 [fuse]
[<0>] fuse_file_put+0x9a/0xd0 [fuse]
[<0>] fuse_release+0x36/0x50 [fuse]
[<0>] __fput+0xec/0x2b0
[<0>] task_work_run+0x55/0x90
[<0>] syscall_exit_to_user_mode+0xe9/0x100
[<0>] do_syscall_64+0x43/0xf0
[<0>] entry_SYSCALL_64_after_hwframe+0x4b/0x53

The fuseblk server is fuse2fs so there's nothing all that exciting in
the server itself.  So why is the fuse server calling fuse_file_put?
The commit message for the fstest sheds some light on that:

"By closing the file descriptor before calling io_destroy, you pretty
much guarantee that the last put on the ioctx will be done in interrupt
context (during I/O completion).

Aha.  AIO fgets a new struct file from the fd when it queues the ioctx.
The completion of the FUSE_WRITE command from userspace causes the fuse
server to call the AIO completion function.  The completion puts the
struct file, queuing a delayed fput to the fuse server task.  When the
fuse server task returns to userspace, it has to run the delayed fput,
which in the case of a fuseblk server, it does synchronously.

Sending the FUSE_RELEASE command sychronously from fuse server threads
is a bad idea because a client program can initiate enough simultaneous
AIOs such that all the fuse server threads end up in delayed_fput, and
now there aren't any threads left to handle the queued fuse commands.

Fix this by only using synchronous fputs for fuseblk servers if the
process doesn't have PF_LOCAL_THROTTLE.  Hopefully the fuseblk server
had the good sense to call PR_SET_IO_FLUSHER to mark itself as a
filesystem server.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 47006d0753f1cd..ee79cb7bc05805 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -355,8 +355,16 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * Make the release synchronous if this is a fuseblk mount,
 	 * synchronous RELEASE is allowed (and desirable) in this case
 	 * because the server can be trusted not to screw up.
+	 *
+	 * If we're a LOCAL_THROTTLE thread, use the asynchronous put
+	 * because the current thread might be a fuse server.  This can
+	 * happen if a process starts some aio and closes the fd before
+	 * the aio completes.  Since aio takes its own ref to the file,
+	 * the IO completion has to drop the ref, which is how the fuse
+	 * server can end up closing its own clients' files.
 	 */
-	fuse_file_put(ff, ff->fm->fc->destroy);
+	fuse_file_put(ff, ff->fm->fc->destroy &&
+			  (current->flags & PF_LOCAL_THROTTLE) == 0);
 }
 
 void fuse_release_common(struct file *file, bool isdir)


