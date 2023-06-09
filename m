Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734F3729979
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjFIMUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjFIMUw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:20:52 -0400
Received: from out-56.mta0.migadu.com (out-56.mta0.migadu.com [IPv6:2001:41d0:1004:224b::38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BFA1A2
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 05:20:51 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686313250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2vOAGi5rd15wmqnwQoNSWtL1Awzw5b0eMRdqHWf5p8g=;
        b=VgYamFTzVfz9nbUpCPpp/UomqbB6O1fXrkO7TPsto5XpIe7rWOkBI7RzALJFCHuPoFkUOr
        r50cPRjwW+HGz8cV7i/PMx8TKrbobyR2mhuM6y/Lm60jJImbRhhBYVEwhAcSBoAkt9B3gx
        vAoHxIsPbm7U3H4JIYN3hoaHh3gXF/I=
From:   Hao Xu <hao.xu@linux.dev>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/11] io-wq: add fixed worker members in io_wq_acct
Date:   Fri,  9 Jun 2023 20:20:24 +0800
Message-Id: <20230609122031.183730-5-hao.xu@linux.dev>
In-Reply-To: <20230609122031.183730-1-hao.xu@linux.dev>
References: <20230609122031.183730-1-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hao Xu <howeyxu@tencent.com>

Add fixed worker related members in io_wq_acct.

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 io_uring/io-wq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 7326fef58ca7..bf9e9af8d9ca 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -84,6 +84,8 @@ struct io_wq_acct {
 	raw_spinlock_t lock;
 	struct io_wq_work_list work_list;
 	unsigned long flags;
+	struct io_worker **fixed_workers;
+	unsigned int fixed_nr;
 };
 
 enum {
-- 
2.25.1

