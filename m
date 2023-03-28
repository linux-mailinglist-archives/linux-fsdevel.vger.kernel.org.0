Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409D56CCC70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 23:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjC1V61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 17:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjC1V6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:58:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC0C113
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a25eabf3f1so892445ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680040702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRPYYmE7VkoLdpt+drXZZpXzRgkrnkDfDvNKqz80KmM=;
        b=DRbBf8YB7W49+t4/7+pcCX3Gne0jF4X69YdZtuIZEm5hfS6HYsccfIBZKY8GJAiPoJ
         PBrpjyMEMx8Ag1yIEL4XF8tViXN3w2unegxeEe0mGfE3K/SLlTSYN6kxVymZ6HL+njDF
         qemawMGx30FCub3QUX5kZyhWo19dFX3UBG3L0ZonE+Slil06GoWWpY3F+XAZhdjTisV2
         6q9WWOKC3ATc21f8LKlSxykKouY9l8osOzrFt0BMPoCIAJkA/XlurkPB9JBJjq1D6XAH
         3PFQXNZeClVo6Pq8t2EDTShcEnBxfeVg21VdgLCvREKPu4q5fprClVJr6JJnxwkc/dWu
         6NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680040702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRPYYmE7VkoLdpt+drXZZpXzRgkrnkDfDvNKqz80KmM=;
        b=5BHaiqPRPEHLwjLPTx3BipnAmj6U8aZX167HMjJ7TUJcz9/+ZT+R5Ip4VnWJ2SK9eT
         mAeKnO7ar4RzLW9L++EMgHJtiF+1/+OVO2fUTKdb3yNtWbCzcN90L0+s427sE+Ndh818
         35eC5HdMDPHUMMEufKMb1GbLm25Tz00Jv55Xl0B0EV1vY+4RGMxxp04gSLjrtny4ESX4
         HwDRpA+Jj9dHDZC4fyG8f4PBlxC9gWsxm7VHH+9z31qeJZAE93eW+03xy8COknAIGPZ6
         Azs7sL9Q1WtSM5EGRCMlzWTSLRNjphulktufXsKRXGJDn+7evkCW59bRUdZMjUzBgLyF
         JDLw==
X-Gm-Message-State: AAQBX9fFjXasVoUXaVNI/alIf8bfABy9L4V9vzUUIYrDq6ko1/Zhk5Bs
        NJE3OkuA0qhr+C2gsWAnW34W4gWfdRjrQQMTCNXHQA==
X-Google-Smtp-Source: AKy350bh1gfLTbi6GLuMqsZIOkpQYA48lH8bURIMtRX0WSgfI1yvz1l8NAaxZqAO/OgreQPsO4siYg==
X-Received: by 2002:a17:90b:4007:b0:23f:6872:e37c with SMTP id ie7-20020a17090b400700b0023f6872e37cmr12405816pjb.0.1680040702025;
        Tue, 28 Mar 2023 14:58:22 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t20-20020a1709028c9400b001a04b92ddffsm21560171plo.140.2023.03.28.14.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 14:58:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/9] IB/qib: check for user backed iterator, not specific iterator type
Date:   Tue, 28 Mar 2023 15:58:08 -0600
Message-Id: <20230328215811.903557-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328215811.903557-1-axboe@kernel.dk>
References: <20230328215811.903557-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for switching single segment iterators to using ITER_UBUF,
swap the check for whether we are user backed or not.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/infiniband/hw/qib/qib_file_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index 80fe92a21f96..425de3bc3abf 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -2245,7 +2245,7 @@ static ssize_t qib_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct qib_ctxtdata *rcd = ctxt_fp(iocb->ki_filp);
 	struct qib_user_sdma_queue *pq = fp->pq;
 
-	if (!iter_is_iovec(from) || !from->nr_segs || !pq)
+	if (!from->user_backed || !from->nr_segs || !pq)
 		return -EINVAL;
 
 	return qib_user_sdma_writev(rcd, pq, from->iov, from->nr_segs);
-- 
2.39.2

