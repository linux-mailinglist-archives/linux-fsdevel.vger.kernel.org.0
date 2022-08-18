Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3182597DD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 07:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243227AbiHRFF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 01:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243322AbiHRFFW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:05:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FB7A6C5F;
        Wed, 17 Aug 2022 22:05:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f21so645044pjt.2;
        Wed, 17 Aug 2022 22:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lFuT8sSYLisADIw9ypCi2dSipGCRvABVMWuXbHp7qjo=;
        b=X0zxD3ZngJqjrX8kUd/aa/EKxd3QJ4ZJS8mx9d3QoEEhujzjKKJkTW4N7x+zbs3gNd
         9SoeKQr1iZugICY2hKCKXK/enkv2R5Pm2Z2JEbRe8V+okITZGaCW9FPphK1iGjqgYVPc
         CTiVlRQKlSDrVf885a7/I+7QeQwXgonXuveQJCACCyjo//48vHBq0KyFawLzag40hr9V
         Rto0b8EqF36V1cvL4b52DOByjqvyZpjGnGkSG7qzLT8KIRwDoNFKEuP9dtAHJOtN9AR5
         Mcbe6SrYtfCAoDKsafGB+ov7oAxkIKGg5EAsgncs6v8649kcePvW/ZanY4XJgtw3aWVU
         iXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lFuT8sSYLisADIw9ypCi2dSipGCRvABVMWuXbHp7qjo=;
        b=FxV/pmk2Qjq4NEvvhjwVAyM27rJknW++5l4OX4GNWNQel2MVSRIdcS1uw9n8gBTR2h
         FS5ssFVMsPku9UkszncLaTyNq1Db9i/FU9jpczSCHL2VURDAXsWqlXkTkyTRT+Q7spNT
         ob3Fc//mD9LN73B9Ayml1tadRIjVmyIkINDzFoVjib2ubSqlBrHn6xt9mrd73d7+3N/7
         f8XdKA+fjvdgYu59h1YPs6ioNpCpBTiwfTqvQVQxO+v7r8oZoMjrKPQn6swnHPZS39TH
         VaG6NbU3i5kjPTWCxiWPc65RnM1relarZTvdf7WsXH6lSPuUSXpbx9Xnb6hJgT4ekdv8
         XGFQ==
X-Gm-Message-State: ACgBeo3UrSNilIMleTLzm4mLIgNPmNofLF9hw1u7epdliTm/REJ5Bksf
        8Aq21pv2tSKKufAx04O1nWdDFmiLzKY=
X-Google-Smtp-Source: AA6agR5c77dm8IiYPzs/0gbhhy7RFfLV4ONF1BmzOkWorGSf/RPH/2cgmWzAjGAvys1oNQiiiqMrkg==
X-Received: by 2002:a17:902:ab98:b0:172:a566:d462 with SMTP id f24-20020a170902ab9800b00172a566d462mr1195248plr.53.1660799113945;
        Wed, 17 Aug 2022 22:05:13 -0700 (PDT)
Received: from localhost ([2406:7400:63:e947:599c:6cd1:507f:801e])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902e88100b0016f196209c9sm343614plg.123.2022.08.17.22.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 22:05:13 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        linux-ntfs-dev@lists.sourceforge.net,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 3/4] fs/buffer: Drop useless return value of submit_bh
Date:   Thu, 18 Aug 2022 10:34:39 +0530
Message-Id: <a98a6ddfac68f73d684c2724952e825bc1f4d238.1660788334.git.ritesh.list@gmail.com>
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
submit_bh from __sync_dirty_buffer(). Once all of submit_bh callers are
cleaned up, we can make it's return type as void.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/buffer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 55e762a58eb6..c21b72c06eb0 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2801,8 +2801,6 @@ EXPORT_SYMBOL(write_dirty_buffer);
  */
 int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
 {
-	int ret = 0;
-
 	WARN_ON(atomic_read(&bh->b_count) < 1);
 	lock_buffer(bh);
 	if (test_clear_buffer_dirty(bh)) {
@@ -2817,14 +2815,14 @@ int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
 
 		get_bh(bh);
 		bh->b_end_io = end_buffer_write_sync;
-		ret = submit_bh(REQ_OP_WRITE | op_flags, bh);
+		submit_bh(REQ_OP_WRITE | op_flags, bh);
 		wait_on_buffer(bh);
-		if (!ret && !buffer_uptodate(bh))
-			ret = -EIO;
+		if (!buffer_uptodate(bh))
+			return -EIO;
 	} else {
 		unlock_buffer(bh);
 	}
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(__sync_dirty_buffer);
 
-- 
2.35.3

