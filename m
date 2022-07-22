Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD00657DB73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 09:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbiGVHnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 03:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGVHnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:43:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD23217061;
        Fri, 22 Jul 2022 00:42:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86C4AB8273C;
        Fri, 22 Jul 2022 07:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A33C341C6;
        Fri, 22 Jul 2022 07:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658475776;
        bh=ogA0HhpspCjS+a1icpgHI4aSwotqmHJVFm71Wnc0cl4=;
        h=From:To:Cc:Subject:Date:From;
        b=OaVFj+XFyb+191Fiq3g3CejvUN/c9Pun4nlCjR8G1LUMKqhw8U7wlq43z+9xnj87f
         Oi+A/SF7qArpUCv2diYRaj6o++MCSzNe0v2dpPKcwdD1S1Ss/IJVGsC0dnLkamPcg5
         keJsBDJCk20l3G2V9E/8+2vGhRV9q3xu/dKiDIaA3zRBCkA7nERfwivYWB2V2dtTRp
         oTyvW2z4AY0X+nehR57g3EQBfcPSEuPol0SIherrMMCfp6h4X6WHURyEz3RkiLiGDW
         u3Geg2MtVq/oNiuENZPPsSLfh1QZz6crIsO3sLk+RtWcwEiMSugY8JjaD0PsS6Ktn8
         /DshXvSmjr9iw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-man@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: [man-pages RFC PATCH v2] statx.2, open.2: document STATX_DIOALIGN
Date:   Fri, 22 Jul 2022 00:42:28 -0700
Message-Id: <20220722074229.148925-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Document the proposed STATX_DIOALIGN support for statx()
(https://lore.kernel.org/linux-fsdevel/20220722071228.146690-1-ebiggers@kernel.org/T/#u).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: rebased onto man-pages master branch, mentioned xfs, and updated
    link to patchset

 man2/open.2  | 43 ++++++++++++++++++++++++++++++++-----------
 man2/statx.2 | 29 +++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 11 deletions(-)

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
index 0326e9af0..ea38ec829 100644
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
+	(since Linux 5.20; support varies by filesystem)
 .TE
 .in
 .PP
@@ -407,6 +414,28 @@ This is the same number reported by
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
+The support on regular files varies by filesystem; it is supported by ext4,
+f2fs, and xfs since Linux 5.20.
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

base-commit: f9f25914e4ed393ac284ab921876e8a78722c504
-- 
2.37.0

