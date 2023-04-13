Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF826E091B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 10:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDMIln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 04:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjDMIl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:41:29 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF0B83F8;
        Thu, 13 Apr 2023 01:41:28 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b27afefacso113848b3a.1;
        Thu, 13 Apr 2023 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681375287; x=1683967287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNOw2u2eN+tovkE55NV5VEud2NLie+WZxAuBLZs7iOE=;
        b=WZ2z9ywkElikDuGBRjkOaReSMnzPZ6MVKwHDMlVy6nmkUvJN7CSRpAxRWzK/9P3UxL
         ih9eDFYAYSONYEL8mi57kf4vI7tzjKrRrIC6/fRhyWOR6XB2pRN9V8tnAdhcO5y6+2fs
         ayjJ3Ac8gcNVn48O35WpeVY1oBIUVUcVxmPdeIrVzS02aIc2U+65Dt4CW7gR/5xjHgXR
         4kfMLQRdZ5+hEeaUb4XRRXmYy6fsdOQc6+ov0duxRUK+Jn+dA0U06KKQFuN0+Wpe14nB
         YGelnSyu9UsP0EJDOuWefc88avoznLIZIRAUl9Q5JtplTQRkim+DUW4dq/0L8rAwA4/N
         nUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681375287; x=1683967287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNOw2u2eN+tovkE55NV5VEud2NLie+WZxAuBLZs7iOE=;
        b=dpLh5WNMkbfwjcr8tNJ5nfOdMpGkGwn3BIk+pLiDUkppO4XnfvWZaTIF8LoO46ekjg
         2VcGwXm0r0K/f5tGlkzu0lPe/gILAW9Fdh6QcpvWK4SM2SFIRtIsiQ9TG8hInlKDk+on
         8WSptnfV7G63nQq/xWwPAkST6mbrxstik0PLRF4S4EnQrZoUHccV4uzrbjPoTBG4O12k
         BezDNzu8cYrKlgpVXFK2Gjy6GjV3AzQeujw9d05h4lsq4ukXjdPaqE1IbwxnErYCjcT8
         KMVrHu1es/Sag/l70dvjCcuDXsCKWyJjnTlHQF/3hpcwTzFGJjIDM3YObZ7C6fpcOrmz
         I8Yg==
X-Gm-Message-State: AAQBX9dHhlhhBRJNBeiLgaW6GWWZFQUpQ/uIfXl5oG/8MRa3J13McwMU
        9K68sUYGqcE8860T0UkSP3w/RV0Msxg=
X-Google-Smtp-Source: AKy350aoUTUzMsqvzqRMnUga31Qax0vGfLL3jvS3AOEmZ2sEeXA2MD3TKRqq8riz4b/GZXoq+Atzhg==
X-Received: by 2002:a05:6a00:2448:b0:63a:cefa:9d44 with SMTP id d8-20020a056a00244800b0063acefa9d44mr2306945pfj.14.1681375287294;
        Thu, 13 Apr 2023 01:41:27 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b0063b23c92d02sm817243pfi.212.2023.04.13.01.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 01:41:27 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv3 04/10] ext2: Use __generic_file_fsync_nolock implementation
Date:   Thu, 13 Apr 2023 14:10:26 +0530
Message-Id: <41ba782c0467b46a6cf9e69bd651fbb3c33a78f4.1681365596.git.ritesh.list@gmail.com>
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

Next patch converts ext2 to use iomap interface for DIO.
iomap layer can call generic_write_sync() -> ext2_fsync() from
iomap_dio_complete while still holding the inode_lock().

Now writeback from other paths doesn't need inode_lock().
It seems there is also no need of an inode_lock for
sync_mapping_buffers(). It uses it's own mapping->private_lock
for it's buffer list handling.
Hence this patch is in preparation to move ext2 to iomap.
This uses __generic_file_fsync_nolock() variant in ext2_fsync().

Tested-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 6b4bebe982ca..1d0bc3fc88bb 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -153,7 +153,9 @@ int ext2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	int ret;
 	struct super_block *sb = file->f_mapping->host->i_sb;
 
-	ret = generic_file_fsync(file, start, end, datasync);
+	ret = __generic_file_fsync_nolock(file, start, end, datasync);
+	if (!ret)
+		ret = blkdev_issue_flush(sb->s_bdev);
 	if (ret == -EIO)
 		/* We don't really know where the IO error happened... */
 		ext2_error(sb, __func__,
-- 
2.39.2

