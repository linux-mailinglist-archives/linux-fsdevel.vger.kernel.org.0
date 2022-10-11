Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380C45FBE04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 00:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJKW7b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 18:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJKW73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:59:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB8992593;
        Tue, 11 Oct 2022 15:59:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 387E1B8160D;
        Tue, 11 Oct 2022 22:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F37C433D6;
        Tue, 11 Oct 2022 22:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665529164;
        bh=uLhjiSU6dHOtAMnX7fEozmgHIL3cBmodbbEpRxHuGto=;
        h=From:To:Cc:Subject:Date:From;
        b=tRTCxhmrMRcfoNQQDoVD4+mN2LX8IwtFR7oZeWKKS8Tc25Djoy+7v1RXW3PEDIPdP
         RZlqnqX3LN4w7+QKAEo7Ueqz3LcCsGjTs8iXdatSn66hytIcLgxnwnUsGwz83zb9QT
         HneEkgnp/65S/TuJc1r5TyoGhaiOXvnJJwHr8y/Nw+pFKUhzRrLesMYcLM08fDyrid
         aEgcGrIVaXXKNRuZr3Ze50CN1FT76SmqYrPOsflkz68JrxmM02SztuyMdkIG74bdsN
         y1qVH7XZgqjSVhKw6qf73ubtLAGsz0Qh+dMpqPpEdRiaiPtdriSxJl4MoaOnZyay2F
         x8aCqukoe/lrA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [man-pages PATCH v4] statx.2, open.2: document STATX_DIOALIGN
Date:   Tue, 11 Oct 2022 15:59:14 -0700
Message-Id: <20221011225914.216344-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Document the STATX_DIOALIGN support for statx()
(https://git.kernel.org/linus/725737e7c21d2d25).

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v4: formatting tweaks, as suggested by Alejandro

v3: updated mentions of Linux version, fixed some punctuation, and added
    a Reviewed-by

v2: rebased onto man-pages master branch, mentioned xfs, and updated
    link to patchset

 man2/open.2  | 52 +++++++++++++++++++++++++++++++++++++++++-----------
 man2/statx.2 | 31 +++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/man2/open.2 b/man2/open.2
index 57beb324a..8e4a063b4 100644
--- a/man2/open.2
+++ b/man2/open.2
@@ -1732,21 +1732,51 @@ of user-space buffers and the file offset of I/Os.
 In Linux alignment
 restrictions vary by filesystem and kernel version and might be
 absent entirely.
-However there is currently no filesystem\-independent
-interface for an application to discover these restrictions for a given
-file or filesystem.
-Some filesystems provide their own interfaces
-for doing so, for example the
+The handling of misaligned
+.B O_DIRECT
+I/Os also varies;
+they can either fail with
+.B EINVAL
+or fall back to buffered I/O.
+.PP
+Since Linux 6.1,
+.B O_DIRECT
+support and alignment restrictions for a file can be queried using
+.BR statx (2),
+using the
+.B STATX_DIOALIGN
+flag.
+Support for
+.B STATX_DIOALIGN
+varies by filesystem;
+see
+.BR statx (2).
+.PP
+Some filesystems provide their own interfaces for querying
+.B O_DIRECT
+alignment restrictions,
+for example the
 .B XFS_IOC_DIOINFO
 operation in
 .BR xfsctl (3).
+.B STATX_DIOALIGN
+should be used instead when it is available.
 .PP
-Under Linux 2.4, transfer sizes, the alignment of the user buffer,
-and the file offset must all be multiples of the logical block size
-of the filesystem.
-Since Linux 2.6.0, alignment to the logical block size of the
-underlying storage (typically 512 bytes) suffices.
-The logical block size can be determined using the
+If none of the above is available,
+then direct I/O support and alignment restrictions
+can only be assumed from known characteristics of the filesystem,
+the individual file,
+the underlying storage device(s),
+and the kernel version.
+In Linux 2.4,
+most block device based filesystems require that
+the file offset and the length and memory address of all I/O segments
+be multiples of the filesystem block size
+(typically 4096 bytes).
+In Linux 2.6.0,
+this was relaxed to the logical block size of the block device
+(typically 512 bytes).
+A block device's logical block size can be determined using the
 .BR ioctl (2)
 .B BLKSSZGET
 operation or from the shell using the command:
diff --git a/man2/statx.2 b/man2/statx.2
index 2a85be7c0..84c35bdf3 100644
--- a/man2/statx.2
+++ b/man2/statx.2
@@ -61,7 +61,12 @@ struct statx {
        containing the filesystem where the file resides */
     __u32 stx_dev_major;   /* Major ID */
     __u32 stx_dev_minor;   /* Minor ID */
+
     __u64 stx_mnt_id;      /* Mount ID */
+
+    /* Direct I/O alignment restrictions */
+    __u32 stx_dio_mem_align;
+    __u32 stx_dio_offset_align;
 };
 .EE
 .in
@@ -247,6 +252,8 @@ STATX_BTIME	Want stx_btime
 STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
 	It is deprecated and should not be used.
 STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
+STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
+	(since Linux 6.1; support varies by filesystem)
 .TE
 .in
 .PP
@@ -407,6 +414,30 @@ This is the same number reported by
 .BR name_to_handle_at (2)
 and corresponds to the number in the first field in one of the records in
 .IR /proc/self/mountinfo .
+.TP
+.I stx_dio_mem_align
+The alignment (in bytes) required for user memory buffers for direct I/O
+.RB ( O_DIRECT )
+on this file,
+or 0 if direct I/O is not supported on this file.
+.IP
+.B STATX_DIOALIGN
+.RI ( stx_dio_mem_align
+and
+.IR stx_dio_offset_align )
+is supported on block devices since Linux 6.1.
+The support on regular files varies by filesystem;
+it is supported by ext4, f2fs, and xfs since Linux 6.1.
+.TP
+.I stx_dio_offset_align
+The alignment (in bytes) required for file offsets and I/O segment lengths
+for direct I/O
+.BR "" ( O_DIRECT )
+on this file,
+or 0 if direct I/O is not supported on this file.
+This will only be nonzero if
+.I stx_dio_mem_align
+is nonzero, and vice versa.
 .PP
 For further information on the above fields, see
 .BR inode (7).

base-commit: ab47278f252262dd9bd90f3386ffd7d8700fa25a
-- 
2.37.3

