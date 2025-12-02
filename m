Return-Path: <linux-fsdevel+bounces-70413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36499C99B0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 02:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D382A3A4007
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 01:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEF5136672;
	Tue,  2 Dec 2025 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTDP7Fsp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A5936D50A
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 01:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764637376; cv=none; b=Vkw2bm0wQoEYQkLlvD+Rf54qAjiThqKzOkyYHrZ+1mh3FhQdEfKLTYwCzO2SttgqmcuP6CUzpX2oppqRery72l4foaTe2H/co+h/qTmDUVjpdPztv4dPxvpe9uwuaf9Lg9/SDg3M8FC/UobI2p4XSj+kBMOU9Jnqq5lCAJFVCSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764637376; c=relaxed/simple;
	bh=r+jQAeRsocUxQ1t8ZGN71ctnJRA717umwq6kIzWfNiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9O/9SMrO9BvHaTuRpWWpu5mBsiRUdHtdUdl+SvaU7TbFHWzcsKXN+XvC+I2cBtGaYf9l3LonksVgIDIOuY/0wlw+RtV5YREFiVt42/vlSKyeIh2FvMdszMh4puo8gGdcP3jJTQ9MZuNmE0kptEuNBzq5mga2OH3Uq8NHiop5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTDP7Fsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE61C4CEF1;
	Tue,  2 Dec 2025 01:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764637375;
	bh=r+jQAeRsocUxQ1t8ZGN71ctnJRA717umwq6kIzWfNiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTDP7FspSmv29pBpXdP+DbFmqx0GO8yOKI5kL9T93AI0xiD441+vCFiiAEcDU0vci
	 OMqB20Mo5XAZw7ozM5TQY4RQ8XUmOYzEj5ehqAhcFihrHS9FKhFDt4BXXYeMe4MvD4
	 N/UuHxNCF9WAKMlwLncpYUZ86eVDGVzCUmlr3CD0tCv67q+u5SMP/r0h9d0529BOLA
	 WCnKuIrvYP7G5B3PN70G7A8bJoTxZnfwriXLKFEoxtiAZ74JVG8enUFWuQ4R6cHDCR
	 SoUvVx41L9YGA3KF1f+annOB68mPGwuCBryEuNSsVIac1tTmZXlVuPhZWN9lzCCuTh
	 Qk7CW7kO3pDow==
Date: Mon, 1 Dec 2025 17:02:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Tomasz =?utf-8?B?xZpsaXdh?= <tomekmsliwa@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: fuse: fix livelock in synchronous file put from fuseblk workers
Message-ID: <20251202010255.GC89492@frogsfrogsfrogs>
References: <CAD8i7BTJiGxp3YRjnyO3vzjcs+eW_uUZHdvtc32phHaJ0FdcbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD8i7BTJiGxp3YRjnyO3vzjcs+eW_uUZHdvtc32phHaJ0FdcbQ@mail.gmail.com>

[Please cc the community, not a single patch author]

$ ./scripts/get_maintainer.pl fs/fuse/
Miklos Szeredi <miklos@szeredi.hu> (maintainer:FUSE: FILESYSTEM IN USERSPACE)
linux-fsdevel@vger.kernel.org (open list:FUSE: FILESYSTEM IN USERSPACE)
linux-kernel@vger.kernel.org (open list)

On Sat, Nov 29, 2025 at 05:02:17PM +0100, Tomasz Śliwa wrote:
> hi Darrick,
> recently I updated kernel (6.12.41-gentoo to 6.12.58-gentoo) in my gentoo
> WSL installation and noticed that gui applications stopped working. During
> investigation I discovered that the last working kernel was 6.12.53 and
> 6.12.54 stopped working, so I started looking for a cause and it looks like
> your fix is somehow related to my issue.
> 
> I have attached a code that reproduces my problem when opening a
> file openat(…, O_CREAT|O_EXCL, 0600). I reproduced this bug(?) on my WSL
> installation using 6.12.54-gentoo kernel built from gentoo-sources with gcc
> 14 and binutils 2.5 (Linux version 6.12.54-gentoo (root@W-PF5652ZB) (gcc
> (Gentoo 14.3.1_p20250801 p4) 14.3.1 20250801, GNU ld (Gentoo 2.45 p3)
> 2.45.0) #1 SMP PREEMPT_DYNAMIC Sat Nov 29 10:34:00 CET 2025)

Urgh, what do the other fuse developers do about debugging Gentoo
kernels running on WSL2?  I don't have any Windows licenses, let alone
working Windows installs. :/

Could you tell which fuse server was the one that was livelocking?  Was
it virtiofsd, as was reported in the various wsl2 reports?

It would be useful if you happen to have captured a sysrq-t from the
livelocked system so we could tell what the kernel was doing (or not) at
the time.  And possibly also a coredump from the virtiofsd process so
that we could tell what it was up to.

<downloads virtiofsd source>

<sees that it's apparently written in rust and contains a Rust
implementation of libfuse>

/me sees src/passthrough/mod.rs:

    fn destroy(&self) {
        self.handles.write().unwrap().clear();
        self.inodes.clear();
        self.writeback.store(false, Ordering::Relaxed);
        self.announce_submounts.store(false, Ordering::Relaxed);
        self.posix_acl.store(false, Ordering::Relaxed);
        self.sup_group_extension.store(false, Ordering::Relaxed);
    }

AFAICT this function is called as part of a response to a FUSE_DESTROY
request.  Between self.handles and self.inodes, I think they both store
refcounted objects, which makes me wonder if the destroy function is
actually waiting for the refcounts on the handles to drop to zero?

Hrmm.  Commit 26e5c67deb2e1f ("fuse: fix livelock in synchronous file
put from fuseblk workers") changed the ->release behavior so that it
always queues the resulting FUSE_RELEASE requests in the background.
virtiofs fuse servers always set fc->destroy, so unmount will wait for
the fuse server to reply to FUSE_DESTROY.  Previously, the FUSE_RELEASE
requests were sent synchronously, which means there wouldn't be any in
flight when the server receives a FUSE_DESTROY request.  But now there
are due to the asynchronousness.  That would explain why reverting the
26e5c67 patch fixes the problem.

I can create a similar-looking hang by running fuse2fs in
single-threaded mode on a vanilla 6.18 kernel, which does not have my
patch to flush all pending background requests before sending
FUSE_DESTROY but *does* have my patch to libfuse to delay FUSE_DESTROY
until all open files have been released.

Can you try the following patch to see if it fixes WSL?

--D

From: Darrick J. Wong <djwong@kernel.org>
Subject: [PATCH] fuse: flush pending FUSE_RELEASE requests before sending FUSE_DESTROY

generic/488 fails with fuse2fs in the following fashion:

generic/488       _check_generic_filesystem: filesystem on /dev/sdf is inconsistent
(see /var/tmp/fstests/generic/488.full for details)

This test opens a large number of files, unlinks them (which really just
renames them to fuse hidden files), closes the program, unmounts the
filesystem, and runs fsck to check that there aren't any inconsistencies
in the filesystem.

Unfortunately, the 488.full file shows that there are a lot of hidden
files left over in the filesystem, with incorrect link counts.  Tracing
fuse_request_* shows that there are a large number of FUSE_RELEASE
commands that are queued up on behalf of the unlinked files at the time
that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
aborted, the fuse server would have responded to the RELEASE commands by
removing the hidden files; instead they stick around.

For upper-level fuse servers that don't use fuseblk mode this isn't a
problem because libfuse responds to the connection going down by pruning
its inode cache and calling the fuse server's ->release for any open
files before calling the server's ->destroy function.

For fuseblk servers this is a problem, however, because the kernel sends
FUSE_DESTROY to the fuse server, and the fuse server has to write all of
its pending changes to the block device before replying to the DESTROY
request because the kernel releases its O_EXCL hold on the block device.
This means that the kernel must flush all pending FUSE_RELEASE requests
before issuing FUSE_DESTROY.

For fuse-iomap servers this will also be a problem because iomap servers
are expected to release all exclusively-held resources before unmount
returns from the kernel.

Create a function to push all the background requests to the queue
before sending FUSE_DESTROY.  That way, all the pending file release
events are processed by the fuse server before it tears itself down, and
we don't end up with a corrupt filesystem.

Note that multithreaded fuse servers will need to track the number of
open files and defer a FUSE_DESTROY request until that number reaches
zero.  An earlier version of this patch made the kernel wait for the
RELEASE acknowledgements before sending DESTROY, but the kernel people
weren't comfortable with adding blocking waits to unmount.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    5 +++++
 fs/fuse/dev.c    |   19 +++++++++++++++++++
 fs/fuse/inode.c  |   12 +++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c2f2a48156d6c5..ba0d458b60fdcd 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1274,6 +1274,11 @@ void fuse_request_end(struct fuse_req *req);
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
 
+/**
+ * Flush all pending requests but do not wait for them.
+ */
+void fuse_flush_requests(struct fuse_conn *fc);
+
 /* Check if any requests timed out */
 void fuse_check_timeout(struct work_struct *work);
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 132f38619d7072..5fad7be3d0dc88 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -24,6 +24,7 @@
 #include <linux/splice.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/nmi.h>
 
 #include "fuse_trace.h"
 
@@ -2430,6 +2431,24 @@ static void end_polls(struct fuse_conn *fc)
 	}
 }
 
+/*
+ * Flush all pending requests and wait for them.  Only call this function when
+ * it is no longer possible for other threads to add requests.
+ */
+void fuse_flush_requests(struct fuse_conn *fc)
+{
+	spin_lock(&fc->lock);
+	spin_lock(&fc->bg_lock);
+	if (fc->connected) {
+		/* Push all the background requests to the queue. */
+		fc->blocked = 0;
+		fc->max_background = UINT_MAX;
+		flush_bg_queue(fc);
+	}
+	spin_unlock(&fc->bg_lock);
+	spin_unlock(&fc->lock);
+}
+
 /*
  * Abort all requests.
  *
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d1babf56f25470..5ca26358062f2b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2094,8 +2094,18 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 {
 	struct fuse_conn *fc = fm->fc;
 
-	if (fc->destroy)
+	if (fc->destroy) {
+		/*
+		 * Flush all pending requests (most of which will be
+		 * FUSE_RELEASE) before sending FUSE_DESTROY, because the fuse
+		 * server must close the filesystem before replying to the
+		 * destroy message, because unmount is about to release its
+		 * O_EXCL hold on the block device.  We don't wait, so libfuse
+		 * has to do that for us.
+		 */
+		fuse_flush_requests(fc);
 		fuse_send_destroy(fm);
+	}
 
 	fuse_abort_conn(fc);
 	fuse_wait_aborted(fc);

