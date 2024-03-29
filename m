Return-Path: <linux-fsdevel+bounces-15656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE94891132
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 03:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B0828CC62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D221313C8F4;
	Fri, 29 Mar 2024 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4FzKBYhz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A302113BAE0
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677320; cv=none; b=O49bRP2m1lBWEMEQHlJ+dKDJ+0SbKikl3CO/GiyQDpikkf+KqvPfUIUaqeF7E0h2ryE1V0w9mXxJrGjW5MtVydi8fvpVtn5slHtT/ORpBJmYAH0pHC9mypngcBqXtgLt5nBd+xxjyBkQ0Hsd4qmAhaDwacZK+KwG60WeM5/cIzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677320; c=relaxed/simple;
	bh=0Uwazv+w/jcDgy7clXL/V1Mbi8BeuxwTAdno5aYWSXU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aAAJqStMA/3nHo79SuZtlStGOtoG7IS/nml8FjVxbqn3EFG6eIP6S8ApB8QwdyLr3Wmo2wif6cLX2m6FraWDI5MN4CZmFwnQUQ8L7y6tCPqadvFOpF3SClv5hgjUzWxI+CYQBUbaGKg1Icv12k7VfCYtJMZtkR4vk8PDLYTFvjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4FzKBYhz; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so2549290276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677315; x=1712282115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MtoMSiLbYsTIFk1WUdHLikHjCOt3vYMxnhJwxAPjDgo=;
        b=4FzKBYhzFOHauDnaW3IMSZUgY790mg4Gn7iRS7Whh++HHf5PydggAXeHn6MNtNiEdx
         cKg7L5CUjDo20yo8VVcfh1FOPO6DAzxs5VygUmkV8Nziz6UEissdAyYm8sfwNsndn265
         9JO5SZ+oCYp5BbIOHHF+qLTkx2LXgoSRltF3jRHx3LGYQrrbujEZUwc6CI6kJqSazWbo
         HtTZPmPAzSrka8Rel0fiP/x8FEaKyJ0RI2hs4+xDcKDm+U2I16zHhZ6Lhkn4RAODxPqV
         CZIvlHoA1akiMTfV/K6bZCXFrXcFTEdbQT00sinGO5nbXXp/UAjld9gybn8kSfc6yAB4
         b8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677315; x=1712282115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MtoMSiLbYsTIFk1WUdHLikHjCOt3vYMxnhJwxAPjDgo=;
        b=AK4RkWD9adiTLTYtwu1ZF/vpTJ0Y+zFEEUCNuxqXpWbKtDaWdX1Jx/ueo315J/EbPC
         b1PmaovUxTtvkkLFycA8vqjYqgSsCjDI3OjtexS97NWfcBXZmFcBfPJjTw/tMEMIVGQ1
         VkWb7Ea0oETLN7WSa6EoA/ptg/7w6IdMDzznTktGPZiOsWfnvTDbocnj358E1l/cG/0d
         f/2xNeHoYrV4HrmootZoH2VRGFOBI67oyDMQfO3SsrI77W37yUFCieYoP/4fjcxV6yy1
         9OAiEY3H34U9jITnvJMOp0S+addKEEFDHQUVhP+pfmlL14Kw25YBR7xsyJ3STQwvON1e
         ozyw==
X-Forwarded-Encrypted: i=1; AJvYcCX5lDicSrcy9E3XCSTckKNhjxi5pgEg5tmlHj+rR+0x4QxWqyI4PWsRmmAi6R6iL4kcazKJHy6lLzvAdl3mj0Q0NG9WVVDoDpVNK0YSJg==
X-Gm-Message-State: AOJu0YxvHfK00aWc6H8ceRscbmGT5IK5dkDhRiCWJPcNOfVDZS4Lcc/A
	yMLr7kqlJtakHVV6CRYc7MTV1DYd/CWHGYw7rZUUc343KmEG3h5VIJnWK8ySYAtLN6XJcFyd4j7
	jSQ==
X-Google-Smtp-Source: AGHT+IGZeYre6FPbWGBQWr9BXmlxwEAHNqQ3mZNYTIqsIIXoLy4CLve2KamU2yv2psNwpCig9et+QacFbsM=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:2313:b0:ddd:7581:1237 with SMTP id
 do19-20020a056902231300b00ddd75811237mr312324ybb.3.1711677315620; Thu, 28 Mar
 2024 18:55:15 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:49 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-35-drosen@google.com>
Subject: [RFC PATCH v4 34/36] tools: Add FUSE, update bpf includes
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"

Updates the bpf includes under tools, and adds fuse

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 tools/include/uapi/linux/bpf.h  |   13 +
 tools/include/uapi/linux/fuse.h | 1197 +++++++++++++++++++++++++++++++
 2 files changed, 1210 insertions(+)
 create mode 100644 tools/include/uapi/linux/fuse.h

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 85ec7fc799d7..fe8b485c9335 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7461,4 +7461,17 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+/* Return Codes for Fuse BPF struct_op programs */
+#define BPF_FUSE_CONTINUE		0
+#define BPF_FUSE_USER			1
+#define BPF_FUSE_USER_PREFILTER		2
+#define BPF_FUSE_POSTFILTER		3
+#define BPF_FUSE_USER_POSTFILTER	4
+#define BPF_FUSE_CALL_DEFAULT		5
+
+/* Op Code Filter values for BPF Programs */
+#define FUSE_OPCODE_FILTER	0x0ffff
+#define FUSE_PREFILTER		0x10000
+#define FUSE_POSTFILTER		0x20000
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/include/uapi/linux/fuse.h b/tools/include/uapi/linux/fuse.h
new file mode 100644
index 000000000000..b37d5b015454
--- /dev/null
+++ b/tools/include/uapi/linux/fuse.h
@@ -0,0 +1,1197 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/*
+    This file defines the kernel interface of FUSE
+    Copyright (C) 2001-2008  Miklos Szeredi <miklos@szeredi.hu>
+
+    This program can be distributed under the terms of the GNU GPL.
+    See the file COPYING.
+
+    This -- and only this -- header file may also be distributed under
+    the terms of the BSD Licence as follows:
+
+    Copyright (C) 2001-2007 Miklos Szeredi. All rights reserved.
+
+    Redistribution and use in source and binary forms, with or without
+    modification, are permitted provided that the following conditions
+    are met:
+    1. Redistributions of source code must retain the above copyright
+       notice, this list of conditions and the following disclaimer.
+    2. Redistributions in binary form must reproduce the above copyright
+       notice, this list of conditions and the following disclaimer in the
+       documentation and/or other materials provided with the distribution.
+
+    THIS SOFTWARE IS PROVIDED BY AUTHOR AND CONTRIBUTORS ``AS IS'' AND
+    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+    ARE DISCLAIMED.  IN NO EVENT SHALL AUTHOR OR CONTRIBUTORS BE LIABLE
+    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+    OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+    HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+    OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+    SUCH DAMAGE.
+*/
+
+/*
+ * This file defines the kernel interface of FUSE
+ *
+ * Protocol changelog:
+ *
+ * 7.1:
+ *  - add the following messages:
+ *      FUSE_SETATTR, FUSE_SYMLINK, FUSE_MKNOD, FUSE_MKDIR, FUSE_UNLINK,
+ *      FUSE_RMDIR, FUSE_RENAME, FUSE_LINK, FUSE_OPEN, FUSE_READ, FUSE_WRITE,
+ *      FUSE_RELEASE, FUSE_FSYNC, FUSE_FLUSH, FUSE_SETXATTR, FUSE_GETXATTR,
+ *      FUSE_LISTXATTR, FUSE_REMOVEXATTR, FUSE_OPENDIR, FUSE_READDIR,
+ *      FUSE_RELEASEDIR
+ *  - add padding to messages to accommodate 32-bit servers on 64-bit kernels
+ *
+ * 7.2:
+ *  - add FOPEN_DIRECT_IO and FOPEN_KEEP_CACHE flags
+ *  - add FUSE_FSYNCDIR message
+ *
+ * 7.3:
+ *  - add FUSE_ACCESS message
+ *  - add FUSE_CREATE message
+ *  - add filehandle to fuse_setattr_in
+ *
+ * 7.4:
+ *  - add frsize to fuse_kstatfs
+ *  - clean up request size limit checking
+ *
+ * 7.5:
+ *  - add flags and max_write to fuse_init_out
+ *
+ * 7.6:
+ *  - add max_readahead to fuse_init_in and fuse_init_out
+ *
+ * 7.7:
+ *  - add FUSE_INTERRUPT message
+ *  - add POSIX file lock support
+ *
+ * 7.8:
+ *  - add lock_owner and flags fields to fuse_release_in
+ *  - add FUSE_BMAP message
+ *  - add FUSE_DESTROY message
+ *
+ * 7.9:
+ *  - new fuse_getattr_in input argument of GETATTR
+ *  - add lk_flags in fuse_lk_in
+ *  - add lock_owner field to fuse_setattr_in, fuse_read_in and fuse_write_in
+ *  - add blksize field to fuse_attr
+ *  - add file flags field to fuse_read_in and fuse_write_in
+ *  - Add ATIME_NOW and MTIME_NOW flags to fuse_setattr_in
+ *
+ * 7.10
+ *  - add nonseekable open flag
+ *
+ * 7.11
+ *  - add IOCTL message
+ *  - add unsolicited notification support
+ *  - add POLL message and NOTIFY_POLL notification
+ *
+ * 7.12
+ *  - add umask flag to input argument of create, mknod and mkdir
+ *  - add notification messages for invalidation of inodes and
+ *    directory entries
+ *
+ * 7.13
+ *  - make max number of background requests and congestion threshold
+ *    tunables
+ *
+ * 7.14
+ *  - add splice support to fuse device
+ *
+ * 7.15
+ *  - add store notify
+ *  - add retrieve notify
+ *
+ * 7.16
+ *  - add BATCH_FORGET request
+ *  - FUSE_IOCTL_UNRESTRICTED shall now return with array of 'struct
+ *    fuse_ioctl_iovec' instead of ambiguous 'struct iovec'
+ *  - add FUSE_IOCTL_32BIT flag
+ *
+ * 7.17
+ *  - add FUSE_FLOCK_LOCKS and FUSE_RELEASE_FLOCK_UNLOCK
+ *
+ * 7.18
+ *  - add FUSE_IOCTL_DIR flag
+ *  - add FUSE_NOTIFY_DELETE
+ *
+ * 7.19
+ *  - add FUSE_FALLOCATE
+ *
+ * 7.20
+ *  - add FUSE_AUTO_INVAL_DATA
+ *
+ * 7.21
+ *  - add FUSE_READDIRPLUS
+ *  - send the requested events in POLL request
+ *
+ * 7.22
+ *  - add FUSE_ASYNC_DIO
+ *
+ * 7.23
+ *  - add FUSE_WRITEBACK_CACHE
+ *  - add time_gran to fuse_init_out
+ *  - add reserved space to fuse_init_out
+ *  - add FATTR_CTIME
+ *  - add ctime and ctimensec to fuse_setattr_in
+ *  - add FUSE_RENAME2 request
+ *  - add FUSE_NO_OPEN_SUPPORT flag
+ *
+ *  7.24
+ *  - add FUSE_LSEEK for SEEK_HOLE and SEEK_DATA support
+ *
+ *  7.25
+ *  - add FUSE_PARALLEL_DIROPS
+ *
+ *  7.26
+ *  - add FUSE_HANDLE_KILLPRIV
+ *  - add FUSE_POSIX_ACL
+ *
+ *  7.27
+ *  - add FUSE_ABORT_ERROR
+ *
+ *  7.28
+ *  - add FUSE_COPY_FILE_RANGE
+ *  - add FOPEN_CACHE_DIR
+ *  - add FUSE_MAX_PAGES, add max_pages to init_out
+ *  - add FUSE_CACHE_SYMLINKS
+ *
+ *  7.29
+ *  - add FUSE_NO_OPENDIR_SUPPORT flag
+ *
+ *  7.30
+ *  - add FUSE_EXPLICIT_INVAL_DATA
+ *  - add FUSE_IOCTL_COMPAT_X32
+ *
+ *  7.31
+ *  - add FUSE_WRITE_KILL_PRIV flag
+ *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
+ *  - add map_alignment to fuse_init_out, add FUSE_MAP_ALIGNMENT flag
+ *
+ *  7.32
+ *  - add flags to fuse_attr, add FUSE_ATTR_SUBMOUNT, add FUSE_SUBMOUNTS
+ *
+ *  7.33
+ *  - add FUSE_HANDLE_KILLPRIV_V2, FUSE_WRITE_KILL_SUIDGID, FATTR_KILL_SUIDGID
+ *  - add FUSE_OPEN_KILL_SUIDGID
+ *  - extend fuse_setxattr_in, add FUSE_SETXATTR_EXT
+ *  - add FUSE_SETXATTR_ACL_KILL_SGID
+ *
+ *  7.34
+ *  - add FUSE_SYNCFS
+ *
+ *  7.35
+ *  - add FOPEN_NOFLUSH
+ *
+ *  7.36
+ *  - extend fuse_init_in with reserved fields, add FUSE_INIT_EXT init flag
+ *  - add flags2 to fuse_init_in and fuse_init_out
+ *  - add FUSE_SECURITY_CTX init flag
+ *  - add security context to create, mkdir, symlink, and mknod requests
+ *  - add FUSE_HAS_INODE_DAX, FUSE_ATTR_DAX
+ *
+ *  7.37
+ *  - add FUSE_TMPFILE
+ *
+ *  7.38
+ *  - add FUSE_EXPIRE_ONLY flag to fuse_notify_inval_entry
+ *  - add FOPEN_PARALLEL_DIRECT_WRITES
+ *  - add total_extlen to fuse_in_header
+ *  - add FUSE_MAX_NR_SECCTX
+ *  - add extension header
+ *  - add FUSE_EXT_GROUPS
+ *  - add FUSE_CREATE_SUPP_GROUP
+ *  - add FUSE_HAS_EXPIRE_ONLY
+ *
+ *  7.39
+ *  - add FUSE_DIRECT_IO_ALLOW_MMAP
+ *  - add FUSE_STATX and related structures
+ */
+
+#ifndef _LINUX_FUSE_H
+#define _LINUX_FUSE_H
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#else
+#include <stdint.h>
+#endif
+
+/*
+ * Version negotiation:
+ *
+ * Both the kernel and userspace send the version they support in the
+ * INIT request and reply respectively.
+ *
+ * If the major versions match then both shall use the smallest
+ * of the two minor versions for communication.
+ *
+ * If the kernel supports a larger major version, then userspace shall
+ * reply with the major version it supports, ignore the rest of the
+ * INIT message and expect a new INIT message from the kernel with a
+ * matching major version.
+ *
+ * If the library supports a larger major version, then it shall fall
+ * back to the major protocol version sent by the kernel for
+ * communication and reply with that major version (and an arbitrary
+ * supported minor version).
+ */
+
+/** Version number of this interface */
+#define FUSE_KERNEL_VERSION 7
+
+/** Minor version number of this interface */
+#define FUSE_KERNEL_MINOR_VERSION 39
+
+/** The node ID of the root inode */
+#define FUSE_ROOT_ID 1
+
+/* Make sure all structures are padded to 64bit boundary, so 32bit
+   userspace works under 64bit kernels */
+
+struct fuse_attr {
+	uint64_t	ino;
+	uint64_t	size;
+	uint64_t	blocks;
+	uint64_t	atime;
+	uint64_t	mtime;
+	uint64_t	ctime;
+	uint32_t	atimensec;
+	uint32_t	mtimensec;
+	uint32_t	ctimensec;
+	uint32_t	mode;
+	uint32_t	nlink;
+	uint32_t	uid;
+	uint32_t	gid;
+	uint32_t	rdev;
+	uint32_t	blksize;
+	uint32_t	flags;
+};
+
+/*
+ * The following structures are bit-for-bit compatible with the statx(2) ABI in
+ * Linux.
+ */
+struct fuse_sx_time {
+	int64_t		tv_sec;
+	uint32_t	tv_nsec;
+	int32_t		__reserved;
+};
+
+struct fuse_statx {
+	uint32_t	mask;
+	uint32_t	blksize;
+	uint64_t	attributes;
+	uint32_t	nlink;
+	uint32_t	uid;
+	uint32_t	gid;
+	uint16_t	mode;
+	uint16_t	__spare0[1];
+	uint64_t	ino;
+	uint64_t	size;
+	uint64_t	blocks;
+	uint64_t	attributes_mask;
+	struct fuse_sx_time	atime;
+	struct fuse_sx_time	btime;
+	struct fuse_sx_time	ctime;
+	struct fuse_sx_time	mtime;
+	uint32_t	rdev_major;
+	uint32_t	rdev_minor;
+	uint32_t	dev_major;
+	uint32_t	dev_minor;
+	uint64_t	__spare2[14];
+};
+
+struct fuse_kstatfs {
+	uint64_t	blocks;
+	uint64_t	bfree;
+	uint64_t	bavail;
+	uint64_t	files;
+	uint64_t	ffree;
+	uint32_t	bsize;
+	uint32_t	namelen;
+	uint32_t	frsize;
+	uint32_t	padding;
+	uint32_t	spare[6];
+};
+
+struct fuse_file_lock {
+	uint64_t	start;
+	uint64_t	end;
+	uint32_t	type;
+	uint32_t	pid; /* tgid */
+};
+
+/**
+ * Bitmasks for fuse_setattr_in.valid
+ */
+#define FATTR_MODE	(1 << 0)
+#define FATTR_UID	(1 << 1)
+#define FATTR_GID	(1 << 2)
+#define FATTR_SIZE	(1 << 3)
+#define FATTR_ATIME	(1 << 4)
+#define FATTR_MTIME	(1 << 5)
+#define FATTR_FH	(1 << 6)
+#define FATTR_ATIME_NOW	(1 << 7)
+#define FATTR_MTIME_NOW	(1 << 8)
+#define FATTR_LOCKOWNER	(1 << 9)
+#define FATTR_CTIME	(1 << 10)
+#define FATTR_KILL_SUIDGID	(1 << 11)
+
+/**
+ * Flags returned by the OPEN request
+ *
+ * FOPEN_DIRECT_IO: bypass page cache for this open file
+ * FOPEN_KEEP_CACHE: don't invalidate the data cache on open
+ * FOPEN_NONSEEKABLE: the file is not seekable
+ * FOPEN_CACHE_DIR: allow caching this directory
+ * FOPEN_STREAM: the file is stream-like (no file position at all)
+ * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
+ * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
+ */
+#define FOPEN_DIRECT_IO		(1 << 0)
+#define FOPEN_KEEP_CACHE	(1 << 1)
+#define FOPEN_NONSEEKABLE	(1 << 2)
+#define FOPEN_CACHE_DIR		(1 << 3)
+#define FOPEN_STREAM		(1 << 4)
+#define FOPEN_NOFLUSH		(1 << 5)
+#define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
+
+/**
+ * INIT request/reply flags
+ *
+ * FUSE_ASYNC_READ: asynchronous read requests
+ * FUSE_POSIX_LOCKS: remote locking for POSIX file locks
+ * FUSE_FILE_OPS: kernel sends file handle for fstat, etc... (not yet supported)
+ * FUSE_ATOMIC_O_TRUNC: handles the O_TRUNC open flag in the filesystem
+ * FUSE_EXPORT_SUPPORT: filesystem handles lookups of "." and ".."
+ * FUSE_BIG_WRITES: filesystem can handle write size larger than 4kB
+ * FUSE_DONT_MASK: don't apply umask to file mode on create operations
+ * FUSE_SPLICE_WRITE: kernel supports splice write on the device
+ * FUSE_SPLICE_MOVE: kernel supports splice move on the device
+ * FUSE_SPLICE_READ: kernel supports splice read on the device
+ * FUSE_FLOCK_LOCKS: remote locking for BSD style file locks
+ * FUSE_HAS_IOCTL_DIR: kernel supports ioctl on directories
+ * FUSE_AUTO_INVAL_DATA: automatically invalidate cached pages
+ * FUSE_DO_READDIRPLUS: do READDIRPLUS (READDIR+LOOKUP in one)
+ * FUSE_READDIRPLUS_AUTO: adaptive readdirplus
+ * FUSE_ASYNC_DIO: asynchronous direct I/O submission
+ * FUSE_WRITEBACK_CACHE: use writeback cache for buffered writes
+ * FUSE_NO_OPEN_SUPPORT: kernel supports zero-message opens
+ * FUSE_PARALLEL_DIROPS: allow parallel lookups and readdir
+ * FUSE_HANDLE_KILLPRIV: fs handles killing suid/sgid/cap on write/chown/trunc
+ * FUSE_POSIX_ACL: filesystem supports posix acls
+ * FUSE_ABORT_ERROR: reading the device after abort returns ECONNABORTED
+ * FUSE_MAX_PAGES: init_out.max_pages contains the max number of req pages
+ * FUSE_CACHE_SYMLINKS: cache READLINK responses
+ * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
+ * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
+ * FUSE_MAP_ALIGNMENT: init_out.map_alignment contains log2(byte alignment) for
+ *		       foffset and moffset fields in struct
+ *		       fuse_setupmapping_out and fuse_removemapping_one.
+ * FUSE_SUBMOUNTS: kernel supports auto-mounting directory submounts
+ * FUSE_HANDLE_KILLPRIV_V2: fs kills suid/sgid/cap on write/chown/trunc.
+ *			Upon write/truncate suid/sgid is only killed if caller
+ *			does not have CAP_FSETID. Additionally upon
+ *			write/truncate sgid is killed only if file has group
+ *			execute permission. (Same as Linux VFS behavior).
+ * FUSE_SETXATTR_EXT:	Server supports extended struct fuse_setxattr_in
+ * FUSE_INIT_EXT: extended fuse_init_in request
+ * FUSE_INIT_RESERVED: reserved, do not use
+ * FUSE_SECURITY_CTX:	add security context to create, mkdir, symlink, and
+ *			mknod
+ * FUSE_HAS_INODE_DAX:  use per inode DAX
+ * FUSE_CREATE_SUPP_GROUP: add supplementary group info to create, mkdir,
+ *			symlink and mknod (single group that matches parent)
+ * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
+ * FUSE_DIRECT_IO_ALLOW_MMAP: allow shared mmap in FOPEN_DIRECT_IO mode.
+ */
+#define FUSE_ASYNC_READ		(1 << 0)
+#define FUSE_POSIX_LOCKS	(1 << 1)
+#define FUSE_FILE_OPS		(1 << 2)
+#define FUSE_ATOMIC_O_TRUNC	(1 << 3)
+#define FUSE_EXPORT_SUPPORT	(1 << 4)
+#define FUSE_BIG_WRITES		(1 << 5)
+#define FUSE_DONT_MASK		(1 << 6)
+#define FUSE_SPLICE_WRITE	(1 << 7)
+#define FUSE_SPLICE_MOVE	(1 << 8)
+#define FUSE_SPLICE_READ	(1 << 9)
+#define FUSE_FLOCK_LOCKS	(1 << 10)
+#define FUSE_HAS_IOCTL_DIR	(1 << 11)
+#define FUSE_AUTO_INVAL_DATA	(1 << 12)
+#define FUSE_DO_READDIRPLUS	(1 << 13)
+#define FUSE_READDIRPLUS_AUTO	(1 << 14)
+#define FUSE_ASYNC_DIO		(1 << 15)
+#define FUSE_WRITEBACK_CACHE	(1 << 16)
+#define FUSE_NO_OPEN_SUPPORT	(1 << 17)
+#define FUSE_PARALLEL_DIROPS    (1 << 18)
+#define FUSE_HANDLE_KILLPRIV	(1 << 19)
+#define FUSE_POSIX_ACL		(1 << 20)
+#define FUSE_ABORT_ERROR	(1 << 21)
+#define FUSE_MAX_PAGES		(1 << 22)
+#define FUSE_CACHE_SYMLINKS	(1 << 23)
+#define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
+#define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
+#define FUSE_MAP_ALIGNMENT	(1 << 26)
+#define FUSE_SUBMOUNTS		(1 << 27)
+#define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
+#define FUSE_SETXATTR_EXT	(1 << 29)
+#define FUSE_INIT_EXT		(1 << 30)
+#define FUSE_INIT_RESERVED	(1 << 31)
+/* bits 32..63 get shifted down 32 bits into the flags2 field */
+#define FUSE_SECURITY_CTX	(1ULL << 32)
+#define FUSE_HAS_INODE_DAX	(1ULL << 33)
+#define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
+#define FUSE_HAS_EXPIRE_ONLY	(1ULL << 35)
+#define FUSE_DIRECT_IO_ALLOW_MMAP (1ULL << 36)
+
+/* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
+#define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
+
+/**
+ * CUSE INIT request/reply flags
+ *
+ * CUSE_UNRESTRICTED_IOCTL:  use unrestricted ioctl
+ */
+#define CUSE_UNRESTRICTED_IOCTL	(1 << 0)
+
+/**
+ * Release flags
+ */
+#define FUSE_RELEASE_FLUSH	(1 << 0)
+#define FUSE_RELEASE_FLOCK_UNLOCK	(1 << 1)
+
+/**
+ * Getattr flags
+ */
+#define FUSE_GETATTR_FH		(1 << 0)
+
+/**
+ * Lock flags
+ */
+#define FUSE_LK_FLOCK		(1 << 0)
+
+/**
+ * WRITE flags
+ *
+ * FUSE_WRITE_CACHE: delayed write from page cache, file handle is guessed
+ * FUSE_WRITE_LOCKOWNER: lock_owner field is valid
+ * FUSE_WRITE_KILL_SUIDGID: kill suid and sgid bits
+ */
+#define FUSE_WRITE_CACHE	(1 << 0)
+#define FUSE_WRITE_LOCKOWNER	(1 << 1)
+#define FUSE_WRITE_KILL_SUIDGID (1 << 2)
+
+/* Obsolete alias; this flag implies killing suid/sgid only. */
+#define FUSE_WRITE_KILL_PRIV	FUSE_WRITE_KILL_SUIDGID
+
+/**
+ * Read flags
+ */
+#define FUSE_READ_LOCKOWNER	(1 << 1)
+
+/**
+ * Ioctl flags
+ *
+ * FUSE_IOCTL_COMPAT: 32bit compat ioctl on 64bit machine
+ * FUSE_IOCTL_UNRESTRICTED: not restricted to well-formed ioctls, retry allowed
+ * FUSE_IOCTL_RETRY: retry with new iovecs
+ * FUSE_IOCTL_32BIT: 32bit ioctl
+ * FUSE_IOCTL_DIR: is a directory
+ * FUSE_IOCTL_COMPAT_X32: x32 compat ioctl on 64bit machine (64bit time_t)
+ *
+ * FUSE_IOCTL_MAX_IOV: maximum of in_iovecs + out_iovecs
+ */
+#define FUSE_IOCTL_COMPAT	(1 << 0)
+#define FUSE_IOCTL_UNRESTRICTED	(1 << 1)
+#define FUSE_IOCTL_RETRY	(1 << 2)
+#define FUSE_IOCTL_32BIT	(1 << 3)
+#define FUSE_IOCTL_DIR		(1 << 4)
+#define FUSE_IOCTL_COMPAT_X32	(1 << 5)
+
+#define FUSE_IOCTL_MAX_IOV	256
+
+/**
+ * Poll flags
+ *
+ * FUSE_POLL_SCHEDULE_NOTIFY: request poll notify
+ */
+#define FUSE_POLL_SCHEDULE_NOTIFY (1 << 0)
+
+/**
+ * Fsync flags
+ *
+ * FUSE_FSYNC_FDATASYNC: Sync data only, not metadata
+ */
+#define FUSE_FSYNC_FDATASYNC	(1 << 0)
+
+/**
+ * fuse_attr flags
+ *
+ * FUSE_ATTR_SUBMOUNT: Object is a submount root
+ * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
+ */
+#define FUSE_ATTR_SUBMOUNT      (1 << 0)
+#define FUSE_ATTR_DAX		(1 << 1)
+
+/**
+ * Open flags
+ * FUSE_OPEN_KILL_SUIDGID: Kill suid and sgid if executable
+ */
+#define FUSE_OPEN_KILL_SUIDGID	(1 << 0)
+
+/**
+ * setxattr flags
+ * FUSE_SETXATTR_ACL_KILL_SGID: Clear SGID when system.posix_acl_access is set
+ */
+#define FUSE_SETXATTR_ACL_KILL_SGID	(1 << 0)
+
+/**
+ * notify_inval_entry flags
+ * FUSE_EXPIRE_ONLY
+ */
+#define FUSE_EXPIRE_ONLY		(1 << 0)
+
+/**
+ * extension type
+ * FUSE_MAX_NR_SECCTX: maximum value of &fuse_secctx_header.nr_secctx
+ * FUSE_EXT_GROUPS: &fuse_supp_groups extension
+ */
+enum fuse_ext_type {
+	/* Types 0..31 are reserved for fuse_secctx_header */
+	FUSE_MAX_NR_SECCTX	= 31,
+	FUSE_EXT_GROUPS		= 32,
+	FUSE_ERROR_IN		= 33,
+};
+
+enum fuse_opcode {
+	FUSE_LOOKUP		= 1,
+	FUSE_FORGET		= 2,  /* no reply */
+	FUSE_GETATTR		= 3,
+	FUSE_SETATTR		= 4,
+	FUSE_READLINK		= 5,
+	FUSE_SYMLINK		= 6,
+	FUSE_MKNOD		= 8,
+	FUSE_MKDIR		= 9,
+	FUSE_UNLINK		= 10,
+	FUSE_RMDIR		= 11,
+	FUSE_RENAME		= 12,
+	FUSE_LINK		= 13,
+	FUSE_OPEN		= 14,
+	FUSE_READ		= 15,
+	FUSE_WRITE		= 16,
+	FUSE_STATFS		= 17,
+	FUSE_RELEASE		= 18,
+	FUSE_FSYNC		= 20,
+	FUSE_SETXATTR		= 21,
+	FUSE_GETXATTR		= 22,
+	FUSE_LISTXATTR		= 23,
+	FUSE_REMOVEXATTR	= 24,
+	FUSE_FLUSH		= 25,
+	FUSE_INIT		= 26,
+	FUSE_OPENDIR		= 27,
+	FUSE_READDIR		= 28,
+	FUSE_RELEASEDIR		= 29,
+	FUSE_FSYNCDIR		= 30,
+	FUSE_GETLK		= 31,
+	FUSE_SETLK		= 32,
+	FUSE_SETLKW		= 33,
+	FUSE_ACCESS		= 34,
+	FUSE_CREATE		= 35,
+	FUSE_INTERRUPT		= 36,
+	FUSE_BMAP		= 37,
+	FUSE_DESTROY		= 38,
+	FUSE_IOCTL		= 39,
+	FUSE_POLL		= 40,
+	FUSE_NOTIFY_REPLY	= 41,
+	FUSE_BATCH_FORGET	= 42,
+	FUSE_FALLOCATE		= 43,
+	FUSE_READDIRPLUS	= 44,
+	FUSE_RENAME2		= 45,
+	FUSE_LSEEK		= 46,
+	FUSE_COPY_FILE_RANGE	= 47,
+	FUSE_SETUPMAPPING	= 48,
+	FUSE_REMOVEMAPPING	= 49,
+	FUSE_SYNCFS		= 50,
+	FUSE_TMPFILE		= 51,
+	FUSE_STATX		= 52,
+
+	/* CUSE specific operations */
+	CUSE_INIT		= 4096,
+
+	/* Reserved opcodes: helpful to detect structure endian-ness */
+	CUSE_INIT_BSWAP_RESERVED	= 1048576,	/* CUSE_INIT << 8 */
+	FUSE_INIT_BSWAP_RESERVED	= 436207616,	/* FUSE_INIT << 24 */
+};
+
+enum fuse_notify_code {
+	FUSE_NOTIFY_POLL   = 1,
+	FUSE_NOTIFY_INVAL_INODE = 2,
+	FUSE_NOTIFY_INVAL_ENTRY = 3,
+	FUSE_NOTIFY_STORE = 4,
+	FUSE_NOTIFY_RETRIEVE = 5,
+	FUSE_NOTIFY_DELETE = 6,
+	FUSE_NOTIFY_CODE_MAX,
+};
+
+/* The read buffer is required to be at least 8k, but may be much larger */
+#define FUSE_MIN_READ_BUFFER 8192
+
+#define FUSE_COMPAT_ENTRY_OUT_SIZE 120
+
+struct fuse_entry_out {
+	uint64_t	nodeid;		/* Inode ID */
+	uint64_t	generation;	/* Inode generation: nodeid:gen must
+					   be unique for the fs's lifetime */
+	uint64_t	entry_valid;	/* Cache timeout for the name */
+	uint64_t	attr_valid;	/* Cache timeout for the attributes */
+	uint32_t	entry_valid_nsec;
+	uint32_t	attr_valid_nsec;
+	struct fuse_attr attr;
+};
+
+#define FUSE_BPF_MAX_ENTRIES	2
+
+enum fuse_bpf_type {
+	FUSE_ENTRY_BACKING		= 1,
+	FUSE_ENTRY_BPF			= 2,
+	FUSE_ENTRY_REMOVE_BACKING	= 3,
+	FUSE_ENTRY_REMOVE_BPF		= 4,
+};
+
+#define BPF_FUSE_NAME_MAX 15
+
+struct fuse_bpf_entry_out {
+	uint32_t	entry_type;
+	uint32_t	unused;
+	union {
+		struct {
+			uint64_t unused2;
+			uint64_t fd;
+		};
+		char name[BPF_FUSE_NAME_MAX + 1];
+	};
+};
+
+struct fuse_forget_in {
+	uint64_t	nlookup;
+};
+
+struct fuse_forget_one {
+	uint64_t	nodeid;
+	uint64_t	nlookup;
+};
+
+struct fuse_batch_forget_in {
+	uint32_t	count;
+	uint32_t	dummy;
+};
+
+struct fuse_getattr_in {
+	uint32_t	getattr_flags;
+	uint32_t	dummy;
+	uint64_t	fh;
+};
+
+#define FUSE_COMPAT_ATTR_OUT_SIZE 96
+
+struct fuse_attr_out {
+	uint64_t	attr_valid;	/* Cache timeout for the attributes */
+	uint32_t	attr_valid_nsec;
+	uint32_t	dummy;
+	struct fuse_attr attr;
+};
+
+struct fuse_statx_in {
+	uint32_t	getattr_flags;
+	uint32_t	reserved;
+	uint64_t	fh;
+	uint32_t	sx_flags;
+	uint32_t	sx_mask;
+};
+
+struct fuse_statx_out {
+	uint64_t	attr_valid;	/* Cache timeout for the attributes */
+	uint32_t	attr_valid_nsec;
+	uint32_t	flags;
+	uint64_t	spare[2];
+	struct fuse_statx stat;
+};
+
+#define FUSE_COMPAT_MKNOD_IN_SIZE 8
+
+struct fuse_mknod_in {
+	uint32_t	mode;
+	uint32_t	rdev;
+	uint32_t	umask;
+	uint32_t	padding;
+};
+
+struct fuse_mkdir_in {
+	uint32_t	mode;
+	uint32_t	umask;
+};
+
+struct fuse_rename_in {
+	uint64_t	newdir;
+};
+
+struct fuse_rename2_in {
+	uint64_t	newdir;
+	uint32_t	flags;
+	uint32_t	padding;
+};
+
+struct fuse_link_in {
+	uint64_t	oldnodeid;
+};
+
+struct fuse_setattr_in {
+	uint32_t	valid;
+	uint32_t	padding;
+	uint64_t	fh;
+	uint64_t	size;
+	uint64_t	lock_owner;
+	uint64_t	atime;
+	uint64_t	mtime;
+	uint64_t	ctime;
+	uint32_t	atimensec;
+	uint32_t	mtimensec;
+	uint32_t	ctimensec;
+	uint32_t	mode;
+	uint32_t	unused4;
+	uint32_t	uid;
+	uint32_t	gid;
+	uint32_t	unused5;
+};
+
+struct fuse_open_in {
+	uint32_t	flags;
+	uint32_t	open_flags;	/* FUSE_OPEN_... */
+};
+
+struct fuse_create_in {
+	uint32_t	flags;
+	uint32_t	mode;
+	uint32_t	umask;
+	uint32_t	open_flags;	/* FUSE_OPEN_... */
+};
+
+struct fuse_open_out {
+	uint64_t	fh;
+	uint32_t	open_flags;
+	uint32_t	padding;
+};
+
+struct fuse_release_in {
+	uint64_t	fh;
+	uint32_t	flags;
+	uint32_t	release_flags;
+	uint64_t	lock_owner;
+};
+
+struct fuse_flush_in {
+	uint64_t	fh;
+	uint32_t	unused;
+	uint32_t	padding;
+	uint64_t	lock_owner;
+};
+
+struct fuse_read_in {
+	uint64_t	fh;
+	uint64_t	offset;
+	uint32_t	size;
+	uint32_t	read_flags;
+	uint64_t	lock_owner;
+	uint32_t	flags;
+	uint32_t	padding;
+};
+
+struct fuse_read_out {
+	uint64_t	offset;
+	uint32_t	again;
+	uint32_t	padding;
+};
+
+// This is likely not what we want
+struct fuse_read_iter_out {
+	uint64_t ret;
+};
+
+#define FUSE_COMPAT_WRITE_IN_SIZE 24
+
+struct fuse_write_in {
+	uint64_t	fh;
+	uint64_t	offset;
+	uint32_t	size;
+	uint32_t	write_flags;
+	uint64_t	lock_owner;
+	uint32_t	flags;
+	uint32_t	padding;
+};
+
+struct fuse_write_out {
+	uint32_t	size;
+	uint32_t	padding;
+};
+
+// This is likely not what we want
+struct fuse_write_iter_out {
+	uint64_t ret;
+};
+
+#define FUSE_COMPAT_STATFS_SIZE 48
+
+struct fuse_statfs_out {
+	struct fuse_kstatfs st;
+};
+
+struct fuse_fsync_in {
+	uint64_t	fh;
+	uint32_t	fsync_flags;
+	uint32_t	padding;
+};
+
+#define FUSE_COMPAT_SETXATTR_IN_SIZE 8
+
+struct fuse_setxattr_in {
+	uint32_t	size;
+	uint32_t	flags;
+	uint32_t	setxattr_flags;
+	uint32_t	padding;
+};
+
+struct fuse_getxattr_in {
+	uint32_t	size;
+	uint32_t	padding;
+};
+
+struct fuse_getxattr_out {
+	uint32_t	size;
+	uint32_t	padding;
+};
+
+struct fuse_lk_in {
+	uint64_t	fh;
+	uint64_t	owner;
+	struct fuse_file_lock lk;
+	uint32_t	lk_flags;
+	uint32_t	padding;
+};
+
+struct fuse_lk_out {
+	struct fuse_file_lock lk;
+};
+
+struct fuse_access_in {
+	uint32_t	mask;
+	uint32_t	padding;
+};
+
+struct fuse_init_in {
+	uint32_t	major;
+	uint32_t	minor;
+	uint32_t	max_readahead;
+	uint32_t	flags;
+	uint32_t	flags2;
+	uint32_t	unused[11];
+};
+
+#define FUSE_COMPAT_INIT_OUT_SIZE 8
+#define FUSE_COMPAT_22_INIT_OUT_SIZE 24
+
+struct fuse_init_out {
+	uint32_t	major;
+	uint32_t	minor;
+	uint32_t	max_readahead;
+	uint32_t	flags;
+	uint16_t	max_background;
+	uint16_t	congestion_threshold;
+	uint32_t	max_write;
+	uint32_t	time_gran;
+	uint16_t	max_pages;
+	uint16_t	map_alignment;
+	uint32_t	flags2;
+	uint32_t	unused[7];
+};
+
+#define CUSE_INIT_INFO_MAX 4096
+
+struct cuse_init_in {
+	uint32_t	major;
+	uint32_t	minor;
+	uint32_t	unused;
+	uint32_t	flags;
+};
+
+struct cuse_init_out {
+	uint32_t	major;
+	uint32_t	minor;
+	uint32_t	unused;
+	uint32_t	flags;
+	uint32_t	max_read;
+	uint32_t	max_write;
+	uint32_t	dev_major;		/* chardev major */
+	uint32_t	dev_minor;		/* chardev minor */
+	uint32_t	spare[10];
+};
+
+struct fuse_interrupt_in {
+	uint64_t	unique;
+};
+
+struct fuse_bmap_in {
+	uint64_t	block;
+	uint32_t	blocksize;
+	uint32_t	padding;
+};
+
+struct fuse_bmap_out {
+	uint64_t	block;
+};
+
+struct fuse_ioctl_in {
+	uint64_t	fh;
+	uint32_t	flags;
+	uint32_t	cmd;
+	uint64_t	arg;
+	uint32_t	in_size;
+	uint32_t	out_size;
+};
+
+struct fuse_ioctl_iovec {
+	uint64_t	base;
+	uint64_t	len;
+};
+
+struct fuse_ioctl_out {
+	int32_t		result;
+	uint32_t	flags;
+	uint32_t	in_iovs;
+	uint32_t	out_iovs;
+};
+
+struct fuse_poll_in {
+	uint64_t	fh;
+	uint64_t	kh;
+	uint32_t	flags;
+	uint32_t	events;
+};
+
+struct fuse_poll_out {
+	uint32_t	revents;
+	uint32_t	padding;
+};
+
+struct fuse_notify_poll_wakeup_out {
+	uint64_t	kh;
+};
+
+struct fuse_fallocate_in {
+	uint64_t	fh;
+	uint64_t	offset;
+	uint64_t	length;
+	uint32_t	mode;
+	uint32_t	padding;
+};
+
+struct fuse_in_header {
+	uint32_t	len;
+	uint32_t	opcode;
+	uint64_t	unique;
+	uint64_t	nodeid;
+	uint32_t	uid;
+	uint32_t	gid;
+	uint32_t	pid;
+	uint16_t	total_extlen; /* length of extensions in 8byte units */
+	uint16_t	padding;
+};
+
+struct fuse_out_header {
+	uint32_t	len;
+	int32_t		error;
+	uint64_t	unique;
+};
+
+struct fuse_dirent {
+	uint64_t	ino;
+	uint64_t	off;
+	uint32_t	namelen;
+	uint32_t	type;
+	char name[];
+};
+
+/* Align variable length records to 64bit boundary */
+#define FUSE_REC_ALIGN(x) \
+	(((x) + sizeof(uint64_t) - 1) & ~(sizeof(uint64_t) - 1))
+
+#define FUSE_NAME_OFFSET offsetof(struct fuse_dirent, name)
+#define FUSE_DIRENT_ALIGN(x) FUSE_REC_ALIGN(x)
+#define FUSE_DIRENT_SIZE(d) \
+	FUSE_DIRENT_ALIGN(FUSE_NAME_OFFSET + (d)->namelen)
+
+struct fuse_direntplus {
+	struct fuse_entry_out entry_out;
+	struct fuse_dirent dirent;
+};
+
+#define FUSE_NAME_OFFSET_DIRENTPLUS \
+	offsetof(struct fuse_direntplus, dirent.name)
+#define FUSE_DIRENTPLUS_SIZE(d) \
+	FUSE_DIRENT_ALIGN(FUSE_NAME_OFFSET_DIRENTPLUS + (d)->dirent.namelen)
+
+struct fuse_notify_inval_inode_out {
+	uint64_t	ino;
+	int64_t		off;
+	int64_t		len;
+};
+
+struct fuse_notify_inval_entry_out {
+	uint64_t	parent;
+	uint32_t	namelen;
+	uint32_t	flags;
+};
+
+struct fuse_notify_delete_out {
+	uint64_t	parent;
+	uint64_t	child;
+	uint32_t	namelen;
+	uint32_t	padding;
+};
+
+struct fuse_notify_store_out {
+	uint64_t	nodeid;
+	uint64_t	offset;
+	uint32_t	size;
+	uint32_t	padding;
+};
+
+struct fuse_notify_retrieve_out {
+	uint64_t	notify_unique;
+	uint64_t	nodeid;
+	uint64_t	offset;
+	uint32_t	size;
+	uint32_t	padding;
+};
+
+/* Matches the size of fuse_write_in */
+struct fuse_notify_retrieve_in {
+	uint64_t	dummy1;
+	uint64_t	offset;
+	uint32_t	size;
+	uint32_t	dummy2;
+	uint64_t	dummy3;
+	uint64_t	dummy4;
+};
+
+/* Device ioctls: */
+#define FUSE_DEV_IOC_MAGIC		229
+#define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
+#define FUSE_DEV_IOC_BPF_RESPONSE(N) _IOW(FUSE_DEV_IOC_MAGIC, 125, char[N])
+
+struct fuse_lseek_in {
+	uint64_t	fh;
+	uint64_t	offset;
+	uint32_t	whence;
+	uint32_t	padding;
+};
+
+struct fuse_lseek_out {
+	uint64_t	offset;
+};
+
+struct fuse_copy_file_range_in {
+	uint64_t	fh_in;
+	uint64_t	off_in;
+	uint64_t	nodeid_out;
+	uint64_t	fh_out;
+	uint64_t	off_out;
+	uint64_t	len;
+	uint64_t	flags;
+};
+
+#define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
+#define FUSE_SETUPMAPPING_FLAG_READ (1ull << 1)
+struct fuse_setupmapping_in {
+	/* An already open handle */
+	uint64_t	fh;
+	/* Offset into the file to start the mapping */
+	uint64_t	foffset;
+	/* Length of mapping required */
+	uint64_t	len;
+	/* Flags, FUSE_SETUPMAPPING_FLAG_* */
+	uint64_t	flags;
+	/* Offset in Memory Window */
+	uint64_t	moffset;
+};
+
+struct fuse_removemapping_in {
+	/* number of fuse_removemapping_one follows */
+	uint32_t        count;
+};
+
+struct fuse_removemapping_one {
+	/* Offset into the dax window start the unmapping */
+	uint64_t        moffset;
+	/* Length of mapping required */
+	uint64_t	len;
+};
+
+#define FUSE_REMOVEMAPPING_MAX_ENTRY   \
+		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
+
+struct fuse_syncfs_in {
+	uint64_t	padding;
+};
+
+/*
+ * For each security context, send fuse_secctx with size of security context
+ * fuse_secctx will be followed by security context name and this in turn
+ * will be followed by actual context label.
+ * fuse_secctx, name, context
+ */
+struct fuse_secctx {
+	uint32_t	size;
+	uint32_t	padding;
+};
+
+/*
+ * Contains the information about how many fuse_secctx structures are being
+ * sent and what's the total size of all security contexts (including
+ * size of fuse_secctx_header).
+ *
+ */
+struct fuse_secctx_header {
+	uint32_t	size;
+	uint32_t	nr_secctx;
+};
+
+/**
+ * struct fuse_ext_header - extension header
+ * @size: total size of this extension including this header
+ * @type: type of extension
+ *
+ * This is made compatible with fuse_secctx_header by using type values >
+ * FUSE_MAX_NR_SECCTX
+ */
+struct fuse_ext_header {
+	uint32_t	size;
+	uint32_t	type;
+};
+
+/**
+ * struct fuse_supp_groups - Supplementary group extension
+ * @nr_groups: number of supplementary groups
+ * @groups: flexible array of group IDs
+ */
+struct fuse_supp_groups {
+	uint32_t	nr_groups;
+	uint32_t	groups[];
+};
+
+#endif /* _LINUX_FUSE_H */
-- 
2.44.0.478.gd926399ef9-goog


