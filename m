Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1E36CF258
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 20:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjC2SlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 14:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjC2SlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:41:12 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A552E5260
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:08 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h187so5518470iof.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680115268; x=1682707268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbAbvx+wulf4ZJIYePr1YK4tcZKpHnBQRhSua/RrBns=;
        b=i/aFHmZoCpMqZl6FXMw+T03+UL6N14GYACYsmk+zlqsT4FaGZzGcnP9ufw8drSAHT8
         lAiE3qCo43QUWbt3yDc6d0zTxPfsIjAm4LesepDrecaLYcEtuaCY+tRqlgusRvtDe0Pl
         1ltdzcCYf8xk419eBjo86/u/0gbnXw7Hp9FClCb6VJD7BV+DLc7GmXcrwtbW1YLUa0fN
         WoqY2IaesVMNje09QfjuAo3MiRMysvM9uOpjpPGB70NMYZpbi+XeWyi5Rtz4fvKNZCFH
         vJUQBZwKhsBAV/QeqGFq8kiTxP8cl1K91hrKz5z0p6bMmg++Y+RLi0akT7ly/DiIZTT9
         Id2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115268; x=1682707268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbAbvx+wulf4ZJIYePr1YK4tcZKpHnBQRhSua/RrBns=;
        b=H/z3AYdJS8H4UQxMUBhIxhfUYtfrXf+5txzaAuYL0jlsiqvWdRVzKZtWWMJVZzPgKL
         xZNwg3bc5n1tRXhE6yO5dhzITT9rp0enId61PHnxKYUPXZX1wu6VePwkhcEmBIncDIjB
         X4238+iVTxHDopWxqc/95XlgGx3+CRMXtz/2/ai4YQVY5PpMZzVd3yCYJYnSZucGtdqM
         KuVHDSQzMlqMZsNTAZoft/Pj1ckfcDRKab2W2SVHVsF4XRgwn7XifZniUQXdHD2D93GS
         Zl3X69Q6EFy6gzOH+XSw7iiu1u5qkwdAkTgXWj7CsQyssIqLS3SHPdx/oV6v/Li3x7cE
         BgWg==
X-Gm-Message-State: AO0yUKVUvKEkREuOfzP+7b7XtzWTNHFCgmGBjaf5geoQPJBUtAJkX3Tc
        TLUVb3eowvbRoG5s05956CPINSIiXMF6j1RpdD4WPA==
X-Google-Smtp-Source: AK7set9OqgsKxt44QIf3xpV4OzzDRCwCk1c/e+Uzt7UK1+mLA2Kn7SPEFjQRBg5pNbrmENqUcsDWxA==
X-Received: by 2002:a05:6602:2dcf:b0:758:6517:c621 with SMTP id l15-20020a0566022dcf00b007586517c621mr15108166iow.2.1680115267652;
        Wed, 29 Mar 2023 11:41:07 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m36-20020a056638272400b004063e6fb351sm10468087jav.89.2023.03.29.11.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:41:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/11] IB/qib: check for user backed iterator, not specific iterator type
Date:   Wed, 29 Mar 2023 12:40:52 -0600
Message-Id: <20230329184055.1307648-9-axboe@kernel.dk>
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
swap the check for whether we are user backed or not.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/infiniband/hw/qib/qib_file_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index 4cee39337866..815ea72ad473 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -2245,7 +2245,7 @@ static ssize_t qib_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct qib_ctxtdata *rcd = ctxt_fp(iocb->ki_filp);
 	struct qib_user_sdma_queue *pq = fp->pq;
 
-	if (!iter_is_iovec(from) || !from->nr_segs || !pq)
+	if (!from->user_backed || !from->nr_segs || !pq)
 		return -EINVAL;
 
 	return qib_user_sdma_writev(rcd, pq, iter_iov(from), from->nr_segs);
-- 
2.39.2

