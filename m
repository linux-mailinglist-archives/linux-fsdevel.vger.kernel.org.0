Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC708559F10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 19:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiFXQ5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 12:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiFXQ5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:57:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79584E3A7;
        Fri, 24 Jun 2022 09:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD8C9B82AC3;
        Fri, 24 Jun 2022 16:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FC6C34114;
        Fri, 24 Jun 2022 16:57:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XSh+wrt2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656089831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x7w4F5vDUanD3cyNwRJTK3WbQC/Ff5DbSn/gTkZD/AQ=;
        b=XSh+wrt2Wy33yrqdt71DjblsNKZBNh2GqO0KR/aWNKpt9hoQma7w72rteUjxL2XsK5tTaA
        MXnKXS1hNTEnn/PmxCBlewQ/CobLshUQtutsesvzTnt4deWSt1D2TzI5JD/2Qq+zMwWD5m
        SB9sI/zLrFniFHvP67qrVeWtmKAQLfg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3165afbf (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 24 Jun 2022 16:57:11 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 5/6] dma-buf: remove useless FMODE_LSEEK flag
Date:   Fri, 24 Jun 2022 18:56:30 +0200
Message-Id: <20220624165631.2124632-6-Jason@zx2c4.com>
In-Reply-To: <20220624165631.2124632-1-Jason@zx2c4.com>
References: <20220624165631.2124632-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is already on by default.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/dma-buf/dma-buf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 32f55640890c..3f08e0b960ec 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -549,7 +549,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 		goto err_dmabuf;
 	}
 
-	file->f_mode |= FMODE_LSEEK;
 	dmabuf->file = file;
 
 	mutex_init(&dmabuf->lock);
-- 
2.35.1

