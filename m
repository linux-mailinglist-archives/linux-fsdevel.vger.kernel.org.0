Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC7D312CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 18:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfEaQrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 12:47:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38644 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfEaQrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 12:47:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id t5so6345131wmh.3;
        Fri, 31 May 2019 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X3WeVFmopGuuzSMfd02xY46iy5YQ5i2IPT3FFyazWHY=;
        b=QpnnyvOYWKnYRoirb83FihX5x9ZV23YEQlEPdDZsKWmtyF+bShusbkmqzPeuusWzyC
         XqOpO/1iGnZOfvLJuwLIcavfSQAhJnaLlMvijfeA69g8zNJSmydIhaYqIJlVQX7FuaGX
         7mFSLTlflUU9fglzB1TwhElftrZ2JIcjFV8WKOMBXHgBMl3e7BJcm/FrjpMfLUqr1qL4
         QgnrT4uCyKHxqFRNKi/oH7DZvWt0X8Nh27texCBdLPB9oGSySHeQXgbxxRHpfL7Z8h7S
         gbM8yA0gZpaJPfgtlmvenO25R2j1PloAemnID7qIAYxsEI+B8rCnjYyeY6Qm6SHk0olK
         dVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X3WeVFmopGuuzSMfd02xY46iy5YQ5i2IPT3FFyazWHY=;
        b=Q66VuEf1Qc2AZUUsl67Noy7u0zRpJiUVAGP0NJ+bfc34vY9zdTXI5u+ajHD67wka+8
         Q0PVVvHnRwjNZrP1XCpv2eiXUvH5ur/XddJQ8bAxDpoRtisZbEuq8tYjjjsdSMn5qNd3
         zEPSPt0+ay5Jspt/lJ34BIOVNi/DJeRBDZJ9E6PQD6tvR4p9uIOC4T3rnfH1M1PjPMHb
         2BbgxxGva1sqiOPUf9zaj2TBM0iKGTXD3jLq0FzhSlV9vRelLsT14lcHmZqB4ppiSwBa
         XU5exHOTebL/TOket7kx4mRl2gDbP0qyBe/36QP/iP/jkjHda9KY1tSEDBvfl4THaji9
         p88Q==
X-Gm-Message-State: APjAAAXqSlFUYRecAnQ1uzouV+hf1OZ2MjTPMf4TfjBqjN18S+1FDxJ1
        SVL7JLBxgKNqJ5hUE+1uFYo=
X-Google-Smtp-Source: APXvYqxOcnHUJG5TmXGvN85Yqz1uaieM1YNFDJzzjxfr378SsXYh9iw73KZ+B4Jdp14HbM0rD0FMPQ==
X-Received: by 2002:a1c:63d7:: with SMTP id x206mr6406035wmb.19.1559321236505;
        Fri, 31 May 2019 09:47:16 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id n5sm7669593wrj.27.2019.05.31.09.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 09:47:15 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v4 4/9] vfs: remove redundant checks from generic_remap_checks()
Date:   Fri, 31 May 2019 19:46:56 +0300
Message-Id: <20190531164701.15112-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531164701.15112-1-amir73il@gmail.com>
References: <20190531164701.15112-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The access limit checks on input file range in generic_remap_checks()
are redundant because the input file size is guaranteed to be within
limits and pos+len are already checked to be within input file size.

Beyond the fact that the check cannot fail, if it would have failed,
it could return -EFBIG for input file range error. There is no precedent
for that. -EFBIG is returned in syscalls that would change file length.

With that call removed, we can fold generic_access_check_limits() into
generic_write_check_limits().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 mm/filemap.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a38619a4a6af..44361928bbb0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2895,24 +2895,11 @@ EXPORT_SYMBOL(read_cache_page_gfp);
  * LFS limits.  If pos is under the limit it becomes a short access.  If it
  * exceeds the limit we return -EFBIG.
  */
-static int generic_access_check_limits(struct file *file, loff_t pos,
-				       loff_t *count)
-{
-	struct inode *inode = file->f_mapping->host;
-	loff_t max_size = inode->i_sb->s_maxbytes;
-
-	if (!(file->f_flags & O_LARGEFILE))
-		max_size = MAX_NON_LFS;
-
-	if (unlikely(pos >= max_size))
-		return -EFBIG;
-	*count = min(*count, max_size - pos);
-	return 0;
-}
-
 static int generic_write_check_limits(struct file *file, loff_t pos,
 				      loff_t *count)
 {
+	struct inode *inode = file->f_mapping->host;
+	loff_t max_size = inode->i_sb->s_maxbytes;
 	loff_t limit = rlimit(RLIMIT_FSIZE);
 
 	if (limit != RLIM_INFINITY) {
@@ -2923,7 +2910,15 @@ static int generic_write_check_limits(struct file *file, loff_t pos,
 		*count = min(*count, limit - pos);
 	}
 
-	return generic_access_check_limits(file, pos, count);
+	if (!(file->f_flags & O_LARGEFILE))
+		max_size = MAX_NON_LFS;
+
+	if (unlikely(pos >= max_size))
+		return -EFBIG;
+
+	*count = min(*count, max_size - pos);
+
+	return 0;
 }
 
 /*
@@ -2963,7 +2958,7 @@ EXPORT_SYMBOL(generic_write_checks);
 /*
  * Performs necessary checks before doing a clone.
  *
- * Can adjust amount of bytes to clone.
+ * Can adjust amount of bytes to clone via @req_count argument.
  * Returns appropriate error code that caller should return or
  * zero in case the clone should be allowed.
  */
@@ -3001,10 +2996,6 @@ int generic_remap_checks(struct file *file_in, loff_t pos_in,
 		return -EINVAL;
 	count = min(count, size_in - (uint64_t)pos_in);
 
-	ret = generic_access_check_limits(file_in, pos_in, &count);
-	if (ret)
-		return ret;
-
 	ret = generic_write_check_limits(file_out, pos_out, &count);
 	if (ret)
 		return ret;
-- 
2.17.1

