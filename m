Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA5E6EA77B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 11:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjDUJrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 05:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjDUJrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:47:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C1BBBB2;
        Fri, 21 Apr 2023 02:46:35 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b73203e0aso13007206b3a.1;
        Fri, 21 Apr 2023 02:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682070394; x=1684662394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2loVQHnXEIbRgzz0wwtKakik0SwqtSHBFppUgBXyaA=;
        b=ig1YH4PMLoWN8eaoh/N6KGCMQwWD1ucvBaT9UF34yNxuNnbrJt3nJSIpFm9pFr2Eht
         M5O3DU1USYqaO1bLFzuy8aa+phJoAYYxvQQhuztBPbIfdb6O/WlaBus1SS2VzAoao62r
         OKSjplRtMGGhFZP7DQJpVNNSPSiwIY0cZ4/f1I4/mavAifnQC+sY1Habn2LLQv6Fd7mO
         k1ZIKVtU0i7u86oxmXbUU05nDhhjjx2bBS8cgpXRxIxowLlfUjr9b7tgIjSFePOcZXi2
         nPFD6bv7aCJNrxYEMC6NoTpeaftEnGElUjisuG4tOBIOvkAMbhr903QFSmdG83WNKa4l
         ANag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682070394; x=1684662394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2loVQHnXEIbRgzz0wwtKakik0SwqtSHBFppUgBXyaA=;
        b=Fx/ViFnVZ2XJIRi7n/Vy4olBhunNhUbx1m16Ku9HouQiGIs2OwdO4b1DUoBMEwQfTo
         gV+yhf62GT/4kx8at5F8+f1wC+5RkdlHEB+rq2gnyl470WxM8wErrO8t99cQeXklm+ax
         Ihp6V0h9WXuFghLOpIdr6QlF7aTNC+diSydYMuqJKmDq0J+oIjYayT8a173m5Vfu+HfI
         aRCIuE0R+Y2/il/Gqhd7eaG1s+SpLdoD3wS8wRrtRHij3qWlnabeAvGUejXIfeWjBUFk
         HRsWVGvHvfuqIeCJyolxcIARo6nDDJ6oCszlYj2F1X2nm5CeVonGy4Ur68aH0Eq53A+3
         KarQ==
X-Gm-Message-State: AAQBX9cPwDFg0el3RP9b/t/p3SNYaCcC8UF+tEH5rd17QDPa8Sol6hDT
        /esVDoyXxGDiVEIyeLTw3n/AeFhS31s=
X-Google-Smtp-Source: AKy350ZLZkQ8ekBpMaaJsLEP2vBvCGrhIw0sqxkg1YyCee/vyeLVx5nfIrlOocRbPf+4Kp+sSyyR8Q==
X-Received: by 2002:a05:6a20:918c:b0:e9:4683:284a with SMTP id v12-20020a056a20918c00b000e94683284amr6414904pzd.4.1682070394733;
        Fri, 21 Apr 2023 02:46:34 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id w35-20020a631623000000b0051f15c575fesm2295376pgl.87.2023.04.21.02.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:46:34 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv6 2/9] fs/buffer.c: Add generic_buffers_fsync*() implementation
Date:   Fri, 21 Apr 2023 15:16:12 +0530
Message-Id: <d573408ac8408627d23a3d2d166e748c172c4c9e.1682069716.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1682069716.git.ritesh.list@gmail.com>
References: <cover.1682069716.git.ritesh.list@gmail.com>
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
generic_buffers_fsync/_noflush() implementation in buffer.c with no
inode_lock/unlock() for now so that filesystems like ext2 and
ext4's nojournal mode can use it.

Ext4 when got converted to iomap for direct-io already copied it's own
variant of __generic_file_fsync() without lock.

This patch adds generic_buffers_fsync()
& generic_buffers_fsync_noflush() implementations for use in filesystems
like ext2 & ext4 respectively.

Later we can review other filesystems as well to see if we can make
generic_buffers_fsync/_noflush() which does not take any inode_lock() as
the default path.

Tested-by: Disha Goel <disgoel@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/buffer.c                 | 70 +++++++++++++++++++++++++++++++++++++
 include/linux/buffer_head.h |  4 +++
 2 files changed, 74 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9e1e2add541e..05febfbaecdc 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -593,6 +593,76 @@ int sync_mapping_buffers(struct address_space *mapping)
 }
 EXPORT_SYMBOL(sync_mapping_buffers);
 
+/**
+ * generic_buffers_fsync_noflush - generic buffer fsync implementation
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
+int generic_buffers_fsync_noflush(struct file *file, loff_t start, loff_t end,
+				  bool datasync)
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
+EXPORT_SYMBOL(generic_buffers_fsync_noflush);
+
+/**
+ * generic_buffers_fsync - generic buffer fsync implementation
+ * for simple filesystems with no inode lock
+ *
+ * @file:	file to synchronize
+ * @start:	start offset in bytes
+ * @end:	end offset in bytes (inclusive)
+ * @datasync:	only synchronize essential metadata if true
+ *
+ * This is a generic implementation of the fsync method for simple
+ * filesystems which track all non-inode metadata in the buffers list
+ * hanging off the address_space structure. This also makes sure that
+ * a device cache flush operation is called at the end.
+ */
+int generic_buffers_fsync(struct file *file, loff_t start, loff_t end,
+			  bool datasync)
+{
+	struct inode *inode = file->f_mapping->host;
+	int ret;
+
+	ret = generic_buffers_fsync_noflush(file, start, end, datasync);
+	if (!ret)
+		ret = blkdev_issue_flush(inode->i_sb->s_bdev);
+	return ret;
+}
+EXPORT_SYMBOL(generic_buffers_fsync);
+
 /*
  * Called when we've recently written block `bblock', and it is known that
  * `bblock' was for a buffer_boundary() buffer.  This means that the block at
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 8f14dca5fed7..105b67c2a7a8 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -211,6 +211,10 @@ int inode_has_buffers(struct inode *);
 void invalidate_inode_buffers(struct inode *);
 int remove_inode_buffers(struct inode *inode);
 int sync_mapping_buffers(struct address_space *mapping);
+int generic_buffers_fsync_noflush(struct file *file, loff_t start, loff_t end,
+				  bool datasync);
+int generic_buffers_fsync(struct file *file, loff_t start, loff_t end,
+			  bool datasync);
 void clean_bdev_aliases(struct block_device *bdev, sector_t block,
 			sector_t len);
 static inline void clean_bdev_bh_alias(struct buffer_head *bh)
-- 
2.39.2

