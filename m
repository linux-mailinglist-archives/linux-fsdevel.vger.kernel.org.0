Return-Path: <linux-fsdevel+bounces-23296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFA592A655
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 17:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884631F22472
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE0314D2BB;
	Mon,  8 Jul 2024 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AX/xL3fF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E64B14BF89;
	Mon,  8 Jul 2024 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454038; cv=none; b=qQNVEvlDHz94Pm8kE0D5tfqnqp69J1q2sIxgIUa6+E3eFhG7vNX/dE0BNzPLW/1uY8Mu2ud2XMPOI3+m08eVcJW/LqXup+1ervpR6wIXB6V9K+5g9PLdgrIG20e/pky4MA5IRTx1XbApYhMm2jeCQukZYN6dZ/500TJQgHVESxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454038; c=relaxed/simple;
	bh=3kjkEi2lp3qDJyH5rtduUEdM10TvHoB9LhQ8/+GSXaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=idqZkmVGsrw+jTC3nnOC/6jxlIvykZ4m0XTM+tyPeZ+zCjmoG6MEkyPrkqRXvhc78ym+gQ4hI1MA5cxLc8ZHXk5kzt55MogUZ4vdWGku1pjPwcxDTlKIKrAznUm1Eq7AumzqM3dHSwha3ERQhYJCvebLTfHY7kLN0nwZjuLnteg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AX/xL3fF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C387C4AF0C;
	Mon,  8 Jul 2024 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454038;
	bh=3kjkEi2lp3qDJyH5rtduUEdM10TvHoB9LhQ8/+GSXaA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AX/xL3fFvU92GisiPs6Zc+adSfi3GyzRCVxVZfJpqtiEvLxdhhF7U10nvmJ4UtyQR
	 fM37bQQPjdiwtSTcbdYn6LMjRFST5q5kd+Ew8F5fFLpiXChImlHCy0ELww42G7Y6RH
	 wAgMYrnoci9J+K2MPrLa3Ic22crAXJNDM+0W9xIzuRdAOgkRJg69GTE27Jij+j1EEB
	 yX7574tzzeUnnYY0aGKe7t0GaAJIpw6+NmA+fQIQl4zWPSileA0i8ZKGlYlonX//zw
	 osAZqb3+Zf2gTgvnVKUJho0qMxzZGfuCK4hOzfoNv3qEKgZVs+fKLTCIeHVSwA2RE5
	 XtVMN76HRT3Xw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 08 Jul 2024 11:53:38 -0400
Subject: [PATCH v4 5/9] Documentation: add a new file documenting
 multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-mgtime-v4-5-a0f3c6fb57f3@kernel.org>
References: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
In-Reply-To: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>, 
 Christoph Hellwig <hch@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6280; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3kjkEi2lp3qDJyH5rtduUEdM10TvHoB9LhQ8/+GSXaA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmjAuEvMLYjCZyHKB07a0DIX65Yy1lyjMtPYQsB
 p/ppuqsUWWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZowLhAAKCRAADmhBGVaC
 FbyGEACt5Is1KDr6nFAsnXhrK6hwHEq1NOHCSrSYTx0zl7StwaPcSBLXI3etbY+cCyHngFD1G2V
 wXXrArzYHOXmX2fDCkftgwk9nXB3Exz9eK+6UO2RGTxxYCFxNN8ihq49HApbfn9eFa2+P8x3Rh3
 uXzX61hR4Vz4awjOxZixbhwCpV5sK+2e1WmZvH1TpsQgC1e8GW45irlUQmj19a7h41VG2ybmKw8
 5JxJxJtnUIHo+7vhwIuLthwH4Mvmt52xiv7J8mJIHyYvdqk5SteVn6EE6tZW0jDN6isXwsVRdwh
 fWxuaYgXleqLfteDUy6bBwR43NMH8kjN52cXIyG9xNX9a3gWDUdGgwmuXivtr3+ZJ8rnLvlJwnb
 +efX02rU0puyV+QosluzdLooCovCu64XnDZ6vrxqRPj06EUWjDL68SkPKHQ3ekNwYX1GA+APb0G
 sxrG54P7Ef8l5JNWVN4rpgMVaoyNGmYLO70Nn/BBt/GoOcxPrR0T8VoFOFZmPe0ECBnmpvsVQCR
 sdjqsbNhIaNfMgOUwXF/YJzLsA1lzR0V+SDo9v1FyoQFqCXvwEkqDpeZoPZnHz2k+7ejgtkAvh8
 L6rxBrlqeM/1xx0J0fCFF54mCTJkZoD0x+DiGdTVzm3bjX6w7AQua19EFBoGTb25W6PQFSqmq3z
 mdHDbimn5AsAdIw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a high-level document that describes how multigrain timestamps work,
rationale for them, and some info about implementation and tradeoffs.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/multigrain-ts.rst | 120 ++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/Documentation/filesystems/multigrain-ts.rst b/Documentation/filesystems/multigrain-ts.rst
new file mode 100644
index 000000000000..e4f52a9e3c51
--- /dev/null
+++ b/Documentation/filesystems/multigrain-ts.rst
@@ -0,0 +1,120 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Multigrain Timestamps
+=====================
+
+Introduction
+============
+Historically, the kernel has always used coarse time values to stamp
+inodes. This value is updated on every jiffy, so any change that happens
+within that jiffy will end up with the same timestamp.
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
+In addition just providing info about changes to individual files, file
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
+Multigrain Timestamps
+=====================
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
+fill those values.

-- 
2.45.2


