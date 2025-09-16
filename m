Return-Path: <linux-fsdevel+bounces-61493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CF5B58928
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965191B228BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87F41A0711;
	Tue, 16 Sep 2025 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsiQveps"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E4625;
	Tue, 16 Sep 2025 00:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982258; cv=none; b=d41gN9naJR3qQJd8hVpm1qxFZxUZ7AcsmyRxY0yxkUmJlDidw3Q3KUyX6e6twX1OYK410C+sVBGnt6jkQtZE1AwANMEPmGOIzMz4l8XXLMpqbkpDsHwTc2fNbWApX9+FpSpYt2iCzMzgr7Rcmc7+s35zD7Xdti+wB4cfLz0l6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982258; c=relaxed/simple;
	bh=Ws5Wm1EF+wN+uMQA+/tf4b8VRo46HYuXpBLCUlFLE9E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUfA2m+AzrWSE0AKvN49L723Q6zpxk/DWx69UaxJEEBiAAgKo7/CEGf8B57SGY487eZSFt1ZPVU4QN6iF4l35qGkw2H7AZ5S77IlTI1MuCxd01psfqttOBuIDFb5kA+l2hOpFLTcm89mc6C/UMHiyVDQnpwXKl3ax/XnKjDIGuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsiQveps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA736C4CEF1;
	Tue, 16 Sep 2025 00:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982257;
	bh=Ws5Wm1EF+wN+uMQA+/tf4b8VRo46HYuXpBLCUlFLE9E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GsiQvepsvuunh9JE9sJfVw7srvOJ//rCL+4N0Jea0EKJfXB4CXm8m0zhjjlfevt75
	 2oIsCTDr9fJ3dqAkrm5RPS0kd1cdwHQnebzu5ssFkGYMOJMhOS0qZB3NUErqjgqael
	 VsCjl/ewXaBEb4imsDnjNIaHuEgGnb7HYjoUa362HqRAlqgwniT7DT7JWsvJT+Meyd
	 X8/SsLi9U1Ppfu/eijY+IUYSNKl/X5gBNNwep6C3s/RwL6T6F2cZ0SGmtYAsAzzSz4
	 Ljzz9wjW8LQ+0y1Eq0jfQquqSnmGpyVJ6+BpJdAt2rF/jctmMC5DXWDgR+Zx0EZ0yi
	 OG1bT2D03O+YQ==
Date: Mon, 15 Sep 2025 17:24:17 -0700
Subject: [PATCH 1/8] fuse: fix livelock in synchronous file put from fuseblk
 workers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: stable@vger.kernel.org, bernd@bsbernd.com, linux-xfs@vger.kernel.org,
 John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
 joannelkoong@gmail.com
Message-ID: <175798150049.381990.18237050995359031628.stgit@frogsfrogsfrogs>
In-Reply-To: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
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

Fix this by only using asynchronous fputs when closing files, and leave
a comment explaining why.

Cc: <stable@vger.kernel.org> # v2.6.38
Fixes: 5a18ec176c934c ("fuse: fix hang of single threaded fuseblk filesystem")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4adcf09d4b01a6..ebdca39b2261d7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -356,8 +356,14 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * Make the release synchronous if this is a fuseblk mount,
 	 * synchronous RELEASE is allowed (and desirable) in this case
 	 * because the server can be trusted not to screw up.
+	 *
+	 * Always use the asynchronous file put because the current thread
+	 * might be the fuse server.  This can happen if a process starts some
+	 * aio and closes the fd before the aio completes.  Since aio takes its
+	 * own ref to the file, the IO completion has to drop the ref, which is
+	 * how the fuse server can end up closing its clients' files.
 	 */
-	fuse_file_put(ff, ff->fm->fc->destroy);
+	fuse_file_put(ff, false);
 }
 
 void fuse_release_common(struct file *file, bool isdir)


