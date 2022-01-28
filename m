Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE4B4A0459
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jan 2022 00:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351814AbiA1XkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 18:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241190AbiA1XkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:40:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1899C061714;
        Fri, 28 Jan 2022 15:40:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F84261F2E;
        Fri, 28 Jan 2022 23:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1C5C340E8;
        Fri, 28 Jan 2022 23:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643413204;
        bh=spfZ0C7Zzj01hpeB+SKGd/oodc1v3r1noyh70XVyPBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2Pk9YJCttEO3LXCWN96An7pNpeozJNfzD23KRTrHMV4ZDMWkGzZptp9dr+An7tHk
         AT7joZu6qGP3AlKNTtjhVXZr6d7kRRqTTijWcyXgYlXw2Kbj+gwNfWj6etyiOvYyXO
         zXvVSwby5N6+/nPPzvCxS4JqAHAI7z9cpk1jfcRsypsUtvpr4sAothr5bYJRXrsR9l
         cJ618VQ3o8Bt2meiuZCADNKl8Vv+EaHKGCNETgm7GqFQL2Oams+5KMQ+J9eLQG3+2c
         1AZRvJA6RVW0wa5BwmjzWu9JSsc3QH1lUEBg9IB25aqfT1p0uOuuJ757Oso4Yk7te2
         ZtCemJbi/UbuA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH v11 5/5] fscrypt: update documentation for direct I/O support
Date:   Fri, 28 Jan 2022 15:39:40 -0800
Message-Id: <20220128233940.79464-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128233940.79464-1-ebiggers@kernel.org>
References: <20220128233940.79464-1-ebiggers@kernel.org>
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
2.35.0

