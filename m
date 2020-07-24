Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C6822CE12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 20:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgGXSpT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 14:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgGXSpN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:45:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBF3C0619D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 11:45:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w35so11501531ybi.16
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 11:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r8Pg6JmNaFN8fVBskJ954zlZvlkSSoV1f+xmIU4eJ8Y=;
        b=WZxif6+6SPfu0xTeldRLQ3uzvhiQHHPuJ3wvszADxxQXo+kraJNCkoW2SjaTiCI/fA
         tjr/RHdHC2utCZI6gqsTf6bi248HQE4FH8OeQ3i5z7Mjm/erk6l9Hs4KAFgiNnGSoJzQ
         +wFpox/AoKBdgYO6JL/4Pt7vSNaTodsgMpvLea+xlBamKo2Zp7mdiwk8z3K+1O4pvHHT
         Zn4bWRPvpRwh7o3cHRLAUqjDHP0wki5gObcM3HhSBidRJ187n9QJXUzMC2M7ubEQa66B
         ltnFBglVcP3vBXxYW+dKa0oTYE+kv+oO/LBgR0e2hn6tgE0m1OcMFNfOm3F+WYqCTZ6H
         wMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r8Pg6JmNaFN8fVBskJ954zlZvlkSSoV1f+xmIU4eJ8Y=;
        b=KJkUnVQZ4weEfDJvHoY4/yjpZ04IX417QnoL1TQ992X7wWF89SMOrJ9vQCeL/5krb5
         ET4PYZTA5m5jMMGLPsoE1uWiMhTN9LgUR9+/Io9Duw6VH0MdFRESvmQlIkGCjRr1k8Ik
         rgHDPRgoocSehYz7/z9x5AWG0bEupAVZOeZbErcnXet97uOMoS6QIjL3O0H/Is2GAbC4
         Alkeq/t4LUaD6Tatp3o51jQ8WwzAQrmx9YtYO8kwY03O+GuAA7nV6m7pIuDoGxO8UA6x
         Zcp0C7uueZB7zaSkivsLZF7XXN2RsVmEZoPmFjShDph5J9HpyCN8lajwpN/k3L6Z0jh6
         LzOw==
X-Gm-Message-State: AOAM532HjACG6EgViDqg/eYV5Cs8AVe94zXvOywa8yVGYg4bYBoRrwXv
        y1mCcADY2sGY37yoXEsOCWtJhLwAqpU=
X-Google-Smtp-Source: ABdhPJz/pwO4CPr/TwSp+10jXFW4RyYAdzpCUQarKYvxET89Fk5Zhv46IwKHyL9Ir7sI+fKC28k4po0GnP8=
X-Received: by 2002:a25:6c8a:: with SMTP id h132mr17095635ybc.353.1595616312763;
 Fri, 24 Jul 2020 11:45:12 -0700 (PDT)
Date:   Fri, 24 Jul 2020 18:44:58 +0000
In-Reply-To: <20200724184501.1651378-1-satyat@google.com>
Message-Id: <20200724184501.1651378-5-satyat@google.com>
Mime-Version: 1.0
References: <20200724184501.1651378-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v6 4/7] ext4: support direct I/O with fscrypt using blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Wire up ext4 with fscrypt direct I/O support. Direct I/O with fscrypt is
only supported through blk-crypto (i.e. CONFIG_BLK_INLINE_ENCRYPTION must
have been enabled, the 'inlinecrypt' mount option must have been specified,
and either hardware inline encryption support must be present or
CONFIG_BLK_INLINE_ENCYRPTION_FALLBACK must have been enabled). Further,
direct I/O on encrypted files is only supported when I/O is aligned
to the filesystem block size (which is *not* necessarily the same as the
block device's block size).

fscrypt_limit_io_blocks() is called before setting up the iomap to ensure
that the blocks of each bio that iomap will submit will have contiguous
DUNs. Note that fscrypt_limit_io_blocks() is normally a no-op, as normally
the DUNs simply increment along with the logical blocks. But it's needed
to handle an edge case in one of the fscrypt IV generation methods.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/ext4/file.c  | 10 ++++++----
 fs/ext4/inode.c |  7 +++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 2a01e31a032c..d534f72675d9 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -36,9 +36,11 @@
 #include "acl.h"
 #include "truncate.h"
 
-static bool ext4_dio_supported(struct inode *inode)
+static bool ext4_dio_supported(struct kiocb *iocb, struct iov_iter *iter)
 {
-	if (IS_ENABLED(CONFIG_FS_ENCRYPTION) && IS_ENCRYPTED(inode))
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (!fscrypt_dio_supported(iocb, iter))
 		return false;
 	if (fsverity_active(inode))
 		return false;
@@ -61,7 +63,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		inode_lock_shared(inode);
 	}
 
-	if (!ext4_dio_supported(inode)) {
+	if (!ext4_dio_supported(iocb, to)) {
 		inode_unlock_shared(inode);
 		/*
 		 * Fallback to buffered I/O if the operation being performed on
@@ -490,7 +492,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	/* Fallback to buffered I/O if the inode does not support direct I/O. */
-	if (!ext4_dio_supported(inode)) {
+	if (!ext4_dio_supported(iocb, from)) {
 		if (ilock_shared)
 			inode_unlock_shared(inode);
 		else
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 44bad4bb8831..6725116ea348 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3445,6 +3445,13 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * When inline encryption is enabled, sometimes I/O to an encrypted file
+	 * has to be broken up to guarantee DUN contiguity. Handle this by
+	 * limiting the length of the mapping returned.
+	 */
+	map.m_len = fscrypt_limit_io_blocks(inode, map.m_lblk, map.m_len);
+
 	ext4_set_iomap(inode, iomap, &map, offset, length);
 
 	return 0;
-- 
2.28.0.rc0.142.g3c755180ce-goog

