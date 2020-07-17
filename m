Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE4922306D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 03:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgGQBfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 21:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgGQBfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:35:33 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236FDC061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 18:35:33 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id s28so5784447pfd.19
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 18:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E/vVSGidxRNqfgFvT7W0V9puYBqKI9SZ+5JR8j0m+58=;
        b=ZcYDTvcfLLpu/jhtpmOZTX1yip7PM/LKW+mqaazTmFRD19tgdynOHn3dvFmYrGW/EU
         3OGE6491fFJOHWChT38oVFGgJgqcZ1z9qC05QU8JraayXUwgfZmczmipgbR37elMel8Z
         zNb7TYC+lWvWJJ6SnDNsPiAtosseBQpBY7N1qfVzLHJNWx+JNLHhks/B90rtrKlzTw2Q
         QdJ4Rgwpk7ZYwleZwGq00b+zq66rjpmtFE10TZhsYG25d9JTk8G6JQVQC1rLY+/3pY2o
         8blcSeqgKqhLSzrKduWn3JF/DTEgh0C9d7W/d32ySDrix8TvV4yJXo/ftZgek76k0P/c
         Y1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E/vVSGidxRNqfgFvT7W0V9puYBqKI9SZ+5JR8j0m+58=;
        b=ph/ZCxQTxAQlml9hESzmtnrwHgMg+SVscBCfYPpyLi8zu0h2fqyklZbYc4In4dzonY
         fMGvQg9b2/zHybx600WITBH/C/VW7C0h/R04nVLeJXHN+05T44rs+DnnM6e1zed6ib26
         /272jHFPUKLn1WFtPUm5dc9IQQT4FhohrFm9K+KbgH6AtLMb+ugsiopkvBMtzrDHfZg+
         wieNOZYvHiu/wkosvTMVbhnp4KIxy3LTJe0Jkk09QupyUsOWUIRfShakiWc/GxbGBO7p
         0uzOZduCQC/d1CtkM/Bg4/yzLwGBnrR0ZBsQM/SEH+u1alQPplShdsop3T74xGhuhInd
         ddRA==
X-Gm-Message-State: AOAM532CKDVUoNgomjkq5671hU7FA/6Um2BeajJ1/0WkZruZsZd4f/4v
        VKQsMxcS83v04E/5ZPq0KAmztB3FOjQ=
X-Google-Smtp-Source: ABdhPJxblkVinfK9/GjEu/MeJLy/xcw1zo2TEXIQwGlWkq0fWav4MrbEVMKPE2WnLaQ1sWXSffDb1SKbb/Q=
X-Received: by 2002:a63:225d:: with SMTP id t29mr6933840pgm.374.1594949732647;
 Thu, 16 Jul 2020 18:35:32 -0700 (PDT)
Date:   Fri, 17 Jul 2020 01:35:15 +0000
In-Reply-To: <20200717013518.59219-1-satyat@google.com>
Message-Id: <20200717013518.59219-5-satyat@google.com>
Mime-Version: 1.0
References: <20200717013518.59219-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v2 4/7] ext4: support direct I/O with fscrypt using blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Wire up ext4 with fscrypt direct I/O support. direct I/O with fscrypt is
only supported through blk-crypto (i.e. CONFIG_BLK_INLINE_ENCRYPTION must
have been enabled, the 'inlinecrypt' mount option must have been specified,
and either hardware inline encryption support must be present or
CONFIG_BLK_INLINE_ENCYRPTION_FALLBACK must have been enabled). Further,
direct I/O on encrypted files is only supported when I/O is aligned
to the filesystem block size (which is *not* necessarily the same as the
block device's block size).

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/ext4/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

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
-- 
2.28.0.rc0.105.gf9edc3c819-goog

