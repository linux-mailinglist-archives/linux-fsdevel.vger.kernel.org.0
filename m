Return-Path: <linux-fsdevel+bounces-30794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D9C98E524
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB6B1F2122E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F12207F8;
	Wed,  2 Oct 2024 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZdd5t/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976A21F438;
	Wed,  2 Oct 2024 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904473; cv=none; b=XLV0IZnDBGcJ64izGb4DEpUNaHs6AmAASsg9VmN8jXyeg4KejYN4Y0YRNZSZW+3L+WsNoZO5NdsA0v71x6rYJ/OwjNxigG0/8hTgvtwiC/0P0zXYbiMY1kejU+ndUxnTS7QzzEYP/UanHZckdkgxYkV5JKf+kNYlbOBHLx93nMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904473; c=relaxed/simple;
	bh=qBtzxV6C3gNnpXcNznor+GUfZID0zTF7K3hXwvPKJ3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D422JGoR2ZRyLl/O0q4IZMwnBwSZD9u7u0OPmygkJCIFI5d3KzMPnAVOUDXYqLT5ZhCViJ7qyn2ocCvS7UdoN6anSci3PUDLmufr4My83HLGDjCyGRHt1B6vLiA0GFsWjHnk3uHJVqstkyXGQN2U03nZYtrnwdLQlDWL5+nWKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZdd5t/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD5AC4CED6;
	Wed,  2 Oct 2024 21:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904473;
	bh=qBtzxV6C3gNnpXcNznor+GUfZID0zTF7K3hXwvPKJ3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tZdd5t/FDA6BUDMKhuyJUMzgrU7Dj+ArevBTpINQ/kUw0bID2yhWKQpKYebxZG9T4
	 2HlHzHF/uJLRfFA19ndqG3latGrn/u720RlCJbM13CK23otWdgZtsYGMvwyX8ndXZ/
	 H8igGJd+Yl0+pDHWi/44IMj7dMBiuhLvFzott0kklgeHKAfK+g3pmdflyDlxJOH9sA
	 y36edvjXMAAWajMoebqCmpJp8QVaBZpMdHVODRyfbSppMXtTxwys10nWxxlpiHuZh2
	 OjTH5zGsziWEHSHh8x/FV255nV5xQkP6RCuEJqa0VcmQfpX79TKxcTXe8XDQZ4pnx0
	 qZT1ErIW9PRnQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 17:27:23 -0400
Subject: [PATCH v10 08/12] Documentation: add a new file documenting
 multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v10-8-d1c4717f5284@kernel.org>
References: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
In-Reply-To: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7402; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qBtzxV6C3gNnpXcNznor+GUfZID0zTF7K3hXwvPKJ3M=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/brA6I1dI8EG/U2Sb1UisGHQiXpPg4GwgYbr8
 hjnuAbXthWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv26wAAKCRAADmhBGVaC
 FV/tD/9X5pKIVIniCMvGql/J6WLFzqLMJ1KN/xNGXflDxvxSCtFhy3Bk+wgy5xigEQNhlpabOFn
 LQ6qkRRkug8tMq2+YV3w5KKcCNUzqBJg51UTT2r48f95rUtSl+q3B5N79OsZ1HzK7fkCD99+xaO
 P5DiED3DEtbfEhbsGCRpRyjrpKWqS5dCYV+3ggmpHv5XXtmAJMicDBzW443AVoks3ua0yvhF7/v
 dpd86poXepdu9zB2qA1wm17Skp5Paejf+WJXi6ilJOoIjZYVmhmzs9p/u/XmvpWtFuOlnGN4Gou
 Is4gcsCS1Zbpocaf+FWUf4TZDeQ3tCqb7LlmMFHRcO9MWqKJaKiSeqkdlHcs56K5MPzYnvjq1Gl
 lXJJjYPdgzD6ZldrFYidpzx3sDvknnjR6lvvo7lbI6dU3QPIMx77R8vd5REqp9nuMZKx4xZXVPg
 V/vtq7O0C+m6q3YCj+PYh0EYBY4I5Q2YBCG6RlOR2pJUdwPZ731ke2R3gPtm9qp+6WBj4rdEymx
 oj2xDpllQcSOV4ieVhIL2b7GOsIObiy7LKiLmekwwpazRph8l9tHk0krQvvZw8cK93TUpfYK3VC
 Ll8T6GXHeXnAko/UaPT9+Xd/1TjOj7hVYYRKN+Id8tDiGX9GQPRy5BPJgcW2zD79/af/mEp1NiZ
 QYYMHRnTwY+vL7A==
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
index e8e496d23e1dd5b523889159b464d7adf5d5c30a..44e9e77ffe0d4b9c85f9921190d33dfd21acff8f 100644
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
index 0000000000000000000000000000000000000000..c779e47284e80f54ad9fc8a6a0b03228dbbf3d59
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


