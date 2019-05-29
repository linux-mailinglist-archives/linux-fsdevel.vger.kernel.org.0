Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2743A2E399
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 19:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfE2Rno (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 13:43:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53583 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfE2Rnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 13:43:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id d17so2249047wmb.3;
        Wed, 29 May 2019 10:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NeKDiq+5p2NPB+OcuE01UzrlB5njM3yLN2qd6AodpeU=;
        b=QN4dIaN9QMaFtoyG1MUp3LUKUh3ugT/NLU0caZNTFXyG+VEwCFfSZ7mD8R4ExD6UXl
         gOYwKkKWru9NBTMqz2dLCYd6divEv4VxRn9L/xfgmYsnWPWYanKR+5T9cqVr77JQ3DVA
         UCbWv1SoobyBKVlV1UospEjByMAApeveSG6P9pQcvZogWrw1GCLzEYMjEp9ICab6sVwe
         MleSETzpiVcMoSl5TEaM8Zm1KYTpW4jXrNVb/TouiRehBOhM0cwE4OyzbFIGSVb7DVr6
         kFpAfSEkd0ruju3U1cz31YBgfo9fjbsnDy9f+1MmnvzAotmiLbvk8C9MTyzaf3aMauOn
         ciRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NeKDiq+5p2NPB+OcuE01UzrlB5njM3yLN2qd6AodpeU=;
        b=jPUXmQHgtbS4Rq/9GGDNd8yiKDBwCN5vGFMt1tlBDJNOn7PboKaXLl0fqXdFrFCIZO
         AJHPUVY3N2pY1c0KisD7xylSogObIcX9MZBU481GDB7hNf85YlvGfdD46kQ2eFjb7gro
         S5UMnbDiLptyg3TU1xGL3kWXER4/UE1uDrCEwskMStmrTHk7QFKCHE6Jy07/6gLacr2f
         W2TGPCcU74KGHRfrF0P9NgPtbwMgtgYUtOPvoDF4KpYZIdM48IzFWnvyqfR8tjJsmHfW
         +aE0O46pyvcO97XKAEQiQJ3ViR0LRFSIbrZw2nkf+R68dDqiRpSIh5ygwPXG/LBpwJh/
         oPsA==
X-Gm-Message-State: APjAAAWIPEMpvO/3y09BEpMSQTnO5xrXlnDGAh1/qMD84Duh0toc4dXR
        adtmM9BKCcQ5xspwqv1Xdq0=
X-Google-Smtp-Source: APXvYqz6bZyxgncHyHvCPAhLhQv5wGfs/oioqGtZDHF7raSCBLoHpEbnJUrWfw3hcdK4BYBLS9qb7w==
X-Received: by 2002:a05:600c:23cf:: with SMTP id p15mr7996691wmb.31.1559151815769;
        Wed, 29 May 2019 10:43:35 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id k125sm31702wmb.34.2019.05.29.10.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:43:35 -0700 (PDT)
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
Subject: [PATCH v3 04/13] vfs: remove redundant checks from generic_remap_checks()
Date:   Wed, 29 May 2019 20:43:08 +0300
Message-Id: <20190529174318.22424-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529174318.22424-1-amir73il@gmail.com>
References: <20190529174318.22424-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The access limit checks on input file range in generic_remap_checks()
are redundant because the input file size is guaranteied to be within
limits and pos+len are already checked to be within input file size.

Beyond the fact that the check cannot fail, if it would have failed,
it could return -EFBIG for input file range error. There is no precedent
for that. -EFBIG is returned in syscalls that would change file length.

With that call removed, we can fold generic_access_check_limits() into
generic_write_check_limits().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
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

