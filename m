Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C1954EAF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 22:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378477AbiFPUWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 16:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378460AbiFPUWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:22:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D7BC51;
        Thu, 16 Jun 2022 13:22:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C48361D28;
        Thu, 16 Jun 2022 20:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0B0C3411B;
        Thu, 16 Jun 2022 20:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655410949;
        bh=M3h58AGOHHTXWiuwNhC9HEL2EAhvwozEXVfdsCNjbvM=;
        h=From:To:Cc:Subject:Date:From;
        b=MjJzjusn6ewv72iXR7k0V9x/KXqlia2Fj9JbaIi0pnWWHSBCRL/nBqC84wAMXdJCF
         uUWcNCHMHFrddP4MYyXNp+Oy0fybAkSIH95xeQ6Fk9zuPmQC3WPQjcduLzixxM7o8G
         38TPZXSveYCnsy3jrG82hgamJWRowDxP5Jnu4mwmXh5fHMijOx1AFSFhvqbdv/EdVG
         TaI45Xjwf/GQa0Js+dwSyIt3oQHXLHaIK3t4Ci6uJA/1OMEXWvqW6rq9nnmGc9+5jr
         JTCmydNG7ltO+qEaQ/uPUkbQlP0pBkiGsWa4Up7jj7oH5TIV2ObhSOLE3aFhumB652
         gWnXZB3m31aSw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-man@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: [man-pages RFC PATCH] statx.2, open.2: document STATX_DIOALIGN
Date:   Thu, 16 Jun 2022 13:21:41 -0700
Message-Id: <20220616202141.125079-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Document the proposed STATX_DIOALIGN support for statx()
(https://lore.kernel.org/linux-fsdevel/20220616201506.124209-1-ebiggers@kernel.org).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 man2/open.2  | 43 ++++++++++++++++++++++++++++++++-----------
 man2/statx.2 | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/man2/open.2 b/man2/open.2
index d1485999f..ef29847c3 100644
--- a/man2/open.2
+++ b/man2/open.2
@@ -1732,21 +1732,42 @@ of user-space buffers and the file offset of I/Os.
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
+I/Os also varies; they can either fail with
+.B EINVAL
+or fall back to buffered I/O.
+.PP
+Since Linux 5.20,
+.B O_DIRECT
+support and alignment restrictions for a file can be queried using
+.BR statx (2),
+using the
+.B STATX_DIOALIGN
+flag.
+Support for
+.B STATX_DIOALIGN
+varies by filesystem; see
+.BR statx (2).
+.PP
+Some filesystems provide their own interfaces for querying
+.B O_DIRECT
+alignment restrictions, for example the
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
+If none of the above is available, then direct I/O support and alignment
+restrictions can only be assumed from known characteristics of the filesystem,
+the individual file, the underlying storage device(s), and the kernel version.
+In Linux 2.4, most block device based filesystems require that the file offset
+and the length and memory address of all I/O segments be multiples of the
+filesystem block size (typically 4096 bytes).
+In Linux 2.6.0, this was relaxed to the logical block size of the block device
+(typically 512 bytes).
+A block device's logical block size can be determined using the
 .BR ioctl (2)
 .B BLKSSZGET
 operation or from the shell using the command:
diff --git a/man2/statx.2 b/man2/statx.2
index a8620be6f..fff0a63ec 100644
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
@@ -244,8 +249,11 @@ STATX_SIZE	Want stx_size
 STATX_BLOCKS	Want stx_blocks
 STATX_BASIC_STATS	[All of the above]
 STATX_BTIME	Want stx_btime
+STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
+         	This is deprecated and should not be used.
 STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
-STATX_ALL	[All currently available fields]
+STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
+              	(since Linux 5.20; support varies by filesystem)
 .TE
 .in
 .PP
@@ -406,6 +414,28 @@ This is the same number reported by
 .BR name_to_handle_at (2)
 and corresponds to the number in the first field in one of the records in
 .IR /proc/self/mountinfo .
+.TP
+.I stx_dio_mem_align
+The alignment (in bytes) required for user memory buffers for direct I/O
+.BR "" ( O_DIRECT )
+on this file. or 0 if direct I/O is not supported on this file.
+.IP
+.B STATX_DIOALIGN
+.IR "" ( stx_dio_mem_align
+and
+.IR stx_dio_offset_align )
+is supported on block devices since Linux 5.20.
+The support on regular files varies by filesystem; it is supported by ext4 and
+f2fs since Linux 5.20.
+.TP
+.I stx_dio_offset_align
+The alignment (in bytes) required for file offsets and I/O segment lengths for
+direct I/O
+.BR "" ( O_DIRECT )
+on this file, or 0 if direct I/O is not supported on this file.
+This will only be nonzero if
+.I stx_dio_mem_align
+is nonzero, and vice versa.
 .PP
 For further information on the above fields, see
 .BR inode (7).
-- 
2.36.1

