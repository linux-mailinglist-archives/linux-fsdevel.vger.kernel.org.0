Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E17B597DD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 07:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243276AbiHRFFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 01:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243497AbiHRFFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:05:24 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12924A1A70;
        Wed, 17 Aug 2022 22:05:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 2so632970pll.0;
        Wed, 17 Aug 2022 22:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7o9q6zRE/LnQajbGEZFofVIBdR8mGxbes8De4o3wgBI=;
        b=lTSZFbH1W3gB1hd+vKpaQ4maRyY+LejWXlwd8H4J5CGwKw8gYcZMMrVXDDIAM6R42K
         HVugf2myQsympLMaiRGNSFJx2pj77DEPcrMKzjwO+0ZoMcVddx0C/RyNW2MSAiF4EM2O
         rF6dcc1iWppY9YZosFq/E/bNI0sDOeaTKnk7Ih5QhIwkjWWIzKgPp6XDXR2S1ajSl5iZ
         iUfCitWt9NyHUvD5qLVTjDp8kg8/6PGSH1B6ZtNK2z2lWUc8CyKES6uH+tNTfXsYJGsl
         gJev7Z/45P7Of2cRD8FjFTYu72lHzesHE8I42VEnUqFKkxDe6KZcuRfzIzmpun1Pn9JV
         l/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7o9q6zRE/LnQajbGEZFofVIBdR8mGxbes8De4o3wgBI=;
        b=kyxBhgIEwc2nQxGOhFsJQdASz3IRL5+YSy1qTlLnj6eODaOsa9oBNkYjGmPleeOWaN
         JrSrifD6Zz7LD6Ku7kvzj0+AETVWYtJgRMHgE65+aIyT3Couo7E83gMI2pwP1YzX7PW1
         ZJlHKoSaPH45fcWsdxzoOIx2FfidDS3f7eBWn4AOl0XvTG4NeHUH+5Xziz3GvpmJmOUF
         n7kCMuIBUjyECmC9+0k7SoHx11JyfAYGogsyGmmI9I8D2UU1wWwp5w+v7f3DA85KXKd4
         EvA9DC8rAdsptRD8t1+ukRoMP+7Uy2YZ2wGhCjDI+yzxo1ffh/duyExPAUTwWfrUhc9f
         8H+Q==
X-Gm-Message-State: ACgBeo2osWgjxW8WOfYfglAqGXLamnHfDLOm1sKGK16kLs6GA456IHQ6
        NOyMOb4TdsHoLRby1eXdaZ9IFkxtegA=
X-Google-Smtp-Source: AA6agR7zRkfBlCwk+TxT4r9iiOceSAqhD0U8vSEdSqityZUqM089DSmox1f0QHE5lfMVykKYq9sWWQ==
X-Received: by 2002:a17:902:ea0d:b0:170:cabd:b28 with SMTP id s13-20020a170902ea0d00b00170cabd0b28mr1146909plg.115.1660799119348;
        Wed, 17 Aug 2022 22:05:19 -0700 (PDT)
Received: from localhost ([2406:7400:63:e947:599c:6cd1:507f:801e])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b0016e808dbe55sm350841plf.96.2022.08.17.22.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 22:05:18 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        linux-ntfs-dev@lists.sourceforge.net,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCHv3 4/4] fs/buffer: Make submit_bh & submit_bh_wbc return type as void
Date:   Thu, 18 Aug 2022 10:34:40 +0530
Message-Id: <cb66ef823374cdd94d2d03083ce13de844fffd41.1660788334.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1660788334.git.ritesh.list@gmail.com>
References: <cover.1660788334.git.ritesh.list@gmail.com>
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

submit_bh/submit_bh_wbc are non-blocking functions which just submit
the bio and return. The caller of submit_bh/submit_bh_wbc needs to wait
on buffer till I/O completion and then check buffer head's b_state field
to know if there was any I/O error.

Hence there is no need for these functions to have any return type.
Even now they always returns 0. Hence drop the return value and make
their return type as void to avoid any confusion.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/buffer.c                 | 13 ++++++-------
 include/linux/buffer_head.h |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index c21b72c06eb0..0a7ba84c1905 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -52,8 +52,8 @@
 #include "internal.h"
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
-static int submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
-			 struct writeback_control *wbc);
+static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
+			  struct writeback_control *wbc);
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
@@ -2673,8 +2673,8 @@ static void end_bio_bh_io_sync(struct bio *bio)
 	bio_put(bio);
 }
 
-static int submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
-			 struct writeback_control *wbc)
+static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
+			  struct writeback_control *wbc)
 {
 	const enum req_op op = opf & REQ_OP_MASK;
 	struct bio *bio;
@@ -2717,12 +2717,11 @@ static int submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 	}
 
 	submit_bio(bio);
-	return 0;
 }
 
-int submit_bh(blk_opf_t opf, struct buffer_head *bh)
+void submit_bh(blk_opf_t opf, struct buffer_head *bh)
 {
-	return submit_bh_wbc(opf, bh, NULL);
+	submit_bh_wbc(opf, bh, NULL);
 }
 EXPORT_SYMBOL(submit_bh);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index def8b8d30ccc..b1373844c43d 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -229,7 +229,7 @@ void ll_rw_block(blk_opf_t, int, struct buffer_head * bh[]);
 int sync_dirty_buffer(struct buffer_head *bh);
 int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
 void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
-int submit_bh(blk_opf_t, struct buffer_head *);
+void submit_bh(blk_opf_t, struct buffer_head *);
 void write_boundary_block(struct block_device *bdev,
 			sector_t bblock, unsigned blocksize);
 int bh_uptodate_or_lock(struct buffer_head *bh);
-- 
2.35.3

