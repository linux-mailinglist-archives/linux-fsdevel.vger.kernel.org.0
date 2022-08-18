Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17532597DDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 07:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242769AbiHRFF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 01:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243236AbiHRFFV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:05:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769439F1B6;
        Wed, 17 Aug 2022 22:05:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s3-20020a17090a2f0300b001facfc6fdbcso85270pjd.1;
        Wed, 17 Aug 2022 22:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=H9LcEe7zEKnk+9IZlOILIvCS3X4aqgzROjS1RylQ0vk=;
        b=O/GJsSfPhcy+Of5V4UT7yETG3vCUIKm/Q238ob/rxctPqNVehoIR3RmJ3RgcRUdpcX
         S4UZK+IlX5dnQkYXUh1o+/CuHKEyQNWWH42EF+o/gUCvH9OujxjeshxB7zJzAgMh2cOa
         fhtH/xMYrjyIjNqrmJScuPl5rjE1aSbs/TpHCllSyhfGYNZfuvf0PBbYhoV2rUIx2Ekt
         7ATiy8SBxZslgNESHJSYxSGzlKu1esTYc9xgwghrgNkCshhAUtwvN8wH8mgrem0E6EUT
         LQuMnIs1J7vLeS8jyyEivfyHK/+dpG+ONneCI6HVNVCFFtsb8fYOI72H91fSE7kbJvwH
         4P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=H9LcEe7zEKnk+9IZlOILIvCS3X4aqgzROjS1RylQ0vk=;
        b=mKO2jm7uTW7I1xO5p4eKcAIxCjZRYVm2GBXM+q4+yyoZF6vSyTPpBnlguhAE67u5KH
         PZ5CBuciwrjOHPRkGGgZ5KyiL8/G5V6RbetqRlAx6fIAKcmveu2V4GenNTcew4l8vuXq
         DGgnXYJhJ8U62XCsaHlkscw4BtS83KgWqOC11ONv7HdWqDrRMlD8P9EwVPtIUM/qcNsQ
         DDiNW/vwM7BPB66dRNpBMl2MDYKxEGqKQSA3iKyRUO2/+QDQz8+669+vPkgovok+j5T6
         V2tlxpLNHT203BqoNTm+9ExLtmuhzAsUvNHkai8Ht91Ul/sZ7SWG/RNDyfw0danEGiVQ
         vF7g==
X-Gm-Message-State: ACgBeo3wf2NPM1vMd7ydVf4WOscoEWi5bkzVXwika0mRBPPUhXDkrBiD
        C8Rp1OSWalLpbt3/vWQ3cG2K04pjYCE=
X-Google-Smtp-Source: AA6agR4nrtFCShyY4xJTyNMckutRPqP+qbkHjfhCB1bh7rFxF4YlvMnYZf+6wwEr1XuCgxsoFOlsmQ==
X-Received: by 2002:a17:90a:c782:b0:1f7:a4ed:11a1 with SMTP id gn2-20020a17090ac78200b001f7a4ed11a1mr1413246pjb.12.1660799108853;
        Wed, 17 Aug 2022 22:05:08 -0700 (PDT)
Received: from localhost ([2406:7400:63:e947:599c:6cd1:507f:801e])
        by smtp.gmail.com with ESMTPSA id b19-20020aa79513000000b0052e26b8f610sm468903pfp.89.2022.08.17.22.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 22:05:08 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        linux-ntfs-dev@lists.sourceforge.net,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>, kernel test robot <lkp@intel.com>
Subject: [PATCHv3 2/4] fs/ntfs: Drop useless return value of submit_bh from ntfs_submit_bh_for_read
Date:   Thu, 18 Aug 2022 10:34:38 +0530
Message-Id: <d82eb29e8dbc52fe13a7affef5c907ea4076aa31.1660788334.git.ritesh.list@gmail.com>
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

submit_bh always returns 0. This patch drops the useless return value of
submit_bh from ntfs_submit_bh_for_read(). Once all of submit_bh callers are
cleaned up, we can make it's return type as void.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 fs/ntfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 58b660dbbee9..c481b14e4fd9 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -527,12 +527,12 @@ static inline int __ntfs_grab_cache_pages(struct address_space *mapping,
 	goto out;
 }
 
-static inline int ntfs_submit_bh_for_read(struct buffer_head *bh)
+static inline void ntfs_submit_bh_for_read(struct buffer_head *bh)
 {
 	lock_buffer(bh);
 	get_bh(bh);
 	bh->b_end_io = end_buffer_read_sync;
-	return submit_bh(REQ_OP_READ, bh);
+	submit_bh(REQ_OP_READ, bh);
 }
 
 /**
-- 
2.35.3

