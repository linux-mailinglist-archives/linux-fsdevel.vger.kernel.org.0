Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5149D3EF460
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 23:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhHQVHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 17:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbhHQVHt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 17:07:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517CDC061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so7403636pjn.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKeS9x12q5POU6jdOxWtIs+r/42Qh8WRU3h43grwDkc=;
        b=nhPMFLcTTafmjCpV89E5HXLztx4iu1Tc3lDDsV3OPPpTWz5QscThWlE+O7z5Ryf/bE
         fHpQWkFYzLk+DvVlAdy5HvU0Rqhk8Od8j/PODyCKIL4m3JEaM5UK+G5c8BNvgyWABsls
         QMwt/+K8rK4p99iTC8Uw2SJz2dRxokn1PDUJL8BQOmMZwyBCwSa2hZwfnC827JvYtTu1
         nnYxnISxDbjn1FfcvRIfy2+nPplGRqpNJW1dAr6A8hZeoy/PlJOnhK42WqeWbA84XyE/
         eoEwDUJD/51xLc6wFgeHph2wJN8hiNBnaAenqpFmXsESIU/wK/faVOmgnbcQ9JFxBNxf
         nlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKeS9x12q5POU6jdOxWtIs+r/42Qh8WRU3h43grwDkc=;
        b=b/2BMCL2IU8LMZY46Sr4SGATEO7hQBQ2ZP1hUygQX4jreU8NF2wkjIbDWy8OgJgH1P
         MisntahL+fQfZVHCitZTL0O3O0oFXr13Mh+sJAkA7nHaXeMMDpAKRvznUVoqcznpR9bE
         YIDFPc10Y3kSVlcCbX4RYfNC9bS6F9j3Y7A6PScuVfzABRxxDXoM1zUGLWC1fZEAyvau
         UKcZtAw6FgKHzRT/SHPaRiSAaPDQVpDEaIdFo6MavDUjj42NTP9O4W4FDHZ3bz3poyfz
         ezfVU5d5QTlnn5UPOrlbf9IpSPyZBNEphCWxFl3s8ZrIwnmJd0pGQiDRP5fO6AOZYUu3
         Cvdg==
X-Gm-Message-State: AOAM5316SdXdOjZHzz5LEijeIxc2+lbgzrLnmJ/daBFemhBYKZGQ3O2A
        ejRp/dFJFz7t/Jl787FhL2uMfmxIOtpdpQ==
X-Google-Smtp-Source: ABdhPJz4lXQQiGf+8VR0uyoy7W2iSPIke5AoUumga+X4liArz5Zuou0/7gvOlhPPTMqNgi4uNf80jA==
X-Received: by 2002:a63:ed50:: with SMTP id m16mr5267690pgk.231.1629234434865;
        Tue, 17 Aug 2021 14:07:14 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:14 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 02/14] fs: export variant of generic_write_checks without iov_iter
Date:   Tue, 17 Aug 2021 14:06:34 -0700
Message-Id: <237db7dc485834d3d359b5765f07ebf7c3514f3a.1629234193.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629234193.git.osandov@fb.com>
References: <cover.1629234193.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Encoded I/O in Btrfs needs to check a write with a given logical size
without an iov_iter that matches that size (because the iov_iter we have
is for the compressed data). So, factor out the parts of
generic_write_check() that expect an iov_iter into a new
__generic_write_checks() function and export that.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/read_write.c    | 40 ++++++++++++++++++++++------------------
 include/linux/fs.h |  1 +
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 0029ff2b0ca8..3bddd5ee7f64 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1633,6 +1633,26 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
 	return 0;
 }
 
+/* Like generic_write_checks(), but takes size of write instead of iter. */
+int __generic_write_checks(struct kiocb *iocb, loff_t *count)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+
+	if (IS_SWAPFILE(inode))
+		return -ETXTBSY;
+
+	/* FIXME: this is for backwards compatibility with 2.4 */
+	if (iocb->ki_flags & IOCB_APPEND)
+		iocb->ki_pos = i_size_read(inode);
+
+	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
+		return -EINVAL;
+
+	return generic_write_check_limits(iocb->ki_filp, iocb->ki_pos, count);
+}
+EXPORT_SYMBOL(__generic_write_checks);
+
 /*
  * Performs necessary checks before doing a write
  *
@@ -1642,26 +1662,10 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
  */
 ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
-	loff_t count;
+	loff_t count = iov_iter_count(from);
 	int ret;
 
-	if (IS_SWAPFILE(inode))
-		return -ETXTBSY;
-
-	if (!iov_iter_count(from))
-		return 0;
-
-	/* FIXME: this is for backwards compatibility with 2.4 */
-	if (iocb->ki_flags & IOCB_APPEND)
-		iocb->ki_pos = i_size_read(inode);
-
-	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
-		return -EINVAL;
-
-	count = iov_iter_count(from);
-	ret = generic_write_check_limits(file, iocb->ki_pos, &count);
+	ret = __generic_write_checks(iocb, &count);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0de4d75339b9..b206814da181 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3227,6 +3227,7 @@ extern int sb_min_blocksize(struct super_block *, int);
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
 extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
+extern int __generic_write_checks(struct kiocb *iocb, loff_t *count);
 extern int generic_write_check_limits(struct file *file, loff_t pos,
 		loff_t *count);
 extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
-- 
2.32.0

