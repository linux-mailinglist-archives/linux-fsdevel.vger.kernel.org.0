Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745306EA787
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 11:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjDUJrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 05:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjDUJr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:47:27 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D65BB95;
        Fri, 21 Apr 2023 02:46:53 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b7588005fso1834685b3a.0;
        Fri, 21 Apr 2023 02:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682070412; x=1684662412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3bFGTlu3ywJiImKEXsaqXr4UVp+VKQfACyqLEyVcDA=;
        b=GmMHlVilRbuUP0UQDM6tw4M93O1CoIq8JjNjSWSek7yNzvAxMW3zMPzDCUxiu2iURt
         cpTBT74J7490z2MS1HDeu5xwRwSKulSwuinosvVU/mApqlRMuUVTIBYlrLMvUjOCEVwb
         ZyVEfnXWJGltZtkbHl1ERKjXZ6p7EZ/g/IZsmdNi4Wh3BprT3H5ol6B9pRq5uvpf44RB
         MO0+CGxCnQDJSgw+ghzhKI18SK8F+JZKyoW/bjjrV+t3UbJhYGXEw9jX67QCRWSX3HBO
         VqzispF+YqcchQR5MrK1dOxrUE5R6AK9zuUB9ciw3JiG7HEiQcFqdpBdOQHbv8yRH5jS
         BGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682070412; x=1684662412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3bFGTlu3ywJiImKEXsaqXr4UVp+VKQfACyqLEyVcDA=;
        b=BifoCkrlWQW1ua3J0Agat4Gyk+tSknBVRDPf+zePqwlBADVl45u4zscu1TQDT64LBB
         W78JJ28KmbQn9Lt3A+QoQWR+lheG+30vt4qe9fyspjASxkuTB9Y+GAFt+i21rn0nB1wa
         vjIvXO/pCI3r8CmHaMkALStjBxt8XCovaYV3dfUc03TG5Y9MJt4C/IpEzGrhiAa1J6ES
         ngq0EZUu0UINv9SDshpY/yFi2AGSf5x+OocXCZ8p6vLWJeohqu3sfIGg9T/yLeXIL8ZU
         KXQzEDMho8JdCStRvztMPV8YGZRu0ywp9iUL+CJKCnM1r76KhYFA+D7MQs8HMOFOjFYa
         yBbA==
X-Gm-Message-State: AAQBX9chKHrYj8cqsDeFAZ8Dp4bPIyjN9d91UMsatOgU7RxOLVAPMC/0
        BB5DKhwp5CFhn7VirjDjenDKBdLVaxk=
X-Google-Smtp-Source: AKy350Y46q76zNzaPLJ5WU7G+2P+pyhKKkv4bnTmPf17P9WVT6E8hNyZWDtr7t891mc5f7tJOiUXuQ==
X-Received: by 2002:a05:6a20:94ce:b0:eb:c227:d517 with SMTP id ht14-20020a056a2094ce00b000ebc227d517mr5706936pzb.9.1682070412589;
        Fri, 21 Apr 2023 02:46:52 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id w35-20020a631623000000b0051f15c575fesm2295376pgl.87.2023.04.21.02.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:46:52 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv6 8/9] iomap: Remove IOMAP_DIO_NOSYNC unused dio flag
Date:   Fri, 21 Apr 2023 15:16:18 +0530
Message-Id: <744d0e54ec73f38c8d61a3e4cf8fd030b2c1a8cf.1682069716.git.ritesh.list@gmail.com>
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

IOMAP_DIO_NOSYNC earlier was added for use in btrfs. But it seems for
aio dsync writes this is not useful anyway. For aio dsync case, we
we queue the request and return -EIOCBQUEUED. Now, since IOMAP_DIO_NOSYNC
doesn't let iomap_dio_complete() to call generic_write_sync(),
hence we may lose the sync write.

Hence kill this flag as it is not in use by any FS now.

Tested-by: Disha Goel <disgoel@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/direct-io.c  | 2 +-
 include/linux/iomap.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f771001574d0..36ab1152dbea 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -541,7 +541,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		}
 
 		/* for data sync or sync, we need sync completion processing */
-		if (iocb_is_dsync(iocb) && !(dio_flags & IOMAP_DIO_NOSYNC)) {
+		if (iocb_is_dsync(iocb)) {
 			dio->flags |= IOMAP_DIO_NEED_SYNC;
 
 		       /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0f8123504e5e..e2b836c2e119 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -377,12 +377,6 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
-/*
- * The caller will sync the write if needed; do not sync it within
- * iomap_dio_rw.  Overrides IOMAP_DIO_FORCE_WAIT.
- */
-#define IOMAP_DIO_NOSYNC		(1 << 3)
-
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.39.2

