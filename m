Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41EC494819
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 08:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358967AbiATHQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 02:16:29 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:41246 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358745AbiATHQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:16:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4F529CE2001;
        Thu, 20 Jan 2022 07:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A38C340F1;
        Thu, 20 Jan 2022 07:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642662976;
        bh=G1gWsQedwA04fsGDZAwPwBO++Xa6hjRhpWotinFU33I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qntr6frtkWdoYANiGYBoYFWCngoe1Tqpb4LMgVGZo/VIozOGZKOHGhT0M4tTXfG3R
         MrkewIH3DvjpV50jaBAbSXmFf0ndRZwHrm1GoxjiQ1ZzHGlqLnAm4US6Pqgpfeq951
         3qPMZtuR4kjF01tEPO/Tru3aMlNE3IbFEITQig41CUclxJf+blJMxZdeVXSU60P5+c
         nuDmDiq9jYF40EnNTxGKaHzY/Sbd8rhJEqDsDCTJihfNFX7jOSZrZnoq11YB01mQUe
         l4ZV5UjiuuhWAWIkFF1luMgmtyAabJweWcavoI4NB7xul4jyN1GX0Vce/EwobNQVRO
         d1v0Xef6p+2Yg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: [PATCH v10 5/5] fscrypt: update documentation for direct I/O support
Date:   Wed, 19 Jan 2022 23:12:15 -0800
Message-Id: <20220120071215.123274-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120071215.123274-1-ebiggers@kernel.org>
References: <20220120071215.123274-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that direct I/O is supported on encrypted files in some cases,
document what these cases are.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fscrypt.rst | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 4d5d50dca65c6..6ccd5efb25b77 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1047,8 +1047,8 @@ astute users may notice some differences in behavior:
   may be used to overwrite the source files but isn't guaranteed to be
   effective on all filesystems and storage devices.
 
-- Direct I/O is not supported on encrypted files.  Attempts to use
-  direct I/O on such files will fall back to buffered I/O.
+- Direct I/O is supported on encrypted files only under some
+  circumstances.  For details, see `Direct I/O support`_.
 
 - The fallocate operations FALLOC_FL_COLLAPSE_RANGE and
   FALLOC_FL_INSERT_RANGE are not supported on encrypted files and will
@@ -1179,6 +1179,27 @@ Inline encryption doesn't affect the ciphertext or other aspects of
 the on-disk format, so users may freely switch back and forth between
 using "inlinecrypt" and not using "inlinecrypt".
 
+Direct I/O support
+==================
+
+For direct I/O on an encrypted file to work, the following conditions
+must be met (in addition to the conditions for direct I/O on an
+unencrypted file):
+
+* The file must be using inline encryption.  Usually this means that
+  the filesystem must be mounted with ``-o inlinecrypt`` and inline
+  encryption hardware must be present.  However, a software fallback
+  is also available.  For details, see `Inline encryption support`_.
+
+* The I/O request must be fully aligned to the filesystem block size.
+  This means that the file position the I/O is targeting, the lengths
+  of all I/O segments, and the memory addresses of all I/O buffers
+  must be multiples of this value.  Note that the filesystem block
+  size may be greater than the logical block size of the block device.
+
+If either of the above conditions is not met, then direct I/O on the
+encrypted file will fall back to buffered I/O.
+
 Implementation details
 ======================
 
-- 
2.34.1

