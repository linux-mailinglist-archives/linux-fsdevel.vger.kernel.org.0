Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043DB6F6959
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 12:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjEDK4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 06:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjEDK4h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 06:56:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20D44C01;
        Thu,  4 May 2023 03:56:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so49909266b.2;
        Thu, 04 May 2023 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683197795; x=1685789795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ifOfkEUyxxO0eazLLKLawS21srpdOWmLX2BHDyl3i/E=;
        b=r6/ULPkETTOQMH/robFPgDlQCst1bREYJAsFn1dwhp1MLmY5wcl5twzUKHdKZPf3Ze
         EsTq0uWPk86oeTO9wQ/eYqzHXRD+koT4Uf2UClwaMh7lkTA6VTMO7nuZOKmTLTdr+Pd5
         yU00n4P009PDG13BAWmuQXGz5t705gggUNyiK7Ro7snRgKBmcWGitgDPMmbxSu2IaNzq
         WL4esf1Oek2AYFza9Y74mHcHzccfEuf/XoB/JYsVoGbaR2dKVKe3/4W1YFh4r2/T710o
         86pPPfnJrjmyuIOHyluem8JkDDqd2gxZku1IPJ3+pMbf9eYlLiQWGdZRhbCJhiDMMQU/
         /bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683197795; x=1685789795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifOfkEUyxxO0eazLLKLawS21srpdOWmLX2BHDyl3i/E=;
        b=FZ6sgJMGajQNR/mADVXiKAipZDsf5JbYIpjbC++ERD/EcMOD+kV2hlk48x7pu1HuW9
         g25wATPgsqagXm216uPQx1LslHaOR1f9hOy4SoAioVjPGB/i8lzP94wrijeOUfk3ryER
         i/SZt0ejUI/oGob6uujjp6WGh4bo7rjZFPu8xpFDFulQxBEoy1TM0kPIrEFrTLPwqFw5
         eAESuf+347X9+0To41YcZud35pD7RFLZlzzJACE1/lwovvvH0NYYQks918eBZlj5yF9O
         wYvPuu7Cbmw3t//xD160GD3W/NqA9pPQHf+FtC1jE9DIoHBLKmnPpJzozDKwE9F1avNn
         wpqA==
X-Gm-Message-State: AC+VfDxypbNXvQ+s+yclXc8xznh3TdsfH/pqvO5glCQBHBP1UPFN3mOs
        2hZLtxIEmjthEu2yfAuoJUI=
X-Google-Smtp-Source: ACHHUZ6TwBZnyii5xpKaYAkZBKaa26bobPL9RsirRFkmhWeDc3ct+W+i8UFXXhJGPnxNy6ZUymQpZQ==
X-Received: by 2002:a17:907:8a02:b0:93e:908d:cfe2 with SMTP id sc2-20020a1709078a0200b0093e908dcfe2mr6022858ejc.0.1683197794976;
        Thu, 04 May 2023 03:56:34 -0700 (PDT)
Received: from zambezi.local (ip-94-112-104-28.bb.vodafone.cz. [94.112.104.28])
        by smtp.gmail.com with ESMTPSA id hf15-20020a1709072c4f00b009659fa6eeddsm988030ejc.196.2023.05.04.03.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 03:56:34 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: always respect QUEUE_FLAG_STABLE_WRITES on the block device
Date:   Thu,  4 May 2023 12:56:24 +0200
Message-Id: <20230504105624.9789-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Commit 1cb039f3dc16 ("bdi: replace BDI_CAP_STABLE_WRITES with a queue
and a sb flag") introduced a regression for the raw block device use
case.  Capturing QUEUE_FLAG_STABLE_WRITES flag in set_bdev_super() has
the effect of respecting it only when there is a filesystem mounted on
top of the block device.  If a filesystem is not mounted, block devices
that do integrity checking return sporadic checksum errors.

Additionally, this commit made the corresponding sysfs knob writeable
for debugging purposes.  However, because QUEUE_FLAG_STABLE_WRITES flag
is captured when the filesystem is mounted and isn't consulted after
that anywhere outside of swap code, changing it doesn't take immediate
effect even though dumping the knob shows the new value.  With no way
to dump SB_I_STABLE_WRITES flag, this is needlessly confusing.

Resurrect the original stable writes behavior by changing
folio_wait_stable() to account for the case of a raw block device and
also:

- for the case of a filesystem, test QUEUE_FLAG_STABLE_WRITES flag
  each time instead of capturing it in the superblock so that changes
  are reflected immediately (thus aligning with the case of a raw block
  device)
- retain SB_I_STABLE_WRITES flag for filesystems that need stable
  writes independent of the underlying block device (currently just
  NFS)

Cc: stable@vger.kernel.org
Fixes: 1cb039f3dc16 ("bdi: replace BDI_CAP_STABLE_WRITES with a queue and a sb flag")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/super.c          |  2 --
 mm/page-writeback.c | 12 +++++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 04bc62ab7dfe..6705b3506ae8 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1213,8 +1213,6 @@ static int set_bdev_super(struct super_block *s, void *data)
 	s->s_dev = s->s_bdev->bd_dev;
 	s->s_bdi = bdi_get(s->s_bdev->bd_disk->bdi);
 
-	if (bdev_stable_writes(s->s_bdev))
-		s->s_iflags |= SB_I_STABLE_WRITES;
 	return 0;
 }
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 516b1aa247e8..469bc57add8c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -3169,7 +3169,17 @@ EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
  */
 void folio_wait_stable(struct folio *folio)
 {
-	if (folio_inode(folio)->i_sb->s_iflags & SB_I_STABLE_WRITES)
+	struct inode *inode = folio_inode(folio);
+	struct super_block *sb = inode->i_sb;
+	bool stable_writes;
+
+	if (sb_is_blkdev_sb(sb))
+		stable_writes = bdev_stable_writes(I_BDEV(inode));
+	else
+		stable_writes = bdev_stable_writes(sb->s_bdev) ||
+				(sb->s_iflags & SB_I_STABLE_WRITES);
+
+	if (stable_writes)
 		folio_wait_writeback(folio);
 }
 EXPORT_SYMBOL_GPL(folio_wait_stable);
-- 
2.39.2

