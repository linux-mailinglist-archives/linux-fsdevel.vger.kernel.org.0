Return-Path: <linux-fsdevel+bounces-23565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C0E92E5B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 13:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4A428310B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 11:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC6116D9D1;
	Thu, 11 Jul 2024 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCzTZU0J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBF416D4E9;
	Thu, 11 Jul 2024 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696120; cv=none; b=pxEk/S08OmaDlDX7YEAgoJdkJFa1adJj7uDc52DTgz4lUQJVDVwbZj6IZwnMZ5rCf8gDY0FPcn/qGjuF8/KRURCc3s4AyoTdtecrNJBrg2VDP7heEotSAT3hPdl6IDUXk12WVuuP9sPvaJlZ5agqvZPL9cB4fWphpWsDdy48W3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696120; c=relaxed/simple;
	bh=pW/jFkAPiF/HbV8e5Z5baq9Y5PvUD3bzN6ubPEHLIXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mB7MLcd3/ZH0H9wbZPajIOPkwg7KMGu/YgOo58w320/QmDCFCOGYHrGV+O02X7vP3YZWC4YufYlGtZ9QiExgCRKD79kjTzOreKM1BsARKGh/SNCG/SNVWjqmYpGiuuqgdmSR1uyo/3BwoKVcAeSwho+/fMYiHD0LMT8B42SVHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCzTZU0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D2CC4AF19;
	Thu, 11 Jul 2024 11:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720696120;
	bh=pW/jFkAPiF/HbV8e5Z5baq9Y5PvUD3bzN6ubPEHLIXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WCzTZU0Jr3v43eG8Kx5I8d4s5hM4Nl+4vwkWWwhE05eXLo7V1b4+GWNCE/DgQpjrC
	 I4wY2fE1b8a9AzJf6PqRGaVfDxSQpO6S3ESRLeYAxDf4sN3ZcBDuErjicZUkW1FKoY
	 M4c//kk3Wv8DChNgGR1TK/cPTm4pLi0RY/GC28H1rN03MPSHbtbTWmshnlF/2ojlLH
	 rYQX9W079Lr36VIK9vZSc31GuUnOLeQo/eC1jCmnLGOSp5kNr1x7yNIFj1fOPSkcq6
	 Z4fG0FH8w9I2wetEiPhdXL5lmwxvUNZCS8wfBrR8OE4yw4GerUFNinTLpSfH65X8Oa
	 1EeUzRbEQKY8w==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jul 2024 07:08:09 -0400
Subject: [PATCH v5 5/9] Documentation: add a new file documenting
 multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-mgtime-v5-5-37bb5b465feb@kernel.org>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
In-Reply-To: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
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
 Kent Overstreet <kent.overstreet@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
 Randy Dunlap <rdunlap@infradead.org>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6283; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pW/jFkAPiF/HbV8e5Z5baq9Y5PvUD3bzN6ubPEHLIXQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmj70lBBUxl022ofr76yZVy6+CpmCaiGsVxhD3/
 T3eOiMHVuuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZo+9JQAKCRAADmhBGVaC
 FWpmD/9kRQrNGkdVPNBW8W7BmKOZt1X+58Y3KY4xzbfBqyo3Eg/XG6dQT717nBirvgi8SfDwtIO
 JW1PZ6ynlRUujLXq/frAtLhMkEZfbgiyqHQnwRnpwL7utKuPHgze9QZBYbEfp9T9AzxH0qOpcEN
 J8Suy3DPo+btdubYZPs5rkpxRXyI0SnmsTDoYU/JmIFvUeRguPCDNMGNHRDx9uOt/z0wcOUti1p
 e8g+jaKiQYw+NnOx24ynuurPOmfg97ad6Z1w7YkiVWSuvnSoLhssKAGQcdKzllDCDpJjwCHWvjQ
 voU3krCPd+4HXIxC+/pUvFcYTDRYODr1DY96YL4P0whozRIxX4OsSmWKYofSbPVyZww1jYja+Wj
 HgRGVktAXTXmlXCSb34KeQ7gpBiOTl+ggwqidK86S5ubl8bm3bQwqC/rYjxxRU5OpzjBtQphNeJ
 Rvqb+vtV9V94Fu1fEaMD5HgGvywWWhN3+VmQqRMsExvrwAlfZc+/AHeNvP1gQJf3JpFR5KirITv
 NMkZR/IhO1xaXfNoD3JyqkoT0+VE+PrnNsdNI5O7o6ahm2BozM9GBqQTlCA4NR6laYYmy9teQT7
 hWgSpi5wdzG60pn4z5+cqXs3cEZu34bW3K/UDzxjHeqeHe04KHdAbmZ2Ykz1oJPd91MfaB3E9WD
 E+Lb3+lWAbLCPsg==
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
index 000000000000..5cefc204ecec
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


