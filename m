Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FDF6E0915
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 10:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDMIl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 04:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjDMIlX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:41:23 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF32786BA;
        Thu, 13 Apr 2023 01:41:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so13358648pji.1;
        Thu, 13 Apr 2023 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681375282; x=1683967282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nqs0GWdhPn+37kbmYRo+WO1uS0UsbgWQLh94vg5vg2c=;
        b=jAJwZXGKv8P8nrqTBMHoNi1ucJUMfbQkRVARvfhdayRUvEushTA39/t4rmt0h2TJH4
         GqKGptTtdyFAkmxi0YftNYXi5k1dXR7supmidRl07HS5091s+0Y9VHbUz6xZfP67V7fh
         UOCP1MsovQJ9rqy2XZ6UvXhrPMmrJeV8N7d3GScAV/a5KKvR8lMYcaUWMxtyq8UeqNP3
         bLitsERG68AT2+2NSxhzKMi2j7WLiGDI5xQ2yiPAqGg6umyMOybiQEccSxKxEPIxljvZ
         BShsP5d+wLhqkDuHhHpnNMeWiie82wl/mBpbgAKvfWRE5vSQY6hALhsWMzIZ+Np5zE4W
         mruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681375282; x=1683967282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nqs0GWdhPn+37kbmYRo+WO1uS0UsbgWQLh94vg5vg2c=;
        b=jEhQ3yfclmjw1PziMEy4DwLKmusXIcsT335FdYWd4XMI/23LQ5OFR9Dl+UU8hsxVu5
         9OStr5MdBLQEhAbqJ5UL8HY+WQE9BVPnrh52KTro6VaVbL2aevF4BhI9QmBBiP06GbU+
         WqFSg3aZ9oMJ6xieu0HjM5wFioX/U9PBcyNHzzG4KpCMERhLldnzP7ULeMldgtjhxn/g
         WEn1MDBN4PJHdJ4WIfl0H/epGBpoGBgXd4TSJvweNRoTp/9WuWXVUoYPBe0Ot9WeGhjq
         Ao16Aq04kh1g/L9Pnn2gjDAFds18OTuZTrroFO3s/ZLEGC9ictwUb4DNzm8pW78bS9x2
         aJ3Q==
X-Gm-Message-State: AAQBX9etSCVvU8mJOnqemki1ae8CIRV0jgXRxenEh+6HT3KYOa/HUogZ
        B+zWsflv7luQO/TJ6kzgwNL5gtWrKeQ=
X-Google-Smtp-Source: AKy350YSdCe1aH+gHYYWj3JznkNMGdxtlHD95bvInMmGE21WUpkTT5xzsG0pL14p1eAqL/CFtr5ZNA==
X-Received: by 2002:a05:6a20:429d:b0:ec:7332:b642 with SMTP id o29-20020a056a20429d00b000ec7332b642mr562896pzj.18.1681375281834;
        Thu, 13 Apr 2023 01:41:21 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b0063b23c92d02sm817243pfi.212.2023.04.13.01.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 01:41:21 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv3 02/10] libfs: Add __generic_file_fsync_nolock implementation
Date:   Thu, 13 Apr 2023 14:10:24 +0530
Message-Id: <e65768eb0fe145c803ba4afdc869a1757d51d758.1681365596.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681365596.git.ritesh.list@gmail.com>
References: <cover.1681365596.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Tested-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/libfs.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 4eda519c3002..054f2e0ab3cb 100644
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
+				bool datasync)
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
index c85916e9f7db..9ca3813f43e2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2935,6 +2935,8 @@ extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 		const void __user *from, size_t count);
 
+int __generic_file_fsync_nolock(struct file *file, loff_t start, loff_t end,
+				bool datasync);
 extern int __generic_file_fsync(struct file *, loff_t, loff_t, int);
 extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 
-- 
2.39.2

