Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967E96E2F83
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 09:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjDOHoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDOHot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 03:44:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140CF868B;
        Sat, 15 Apr 2023 00:44:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-246eebbde1cso1108634a91.3;
        Sat, 15 Apr 2023 00:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681544684; x=1684136684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JODBs8P43hIsjCqqKREf8+XQIM2HCnjU8ac1MO4CF9k=;
        b=TuqKnR0o5I31KY6e/wi+o6tNH9OI89axfVGQkYcEZnSmZQEv7Jw9B8oFIO2jl+qhRU
         HMpfSvYdg6JVnD+zL4Mzy9fk3OYa6vkifgouGHc9uuAzdEBLfmv88+yRzpC/Wye9DqM1
         Jsm0MHWy8acyyZ7Sk8daYEyoxYTNiT8EAwsw4htv57sBXDW0NPToSj7amozmSUzjL11q
         MlpCANPD+dhLi3p7D/mBzuDhWy5rhbd69ielYZav9IWK8uwhRBoV5pHAf9QZTuIxUcpx
         zUG7xbnqknUbWwh/qA8T6cog8Er051vfvJ1J7CCsHfKBfSKHXuAVUtFcorms24h/weAN
         BCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681544684; x=1684136684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JODBs8P43hIsjCqqKREf8+XQIM2HCnjU8ac1MO4CF9k=;
        b=QJdT4JL8p18BDMSNS+Kd9tXtKi3enCo9eEU2c05Z2emhI6rHHrq/sU5pm/Nr+ZlNiG
         ddwSR4FIkvGiQNldCr3NOvkXTvoZLo3WKOsY0rN89mLQvsQ1zxLtq/7MsWXc0wbcTCYr
         pyMJY786JWYkjQlOs1oe3HexDjnp9TOFfyeldBLBdNrPhvqrj7y0lMzIFDfUeDBzrj6+
         uGIa+6yj9v237ENNT/XuebcyD0JG/E5JeRk9SNTdC3rn5wAmb1WBXQMZs5jhUw+gVDAe
         icOecZeFwIC41uBO7f7eQ5lU4YfAqKpen7flzFyxwne8CiALSDZaorQqjEjr3LkR9wpT
         9hlA==
X-Gm-Message-State: AAQBX9eiI/6AfWc30sT/6DHN+NE5+7rAOBpM2jqegtC3KLCoAa9U7QXP
        IGTnWdgi/siITr5AdfNdeDQbBZtZgoA=
X-Google-Smtp-Source: AKy350bzHhQ5NkkCLeAdY3bmXMZ1yRt4VLg/Ib/J5UuMSngm0T53CeysT2Mobk25WBpXUyjm6kfJjA==
X-Received: by 2002:a05:6a00:168e:b0:626:2984:8a76 with SMTP id k14-20020a056a00168e00b0062629848a76mr11872495pfc.34.1681544684189;
        Sat, 15 Apr 2023 00:44:44 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78255000000b0063b675f01a5sm2338789pfn.11.2023.04.15.00.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 00:44:43 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv4 2/9] fs/buffer.c: Add generic_buffer_fsync implementation
Date:   Sat, 15 Apr 2023 13:14:23 +0530
Message-Id: <5969eb067ad38272a1bb0df516965301ff08a919.1681544352.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681544352.git.ritesh.list@gmail.com>
References: <cover.1681544352.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some of the higher layers like iomap takes inode_lock() when calling
generic_write_sync().
Also writeback already happens from other paths without inode lock,
so it's difficult to say that we really need sync_mapping_buffers() to
take any inode locking here. Having said that, let's add
generic_buffer_fsync() implementation in buffer.c with no
inode_lock/unlock() for now so that filesystems like ext2 and
ext4's nojournal mode can use it.

Ext4 when got converted to iomap for direct-io already copied it's own
variant of __generic_file_fsync() without lock. Hence let's add a helper
API and use it both in ext2 and ext4.

Later we can review other filesystems as well to see if we can make
generic_buffer_fsync() which does not take any inode_lock() as the
default path.

Tested-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/buffer.c                 | 43 +++++++++++++++++++++++++++++++++++++
 include/linux/buffer_head.h |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9e1e2add541e..df98f1966a71 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -593,6 +593,49 @@ int sync_mapping_buffers(struct address_space *mapping)
 }
 EXPORT_SYMBOL(sync_mapping_buffers);
 
+/**
+ * generic_buffer_fsync - generic buffer fsync implementation
+ * for simple filesystems with no inode lock
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
+int generic_buffer_fsync(struct file *file, loff_t start, loff_t end,
+			 bool datasync)
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
+EXPORT_SYMBOL(generic_buffer_fsync);
+
 /*
  * Called when we've recently written block `bblock', and it is known that
  * `bblock' was for a buffer_boundary() buffer.  This means that the block at
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 8f14dca5fed7..3170d0792d52 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -211,6 +211,8 @@ int inode_has_buffers(struct inode *);
 void invalidate_inode_buffers(struct inode *);
 int remove_inode_buffers(struct inode *inode);
 int sync_mapping_buffers(struct address_space *mapping);
+int generic_buffer_fsync(struct file *file, loff_t start, loff_t end,
+			 bool datasync);
 void clean_bdev_aliases(struct block_device *bdev, sector_t block,
 			sector_t len);
 static inline void clean_bdev_bh_alias(struct buffer_head *bh)
-- 
2.39.2

