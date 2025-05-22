Return-Path: <linux-fsdevel+bounces-49607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57267AC00E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65E11BC3D34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62507320F;
	Thu, 22 May 2025 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gc2tYIDj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E2EC5;
	Thu, 22 May 2025 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872162; cv=none; b=A3nczQixkoYWMbrxVU6zjOyAUKIR9a/Iz/bUpRJhd/LiDZ6KXrKOVWadv+35jmA7d5wHlaAi3V9VKsL0DKPWvBDFsO88A8l2QZqUeN7cAV3T6UNE4sLEuwCSXN/+/33yUp5aMI0DrNY8ZEkV/iwZJrfSVdOT299AkIMByNEe290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872162; c=relaxed/simple;
	bh=cBq0PnEtICflZNparBoaPCSIEDEZbzk++xX6slF199U=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/FozTBhTOqVlf/x8Oq/6y+L2ruAn1rD5GLTIwxsXYn9mPXHSb3X0R7VZGJZ+ku0FPJxRl3oJea+RVl3vpiZrTy4Or3y2oJWSd/KfBx7T0Y9p+2QYek4DXg86M3lNx18xUKxUVKGuien2EVTRG7zHPDOZLClxM0ew5f1/w4wHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gc2tYIDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344C5C4CEE4;
	Thu, 22 May 2025 00:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872161;
	bh=cBq0PnEtICflZNparBoaPCSIEDEZbzk++xX6slF199U=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gc2tYIDjjwKKRVKsrW/8fUelqQ9mZqBJjWRbNP0fD2XvLPYlv5/4h4jYu3ZsAiMev
	 vglUpn7RaeSgcBiqvFL6kvJYUI5rMr0y3Bc/dbxpEVRFwy0+aePVtRYrgSfVeKNSMi
	 6gmEKeBxkGJeMOkiFFqhJiACb6+zYcs0hV3EgfsHR7HNL/br3oVDueSqzE4LMCIdR8
	 ykrTIkrEJd3t7IwbfIqdv17PLp7bix2z3HFTJzo4De2uJQ24M2W+aglXPLb/eYk18W
	 ALIVm5AZ3FpVjTiBI7l5u6+LQE1rhaICj5urS437BVUevopu/uK4q5hAjL2t9HiNDz
	 84RH0uwN9+1WQ==
Date: Wed, 21 May 2025 17:02:40 -0700
Subject: [PATCH 01/11] fuse: fix livelock in synchronous file put from fuseblk
 workers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Message-ID: <174787195588.1483178.6811285839793085547.stgit@frogsfrogsfrogs>
In-Reply-To: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
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
index 754378dd9f7159..ada1ed9e653e42 100644
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


