Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D93550FE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 07:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbiFTF7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 01:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238421AbiFTF7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:59:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03995DFA6;
        Sun, 19 Jun 2022 22:59:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so9278207pjz.1;
        Sun, 19 Jun 2022 22:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Clel/4ybCmI1HGYhwncCodVfekWAtcomQbTqtWI+l0Q=;
        b=YAbbkPY7AQqeGcoSQY/GDuPZ4RakV3S3JtVdiT2WDFxLmyHoRq5stiZIPZJQrz38ij
         P/U3fSbE00vIjIHK4rt9r8bZfVgbj/q729TbMOppW0sppD0HnGp0tDEFSQfroVrjhwQ9
         Giyx24RXA9ySH70qRJUqmFGCvf21GQq5ehjsyTP8RPHcbORmTOvdY/48P6TbsaR4yMUx
         RjBV91bdyTjNUh1xl7G3GK5eDIYI8lYVTBoA7Jzj3Q6k2G3Ndzui4qpOdvYLb+h6xzfQ
         NRLXJ+L5tpLsb95d9nh6c5pe1OrCnP3pSb9bLwWD71nd+wOXQDzZxIZ/vTajbb//xPdp
         hhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Clel/4ybCmI1HGYhwncCodVfekWAtcomQbTqtWI+l0Q=;
        b=q8eU6YYCAQF+Fr0ioRJbxHRv6NXvPb4CQrw46ekt+XbF0LU3IQ/I6BkNs9MsFMMVBU
         NUdGUjt6g0BQkKZgFrGi0Ue6K1Tv9NqMPd3jA31A/NnQIwJXCWVoIYxV49xF3ohsGRa6
         K6gxR1FU+P6PisDDP781b2OSeuk9LeKAt1Do2wzdUCP36Gj4XwZGuzGIN9UsiEDhbneW
         MR3IhzH4vTTljIjLqGpurOy/g7ups2FMZdBwFhTyG1sNbei/7ELznLli5uD5TZLp9WS2
         4n43RRLJpIntESDEk6UppMBJeMTAV98d8mzQFU2z7ViV0CF1UH43nDyMYqxNhp8Y6thr
         5I4Q==
X-Gm-Message-State: AJIora+T5Vv0lWfEbwbe71gjvb4IEZZHB7cJGaIwqm5td3MHCcPYajDA
        WyW6Tq6rxqZuhqbEVgHTHEDYe1AhN/M=
X-Google-Smtp-Source: AGRyM1uHcTMDgy+sugVksf12u0TC4QU4EKjkQc/KOyYn8vDa4EfP6+m+gPhbCIDrfNe7V1K+GoXwnw==
X-Received: by 2002:a17:903:240e:b0:168:ea13:f9e0 with SMTP id e14-20020a170903240e00b00168ea13f9e0mr22599116plo.6.1655704776327;
        Sun, 19 Jun 2022 22:59:36 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id v20-20020a17090331d400b001641047544bsm7709664ple.103.2022.06.19.22.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 22:59:35 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 2/3] fs/buffer: Drop useless return value of submit_bh
Date:   Mon, 20 Jun 2022 11:28:41 +0530
Message-Id: <77274d2a2030f6ee06901496f9c5fbe8779127a3.1655703467.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655703466.git.ritesh.list@gmail.com>
References: <cover.1655703466.git.ritesh.list@gmail.com>
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

Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 fs/buffer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 898c7f301b1b..313283af15b6 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3121,8 +3121,6 @@ EXPORT_SYMBOL(write_dirty_buffer);
  */
 int __sync_dirty_buffer(struct buffer_head *bh, int op_flags)
 {
-	int ret = 0;
-
 	WARN_ON(atomic_read(&bh->b_count) < 1);
 	lock_buffer(bh);
 	if (test_clear_buffer_dirty(bh)) {
@@ -3137,14 +3135,14 @@ int __sync_dirty_buffer(struct buffer_head *bh, int op_flags)
 
 		get_bh(bh);
 		bh->b_end_io = end_buffer_write_sync;
-		ret = submit_bh(REQ_OP_WRITE, op_flags, bh);
+		submit_bh(REQ_OP_WRITE, op_flags, bh);
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

