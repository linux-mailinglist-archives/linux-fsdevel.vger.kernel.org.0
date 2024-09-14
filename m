Return-Path: <linux-fsdevel+bounces-29386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4B4979276
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 19:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F138D1C2188A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 17:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEB01D618E;
	Sat, 14 Sep 2024 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6jXlekN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07D31D5CE9;
	Sat, 14 Sep 2024 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726333661; cv=none; b=rNkSJz4lOdq6GuzRWhZhwvB+M/zs/Fgz1CoiX9ZnoqcmmMsuhrxGgL4josAfMxkxQnluJFVevSGBAKtocYBaYignNaiDpjjAE226rOed88X1+QLw+YxtaJ3C2lwRCDY9K4QJEeW8zRuSCTWqN8+DWlPeIkqLt1gZYT4D545hN5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726333661; c=relaxed/simple;
	bh=/XcZHkK5gYpUwCSVg7s3+A6XUqyCAQD/OQvh4jjSlT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dztHNkjndRO63MTOzAZuQ6UXAH5PP6cLKGe75eBkuzl40fZE8/9/VezzdJTqZNRSVthNXqXqmnqzpxJtIuFAZ+r7Oo8rvLecFRvQBUVIO0zixIkl+irDOYJoZYynd6TrRwAEEm0xk5v47lBf18KuWcjUM055FSE5bt5KykjCaF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6jXlekN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB481C4CECE;
	Sat, 14 Sep 2024 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726333661;
	bh=/XcZHkK5gYpUwCSVg7s3+A6XUqyCAQD/OQvh4jjSlT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I6jXlekNuZGCsp5NBpRYP0R+xcXpVQbTNaK6HMUBUnTRSpt1zMlwP9l28+OQQsA35
	 qDoXUcSjO+bpgtb+5Fwv7gteU9Nn3R0dTcshB0a9pD2k3fNQQcCNyEnuNQAPrPXCmS
	 9EPY65VWshQzrPwqy8HHc2coX7lK5lfDWBwZO4fBj5XPwwC/irwcLnoxz9nT+Ceopb
	 obf3x/9tQr5KsfITxF8pANIEFJblk2cNow6RtJQgL5OpANFICZK2eSs5HLhO3srtMS
	 82TGmM5omjLC8ZyXKmCqqtVN0z4DPt4tz+4+9qZgV/GdqjganAwnPl2l2av7XZxMN5
	 Emi4PP3ARb5eg==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 14 Sep 2024 13:07:20 -0400
Subject: [PATCH v8 07/11] Documentation: add a new file documenting
 multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-mgtime-v8-7-5bd872330bed@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
In-Reply-To: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6998; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/XcZHkK5gYpUwCSVg7s3+A6XUqyCAQD/OQvh4jjSlT8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5cLGJuuSb1xltFHpW0q8a+qitvGMUmowicsfj
 Rg/e3AZpXiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuXCxgAKCRAADmhBGVaC
 FWVQEADCr1Ju8Vg4w9iEuJQYTT5m4eUvccIiH6Wxe4xu7Bjjl7Esfa5BErRe/5Jzro90FFNT424
 rEz4iPtm6aigGIR/RWKMg+HHvguntKiMPVorNF2LSPWDdD323OJYfux0/lhljniTqzGjYNxEJDD
 AyTSwsd+qaP99+L8AtMBC8VbvyBAM9M2d8I+U82Omh/FxBpuybHvs2KUh8Zqnom/ICx7y3131gx
 BUbpZN4gCpoP8yyUoB1+I8XnGs3Q4e4xU/3f3VMmHve1xpMr47XZ9aEuEpVQZ/6dyKTSTEkr5pd
 BW9VllFp5Xq0daBkYHXOVTJVR+5xX+GPkraB/JNTcJBRl8FQXnUXzbXHFottzpRseuCGkLnlhR5
 /Oy1FspdD6sUlKvnyALimjvBu6vKZzqJRuYOxHLNI0HYiY3mnBwq8UTouZR515qw64HylfuCHIh
 tfNxxCNnfr86gANN4QXomTNmAzzBzvWGfD+V48xHvhRE4ESBjfQ1B2NFJyinNOYkBQfrRtVUUXP
 aCHXIgF0oFoiDt2e0nCQym4YsEt0Wxh5aSNJDdcA0Zs6srKCiIjbA1U7TgGCF+UXQ9QhBLeeAaw
 iGt7V2f/qfXuyfXskvDFLtFTHw84eXq55hkiuqqgZJ+i4cvgaOQ6/d6+K8qD98nF0fWuHreU9yx
 EBLPusAlWUknZNQ==
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


