Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B2B24CF6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgHUHi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgHUHix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:38:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA4C061387
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:38:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u128so664835pfb.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OuOQkpJ+s8y7Py7BHshRC8sGkmjsoFJukPaR2Amb08g=;
        b=uucMpO60tYPbHYue1thgRZF0+vFXF3+UQYYL/nerj0E/orLh3f0eUl4BZd894S1Ekd
         OOIeCQYVMBK8oVpjgCckOWc+QGfQzsXAlS0E7V1ujmDt7I8bfgiQgGKvjy1nC9LC2UYV
         vTd8GjtzWk7D7bin/FWmiWJW/SyKDLI+jTBY/OOnUJtlkeOJDileRxjrlIOa+rLkTvju
         J6JakhZrwXO1NQGlLz4rQ64R5p6ujUm29fpBxO7D2jcIZEBwidaxoXpFTXlfhJZ5LgKI
         XS6zktbPVwoUYjHquCuPjXe6xyYYYH7HCsCdrFthY1bXBpXQArkgobpoqej3+8033x5T
         Mpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OuOQkpJ+s8y7Py7BHshRC8sGkmjsoFJukPaR2Amb08g=;
        b=bf+mZzfYrCnEs4SMFDffOPxvNOAo9SmSmRxUWVSuQMeob9nC2Uu3gKdqZtgb4HHrRS
         OGwnKrqNFHCerg7MErDCOiutc9iX+lyW00q1jWZgwp/yPRvxa6/tAi6lNQVogW3m+axs
         UVdoGSzT4CusEXdzAVraQEXjXVgzvieBcQ+bwrePdWZLKKf7paDU0O9HdfI3JD4xHH06
         pu5gR9deRYxNxikAkt2IGCq9YaRdHFc3NKUw7d3eu84rSaPtSwh6EHL63PtJVRH6H12C
         /sTy9vVi/ygLVm8hJ9wujCJ6I5vi21xdgR4A9zJ1EGXckCeZnTezwVVZSoKu3hGUx5Eo
         /lUA==
X-Gm-Message-State: AOAM533+NQIBiAQ+s57ZJbxqytNVwMHsaYWh/Up5L5NPtdx5Gwo6ZVen
        kTE1ZwiURBU9XBfIcMNssxio/6ZQq3em3A==
X-Google-Smtp-Source: ABdhPJwVuN7DSUI2iMZNO3RcEWKAHFDmKUoBzPK7A3/LYjX3ns4+qFDCYZucRMG1kvb2WcUsX9gyjg==
X-Received: by 2002:a63:545a:: with SMTP id e26mr1484120pgm.60.1597995531244;
        Fri, 21 Aug 2020 00:38:51 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id t10sm1220867pgp.15.2020.08.21.00.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:38:50 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com, Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>
Subject: [PATCH man-pages v5] Document encoded I/O
Date:   Fri, 21 Aug 2020 00:38:31 -0700
Message-Id: <64cc229872230dc6998a3dbf2264513870a8a6f6.1597994017.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597993855.git.osandov@osandov.com>
References: <cover.1597993855.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This adds a new page, encoded_io(7), providing an overview of encoded
I/O and updates fcntl(2), open(2), and preadv2(2)/pwritev2(2) to
reference it.

Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: linux-man <linux-man@vger.kernel.org>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
This feature is not yet upstream.

 man2/fcntl.2      |  10 +-
 man2/open.2       |  13 ++
 man2/readv.2      |  64 +++++++++
 man7/encoded_io.7 | 347 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 433 insertions(+), 1 deletion(-)
 create mode 100644 man7/encoded_io.7

diff --git a/man2/fcntl.2 b/man2/fcntl.2
index 874cf2826..bf937260a 100644
--- a/man2/fcntl.2
+++ b/man2/fcntl.2
@@ -221,8 +221,9 @@ On Linux, this command can change only the
 .BR O_ASYNC ,
 .BR O_DIRECT ,
 .BR O_NOATIME ,
+.BR O_NONBLOCK ,
 and
-.B O_NONBLOCK
+.B O_ALLOW_ENCODED
 flags.
 It is not possible to change the
 .BR O_DSYNC
@@ -1820,6 +1821,13 @@ Attempted to clear the
 flag on a file that has the append-only attribute set.
 .TP
 .B EPERM
+Attempted to set the
+.B O_ALLOW_ENCODED
+flag and the calling process did not have the
+.B CAP_SYS_ADMIN
+capability.
+.TP
+.B EPERM
 .I cmd
 was
 .BR F_ADD_SEALS ,
diff --git a/man2/open.2 b/man2/open.2
index 21ed2db22..7d36fdcc8 100644
--- a/man2/open.2
+++ b/man2/open.2
@@ -437,6 +437,14 @@ was followed by a call to
 .BR fdatasync (2)).
 .IR "See NOTES below" .
 .TP
+.B O_ALLOW_ENCODED
+Open the file with encoded I/O permissions;
+see
+.BR encoded_io (7).
+The caller must have the
+.B CAP_SYS_ADMIN
+capability.
+.TP
 .B O_EXCL
 Ensure that this call creates the file:
 if this flag is specified in conjunction with
@@ -1230,6 +1238,11 @@ did not match the owner of the file and the caller was not privileged.
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
index 40b52964d..6ddd81930 100644
--- a/man2/readv.2
+++ b/man2/readv.2
@@ -264,6 +264,11 @@ the data is always appended to the end of the file.
 However, if the
 .I offset
 argument is \-1, the current file offset is updated.
+.TP
+.BR RWF_ENCODED " (since Linux 5.8)"
+Read or write encoded (e.g., compressed) data.
+See
+.BR encoded_io (7).
 .SH RETURN VALUE
 On success,
 .BR readv (),
@@ -283,6 +288,13 @@ than requested (see
 and
 .BR write (2)).
 .PP
+If
+.B
+RWF_ENCODED
+was specified in
+.IR flags ,
+then the return value is the number of encoded bytes.
+.PP
 On error, \-1 is returned, and \fIerrno\fP is set appropriately.
 .SH ERRORS
 The errors are as given for
@@ -313,6 +325,58 @@ is less than zero or greater than the permitted maximum.
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
+can fail for the following reasons:
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
+can fail for the following reasons:
+.TP
+.B E2BIG
+.B RWF_ENCODED
+is specified in
+.I flags
+and
+.I iov[0]
+contains non-zero fields
+after the kernel's
+.IR "sizeof(struct\ encoded_iov)" .
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
index 000000000..ad0542c38
--- /dev/null
+++ b/man7/encoded_io.7
@@ -0,0 +1,347 @@
+.\" Copyright (c) 2019 by Omar Sandoval <osandov@fb.com>
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
+.TH ENCODED_IO  7 2019-10-14 "Linux" "Linux Programmer's Manual"
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
+.I
+encoded_iov
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
+.I "sizeof(struct\ encoded_iov)"
+for forward/backward compatibility.
+The remaining buffers contain the encoded data.
+.PP
+.I compression
+and
+.I encryption
+are the encoding fields.
+.I compression
+is one of
+.B ENCODED_IOV_COMPRESSION_NONE
+(zero),
+.BR ENCODED_IOV_COMPRESSION_ZLIB ,
+.BR ENCODED_IOV_COMPRESSION_LZO ,
+or
+.BR ENCODED_IOV_COMPRESSION_ZSTD .
+.I encryption
+is currently always
+.B ENCODED_IOV_ENCRYPTION_NONE
+(zero).
+.PP
+.I unencoded_len
+is the length of the unencoded (i.e., decrypted and decompressed) data.
+.I unencoded_offset
+is the offset into the unencoded data where the data in the file begins
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
+.I
+.PP
+If the unencoded data is actually longer than
+.IR unencoded_len ,
+then it is truncated;
+if it is shorter, then it is extended with zeroes.
+.PP
+
+.BR pwritev2 ()
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
+.BR pwritev2 ()
+is -1, then the file offset is incremented by
+.IR len .
+If
+.I iov[0].iov_len
+is less than
+.I "sizeof(struct\ encoded_iov)"
+in the kernel,
+then any fields unknown to userspace are treated as if they were zero;
+if it is greater and any fields unknown to the kernel are non-zero,
+then this returns -1 and sets
+.I errno
+to
+.BR E2BIG .
+.PP
+.BR preadv2 ()
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
+.BR preadv2 ()
+is -1, then the file offset is incremented by
+.IR len .
+If
+.I iov[0].iov_len
+is less than
+.I "sizeof(struct\ encoded_iov)"
+in the kernel and any fields unknown to userspace are non-zero,
+then
+.BR preadv2 ()
+returns -1 and sets
+.I errno
+to
+.BR E2BIG ;
+if it is greater,
+then any fields unknown to the kernel are returned as zero.
+If the provided buffers are not large enough to return an entire encoded
+extent,
+then
+.BR preadv2 ()
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
+.IR unencoded_len\ -\ 50 .
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
+then compressed files with a size unaligned to the filesystem block size will
+end with an extent with
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
+Encoded writes allow writing arbitrary data which the kernel will decode on
+a subsequent read. Decompression algorithms are complex and may have bugs
+which can be exploited by maliciously crafted data.
+.IP *
+Encoded reads may return data which is not logically present in the file
+(see the discussion of
+.I len
+vs.
+.I unencoded_len
+above).
+It may not be intended for this data to be readable.
+.PP
+Therefore, encoded I/O requires privilege.
+Namely, the
+.B RWF_ENCODED
+flag may only be used when the file was opened with the
+.B O_ALLOW_ENCODED
+flag to
+.BR open (2),
+which requires the
+.B CAP_SYS_ADMIN
+capability.
+.B O_ALLOW_ENCODED
+may be set and cleared with
+.BR fcntl (2).
+Note that it is not cleared on
+.BR fork (2)
+or
+.BR execve (2);
+one may wish to use
+.B O_CLOEXEC
+with
+.BR O_ALLOW_ENCODED .
+.SS Filesystem support
+Encoded I/O is supported on the following filesystems:
+.TP
+Btrfs (since Linux 5.10)
+.IP
+Btrfs supports encoded reads and writes of compressed data.
+The data is encoded as follows:
+.RS
+.IP * 3
+If
+.I compression
+is
+.BR ENCODED_IOV_COMPRESSION_ZLIB ,
+then the encoded data is a single zlib stream.
+.IP *
+If
+.I compression
+is
+.BR ENCODED_IOV_COMPRESSION_LZO ,
+then the encoded data is compressed page by page with LZO1X
+and wrapped in the format documented in the Linux kernel source file
+.IR fs/btrfs/lzo.c .
+.IP *
+If
+.I compression
+is
+.BR ENCODED_IOV_COMPRESSION_ZSTD ,
+then the encoded data is a single zstd frame compressed with the
+.I windowLog
+compression parameter set to no more than 17.
+.RE
+.IP
+Additionally, there are some restrictions on
+.BR pwritev2 ():
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
+.RE
-- 
2.28.0

