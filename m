Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13166CF252
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 20:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjC2SlD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 14:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC2SlC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:41:02 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9843218F
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:01 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7585535bd79so9937739f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680115260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4NGaKNQumVHBmJnPUCoj4JSRLmXQM6FZ5Zam1tOsx4=;
        b=gJ++MD0LIGmWuvVGWTBiMDXuzauI3zu3ho73y0eaU1Lwl/VosI+DByixd0MFXQXppE
         3Y716lGGVqsCGm4S411NJINv0WUfG4lVR24FoauRIYqB8BKKsOn/+a7v+oDhSBGIReht
         7GYf+tVnPgcyu4/MCldiaI16dF+ikimFppByMhkEw9xLVrt9nTXc8+Bz2V+C7e/i9ux4
         ubhfWDBlgBivLdZNb5Y4U8/R7zA+rOFmGtQOX96cp3c2Y5aYQyR6MXeSA0L5uXtXAPXC
         KJ18CJHJOFmqwA9ooKSjguchcYlzlfKx5HoJ22DlwopioC/ONvnW6npUGUe/MyCe2akA
         xd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4NGaKNQumVHBmJnPUCoj4JSRLmXQM6FZ5Zam1tOsx4=;
        b=pzeXWnVDphQNM24mgc/N+fg1HjbCGsNJ69qYGgQlS/YZnNPvpzWXUhdh/BvYame61z
         3gxGzdndwu/txOPcB1JhF07OpBQHuhYYP7+JKSKV1WzbUIOLpTxJnHffMfFNzD76P5Wi
         w61QJ/lWGy7K0HBsuC6l6B8f+1n8xxt5bnN0LqNG1A3NO8UFlT9zcQRxdigc0Q+R5/K6
         eoCZ8MF8KOhkNs5NGRl6X4X3xn5tAoWix16w86YdxWpbbQ94lm0YtRyRr4FZk/0cbeEM
         GviH2yvrwIioMsfDLXA3lio3DQUVU/irMyddG4AuFay4ZVZJqYOa/Ig2FopEzIs7ZKEm
         nJzw==
X-Gm-Message-State: AO0yUKURWrzSPOvxJsLWAVdL29DziA2D5Vpcd8wLycXZVaCmE275dgnS
        mj4hkQB1dnOduZmQ9+wyOQ89qqYFVxqsw/yB3Cfmcg==
X-Google-Smtp-Source: AK7set8s3jHXmhvcwCwnvJTb85l/IjY9FweqqTiA9yZraU6kJKHhLZxV2UD3PoiX+dgJiCAZvpjMpg==
X-Received: by 2002:a05:6602:2d87:b0:759:485:41d with SMTP id k7-20020a0566022d8700b007590485041dmr11983777iow.0.1680115260466;
        Wed, 29 Mar 2023 11:41:00 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m36-20020a056638272400b004063e6fb351sm10468087jav.89.2023.03.29.11.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:40:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/11] block: ensure bio_alloc_map_data() deals with ITER_UBUF correctly
Date:   Wed, 29 Mar 2023 12:40:45 -0600
Message-Id: <20230329184055.1307648-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329184055.1307648-1-axboe@kernel.dk>
References: <20230329184055.1307648-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helper blindly copies the iovec, even if we don't have one.
Make this case a bit smarter by only doing so if we have an iovec
array to copy.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-map.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 9137d16cecdc..3bfcad64d67c 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -29,10 +29,11 @@ static struct bio_map_data *bio_alloc_map_data(struct iov_iter *data,
 	bmd = kmalloc(struct_size(bmd, iov, data->nr_segs), gfp_mask);
 	if (!bmd)
 		return NULL;
-	memcpy(bmd->iov, data->iov, sizeof(struct iovec) * data->nr_segs);
 	bmd->iter = *data;
-	if (iter_is_iovec(data))
+	if (iter_is_iovec(data)) {
+		memcpy(bmd->iov, data->iov, sizeof(struct iovec) * data->nr_segs);
 		bmd->iter.iov = bmd->iov;
+	}
 	return bmd;
 }
 
-- 
2.39.2

