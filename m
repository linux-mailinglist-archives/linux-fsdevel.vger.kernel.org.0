Return-Path: <linux-fsdevel+bounces-22866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03F91DCC1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF14285318
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00D915B97B;
	Mon,  1 Jul 2024 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6GNnASo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60915B14F;
	Mon,  1 Jul 2024 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829654; cv=none; b=lzHfx6+NyQPrrf/bGXf5xf5o8+Gco+mbVAuXLrX4KACh/PwuL7go8UdM9tfdEgUt3sdUAKasnlgeoinn97ZeyHAIYKaHtPHcSmu1cF2B+UyNIoTN1muAI3/F0b6hcDMi0OeW76B23LPDGue1rR+Zno35TYJ1yMasi+k3ZvaOpHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829654; c=relaxed/simple;
	bh=yGbFoI0x64Criq5hVXpnf8cTDkEYS+drfXiF9/4UXTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mTE37RnGBtfVOi9d+2VjpFajRZt2en2vR4FKluwaydpzfuNVpgK8vftEmLa6bAdf3Th0C79ldS11gG1+YL6jZ0a/9JtA1/k5o7H0YBCF7Z2vm8ErxqGc1lueCi1SfhX1hlpU8jm/b3jbsct7c+9ZJZxBYT4NmZSf5tAaWM6EfKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6GNnASo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947F5C116B1;
	Mon,  1 Jul 2024 10:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829653;
	bh=yGbFoI0x64Criq5hVXpnf8cTDkEYS+drfXiF9/4UXTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z6GNnASo0fot0PtERrcGCWLqCNkhG+ti+9IgcG2z62xbIC1ym5I817maTy4fkKhbY
	 R2soLnBsN9ntBuRXtGUYtbUxBrvdurk/E0KX7EbbDmjOFHzMmSyo90wX0FwClonR8X
	 P4RBkhzh+f0YRGrqIUSoKG7uVfAoeaEL0Ss0NQOw6/1RUJIexOvqBArjV7Pm3HKK+T
	 ELGB782hclQDbjeAOXe38I7SPtwUvE2y977540crj+h57ilap+jopmlWAGnCDy6jcC
	 lu8QPn3FZYpTj4N486u8gYzuOufgDmx/UFNBSoDMzdpGwk8GFl1VmaMqBSCpZXUEsG
	 h//393LSr0nGQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jul 2024 06:26:47 -0400
Subject: [PATCH v2 11/11] Documentation: add a new file documenting
 multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-mgtime-v2-11-19d412a940d9@kernel.org>
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
In-Reply-To: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6401; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yGbFoI0x64Criq5hVXpnf8cTDkEYS+drfXiF9/4UXTc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmgoR51H+Vt+Exq9KPckzpWSJI72DyZw39g58HZ
 6vgl2QTkO+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZoKEeQAKCRAADmhBGVaC
 FUgRD/9lsIjZK2rTJJTMM0K7QsIaOP3fGuxn3FJzgS/8fA0BxnWEFHyOjfHbW7G8Pk2e7T3FUtF
 eRaFdjrKm58/m+Pri5Gimbl9u0L3k8bs3OwWdfEHjjd3vY8dBeCHDYsyOOU96h0C8YAeLXYKW7v
 awrdt160eBzPfrVCLR+PYf0Nr2R5N1w4tTp8UCEaSy8BhOhiWHE5yEU+0dILaoEVaKub1bwYVjV
 mPVEWbsALVgC3JDWdkI4JTid9yXq+2fKgyT8ZRN9DuQqtfhetl6akwSxiTy2ZhYjQWXn4MwseN+
 Sl42qLYCNzrpb+I3GsuPzd4w3YrijPaS2vDQ82BPfRbQqqj+64kR1zd/yjaqoWMcp0YB5VEUnGO
 l8uyRah0FF1rQNatV4c+a/SpXu1jdNXXtOG6rlSN+0Vih1+1Q/miYBQH6ApBVf+QJxDKzXW10YR
 ywIi+5WIwTwVnTTUoJdTzKDyW7vSlMCR/n50SSiuX9vYI7wm5/wi5HL/+KT5Idgv29ro6UPca5C
 tuQZld6B1HnPwUHD0E34Slj4q9H2YbmDz2UYLavQK9GWVOSWvyVApcHSF74iwlV6XMnozuLwVRs
 iOP1aC1GI5fBD0AJrcgAxYw/xjmU0slyWE7EPk6otXIYcdc4Qrgc4cWAu3TP2Cu6Kw7o6A269Hq
 VCQ37btdGTtuEEA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a high-level document that describes how multigrain timestamps work,
rationale for them, and some info about implementation and tradeoffs.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/multigrain-ts.rst | 126 ++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/Documentation/filesystems/multigrain-ts.rst b/Documentation/filesystems/multigrain-ts.rst
new file mode 100644
index 000000000000..beef7f79108c
--- /dev/null
+++ b/Documentation/filesystems/multigrain-ts.rst
@@ -0,0 +1,126 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Multigrain Timestamps
+=====================
+
+Introduction
+============
+Historically, the kernel has always used a coarse time values to stamp
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
+all filesystems implement this properly, and many just populating this with
+the ctime.
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
+always recognizeable, without violating the ordering guarantees when multiple
+different files are modified. This affects the mtime and the ctime, but the
+atime will always use coarse-grained timestamps.
+
+It uses the lowest-order bit in the timestamp as a flag that indicates whether
+the mtime or ctime have been queried. If either or both have, then the kernel
+takes special care to ensure the next timestamp update will display a visible
+change. This ensures tight cache coherency for use-cases like NFS, without
+sacrificing the benefits of reduced metadata updates when files aren't being
+watched.
+
+The ctime Floor Value
+=====================
+It's not sufficient to simply use fine or coarse-grained timestamps based on
+whether the mtime or ctime has been queried. A file could get a fine grained
+timestamp, and then a second file modified later could get a coarse-grained one
+that appears earlier than the first, which would break the kernel's timestamp
+ordering guarantees.
+
+To mitigate this problem, we maintain a per-time_namespace floor value that
+ensures that this can't happen. The two files in the above example may appear
+to have been modified at the same time in such a case, but they will never show
+the reverse order.
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
+
+Caveats
+=======
+The main sacrifice is the lowest bit in the ctime's field, since that's
+where the flag is stored. Thus, timestamps presented by multigrain enabled
+filesystems will always have an even tv_nsec value (since the lowest bit
+is masked off).

-- 
2.45.2


