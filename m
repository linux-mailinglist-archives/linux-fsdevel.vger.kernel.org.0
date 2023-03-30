Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5401C6D0BB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 18:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjC3Qrf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 12:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjC3QrJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:47:09 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFAED321
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:07 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h187so6817631iof.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680194826; x=1682786826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4NGaKNQumVHBmJnPUCoj4JSRLmXQM6FZ5Zam1tOsx4=;
        b=0xgl9qbcPpXnPpzfzYkEBiHHcf0HF+wpRWyMej2tyTZ6+kw2ZNP9WdEmpYzG0qmgRC
         fDpUC5FtMv/0Von3VUnXWMqa2mPBg98nvr/76zPrd5WIuaiPVPFy62KAT6EjwXyM86Dv
         gKUX6NhN9EygZOPB44bSArElyhE8AqDQAVZWUSdLjvgbbOMqGDxdoWY2vYi+KS8FT/2L
         1srBFfrOnAcSQ3ZQe5O/9qGkUTkOXWCz17+/YNW/MWL22ZIBmvalsjOitucV7OoK9BVy
         KerhTkpnUlPB6oV7nTO9uWHgb1xfDU8xZYbufsHfQ73GXSF/5J2saGe8e6/GvSDsuK0g
         i7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194826; x=1682786826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4NGaKNQumVHBmJnPUCoj4JSRLmXQM6FZ5Zam1tOsx4=;
        b=vCN7nj9glNw7ollsAF/LJ9BHI5Y+n2OSl/MCZtKQME2C3owv5Tu5fNf6Ff5qaGDATo
         smsZ2W7xr4Y3mw5hwJYkEHBlvj7fscHLQ7GpshUOkuYBPyMvQ1r7mWJya0jrv+rA1bNo
         qavaioWzvlrGUQyIg2e4Qj3z6I181rRY9+UtiAtdp6PJOEuhPKC/UJM2g4J++C9dAJHm
         JaTAnbPnV6HQ8Qjy94IxUvwjoP5/bpCYVsmMIcokqwFhkKKbjL536BvSWrqoN9PrsyRO
         vCaYRiPUDYo2yaOQKel9/hBD4W3oEin7L4c/w2B5d8joUZ0l8Kju+Vo/RhJ8zMFoiLF6
         VrCw==
X-Gm-Message-State: AAQBX9eGkyimxsIIyZeaYuBjGfn2gy0TKDDnUqB3fLbkY3ga8t8QUqFg
        0d9bVtQA6LPlHErodlKyTS79nKmISGf9SbgAQHouTQ==
X-Google-Smtp-Source: AKy350a/kxsf+6rLW0ZQJSJhFTwyNqct4efmzN2Ai76qtn2qZWfTs72/JD3IlTSE/oF9Y2jvfq5aCg==
X-Received: by 2002:a6b:ce05:0:b0:758:5525:860a with SMTP id p5-20020a6bce05000000b007585525860amr1316300iob.0.1680194826546;
        Thu, 30 Mar 2023 09:47:06 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v21-20020a056638251500b003a53692d6dbsm20876jat.124.2023.03.30.09.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:47:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/11] block: ensure bio_alloc_map_data() deals with ITER_UBUF correctly
Date:   Thu, 30 Mar 2023 10:46:52 -0600
Message-Id: <20230330164702.1647898-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330164702.1647898-1-axboe@kernel.dk>
References: <20230330164702.1647898-1-axboe@kernel.dk>
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

