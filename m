Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D772D5EB5A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiIZXV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiIZXUV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:20:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4025270F
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-34d188806a8so75198587b3.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=0QBz/J/0LPKoIlveKCk8tGtpKvTNgflduH8ludvOW9A=;
        b=nkDrX+Kx2aw381QJMZin6BxPou1G5kY3UWIHa1L1gO7t/Is47ML2heDYPBlVA2inNO
         yEQx/bXRM2l9MU1EIW0AqvUTl6gf6Chk7w4/phkNDoyInFFqhxgAJaTWXq5Spzvn40mC
         QuPP96Ifr9f/WxCgs6Aq94K/Kae3Hfr6DEQQ9GgtxOakmk4PeZV1G+WZJ/MNYb4ST5rE
         6ubXrVjsL9omeDN7eKR8C61g7ttnQXjS+pRnGm8tjiwZxHufYRbAAOvNiwQElY2HudWL
         urviR7y7ewmbWxxeuDAdPyfU2r8EeUWtWSiFQUxHlg2fZ7cDC6dMqOMuXvDt63PQE/pV
         IMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=0QBz/J/0LPKoIlveKCk8tGtpKvTNgflduH8ludvOW9A=;
        b=sGa85FtSVA+WknzugPmcKT6k5qE9OMvsFt67fNy5ekcpxDdKYSMWK4mDTmTCm4v4y4
         6/e+S7zUjXbP94rzky0lDJY5KWQTUXqV9mVqvh2zT8TvJim/I2LAGfM3HxQHme4W8iJm
         4ZWatPhwkyEaVp7t/aMirJKQjMU9t+olP8vXdwNoArbIkt4J+Co94rTDZT+5serq5JaK
         ZILrCe4uzpRySyg7lDjSNW+KRHMYROYIZthvh41TAWGLdLXJASmec0C5eR/W0P1QbaYP
         Qx/B/JT+3jLJ6StHF27znHNiiyOiHsQrqPXg+HLYqk1WjXlYUMTZjSAa9sW5mYUfOl+0
         MEng==
X-Gm-Message-State: ACrzQf3twqf6t89HWghwk9z26UgVOD3Oxgzj5nBGAbu7BFG9RJR2qNYl
        7uQYIsLP5Sz9LS+iPPekTYzM8h7q2NQ=
X-Google-Smtp-Source: AMsMyM4qsQECuTTTw/CQqIsX8vlPVNO2ClakpiMtU6OO+MU22nG+FsO6JLhVTUIKzPx3KTxHbYT5JevhDow=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a05:6902:1246:b0:6ae:fd40:bab9 with SMTP id
 t6-20020a056902124600b006aefd40bab9mr22321383ybu.563.1664234379262; Mon, 26
 Sep 2022 16:19:39 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:22 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-27-drosen@google.com>
Subject: [PATCH 26/26] fuse-bpf: Add selftests
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This test suite covers basic fuse-bpf functionality.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
Signed-off-by: Alessio Balsini <balsini@google.com>
---
 tools/include/uapi/linux/bpf.h                |   33 +
 tools/include/uapi/linux/fuse.h               | 1066 ++++++++
 .../selftests/filesystems/fuse/.gitignore     |    2 +
 .../selftests/filesystems/fuse/Makefile       |   41 +
 .../testing/selftests/filesystems/fuse/OWNERS |    2 +
 .../selftests/filesystems/fuse/bpf_loader.c   |  798 ++++++
 .../testing/selftests/filesystems/fuse/fd.txt |   21 +
 .../selftests/filesystems/fuse/fd_bpf.c       |  370 +++
 .../selftests/filesystems/fuse/fuse_daemon.c  |  294 +++
 .../selftests/filesystems/fuse/fuse_test.c    | 2147 +++++++++++++++++
 .../selftests/filesystems/fuse/test_bpf.c     |  800 ++++++
 .../filesystems/fuse/test_framework.h         |  173 ++
 .../selftests/filesystems/fuse/test_fuse.h    |  328 +++
 13 files changed, 6075 insertions(+)
 create mode 100644 tools/include/uapi/linux/fuse.h
 create mode 100644 tools/testing/selftests/filesystems/fuse/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fuse/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fuse/OWNERS
 create mode 100644 tools/testing/selftests/filesystems/fuse/bpf_loader.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fd.txt
 create mode 100644 tools/testing/selftests/filesystems/fuse/fd_bpf.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_daemon.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_test.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/test_bpf.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/test_framework.h
 create mode 100644 tools/testing/selftests/filesystems/fuse/test_fuse.h

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 59a217ca2dfd..a0ad91e9b9b0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -952,6 +952,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_LSM,
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
+	BPF_PROG_TYPE_FUSE,
 };
 
 enum bpf_attach_type {
@@ -5541,6 +5542,8 @@ union bpf_attr {
 	FN(tcp_raw_gen_syncookie_ipv6),	\
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
+	FN(fuse_get_writeable_in),	\
+	FN(fuse_get_writeable_out),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
@@ -6848,4 +6851,34 @@ struct bpf_core_relo {
 	enum bpf_core_relo_kind kind;
 };
 
+struct __bpf_fuse_arg {
+	__u64 value;
+	__u64 end_offset;
+	__u32 size;
+	__u32 max_size;
+};
+
+struct __bpf_fuse_args {
+	__u64 nodeid;
+	__u32 opcode;
+	__u32 error_in;
+	__u32 in_numargs;
+	__u32 out_numargs;
+	__u32 flags;
+	struct __bpf_fuse_arg in_args[3];
+	struct __bpf_fuse_arg out_args[2];
+};
+
+/* Return Codes for Fuse BPF programs */
+#define BPF_FUSE_CONTINUE 		0
+#define BPF_FUSE_USER			1
+#define BPF_FUSE_USER_PREFILTER		2
+#define BPF_FUSE_POSTFILTER		3
+#define BPF_FUSE_USER_POSTFILTER	4
+
+/* Op Code Filter values for BPF Programs */
+#define FUSE_OPCODE_FILTER	0x0ffff
+#define FUSE_PREFILTER		0x10000
+#define FUSE_POSTFILTER		0x20000
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/include/uapi/linux/fuse.h b/tools/include/uapi/linux/fuse.h
new file mode 100644
index 000000000000..45286cc6b7ec
--- /dev/null
+++ b/tools/include/uapi/linux/fuse.h
@@ -0,0 +1,1066 @@
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
+#define FUSE_KERNEL_MINOR_VERSION 36
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
+ */
+#define FOPEN_DIRECT_IO		(1 << 0)
+#define FOPEN_KEEP_CACHE	(1 << 1)
+#define FOPEN_NONSEEKABLE	(1 << 2)
+#define FOPEN_CACHE_DIR		(1 << 3)
+#define FOPEN_STREAM		(1 << 4)
+#define FOPEN_NOFLUSH		(1 << 5)
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
+
+/*
+ * For FUSE < 7.36 FUSE_PASSTHROUGH has value (1 << 31).
+ * This condition check is not really required, but would prevent having a
+ * broken commit in the tree.
+ */
+#if FUSE_KERNEL_VERSION > 7 ||                                                 \
+	(FUSE_KERNEL_VERSION == 7 && FUSE_KERNEL_MINOR_VERSION >= 36)
+#define FUSE_PASSTHROUGH (1ULL << 63)
+#else
+#define FUSE_PASSTHROUGH (1 << 31)
+#endif
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
+#define FUSE_ACTION_KEEP	0
+#define FUSE_ACTION_REMOVE	1
+#define FUSE_ACTION_REPLACE	2
+
+struct fuse_entry_bpf_out {
+	uint64_t	backing_action;
+	uint64_t	backing_fd;
+	uint64_t	bpf_action;
+	uint64_t	bpf_fd;
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
+	uint32_t	passthrough_fh;
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
+	uint32_t	error_in;
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
+	uint32_t	padding;
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
+/* 127 is reserved for the V1 interface implementation in Android (deprecated) */
+/* 126 is reserved for the V2 interface implementation in Android */
+#define FUSE_DEV_IOC_PASSTHROUGH_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 126, uint32_t)
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
+#endif /* _LINUX_FUSE_H */
diff --git a/tools/testing/selftests/filesystems/fuse/.gitignore b/tools/testing/selftests/filesystems/fuse/.gitignore
new file mode 100644
index 000000000000..3ee9a27fe66a
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/.gitignore
@@ -0,0 +1,2 @@
+fuse_test
+*.raw
diff --git a/tools/testing/selftests/filesystems/fuse/Makefile b/tools/testing/selftests/filesystems/fuse/Makefile
new file mode 100644
index 000000000000..98acf81dce45
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/Makefile
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../../../../../scripts/Kbuild.include
+include ../../../../scripts/Makefile.arch
+
+CXX ?= $(CROSS_COMPILE)g++
+
+CURDIR := $(abspath .)
+TOOLSDIR := $(abspath ../../../..)
+TOOLINCDIR := $(TOOLSDIR)/include
+APIDIR := $(TOOLINCDIR)/uapi
+SELFTESTS:=$(TOOLSDIR)/testing/selftests/
+
+CFLAGS += -D_FILE_OFFSET_BITS=64 -Wall -Werror -I$(CURDIR) \
+	  -I$(TOOLINCDIR) -I$(APIDIR) -I$(SELFTESTS)
+LDLIBS := -lpthread -lelf
+TEST_GEN_PROGS := fuse_test fuse_daemon
+TEST_GEN_FILES := \
+	test_bpf.bpf \
+	fd_bpf.bpf \
+	fd.sh \
+
+EXTRA_CLEAN := *.bpf
+BPF_FLAGS = -Wall -Werror -O2 -g -emit-llvm
+
+include ../../lib.mk
+
+# Put after include ../../lib.mk since that changes $(TEST_GEN_PROGS)
+# Otherwise you get multiple targets, this becomes the default, and it's a mess
+EXTRA_SOURCES := bpf_loader.c
+$(TEST_GEN_PROGS) : $(EXTRA_SOURCES)
+
+$(OUTPUT)/%.ir: %.c
+	clang $(BPF_FLAGS) -c $(CFLAGS) $< -o $@
+
+$(OUTPUT)/%.bpf: $(OUTPUT)/%.ir
+	llc -march=bpf -filetype=obj -o $@ $<
+
+$(OUTPUT)/fd.sh: fd.txt
+	cp $< $@
+	chmod 755 $@
+
diff --git a/tools/testing/selftests/filesystems/fuse/OWNERS b/tools/testing/selftests/filesystems/fuse/OWNERS
new file mode 100644
index 000000000000..5eb371e1a5a3
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/OWNERS
@@ -0,0 +1,2 @@
+# include OWNERS from the authoritative android-mainline branch
+include kernel/common:android-mainline:/tools/testing/selftests/filesystems/incfs/OWNERS
diff --git a/tools/testing/selftests/filesystems/fuse/bpf_loader.c b/tools/testing/selftests/filesystems/fuse/bpf_loader.c
new file mode 100644
index 000000000000..2020eac7e5ba
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/bpf_loader.c
@@ -0,0 +1,798 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 Google LLC
+ */
+
+#include "test_fuse.h"
+
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <gelf.h>
+#include <libelf.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/statfs.h>
+#include <sys/xattr.h>
+
+#include <linux/unistd.h>
+
+#include <uapi/linux/fuse.h>
+#include <uapi/linux/bpf.h>
+
+struct _test_options test_options;
+
+struct s s(const char *s1)
+{
+	struct s s = {0};
+
+	if (!s1)
+		return s;
+
+	s.s = malloc(strlen(s1) + 1);
+	if (!s.s)
+		return s;
+
+	strcpy(s.s, s1);
+	return s;
+}
+
+struct s sn(const char *s1, const char *s2)
+{
+	struct s s = {0};
+
+	if (!s1)
+		return s;
+
+	s.s = malloc(s2 - s1 + 1);
+	if (!s.s)
+		return s;
+
+	strncpy(s.s, s1, s2 - s1);
+	s.s[s2 - s1] = 0;
+	return s;
+}
+
+int s_cmp(struct s s1, struct s s2)
+{
+	int result = -1;
+
+	if (!s1.s || !s2.s)
+		goto out;
+	result = strcmp(s1.s, s2.s);
+out:
+	free(s1.s);
+	free(s2.s);
+	return result;
+}
+
+struct s s_cat(struct s s1, struct s s2)
+{
+	struct s s = {0};
+
+	if (!s1.s || !s2.s)
+		goto out;
+
+	s.s = malloc(strlen(s1.s) + strlen(s2.s) + 1);
+	if (!s.s)
+		goto out;
+
+	strcpy(s.s, s1.s);
+	strcat(s.s, s2.s);
+out:
+	free(s1.s);
+	free(s2.s);
+	return s;
+}
+
+struct s s_splitleft(struct s s1, char c)
+{
+	struct s s = {0};
+	char *split;
+
+	if (!s1.s)
+		return s;
+
+	split = strchr(s1.s, c);
+	if (split)
+		s = sn(s1.s, split);
+
+	free(s1.s);
+	return s;
+}
+
+struct s s_splitright(struct s s1, char c)
+{
+	struct s s2 = {0};
+	char *split;
+
+	if (!s1.s)
+		return s2;
+
+	split = strchr(s1.s, c);
+	if (split)
+		s2 = s(split + 1);
+
+	free(s1.s);
+	return s2;
+}
+
+struct s s_word(struct s s1, char c, size_t n)
+{
+	while (n--)
+		s1 = s_splitright(s1, c);
+	return s_splitleft(s1, c);
+}
+
+struct s s_path(struct s s1, struct s s2)
+{
+	return s_cat(s_cat(s1, s("/")), s2);
+}
+
+struct s s_pathn(size_t n, struct s s1, ...)
+{
+	va_list argp;
+
+	va_start(argp, s1);
+	while (--n)
+		s1 = s_path(s1, va_arg(argp, struct s));
+	va_end(argp);
+	return s1;
+}
+
+int s_link(struct s src_pathname, struct s dst_pathname)
+{
+	int res;
+
+	if (src_pathname.s && dst_pathname.s) {
+		res = link(src_pathname.s, dst_pathname.s);
+	} else {
+		res = -1;
+		errno = ENOMEM;
+	}
+
+	free(src_pathname.s);
+	free(dst_pathname.s);
+	return res;
+}
+
+int s_symlink(struct s src_pathname, struct s dst_pathname)
+{
+	int res;
+
+	if (src_pathname.s && dst_pathname.s) {
+		res = symlink(src_pathname.s, dst_pathname.s);
+	} else {
+		res = -1;
+		errno = ENOMEM;
+	}
+
+	free(src_pathname.s);
+	free(dst_pathname.s);
+	return res;
+}
+
+
+int s_mkdir(struct s pathname, mode_t mode)
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = mkdir(pathname.s, mode);
+	free(pathname.s);
+	return res;
+}
+
+int s_rmdir(struct s pathname)
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = rmdir(pathname.s);
+	free(pathname.s);
+	return res;
+}
+
+int s_unlink(struct s pathname)
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = unlink(pathname.s);
+	free(pathname.s);
+	return res;
+}
+
+int s_open(struct s pathname, int flags, ...)
+{
+	va_list ap;
+	int res;
+
+	va_start(ap, flags);
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	if (flags & (O_CREAT | O_TMPFILE))
+		res = open(pathname.s, flags, va_arg(ap, mode_t));
+	else
+		res = open(pathname.s, flags);
+
+	free(pathname.s);
+	va_end(ap);
+	return res;
+}
+
+int s_openat(int dirfd, struct s pathname, int flags, ...)
+{
+	va_list ap;
+	int res;
+
+	va_start(ap, flags);
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	if (flags & (O_CREAT | O_TMPFILE))
+		res = openat(dirfd, pathname.s, flags, va_arg(ap, mode_t));
+	else
+		res = openat(dirfd, pathname.s, flags);
+
+	free(pathname.s);
+	va_end(ap);
+	return res;
+}
+
+int s_creat(struct s pathname, mode_t mode)
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = open(pathname.s, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, mode);
+	free(pathname.s);
+	return res;
+}
+
+int s_mkfifo(struct s pathname, mode_t mode)
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = mknod(pathname.s, S_IFIFO | mode, 0);
+	free(pathname.s);
+	return res;
+}
+
+int s_stat(struct s pathname, struct stat *st)
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = stat(pathname.s, st);
+	free(pathname.s);
+	return res;
+}
+
+int s_statfs(struct s pathname, struct statfs *st)
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = statfs(pathname.s, st);
+	free(pathname.s);
+	return res;
+}
+
+DIR *s_opendir(struct s pathname)
+{
+	DIR *res;
+
+	res = opendir(pathname.s);
+	free(pathname.s);
+	return res;
+}
+
+int s_getxattr(struct s pathname, const char name[], void *value, size_t size,
+	       ssize_t *ret_size)
+{
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	*ret_size = getxattr(pathname.s, name, value, size);
+	free(pathname.s);
+	return *ret_size >= 0 ? 0 : -1;
+}
+
+int s_listxattr(struct s pathname, void *list, size_t size, ssize_t *ret_size)
+{
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	*ret_size = listxattr(pathname.s, list, size);
+	free(pathname.s);
+	return *ret_size >= 0 ? 0 : -1;
+}
+
+int s_setxattr(struct s pathname, const char name[], const void *value, size_t size, int flags)
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = setxattr(pathname.s, name, value, size, flags);
+	free(pathname.s);
+	return res;
+}
+
+int s_removexattr(struct s pathname, const char name[])
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = removexattr(pathname.s, name);
+	free(pathname.s);
+	return res;
+}
+
+int s_rename(struct s oldpathname, struct s newpathname)
+{
+	int res;
+
+	if (!oldpathname.s || !newpathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = rename(oldpathname.s, newpathname.s);
+	free(oldpathname.s);
+	free(newpathname.s);
+	return res;
+}
+
+int s_fuse_attr(struct s pathname, struct fuse_attr *fuse_attr_out)
+{
+
+	struct stat st;
+	int result = TEST_FAILURE;
+
+	TESTSYSCALL(s_stat(pathname, &st));
+
+	fuse_attr_out->ino = st.st_ino;
+	fuse_attr_out->mode = st.st_mode;
+	fuse_attr_out->nlink = st.st_nlink;
+	fuse_attr_out->uid = st.st_uid;
+	fuse_attr_out->gid = st.st_gid;
+	fuse_attr_out->rdev = st.st_rdev;
+	fuse_attr_out->size = st.st_size;
+	fuse_attr_out->blksize = st.st_blksize;
+	fuse_attr_out->blocks = st.st_blocks;
+	fuse_attr_out->atime = st.st_atime;
+	fuse_attr_out->mtime = st.st_mtime;
+	fuse_attr_out->ctime = st.st_ctime;
+	fuse_attr_out->atimensec = UINT32_MAX;
+	fuse_attr_out->mtimensec = UINT32_MAX;
+	fuse_attr_out->ctimensec = UINT32_MAX;
+
+	result = TEST_SUCCESS;
+out:
+	return result;
+}
+
+struct s tracing_folder(void)
+{
+	struct s trace = {0};
+	FILE *mounts = NULL;
+	char *line = NULL;
+	size_t size = 0;
+
+	TEST(mounts = fopen("/proc/mounts", "re"), mounts);
+	while (getline(&line, &size, mounts) != -1) {
+		if (!s_cmp(s_word(sn(line, line + size), ' ', 2),
+			   s("tracefs"))) {
+			trace = s_word(sn(line, line + size), ' ', 1);
+			break;
+		}
+
+		if (!s_cmp(s_word(sn(line, line + size), ' ', 2), s("debugfs")))
+			trace = s_path(s_word(sn(line, line + size), ' ', 1),
+				       s("tracing"));
+	}
+
+out:
+	free(line);
+	fclose(mounts);
+	return trace;
+}
+
+int tracing_on(void)
+{
+	int result = TEST_FAILURE;
+	int tracing_on = -1;
+
+	TEST(tracing_on = s_open(s_path(tracing_folder(), s("tracing_on")),
+				 O_WRONLY | O_CLOEXEC),
+	     tracing_on != -1);
+	TESTEQUAL(write(tracing_on, "1", 1), 1);
+	result = TEST_SUCCESS;
+out:
+	close(tracing_on);
+	return result;
+}
+
+char *concat_file_name(const char *dir, const char *file)
+{
+	char full_name[FILENAME_MAX] = "";
+
+	if (snprintf(full_name, ARRAY_SIZE(full_name), "%s/%s", dir, file) < 0)
+		return NULL;
+	return strdup(full_name);
+}
+
+char *setup_mount_dir(const char *name)
+{
+	struct stat st;
+	char *current_dir = getcwd(NULL, 0);
+	char *mount_dir = concat_file_name(current_dir, name);
+
+	free(current_dir);
+	if (stat(mount_dir, &st) == 0) {
+		if (S_ISDIR(st.st_mode))
+			return mount_dir;
+
+		ksft_print_msg("%s is a file, not a dir.\n", mount_dir);
+		return NULL;
+	}
+
+	if (mkdir(mount_dir, 0777)) {
+		ksft_print_msg("Can't create mount dir.");
+		return NULL;
+	}
+
+	return mount_dir;
+}
+
+int delete_dir_tree(const char *dir_path, bool remove_root)
+{
+	DIR *dir = NULL;
+	struct dirent *dp;
+	int result = 0;
+
+	dir = opendir(dir_path);
+	if (!dir) {
+		result = -errno;
+		goto out;
+	}
+
+	while ((dp = readdir(dir))) {
+		char *full_path;
+
+		if (!strcmp(dp->d_name, ".") || !strcmp(dp->d_name, ".."))
+			continue;
+
+		full_path = concat_file_name(dir_path, dp->d_name);
+		if (dp->d_type == DT_DIR)
+			result = delete_dir_tree(full_path, true);
+		else
+			result = unlink(full_path);
+		free(full_path);
+		if (result)
+			goto out;
+	}
+
+out:
+	if (dir)
+		closedir(dir);
+	if (!result && remove_root)
+		rmdir(dir_path);
+	return result;
+}
+
+static int mount_fuse_maybe_init(const char *mount_dir, int bpf_fd, int dir_fd,
+			     int *fuse_dev_ptr, bool init)
+{
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	char options[FILENAME_MAX];
+	uint8_t bytes_in[FUSE_MIN_READ_BUFFER];
+	uint8_t bytes_out[FUSE_MIN_READ_BUFFER];
+
+	DECL_FUSE_IN(init);
+
+	TEST(fuse_dev = open("/dev/fuse", O_RDWR | O_CLOEXEC), fuse_dev != -1);
+	snprintf(options, FILENAME_MAX, "fd=%d,user_id=0,group_id=0,rootmode=0040000",
+		 fuse_dev);
+	if (bpf_fd != -1)
+		snprintf(options + strlen(options),
+			 sizeof(options) - strlen(options),
+			 ",root_bpf=%d", bpf_fd);
+	if (dir_fd != -1)
+		snprintf(options + strlen(options),
+			 sizeof(options) - strlen(options),
+			 ",root_dir=%d", dir_fd);
+	TESTSYSCALL(mount("ABC", mount_dir, "fuse", 0, options));
+
+	if (init) {
+		TESTFUSEIN(FUSE_INIT, init_in);
+		TESTEQUAL(init_in->major, FUSE_KERNEL_VERSION);
+		TESTEQUAL(init_in->minor, FUSE_KERNEL_MINOR_VERSION);
+		TESTFUSEOUT1(fuse_init_out, ((struct fuse_init_out) {
+			.major = FUSE_KERNEL_VERSION,
+			.minor = FUSE_KERNEL_MINOR_VERSION,
+			.max_readahead = 4096,
+			.flags = 0,
+			.max_background = 0,
+			.congestion_threshold = 0,
+			.max_write = 4096,
+			.time_gran = 1000,
+			.max_pages = 12,
+			.map_alignment = 4096,
+		}));
+	}
+
+	*fuse_dev_ptr = fuse_dev;
+	fuse_dev = -1;
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	return result;
+}
+
+int mount_fuse(const char *mount_dir, int bpf_fd, int dir_fd, int *fuse_dev_ptr)
+{
+	return mount_fuse_maybe_init(mount_dir, bpf_fd, dir_fd, fuse_dev_ptr,
+				     true);
+}
+
+int mount_fuse_no_init(const char *mount_dir, int bpf_fd, int dir_fd,
+		       int *fuse_dev_ptr)
+{
+	return mount_fuse_maybe_init(mount_dir, bpf_fd, dir_fd, fuse_dev_ptr,
+				     false);
+}
+
+struct fuse_bpf_map {
+	unsigned int map_type;
+	size_t key_size;
+	size_t value_size;
+	unsigned int max_entries;
+};
+
+static int install_maps(Elf_Data *maps, int maps_index, Elf *elf,
+			Elf_Data *symbols, int symbol_index,
+			struct map_relocation **mr, size_t *map_count)
+{
+	int result = TEST_FAILURE;
+	int i;
+	GElf_Sym symbol;
+
+	TESTNE((void *)symbols, NULL);
+
+	for (i = 0; i < symbols->d_size / sizeof(symbol); ++i) {
+		TESTNE((void *)gelf_getsym(symbols, i, &symbol), 0);
+		if (symbol.st_shndx == maps_index) {
+			struct fuse_bpf_map *map;
+			union bpf_attr attr;
+			int map_fd;
+
+			map = (struct fuse_bpf_map *)
+				((char *)maps->d_buf + symbol.st_value);
+
+			attr = (union bpf_attr) {
+				.map_type = map->map_type,
+				.key_size = map->key_size,
+				.value_size = map->value_size,
+				.max_entries = map->max_entries,
+			};
+
+			TEST(*mr = realloc(*mr, ++*map_count *
+					   sizeof(struct fuse_bpf_map)),
+			     *mr);
+			TEST(map_fd = syscall(__NR_bpf, BPF_MAP_CREATE,
+					      &attr, sizeof(attr)),
+			     map_fd != -1);
+			(*mr)[*map_count - 1] = (struct map_relocation) {
+				.name = strdup(elf_strptr(elf, symbol_index,
+							  symbol.st_name)),
+				.fd = map_fd,
+				.value = symbol.st_value,
+			};
+		}
+	}
+
+	result = TEST_SUCCESS;
+out:
+	return result;
+}
+
+static inline int relocate_maps(GElf_Shdr *rel_header, Elf_Data *rel_data,
+			 Elf_Data *prog_data, Elf_Data *symbol_data,
+			 struct map_relocation *map_relocations,
+			 size_t map_count)
+{
+	int result = TEST_FAILURE;
+	int i;
+	struct bpf_insn *insns = (struct bpf_insn *) prog_data->d_buf;
+
+	for (i = 0; i < rel_header->sh_size / rel_header->sh_entsize; ++i) {
+		GElf_Sym sym;
+		GElf_Rel rel;
+		unsigned int insn_idx;
+		int map_idx;
+
+		gelf_getrel(rel_data, i, &rel);
+		insn_idx = rel.r_offset / sizeof(struct bpf_insn);
+		insns[insn_idx].src_reg = BPF_PSEUDO_MAP_FD;
+
+		gelf_getsym(symbol_data, GELF_R_SYM(rel.r_info), &sym);
+		for (map_idx = 0; map_idx < map_count; map_idx++) {
+			if (map_relocations[map_idx].value == sym.st_value) {
+				insns[insn_idx].imm =
+					map_relocations[map_idx].fd;
+				break;
+			}
+		}
+		TESTNE(map_idx, map_count);
+	}
+
+	result = TEST_SUCCESS;
+out:
+	return result;
+}
+
+static int install_elf_bpf_helper(const char *file, const char *section, int *fd,
+		    struct map_relocation **map_relocations, size_t *map_count,
+		    bool is_valid)
+{
+	int result = TEST_FAILURE;
+	char path[PATH_MAX] = {};
+	char *last_slash;
+	int filter_fd = -1;
+	union bpf_attr bpf_attr;
+	static char log[1 << 20];
+	Elf *elf = NULL;
+	GElf_Ehdr ehdr;
+	Elf_Data *data_prog = NULL, *data_maps = NULL, *data_symbols = NULL;
+	int maps_index, symbol_index, prog_index;
+	int i;
+
+	TESTNE(readlink("/proc/self/exe", path, PATH_MAX), -1);
+	TEST(last_slash = strrchr(path, '/'), last_slash);
+	strcpy(last_slash + 1, file);
+	TEST(filter_fd = open(path, O_RDONLY | O_CLOEXEC), filter_fd != -1);
+	TESTNE(elf_version(EV_CURRENT), EV_NONE);
+	TEST(elf = elf_begin(filter_fd, ELF_C_READ, NULL), elf);
+	TESTEQUAL((void *) gelf_getehdr(elf, &ehdr), &ehdr);
+	for (i = 1; i < ehdr.e_shnum; i++) {
+		char *shname;
+		GElf_Shdr shdr;
+		Elf_Scn *scn;
+
+		TEST(scn = elf_getscn(elf, i), scn);
+		TESTEQUAL((void *)gelf_getshdr(scn, &shdr), &shdr);
+		TEST(shname = elf_strptr(elf, ehdr.e_shstrndx, shdr.sh_name),
+		     shname);
+
+		if (!strcmp(shname, "maps")) {
+			TEST(data_maps = elf_getdata(scn, 0), data_maps);
+			maps_index = i;
+		} else if (shdr.sh_type == SHT_SYMTAB) {
+			TEST(data_symbols = elf_getdata(scn, 0), data_symbols);
+			symbol_index = shdr.sh_link;
+		} else if (!strcmp(shname, section)) {
+			TEST(data_prog = elf_getdata(scn, 0), data_prog);
+			prog_index = i;
+		}
+	}
+	TESTNE((void *) data_prog, NULL);
+
+	if (data_maps)
+		TESTEQUAL(install_maps(data_maps, maps_index, elf,
+				       data_symbols, symbol_index,
+				       map_relocations, map_count), 0);
+
+	/* Now relocate maps */
+	for (i = 1; i < ehdr.e_shnum; i++) {
+		GElf_Shdr rel_header;
+		Elf_Scn *scn;
+		Elf_Data *rel_data;
+
+		TEST(scn = elf_getscn(elf, i), scn);
+		TESTEQUAL((void *)gelf_getshdr(scn, &rel_header),
+			&rel_header);
+		if (rel_header.sh_type != SHT_REL)
+			continue;
+		TEST(rel_data = elf_getdata(scn, 0), rel_data);
+
+		if (rel_header.sh_info != prog_index)
+			continue;
+		TESTEQUAL(relocate_maps(&rel_header, rel_data,
+					data_prog, data_symbols,
+					*map_relocations, *map_count),
+			  0);
+	}
+
+	bpf_attr = (union bpf_attr) {
+		.prog_type = BPF_PROG_TYPE_FUSE,
+		.insn_cnt = data_prog->d_size / 8,
+		.insns = ptr_to_u64(data_prog->d_buf),
+		.license = ptr_to_u64("GPL"),
+		.log_buf = test_options.verbose ? ptr_to_u64(log) : 0,
+		.log_size = test_options.verbose ? sizeof(log) : 0,
+		.log_level = test_options.verbose ? 2 : 0,
+	};
+	*fd = syscall(__NR_bpf, BPF_PROG_LOAD, &bpf_attr, sizeof(bpf_attr));
+	if (test_options.verbose)
+		ksft_print_msg("%s\n", log);
+	if (*fd == -1 && errno == ENOSPC)
+		ksft_print_msg("bpf log size too small!\n");
+	if (is_valid)
+		TESTNE(*fd, -1);
+	else
+		TESTEQUAL(*fd, -1);
+
+	result = TEST_SUCCESS;
+out:
+	close(filter_fd);
+	return result;
+}
+
+int install_elf_bpf(const char *file, const char *section, int *fd,
+		    struct map_relocation **map_relocations, size_t *map_count)
+{
+	return install_elf_bpf_helper(file, section, fd, map_relocations,
+			map_count, true);
+}
+
+int install_elf_bpf_invalid(const char *file, const char *section, int *fd,
+		    struct map_relocation **map_relocations, size_t *map_count)
+{
+	return install_elf_bpf_helper(file, section, fd, map_relocations,
+			map_count, false);
+}
+
+
diff --git a/tools/testing/selftests/filesystems/fuse/fd.txt b/tools/testing/selftests/filesystems/fuse/fd.txt
new file mode 100644
index 000000000000..15ce77180d55
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/fd.txt
@@ -0,0 +1,21 @@
+fuse_daemon $*
+cd fd-dst
+ls
+cd show
+ls
+fsstress -s 123 -d . -p 4 -n 100 -l5
+echo test > wibble
+ls
+cat wibble
+fallocate -l 1000 wobble
+mkdir testdir
+mkdir tmpdir
+rmdir tmpdir
+touch tmp
+mv tmp tmp2
+rm tmp2
+
+# FUSE_LINK
+echo "ln_src contents" > ln_src
+ln ln_src ln_link
+cat ln_link
diff --git a/tools/testing/selftests/filesystems/fuse/fd_bpf.c b/tools/testing/selftests/filesystems/fuse/fd_bpf.c
new file mode 100644
index 000000000000..7d23c0fb95ae
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/fd_bpf.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+// Copyright (c) 2021 Google LLC
+
+#define __EXPORTED_HEADERS__
+#define __KERNEL__
+
+#include <uapi/linux/bpf.h>
+#include <uapi/linux/fuse.h>
+
+struct fuse_bpf_map {
+	int map_type;
+	size_t key_size;
+	size_t value_size;
+	int max_entries;
+};
+
+static void *(*bpf_map_lookup_elem)(struct fuse_bpf_map *map, void *key)
+	= (void *) 1;
+
+static void *(*bpf_map_update_elem)(struct fuse_bpf_map *map, void *key,
+				    void *value, int flags)
+	= (void *) 2;
+
+static long (*bpf_trace_printk)(const char *fmt, __u32 fmt_size, ...)
+	= (void *) 6;
+
+static long (*bpf_get_current_pid_tgid)()
+	= (void *) 14;
+
+static long (*bpf_get_current_uid_gid)()
+	= (void *) 15;
+
+#define bpf_printk(fmt, ...)					\
+	({			                                \
+		char ____fmt[] = fmt;                           \
+		bpf_trace_printk(____fmt, sizeof(____fmt),      \
+		                 ##__VA_ARGS__);                \
+	})
+
+inline const void *fa_verify_in(struct __bpf_fuse_args *fa, int i, unsigned int size)
+{
+	const char *val = (void *)(long) fa->in_args[i].value;
+	const char *end = (void *)(long) fa->in_args[i].end_offset;
+
+	if (i >= fa->in_numargs)
+		return NULL;
+	if (val + size <= end)
+		return val;
+	return NULL;
+}
+
+inline void *fa_verify_out(struct __bpf_fuse_args *fa, int i, unsigned int size)
+{
+	char *val = (void *)(long) fa->out_args[i].value;
+	char *end = (void *)(long) fa->out_args[i].end_offset;
+
+	if (i >= fa->out_numargs)
+		return NULL;
+	if (val + size <= end)
+		return val;
+	return NULL;
+}
+
+#define SEC(NAME) __attribute__((section(NAME), used))
+
+SEC("dummy")
+
+inline int strcmp(const char *a, const char *b)
+{
+	int i;
+
+	for (i = 0; i < __builtin_strlen(b) + 1; ++i)
+		if (a[i] != b[i])
+			return -1;
+
+	return 0;
+}
+
+SEC("maps") struct fuse_bpf_map test_map = {
+	BPF_MAP_TYPE_ARRAY,
+	sizeof(uint32_t),
+	sizeof(uint32_t),
+	1000,
+};
+
+SEC("maps") struct fuse_bpf_map test_map2 = {
+	BPF_MAP_TYPE_HASH,
+	sizeof(uint32_t),
+	sizeof(uint64_t),
+	76,
+};
+
+SEC("test_daemon")
+
+int trace_daemon(struct __bpf_fuse_args *fa)
+{
+	uint64_t uid_gid = bpf_get_current_uid_gid();
+	uint32_t uid = uid_gid & 0xffffffff;
+	uint64_t pid_tgid = bpf_get_current_pid_tgid();
+	uint32_t pid = pid_tgid & 0xffffffff;
+	uint32_t key = 23;
+	uint32_t *pvalue;
+
+
+	pvalue = bpf_map_lookup_elem(&test_map, &key);
+	if (pvalue) {
+		uint32_t value = *pvalue;
+
+		bpf_printk("pid %u uid %u value %u", pid, uid, value);
+		value++;
+		bpf_map_update_elem(&test_map, &key,  &value, BPF_ANY);
+	}
+
+	switch (fa->opcode) {
+	case FUSE_ACCESS | FUSE_PREFILTER: {
+		bpf_printk("Access: %d", fa->nodeid);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_GETATTR | FUSE_PREFILTER: {
+		const struct fuse_getattr_in *fgi = fa_verify_in(fa, 0, sizeof(*fgi));
+
+		if (!fgi)
+			return -1;
+
+		bpf_printk("Get Attr %d", fgi->fh);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_SETATTR | FUSE_PREFILTER: {
+		const struct fuse_setattr_in *fsi = fa_verify_in(fa, 0, sizeof(*fsi));
+
+		if (!fsi)
+			return -1;
+
+		bpf_printk("Set Attr %d", fsi->fh);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_OPENDIR | FUSE_PREFILTER: {
+		bpf_printk("Open Dir: %d", fa->nodeid);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_READDIR | FUSE_PREFILTER: {
+		const struct fuse_read_in *fri = fa_verify_in(fa, 0, sizeof(*fri));
+
+		if (!fri)
+			return -1;
+
+		bpf_printk("Read Dir: fh: %lu", fri->fh, fri->offset);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_LOOKUP | FUSE_PREFILTER: {
+		const char *name = (void *)(long)fa->in_args[0].value;
+
+		bpf_printk("Lookup: %lx %s", fa->nodeid, name);
+		if (fa->nodeid == 1)
+			return BPF_FUSE_USER_PREFILTER;
+		else
+			return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_MKNOD | FUSE_PREFILTER: {
+		const struct fuse_mknod_in *fmi = fa_verify_in(fa, 0, sizeof(*fmi));
+		const char *name = (void *)(long)fa->in_args[1].value;
+
+		if (!fmi)
+			return -1;
+
+		bpf_printk("mknod %s %x %x", name,  fmi->rdev | fmi->mode, fmi->umask);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_MKDIR | FUSE_PREFILTER: {
+		const struct fuse_mkdir_in *fmi = fa_verify_in(fa, 0, sizeof(*fmi));
+		const char *name = (void *)(long)fa->in_args[1].value;
+
+		if (!fmi)
+			return -1;
+
+		bpf_printk("mkdir: %s %x %x", name, fmi->mode, fmi->umask);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_RMDIR | FUSE_PREFILTER: {
+		const char *name = (void *)(long)fa->in_args[0].value;
+
+		bpf_printk("rmdir: %s", name);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_RENAME | FUSE_PREFILTER: {
+		const char *oldname = (void *)(long) fa->in_args[1].value;
+		const char *newname = (void *)(long) fa->in_args[2].value;
+
+		bpf_printk("rename from %s", oldname);
+		bpf_printk("rename to %s", newname);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_RENAME2 | FUSE_PREFILTER: {
+		const struct fuse_rename2_in *fri = fa_verify_in(fa, 0, sizeof(*fri));
+		uint32_t flags = fri->flags;
+		const char *oldname = (void *)(long) fa->in_args[1].value;
+		const char *newname = (void *)(long) fa->in_args[2].value;
+
+		if (!fri)
+			return -1;
+
+		bpf_printk("rename(%x) from %s", flags, oldname);
+		bpf_printk("rename to %s", newname);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_UNLINK | FUSE_PREFILTER: {
+		const char *name = (void *)(long)fa->in_args[0].value;
+
+		bpf_printk("unlink: %s", name);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_LINK | FUSE_PREFILTER: {
+		const struct fuse_link_in *fli = fa_verify_in(fa, 0, sizeof(*fli));
+		const char *dst_name = (void *)(long) fa->in_args[1].value;
+
+		if (!fli)
+			return -1;
+
+		bpf_printk("Link: %d %s", fli->oldnodeid, dst_name);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_SYMLINK | FUSE_PREFILTER: {
+		const char *link_name = (void *)(long) fa->in_args[0].value;
+		const char *link_dest = (void *)(long) fa->in_args[1].value;
+
+		bpf_printk("symlink from %s", link_name);
+		bpf_printk("symlink to %s", link_dest);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_READLINK | FUSE_PREFILTER: {
+		const char *link_name = (void *)(long) fa->in_args[0].value;
+
+		bpf_printk("readlink from %s", link_name);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_RELEASE | FUSE_PREFILTER: {
+		const struct fuse_release_in *fri = fa_verify_in(fa, 0, sizeof(*fri));
+
+		if (!fri)
+			return -1;
+
+		bpf_printk("Release: %d", fri->fh);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_RELEASEDIR | FUSE_PREFILTER: {
+		const struct fuse_release_in *fri = fa_verify_in(fa, 0, sizeof(*fri));
+
+		if (!fri)
+			return -1;
+
+		bpf_printk("Release Dir: %d", fri->fh);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_CREATE | FUSE_PREFILTER: {
+		bpf_printk("Create %s", fa->in_args[1].value);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_OPEN | FUSE_PREFILTER: {
+		bpf_printk("Open: %d", fa->nodeid);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_READ | FUSE_PREFILTER: {
+		const struct fuse_read_in *fri = fa_verify_in(fa, 0, sizeof(*fri));
+
+		if (!fri)
+			return -1;
+
+		bpf_printk("Read: fh: %lu, offset %lu, size %lu",
+			   fri->fh, fri->offset, fri->size);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_WRITE | FUSE_PREFILTER: {
+		const struct fuse_write_in *fwi = fa_verify_in(fa, 0, sizeof(*fwi));
+
+		if (!fwi)
+			return -1;
+
+		bpf_printk("Write: fh: %lu, offset %lu, size %lu",
+			   fwi->fh, fwi->offset, fwi->size);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_FLUSH | FUSE_PREFILTER: {
+		const struct fuse_flush_in *ffi = fa_verify_in(fa, 0, sizeof(*ffi));
+
+		if (!ffi)
+			return -1;
+
+		bpf_printk("Flush %d", ffi->fh);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_FALLOCATE | FUSE_PREFILTER: {
+		const struct fuse_fallocate_in *ffa = fa_verify_in(fa, 0, sizeof(*ffa));
+
+		if (!ffa)
+			return -1;
+
+		bpf_printk("Fallocate %d %lu", ffa->fh, ffa->length);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_GETXATTR | FUSE_PREFILTER: {
+		const char *name = (void *)(long)fa->in_args[1].value;
+
+		bpf_printk("Getxattr %d %s", fa->nodeid, name);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_LISTXATTR | FUSE_PREFILTER: {
+		const char *name = (void *)(long)fa->in_args[1].value;
+
+		bpf_printk("Listxattr %d %s", fa->nodeid, name);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_SETXATTR | FUSE_PREFILTER: {
+		const char *name = (void *)(long)fa->in_args[1].value;
+
+		bpf_printk("Setxattr %d %s", fa->nodeid, name);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_STATFS | FUSE_PREFILTER: {
+		bpf_printk("statfs %d", fa->nodeid);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_LSEEK | FUSE_PREFILTER: {
+		const struct fuse_lseek_in *fli = fa_verify_in(fa, 0, sizeof(*fli));
+
+		if (!fli)
+			return -1;
+
+		bpf_printk("lseek type:%d, offset:%lld", fli->whence, fli->offset);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	default:
+		if (fa->opcode & FUSE_PREFILTER)
+			bpf_printk("prefilter *** UNKNOWN *** opcode: %d",
+				   fa->opcode & FUSE_OPCODE_FILTER);
+		else if (fa->opcode & FUSE_POSTFILTER)
+			bpf_printk("postfilter *** UNKNOWN *** opcode: %d",
+				   fa->opcode & FUSE_OPCODE_FILTER);
+		else
+			bpf_printk("*** UNKNOWN *** opcode: %d", fa->opcode);
+		return BPF_FUSE_CONTINUE;
+	}
+}
diff --git a/tools/testing/selftests/filesystems/fuse/fuse_daemon.c b/tools/testing/selftests/filesystems/fuse/fuse_daemon.c
new file mode 100644
index 000000000000..c3c1206b8f35
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/fuse_daemon.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 Google LLC
+ */
+
+#include "test_fuse.h"
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+
+#include <linux/unistd.h>
+
+#include <uapi/linux/fuse.h>
+#include <uapi/linux/bpf.h>
+
+bool user_messages;
+bool kernel_messages;
+
+static int display_trace(void)
+{
+	int pid = -1;
+	int tp = -1;
+	char c;
+	ssize_t bytes_read;
+	static char line[256] = {0};
+
+	if (!kernel_messages)
+		return TEST_SUCCESS;
+
+	TEST(pid = fork(), pid != -1);
+	if (pid != 0)
+		return pid;
+
+	TESTEQUAL(tracing_on(), 0);
+	TEST(tp = s_open(s_path(tracing_folder(), s("trace_pipe")),
+			 O_RDONLY | O_CLOEXEC), tp != -1);
+	for (;;) {
+		TEST(bytes_read = read(tp, &c, sizeof(c)),
+		     bytes_read == 1);
+		if (c == '\n') {
+			printf("%s\n", line);
+			line[0] = 0;
+		} else
+			sprintf(line + strlen(line), "%c", c);
+	}
+out:
+	if (pid == 0) {
+		close(tp);
+		exit(TEST_FAILURE);
+	}
+	return pid;
+}
+
+static const char *fuse_opcode_to_string(int opcode)
+{
+	switch (opcode & FUSE_OPCODE_FILTER) {
+	case FUSE_LOOKUP:
+		return "FUSE_LOOKUP";
+	case FUSE_FORGET:
+		return "FUSE_FORGET";
+	case FUSE_GETATTR:
+		return "FUSE_GETATTR";
+	case FUSE_SETATTR:
+		return "FUSE_SETATTR";
+	case FUSE_READLINK:
+		return "FUSE_READLINK";
+	case FUSE_SYMLINK:
+		return "FUSE_SYMLINK";
+	case FUSE_MKNOD:
+		return "FUSE_MKNOD";
+	case FUSE_MKDIR:
+		return "FUSE_MKDIR";
+	case FUSE_UNLINK:
+		return "FUSE_UNLINK";
+	case FUSE_RMDIR:
+		return "FUSE_RMDIR";
+	case FUSE_RENAME:
+		return "FUSE_RENAME";
+	case FUSE_LINK:
+		return "FUSE_LINK";
+	case FUSE_OPEN:
+		return "FUSE_OPEN";
+	case FUSE_READ:
+		return "FUSE_READ";
+	case FUSE_WRITE:
+		return "FUSE_WRITE";
+	case FUSE_STATFS:
+		return "FUSE_STATFS";
+	case FUSE_RELEASE:
+		return "FUSE_RELEASE";
+	case FUSE_FSYNC:
+		return "FUSE_FSYNC";
+	case FUSE_SETXATTR:
+		return "FUSE_SETXATTR";
+	case FUSE_GETXATTR:
+		return "FUSE_GETXATTR";
+	case FUSE_LISTXATTR:
+		return "FUSE_LISTXATTR";
+	case FUSE_REMOVEXATTR:
+		return "FUSE_REMOVEXATTR";
+	case FUSE_FLUSH:
+		return "FUSE_FLUSH";
+	case FUSE_INIT:
+		return "FUSE_INIT";
+	case FUSE_OPENDIR:
+		return "FUSE_OPENDIR";
+	case FUSE_READDIR:
+		return "FUSE_READDIR";
+	case FUSE_RELEASEDIR:
+		return "FUSE_RELEASEDIR";
+	case FUSE_FSYNCDIR:
+		return "FUSE_FSYNCDIR";
+	case FUSE_GETLK:
+		return "FUSE_GETLK";
+	case FUSE_SETLK:
+		return "FUSE_SETLK";
+	case FUSE_SETLKW:
+		return "FUSE_SETLKW";
+	case FUSE_ACCESS:
+		return "FUSE_ACCESS";
+	case FUSE_CREATE:
+		return "FUSE_CREATE";
+	case FUSE_INTERRUPT:
+		return "FUSE_INTERRUPT";
+	case FUSE_BMAP:
+		return "FUSE_BMAP";
+	case FUSE_DESTROY:
+		return "FUSE_DESTROY";
+	case FUSE_IOCTL:
+		return "FUSE_IOCTL";
+	case FUSE_POLL:
+		return "FUSE_POLL";
+	case FUSE_NOTIFY_REPLY:
+		return "FUSE_NOTIFY_REPLY";
+	case FUSE_BATCH_FORGET:
+		return "FUSE_BATCH_FORGET";
+	case FUSE_FALLOCATE:
+		return "FUSE_FALLOCATE";
+	case FUSE_READDIRPLUS:
+		return "FUSE_READDIRPLUS";
+	case FUSE_RENAME2:
+		return "FUSE_RENAME2";
+	case FUSE_LSEEK:
+		return "FUSE_LSEEK";
+	case FUSE_COPY_FILE_RANGE:
+		return "FUSE_COPY_FILE_RANGE";
+	case FUSE_SETUPMAPPING:
+		return "FUSE_SETUPMAPPING";
+	case FUSE_REMOVEMAPPING:
+		return "FUSE_REMOVEMAPPING";
+	//case FUSE_SYNCFS:
+	//	return "FUSE_SYNCFS";
+	case CUSE_INIT:
+		return "CUSE_INIT";
+	case CUSE_INIT_BSWAP_RESERVED:
+		return "CUSE_INIT_BSWAP_RESERVED";
+	case FUSE_INIT_BSWAP_RESERVED:
+		return "FUSE_INIT_BSWAP_RESERVED";
+	}
+	return "?";
+}
+
+static int parse_options(int argc, char *const *argv)
+{
+	signed char c;
+
+	while ((c = getopt(argc, argv, "kuv")) != -1)
+		switch (c) {
+		case 'v':
+			test_options.verbose = true;
+			break;
+
+		case 'u':
+			user_messages = true;
+			break;
+
+		case 'k':
+			kernel_messages = true;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int result = TEST_FAILURE;
+	int trace_pid = -1;
+	char *mount_dir = NULL;
+	char *src_dir = NULL;
+	int bpf_fd = -1;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	struct map_relocation *map_relocations = NULL;
+	size_t map_count = 0;
+	int i;
+
+	if (geteuid() != 0)
+		ksft_print_msg("Not a root, might fail to mount.\n");
+	TESTEQUAL(parse_options(argc, argv), 0);
+
+	TEST(trace_pid = display_trace(), trace_pid != -1);
+
+	delete_dir_tree("fd-src", true);
+	TEST(src_dir = setup_mount_dir("fd-src"), src_dir);
+	delete_dir_tree("fd-dst", true);
+	TEST(mount_dir = setup_mount_dir("fd-dst"), mount_dir);
+
+	TESTEQUAL(install_elf_bpf("fd_bpf.bpf", "test_daemon", &bpf_fd,
+				  &map_relocations, &map_count), 0);
+
+	TEST(src_fd = open("fd-src", O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTSYSCALL(mkdirat(src_fd, "show", 0777));
+	TESTSYSCALL(mkdirat(src_fd, "hide", 0777));
+
+	for (i = 0; i < map_count; ++i)
+		if (!strcmp(map_relocations[i].name, "test_map")) {
+			uint32_t key = 23;
+			uint32_t value = 1234;
+			union bpf_attr attr = {
+				.map_fd = map_relocations[i].fd,
+				.key    = ptr_to_u64(&key),
+				.value  = ptr_to_u64(&value),
+				.flags  = BPF_ANY,
+			};
+			TESTSYSCALL(syscall(__NR_bpf, BPF_MAP_UPDATE_ELEM,
+					    &attr, sizeof(attr)));
+		}
+
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	if (fork())
+		return 0;
+
+	for (;;) {
+		uint8_t bytes_in[FUSE_MIN_READ_BUFFER];
+		uint8_t bytes_out[FUSE_MIN_READ_BUFFER] __attribute__((unused));
+		struct fuse_in_header *in_header =
+			(struct fuse_in_header *)bytes_in;
+		ssize_t res = read(fuse_dev, bytes_in, sizeof(bytes_in));
+
+		if (res == -1)
+			break;
+
+		switch (in_header->opcode) {
+		case FUSE_LOOKUP | FUSE_PREFILTER: {
+			char *name = (char *)(bytes_in + sizeof(*in_header));
+
+			if (user_messages)
+				printf("Lookup %s\n", name);
+			if (!strcmp(name, "hide"))
+				TESTFUSEOUTERROR(-ENOENT);
+			else
+				TESTFUSEOUTREAD(name, strlen(name) + 1);
+			break;
+		}
+		default:
+			if (user_messages) {
+				printf("opcode is %d (%s)\n", in_header->opcode,
+				       fuse_opcode_to_string(
+					       in_header->opcode));
+			}
+			break;
+		}
+	}
+
+	result = TEST_SUCCESS;
+
+out:
+	for (i = 0; i < map_count; ++i) {
+		free(map_relocations[i].name);
+		close(map_relocations[i].fd);
+	}
+	free(map_relocations);
+	umount2(mount_dir, MNT_FORCE);
+	delete_dir_tree(mount_dir, true);
+	free(mount_dir);
+	delete_dir_tree(src_dir, true);
+	free(src_dir);
+	if (trace_pid != -1)
+		kill(trace_pid, SIGKILL);
+	return result;
+}
diff --git a/tools/testing/selftests/filesystems/fuse/fuse_test.c b/tools/testing/selftests/filesystems/fuse/fuse_test.c
new file mode 100644
index 000000000000..40545ab29cbd
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/fuse_test.c
@@ -0,0 +1,2147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 Google LLC
+ */
+#define _GNU_SOURCE
+
+#include "test_fuse.h"
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/inotify.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+
+#include <linux/capability.h>
+#include <linux/random.h>
+
+#include <uapi/linux/fuse.h>
+#include <uapi/linux/bpf.h>
+
+static const char *ft_src = "ft-src";
+static const char *ft_dst = "ft-dst";
+
+static void fill_buffer(uint8_t *data, size_t len, int file, int block)
+{
+	int i;
+	int seed = 7919 * file + block;
+
+	for (i = 0; i < len; i++) {
+		seed = 1103515245 * seed + 12345;
+		data[i] = (uint8_t)(seed >> (i % 13));
+	}
+}
+
+static bool test_buffer(uint8_t *data, size_t len, int file, int block)
+{
+	int i;
+	int seed = 7919 * file + block;
+
+	for (i = 0; i < len; i++) {
+		seed = 1103515245 * seed + 12345;
+		if (data[i] != (uint8_t)(seed >> (i % 13)))
+			return false;
+	}
+
+	return true;
+}
+
+static int create_file(int dir, struct s name, int index, size_t blocks)
+{
+	int result = TEST_FAILURE;
+	int fd = -1;
+	int i;
+	uint8_t data[PAGE_SIZE];
+
+	TEST(fd = s_openat(dir, name, O_CREAT | O_WRONLY, 0777), fd != -1);
+	for (i = 0; i < blocks; ++i) {
+		fill_buffer(data, PAGE_SIZE, index, i);
+		TESTEQUAL(write(fd, data, sizeof(data)), PAGE_SIZE);
+	}
+	TESTSYSCALL(close(fd));
+	result = TEST_SUCCESS;
+
+out:
+	close(fd);
+	return result;
+}
+
+static int bpf_clear_trace(void)
+{
+	int result = TEST_FAILURE;
+	int tp = -1;
+
+	TEST(tp = s_open(s_path(tracing_folder(), s("trace")),
+			 O_WRONLY | O_TRUNC | O_CLOEXEC), tp != -1);
+
+	result = TEST_SUCCESS;
+out:
+	close(tp);
+	return result;
+}
+
+static int bpf_test_trace_maybe(const char *substr, bool present)
+{
+	int result = TEST_FAILURE;
+	int tp = -1;
+	char trace_buffer[4096] = {};
+	ssize_t bytes_read;
+
+	TEST(tp = s_open(s_path(tracing_folder(), s("trace_pipe")),
+			 O_RDONLY | O_CLOEXEC),
+	     tp != -1);
+	fcntl(tp, F_SETFL, O_NONBLOCK);
+
+	for (;;) {
+		bytes_read = read(tp, trace_buffer, sizeof(trace_buffer));
+		if (present)
+			TESTCOND(bytes_read > 0);
+		else if (bytes_read <= 0) {
+			result = TEST_SUCCESS;
+			break;
+		}
+
+		if (test_options.verbose)
+			ksft_print_msg("%s\n", trace_buffer);
+
+		if (strstr(trace_buffer, substr)) {
+			if (present)
+				result = TEST_SUCCESS;
+			break;
+		}
+	}
+out:
+	close(tp);
+	return result;
+}
+
+static int bpf_test_trace(const char *substr)
+{
+	return bpf_test_trace_maybe(substr, true);
+}
+
+static int bpf_test_no_trace(const char *substr)
+{
+	return bpf_test_trace_maybe(substr, false);
+}
+
+static int basic_test(const char *mount_dir)
+{
+	const char *test_name = "test";
+	const char *test_data = "data";
+
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	char *filename = NULL;
+	int fd = -1;
+	int pid = -1;
+	int status;
+
+	TESTEQUAL(mount_fuse(mount_dir, -1, -1, &fuse_dev), 0);
+	FUSE_ACTION
+		char data[256];
+
+		filename = concat_file_name(mount_dir, test_name);
+		TESTERR(fd = open(filename, O_RDONLY | O_CLOEXEC), fd != -1);
+		TESTEQUAL(read(fd, data, strlen(test_data)), strlen(test_data));
+		TESTCOND(!strcmp(data, test_data));
+		TESTSYSCALL(close(fd));
+		fd = -1;
+	FUSE_DAEMON
+		DECL_FUSE_IN(open);
+		DECL_FUSE_IN(read);
+		DECL_FUSE_IN(flush);
+		DECL_FUSE_IN(release);
+
+		TESTFUSELOOKUP(test_name, 0);
+		TESTFUSEOUT1(fuse_entry_out, ((struct fuse_entry_out) {
+			.nodeid		= 2,
+			.generation	= 1,
+			.attr.ino = 100,
+			.attr.size = 4,
+			.attr.blksize = 512,
+			.attr.mode = S_IFREG | 0777,
+			}));
+
+		TESTFUSEIN(FUSE_OPEN, open_in);
+		TESTFUSEOUT1(fuse_open_out, ((struct fuse_open_out) {
+			.fh = 1,
+			.open_flags = open_in->flags,
+		}));
+
+		TESTFUSEIN(FUSE_READ, read_in);
+		TESTFUSEOUTREAD(test_data, strlen(test_data));
+
+		TESTFUSEIN(FUSE_FLUSH, flush_in);
+		TESTFUSEOUTEMPTY();
+
+		TESTFUSEIN(FUSE_RELEASE, release_in);
+		TESTFUSEOUTEMPTY();
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	if (!pid)
+		exit(TEST_FAILURE);
+	close(fuse_dev);
+	close(fd);
+	free(filename);
+	umount(mount_dir);
+	return result;
+}
+
+static int bpf_test_real(const char *mount_dir)
+{
+	const char *test_name = "real";
+	const char *test_data = "Weebles wobble but they don't fall down";
+	int result = TEST_FAILURE;
+	int bpf_fd = -1;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	char *filename = NULL;
+	int fd = -1;
+	char read_buffer[256] = {};
+	ssize_t bytes_read;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(fd = openat(src_fd, test_name, O_CREAT | O_RDWR | O_CLOEXEC, 0777),
+	     fd != -1);
+	TESTEQUAL(write(fd, test_data, strlen(test_data)), strlen(test_data));
+	TESTSYSCALL(close(fd));
+	fd = -1;
+
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_trace",
+				  &bpf_fd, NULL, NULL), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	filename = concat_file_name(mount_dir, test_name);
+	TESTERR(fd = open(filename, O_RDONLY | O_CLOEXEC), fd != -1);
+	bytes_read = read(fd, read_buffer, strlen(test_data));
+	TESTEQUAL(bytes_read, strlen(test_data));
+	TESTEQUAL(strcmp(test_data, read_buffer), 0);
+	TESTEQUAL(bpf_test_trace("read"), 0);
+
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	close(fd);
+	free(filename);
+	umount(mount_dir);
+	close(src_fd);
+	close(bpf_fd);
+	return result;
+}
+
+
+static int bpf_test_partial(const char *mount_dir)
+{
+	const char *test_name = "partial";
+	int result = TEST_FAILURE;
+	int bpf_fd = -1;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	char *filename = NULL;
+	int fd = -1;
+	int pid = -1;
+	int status;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(create_file(src_fd, s(test_name), 1, 2), 0);
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_trace",
+				  &bpf_fd, NULL, NULL), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	FUSE_ACTION
+		uint8_t data[PAGE_SIZE];
+
+		TEST(filename = concat_file_name(mount_dir, test_name),
+		     filename);
+		TESTERR(fd = open(filename, O_RDONLY | O_CLOEXEC), fd != -1);
+		TESTEQUAL(read(fd, data, PAGE_SIZE), PAGE_SIZE);
+		TESTEQUAL(bpf_test_trace("read"), 0);
+		TESTCOND(test_buffer(data, PAGE_SIZE, 2, 0));
+		TESTCOND(!test_buffer(data, PAGE_SIZE, 1, 0));
+		TESTEQUAL(read(fd, data, PAGE_SIZE), PAGE_SIZE);
+		TESTCOND(test_buffer(data, PAGE_SIZE, 1, 1));
+		TESTCOND(!test_buffer(data, PAGE_SIZE, 2, 1));
+		TESTSYSCALL(close(fd));
+		fd = -1;
+	FUSE_DAEMON
+		DECL_FUSE(open);
+		DECL_FUSE(read);
+		DECL_FUSE(release);
+		uint8_t data[PAGE_SIZE];
+
+		TESTFUSEIN2(FUSE_OPEN | FUSE_POSTFILTER, open_in, open_out);
+		TESTFUSEOUT1(fuse_open_out, ((struct fuse_open_out) {
+			.fh = 1,
+			.open_flags = open_in->flags,
+		}));
+
+		TESTFUSEIN(FUSE_READ, read_in);
+		fill_buffer(data, PAGE_SIZE, 2, 0);
+		TESTFUSEOUTREAD(data, PAGE_SIZE);
+
+		TESTFUSEIN(FUSE_RELEASE, release_in);
+		TESTFUSEOUTEMPTY();
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	if (!pid)
+		exit(TEST_FAILURE);
+	close(fuse_dev);
+	close(fd);
+	free(filename);
+	umount(mount_dir);
+	close(src_fd);
+	close(bpf_fd);
+	return result;
+}
+
+static int bpf_test_attrs(const char *mount_dir)
+{
+	const char *test_name = "partial";
+	int result = TEST_FAILURE;
+	int bpf_fd = -1;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	char *filename = NULL;
+	struct stat st;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(create_file(src_fd, s(test_name), 1, 2), 0);
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_trace",
+				  &bpf_fd, NULL, NULL), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	TEST(filename = concat_file_name(mount_dir, test_name), filename);
+	TESTSYSCALL(stat(filename, &st));
+	TESTSYSCALL(chmod(filename, 0111));
+	TESTSYSCALL(stat(filename, &st));
+	TESTEQUAL(st.st_mode & 0777, 0111);
+	TESTSYSCALL(chmod(filename, 0777));
+	TESTSYSCALL(stat(filename, &st));
+	TESTEQUAL(st.st_mode & 0777, 0777);
+	TESTSYSCALL(chown(filename, 5, 6));
+	TESTSYSCALL(stat(filename, &st));
+	TESTEQUAL(st.st_uid, 5);
+	TESTEQUAL(st.st_gid, 6);
+
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	free(filename);
+	umount(mount_dir);
+	close(src_fd);
+	close(bpf_fd);
+	return result;
+}
+
+static int bpf_test_readdir(const char *mount_dir)
+{
+	const char *names[] = {"real", "partial", "fake", ".", ".."};
+	int result = TEST_FAILURE;
+	int bpf_fd = -1;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	int pid = -1;
+	int status;
+	DIR *dir = NULL;
+	struct dirent *dirent;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(create_file(src_fd, s(names[0]), 1, 2), 0);
+	TESTEQUAL(create_file(src_fd, s(names[1]), 1, 2), 0);
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_trace",
+				  &bpf_fd, NULL, NULL), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	FUSE_ACTION
+		int i, j;
+
+		TEST(dir = s_opendir(s(mount_dir)), dir);
+		TESTEQUAL(bpf_test_trace("opendir"), 0);
+
+		for (i = 0; i < ARRAY_SIZE(names); ++i) {
+			TEST(dirent = readdir(dir), dirent);
+
+			for (j = 0; j < ARRAY_SIZE(names); ++j)
+				if (names[j] &&
+				    strcmp(names[j], dirent->d_name) == 0) {
+					names[j] = NULL;
+					break;
+				}
+			TESTNE(j, ARRAY_SIZE(names));
+		}
+		TEST(dirent = readdir(dir), dirent == NULL);
+		TESTSYSCALL(closedir(dir));
+		dir = NULL;
+		TESTEQUAL(bpf_test_trace("readdir"), 0);
+	FUSE_DAEMON
+		struct fuse_in_header *in_header =
+			(struct fuse_in_header *)bytes_in;
+		ssize_t res = read(fuse_dev, bytes_in, sizeof(bytes_in));
+		struct fuse_read_out *read_out =
+			(struct fuse_read_out *) (bytes_in +
+					sizeof(*in_header) +
+					sizeof(struct fuse_read_in));
+		struct fuse_dirent *fuse_dirent =
+			(struct fuse_dirent *) (bytes_in + res);
+
+		TESTGE(res, sizeof(*in_header) + sizeof(struct fuse_read_in));
+		TESTEQUAL(in_header->opcode, FUSE_READDIR | FUSE_POSTFILTER);
+		*fuse_dirent = (struct fuse_dirent) {
+			.ino = 100,
+			.off = 5,
+			.namelen = strlen("fake"),
+			.type = DT_REG,
+		};
+		strcpy((char *)(bytes_in + res + sizeof(*fuse_dirent)), "fake");
+		res += FUSE_DIRENT_ALIGN(sizeof(*fuse_dirent) + strlen("fake") +
+					 1);
+		TESTFUSEDIROUTREAD(read_out,
+				bytes_in +
+				   sizeof(struct fuse_in_header) +
+				   sizeof(struct fuse_read_in) +
+				   sizeof(struct fuse_read_out),
+				res - sizeof(struct fuse_in_header) -
+				    sizeof(struct fuse_read_in) -
+				    sizeof(struct fuse_read_out));
+		res = read(fuse_dev, bytes_in, sizeof(bytes_in));
+		TESTEQUAL(res, sizeof(*in_header) +
+			  sizeof(struct fuse_read_in) +
+			  sizeof(struct fuse_read_out));
+		TESTEQUAL(in_header->opcode, FUSE_READDIR | FUSE_POSTFILTER);
+		TESTFUSEDIROUTREAD(read_out, bytes_in, 0);
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	closedir(dir);
+	close(fuse_dev);
+	umount(mount_dir);
+	close(src_fd);
+	close(bpf_fd);
+	return result;
+}
+
+static int bpf_test_redact_readdir(const char *mount_dir)
+{
+	const char *names[] = {"f1", "f2", "f3", "f4", "f5", "f6", ".", ".."};
+	int num_shown = (ARRAY_SIZE(names) - 2) / 2 + 2;
+	int result = TEST_FAILURE;
+	int bpf_fd = -1;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	int pid = -1;
+	int status;
+	DIR *dir = NULL;
+	struct dirent *dirent;
+	int i;
+	int count = 0;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	for (i = 0; i < ARRAY_SIZE(names) - 2; i++)
+		TESTEQUAL(create_file(src_fd, s(names[i]), 1, 2), 0);
+
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_readdir_redact",
+				  &bpf_fd, NULL, NULL), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	FUSE_ACTION
+		int j;
+
+		TEST(dir = s_opendir(s(mount_dir)), dir);
+		while ((dirent = readdir(dir))) {
+			errno = 0;
+			TESTEQUAL(errno, 0);
+
+			for (j = 0; j < ARRAY_SIZE(names); ++j)
+				if (names[j] &&
+				    strcmp(names[j], dirent->d_name) == 0) {
+					names[j] = NULL;
+					count++;
+					break;
+				}
+			TESTNE(j, ARRAY_SIZE(names));
+			TESTGE(num_shown, count);
+		}
+		TESTEQUAL(count, num_shown);
+		TESTSYSCALL(closedir(dir));
+		dir = NULL;
+	FUSE_DAEMON
+		bool skip = true;
+		for (int i = 0; i < ARRAY_SIZE(names) + 1; i++) {
+			uint8_t bytes_in[FUSE_MIN_READ_BUFFER];
+			uint8_t bytes_out[FUSE_MIN_READ_BUFFER];
+			struct fuse_in_header *in_header =
+				(struct fuse_in_header *)bytes_in;
+			ssize_t res = read(fuse_dev, bytes_in, sizeof(bytes_in));
+			int length_out = 0;
+			uint8_t *pos;
+			uint8_t *dirs_in;
+			uint8_t *dirs_out;
+			struct fuse_read_in *fuse_read_in;
+			struct fuse_read_out *fuse_read_out_in;
+			struct fuse_read_out *fuse_read_out_out;
+			struct fuse_dirent *fuse_dirent_in = NULL;
+			struct fuse_dirent *next = NULL;
+			bool again = false;
+			int dir_ent_len = 0;
+
+			TESTGE(res, sizeof(struct fuse_in_header) +
+					sizeof(struct fuse_read_in) +
+					sizeof(struct fuse_read_out));
+
+			pos = bytes_in + sizeof(struct fuse_in_header);
+			fuse_read_in = (struct fuse_read_in *) pos;
+			pos += sizeof(*fuse_read_in);
+			fuse_read_out_in = (struct fuse_read_out *) pos;
+			pos += sizeof(*fuse_read_out_in);
+			dirs_in = pos;
+
+			pos = bytes_out + sizeof(struct fuse_out_header);
+			fuse_read_out_out = (struct fuse_read_out *) pos;
+			pos += sizeof(*fuse_read_out_out);
+			dirs_out = pos;
+
+			if (dirs_in < bytes_in + res) {
+				bool is_dot;
+
+				fuse_dirent_in = (struct fuse_dirent *) dirs_in;
+				is_dot = (fuse_dirent_in->namelen == 1 &&
+						!strncmp(fuse_dirent_in->name, ".", 1)) ||
+					 (fuse_dirent_in->namelen == 2 &&
+						!strncmp(fuse_dirent_in->name, "..", 2));
+
+				dir_ent_len = FUSE_DIRENT_ALIGN(
+					sizeof(*fuse_dirent_in) +
+					fuse_dirent_in->namelen);
+
+				if (dirs_in + dir_ent_len < bytes_in + res)
+					next = (struct fuse_dirent *)
+							(dirs_in + dir_ent_len);
+
+				if (!skip || is_dot) {
+					memcpy(dirs_out, fuse_dirent_in,
+					       sizeof(struct fuse_dirent) +
+					       fuse_dirent_in->namelen);
+					length_out += dir_ent_len;
+				}
+				again = ((skip && !is_dot) && next);
+
+				if (!is_dot)
+					skip = !skip;
+			}
+
+			fuse_read_out_out->offset = next ? next->off :
+					fuse_read_out_in->offset;
+			fuse_read_out_out->again = again;
+
+			{
+			struct fuse_out_header *out_header =
+				(struct fuse_out_header *)bytes_out;
+
+			*out_header = (struct fuse_out_header) {
+				.len = sizeof(*out_header) +
+				       sizeof(*fuse_read_out_out) + length_out,
+				.unique = in_header->unique,
+			};
+			TESTEQUAL(write(fuse_dev, bytes_out, out_header->len),
+				  out_header->len);
+			}
+		}
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	closedir(dir);
+	close(fuse_dev);
+	umount(mount_dir);
+	close(src_fd);
+	close(bpf_fd);
+	return result;
+}
+
+/*
+ * This test is more to show what classic fuse does with a creat in a subdir
+ * than a test of any new functionality
+ */
+static int bpf_test_creat(const char *mount_dir)
+{
+	const char *dir_name = "show";
+	const char *file_name = "file";
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	int pid = -1;
+	int status;
+	int fd = -1;
+
+	TESTEQUAL(mount_fuse(mount_dir, -1, -1, &fuse_dev), 0);
+
+	FUSE_ACTION
+		TEST(fd = s_creat(s_path(s_path(s(mount_dir), s(dir_name)),
+					 s(file_name)),
+				  0777),
+		     fd != -1);
+		TESTSYSCALL(close(fd));
+	FUSE_DAEMON
+		DECL_FUSE_IN(create);
+		DECL_FUSE_IN(release);
+		DECL_FUSE_IN(flush);
+
+		TESTFUSELOOKUP(dir_name, 0);
+		TESTFUSEOUT1(fuse_entry_out, ((struct fuse_entry_out) {
+			.nodeid		= 3,
+			.generation	= 1,
+			.attr.ino = 100,
+			.attr.size = 4,
+			.attr.blksize = 512,
+			.attr.mode = S_IFDIR | 0777,
+			}));
+
+		TESTFUSELOOKUP(file_name, 0);
+		TESTFUSEOUTERROR(-ENOENT);
+
+		TESTFUSEINEXT(FUSE_CREATE, create_in, strlen(file_name) + 1);
+		TESTFUSEOUT2(fuse_entry_out, ((struct fuse_entry_out) {
+			.nodeid		= 2,
+			.generation	= 1,
+			.attr.ino = 200,
+			.attr.size = 4,
+			.attr.blksize = 512,
+			.attr.mode = S_IFREG,
+			}),
+			fuse_open_out, ((struct fuse_open_out) {
+			.fh = 1,
+			.open_flags = create_in->flags,
+			}));
+
+		TESTFUSEIN(FUSE_FLUSH, flush_in);
+		TESTFUSEOUTEMPTY();
+
+		TESTFUSEIN(FUSE_RELEASE, release_in);
+		TESTFUSEOUTEMPTY();
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	return result;
+}
+
+static int bpf_test_hidden_entries(const char *mount_dir)
+{
+	static const char * const dir_names[] = {
+		"show",
+		"hide",
+	};
+	const char *file_name = "file";
+	const char *data = "The quick brown fox jumps over the lazy dog\n";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	int fd = -1;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTSYSCALL(mkdirat(src_fd, dir_names[0], 0777));
+	TESTSYSCALL(mkdirat(src_fd, dir_names[1], 0777));
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_hidden",
+				  &bpf_fd, NULL, NULL), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	TEST(fd = s_creat(s_path(s_path(s(mount_dir), s(dir_names[0])),
+				 s(file_name)),
+			  0777),
+	     fd != -1);
+	TESTSYSCALL(fallocate(fd, 0, 0, 4096));
+	TEST(write(fd, data, strlen(data)), strlen(data));
+	TESTSYSCALL(close(fd));
+	TESTEQUAL(bpf_test_trace("Create"), 0);
+
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	close(bpf_fd);
+	close(src_fd);
+	return result;
+}
+
+static int bpf_test_dir(const char *mount_dir)
+{
+	const char *dir_name = "dir";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	struct stat st;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_trace",
+				  &bpf_fd, NULL, NULL), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	TESTSYSCALL(s_mkdir(s_path(s(mount_dir), s(dir_name)), 0777));
+	TESTEQUAL(bpf_test_trace("mkdir"), 0);
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(dir_name)), &st));
+	TESTSYSCALL(s_rmdir(s_path(s(mount_dir), s(dir_name))));
+	TESTEQUAL(s_stat(s_path(s(ft_src), s(dir_name)), &st), -1);
+	TESTEQUAL(errno, ENOENT);
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	close(bpf_fd);
+	close(src_fd);
+	return result;
+}
+
+static int bpf_test_file(const char *mount_dir, bool close_first)
+{
+	const char *file_name = "real";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	int fd = -1;
+	struct stat st;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_trace",
+			  &bpf_fd, NULL, NULL), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	TEST(fd = s_creat(s_path(s(mount_dir), s(file_name)),
+			  0777),
+	     fd != -1);
+	TESTEQUAL(bpf_test_trace("Create"), 0);
+	if (close_first) {
+		TESTSYSCALL(close(fd));
+		fd = -1;
+	}
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(file_name)), &st));
+	TESTSYSCALL(s_unlink(s_path(s(mount_dir), s(file_name))));
+	TESTEQUAL(bpf_test_trace("unlink"), 0);
+	TESTEQUAL(s_stat(s_path(s(ft_src), s(file_name)), &st), -1);
+	TESTEQUAL(errno, ENOENT);
+	if (!close_first) {
+		TESTSYSCALL(close(fd));
+		fd = -1;
+	}
+	result = TEST_SUCCESS;
+out:
+	close(fd);
+	close(fuse_dev);
+	umount(mount_dir);
+	close(bpf_fd);
+	close(src_fd);
+	return result;
+}
+
+static int bpf_test_file_early_close(const char *mount_dir)
+{
+	return bpf_test_file(mount_dir, true);
+}
+
+static int bpf_test_file_late_close(const char *mount_dir)
+{
+	return bpf_test_file(mount_dir, false);
+}
+
+static int bpf_test_alter_errcode_bpf(const char *mount_dir)
+{
+	const char *dir_name = "dir";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	struct stat st;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_error",
+				  &bpf_fd, NULL, NULL), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	TESTSYSCALL(s_mkdir(s_path(s(mount_dir), s(dir_name)), 0777));
+	//TESTEQUAL(bpf_test_trace("mkdir"), 0);
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(dir_name)), &st));
+	TESTEQUAL(s_mkdir(s_path(s(mount_dir), s(dir_name)), 0777), -EPERM);
+	TESTSYSCALL(s_rmdir(s_path(s(mount_dir), s(dir_name))));
+	TESTEQUAL(s_stat(s_path(s(ft_src), s(dir_name)), &st), -1);
+	TESTEQUAL(errno, ENOENT);
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	close(bpf_fd);
+	close(src_fd);
+	return result;
+}
+
+static int bpf_test_alter_errcode_userspace(const char *mount_dir)
+{
+	const char *dir_name = "doesnotexist";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	int pid = -1;
+	int status;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_error",
+				  &bpf_fd, NULL, NULL), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	FUSE_ACTION
+		TESTEQUAL(s_unlink(s_path(s(mount_dir), s(dir_name))),
+		     -1);
+		TESTEQUAL(errno, ENOMEM);
+	FUSE_DAEMON
+		TESTFUSELOOKUP("doesnotexist", FUSE_POSTFILTER);
+		TESTFUSEOUTERROR(-ENOMEM);
+	FUSE_DONE
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	close(bpf_fd);
+	close(src_fd);
+	return result;
+}
+
+static int bpf_test_verifier(const char *mount_dir)
+{
+	int result = TEST_FAILURE;
+	int bpf_fd1 = -1;
+	int bpf_fd2 = -1;
+	int bpf_fd3 = -1;
+
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_verify",
+				  &bpf_fd1, NULL, NULL), 0);
+	TESTEQUAL(install_elf_bpf_invalid("test_bpf.bpf", "test_verify_fail",
+				  &bpf_fd2, NULL, NULL), 0);
+	TESTEQUAL(install_elf_bpf_invalid("test_bpf.bpf", "test_verify_fail2",
+				  &bpf_fd3, NULL, NULL), 0);
+	result = TEST_SUCCESS;
+out:
+	close(bpf_fd1);
+	close(bpf_fd2);
+	close(bpf_fd3);
+	return result;
+}
+
+static int bpf_test_verifier_out_args(const char *mount_dir)
+{
+	int result = TEST_FAILURE;
+	int bpf_fd1 = -1;
+	int bpf_fd2 = -1;
+
+	TESTEQUAL(install_elf_bpf_invalid("test_bpf.bpf", "test_verify_fail3",
+				  &bpf_fd1, NULL, NULL), 0);
+	TESTEQUAL(install_elf_bpf_invalid("test_bpf.bpf", "test_verify_fail4",
+				  &bpf_fd2, NULL, NULL), 0);
+	result = TEST_SUCCESS;
+out:
+	close(bpf_fd1);
+	close(bpf_fd2);
+	return result;
+}
+
+static int bpf_test_verifier_packet_invalidation(const char *mount_dir)
+{
+	int result = TEST_FAILURE;
+	int bpf_fd1 = -1;
+	int bpf_fd2 = -1;
+
+	TESTEQUAL(install_elf_bpf_invalid("test_bpf.bpf", "test_verify_fail5",
+				  &bpf_fd1, NULL, NULL), 0);
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_verify5",
+				  &bpf_fd2, NULL, NULL), 0);
+	result = TEST_SUCCESS;
+out:
+	close(bpf_fd1);
+	close(bpf_fd2);
+	return result;
+}
+
+static int bpf_test_verifier_nonsense_read(const char *mount_dir)
+{
+	int result = TEST_FAILURE;
+	int bpf_fd1 = -1;
+
+	TESTEQUAL(install_elf_bpf_invalid("test_bpf.bpf", "test_verify_fail6",
+				  &bpf_fd1, NULL, NULL), 0);
+	result = TEST_SUCCESS;
+out:
+	close(bpf_fd1);
+	return result;
+}
+
+
+static int bpf_test_mknod(const char *mount_dir)
+{
+	const char *file_name = "real";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	struct stat st;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_trace",
+				  &bpf_fd, NULL, NULL), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	TESTSYSCALL(s_mkfifo(s_path(s(mount_dir), s(file_name)), 0777));
+	TESTEQUAL(bpf_test_trace("mknod"), 0);
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(file_name)), &st));
+	TESTSYSCALL(s_unlink(s_path(s(mount_dir), s(file_name))));
+	TESTEQUAL(bpf_test_trace("unlink"), 0);
+	TESTEQUAL(s_stat(s_path(s(ft_src), s(file_name)), &st), -1);
+	TESTEQUAL(errno, ENOENT);
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	close(bpf_fd);
+	close(src_fd);
+	return result;
+}
+
+static int bpf_test_largedir(const char *mount_dir)
+{
+	const char *show = "show";
+	const int files = 1000;
+
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	struct map_relocation *map_relocations = NULL;
+	size_t map_count = 0;
+	int pid = -1;
+	int status;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(install_elf_bpf("fd_bpf.bpf", "test_daemon",
+			  &bpf_fd, &map_relocations, &map_count), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	FUSE_ACTION
+		int i;
+		int fd;
+		DIR *dir = NULL;
+		struct dirent *dirent;
+
+		TESTSYSCALL(s_mkdir(s_path(s(mount_dir), s(show)), 0777));
+		for (i = 0; i < files; ++i) {
+			char filename[NAME_MAX];
+
+			sprintf(filename, "%d", i);
+			TEST(fd = s_creat(s_path(s_path(s(mount_dir), s(show)),
+						 s(filename)), 0777), fd != -1);
+			TESTSYSCALL(close(fd));
+		}
+
+		TEST(dir = s_opendir(s_path(s(mount_dir), s(show))), dir);
+		for (dirent = readdir(dir); dirent; dirent = readdir(dir))
+			;
+		closedir(dir);
+	FUSE_DAEMON
+		int i;
+
+		for (i = 0; i < files + 2; ++i) {
+			TESTFUSELOOKUP(show, FUSE_PREFILTER);
+			TESTFUSEOUTREAD(show, 5);
+		}
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	close(bpf_fd);
+	close(src_fd);
+	return result;
+}
+
+static int bpf_test_link(const char *mount_dir)
+{
+	const char *file_name = "real";
+	const char *link_name = "partial";
+	int result = TEST_FAILURE;
+	int fd = -1;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	struct stat st;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_trace", &bpf_fd, NULL,
+				  NULL),
+		  0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	TEST(fd = s_creat(s_path(s(mount_dir), s(file_name)), 0777), fd != -1);
+	TESTEQUAL(bpf_test_trace("Create"), 0);
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(file_name)), &st));
+
+	TESTSYSCALL(s_link(s_path(s(mount_dir), s(file_name)),
+			   s_path(s(mount_dir), s(link_name))));
+
+	TESTEQUAL(bpf_test_trace("link"), 0);
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(link_name)), &st));
+
+	TESTSYSCALL(s_unlink(s_path(s(mount_dir), s(link_name))));
+	TESTEQUAL(bpf_test_trace("unlink"), 0);
+	TESTEQUAL(s_stat(s_path(s(ft_src), s(link_name)), &st), -1);
+	TESTEQUAL(errno, ENOENT);
+
+	TESTSYSCALL(s_unlink(s_path(s(mount_dir), s(file_name))));
+	TESTEQUAL(bpf_test_trace("unlink"), 0);
+	TESTEQUAL(s_stat(s_path(s(ft_src), s(file_name)), &st), -1);
+	TESTEQUAL(errno, ENOENT);
+
+	result = TEST_SUCCESS;
+out:
+	close(fd);
+	close(fuse_dev);
+	umount(mount_dir);
+	close(bpf_fd);
+	close(src_fd);
+	return result;
+}
+
+static int bpf_test_symlink(const char *mount_dir)
+{
+	const char *test_name = "real";
+	const char *symlink_name = "partial";
+	const char *test_data = "Weebles wobble but they don't fall down";
+	int result = TEST_FAILURE;
+	int bpf_fd = -1;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	int fd = -1;
+	char read_buffer[256] = {};
+	ssize_t bytes_read;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(fd = openat(src_fd, test_name, O_CREAT | O_RDWR | O_CLOEXEC, 0777),
+	     fd != -1);
+	TESTEQUAL(write(fd, test_data, strlen(test_data)), strlen(test_data));
+	TESTSYSCALL(close(fd));
+	fd = -1;
+
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_trace",
+				  &bpf_fd, NULL, NULL), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	TESTSYSCALL(s_symlink(s_path(s(mount_dir), s(test_name)),
+				   s_path(s(mount_dir), s(symlink_name))));
+	TESTEQUAL(bpf_test_trace("symlink"), 0);
+
+	TESTERR(fd = s_open(s_path(s(mount_dir), s(symlink_name)), O_RDONLY | O_CLOEXEC), fd != -1);
+	bytes_read = read(fd, read_buffer, strlen(test_data));
+	TESTEQUAL(bpf_test_trace("readlink"), 0);
+	TESTEQUAL(bytes_read, strlen(test_data));
+	TESTEQUAL(strcmp(test_data, read_buffer), 0);
+
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	close(fd);
+	umount(mount_dir);
+	close(src_fd);
+	close(bpf_fd);
+	return result;
+}
+
+static int bpf_test_xattr(const char *mount_dir)
+{
+	static const char file_name[] = "real";
+	static const char xattr_name[] = "user.xattr_test_name";
+	static const char xattr_value[] = "this_is_a_test";
+	const size_t xattr_size = sizeof(xattr_value);
+	char xattr_value_ret[256];
+	ssize_t xattr_size_ret;
+	int result = TEST_FAILURE;
+	int fd = -1;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	struct stat st;
+
+	memset(xattr_value_ret, '\0', sizeof(xattr_value_ret));
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_trace", &bpf_fd, NULL,
+				  NULL),
+		  0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	TEST(fd = s_creat(s_path(s(mount_dir), s(file_name)), 0777), fd != -1);
+	TESTEQUAL(bpf_test_trace("Create"), 0);
+	TESTSYSCALL(close(fd));
+
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(file_name)), &st));
+	TEST(result = s_getxattr(s_path(s(mount_dir), s(file_name)), xattr_name,
+				 xattr_value_ret, sizeof(xattr_value_ret),
+				 &xattr_size_ret),
+	     result == -1);
+	TESTEQUAL(errno, ENODATA);
+	TESTEQUAL(bpf_test_trace("getxattr"), 0);
+
+	TESTSYSCALL(s_listxattr(s_path(s(mount_dir), s(file_name)),
+				xattr_value_ret, sizeof(xattr_value_ret),
+				&xattr_size_ret));
+	TESTEQUAL(bpf_test_trace("listxattr"), 0);
+	TESTEQUAL(xattr_size_ret, 0);
+
+	TESTSYSCALL(s_setxattr(s_path(s(mount_dir), s(file_name)), xattr_name,
+			       xattr_value, xattr_size, 0));
+	TESTEQUAL(bpf_test_trace("setxattr"), 0);
+
+	TESTSYSCALL(s_listxattr(s_path(s(mount_dir), s(file_name)),
+				xattr_value_ret, sizeof(xattr_value_ret),
+				&xattr_size_ret));
+	TESTEQUAL(bpf_test_trace("listxattr"), 0);
+	TESTEQUAL(xattr_size_ret, sizeof(xattr_name));
+	TESTEQUAL(strcmp(xattr_name, xattr_value_ret), 0);
+
+	TESTSYSCALL(s_getxattr(s_path(s(mount_dir), s(file_name)), xattr_name,
+			       xattr_value_ret, sizeof(xattr_value_ret),
+			       &xattr_size_ret));
+	TESTEQUAL(bpf_test_trace("getxattr"), 0);
+	TESTEQUAL(xattr_size, xattr_size_ret);
+	TESTEQUAL(strcmp(xattr_value, xattr_value_ret), 0);
+
+	TESTSYSCALL(s_removexattr(s_path(s(mount_dir), s(file_name)), xattr_name));
+	TESTEQUAL(bpf_test_trace("removexattr"), 0);
+
+	TESTEQUAL(s_getxattr(s_path(s(mount_dir), s(file_name)), xattr_name,
+			       xattr_value_ret, sizeof(xattr_value_ret),
+			       &xattr_size_ret), -1);
+	TESTEQUAL(errno, ENODATA);
+
+	TESTSYSCALL(s_unlink(s_path(s(mount_dir), s(file_name))));
+	TESTEQUAL(bpf_test_trace("unlink"), 0);
+	TESTEQUAL(s_stat(s_path(s(ft_src), s(file_name)), &st), -1);
+	TESTEQUAL(errno, ENOENT);
+
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	close(bpf_fd);
+	close(src_fd);
+	return result;
+}
+
+static int bpf_test_set_backing(const char *mount_dir)
+{
+	const char *backing_name = "backing";
+	const char *test_data = "data";
+	const char *test_name = "test";
+
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	int fd = -1;
+	int pid = -1;
+	int status;
+
+	TESTEQUAL(mount_fuse_no_init(mount_dir, -1, -1, &fuse_dev), 0);
+	FUSE_ACTION
+		char data[256] = {0};
+
+		TESTERR(fd = s_open(s_path(s(mount_dir), s(test_name)),
+				    O_RDONLY | O_CLOEXEC), fd != -1);
+		TESTEQUAL(read(fd, data, strlen(test_data)), strlen(test_data));
+		TESTCOND(!strcmp(data, test_data));
+		TESTSYSCALL(close(fd));
+		fd = -1;
+		TESTSYSCALL(umount(mount_dir));
+	FUSE_DAEMON
+		int bpf_fd  = -1;
+		int backing_fd = -1;
+
+		TESTERR(backing_fd = s_creat(s_path(s(ft_src), s(backing_name)), 0777),
+			backing_fd != -1);
+		TESTEQUAL(write(backing_fd, test_data, strlen(test_data)),
+			  strlen(test_data));
+		TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_simple",
+					  &bpf_fd, NULL, NULL), 0);
+
+		TESTFUSEINIT();
+		TESTFUSELOOKUP(test_name, 0);
+		TESTFUSEOUT2(fuse_entry_out, ((struct fuse_entry_out) {0}),
+			     fuse_entry_bpf_out, ((struct fuse_entry_bpf_out) {
+			.backing_action = FUSE_ACTION_REPLACE,
+			.backing_fd = backing_fd,
+			.bpf_action = FUSE_ACTION_REPLACE,
+			.bpf_fd = bpf_fd,
+			}));
+		read(fuse_dev, bytes_in, sizeof(bytes_in));
+		TESTSYSCALL(close(bpf_fd));
+		TESTSYSCALL(close(backing_fd));
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	if (!pid)
+		exit(TEST_FAILURE);
+	close(fuse_dev);
+	close(fd);
+	umount(mount_dir);
+	return result;
+}
+
+static int bpf_test_set_backing_folder(const char *mount_dir)
+{
+	const char *backing_name = "backingdir";
+	const char *test_name = "testdir";
+	const char *names[] = {"file", ".", ".."};
+
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	int fd = -1;
+	int pid = -1;
+	int status;
+
+	TESTEQUAL(mount_fuse_no_init(mount_dir, -1, -1, &fuse_dev), 0);
+	FUSE_ACTION
+		DIR *dir = NULL;
+		struct dirent *dirent;
+		int i, j;
+
+		TEST(dir = s_opendir(s_path(s(mount_dir), s(test_name))), dir);
+
+		for (i = 0; i < ARRAY_SIZE(names); ++i) {
+			TEST(dirent = readdir(dir), dirent);
+
+			for (j = 0; j < ARRAY_SIZE(names); ++j)
+				if (names[j] &&
+				    strcmp(names[j], dirent->d_name) == 0) {
+					names[j] = NULL;
+					break;
+				}
+			TESTNE(j, ARRAY_SIZE(names));
+		}
+		TEST(dirent = readdir(dir), dirent == NULL);
+		TESTSYSCALL(closedir(dir));
+		dir = NULL;
+		TESTEQUAL(bpf_test_trace("prefilter opcode: 28"), 0);
+		TESTSYSCALL(umount(mount_dir));
+	FUSE_DAEMON
+		int bpf_fd  = -1;
+		int backing_fd = -1;
+
+		TESTSYSCALL(s_mkdir(s_path(s(ft_src), s(backing_name)), 0777));
+		TESTERR(backing_fd = s_open(s_path(s(ft_src), s(backing_name)), O_RDONLY | O_CLOEXEC),
+					backing_fd != -1);
+		TESTSYSCALL(s_mkdir(s_pathn(3, s(ft_src), s(backing_name), s(names[0])), 0777));
+		TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_simple",
+					  &bpf_fd, NULL, NULL), 0);
+
+		TESTFUSEINIT();
+		TESTFUSELOOKUP(test_name, 0);
+
+		TESTFUSEOUT2(fuse_entry_out, ((struct fuse_entry_out) {0}),
+			     fuse_entry_bpf_out, ((struct fuse_entry_bpf_out) {
+			.backing_action = FUSE_ACTION_REPLACE,
+			.backing_fd = backing_fd,
+			.bpf_action = FUSE_ACTION_REPLACE,
+			.bpf_fd = bpf_fd,
+			}));
+		TESTSYSCALL(close(bpf_fd));
+		TESTSYSCALL(close(backing_fd));
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	if (!pid)
+		exit(TEST_FAILURE);
+	close(fuse_dev);
+	close(fd);
+	umount(mount_dir);
+	return result;
+}
+
+static int bpf_test_remove_backing(const char *mount_dir)
+{
+	const char *folder1 = "folder1";
+	const char *folder2 = "folder2";
+	const char *file = "file1";
+	const char *contents1 = "contents1";
+	const char *contents2 = "contents2";
+
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	int fd = -1;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int pid = -1;
+	int status;
+	char data[256] = {0};
+
+	/*
+	 * Create folder1/file
+	 *        folder2/file
+	 *
+	 * test will install bpf into mount
+	 * bpf will postfilter root lookup to daemon
+	 * daemon will remove bpf and redirect opens on folder1 to folder2
+	 * test will open folder1/file which will be redirected to folder2
+	 * test will check no traces for file, and contents are folder2/file
+	 */
+	TESTEQUAL(bpf_clear_trace(), 0);
+	TESTSYSCALL(s_mkdir(s_path(s(ft_src), s(folder1)), 0777));
+	TEST(fd = s_creat(s_pathn(3, s(ft_src), s(folder1), s(file)), 0777),
+	     fd != -1);
+	TESTEQUAL(write(fd, contents1, strlen(contents1)), strlen(contents1));
+	TESTSYSCALL(close(fd));
+	TESTSYSCALL(s_mkdir(s_path(s(ft_src), s(folder2)), 0777));
+	TEST(fd = s_creat(s_pathn(3, s(ft_src), s(folder2), s(file)), 0777),
+	     fd != -1);
+	TESTEQUAL(write(fd, contents2, strlen(contents2)), strlen(contents2));
+	TESTSYSCALL(close(fd));
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_passthrough", &bpf_fd,
+				  NULL, NULL), 0);
+	TESTEQUAL(mount_fuse_no_init(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	FUSE_ACTION
+		TESTERR(fd = s_open(s_pathn(3, s(mount_dir), s(folder1),
+					    s(file)),
+				    O_RDONLY | O_CLOEXEC), fd != -1);
+		TESTEQUAL(read(fd, data, sizeof(data)), strlen(contents2));
+		TESTCOND(!strcmp(data, contents2));
+		TESTEQUAL(bpf_test_no_trace("file"), 0);
+		TESTSYSCALL(close(fd));
+		fd = -1;
+		TESTSYSCALL(umount(mount_dir));
+	FUSE_DAEMON
+		struct {
+			char name[8];
+			struct fuse_entry_out feo;
+			struct fuse_entry_bpf_out febo;
+		} __attribute__((packed)) in;
+		int backing_fd = -1;
+
+		TESTFUSEINIT();
+		TESTFUSEIN(FUSE_LOOKUP | FUSE_POSTFILTER, &in);
+		TEST(backing_fd = s_open(s_path(s(ft_src), s(folder2)),
+				 O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+		     backing_fd != -1);
+		TESTFUSEOUT2(fuse_entry_out, ((struct fuse_entry_out) {0}),
+			     fuse_entry_bpf_out, ((struct fuse_entry_bpf_out) {
+			.bpf_action = FUSE_ACTION_REMOVE,
+			.backing_action = FUSE_ACTION_REPLACE,
+			.backing_fd = backing_fd,
+			}));
+
+		while (read(fuse_dev, bytes_in, sizeof(bytes_in)) != -1)
+			;
+		TESTSYSCALL(close(backing_fd));
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	close(fd);
+	close(src_fd);
+	close(bpf_fd);
+	umount(mount_dir);
+	return result;
+}
+
+static int bpf_test_dir_rename(const char *mount_dir)
+{
+	const char *dir_name = "dir";
+	const char *dir_name2 = "dir2";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	struct stat st;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_trace",
+				  &bpf_fd, NULL, NULL), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	TESTSYSCALL(s_mkdir(s_path(s(mount_dir), s(dir_name)), 0777));
+	TESTEQUAL(bpf_test_trace("mkdir"), 0);
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(dir_name)), &st));
+	TESTSYSCALL(s_rename(s_path(s(mount_dir), s(dir_name)),
+			     s_path(s(mount_dir), s(dir_name2))));
+	TESTEQUAL(s_stat(s_path(s(ft_src), s(dir_name)), &st), -1);
+	TESTEQUAL(errno, ENOENT);
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(dir_name2)), &st));
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	close(bpf_fd);
+	close(src_fd);
+	return result;
+}
+
+static int bpf_test_file_rename(const char *mount_dir)
+{
+	const char *dir = "dir";
+	const char *file1 = "file1";
+	const char *file2 = "file2";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	int fd = -1;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_trace",
+				  &bpf_fd, NULL, NULL), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	TESTSYSCALL(s_mkdir(s_path(s(mount_dir), s(dir)), 0777));
+	TEST(fd = s_creat(s_pathn(3, s(mount_dir), s(dir), s(file1)), 0777),
+	     fd != -1);
+	TESTSYSCALL(s_rename(s_pathn(3, s(mount_dir), s(dir), s(file1)),
+			     s_pathn(3, s(mount_dir), s(dir), s(file2))));
+	result = TEST_SUCCESS;
+out:
+	close(fd);
+	umount(mount_dir);
+	close(fuse_dev);
+	close(bpf_fd);
+	close(src_fd);
+	return result;
+}
+
+static int mmap_test(const char *mount_dir)
+{
+	const char *file = "file";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	int fd = -1;
+	char *addr = NULL;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(mount_fuse(mount_dir, -1, src_fd, &fuse_dev), 0);
+	TEST(fd = s_open(s_path(s(mount_dir), s(file)),
+			 O_CREAT | O_RDWR | O_CLOEXEC, 0777),
+	     fd != -1);
+	TESTSYSCALL(fallocate(fd, 0, 4096, SEEK_CUR));
+	TEST(addr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0),
+	     addr != (void *) -1);
+	memset(addr, 'a', 4096);
+
+	result = TEST_SUCCESS;
+out:
+	munmap(addr, 4096);
+	close(fd);
+	umount(mount_dir);
+	close(fuse_dev);
+	close(src_fd);
+	return result;
+}
+
+static int readdir_perms_test(const char *mount_dir)
+{
+	int result = TEST_FAILURE;
+	struct __user_cap_header_struct uchs = { _LINUX_CAPABILITY_VERSION_3 };
+	struct __user_cap_data_struct ucds[2];
+	int src_fd = -1;
+	int fuse_dev = -1;
+	DIR *dir = NULL;
+
+	/* Must remove capabilities for this test. */
+	TESTSYSCALL(syscall(SYS_capget, &uchs, ucds));
+	ucds[0].effective &= ~(1 << CAP_DAC_OVERRIDE | 1 << CAP_DAC_READ_SEARCH);
+	TESTSYSCALL(syscall(SYS_capset, &uchs, ucds));
+
+	/* This is what we are testing in fuseland. First test without fuse, */
+	TESTSYSCALL(mkdir("test", 0111));
+	TEST(dir = opendir("test"), dir == NULL);
+	closedir(dir);
+	dir = NULL;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(mount_fuse(mount_dir, -1, src_fd, &fuse_dev), 0);
+
+	TESTSYSCALL(s_mkdir(s_path(s(mount_dir), s("test")), 0111));
+	TEST(dir = s_opendir(s_path(s(mount_dir), s("test"))), dir == NULL);
+
+	result = TEST_SUCCESS;
+out:
+	ucds[0].effective |= 1 << CAP_DAC_OVERRIDE | 1 << CAP_DAC_READ_SEARCH;
+	syscall(SYS_capset, &uchs, ucds);
+
+	closedir(dir);
+	s_rmdir(s_path(s(mount_dir), s("test")));
+	umount(mount_dir);
+	close(fuse_dev);
+	close(src_fd);
+	rmdir("test");
+	return result;
+}
+
+static int bpf_test_statfs(const char *mount_dir)
+{
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	int fd = -1;
+	struct statfs st;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_trace",
+				  &bpf_fd, NULL, NULL), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	TESTSYSCALL(s_statfs(s(mount_dir), &st));
+	TESTEQUAL(bpf_test_trace("statfs"), 0);
+	TESTEQUAL(st.f_type, 0x65735546);
+	result = TEST_SUCCESS;
+out:
+	close(fd);
+	umount(mount_dir);
+	close(fuse_dev);
+	close(bpf_fd);
+	close(src_fd);
+	return result;
+}
+
+static int bpf_test_lseek(const char *mount_dir)
+{
+	const char *file = "real";
+	const char *test_data = "data";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	int fd = -1;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(fd = openat(src_fd, file, O_CREAT | O_RDWR | O_CLOEXEC, 0777),
+	     fd != -1);
+	TESTEQUAL(write(fd, test_data, strlen(test_data)), strlen(test_data));
+	TESTSYSCALL(close(fd));
+	fd = -1;
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_trace",
+				  &bpf_fd, NULL, NULL), 0);
+	TESTEQUAL(mount_fuse(mount_dir, bpf_fd, src_fd, &fuse_dev), 0);
+
+	TEST(fd = s_open(s_path(s(mount_dir), s(file)), O_RDONLY | O_CLOEXEC),
+	     fd != -1);
+	TESTEQUAL(lseek(fd, 3, SEEK_SET), 3);
+	TESTEQUAL(bpf_test_trace("lseek"), 0);
+	TESTEQUAL(lseek(fd, 5, SEEK_END), 9);
+	TESTEQUAL(bpf_test_trace("lseek"), 0);
+	TESTEQUAL(lseek(fd, 1, SEEK_CUR), 10);
+	TESTEQUAL(bpf_test_trace("lseek"), 0);
+	TESTEQUAL(lseek(fd, 1, SEEK_DATA), 1);
+	TESTEQUAL(bpf_test_trace("lseek"), 0);
+	result = TEST_SUCCESS;
+out:
+	close(fd);
+	umount(mount_dir);
+	close(fuse_dev);
+	close(bpf_fd);
+	close(src_fd);
+	return result;
+}
+
+/*
+ * State:
+ * Original: dst/folder1/content.txt
+ *                  ^
+ *                  |
+ *                  |
+ * Backing:  src/folder1/content.txt
+ *
+ * Step 1:  open(folder1) - set backing to src/folder1
+ * Check 1: cat(content.txt) - check not receiving call on the fuse daemon
+ *                             and content is the same
+ * Step 2:  readdirplus(dst)
+ * Check 2: cat(content.txt) - check not receiving call on the fuse daemon
+ *                             and content is the same
+ */
+static int bpf_test_readdirplus_not_overriding_backing(const char *mount_dir)
+{
+	const char *folder1 = "folder1";
+	const char *content_file = "content.txt";
+	const char *content = "hello world";
+
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	int src_fd = -1;
+	int content_fd = -1;
+	int pid = -1;
+	int status;
+
+	TESTSYSCALL(s_mkdir(s_path(s(ft_src), s(folder1)), 0777));
+	TEST(content_fd = s_creat(s_pathn(3, s(ft_src), s(folder1), s(content_file)), 0777),
+		content_fd != -1);
+	TESTEQUAL(write(content_fd, content, strlen(content)), strlen(content));
+	TESTEQUAL(mount_fuse_no_init(mount_dir, -1, -1, &fuse_dev), 0);
+
+	FUSE_ACTION
+		DIR *open_mount_dir = NULL;
+		struct dirent *mount_dirent;
+		int dst_folder1_fd = -1;
+		int dst_content_fd = -1;
+		int dst_content_read_size = -1;
+		char content_buffer[12];
+
+		// Step 1: Lookup folder1
+		TESTERR(dst_folder1_fd = s_open(s_path(s(mount_dir), s(folder1)),
+			O_RDONLY | O_CLOEXEC), dst_folder1_fd != -1);
+
+		// Check 1: Read content file (backed)
+		TESTERR(dst_content_fd =
+			s_open(s_pathn(3, s(mount_dir), s(folder1), s(content_file)),
+			O_RDONLY | O_CLOEXEC), dst_content_fd != -1);
+
+		TEST(dst_content_read_size =
+			read(dst_content_fd, content_buffer, strlen(content)),
+			dst_content_read_size == strlen(content) &&
+			strcmp(content, content_buffer) == 0);
+
+		TESTSYSCALL(close(dst_content_fd));
+		dst_content_fd = -1;
+		TESTSYSCALL(close(dst_folder1_fd));
+		dst_folder1_fd = -1;
+		memset(content_buffer, 0, strlen(content));
+
+		// Step 2: readdir folder 1
+		TEST(open_mount_dir = s_opendir(s(mount_dir)),
+			open_mount_dir != NULL);
+		TEST(mount_dirent = readdir(open_mount_dir), mount_dirent != NULL);
+		TESTSYSCALL(closedir(open_mount_dir));
+		open_mount_dir = NULL;
+
+		// Check 2: Read content file again (must be backed)
+		TESTERR(dst_content_fd =
+			s_open(s_pathn(3, s(mount_dir), s(folder1), s(content_file)),
+			O_RDONLY | O_CLOEXEC), dst_content_fd != -1);
+
+		TEST(dst_content_read_size =
+			read(dst_content_fd, content_buffer, strlen(content)),
+			dst_content_read_size == strlen(content) &&
+			strcmp(content, content_buffer) == 0);
+
+		TESTSYSCALL(close(dst_content_fd));
+		dst_content_fd = -1;
+	FUSE_DAEMON
+		size_t read_size = 0;
+		struct fuse_in_header *in_header = (struct fuse_in_header *)bytes_in;
+		struct fuse_read_out *read_out = NULL;
+		struct fuse_attr attr = {};
+		int backing_fd = -1;
+		DECL_FUSE_IN(open);
+		DECL_FUSE_IN(getattr);
+
+		TESTFUSEINITFLAGS(FUSE_DO_READDIRPLUS | FUSE_READDIRPLUS_AUTO);
+
+		// Step 1: Lookup folder 1 with backing
+		TESTFUSELOOKUP(folder1, 0);
+		TESTSYSCALL(s_fuse_attr(s_path(s(ft_src), s(folder1)), &attr));
+		TEST(backing_fd = s_open(s_path(s(ft_src), s(folder1)),
+					 O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+		     backing_fd != -1);
+		TESTFUSEOUT2(fuse_entry_out, ((struct fuse_entry_out) {
+				.nodeid = attr.ino,
+				.generation = 0,
+				.entry_valid = UINT64_MAX,
+				.attr_valid = UINT64_MAX,
+				.entry_valid_nsec = UINT32_MAX,
+				.attr_valid_nsec = UINT32_MAX,
+				.attr = attr,
+			     }), fuse_entry_bpf_out, ((struct fuse_entry_bpf_out) {
+				.backing_action = FUSE_ACTION_REPLACE,
+				.backing_fd = backing_fd,
+			     }));
+		TESTSYSCALL(close(backing_fd));
+
+		// Step 2: Open root dir
+		TESTFUSEIN(FUSE_OPENDIR, open_in);
+		TESTFUSEOUT1(fuse_open_out, ((struct fuse_open_out) {
+			.fh = 100,
+			.open_flags = open_in->flags
+		}));
+
+		// Step 2: Handle getattr
+		TESTFUSEIN(FUSE_GETATTR, getattr_in);
+		TESTSYSCALL(s_fuse_attr(s(ft_src), &attr));
+		TESTFUSEOUT1(fuse_attr_out, ((struct fuse_attr_out) {
+			.attr_valid = UINT64_MAX,
+			.attr_valid_nsec = UINT32_MAX,
+			.attr = attr
+		}));
+
+		// Step 2: Handle readdirplus
+		read_size = read(fuse_dev, bytes_in, sizeof(bytes_in));
+		TESTEQUAL(in_header->opcode, FUSE_READDIRPLUS);
+
+		struct fuse_direntplus *dirent_plus =
+			(struct fuse_direntplus *) (bytes_in + read_size);
+		struct fuse_dirent dirent;
+		struct fuse_entry_out entry_out;
+
+		read_out = (struct fuse_read_out *) (bytes_in +
+					sizeof(*in_header) +
+					sizeof(struct fuse_read_in));
+
+		TESTSYSCALL(s_fuse_attr(s_path(s(ft_src), s(folder1)), &attr));
+
+		dirent = (struct fuse_dirent) {
+			.ino = attr.ino,
+			.off = 1,
+			.namelen = strlen(folder1),
+			.type = DT_REG
+		};
+		entry_out = (struct fuse_entry_out) {
+			.nodeid = attr.ino,
+			.generation = 0,
+			.entry_valid = UINT64_MAX,
+			.attr_valid = UINT64_MAX,
+			.entry_valid_nsec = UINT32_MAX,
+			.attr_valid_nsec = UINT32_MAX,
+			.attr = attr
+		};
+		*dirent_plus = (struct fuse_direntplus) {
+			.dirent = dirent,
+			.entry_out = entry_out
+		};
+
+		strcpy((char *)(bytes_in + read_size + sizeof(*dirent_plus)), folder1);
+		read_size += FUSE_DIRENT_ALIGN(sizeof(*dirent_plus) + strlen(folder1) +
+					1);
+		TESTFUSEDIROUTREAD(read_out,
+				bytes_in +
+				sizeof(struct fuse_in_header) +
+				sizeof(struct fuse_read_in) +
+				sizeof(struct fuse_read_out),
+				read_size - sizeof(struct fuse_in_header) -
+					sizeof(struct fuse_read_in) -
+					sizeof(struct fuse_read_out));
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+
+out:
+	close(fuse_dev);
+	close(content_fd);
+	close(src_fd);
+	umount(mount_dir);
+	return result;
+}
+
+static int bpf_test_no_readdirplus_without_nodeid(const char *mount_dir)
+{
+	const char *folder1 = "folder1";
+	const char *folder2 = "folder2";
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	int src_fd = -1;
+	int content_fd = -1;
+	int bpf_fd = -1;
+	int pid = -1;
+	int status;
+
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf", "test_readdirplus",
+					  &bpf_fd, NULL, NULL), 0);
+	TESTSYSCALL(s_mkdir(s_path(s(ft_src), s(folder1)), 0777));
+	TESTSYSCALL(s_mkdir(s_path(s(ft_src), s(folder2)), 0777));
+	TESTEQUAL(mount_fuse_no_init(mount_dir, -1, -1, &fuse_dev), 0);
+	FUSE_ACTION
+		DIR *open_dir = NULL;
+		struct dirent *dirent;
+
+		// Folder 1: Readdir with no nodeid
+		TEST(open_dir = s_opendir(s_path(s(ft_dst), s(folder1))),
+				open_dir != NULL);
+		TEST(dirent = readdir(open_dir), dirent == NULL);
+		TESTCOND(errno == EINVAL);
+		TESTSYSCALL(closedir(open_dir));
+		open_dir = NULL;
+
+		// Folder 2: Readdir with a nodeid
+		TEST(open_dir = s_opendir(s_path(s(ft_dst), s(folder2))),
+				open_dir != NULL);
+		TEST(dirent = readdir(open_dir), dirent == NULL);
+		TESTCOND(errno == EINVAL);
+		TESTSYSCALL(closedir(open_dir));
+		open_dir = NULL;
+	FUSE_DAEMON
+		size_t read_size;
+		struct fuse_in_header *in_header = (struct fuse_in_header *)bytes_in;
+		struct fuse_attr attr = {};
+		int backing_fd = -1;
+
+		TESTFUSEINITFLAGS(FUSE_DO_READDIRPLUS | FUSE_READDIRPLUS_AUTO);
+
+		// folder 1: Set 0 as nodeid, Expect READDIR
+		TESTFUSELOOKUP(folder1, 0);
+		TEST(backing_fd = s_open(s_path(s(ft_src), s(folder1)),
+					 O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+		     backing_fd != -1);
+		TESTFUSEOUT2(fuse_entry_out, ((struct fuse_entry_out) {
+				.nodeid = 0,
+				.generation = 0,
+				.entry_valid = UINT64_MAX,
+				.attr_valid = UINT64_MAX,
+				.entry_valid_nsec = UINT32_MAX,
+				.attr_valid_nsec = UINT32_MAX,
+				.attr = attr,
+			     }), fuse_entry_bpf_out, ((struct fuse_entry_bpf_out) {
+				.backing_action = FUSE_ACTION_REPLACE,
+				.backing_fd = backing_fd,
+				.bpf_action = FUSE_ACTION_REPLACE,
+				.bpf_fd = bpf_fd,
+			     }));
+		TESTSYSCALL(close(backing_fd));
+		TEST(read_size = read(fuse_dev, bytes_in, sizeof(bytes_in)), read_size > 0);
+		TESTEQUAL(in_header->opcode, FUSE_READDIR);
+		TESTFUSEOUTERROR(-EINVAL);
+
+		// folder 2: Set 10 as nodeid, Expect READDIRPLUS
+		TESTFUSELOOKUP(folder2, 0);
+		TEST(backing_fd = s_open(s_path(s(ft_src), s(folder2)),
+					 O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+		     backing_fd != -1);
+		TESTFUSEOUT2(fuse_entry_out, ((struct fuse_entry_out) {
+				.nodeid = 10,
+				.generation = 0,
+				.entry_valid = UINT64_MAX,
+				.attr_valid = UINT64_MAX,
+				.entry_valid_nsec = UINT32_MAX,
+				.attr_valid_nsec = UINT32_MAX,
+				.attr = attr,
+			     }), fuse_entry_bpf_out, ((struct fuse_entry_bpf_out) {
+				.backing_action = FUSE_ACTION_REPLACE,
+				.backing_fd = backing_fd,
+				.bpf_action = FUSE_ACTION_REPLACE,
+				.bpf_fd = bpf_fd,
+			     }));
+		TESTSYSCALL(close(backing_fd));
+		TEST(read_size = read(fuse_dev, bytes_in, sizeof(bytes_in)), read_size > 0);
+		TESTEQUAL(in_header->opcode, FUSE_READDIRPLUS);
+		TESTFUSEOUTERROR(-EINVAL);
+	FUSE_DONE
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	close(content_fd);
+	close(src_fd);
+	close(bpf_fd);
+	umount(mount_dir);
+	return result;
+}
+
+/*
+ * State:
+ * Original: dst/folder1/content.txt
+ *                  ^
+ *                  |
+ *                  |
+ * Backing:  src/folder1/content.txt
+ *
+ * Step 1:  open(folder1) - lookup folder1 with entry_timeout set to 0
+ * Step 2:  open(folder1) - lookup folder1 again to trigger revalidate wich will
+ *                          set backing fd
+ *
+ * Check 1: cat(content.txt) - check not receiving call on the fuse daemon
+ *                             and content is the same
+ */
+static int bpf_test_revalidate_handle_backing_fd(const char *mount_dir)
+{
+	const char *folder1 = "folder1";
+	const char *content_file = "content.txt";
+	const char *content = "hello world";
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	int src_fd = -1;
+	int content_fd = -1;
+	int pid = -1;
+	int status;
+	TESTSYSCALL(s_mkdir(s_path(s(ft_src), s(folder1)), 0777));
+	TEST(content_fd = s_creat(s_pathn(3, s(ft_src), s(folder1), s(content_file)), 0777),
+		content_fd != -1);
+	TESTEQUAL(write(content_fd, content, strlen(content)), strlen(content));
+	TESTSYSCALL(close(content_fd));
+	content_fd = -1;
+	TESTEQUAL(mount_fuse_no_init(mount_dir, -1, -1, &fuse_dev), 0);
+	FUSE_ACTION
+		int dst_folder1_fd = -1;
+		int dst_content_fd = -1;
+		int dst_content_read_size = -1;
+		char content_buffer[9] = {0};
+		// Step 1: Lookup folder1
+		TESTERR(dst_folder1_fd = s_open(s_path(s(mount_dir), s(folder1)),
+			O_RDONLY | O_CLOEXEC), dst_folder1_fd != -1);
+		TESTSYSCALL(close(dst_folder1_fd));
+		dst_folder1_fd = -1;
+		// Step 2: Lookup folder1 again
+		TESTERR(dst_folder1_fd = s_open(s_path(s(mount_dir), s(folder1)),
+			O_RDONLY | O_CLOEXEC), dst_folder1_fd != -1);
+		TESTSYSCALL(close(dst_folder1_fd));
+		dst_folder1_fd = -1;
+		// Check 1: Read content file (must be backed)
+		TESTERR(dst_content_fd =
+			s_open(s_pathn(3, s(mount_dir), s(folder1), s(content_file)),
+			O_RDONLY | O_CLOEXEC), dst_content_fd != -1);
+		TEST(dst_content_read_size =
+			read(dst_content_fd, content_buffer, strlen(content)),
+			dst_content_read_size == strlen(content) &&
+			strcmp(content, content_buffer) == 0);
+		TESTSYSCALL(close(dst_content_fd));
+		dst_content_fd = -1;
+	FUSE_DAEMON
+		struct fuse_attr attr = {};
+		int backing_fd = -1;
+		TESTFUSEINITFLAGS(FUSE_DO_READDIRPLUS | FUSE_READDIRPLUS_AUTO);
+		// Step 1: Lookup folder1 set entry_timeout to 0 to trigger
+		// revalidate later
+		TESTFUSELOOKUP(folder1, 0);
+		TESTSYSCALL(s_fuse_attr(s_path(s(ft_src), s(folder1)), &attr));
+		TEST(backing_fd = s_open(s_path(s(ft_src), s(folder1)),
+					 O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+		     backing_fd != -1);
+		TESTFUSEOUT2(fuse_entry_out, ((struct fuse_entry_out) {
+				.nodeid = attr.ino,
+				.generation = 0,
+				.entry_valid = 0,
+				.attr_valid = UINT64_MAX,
+				.entry_valid_nsec = 0,
+				.attr_valid_nsec = UINT32_MAX,
+				.attr = attr,
+			     }), fuse_entry_bpf_out, ((struct fuse_entry_bpf_out) {
+				.backing_action = FUSE_ACTION_REPLACE,
+				.backing_fd = backing_fd,
+			     }));
+		TESTSYSCALL(close(backing_fd));
+		// Step 1: Lookup folder1 as a reaction to revalidate call
+		// This attempts to change the backing node, which is not allowed on revalidate
+		TESTFUSELOOKUP(folder1, 0);
+		TESTSYSCALL(s_fuse_attr(s_path(s(ft_src), s(folder1)), &attr));
+		TEST(backing_fd = s_open(s_path(s(ft_src), s(folder1)),
+					 O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+		     backing_fd != -1);
+		TESTFUSEOUT2(fuse_entry_out, ((struct fuse_entry_out) {
+				.nodeid = attr.ino,
+				.generation = 0,
+				.entry_valid = UINT64_MAX,
+				.attr_valid = UINT64_MAX,
+				.entry_valid_nsec = UINT32_MAX,
+				.attr_valid_nsec = UINT32_MAX,
+				.attr = attr,
+			     }), fuse_entry_bpf_out, ((struct fuse_entry_bpf_out) {
+				.backing_action = FUSE_ACTION_REPLACE,
+				.backing_fd = backing_fd,
+			     }));
+		TESTSYSCALL(close(backing_fd));
+
+		// Lookup folder1 as a reaction to failed revalidate
+		TESTFUSELOOKUP(folder1, 0);
+		TESTSYSCALL(s_fuse_attr(s_path(s(ft_src), s(folder1)), &attr));
+		TEST(backing_fd = s_open(s_path(s(ft_src), s(folder1)),
+					 O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+		     backing_fd != -1);
+		TESTFUSEOUT2(fuse_entry_out, ((struct fuse_entry_out) {
+				.nodeid = attr.ino,
+				.generation = 0,
+				.entry_valid = UINT64_MAX,
+				.attr_valid = UINT64_MAX,
+				.entry_valid_nsec = UINT32_MAX,
+				.attr_valid_nsec = UINT32_MAX,
+				.attr = attr,
+			     }), fuse_entry_bpf_out, ((struct fuse_entry_bpf_out) {
+				.backing_action = FUSE_ACTION_REPLACE,
+				.backing_fd = backing_fd,
+			     }));
+		TESTSYSCALL(close(backing_fd));
+	FUSE_DONE
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	close(content_fd);
+	close(src_fd);
+	umount(mount_dir);
+	return result;
+}
+
+static int parse_options(int argc, char *const *argv)
+{
+	signed char c;
+
+	while ((c = getopt(argc, argv, "f:t:v")) != -1)
+		switch (c) {
+		case 'f':
+			test_options.file = strtol(optarg, NULL, 10);
+			break;
+
+		case 't':
+			test_options.test = strtol(optarg, NULL, 10);
+			break;
+
+		case 'v':
+			test_options.verbose = true;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+
+	return 0;
+}
+
+struct test_case {
+	int (*pfunc)(const char *dir);
+	const char *name;
+};
+
+static void run_one_test(const char *mount_dir, struct test_case *test_case)
+{
+	ksft_print_msg("Running %s\n", test_case->name);
+	bpf_clear_trace();
+	if (test_case->pfunc(mount_dir) == TEST_SUCCESS)
+		ksft_test_result_pass("%s\n", test_case->name);
+	else
+		ksft_test_result_fail("%s\n", test_case->name);
+}
+
+int main(int argc, char *argv[])
+{
+	char *mount_dir = NULL;
+	char *src_dir = NULL;
+	int i;
+	int fd, count;
+
+	if (parse_options(argc, argv))
+		ksft_exit_fail_msg("Bad options\n");
+
+	// Seed randomness pool for testing on QEMU
+	// NOTE - this abuses the concept of randomness - do *not* ever do this
+	// on a machine for production use - the device will think it has good
+	// randomness when it does not.
+	fd = open("/dev/urandom", O_WRONLY | O_CLOEXEC);
+	count = 4096;
+	for (int i = 0; i < 128; ++i)
+		ioctl(fd, RNDADDTOENTCNT, &count);
+	close(fd);
+
+	ksft_print_header();
+
+	if (geteuid() != 0)
+		ksft_print_msg("Not a root, might fail to mount.\n");
+
+	if (tracing_on() != TEST_SUCCESS)
+		ksft_exit_fail_msg("Can't turn on tracing\n");
+
+	src_dir = setup_mount_dir(ft_src);
+	mount_dir = setup_mount_dir(ft_dst);
+	if (src_dir == NULL || mount_dir == NULL)
+		ksft_exit_fail_msg("Can't create a mount dir\n");
+
+#define MAKE_TEST(test)                                                        \
+	{                                                                      \
+		test, #test                                                    \
+	}
+	struct test_case cases[] = {
+		MAKE_TEST(basic_test),
+		MAKE_TEST(bpf_test_real),
+		MAKE_TEST(bpf_test_partial),
+		MAKE_TEST(bpf_test_attrs),
+		MAKE_TEST(bpf_test_readdir),
+		MAKE_TEST(bpf_test_creat),
+		MAKE_TEST(bpf_test_hidden_entries),
+		MAKE_TEST(bpf_test_dir),
+		MAKE_TEST(bpf_test_file_early_close),
+		MAKE_TEST(bpf_test_file_late_close),
+		MAKE_TEST(bpf_test_mknod),
+		MAKE_TEST(bpf_test_largedir),
+		MAKE_TEST(bpf_test_link),
+		MAKE_TEST(bpf_test_symlink),
+		MAKE_TEST(bpf_test_xattr),
+		MAKE_TEST(bpf_test_redact_readdir),
+		MAKE_TEST(bpf_test_set_backing),
+		MAKE_TEST(bpf_test_set_backing_folder),
+		MAKE_TEST(bpf_test_remove_backing),
+		MAKE_TEST(bpf_test_dir_rename),
+		MAKE_TEST(bpf_test_file_rename),
+		MAKE_TEST(bpf_test_alter_errcode_bpf),
+		MAKE_TEST(bpf_test_alter_errcode_userspace),
+		MAKE_TEST(mmap_test),
+		MAKE_TEST(readdir_perms_test),
+		MAKE_TEST(bpf_test_statfs),
+		MAKE_TEST(bpf_test_lseek),
+		MAKE_TEST(bpf_test_readdirplus_not_overriding_backing),
+		MAKE_TEST(bpf_test_no_readdirplus_without_nodeid),
+		MAKE_TEST(bpf_test_revalidate_handle_backing_fd),
+		MAKE_TEST(bpf_test_verifier),
+		MAKE_TEST(bpf_test_verifier_out_args),
+		MAKE_TEST(bpf_test_verifier_packet_invalidation),
+		MAKE_TEST(bpf_test_verifier_nonsense_read)
+	};
+#undef MAKE_TEST
+
+	if (test_options.test) {
+		if (test_options.test <= 0 ||
+		    test_options.test > ARRAY_SIZE(cases))
+			ksft_exit_fail_msg("Invalid test\n");
+
+		ksft_set_plan(1);
+		delete_dir_tree(mount_dir, false);
+		delete_dir_tree(src_dir, false);
+		run_one_test(mount_dir, &cases[test_options.test - 1]);
+	} else {
+		ksft_set_plan(ARRAY_SIZE(cases));
+		for (i = 0; i < ARRAY_SIZE(cases); ++i) {
+			delete_dir_tree(mount_dir, false);
+			delete_dir_tree(src_dir, false);
+			run_one_test(mount_dir, &cases[i]);
+		}
+	}
+
+	umount2(mount_dir, MNT_FORCE);
+	delete_dir_tree(mount_dir, true);
+	delete_dir_tree(src_dir, true);
+	return !ksft_get_fail_cnt() ? ksft_exit_pass() : ksft_exit_fail();
+}
diff --git a/tools/testing/selftests/filesystems/fuse/test_bpf.c b/tools/testing/selftests/filesystems/fuse/test_bpf.c
new file mode 100644
index 000000000000..da28792c3eaa
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/test_bpf.c
@@ -0,0 +1,800 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+// Copyright (c) 2021 Google LLC
+
+#include <linux/fuse.h>
+#include <linux/errno.h>
+#include <uapi/linux/bpf.h>
+#include <linux/types.h>
+
+#include <stdbool.h>
+
+#define SEC(NAME) __attribute__((section(NAME), used))
+
+static long (*bpf_trace_printk)(const char *fmt, __u32 fmt_size, ...)
+	= (void *) 6;
+
+#define bpf_printk(fmt, ...)					\
+	({			                                \
+		char ____fmt[] = fmt;                           \
+		bpf_trace_printk(____fmt, sizeof(____fmt),      \
+		                 ##__VA_ARGS__);                \
+	})
+
+//static long (*bpf_fuse_get_writeable_in)(struct fuse_bpf_args *fa, u32 index, void *value,
+//					 u64 size, bool copy)
+//	= (void *) 208;
+static long (*bpf_fuse_get_writeable_out)(struct __bpf_fuse_args *fa, u32 index, void *value,
+					  u64 size, bool copy)
+	= (void *) 209;
+
+
+//#define bpf_make_writable_in(fa, index, size, copy)\
+//	(void *)bpf_fuse_get_writeable_in(fa, index, size, copy)
+#define bpf_make_writable_out(fa, index, value, size, copy) \
+	(void *)bpf_fuse_get_writeable_out(fa, index, (void *)(long)value, size, copy)
+
+inline const void *fa_verify_in(struct __bpf_fuse_args *fa, int i, unsigned int size)
+{
+	const char *val = (void *)(long)fa->in_args[i].value;
+	const char *end = (void *)(long)fa->in_args[i].end_offset;
+
+	if (i >= fa->in_numargs)
+		return NULL;
+	if (val + size <= end)
+		return val;
+	return NULL;
+}
+
+inline void *fa_verify_out(struct __bpf_fuse_args *fa, int i, unsigned int size)
+{
+	char *val = (void *)(long)fa->out_args[i].value;
+	char *end = (void *)(long)fa->out_args[i].end_offset;
+
+	if (i >= fa->out_numargs)
+		return NULL;
+	if (val + size <= end)
+		return val;
+	return NULL;
+}
+
+SEC("dummy")
+
+inline int strcmp(const char *a, const char *b)
+{
+	int i;
+
+	for (i = 0; i < __builtin_strlen(b) + 1; ++i)
+		if (a[i] != b[i])
+			return -1;
+	return 0;
+}
+
+/* This is a macro to enforce inlining. Without it, the compiler will do the wrong thing for bpf */
+#define strcmp_check(a, b, end_b) \
+		(((b) + __builtin_strlen(a) + 1 > (end_b)) ? -1 : strcmp((b), (a)))
+
+SEC("test_readdir_redact")
+/* return BPF_FUSE_CONTINUE to use backing fs, BPF_FUSE_USER to pass to usermode */
+int readdir_test(struct __bpf_fuse_args *fa)
+{
+	switch (fa->opcode) {
+	case FUSE_READDIR | FUSE_PREFILTER: {
+		const struct fuse_read_in *fri = fa_verify_in(fa, 0, sizeof(*fri));
+
+		if (!fri)
+			return -1;
+
+		bpf_printk("readdir %d", fri->fh);
+		return BPF_FUSE_POSTFILTER;
+	}
+
+	case FUSE_READDIR | FUSE_POSTFILTER: {
+		const struct fuse_read_in *fri = fa_verify_in(fa, 0, sizeof(*fri));
+
+		if (!fri)
+			return -1;
+
+		bpf_printk("readdir postfilter %x", fri->fh);
+		return BPF_FUSE_USER_POSTFILTER;
+	}
+
+	default:
+		bpf_printk("opcode %d", fa->opcode);
+		return BPF_FUSE_CONTINUE;
+	}
+}
+SEC("test_trace")
+
+/* return BPF_FUSE_CONTINUE to use backing fs, BPF_FUSE_USER to pass to usermode */
+int trace_test(struct __bpf_fuse_args *fa)
+{
+	switch (fa->opcode) {
+	case FUSE_LOOKUP | FUSE_PREFILTER: {
+		/* real and partial use backing file */
+		const char *name = (void *)(long)fa->in_args[0].value;
+		const char *end = (void *)(long)fa->in_args[0].end_offset;
+		bool backing = false;
+
+		if (strcmp_check("real", name, end) == 0 || strcmp_check("partial", name, end) == 0)
+			backing = true;
+
+		if (strcmp_check("dir", name, end) == 0)
+			backing = true;
+		if (strcmp_check("dir2", name, end) == 0)
+			backing = true;
+
+		if (strcmp_check("file1", name, end) == 0)
+			backing = true;
+		if (strcmp_check("file2", name, end) == 0)
+			backing = true;
+
+		bpf_printk("lookup %s %d", name, backing);
+		return backing ? BPF_FUSE_POSTFILTER : BPF_FUSE_USER;
+	}
+
+	case FUSE_LOOKUP | FUSE_POSTFILTER: {
+		const char *name = (void *)(long)fa->in_args[0].value;
+		const char *end = (void *)(long)fa->in_args[0].end_offset;
+		struct fuse_entry_out *feo = (struct fuse_entry_out *)
+				bpf_make_writable_out(fa, 0, fa->out_args[0].value,
+						      sizeof(*feo), true);
+
+		if (!feo)
+			return -1;
+
+		if (strcmp_check("real", name, end) == 0)
+			feo->nodeid = 5;
+		else if (strcmp_check("partial", name, end) == 0)
+			feo->nodeid = 6;
+
+		bpf_printk("post-lookup %s %d", name, feo->nodeid);
+		return 0;
+	}
+
+	case FUSE_ACCESS | FUSE_PREFILTER: {
+		bpf_printk("Access: %d", fa->nodeid);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_CREATE | FUSE_PREFILTER:
+		bpf_printk("Create: %d", fa->nodeid);
+		return BPF_FUSE_CONTINUE;
+
+	case FUSE_MKNOD | FUSE_PREFILTER: {
+		const struct fuse_mknod_in *fmi = fa_verify_in(fa, 0, sizeof(*fmi));
+		const char *name = (void *)(long)fa->in_args[1].value;
+
+		if (!fmi)
+			return -1;
+
+		bpf_printk("mknod %s %x %x", name, fmi->rdev | fmi->mode, fmi->umask);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_MKDIR | FUSE_PREFILTER: {
+		const struct fuse_mkdir_in *fmi = fa_verify_in(fa, 0, sizeof(*fmi));
+		const char *name = (void *)(long)fa->in_args[1].value;
+
+		if (!fmi)
+			return -1;
+
+		bpf_printk("mkdir %s %x %x", name, fmi->mode, fmi->umask);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_RMDIR | FUSE_PREFILTER: {
+		const char *name = (void *)(long)fa->in_args[0].value;
+
+		bpf_printk("rmdir %s", name);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_RENAME | FUSE_PREFILTER: {
+		const char *oldname = (void *)(long)fa->in_args[1].value;
+		const char *newname = (void *)(long)fa->in_args[2].value;
+
+		bpf_printk("rename from %s", oldname);
+		bpf_printk("rename to %s", newname);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_RENAME2 | FUSE_PREFILTER: {
+		const struct fuse_rename2_in *fri = fa_verify_in(fa, 0, sizeof(*fri));
+		uint32_t flags = fri->flags;
+		const char *oldname = (void *)(long) fa->in_args[1].value;
+		const char *newname = (void *)(long) fa->in_args[2].value;
+
+		if (!fri)
+			return -1;
+
+		bpf_printk("rename(%x) from %s", flags, oldname);
+		bpf_printk("rename to %s", newname);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_UNLINK | FUSE_PREFILTER: {
+		const char *name = (void *)(long)fa->in_args[0].value;
+
+		bpf_printk("unlink %s", name);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_LINK | FUSE_PREFILTER: {
+		const struct fuse_link_in *fli = fa_verify_in(fa, 0, sizeof(*fli));
+		const char *link_name = (void *)(long) fa->in_args[1].value;
+
+		if (!fli)
+			return -1;
+
+		bpf_printk("link %d %s", fli->oldnodeid, link_name);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_SYMLINK | FUSE_PREFILTER: {
+		const char *link_name = (void *)(long) fa->in_args[0].value;
+		const char *link_dest = (void *)(long) fa->in_args[1].value;
+
+		bpf_printk("symlink from %s", link_name);
+		bpf_printk("symlink to %s", link_dest);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_READLINK | FUSE_PREFILTER: {
+		const char *link_name = (void *)(long) fa->in_args[0].value;
+
+		bpf_printk("readlink from", link_name);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_OPEN | FUSE_PREFILTER: {
+		int backing = BPF_FUSE_USER;
+
+		switch (fa->nodeid) {
+		case 5:
+			backing = BPF_FUSE_CONTINUE;
+			break;
+
+		case 6:
+			backing = BPF_FUSE_POSTFILTER;
+			break;
+
+		default:
+			break;
+		}
+
+		bpf_printk("open %d %d", fa->nodeid, backing);
+		return backing;
+	}
+
+	case FUSE_OPEN | FUSE_POSTFILTER:
+		bpf_printk("open postfilter");
+		return BPF_FUSE_USER_POSTFILTER;
+
+	case FUSE_READ | FUSE_PREFILTER: {
+		const struct fuse_read_in *fri = fa_verify_in(fa, 0, sizeof(*fri));
+
+		if (!fri)
+			return -1;
+
+		bpf_printk("read %llu %llu", fri->fh, fri->offset);
+		if (fri->fh == 1 && fri->offset == 0)
+			return BPF_FUSE_USER;
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_GETATTR | FUSE_PREFILTER: {
+		/* real and partial use backing file */
+		int backing = BPF_FUSE_USER;
+
+		switch (fa->nodeid) {
+		case 1:
+		case 5:
+		case 6:
+		/*
+		 * TODO: Find better solution
+		 * Add 100 to stop clang compiling to jump table which bpf hates
+		 */
+		case 100:
+			backing = BPF_FUSE_CONTINUE;
+			break;
+		}
+
+		bpf_printk("getattr %d %d", fa->nodeid, backing);
+		return backing;
+	}
+
+	case FUSE_SETATTR | FUSE_PREFILTER: {
+		/* real and partial use backing file */
+		int backing = BPF_FUSE_USER;
+
+		switch (fa->nodeid) {
+		case 1:
+		case 5:
+		case 6:
+		/* TODO See above */
+		case 100:
+			backing = BPF_FUSE_CONTINUE;
+			break;
+		}
+
+		bpf_printk("setattr %d %d", fa->nodeid, backing);
+		return backing;
+	}
+
+	case FUSE_OPENDIR | FUSE_PREFILTER: {
+		int backing = BPF_FUSE_USER;
+
+		switch (fa->nodeid) {
+		case 1:
+			backing = BPF_FUSE_POSTFILTER;
+			break;
+		}
+
+		bpf_printk("opendir %d %d", fa->nodeid, backing);
+		return backing;
+	}
+
+	case FUSE_OPENDIR | FUSE_POSTFILTER: {
+		struct fuse_open_out *foo = bpf_make_writable_out(fa, 0, fa->out_args[0].value,
+								  sizeof(*foo), true);
+
+		if (!foo)
+			return -1;
+
+		foo->fh = 2;
+		bpf_printk("opendir postfilter");
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_READDIR | FUSE_PREFILTER: {
+		const struct fuse_read_in *fri = fa_verify_in(fa, 0, sizeof(*fri));
+		int backing = BPF_FUSE_USER;
+
+		if (!fri)
+			return -1;
+
+		if (fri->fh == 2)
+			backing = BPF_FUSE_POSTFILTER;
+
+		bpf_printk("readdir %d %d", fri->fh, backing);
+		return backing;
+	}
+
+	case FUSE_READDIR | FUSE_POSTFILTER: {
+		const struct fuse_read_in *fri = fa_verify_in(fa, 0, sizeof(*fri));
+		int backing = BPF_FUSE_CONTINUE;
+
+		if (!fri)
+			return -1;
+
+		if (fri->fh == 2)
+			backing = BPF_FUSE_USER_POSTFILTER;
+
+		bpf_printk("readdir postfilter %d %d", fri->fh, backing);
+		return backing;
+	}
+
+	case FUSE_FLUSH | FUSE_PREFILTER: {
+		const struct fuse_flush_in *ffi = fa_verify_in(fa, 0, sizeof(*ffi));
+
+		if (!ffi)
+			return -1;
+
+		bpf_printk("Flush %d", ffi->fh);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_GETXATTR | FUSE_PREFILTER: {
+		const struct fuse_getxattr_in *fgi = fa_verify_in(fa, 0, sizeof(*fgi));
+		const char *name = (void *)(long)fa->in_args[1].value;
+
+		if (!fgi)
+			return -1;
+
+		bpf_printk("getxattr %d %s", fgi->size, name);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_LISTXATTR | FUSE_PREFILTER: {
+		const struct fuse_getxattr_in *fgi = fa_verify_in(fa, 0, sizeof(*fgi));
+		const char *name = (void *)(long)fa->in_args[1].value;
+
+		if (!fgi)
+			return -1;
+
+		bpf_printk("listxattr %d %s", fgi->size, name);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_SETXATTR | FUSE_PREFILTER: {
+		const struct fuse_setxattr_in *fsi = fa_verify_in(fa, 0, sizeof(*fsi));
+		const char *name = (void *)(long)fa->in_args[1].value;
+		unsigned int size = fa->in_args[2].size;
+
+		if (!fsi)
+			return -1;
+		bpf_printk("setxattr %x %s %u", fsi->flags, name, size);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_REMOVEXATTR | FUSE_PREFILTER: {
+		const char *name = (void *)(long)fa->in_args[0].value;
+
+		bpf_printk("removexattr %s", name);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_CANONICAL_PATH | FUSE_PREFILTER: {
+		bpf_printk("canonical_path");
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_STATFS | FUSE_PREFILTER: {
+		bpf_printk("statfs");
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_LSEEK | FUSE_PREFILTER: {
+		const struct fuse_lseek_in *fli = fa_verify_in(fa, 0, sizeof(*fli));
+
+		if (!fli)
+			return -1;
+		bpf_printk("lseek type:%d, offset:%lld", fli->whence, fli->offset);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	default:
+		bpf_printk("Unknown opcode %d", fa->opcode);
+		return BPF_FUSE_USER;
+	}
+}
+
+SEC("test_hidden")
+
+int trace_hidden(struct __bpf_fuse_args *fa)
+{
+	switch (fa->opcode) {
+	case FUSE_LOOKUP | FUSE_PREFILTER: {
+		const char *name = (void *)(long)fa->in_args[0].value;
+		const char *end = (void *)(long)fa->in_args[0].end_offset;
+
+		bpf_printk("Lookup: %s", name);
+		if (!strcmp_check("show", name, end))
+			return BPF_FUSE_CONTINUE;
+		if (!strcmp_check("hide", name, end))
+			return -ENOENT;
+
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_ACCESS | FUSE_PREFILTER: {
+		bpf_printk("Access: %d", fa->nodeid);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_CREATE | FUSE_PREFILTER:
+		bpf_printk("Create: %d", fa->nodeid);
+		return BPF_FUSE_CONTINUE;
+
+	case FUSE_WRITE | FUSE_PREFILTER:
+	// TODO: Clang combines similar printk calls, causing BPF to complain
+	//	bpf_printk("Write: %d", fa->nodeid);
+		return BPF_FUSE_CONTINUE;
+
+	case FUSE_FLUSH | FUSE_PREFILTER: {
+	//	const struct fuse_flush_in *ffi = fa->in_args[0].value;
+
+	//	bpf_printk("Flush %d", ffi->fh);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_RELEASE | FUSE_PREFILTER: {
+	//	const struct fuse_release_in *fri = fa->in_args[0].value;
+
+	//	bpf_printk("Release %d", fri->fh);
+		return BPF_FUSE_CONTINUE;
+	}
+
+	case FUSE_FALLOCATE | FUSE_PREFILTER:
+	//	bpf_printk("fallocate %d", fa->nodeid);
+		return BPF_FUSE_CONTINUE;
+
+	case FUSE_CANONICAL_PATH | FUSE_PREFILTER: {
+		return BPF_FUSE_CONTINUE;
+	}
+	default:
+		bpf_printk("Unknown opcode: %d", fa->opcode);
+		return BPF_FUSE_CONTINUE;
+	}
+}
+
+SEC("test_simple")
+int trace_simple(struct __bpf_fuse_args *fa)
+{
+	if (fa->opcode & FUSE_PREFILTER)
+		bpf_printk("prefilter opcode: %d",
+			   fa->opcode & FUSE_OPCODE_FILTER);
+	else if (fa->opcode & FUSE_POSTFILTER)
+		bpf_printk("postfilter opcode: %d",
+			   fa->opcode & FUSE_OPCODE_FILTER);
+	else
+		bpf_printk("*** UNKNOWN *** opcode: %d", fa->opcode);
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC("test_passthrough")
+int trace_daemon(struct __bpf_fuse_args *fa)
+{
+	switch (fa->opcode) {
+	case FUSE_LOOKUP | FUSE_PREFILTER: {
+		const char *name = (void *)(long)fa->in_args[0].value;
+
+		bpf_printk("Lookup prefilter: %lx %s", fa->nodeid, name);
+		return BPF_FUSE_POSTFILTER;
+	}
+
+	case FUSE_LOOKUP | FUSE_POSTFILTER: {
+		const char *name = (void *)(long)fa->in_args[0].value;
+		struct fuse_entry_bpf_out *febo = bpf_make_writable_out(fa, 1,
+									fa->out_args[1].value,
+									sizeof(*febo), true);
+
+		if (!febo)
+			return -1;
+		bpf_printk("Lookup postfilter: %lx %s %lu", fa->nodeid, name);
+		febo->bpf_action = FUSE_ACTION_REMOVE;
+
+		return BPF_FUSE_USER_POSTFILTER;
+	}
+
+	default:
+		if (fa->opcode & FUSE_PREFILTER)
+			bpf_printk("prefilter opcode: %d",
+				   fa->opcode & FUSE_OPCODE_FILTER);
+		else if (fa->opcode & FUSE_POSTFILTER)
+			bpf_printk("postfilter opcode: %d",
+				   fa->opcode & FUSE_OPCODE_FILTER);
+		else
+			bpf_printk("*** UNKNOWN *** opcode: %d", fa->opcode);
+		return BPF_FUSE_CONTINUE;
+	}
+}
+
+SEC("test_error")
+
+/* return BPF_FUSE_CONTINUE to use backing fs, BPF_FUSE_USER to pass to usermode */
+int error_test(struct __bpf_fuse_args *fa)
+{
+	switch (fa->opcode) {
+	case FUSE_MKDIR | FUSE_PREFILTER: {
+		bpf_printk("mkdir");
+		return BPF_FUSE_POSTFILTER;
+	}
+	case FUSE_MKDIR | FUSE_POSTFILTER: {
+		bpf_printk("mkdir postfilter");
+		if (fa->error_in == -EEXIST)
+			return -EPERM;
+
+		return 0;
+	}
+
+	case FUSE_LOOKUP | FUSE_PREFILTER: {
+		const char *name = (void *)(long)fa->in_args[0].value;
+
+		bpf_printk("lookup prefilter %s", name);
+		return BPF_FUSE_POSTFILTER;
+	}
+	case FUSE_LOOKUP | FUSE_POSTFILTER: {
+		const char *name = (void *)(long)fa->in_args[0].value;
+		const char *end = (void *)(long)fa->in_args[0].end_offset;
+
+		bpf_printk("lookup postfilter %s %d", name, fa->error_in);
+		if (strcmp_check("doesnotexist", name, end) == 0/* && fa->error_in == -EEXIST*/) {
+			bpf_printk("lookup postfilter doesnotexist");
+			return BPF_FUSE_USER_POSTFILTER;
+		}
+
+		return 0;
+	}
+
+	default:
+		if (fa->opcode & FUSE_PREFILTER)
+			bpf_printk("prefilter opcode: %d",
+				   fa->opcode & FUSE_OPCODE_FILTER);
+		else if (fa->opcode & FUSE_POSTFILTER)
+			bpf_printk("postfilter opcode: %d",
+				   fa->opcode & FUSE_OPCODE_FILTER);
+		else
+			bpf_printk("*** UNKNOWN *** opcode: %d", fa->opcode);
+		return BPF_FUSE_CONTINUE;
+	}
+}
+
+
+SEC("test_readdirplus")
+int readdirplus_test(struct __bpf_fuse_args *fa)
+{
+	switch (fa->opcode) {
+	case FUSE_READDIR | FUSE_PREFILTER: {
+		return BPF_FUSE_USER;
+	}
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC("test_verify")
+
+int verify_test(struct __bpf_fuse_args *fa)
+{
+	if (fa->opcode == (FUSE_MKDIR | FUSE_PREFILTER)) {
+		const char *start;
+		const char *end;
+		const struct fuse_mkdir_in *in;
+
+		start = (void *)(long) fa->in_args[0].value;
+		end = (void *)(long) fa->in_args[0].end_offset;
+		if (start + sizeof(*in) <= end) {
+			in = (struct fuse_mkdir_in *)(start);
+			bpf_printk("test1: %d %d", in->mode, in->umask);
+		}
+
+		return BPF_FUSE_CONTINUE;
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC("test_verify_fail")
+
+int verify_fail_test(struct __bpf_fuse_args *fa)
+{
+	struct t {
+		uint32_t a;
+		uint32_t b;
+		char d[];
+	};
+	if (fa->opcode == (FUSE_MKDIR | FUSE_PREFILTER)) {
+		const char *start;
+		const char *end;
+		const struct t *c;
+
+		start = (void *)(long) fa->in_args[0].value;
+		end = (void *)(long) fa->in_args[0].end_offset;
+		if (start + sizeof(struct t) <= end) {
+			c = (struct t *)start;
+			bpf_printk("test1: %d %d %d", c->a, c->b, c->d[0]);
+		}
+		return BPF_FUSE_CONTINUE;
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC("test_verify_fail2")
+
+int verify_fail_test2(struct __bpf_fuse_args *fa)
+{
+	if (fa->opcode == (FUSE_MKDIR | FUSE_PREFILTER)) {
+		const char *start;
+		const char *end;
+		struct fuse_mkdir_in *c;
+
+		start = (void *)(long) fa->in_args[0].value;
+		end = (void *)(long) fa->in_args[1].end_offset;
+		if (start + sizeof(*c) <= end) {
+			c = (struct fuse_mkdir_in *)start;
+			bpf_printk("test1: %d %d", c->mode, c->umask);
+		}
+		return BPF_FUSE_CONTINUE;
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC("test_verify_fail3")
+/* Cannot write directly to fa */
+int verify_fail_test3(struct __bpf_fuse_args *fa)
+{
+	if (fa->opcode == (FUSE_LOOKUP | FUSE_POSTFILTER)) {
+		const char *name = (void *)(long)fa->in_args[0].value;
+		const char *end = (void *)(long)fa->in_args[0].end_offset;
+		struct fuse_entry_out *feo = fa_verify_out(fa, 0, sizeof(*feo));
+
+		if (!feo)
+			return -1;
+
+		if (strcmp_check("real", name, end) == 0)
+			feo->nodeid = 5;
+		else if (strcmp_check("partial", name, end) == 0)
+			feo->nodeid = 6;
+
+		bpf_printk("post-lookup %s %d", name, feo->nodeid);
+		return BPF_FUSE_CONTINUE;
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC("test_verify_fail4")
+/* Cannot write outside of requested area */
+int verify_fail_test4(struct __bpf_fuse_args *fa)
+{
+	if (fa->opcode == (FUSE_LOOKUP | FUSE_POSTFILTER)) {
+		const char *name = (void *)(long)fa->in_args[0].value;
+		const char *end = (void *)(long)fa->in_args[0].end_offset;
+		struct fuse_entry_out *feo = bpf_make_writable_out(fa, 0, fa->out_args[0].value,
+								   1, true);
+
+		if (!feo)
+			return -1;
+
+		if (strcmp_check("real", name, end) == 0)
+			feo->nodeid = 5;
+		else if (strcmp_check("partial", name, end) == 0)
+			feo->nodeid = 6;
+
+		bpf_printk("post-lookup %s %d", name, feo->nodeid);
+		return BPF_FUSE_CONTINUE;
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC("test_verify_fail5")
+/* Cannot use old verification after requesting writable */
+int verify_fail_test5(struct __bpf_fuse_args *fa)
+{
+	if (fa->opcode == (FUSE_LOOKUP | FUSE_POSTFILTER)) {
+		struct fuse_entry_out *feo;
+		struct fuse_entry_out *feo_w;
+
+		feo = fa_verify_out(fa, 0, sizeof(*feo));
+		if (!feo)
+			return -1;
+
+		feo_w = bpf_make_writable_out(fa, 0, fa->out_args[0].value, sizeof(*feo_w), true);
+		bpf_printk("post-lookup %d", feo->nodeid);
+		if (!feo_w)
+			return -1;
+
+		feo_w->nodeid = 5;
+
+		return BPF_FUSE_CONTINUE;
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC("test_verify5")
+/* Can use new verification after requesting writable */
+int verify_pass_test5(struct __bpf_fuse_args *fa)
+{
+	if (fa->opcode == (FUSE_LOOKUP | FUSE_POSTFILTER)) {
+		struct fuse_entry_out *feo;
+		struct fuse_entry_out *feo_w;
+
+		feo = fa_verify_out(fa, 0, sizeof(*feo));
+		if (!feo)
+			return -1;
+
+		bpf_printk("post-lookup %d", feo->nodeid);
+
+		feo_w = bpf_make_writable_out(fa, 0, fa->out_args[0].value, sizeof(*feo_w), true);
+
+		feo = fa_verify_out(fa, 0, sizeof(*feo));
+		if (feo)
+			bpf_printk("post-lookup %d", feo->nodeid);
+		if (!feo_w)
+			return -1;
+
+		feo_w->nodeid = 5;
+
+		return BPF_FUSE_CONTINUE;
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC("test_verify_fail6")
+/* Reading context from a nonsense offset is not allowed */
+int verify_pass_test6(struct __bpf_fuse_args *fa)
+{
+	char *nonsense = (char *)fa;
+
+	bpf_printk("post-lookup %d", nonsense[1]);
+
+	return BPF_FUSE_CONTINUE;
+}
diff --git a/tools/testing/selftests/filesystems/fuse/test_framework.h b/tools/testing/selftests/filesystems/fuse/test_framework.h
new file mode 100644
index 000000000000..2e376c0f2994
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/test_framework.h
@@ -0,0 +1,173 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Google LLC
+ */
+
+#ifndef _TEST_FRAMEWORK_H
+#define _TEST_FRAMEWORK_H
+
+#include <stdbool.h>
+#include <stdio.h>
+
+#ifdef __ANDROID__
+static int test_case_pass;
+static int test_case_fail;
+#define ksft_print_msg			printf
+#define ksft_test_result_pass(...)	({test_case_pass++; printf(__VA_ARGS__); })
+#define ksft_test_result_fail(...)	({test_case_fail++; printf(__VA_ARGS__); })
+#define ksft_exit_fail_msg(...)		printf(__VA_ARGS__)
+#define ksft_print_header()
+#define ksft_set_plan(cnt)
+#define ksft_get_fail_cnt()		test_case_fail
+#define ksft_exit_pass()		0
+#define ksft_exit_fail()		1
+#else
+#include <kselftest.h>
+#endif
+
+#define TEST_FAILURE 1
+#define TEST_SUCCESS 0
+
+#define ptr_to_u64(p) ((__u64)p)
+
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define le16_to_cpu(x)          (x)
+#define le32_to_cpu(x)          (x)
+#define le64_to_cpu(x)          (x)
+#else
+#error Big endian not supported!
+#endif
+
+struct _test_options {
+	int file;
+	int test;
+	bool verbose;
+};
+
+extern struct _test_options test_options;
+
+#define TESTCOND(condition)						\
+	do {								\
+		if (!(condition)) {					\
+			ksft_print_msg("%s failed %d\n",		\
+				       __func__, __LINE__);		\
+			goto out;					\
+		} else if (test_options.verbose)			\
+			ksft_print_msg("%s succeeded %d\n",		\
+				       __func__, __LINE__);		\
+	} while (false)
+
+#define TESTCONDERR(condition)						\
+	do {								\
+		if (!(condition)) {					\
+			ksft_print_msg("%s failed %d\n",		\
+				       __func__, __LINE__);		\
+			ksft_print_msg("Error %d (\"%s\")\n",		\
+				       errno, strerror(errno));		\
+			goto out;					\
+		} else if (test_options.verbose)			\
+			ksft_print_msg("%s succeeded %d\n",		\
+				       __func__, __LINE__);		\
+	} while (false)
+
+#define TEST(statement, condition)					\
+	do {								\
+		statement;						\
+		TESTCOND(condition);					\
+	} while (false)
+
+#define TESTERR(statement, condition)					\
+	do {								\
+		statement;						\
+		TESTCONDERR(condition);					\
+	} while (false)
+
+enum _operator {
+	_eq,
+	_ne,
+	_ge,
+};
+
+static const char * const _operator_name[] = {
+	"==",
+	"!=",
+	">=",
+};
+
+#define _TEST_OPERATOR(name, _type, format_specifier)			\
+static inline int _test_operator_##name(const char *func, int line,	\
+				_type a, _type b, enum _operator o)	\
+{									\
+	bool pass;							\
+	switch (o) {							\
+	case _eq: pass = a == b; break;					\
+	case _ne: pass = a != b; break;					\
+	case _ge: pass = a >= b; break;					\
+	}								\
+									\
+	if (!pass)							\
+		ksft_print_msg("Failed: %s at line %d, "		\
+			       format_specifier " %s "			\
+			       format_specifier	"\n",			\
+			       func, line, a, _operator_name[o], b);	\
+	else if (test_options.verbose)					\
+		ksft_print_msg("Passed: %s at line %d, "		\
+			       format_specifier " %s "			\
+			       format_specifier "\n",			\
+			       func, line, a, _operator_name[o], b);	\
+									\
+	return pass ? TEST_SUCCESS : TEST_FAILURE;			\
+}
+
+_TEST_OPERATOR(i, int, "%d")
+_TEST_OPERATOR(ui, unsigned int, "%u")
+_TEST_OPERATOR(lui, unsigned long, "%lu")
+_TEST_OPERATOR(ss, ssize_t, "%zd")
+_TEST_OPERATOR(vp, void *, "%px")
+_TEST_OPERATOR(cp, char *, "%px")
+
+#define _CALL_TO(_type, name, a, b, o)					\
+	_type:_test_operator_##name(__func__, __LINE__,			\
+				  (_type) (long long) (a),		\
+				  (_type) (long long) (b), o)
+
+#define TESTOPERATOR(a, b, o)						\
+	do {								\
+		if (_Generic((a),					\
+			     _CALL_TO(int, i, a, b, o),			\
+			     _CALL_TO(unsigned int, ui, a, b, o),	\
+			     _CALL_TO(unsigned long, lui, a, b, o),	\
+			     _CALL_TO(ssize_t, ss, a, b, o),		\
+			     _CALL_TO(void *, vp, a, b, o),		\
+			     _CALL_TO(char *, cp, a, b, o)		\
+		))							\
+			goto out;					\
+	} while (false)
+
+#define TESTEQUAL(a, b) TESTOPERATOR(a, b, _eq)
+#define TESTNE(a, b) TESTOPERATOR(a, b, _ne)
+#define TESTGE(a, b) TESTOPERATOR(a, b, _ge)
+
+/* For testing a syscall that returns 0 on success and sets errno otherwise */
+#define TESTSYSCALL(statement) TESTCONDERR((statement) == 0)
+
+static inline void print_bytes(const void *data, size_t size)
+{
+	const char *bytes = data;
+	int i;
+
+	for (i = 0; i < size; ++i) {
+		if (i % 0x10 == 0)
+			printf("%08x:", i);
+		printf("%02x ", (unsigned int) (unsigned char) bytes[i]);
+		if (i % 0x10 == 0x0f)
+			printf("\n");
+	}
+
+	if (i % 0x10 != 0)
+		printf("\n");
+}
+
+
+
+#endif
diff --git a/tools/testing/selftests/filesystems/fuse/test_fuse.h b/tools/testing/selftests/filesystems/fuse/test_fuse.h
new file mode 100644
index 000000000000..a1ef10af079b
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/test_fuse.h
@@ -0,0 +1,328 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Google LLC
+ */
+
+#ifndef TEST_FUSE__H
+#define TEST_FUSE__H
+
+#define _GNU_SOURCE
+
+#include "test_framework.h"
+
+#include <dirent.h>
+#include <sys/stat.h>
+#include <sys/statfs.h>
+#include <sys/types.h>
+
+#include <uapi/linux/fuse.h>
+
+#define PAGE_SIZE 4096
+#define FUSE_POSTFILTER 0x20000
+
+extern struct _test_options test_options;
+
+/* Slow but semantically easy string functions */
+
+/*
+ * struct s just wraps a char pointer
+ * It is a pointer to a malloc'd string, or null
+ * All consumers handle null input correctly
+ * All consumers free the string
+ */
+struct s {
+	char *s;
+};
+
+struct s s(const char *s1);
+struct s sn(const char *s1, const char *s2);
+int s_cmp(struct s s1, struct s s2);
+struct s s_cat(struct s s1, struct s s2);
+struct s s_splitleft(struct s s1, char c);
+struct s s_splitright(struct s s1, char c);
+struct s s_word(struct s s1, char c, size_t n);
+struct s s_path(struct s s1, struct s s2);
+struct s s_pathn(size_t n, struct s s1, ...);
+int s_link(struct s src_pathname, struct s dst_pathname);
+int s_symlink(struct s src_pathname, struct s dst_pathname);
+int s_mkdir(struct s pathname, mode_t mode);
+int s_rmdir(struct s pathname);
+int s_unlink(struct s pathname);
+int s_open(struct s pathname, int flags, ...);
+int s_openat(int dirfd, struct s pathname, int flags, ...);
+int s_creat(struct s pathname, mode_t mode);
+int s_mkfifo(struct s pathname, mode_t mode);
+int s_stat(struct s pathname, struct stat *st);
+int s_statfs(struct s pathname, struct statfs *st);
+int s_fuse_attr(struct s pathname, struct fuse_attr *fuse_attr_out);
+DIR *s_opendir(struct s pathname);
+int s_getxattr(struct s pathname, const char name[], void *value, size_t size,
+	       ssize_t *ret_size);
+int s_listxattr(struct s pathname, void *list, size_t size, ssize_t *ret_size);
+int s_setxattr(struct s pathname, const char name[], const void *value,
+	       size_t size, int flags);
+int s_removexattr(struct s pathname, const char name[]);
+int s_rename(struct s oldpathname, struct s newpathname);
+
+struct s tracing_folder(void);
+int tracing_on(void);
+
+char *concat_file_name(const char *dir, const char *file);
+char *setup_mount_dir(const char *name);
+int delete_dir_tree(const char *dir_path, bool remove_root);
+
+#define TESTFUSEINNULL(_opcode)						\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		ssize_t res = read(fuse_dev, &bytes_in,			\
+			sizeof(bytes_in));				\
+									\
+		TESTEQUAL(in_header->opcode, _opcode);			\
+		TESTEQUAL(res, sizeof(*in_header));			\
+	} while (false)
+
+#define TESTFUSEIN(_opcode, in_struct)					\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		ssize_t res = read(fuse_dev, &bytes_in,			\
+			sizeof(bytes_in));				\
+									\
+		TESTEQUAL(in_header->opcode, _opcode);			\
+		TESTEQUAL(res, sizeof(*in_header) + sizeof(*in_struct));\
+	} while (false)
+
+#define TESTFUSEIN2(_opcode, in_struct1, in_struct2)			\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		ssize_t res = read(fuse_dev, &bytes_in,			\
+			sizeof(bytes_in));				\
+									\
+		TESTEQUAL(in_header->opcode, _opcode);			\
+		TESTEQUAL(res, sizeof(*in_header) + sizeof(*in_struct1) \
+						+ sizeof(*in_struct2)); \
+		in_struct1 = (void *)(bytes_in + sizeof(*in_header));	\
+		in_struct2 = (void *)(bytes_in + sizeof(*in_header)	\
+				      + sizeof(*in_struct1));		\
+	} while (false)
+
+#define TESTFUSEINEXT(_opcode, in_struct, extra)			\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		ssize_t res = read(fuse_dev, &bytes_in,			\
+			sizeof(bytes_in));				\
+									\
+		TESTEQUAL(in_header->opcode, _opcode);			\
+		TESTEQUAL(res,						\
+		       sizeof(*in_header) + sizeof(*in_struct) + extra);\
+	} while (false)
+
+#define TESTFUSEINUNKNOWN()						\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		ssize_t res = read(fuse_dev, &bytes_in,			\
+			sizeof(bytes_in));				\
+									\
+		TESTGE(res, sizeof(*in_header));			\
+		TESTEQUAL(in_header->opcode, -1);			\
+	} while (false)
+
+/* Special case lookup since it is asymmetric */
+#define TESTFUSELOOKUP(expected, filter)				\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		char *name = (char *) (bytes_in + sizeof(*in_header));	\
+		ssize_t res;						\
+									\
+		TEST(res = read(fuse_dev, &bytes_in, sizeof(bytes_in)),	\
+			  res != -1);					\
+		/* TODO once we handle forgets properly, remove */	\
+		if (in_header->opcode == FUSE_FORGET)			\
+			continue;					\
+		if (in_header->opcode == FUSE_BATCH_FORGET)		\
+			continue;					\
+		TESTGE(res, sizeof(*in_header));			\
+		TESTEQUAL(in_header->opcode,				\
+			FUSE_LOOKUP | filter);				\
+		TESTEQUAL(res,						\
+			  sizeof(*in_header) + strlen(expected) + 1 +	\
+				(filter == FUSE_POSTFILTER ?		\
+				sizeof(struct fuse_entry_out) +		\
+				sizeof(struct fuse_entry_bpf_out) : 0));\
+		TESTCOND(!strcmp(name, expected));			\
+		break;							\
+	} while (true)
+
+#define TESTFUSEOUTEMPTY()						\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		struct fuse_out_header *out_header =			\
+			(struct fuse_out_header *)bytes_out;		\
+									\
+		*out_header = (struct fuse_out_header) {		\
+			.len = sizeof(*out_header),			\
+			.unique = in_header->unique,			\
+		};							\
+		TESTEQUAL(write(fuse_dev, bytes_out, out_header->len),	\
+			  out_header->len);				\
+	} while (false)
+
+#define TESTFUSEOUTERROR(errno)						\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		struct fuse_out_header *out_header =			\
+			(struct fuse_out_header *)bytes_out;		\
+									\
+		*out_header = (struct fuse_out_header) {		\
+			.len = sizeof(*out_header),			\
+			.error = errno,					\
+			.unique = in_header->unique,			\
+		};							\
+		TESTEQUAL(write(fuse_dev, bytes_out, out_header->len),	\
+			  out_header->len);				\
+	} while (false)
+
+#define TESTFUSEOUTREAD(data, length)					\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		struct fuse_out_header *out_header =			\
+			(struct fuse_out_header *)bytes_out;		\
+									\
+		*out_header = (struct fuse_out_header) {		\
+			.len = sizeof(*out_header) + length,		\
+			.unique = in_header->unique,			\
+		};							\
+		memcpy(bytes_out + sizeof(*out_header), data, length);	\
+		TESTEQUAL(write(fuse_dev, bytes_out, out_header->len),	\
+			  out_header->len);				\
+	} while (false)
+
+#define TESTFUSEDIROUTREAD(read_out, data, length)			\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		struct fuse_out_header *out_header =			\
+			(struct fuse_out_header *)bytes_out;		\
+									\
+		*out_header = (struct fuse_out_header) {		\
+			.len = sizeof(*out_header) +			\
+			       sizeof(*read_out) + length,		\
+			.unique = in_header->unique,			\
+		};							\
+		memcpy(bytes_out + sizeof(*out_header) +		\
+				sizeof(*read_out), data, length);	\
+		memcpy(bytes_out + sizeof(*out_header),			\
+				read_out, sizeof(*read_out));		\
+		TESTEQUAL(write(fuse_dev, bytes_out, out_header->len),	\
+			  out_header->len);				\
+	} while (false)
+
+#define TESTFUSEOUT1(type1, obj1)					\
+	do {								\
+		*(struct fuse_out_header *) bytes_out			\
+			= (struct fuse_out_header) {			\
+			.len = sizeof(struct fuse_out_header)		\
+				+ sizeof(struct type1),			\
+			.unique = ((struct fuse_in_header *)		\
+				   bytes_in)->unique,			\
+		};							\
+		*(struct type1 *) (bytes_out				\
+			+ sizeof(struct fuse_out_header))		\
+			= obj1;						\
+		TESTEQUAL(write(fuse_dev, bytes_out,			\
+			((struct fuse_out_header *)bytes_out)->len),	\
+			((struct fuse_out_header *)bytes_out)->len);	\
+	} while (false)
+
+#define TESTFUSEOUT2(type1, obj1, type2, obj2)				\
+	do {								\
+		*(struct fuse_out_header *) bytes_out			\
+			= (struct fuse_out_header) {			\
+			.len = sizeof(struct fuse_out_header)		\
+				+ sizeof(struct type1)			\
+				+ sizeof(struct type2),			\
+			.unique = ((struct fuse_in_header *)		\
+				   bytes_in)->unique,			\
+		};							\
+		*(struct type1 *) (bytes_out				\
+			+ sizeof(struct fuse_out_header))		\
+			= obj1;						\
+		*(struct type2 *) (bytes_out				\
+			+ sizeof(struct fuse_out_header)		\
+			+ sizeof(struct type1))				\
+			= obj2;						\
+		TESTEQUAL(write(fuse_dev, bytes_out,			\
+			((struct fuse_out_header *)bytes_out)->len),	\
+			((struct fuse_out_header *)bytes_out)->len);	\
+	} while (false)
+
+#define TESTFUSEINITFLAGS(fuse_connection_flags)			\
+	do {								\
+		DECL_FUSE_IN(init);					\
+									\
+		TESTFUSEIN(FUSE_INIT, init_in);				\
+		TESTEQUAL(init_in->major, FUSE_KERNEL_VERSION);		\
+		TESTEQUAL(init_in->minor, FUSE_KERNEL_MINOR_VERSION);	\
+		TESTFUSEOUT1(fuse_init_out, ((struct fuse_init_out) {	\
+			.major = FUSE_KERNEL_VERSION,			\
+			.minor = FUSE_KERNEL_MINOR_VERSION,		\
+			.max_readahead = 4096,				\
+			.flags = fuse_connection_flags,			\
+			.max_background = 0,				\
+			.congestion_threshold = 0,			\
+			.max_write = 4096,				\
+			.time_gran = 1000,				\
+			.max_pages = 12,				\
+			.map_alignment = 4096,				\
+		}));							\
+	} while (false)
+
+#define TESTFUSEINIT()							\
+	TESTFUSEINITFLAGS(0)
+
+#define DECL_FUSE_IN(name)						\
+	struct fuse_##name##_in *name##_in =				\
+		(struct fuse_##name##_in *)				\
+		(bytes_in + sizeof(struct fuse_in_header))
+
+#define DECL_FUSE(name)							\
+	struct fuse_##name##_in *name##_in __attribute__((unused));	\
+	struct fuse_##name##_out *name##_out __attribute__((unused))
+
+#define FUSE_ACTION	TEST(pid = fork(), pid != -1);			\
+			if (pid) {
+
+#define FUSE_DAEMON	} else {					\
+				uint8_t bytes_in[FUSE_MIN_READ_BUFFER]	\
+					__attribute__((unused));	\
+				uint8_t bytes_out[FUSE_MIN_READ_BUFFER]	\
+					__attribute__((unused));
+
+#define FUSE_DONE		exit(TEST_SUCCESS);			\
+			}						\
+			TESTEQUAL(waitpid(pid, &status, 0), pid);	\
+			TESTEQUAL(status, TEST_SUCCESS);
+
+struct map_relocation {
+	char *name;
+	int fd;
+	int value;
+};
+
+int mount_fuse(const char *mount_dir, int bpf_fd, int dir_fd,
+	       int *fuse_dev_ptr);
+int mount_fuse_no_init(const char *mount_dir, int bpf_fd, int dir_fd,
+	       int *fuse_dev_ptr);
+int install_elf_bpf(const char *file, const char *section, int *fd,
+		    struct map_relocation **map_relocations, size_t *map_count);
+int install_elf_bpf_invalid(const char *file, const char *section, int *fd,
+		    struct map_relocation **map_relocations, size_t *map_count);
+#endif
-- 
2.37.3.998.g577e59143f-goog

