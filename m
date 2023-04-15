Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED88E6E2F87
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 09:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjDOHo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 03:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjDOHow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 03:44:52 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDDD83DF;
        Sat, 15 Apr 2023 00:44:50 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-51b6d0b9430so230219a12.2;
        Sat, 15 Apr 2023 00:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681544690; x=1684136690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMu2Z6KXv/0ceszG2jht7fa1feJSyyCUFNwC5P7U1ig=;
        b=R12mBpVIScO/ybPKCDH+JA3H7SvOdnUIhGwGxVav53/bIcvfxai/+q0DQ6dvi2oLN2
         qniiJBvJekfKVTBmhhnS5kN9OP1FaYQDDMoA2bTINwznRT+F0K0ZBYCBq+R2uvhR6EgD
         OE+HHJcyKcph9LQNn3r8FDCxzueT0+VYZbzgCrsicJIShA0iDF1nP755vYNN9MYYaW4W
         DUMV7QMMb7PDWuupfrlnoXOogHWKuOPLeXSktKyojtR2fIzTrIawSTM6CnjF/+eCnid4
         zg8ak6lkMtuGnRmjUov95qXmy77hd9XIJg7F9y5HcGNFfvDm4l2y0qpP0eb5PBX11I1q
         2gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681544690; x=1684136690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMu2Z6KXv/0ceszG2jht7fa1feJSyyCUFNwC5P7U1ig=;
        b=BbXFtOra9yOdv035l3+8yLyeQI6OHSFTtI1d8Vu0yM+hVxvwNzmYIj9HmbfUEgVILh
         F0iIKHYuWNpwG4Yl3gkVqZ4LBv3sDGN8Ls+Vxw1SLVbkhhGfVtw/1JBbH5Elr5PUPgHX
         G4uZTmUQ9G9u2M/JCi73lJEIkASIFeaZas3bHylvE+FB72g4q5+LVTq8HHTdsGyQD4CV
         HAxv+VwE7ij/KsW0lPl7gZx4u0bOoOLYM9YPHZE/6+q5qZCETouNEC0HX9xEaCyO/bpC
         JralMijfQnStbbC/Z2bmyEu7PLRyXzPMX/kE8UALvirmbrIAp8C0c0pHRtE2CwZPm2rc
         QcYg==
X-Gm-Message-State: AAQBX9fWZ2KoPs2Gwxlh7oD/woFnjTvqJjO10orkauNmAwNqKqw4F8a7
        OEv5HSpIeDf6Lycg+38JBtTVdeS+X/A=
X-Google-Smtp-Source: AKy350a1py+A7j06L0ZyRrBPuohZ8Nn4i1Q0VPjHPJjZK93ITUNmMxKkUXY3eG+T9irqebwTWiy+CA==
X-Received: by 2002:a05:6a00:16c1:b0:636:4523:da93 with SMTP id l1-20020a056a0016c100b006364523da93mr12289799pfc.12.1681544689698;
        Sat, 15 Apr 2023 00:44:49 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78255000000b0063b675f01a5sm2338789pfn.11.2023.04.15.00.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 00:44:49 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv4 4/9] ext2: Use generic_buffer_fsync() implementation
Date:   Sat, 15 Apr 2023 13:14:25 +0530
Message-Id: <ab353c31861853abe4836143dc2674c463bdd986.1681544352.git.ritesh.list@gmail.com>
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

