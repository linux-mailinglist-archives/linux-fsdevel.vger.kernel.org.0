Return-Path: <linux-fsdevel+bounces-29324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D9F9781CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919411C2111B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311751E00BE;
	Fri, 13 Sep 2024 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWcayPO0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CB11E009D;
	Fri, 13 Sep 2024 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235680; cv=none; b=rgUbMJnyBHAPkhetMResR13s0c2l1qap8jx9gjo2tyu9zz50WzbnNP/qis788akpcXziw/174hpuUhjPjKPdY8MRByFiItJLrGHq5W/hz66LPfF7iyM+I+itIAqvURn3kjpO7T9AEFZygqaVJtxwMQiNiZvsLJ+R2zIj2WZ1eG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235680; c=relaxed/simple;
	bh=/XcZHkK5gYpUwCSVg7s3+A6XUqyCAQD/OQvh4jjSlT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sVUep616DqZ/88pGW/WRr1hK79cqBDdzQQRD1T4h9okYwEOmaJLfbzCCvU2izoz2aM6khFMYdJbg4p0qMx9TeDulUTukQREeEOp1eM2A06TCfHtEyj9dZtkR92usF+UQkZzl1UX0+QUS6xhc51BXbvNcjmWtPEgl1BSKGOPmCyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWcayPO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836D6C4CED0;
	Fri, 13 Sep 2024 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235680;
	bh=/XcZHkK5gYpUwCSVg7s3+A6XUqyCAQD/OQvh4jjSlT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CWcayPO0BREmELx+qbla/1UkRoRXru8vfwvasAmBHs3OEmTzi5w2AeX7jA7cT8U4X
	 38UavtmBwMs4Ja9lM0InjsPOHCQYdbHPXzXSNkqGpTbgrcKWdyDC5GIu0bdj+bfJHh
	 8wmPVsXgw3nSgXsaEhE3Y8MvlFO4lshs8i52xCovEQwqU9BKge+LMFg/7qKGDnoMKE
	 hGJAYizGYMPUSBbisaxLn+Eahr1+0bmRu/0l+o7CwDdN5/hS4EMu1ctLVpD216wUDI
	 9eMnXTM2Z/VO5BetJBI5Mruuqpz/wYGvkwPU6yaYvBBjoFwclUCzlXzemGEpWdqNi3
	 m/oDF1pr+zOJw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 13 Sep 2024 09:54:16 -0400
Subject: [PATCH v7 07/11] Documentation: add a new file documenting
 multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-mgtime-v7-7-92d4020e3b00@kernel.org>
References: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
In-Reply-To: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, 
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
 Jeff Layton <jlayton@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6998; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/XcZHkK5gYpUwCSVg7s3+A6XUqyCAQD/OQvh4jjSlT8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5EQJ1zvz7D6LAhdnOHcJnvHOQRJ7Pg8fD+uTz
 utfCHBIZWeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuRECQAKCRAADmhBGVaC
 FbvsEACoJHq00HMhA20PmQVbSRdg1FHnGuaUNQHBn66D636/VgZoSV8WgJu70G84vvFDIevbKMV
 bFejZ2F0n4EZC2z9z4DSA7SXYHnBQihlV1uN9+91voMzQBrwZhoh/yaACJnKLo/hKd/GtU+bkZk
 8q243t6sBl3Eej7xrnY1QkNKSt2LOay+KR9I13PRrXaZFILjykvrWtMO1m5d6MmT4yZG2x20pQh
 imTIRKqSrIDYq286AkvABlR5bF/bfMYlYbjh5uJejc2wAHixNrvkfkdLDcFUzAhIIJZO65WkZt9
 6W589fBgMuRCGwXyK/fuomY//FGkaNhGgTO3n7ncI2MDthotR8AE3bi/kz6SJdA/KSABtbb86fE
 JOq0YejwvQ4jJwSot5799C85AOQakU/9RUJfbPrwZxh8caEfoqEteLrAiOqWI5tsHAKDOA0PalM
 zypILvN5pYhWbwnlW+I3rWyle2v+gMoa2AGGTyvmiAvNQzMmYB/j2+9a2cV9EEhm0ullKHsI7YR
 vamW0vUHCs2OEnNlxEGOYNcVc7nbkkKLHDQu+URoB0ovON8waJcGlXaOw3g6bYcf4cfJwRa701g
 e0sTRqk60QYnQ8QZMnNApaO0I3y4ahS5bMkns5vJ+Kv5uIfLiA2TXW9xw6qE3VTzctsRft6s/IK
 Y4jJ9dKvqkO7iJw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a high-level document that describes how multigrain timestamps work,
rationale for them, and some info about implementation and tradeoffs.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/index.rst         |   1 +
 Documentation/filesystems/multigrain-ts.rst | 121 ++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

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
index 000000000000..97877ab3d933
--- /dev/null
+++ b/Documentation/filesystems/multigrain-ts.rst
@@ -0,0 +1,121 @@
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
+To mitigate this problem, we maintain a global floor value that ensures that
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
+doesn't call generic_fillattr, then you should have it call fill_mg_cmtime to
+fill those values. For setattr, it should use setattr_copy() to update the
+timestamps, or otherwise mimic its behavior.

-- 
2.46.0


