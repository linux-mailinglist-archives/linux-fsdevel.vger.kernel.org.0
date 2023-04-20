Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8D76E9B63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 20:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjDTSPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 14:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjDTSPr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:15:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908BB3A90
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 11:15:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2472dc49239so1135125a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682014544; x=1684606544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdrDhaZEOy+UKGsi82P8bV8Exkli2SlfWKGwO5/v5to=;
        b=C6iwSPnNEkACtdMWtmTCTc4J4utsn2bNXPhh/YIsthCiGtPItJj5nljqHj+E8kbk4c
         CiZNtCni6d4pm5zyJsFVUAqfG5r04hyRZxlZliwhm/K3WmBYFudunroOc9P6zwp5l4a7
         qY2X9w7GTSr24KWOxRAyRQFjH7TYyIQ7Gek5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682014544; x=1684606544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdrDhaZEOy+UKGsi82P8bV8Exkli2SlfWKGwO5/v5to=;
        b=ljOleZHIs+6zUPlmZoXo8TT2V2ANkTttEEJNlFPqRpQF6RCWQMrB/WilwajALNza1Y
         sU208EbthcVxOjrAFakKX904VbRXjyf2L81OKUbXTn5SzH9x2KK5BgW61kaYWNvdAHJe
         ltC8wSzrOJFc5H4uC+hCUyhmCKeyIrsrxYj/cSfl1neyuzWAlRtd2F/SvYllj5XYv283
         S2FfuVu6tu5wvDrBtojpqkvLlXOG+sqQnWvb9oD8lKLZ3gwLLDVqHBJwnWnoH3e1Nz/X
         yr687KjGoliHgAreaNtsQdxKHPfrWecxGKYs+bm2aQRMJvMqzKaFV8MW4eKi6a2iOY7g
         yCSA==
X-Gm-Message-State: AAQBX9edPSPsvhzVcf2XYogGlRx9gTVM6gg04E5IkO94yIcUd8O1zDIS
        p3AVLPc5PzlojHq3Y4xOgl9Qig==
X-Google-Smtp-Source: AKy350ZaDYxOz1KaCvteqlMJzUhYsjwN2ABUnz4TxRTY2yv//E9hm9d6g/BfyYrSik+PBwHYtByO3w==
X-Received: by 2002:a17:90a:4f0b:b0:247:1e13:90ef with SMTP id p11-20020a17090a4f0b00b002471e1390efmr2574129pjh.20.1682014544026;
        Thu, 20 Apr 2023 11:15:44 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:236d:acb8:49ac:b60a])
        by smtp.gmail.com with ESMTPSA id il7-20020a17090b164700b00247150f2091sm3373157pjb.8.2023.04.20.11.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 11:15:43 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v5-fix 1/5] block: Don't invalidate pagecache for invalid falloc modes
Date:   Thu, 20 Apr 2023 11:15:40 -0700
Message-ID: <20230420181540.337203-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.0.396.gfff15efe05-goog
In-Reply-To: <ZEFmS9h81Wwlv9+/@redhat.com>
References: <ZEFmS9h81Wwlv9+/@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Only call truncate_bdev_range() if the fallocate mode is
supported. This fixes a bug where data in the pagecache
could be invalidated if the fallocate() was called on the
block device with an invalid mode.

Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block devices")
Cc: stable@vger.kernel.org
Reported-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 block/fops.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index d2e6be4e3d1c..4c70fdc546e7 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -648,24 +648,35 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
 	filemap_invalidate_lock(inode->i_mapping);
 
-	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file->f_mode, start, end);
-	if (error)
-		goto fail;
-
+	/*
+	 * Invalidate the page cache, including dirty pages, for valid
+	 * de-allocate mode calls to fallocate().
+	 */
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL);
 		break;
-- 
2.40.0.396.gfff15efe05-goog

