Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8546EA77F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 11:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjDUJrd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 05:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjDUJrZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:47:25 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB14EB778;
        Fri, 21 Apr 2023 02:46:47 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b5c4c769aso2759586b3a.3;
        Fri, 21 Apr 2023 02:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682070400; x=1684662400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6NTvJZR5izvfH9V8WT4r3UxcM8ySPD3DVNjQh8XTKU=;
        b=Y8lOwa8kGb1sYFvDNYUKcJ88Ppy+zioqFJ55wRp4ebrAq+109F3YnU+ZOE39u9+/q2
         cP45zOHFe4UkG6BNuII2xnFFw16RvcfXWR+b6babMEp3iFh8XO4orCa49/YlajSlEwfr
         ID4Q4ZO3E9PXpMtpSp3AIAosjpGXrOdna3vdyGj76AFW9UmuMoFijcP5xkaKYKCKaLCy
         THu/Gc76ssfol2LOrwJ71UfdVH9tmbIuOTCVlBL3+6mH+onTPnkzpSYtevKWkp7y115m
         +6EnVeY4GB6If2UFUu2txkriuI/k7yKOCXBNx9rbmS6ybH18dygCcvFTAxH6YIuNCsde
         pNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682070400; x=1684662400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6NTvJZR5izvfH9V8WT4r3UxcM8ySPD3DVNjQh8XTKU=;
        b=FJOZos4fRg1uzFlUR2uM+AFrDjuPZOxwMHyh8isWE0o7kEt5H/GtIzTkN00Jf3VRpZ
         fYsNt+O+qxtRjK1v3I8ULT0TGP0t4R2EUx0LXKsKaRMMYZS7kJbmsSJ28Tlg8DKRLWev
         X5IBtG0AW7+8YLv9bjg0m0nBGPEernUYjQkFR2owf0IDaCAxtg6oNj9El+6kcFgmzpWo
         kmj6gon51bQf7fb8W4/rspRxMMBOBIPpwR9Noo3/MryDhR2729/GPsYOvqCquiwy912r
         9d7wGWEPoD1hVdGe7725OJBpTO2mgXaqA70Ue0yVuel574TxoVpTf0/FMpe1jvHdZqZr
         +5zQ==
X-Gm-Message-State: AAQBX9cS3Ca0xHQ1XAx5Eihcq5BzndnwBylG6Vhc53Z+jhmlmfxLw0ph
        1kRmLPTrbdha9SPjFzyBZLRqjHMvc9k=
X-Google-Smtp-Source: AKy350bA3Qub3Rc6TphC4fWF82RfZgxFGAe3hHcpTZHMxZRj3GEkTQsdr9kiwDBJw2FDyxX5g9mXyA==
X-Received: by 2002:a05:6a00:24ca:b0:63a:ea82:b7b7 with SMTP id d10-20020a056a0024ca00b0063aea82b7b7mr5501848pfv.28.1682070400470;
        Fri, 21 Apr 2023 02:46:40 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id w35-20020a631623000000b0051f15c575fesm2295376pgl.87.2023.04.21.02.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:46:40 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv6 4/9] ext2: Use generic_buffers_fsync() implementation
Date:   Fri, 21 Apr 2023 15:16:14 +0530
Message-Id: <76d206a464574ff91db25bc9e43479b51ca7e307.1682069716.git.ritesh.list@gmail.com>
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

Next patch converts ext2 to use iomap interface for DIO.
iomap layer can call generic_write_sync() -> ext2_fsync() from
iomap_dio_complete while still holding the inode_lock().

Now writeback from other paths doesn't need inode_lock().
It seems there is also no need of an inode_lock() for
sync_mapping_buffers(). It uses it's own mapping->private_lock
for it's buffer list handling.
Hence this patch is in preparation to move ext2 to iomap.
This uses generic_buffers_fsync() which does not take any inode_lock()
in ext2_fsync().

Tested-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 6b4bebe982ca..749163787139 100644
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
@@ -153,7 +154,7 @@ int ext2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	int ret;
 	struct super_block *sb = file->f_mapping->host->i_sb;
 
-	ret = generic_file_fsync(file, start, end, datasync);
+	ret = generic_buffers_fsync(file, start, end, datasync);
 	if (ret == -EIO)
 		/* We don't really know where the IO error happened... */
 		ext2_error(sb, __func__,
-- 
2.39.2

