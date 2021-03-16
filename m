Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9042033DDC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbhCPTnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbhCPTn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:43:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0729DC061762
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:43:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so44596pjv.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wOzOexxh6K3lYODZ8jI9EEnEZh21pj9q225heAgUYAk=;
        b=VcgF5lqXgwqlIvnI2b+iFl28XYaMgNlQ3oFlYxsoSqbOADlPHz+Bg+o8e4DyReTNZ1
         Ft/GohDyYTcIU8u7RNDqJwFNyp89zf6N5P9Tq3/FBWf9l7dXdVH4H8u6jSzScXhMeNaE
         tNpo7KccLvaC4mrs327aQVZNBxT1Yw6qGHhiB2Vh8FrfIw/Gc66aKWO8T8Gy4IEQ71LP
         Z3VwquHMMsZdEfW5cOtTq9EV2DFVi8Tjheb2aRpQGLOhfU1RUrThw+07uUd8fl2Q8veN
         9lDIkdzQpKysISlnfxQV1ao2OneoeXKfDzX1AT+lJEm0f0jxVEzUQWkdt70NMipgZVhF
         W0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wOzOexxh6K3lYODZ8jI9EEnEZh21pj9q225heAgUYAk=;
        b=bLZltQIo89178uJvl2ZIY2SxcRkicKATmWDnlPeuHbCTgHl68x5MjKKPdhCmao1Jnq
         bOFNueTckFWJSDWxm/FPTStglpUfIxL7dnhYHJctq/XZJ6oCpffm0/W4ttP68C2Q/n29
         FKgGaoRvDWzaiS7ck0t2K3XoXvkMmP1oKiOu5m1oA1r+O6iNIk5IZJP6Pq/t0k5xr2Yp
         gvQBBTzz3wMhHy7+pw7nbCNtb801pdwJwi+DGjNwGh+uhZd+4ccr4h0fy0NFDwRDwQPp
         Juum3YGk9EYtcwBq2kDrCpgTRbg49Ln+QFvbUfKy/J9Tmmd+STwSQMwCiuGuqFiThvv0
         hK9g==
X-Gm-Message-State: AOAM531fFYRySxveVn5OL31DNAJa/Lstq4SAiU9VW4hLfomtsQgU9H4u
        mb7WCDf5gvoWWeCFBq0KvJOMObQk7uGXXQ==
X-Google-Smtp-Source: ABdhPJwGGUQSdlfOfYizuKGoptlme17/kcBDnkjCzzxzZMVw267/sPERgVz6ho+pKPv1Iwh4GuSwfA==
X-Received: by 2002:a17:90a:67cf:: with SMTP id g15mr633551pjm.208.1615923806562;
        Tue, 16 Mar 2021 12:43:26 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id gm10sm217264pjb.4.2021.03.16.12.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:43:25 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH man-pages v8] Document encoded I/O
Date:   Tue, 16 Mar 2021 12:42:56 -0700
Message-Id: <03cb1c219989868f064782cb0b9c1011af8a0a9e.1615923241.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922644.git.osandov@fb.com>
References: <cover.1615922644.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This adds a new page, encoded_io(7), providing an overview of encoded
I/O and updates fcntl(2), open(2), and preadv2(2)/pwritev2(2) to
reference it.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 man2/fcntl.2      |   8 +
 man2/open.2       |  13 ++
 man2/readv.2      |  69 +++++++++
 man7/encoded_io.7 | 369 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 459 insertions(+)
 create mode 100644 man7/encoded_io.7

diff --git a/man2/fcntl.2 b/man2/fcntl.2
index a15f467ef..1081cb70f 100644
--- a/man2/fcntl.2
+++ b/man2/fcntl.2
@@ -217,6 +217,7 @@ in
 .I arg
 are ignored.
 On Linux, this command can change only the
+.BR O_ALLOW_ENCODED ,
 .BR O_APPEND ,
 .BR O_ASYNC ,
 .BR O_DIRECT ,
@@ -1815,6 +1816,13 @@ and the soft or hard user pipe limit has been reached; see
 .BR pipe (7).
 .TP
 .B EPERM
+Attempted to set the
+.B O_ALLOW_ENCODED
+flag and the calling process did not have the
+.B CAP_SYS_ADMIN
+capability.
+.TP
+.B EPERM
 Attempted to clear the
 .B O_APPEND
 flag on a file that has the append-only attribute set.
diff --git a/man2/open.2 b/man2/open.2
index 03fff1b65..0456a173b 100644
--- a/man2/open.2
+++ b/man2/open.2
@@ -180,6 +180,14 @@ for details.
 .PP
 The full list of file creation flags and file status flags is as follows:
 .TP
+.B O_ALLOW_ENCODED
+Open the file with encoded I/O permissions;
+see
+.BR encoded_io (7).
+The caller must have the
+.B CAP_SYS_ADMIN
+capability.
+.TP
 .B O_APPEND
 The file is opened in append mode.
 Before each
@@ -1232,6 +1240,11 @@ did not match the owner of the file and the caller was not privileged.
 The operation was prevented by a file seal; see
 .BR fcntl (2).
 .TP
+.B EPERM
+The
+.B O_ALLOW_ENCODED
+flag was specified, but the caller was not privileged.
+.TP
 .B EROFS
 .I pathname
 refers to a file on a read-only filesystem and write access was
diff --git a/man2/readv.2 b/man2/readv.2
index 472adcf73..c7aec9fa7 100644
--- a/man2/readv.2
+++ b/man2/readv.2
@@ -263,6 +263,11 @@ the data is always appended to the end of the file.
 However, if the
 .I offset
 argument is \-1, the current file offset is updated.
+.TP
+.BR RWF_ENCODED " (since Linux 5.13)"
+Read or write encoded (e.g., compressed) data.
+See
+.BR encoded_io (7).
 .SH RETURN VALUE
 On success,
 .BR readv (),
@@ -282,6 +287,12 @@ than requested (see
 and
 .BR write (2)).
 .PP
+If
+.B RWF_ENCODED
+was specified in
+.IR flags ,
+then the return value is the number of encoded bytes.
+.PP
 On error, \-1 is returned, and \fIerrno\fP is set to indicate the error.
 .SH ERRORS
 The errors are as given for
@@ -312,6 +323,64 @@ is less than zero or greater than the permitted maximum.
 .TP
 .B EOPNOTSUPP
 An unknown flag is specified in \fIflags\fP.
+.TP
+.B EOPNOTSUPP
+.B RWF_ENCODED
+is specified in
+.I flags
+and the filesystem does not implement encoded I/O.
+.TP
+.B EPERM
+.B RWF_ENCODED
+is specified in
+.I flags
+and the file was not opened with the
+.B O_ALLOW_ENCODED
+flag.
+.PP
+.BR preadv2 ()
+can additionally fail for the following reasons:
+.TP
+.B E2BIG
+.B RWF_ENCODED
+is specified in
+.I flags
+and
+.I iov[0]
+is not large enough to return the encoding metadata.
+.TP
+.B ENOBUFS
+.B RWF_ENCODED
+is specified in
+.I flags
+and the buffers in
+.I iov
+are not big enough to return the encoded data.
+.PP
+.BR pwritev2 ()
+can additionally fail for the following reasons:
+.TP
+.B E2BIG
+.B RWF_ENCODED
+is specified in
+.I flags
+and
+.I iov[0]
+contains non-zero fields
+after the kernel's
+.IR "sizeof(struct encoded_iov)" .
+.TP
+.B EINVAL
+.B RWF_ENCODED
+is specified in
+.I flags
+and the encoding is unknown or not supported by the filesystem.
+.TP
+.B EINVAL
+.B RWF_ENCODED
+is specified in
+.I flags
+and the alignment and/or size requirements are not met.
 .SH VERSIONS
 .BR preadv ()
 and
diff --git a/man7/encoded_io.7 b/man7/encoded_io.7
new file mode 100644
index 000000000..1f5e6a510
--- /dev/null
+++ b/man7/encoded_io.7
@@ -0,0 +1,369 @@
+.\" Copyright (c) 2020 by Omar Sandoval <osandov@fb.com>
+.\"
+.\" %%%LICENSE_START(VERBATIM)
+.\" Permission is granted to make and distribute verbatim copies of this
+.\" manual provided the copyright notice and this permission notice are
+.\" preserved on all copies.
+.\"
+.\" Permission is granted to copy and distribute modified versions of this
+.\" manual under the conditions for verbatim copying, provided that the
+.\" entire resulting derived work is distributed under the terms of a
+.\" permission notice identical to this one.
+.\"
+.\" Since the Linux kernel and libraries are constantly changing, this
+.\" manual page may be incorrect or out-of-date.  The author(s) assume no
+.\" responsibility for errors or omissions, or for damages resulting from
+.\" the use of the information contained herein.  The author(s) may not
+.\" have taken the same level of care in the production of this manual,
+.\" which is licensed free of charge, as they might when working
+.\" professionally.
+.\"
+.\" Formatted or processed versions of this manual, if unaccompanied by
+.\" the source, must acknowledge the copyright and authors of this work.
+.\" %%%LICENSE_END
+.\"
+.\"
+.TH ENCODED_IO  7 2020-11-11 "Linux" "Linux Programmer's Manual"
+.SH NAME
+encoded_io \- overview of encoded I/O
+.SH DESCRIPTION
+Several filesystems (e.g., Btrfs) support transparent encoding
+(e.g., compression, encryption) of data on disk:
+written data is encoded by the kernel before it is written to disk,
+and read data is decoded before being returned to the user.
+In some cases, it is useful to skip this encoding step.
+For example, the user may want to read the compressed contents of a file
+or write pre-compressed data directly to a file.
+This is referred to as "encoded I/O".
+.SS Encoded I/O API
+Encoded I/O is specified with the
+.B RWF_ENCODED
+flag to
+.BR preadv2 (2)
+and
+.BR pwritev2 (2).
+If
+.B RWF_ENCODED
+is specified, then
+.I iov[0].iov_base
+points to an
+.I encoded_iov
+structure, defined in
+.I <linux/fs.h>
+as:
+.PP
+.in +4n
+.EX
+struct encoded_iov {
+    __aligned_u64 len;
+    __aligned_u64 unencoded_len;
+    __aligned_u64 unencoded_offset;
+    __u32 compression;
+    __u32 encryption;
+};
+.EE
+.in
+.PP
+This may be extended in the future, so
+.I iov[0].iov_len
+must be set to
+.I sizeof(struct encoded_iov)
+for forward/backward compatibility.
+The remaining buffers contain the encoded data.
+.PP
+.I compression
+and
+.I encryption
+are the encoding fields.
+.I compression
+is
+.B ENCODED_IOV_COMPRESSION_NONE
+(zero)
+or a filesystem-specific
+.B ENCODED_IOV_COMPRESSION_*
+constant;
+see
+.B "Filesystem support"
+below.
+.I encryption
+is currently always
+.B ENCODED_IOV_ENCRYPTION_NONE
+(zero).
+.PP
+.I unencoded_len
+is the length of the unencoded (i.e., decrypted and decompressed) data.
+.I unencoded_offset
+is the offset from the first byte of the unencoded data
+to the first byte of logical data in the file
+(less than or equal to
+.IR unencoded_len ).
+.I len
+is the length of the data in the file
+(less than or equal to
+.I unencoded_len
+-
+.IR unencoded_offset ).
+See
+.B Extent layout
+below for some examples.
+.PP
+If the unencoded data is actually longer than
+.IR unencoded_len ,
+then it is truncated;
+if it is shorter, then it is extended with zeroes.
+.PP
+.BR pwritev2 (2)
+uses the metadata specified in
+.IR iov[0] ,
+writes the encoded data from the remaining buffers,
+and returns the number of encoded bytes written
+(that is, the sum of
+.I iov[n].iov_len
+for 1 <=
+.I n
+<
+.IR iovcnt ;
+partial writes will not occur).
+At least one encoding field must be non-zero.
+Note that the encoded data is not validated when it is written;
+if it is not valid (e.g., it cannot be decompressed),
+then a subsequent read may return an error.
+If the
+.I offset
+argument to
+.BR pwritev2 (2)
+is -1, then the file offset is incremented by
+.IR len .
+If
+.I iov[0].iov_len
+is less than
+.I sizeof(struct encoded_iov)
+in the kernel,
+then any fields unknown to user space are treated as if they were zero;
+if it is greater and any fields unknown to the kernel are non-zero,
+then this returns -1 and sets
+.I errno
+to
+.BR E2BIG .
+.PP
+.BR preadv2 (2)
+populates the metadata in
+.IR iov[0] ,
+the encoded data in the remaining buffers,
+and returns the number of encoded bytes read.
+This will only return one extent per call.
+This can also read data which is not encoded;
+all encoding fields will be zero in that case.
+If the
+.I offset
+argument to
+.BR preadv2 (2)
+is -1, then the file offset is incremented by
+.IR len .
+If
+.I iov[0].iov_len
+is less than
+.I sizeof(struct encoded_iov)
+in the kernel and any fields unknown to user space are non-zero,
+then
+.BR preadv2 (2)
+returns -1 and sets
+.I errno
+to
+.BR E2BIG ;
+if it is greater,
+then any fields unknown to the kernel are returned as zero.
+If the provided buffers are not large enough
+to return an entire encoded extent,
+then
+.BR preadv2 (2)
+returns -1 and sets
+.I errno
+to
+.BR ENOBUFS .
+.PP
+As the filesystem page cache typically contains decoded data,
+encoded I/O bypasses the page cache.
+.SS Extent layout
+By using
+.IR len ,
+.IR unencoded_len ,
+and
+.IR unencoded_offset ,
+it is possible to refer to a subset of an unencoded extent.
+.PP
+In the simplest case,
+.I len
+is equal to
+.I unencoded_len
+and
+.I unencoded_offset
+is zero.
+This means that the entire unencoded extent is used.
+.PP
+However, suppose we read 50 bytes into a file
+which contains a single compressed extent.
+The filesystem must still return the entire compressed extent
+for us to be able to decompress it,
+so
+.I unencoded_len
+would be the length of the entire decompressed extent.
+However, because the read was at offset 50,
+the first 50 bytes should be ignored.
+Therefore,
+.I unencoded_offset
+would be 50,
+and
+.I len
+would accordingly be
+.I unencoded_len
+- 50.
+.PP
+Additionally, suppose we want to create an encrypted file with length 500,
+but the file is encrypted with a block cipher using a block size of 4096.
+The unencoded data would therefore include the appropriate padding,
+and
+.I unencoded_len
+would be 4096.
+However, to represent the logical size of the file,
+.I len
+would be 500
+(and
+.I unencoded_offset
+would be 0).
+.PP
+Similar situations can arise in other cases:
+.IP * 3
+If the filesystem pads data to the filesystem block size before compressing,
+then compressed files with a size unaligned to the filesystem block size
+will end with an extent with
+.I len
+<
+.IR unencoded_len .
+.IP *
+Extents cloned from the middle of a larger encoded extent with
+.B FICLONERANGE
+may have a non-zero
+.I unencoded_offset
+and/or
+.I len
+<
+.IR unencoded_len .
+.IP *
+If the middle of an encoded extent is overwritten,
+the filesystem may create extents with a non-zero
+.I unencoded_offset
+and/or
+.I len
+<
+.I unencoded_len
+for the parts that were not overwritten.
+.SS Security
+Encoded I/O creates the potential for some security issues:
+.IP * 3
+Encoded writes allow writing arbitrary data
+which the kernel will decode on a subsequent read.
+Decompression algorithms are complex
+and may have bugs which can be exploited by maliciously crafted data.
+.IP *
+Encoded reads may return data which is not logically present in the file
+(see the discussion of
+.I len
+vs
+.I unencoded_len
+above).
+It may not be intended for this data to be readable.
+.PP
+Therefore, encoded I/O requires privilege.
+Namely, the
+.B RWF_ENCODED
+flag may only be used if the file description has the
+.B O_ALLOW_ENCODED
+file status flag set,
+and the
+.B O_ALLOW_ENCODED
+flag may only be set by a thread with the
+.B CAP_SYS_ADMIN
+capability.
+The
+.B O_ALLOW_ENCODED
+flag can be set by
+.BR open (2)
+or
+.BR fcntl (2).
+It can also be cleared by
+.BR fcntl (2);
+clearing it does not require
+.B CAP_SYS_ADMIN.
+Note that it is not cleared on
+.BR fork (2)
+or
+.BR execve (2).
+One may wish to use
+.B O_CLOEXEC
+with
+.BR O_ALLOW_ENCODED .
+.SS Filesystem support
+Encoded I/O is supported on the following filesystems:
+.TP
+Btrfs (since Linux 5.13)
+.IP
+Btrfs supports encoded reads and writes of compressed data.
+The data is encoded as follows:
+.RS
+.IP * 3
+If
+.I compression
+is
+.BR ENCODED_IOV_COMPRESSION_BTRFS_ZLIB ,
+then the encoded data is a single zlib stream.
+.IP *
+If
+.I compression
+is
+.BR ENCODED_IOV_COMPRESSION_BTRFS_ZSTD ,
+then the encoded data is a single zstd frame compressed with the
+.I windowLog
+compression parameter set to no more than 17.
+.IP *
+If
+.I compression
+is one of
+.BR ENCODED_IOV_COMPRESSION_BTRFS_LZO_4K ,
+.BR ENCODED_IOV_COMPRESSION_BTRFS_LZO_8K ,
+.BR ENCODED_IOV_COMPRESSION_BTRFS_LZO_16K ,
+.BR ENCODED_IOV_COMPRESSION_BTRFS_LZO_32K ,
+or
+.BR ENCODED_IOV_COMPRESSION_BTRFS_LZO_64K ,
+then the encoded data is compressed page by page
+(using the page size indicated by the name of the constant)
+with LZO1X
+and wrapped in the format documented in the Linux kernel source file
+.IR fs/btrfs/lzo.c .
+.RE
+.IP
+Additionally, there are some restrictions on
+.BR pwritev2 (2):
+.RS
+.IP * 3
+.I offset
+(or the current file offset if
+.I offset
+is -1) must be aligned to the sector size of the filesystem.
+.IP *
+.I len
+must be aligned to the sector size of the filesystem
+unless the data ends at or beyond the current end of the file.
+.IP *
+.I unencoded_len
+and the length of the encoded data must each be no more than 128 KiB.
+This limit may increase in the future.
+.IP *
+The length of the encoded data must be less than or equal to
+.IR unencoded_len .
+.IP *
+If using LZO, the filesystem's page size must match the compression page size.
+.RE
+.SH SEE ALSO
+.BR open (2),
+.BR preadv2 (2)
-- 
2.30.2

