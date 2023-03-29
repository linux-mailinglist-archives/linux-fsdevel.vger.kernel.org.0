Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633DD6CF25A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 20:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjC2SlT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 14:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjC2SlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:41:13 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F3F1BE4
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:07 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id j2so1553989ila.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680115266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xGS1WJPD4n46wbrdJA3HTeawxdexvwLRq+jxow2GHk=;
        b=303Nu16BnhfbRchxfy7E3Vfr0miRZ+SmSqAxmWAMiymaxT+QfalejvwDZfQrcSyqh1
         okTRPheqzv5yXo0fo/RzFIyfjYB2gDFESv+6uic0jhxF+1mCDrJbpUktf3t62XvOeSVo
         hICcnzhGo32yPz/5V0RzJFRHCpuFUx8ESdbvzEMr6AvGt65u4ECFiQtOSDLH+3SaCPOZ
         j7HI8HSTmV/DYnvTGlHqxivvLSinbHoGZ5Esyxn9N/43mJVKcMjMyoOvAsNxezbgCQIx
         HOYDylDW12Cc+6m/zMQhp2joofzq4rI/B2se/bkLS5hsdYJqyYOQDkV9W07py/6InHJK
         9IxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xGS1WJPD4n46wbrdJA3HTeawxdexvwLRq+jxow2GHk=;
        b=VKWA3aXc/5FnRU2wCgfy3fVLFpi3VbXSGB9NGngtGJWgEoAD2WE6TwPUeTb1cDxM/I
         PkhD9HZKZ8oTkhS0uyfPt3N9kKYeSmTi52Ww6K4bop9ahwYoTPnOobSZnsghK62BJGgZ
         9CiiiAqKTHhC0IpCrNpXtjgjW1Jp3o4TEqmFsrPDgPu+66MgtKT6C4nMFQKb8V3kMVUl
         V6w1eKh4vMInJJHwhYGPBVuCiXwkk4f0kGa3Z3YiLZXN19CcnfpZa04sPDgl82wi559Y
         KGNRxSxuDmXYpL59bcpd2Jugg0RodA+P8UHhJtymm9l+NCeskGmmy1XlMYVPfGG4e0x6
         APng==
X-Gm-Message-State: AAQBX9c8COfLQE9fw6GgjoldCqNjLuKZVf240Hd1Yg+IX4JFPCyfEojP
        Vt0ZB1XT/HeOmrHYpi6PpAzMaEC0HBEorj8IicGg9g==
X-Google-Smtp-Source: AKy350Zt2aEwvhvN4pVijKz7+mi+CqCUB3K6LeC1lzK2SHo4E9RIyNwxWhK8XfreI//ENbIrW2jm0g==
X-Received: by 2002:a05:6e02:218f:b0:326:1778:fae3 with SMTP id j15-20020a056e02218f00b003261778fae3mr6057930ila.2.1680115266696;
        Wed, 29 Mar 2023 11:41:06 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m36-20020a056638272400b004063e6fb351sm10468087jav.89.2023.03.29.11.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:41:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/11] IB/hfi1: check for user backed iterator, not specific iterator type
Date:   Wed, 29 Mar 2023 12:40:51 -0600
Message-Id: <20230329184055.1307648-8-axboe@kernel.dk>
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

In preparation for switching single segment iterators to using ITER_UBUF,
swap the check for whether we are user backed or not. While at it, move
it outside the srcu locking area to clean up the code a bit.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/infiniband/hw/hfi1/file_ops.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 3065db9d6bb9..f3d6ce45c397 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -267,6 +267,8 @@ static ssize_t hfi1_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 
 	if (!HFI1_CAP_IS_KSET(SDMA))
 		return -EINVAL;
+	if (!from->user_backed)
+		return -EINVAL;
 	idx = srcu_read_lock(&fd->pq_srcu);
 	pq = srcu_dereference(fd->pq, &fd->pq_srcu);
 	if (!cq || !pq) {
@@ -274,11 +276,6 @@ static ssize_t hfi1_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 		return -EIO;
 	}
 
-	if (!iter_is_iovec(from) || !dim) {
-		srcu_read_unlock(&fd->pq_srcu, idx);
-		return -EINVAL;
-	}
-
 	trace_hfi1_sdma_request(fd->dd, fd->uctxt->ctxt, fd->subctxt, dim);
 
 	if (atomic_read(&pq->n_reqs) == pq->n_max_reqs) {
-- 
2.39.2

