Return-Path: <linux-fsdevel+bounces-30770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1FA98E30E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6621281D8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B99C21C18E;
	Wed,  2 Oct 2024 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvBH9LB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC26121C16F;
	Wed,  2 Oct 2024 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895014; cv=none; b=Uu5g0QNa9PMZOP3evj6LBS/wMIsxx690Cor0pXn5lxr7LR8KDh8MMVwfcI0mA6MkMSqeMrCIca8TIanKXsE8berZ98DVwHpro9SWrwgS972YUslsq+3AUa78AwY9Zad2DURrmmtPLy7AYT26JJwpDRtrCI3Nrv9fdV/jCrZ6c6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895014; c=relaxed/simple;
	bh=yU3ux0/2Dtj33S4oJe5U/3bWMbsd90MTGAANY4A51kE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C0gB/x3XfpDNGMpXl4JHQcjkVaXa+vJiuPih6KeZMmrUXOHkZrkyDsF83Rmg/rEvKoDHYbYaMSSHwz8J+8XfIg8rqwlff/kK5a97Zq+2mfwQMIjmOaLP+M5mZ7bMVZkIcNY0inF6iJi/7kbxW59DrLOhzXJfKf2dfBb+nwuOTo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvBH9LB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FC3C4CED5;
	Wed,  2 Oct 2024 18:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727895014;
	bh=yU3ux0/2Dtj33S4oJe5U/3bWMbsd90MTGAANY4A51kE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XvBH9LB2fmEjgRxUykO9Mmm5sj8iqfay0+A30RJBERXYirFJUXgSdeB259F90X6PF
	 oXNBts/3rpgqFkpclUGpTpAV7HpwOsfjyE06TclQoeCCL2rIRwAoCQwFxD0Pat0QTG
	 tr12tHICR1C2F2Axhdui82G5Xqa4gCQQEgPbuzemgii7wf302vlF36BY9MEszwBis0
	 mQR84ZKkMne3WdaUMa+1deCr3t5xJ9Fw/zBxfefkH46o4bzgfEDzLNfl/5fKdogt3F
	 VilUn4NJ1u2+At3B7NV8Xgu8M1/+rmJNBMmaGMIFd2TM6Vekj2whJLFXpYjBHN5qNb
	 36eQC74yhzrlQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 14:49:36 -0400
Subject: [PATCH v9 08/12] Documentation: add a new file documenting
 multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v9-8-77e2baad57ac@kernel.org>
References: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
In-Reply-To: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7290; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yU3ux0/2Dtj33S4oJe5U/3bWMbsd90MTGAANY4A51kE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/ZXMHmQlIM1XltglOKZZMLpcT3TrGf3O4cPbk
 2Y7Zl/tM/GJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv2VzAAKCRAADmhBGVaC
 FWtmD/4ljmJ5SjJ0YYZIgYOuuC1tG2m9LzbX5IH1G9yVu5KijxWOZWa6jl/6djpXxBIR/hXE+8J
 oQ15OQ5qJ19h9q7ixp9LTwzbhs0CRzMDQflyXtW2Pbl0fCd5/pKb3uXbwrEN8Bqc7Yz9EQB1sMo
 wSPhHCdR/h1Dl9W9yytIAlPr1mg6WqV9iynvU80v9VYF3vd/lM5BPd96ddlnnNDRBXvb+7xlOkA
 mtmzAxtOhcdSDKch71FVHYmJ3PR+uZGG8E5XfIRH3j1MfPW3YZgOelTOZ6DoiV6e83XYAUuMQm1
 wuna4OKC0zXlyFUUYiwyet/jt67VRc2ht8Q3QK+68wkQgROjSPTjoSr1iU/ypxH0RnPNBrMQdXJ
 Nqv99kKd9TmJPfVWt4MYxx0fes4+i/iWTsV9LEKbpU3EXU0KF/HyJnecw64V0rHLLDY+v2RP8HZ
 jQ5mBuKpRNtezbXYOzCBFri6HwyEUsmBl/6EG/r0n7M8neuxorWx8bkIdIvMWSLTJk8wqmWOyV8
 d6KZdZ9NDYkfOatQMbQfkiwIXsZTd9jnp1MUh+hYXcEyU0dtf8TJtTxInzPS1ZwuF83XFstwvCr
 vJs5e1foaiQdx7tMBIhFWmhzuZPmbqd/EW1C6sWjQg/r0qRDBvZx4Jk7oyesdhUotKyhorBc9pj
 ttfdObbsH8mEtVQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a high-level document that describes how multigrain timestamps work,
rationale for them, and some info about implementation and tradeoffs.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/index.rst         |   1 +
 Documentation/filesystems/multigrain-ts.rst | 125 ++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index e8e496d23e1d..44e9e77ffe0d 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -29,6 +29,7 @@ algorithms work.
    fiemap
    files
    locks
+   multigrain-ts
    mount_api
    quota
    seq_file
diff --git a/Documentation/filesystems/multigrain-ts.rst b/Documentation/filesystems/multigrain-ts.rst
new file mode 100644
index 000000000000..c779e47284e8
--- /dev/null
+++ b/Documentation/filesystems/multigrain-ts.rst
@@ -0,0 +1,125 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Multigrain Timestamps
+=====================
+
+Introduction
+============
+Historically, the kernel has always used coarse time values to stamp inodes.
+This value is updated every jiffy, so any change that happens within that jiffy
+will end up with the same timestamp.
+
+When the kernel goes to stamp an inode (due to a read or write), it first gets
+the current time and then compares it to the existing timestamp(s) to see
+whether anything will change. If nothing changed, then it can avoid updating
+the inode's metadata.
+
+Coarse timestamps are therefore good from a performance standpoint, since they
+reduce the need for metadata updates, but bad from the standpoint of
+determining whether anything has changed, since a lot of things can happen in a
+jiffy.
+
+They are particularly troublesome with NFSv3, where unchanging timestamps can
+make it difficult to tell whether to invalidate caches. NFSv4 provides a
+dedicated change attribute that should always show a visible change, but not
+all filesystems implement this properly, causing the NFS server to substitute
+the ctime in many cases.
+
+Multigrain timestamps aim to remedy this by selectively using fine-grained
+timestamps when a file has had its timestamps queried recently, and the current
+coarse-grained time does not cause a change.
+
+Inode Timestamps
+================
+There are currently 3 timestamps in the inode that are updated to the current
+wallclock time on different activity:
+
+ctime:
+  The inode change time. This is stamped with the current time whenever
+  the inode's metadata is changed. Note that this value is not settable
+  from userland.
+
+mtime:
+  The inode modification time. This is stamped with the current time
+  any time a file's contents change.
+
+atime:
+  The inode access time. This is stamped whenever an inode's contents are
+  read. Widely considered to be a terrible mistake. Usually avoided with
+  options like noatime or relatime.
+
+Updating the mtime always implies a change to the ctime, but updating the
+atime due to a read request does not.
+
+Multigrain timestamps are only tracked for the ctime and the mtime. atimes are
+not affected and always use the coarse-grained value (subject to the floor).
+
+Inode Timestamp Ordering
+========================
+
+In addition to just providing info about changes to individual files, file
+timestamps also serve an important purpose in applications like "make". These
+programs measure timestamps in order to determine whether source files might be
+newer than cached objects.
+
+Userland applications like make can only determine ordering based on
+operational boundaries. For a syscall those are the syscall entry and exit
+points. For io_uring or nfsd operations, that's the request submission and
+response. In the case of concurrent operations, userland can make no
+determination about the order in which things will occur.
+
+For instance, if a single thread modifies one file, and then another file in
+sequence, the second file must show an equal or later mtime than the first. The
+same is true if two threads are issuing similar operations that do not overlap
+in time.
+
+If however, two threads have racing syscalls that overlap in time, then there
+is no such guarantee, and the second file may appear to have been modified
+before, after or at the same time as the first, regardless of which one was
+submitted first.
+
+Note that the above assumes that the system doesn't experience a backward jump
+of the realtime clock. If that occurs at an inopportune time, then timestamps
+can appear to go backward, even on a properly functioning system.
+
+Multigrain Timestamp Implementation
+===================================
+Multigrain timestamps are aimed at ensuring that changes to a single file are
+always recognizable, without violating the ordering guarantees when multiple
+different files are modified. This affects the mtime and the ctime, but the
+atime will always use coarse-grained timestamps.
+
+It uses an unused bit in the i_ctime_nsec field to indicate whether the mtime
+or ctime has been queried. If either or both have, then the kernel takes
+special care to ensure the next timestamp update will display a visible change.
+This ensures tight cache coherency for use-cases like NFS, without sacrificing
+the benefits of reduced metadata updates when files aren't being watched.
+
+The Ctime Floor Value
+=====================
+It's not sufficient to simply use fine or coarse-grained timestamps based on
+whether the mtime or ctime has been queried. A file could get a fine grained
+timestamp, and then a second file modified later could get a coarse-grained one
+that appears earlier than the first, which would break the kernel's timestamp
+ordering guarantees.
+
+To mitigate this problem, maintain a global floor value that ensures that
+this can't happen. The two files in the above example may appear to have been
+modified at the same time in such a case, but they will never show the reverse
+order. To avoid problems with realtime clock jumps, the floor is managed as a
+monotonic ktime_t, and the values are converted to realtime clock values as
+needed.
+
+Implementation Notes
+====================
+Multigrain timestamps are intended for use by local filesystems that get
+ctime values from the local clock. This is in contrast to network filesystems
+and the like that just mirror timestamp values from a server.
+
+For most filesystems, it's sufficient to just set the FS_MGTIME flag in the
+fstype->fs_flags in order to opt-in, providing the ctime is only ever set via
+inode_set_ctime_current(). If the filesystem has a ->getattr routine that
+doesn't call generic_fillattr, then it should call fill_mg_cmtime() to
+fill those values. For setattr, it should use setattr_copy() to update the
+timestamps, or otherwise mimic its behavior.

-- 
2.46.2


