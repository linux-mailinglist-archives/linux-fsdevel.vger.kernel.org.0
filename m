Return-Path: <linux-fsdevel+bounces-58435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12202B2E9BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCAB3B6AA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773E11EF38C;
	Thu, 21 Aug 2025 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6fAYsua"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D347C18991E;
	Thu, 21 Aug 2025 00:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737456; cv=none; b=BGdnVr2Ua2vkVdeZcAg33YQ0SVXCf4ApbZSdFGKI6VOhcQL6gWjo3Ocea6ltRcklsMzYOhtW6c1m6rfoz9VOnluVIiSSWg+O1E7ifhpzDtwHHOf3lsvchEi2m+uyPUpbbUKEuMeYxUReHTPCfFg1QpyT/PBZW+vgnmgV4kwj0rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737456; c=relaxed/simple;
	bh=wjJ1d2n6n9UC6ILcOJaialqZVZHmYoxfOzdx3Po3SLQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsAaeJY6jyF1lGnlFFqBHBiLNyKN0xtGQA/cqoBBF+EZuPCRhTUgO8/cnHakp4Maj54yj4GVM5BFIof/Y8MFYB4sAfz0fmk/v/9hZcf2+TCzntxamrFS2CHhfQdJsDT9zlsuzgR8MlX7of5oHQyYuOSfTKRWs/9hcDZzOXzZvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6fAYsua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDF5C4CEE7;
	Thu, 21 Aug 2025 00:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737456;
	bh=wjJ1d2n6n9UC6ILcOJaialqZVZHmYoxfOzdx3Po3SLQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=R6fAYsua6Sm8jgcfEc5WphORKGHRwfMxlHTIjz78vIEKmmougsqGpDilLPjqMuG0w
	 1CzrPlEZVfipVK76r7tfRX5UmklySgPCm1fp6lM2Vw5iYSqNly6r1XFjRFcc8lZOyZ
	 XssyzVQHCbhyLEf7dvl0+YpQ465q0jBCXO2qaW5NqaXeVYhuACE5uXg5ZBbqa4SzIe
	 Y8Fk0iK/N1J5didgnssSPO8iwTP3FgfwVpujZPrpducYcHfR9l2rMWyf48wEEtvOAF
	 QnpSNXkzEaRDchc6V0JTWJ0z4GS2OsRUCyScLnV+ih4ZWTN2ojQ2xsZB6dKZoxOd3S
	 nQiZ2bQI8Oo+g==
Date: Wed, 20 Aug 2025 17:50:56 -0700
Subject: [PATCH 1/7] fuse: fix livelock in synchronous file put from fuseblk
 workers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: stable@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev,
 John@groves.net, linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573708568.15537.7644981804415837951.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
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

Cc: <stable@vger.kernel.org> # v2.6.38
Fixes: 5a18ec176c934c ("fuse: fix hang of single threaded fuseblk filesystem")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5525a4520b0f89..0ba2b62e06679e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -356,8 +356,16 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
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


