Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7374F2E38C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 19:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfE2Rnn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 13:43:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35474 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfE2Rnl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 13:43:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so2181935wmi.0;
        Wed, 29 May 2019 10:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=scXNy7Kv0jk0u1cUOdecKgwqwG5sRFulap1lrncxuHo=;
        b=s+jtsDe6rXzCxWe4+vL2LKW99Wa6fSQ5fJFeqRL0+ypE7CjnvYTV/ENnJOM8O84F8G
         eyfHIA3Gs9BWZnUk8XBCWOztvFKUdmdjhcw1s3ScNe91pfBhIJsOS1aQlOESy/Pwt5OF
         EVjvnDjIC28XzmPo+yat+GOs+8DNr7Z14d8QMSGG4b2EhvxSbmF3nxvhufcpUGKZNQI6
         z9S9gjH40vjNjVDZKU9XHMl5v0gwr1KE//A9kfqIVjMFaDS5VwLVM0fodQ5ww5jy/pYR
         W7vJqwP7TbUuchqruP6RapRhdhiAnIR+37GizTbBrR/0gripwtGAuk6jFyKc/qnfAY6k
         poiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=scXNy7Kv0jk0u1cUOdecKgwqwG5sRFulap1lrncxuHo=;
        b=krXca3yrL5g1NkBNso3nsqrQzGSv+GqYEf6t4w3hh2XQPRq+BhfGsRJf25O6BWgww3
         w0LFC8q1J3DTefPeOuwxX616tNNcu6MAS3y7EemVFYQKn449HpbqavVXkY3+8bIhpOSG
         /Y4FplDT7vPUFmkjubMxTc3rwe05RcM0H1tMYG2KQc686yaea54jpH0/9epiAYV4KaV5
         jvD1tAtWIM05GuZ8sNwUfKcqn28Y3iSt0jz1eH+h5qBtwfB6qBqxgxg09C72DMvBh0QK
         Z0lhoorjlX1JqrE+AW3XNwu/nDhueWE+Lk5pg0SflntvMXEp81Ru/JEQdzk2XZrzshNh
         0UwQ==
X-Gm-Message-State: APjAAAVO0K/Q8t0q/5RGMPmlJxy2E5qbk1RAHpP8wwLevTWhVsRLHj/l
        ABoF6Yl/3YNy8WM5ICQEW1Y=
X-Google-Smtp-Source: APXvYqxhAE3qGe17aHRIuRoz8i3iWKXSr8e07GEpkjAf4PZNHDYajF6mhq35eVbjNKcCGa5E96iAoQ==
X-Received: by 2002:a1c:9904:: with SMTP id b4mr7585111wme.1.1559151819895;
        Wed, 29 May 2019 10:43:39 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id k125sm31702wmb.34.2019.05.29.10.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:43:39 -0700 (PDT)
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
Subject: [PATCH v3 06/13] vfs: introduce file_modified() helper
Date:   Wed, 29 May 2019 20:43:10 +0300
Message-Id: <20190529174318.22424-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529174318.22424-1-amir73il@gmail.com>
References: <20190529174318.22424-1-amir73il@gmail.com>
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
index df6542ec3b88..2885f2f2c7a5 100644
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
+	if (likely(file->f_mode & FMODE_NOCMTIME))
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

