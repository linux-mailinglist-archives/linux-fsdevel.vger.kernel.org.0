Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD4A6E36ED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 12:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDPKJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 06:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjDPKJE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:09:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EE81701;
        Sun, 16 Apr 2023 03:09:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b2-20020a17090a6e0200b002470b249e59so12253446pjk.4;
        Sun, 16 Apr 2023 03:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681639742; x=1684231742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlK5f0p2tRjTAzbZYwUDkCjIL8w12wMg+uz1sNNRK7A=;
        b=QIp8o+aizrJ/TmO209+AELc1h8i/Jgtt0pRcWn4bHZf5jlhwBlUY1pAmUAdo1fIx/5
         G3fUba+QujLZDlvedU8jgRKfPfHtPZCv+KaJeWT4RTHcZYcCdOpbEWwphgsm2U+hD9PN
         YPFONZCtsz7Iwhc+EwqrFDi4Mr405axNgcPoWeYSOdEuh7F7agvzau8inhnm98G41a70
         lvJSUS7VSJ9QmLhoGEZnoGuWUMwmI02fkqleAuDaqmd2QHMWDcMiOmWhV1I1TKEIQNtq
         1ghS33hsSF+BsaS/RQaEaJQXpMFUr84BPiol0CA0RvSSq0IgfVA1M7l5zOyWgR8BBTeN
         TdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681639742; x=1684231742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlK5f0p2tRjTAzbZYwUDkCjIL8w12wMg+uz1sNNRK7A=;
        b=HdRW8fDhaPTg9Hj52k8ptFi8j9UaEGqzOSkYooeKGI7FQ7AbFK/BYTdLB71glLdu+3
         kn3Lb5yxL8md/fgNE2H4wEl0IipQtyBDIXrw8m3D+6sSSzH/8hFtzBpyUd2QBQPr9lfL
         GGl3Rh1KcS3+L2cd7vI7ClcsG5J974anuyryO7REDHXgKxDnScFH+Rf4v51+rErN/Mzf
         ucc02YFXA4LXCmqB58WJ5Rli2UKSMY/kG0SPyrVTnE9HBkdUTR3/7UBKeF4YSMk+NLjG
         7tXDx+RkVpD1mkAWZbTrWVwtRCMQLb+Yq2uVc+gtAD4o4ZYsp2zAbXuwedJwjN4O8YOH
         c+iA==
X-Gm-Message-State: AAQBX9dmFAuqGcSfMJO7ae8SC4MhQRA9j6i0b/P1c/ul//C5TG68pAMd
        ZgUIWoZsrUd13SZu1mv18cviqe5HkJQ=
X-Google-Smtp-Source: AKy350aflP2A2JoECj/JkwBxHJGgqBK5qiQwV5ZnVHpRm9B0Xy1Svjg9bEmvGIgEvcTjD1GgKcEVLQ==
X-Received: by 2002:a05:6a20:440c:b0:ee:9647:45fa with SMTP id ce12-20020a056a20440c00b000ee964745famr7326652pzb.20.1681639741997;
        Sun, 16 Apr 2023 03:09:01 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id h9-20020aa786c9000000b0063b733fdd33sm3096057pfo.89.2023.04.16.03.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:09:01 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv5 2/9] fs/buffer.c: Add generic_buffer_fsync implementation
Date:   Sun, 16 Apr 2023 15:38:37 +0530
Message-Id: <7a7c48bf0a91d00f1114db2dc6b1269c25f7513b.1681639164.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681639164.git.ritesh.list@gmail.com>
References: <cover.1681639164.git.ritesh.list@gmail.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

