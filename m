Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7F46E36F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 12:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDPKJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 06:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjDPKJU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:09:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328EE10D4;
        Sun, 16 Apr 2023 03:09:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v21-20020a17090a459500b0024776162815so1705629pjg.2;
        Sun, 16 Apr 2023 03:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681639747; x=1684231747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMu2Z6KXv/0ceszG2jht7fa1feJSyyCUFNwC5P7U1ig=;
        b=bLgqLIACS1CCHmGinY8/zBtdiUFCZp4cqyIzQ++wFfJe5pVx8xIsTTHiRRr6mPPQVA
         1m9HUbVZH4Lk3hEbtQ1MVOnwCottahR8itjg2A+nKh8lj6PK17R/Dun4RZkUBmzpRjpl
         38RAeHMmTFxZYB/EkFNehWlPib/fEQ/9RhJBkvZJPiabRSVFri5h7eXVBIdSAcPLsmq1
         VR0eTcoCrP5yn7fq3bwT4OumePc1XitaK8UBK0tm9kPXBlN1NdK8ynNYHH8eTq/Emg8d
         rd0VNVEqlT2ssedpovxXwbs0bVW9WJNoMs3fNgQsQB4BK0SlPeNx9qGIcGW0luBkTZ4M
         LUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681639747; x=1684231747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMu2Z6KXv/0ceszG2jht7fa1feJSyyCUFNwC5P7U1ig=;
        b=M8vsvkWl/EV9l2ZiYQQC8vBGaoio+4+L0UI57P9HPbfzNo/nLKleNt0PyDkWgWxu9s
         jk4IAdEnoCHSUs+9FCp7EwToOtQIXA35YeRO337lvOf0EHCukQrQv6/rgpp+UJoDF8wt
         wj3tyF9w24y440w0bi5VsV9UEEelvJBrFQVYVTTufjlNOT72kztDyYZi+vkkxUoXTZ76
         Akxn0UfnEiRZ9oOw5Kfhf/Ch1G2ZXqgHu0yzvB5Opjccmyv5pYABINu8TIYckzqU7dD7
         qDLVLfhnR4YxJ/nQpE/SzKdY/njec7AmkLpSRVencSOGVrbK9o/886vEQh48tdoiWmI4
         tSQg==
X-Gm-Message-State: AAQBX9eW6piNQvwPrUyb45GfFSAQ7ljW9UjCKYTCdaxAWUwkyCLI2D+/
        E/9PrQIsys0Zjq9zr53LovRo9MLXetg=
X-Google-Smtp-Source: AKy350Y9UvSuXwpXslvb8G7+QVEwZtDmSkLF/B8fgtD5hc0ut75RPnkclbX1B3qYMYUh1QSVJYb2/Q==
X-Received: by 2002:a05:6a20:77af:b0:d9:237e:9d08 with SMTP id c47-20020a056a2077af00b000d9237e9d08mr10390217pzg.3.1681639747378;
        Sun, 16 Apr 2023 03:09:07 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id h9-20020aa786c9000000b0063b733fdd33sm3096057pfo.89.2023.04.16.03.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:09:07 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv5 4/9] ext2: Use generic_buffer_fsync() implementation
Date:   Sun, 16 Apr 2023 15:38:39 +0530
Message-Id: <63f1a424daebbacd758f73425b2f3b3787c12738.1681639164.git.ritesh.list@gmail.com>
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

Next patch converts ext2 to use iomap interface for DIO.
iomap layer can call generic_write_sync() -> ext2_fsync() from
iomap_dio_complete while still holding the inode_lock().

Now writeback from other paths doesn't need inode_lock().
It seems there is also no need of an inode_lock() for
sync_mapping_buffers(). It uses it's own mapping->private_lock
for it's buffer list handling.
Hence this patch is in preparation to move ext2 to iomap.
This uses generic_buffer_fsync() which does not take any inode_lock()
in ext2_fsync().

Tested-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 6b4bebe982ca..7603427fb38f 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -25,6 +25,7 @@
 #include <linux/quotaops.h>
 #include <linux/iomap.h>
 #include <linux/uio.h>
+#include <linux/buffer_head.h>
 #include "ext2.h"
 #include "xattr.h"
 #include "acl.h"
@@ -153,7 +154,9 @@ int ext2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	int ret;
 	struct super_block *sb = file->f_mapping->host->i_sb;
 
-	ret = generic_file_fsync(file, start, end, datasync);
+	ret = generic_buffer_fsync(file, start, end, datasync);
+	if (!ret)
+		ret = blkdev_issue_flush(sb->s_bdev);
 	if (ret == -EIO)
 		/* We don't really know where the IO error happened... */
 		ext2_error(sb, __func__,
-- 
2.39.2

