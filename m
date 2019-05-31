Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1CE3312DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 18:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfEaQr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 12:47:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36176 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfEaQrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 12:47:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id v22so6350709wml.1;
        Fri, 31 May 2019 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jGXSvLa7NNCoOVvlvMxKeItWZVCcyVMKXFY2Xr6oVfM=;
        b=XwdbJXZDONlGTsiGHQlCU9tuovtGGMRRnMtHaj8HzeH3pB7ZlJ4kKQm5PlwcCgXoxS
         r3Pbcy63CkUe1x2o3uOclLYLEfb9QJasjsEarxAqxFIQRanhGb9AYoyZYEGk9M0ob+YJ
         9gSWG922Bafz2y12P7T8ISgOiFq0CampMVDrryxwOlBHh8J7hOgGoY2BgFY5uTAcY6vA
         wKlMjFV1f+DBMRlEh3v61jPS3NA2+6IG9bjGH6BZVJxFwdL79ASXP4sa9y/agNMaJyOY
         /WvXqvIyDKujS8a4byEXP+r0Kz56D3gs045G1CtYH1XVW290b86B/kbkfnMQCKOINLNc
         DeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jGXSvLa7NNCoOVvlvMxKeItWZVCcyVMKXFY2Xr6oVfM=;
        b=C8Oyc13coVtT399eWPulwOkZ9abJBgpLw3BxZFp2Cg6ucNFgD3yh15YCuozQF8I5ml
         lR6KfGO2zcqW1UKo3p/nAxrn9AUokMiJvmuZ3DccESn4Nt94kdbffXLioy8PLz6wYqqb
         JeVTYfBnbrcClK1YF+gz1aHIvrlkBWVGggqsRM5di8Itiwn6G6ZUTtDV7WINWtDXheP/
         N+4OPqZc4CPrAaOHgxIQdJ0hdsLDhC6hQHF5m5OOix5V5vbSpD97P9o2FYk2RofcZfnk
         7fANlBgEt3YVZK+uhc28WDQJ/T4t0+eOkMqdlOUs9OHJYgCjE2RUqjl02zolbOyeJCSW
         JHDA==
X-Gm-Message-State: APjAAAULY3ikgCto8nwa/76HA6rX8NsPKTMjzQwNoqpr2S+NmzseFz0k
        7bRU5l5GBWNdCzh1tUDvUDU=
X-Google-Smtp-Source: APXvYqwHKCdYfvR2HLz+xaIUZ1eV2cOfULE8MIAz9Yk42YD3i5z7576EF9U2LJ+AQNXtv18H+34TJg==
X-Received: by 2002:a1c:7f10:: with SMTP id a16mr6398399wmd.30.1559321240180;
        Fri, 31 May 2019 09:47:20 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id n5sm7669593wrj.27.2019.05.31.09.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 09:47:19 -0700 (PDT)
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
Subject: [PATCH v4 6/9] vfs: introduce file_modified() helper
Date:   Fri, 31 May 2019 19:46:58 +0300
Message-Id: <20190531164701.15112-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531164701.15112-1-amir73il@gmail.com>
References: <20190531164701.15112-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The combination of file_remove_privs() and file_update_mtime() is
quite common in filesystem ->write_iter() methods.

Modelled after the helper file_accessed(), introduce file_modified()
and use it from generic_remap_file_range_prep().

Note that the order of calling file_remove_privs() before
file_update_mtime() in the helper was matched to the more common order by
filesystems and not the current order in generic_remap_file_range_prep().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/inode.c         | 20 ++++++++++++++++++++
 fs/read_write.c    | 21 +++------------------
 include/linux/fs.h |  2 ++
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index df6542ec3b88..4348cfb14562 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1899,6 +1899,26 @@ int file_update_time(struct file *file)
 }
 EXPORT_SYMBOL(file_update_time);
 
+/* Caller must hold the file's inode lock */
+int file_modified(struct file *file)
+{
+	int err;
+
+	/*
+	 * Clear the security bits if the process is not being run by root.
+	 * This keeps people from modifying setuid and setgid binaries.
+	 */
+	err = file_remove_privs(file);
+	if (err)
+		return err;
+
+	if (unlikely(file->f_mode & FMODE_NOCMTIME))
+		return 0;
+
+	return file_update_time(file);
+}
+EXPORT_SYMBOL(file_modified);
+
 int inode_needs_sync(struct inode *inode)
 {
 	if (IS_SYNC(inode))
diff --git a/fs/read_write.c b/fs/read_write.c
index b0fb1176b628..cec7e7b1f693 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1980,25 +1980,10 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 		return ret;
 
 	/* If can't alter the file contents, we're done. */
-	if (!(remap_flags & REMAP_FILE_DEDUP)) {
-		/* Update the timestamps, since we can alter file contents. */
-		if (!(file_out->f_mode & FMODE_NOCMTIME)) {
-			ret = file_update_time(file_out);
-			if (ret)
-				return ret;
-		}
+	if (!(remap_flags & REMAP_FILE_DEDUP))
+		ret = file_modified(file_out);
 
-		/*
-		 * Clear the security bits if the process is not being run by
-		 * root.  This keeps people from modifying setuid and setgid
-		 * binaries.
-		 */
-		ret = file_remove_privs(file_out);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(generic_remap_file_range_prep);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e4d382c4342a..79ffa2958bd8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2177,6 +2177,8 @@ static inline void file_accessed(struct file *file)
 		touch_atime(&file->f_path);
 }
 
+extern int file_modified(struct file *file);
+
 int sync_inode(struct inode *inode, struct writeback_control *wbc);
 int sync_inode_metadata(struct inode *inode, int wait);
 
-- 
2.17.1

