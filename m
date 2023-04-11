Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CD46DD184
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 07:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjDKFWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 01:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjDKFWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:22:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FB6269E;
        Mon, 10 Apr 2023 22:22:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n14so31895592plc.8;
        Mon, 10 Apr 2023 22:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681190536; x=1683782536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGx1WHHG4yxIoqah22dglkintMa8RBxc6irauTziWjw=;
        b=dqcyZPAimsqjJnqhoUSzDw1jR6VKKfiHPJcTVneeGgAfFOzEQiC3AyncvfpFRq5KNW
         7WSZW/0N1i+RjrKKO948b9dZgP+97/TjZalZZ9M6eD/pJpckLc6BNu0UYNl6gzjmubVB
         M3Ge7vUcxWZ3E3lLZlsC47lfgYSU4LZskUViPu+QMFbN+U9Hexn8jOQP3sNuXeOlbvam
         7/vTCBpPjQdQnSGMJlu/3udMGJwn3EBxkkt4YMYlYsX0majZajBa73fd7QDO2z18+TtV
         j5bhGm/HSFlf75WJ9OoFhktC0WwUk9I/J1u2s/+jbTtmrHa/GcMcCmvWUw2GOdyB+ckv
         tIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681190536; x=1683782536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGx1WHHG4yxIoqah22dglkintMa8RBxc6irauTziWjw=;
        b=gwd8hzoRLH+k8Z7A6sh4YNu5IzfU+qltd503jShuR6zqgBvFq8x9c769beKFMiU+0H
         PC4ACT/Jx3n3256lMXnFp+3sNjxqja4IHjOMJJJ7mPuotmtiRun5vFZsG7V9aZ0lifdA
         YVV2zFnBYNblHQEt4g1AjD/Y+bhk+AH/bfwP8Cm50oP/dHIK6qGcg+cstrwS2QFEHwlM
         8E+CGario2ubYYZRiYhNp/Tvd5jdrx1pYWlN2DIuugnaP7q4ZdmULqH0ukcMRx1IqelB
         qwp5MOsI3FFAgGUSK8zs0PHJSJC5KPfmv1TuibcZas/3ev8pmEpqNeeg8+BhJppodXLH
         UcXQ==
X-Gm-Message-State: AAQBX9dCAE9xlueiAkrwlE5Ar2WGtyrd3OUb8ykVxGi9Pv3ufosu5aQO
        ygjbxjuH/+ZralMFadKoytrsFZI+gV4=
X-Google-Smtp-Source: AKy350bLyBje4Yn44rTqdahx13I4lTgh3dsSWuRTr/wCvqCgPI6NyaDSA5EC3X8tSudQJTFZnlv+zw==
X-Received: by 2002:a17:90b:4a4e:b0:246:b635:b7fc with SMTP id lb14-20020a17090b4a4e00b00246b635b7fcmr5703080pjb.5.1681190536064;
        Mon, 10 Apr 2023 22:22:16 -0700 (PDT)
Received: from rh-tp.ibmuc.com ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090abb9300b00246d7cd7327sm646154pjr.51.2023.04.10.22.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:22:15 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 2/8] libfs: Add __generic_file_fsync_nolock implementation
Date:   Tue, 11 Apr 2023 10:51:50 +0530
Message-Id: <6fad2ec25bccbbb9b3effbd18c2d6d6965b9a33c.1681188927.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681188927.git.ritesh.list@gmail.com>
References: <cover.1681188927.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some of the higher layers like iomap takes inode_lock() when calling
generic_write_sync().
Also writeback already happens from other paths without inode lock,
so it's difficult to say that we really need sync_mapping_buffers() to
take any inode locking here. Having said that, let's add a _nolock
variant of this function in libfs for now so that filesystems like
ext2 and ext4's nojournal mode can use it.

Ext4 when got converted to iomap for direct-io already copied it's own
variant of __generic_file_fsync() without lock. Hence let's add a helper
API and use it both in ext2 and ext4.

Later we can review other filesystems as well to see if we can make
_nolock as the default path if inode_lock() is not necessary here.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/libfs.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 4eda519c3002..d2dfb72e3cf8 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1110,6 +1110,49 @@ struct dentry *generic_fh_to_parent(struct super_block *sb, struct fid *fid,
 }
 EXPORT_SYMBOL_GPL(generic_fh_to_parent);
 
+/**
+ * __generic_file_fsync_nolock - generic fsync implementation for simple
+ * filesystems with no inode lock
+ *
+ * @file:	file to synchronize
+ * @start:	start offset in bytes
+ * @end:	end offset in bytes (inclusive)
+ * @datasync:	only synchronize essential metadata if true
+ *
+ * This is a generic implementation of the fsync method for simple
+ * filesystems which track all non-inode metadata in the buffers list
+ * hanging off the address_space structure.
+ */
+int __generic_file_fsync_nolock(struct file *file, loff_t start, loff_t end,
+				 int datasync)
+{
+	struct inode *inode = file->f_mapping->host;
+	int err;
+	int ret;
+
+	err = file_write_and_wait_range(file, start, end);
+	if (err)
+		return err;
+
+	ret = sync_mapping_buffers(inode->i_mapping);
+	if (!(inode->i_state & I_DIRTY_ALL))
+		goto out;
+	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
+		goto out;
+
+	err = sync_inode_metadata(inode, 1);
+	if (ret == 0)
+		ret = err;
+
+out:
+	/* check and advance again to catch errors after syncing out buffers */
+	err = file_check_and_advance_wb_err(file);
+	if (ret == 0)
+		ret = err;
+	return ret;
+}
+EXPORT_SYMBOL(__generic_file_fsync_nolock);
+
 /**
  * __generic_file_fsync - generic fsync implementation for simple filesystems
  *
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..21d2b5670308 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2935,6 +2935,7 @@ extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 		const void __user *from, size_t count);
 
+extern int __generic_file_fsync_nolock(struct file *, loff_t, loff_t, int);
 extern int __generic_file_fsync(struct file *, loff_t, loff_t, int);
 extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 
-- 
2.39.2

