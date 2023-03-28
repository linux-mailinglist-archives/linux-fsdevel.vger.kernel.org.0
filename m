Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9F76CC962
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 19:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjC1Rgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 13:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjC1RgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:36:25 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42517D50D
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:23 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h187so3961067iof.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680024982; x=1682616982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwwpNkl97QizhYZnvuFRLqCzVAAtNtlsaziCI/Oydsc=;
        b=uzI0rbxg++PYHO5BNhGjMza/dk1NgVjdshDWsWlmzRr7H9YLnZ2uzOMJIPUL6MrY5U
         +J72JK4IxZjkavNlbXYHgIcFNKFoIwbDgCQUldQc9GMb/CEAv7RlnA7OdotBxGEeRwL3
         VpY90c8tpQ86DzcEprOw1DJohaOMUAS4gVnGEiUdhDTsnS5Lf+JeaWB7N3XXNyAxrMFW
         fWk2o8BZYS2O8+i6XDPRKkwLzRLDTQXaLd2PnPkM/XiDge2ERGWB/g8bWCQze+ubcAda
         PiJDkoDEvdfkB5gwktticUujhs2vLt3u3aOfb21ct9UF2FxfmSSwlhEz/vHywcsE+IZj
         sHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680024982; x=1682616982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwwpNkl97QizhYZnvuFRLqCzVAAtNtlsaziCI/Oydsc=;
        b=4DowxogwG2soX/zurOGtMQvNHHViNHHjuYUlbpI6QOr8NuUFkH2dcIHWhqLXkbq9td
         MLfblVTvuvrMjirQkzhz6/5Y+0xtxn7NEqOed+Nu6a9FkuAjuWwUzrrbvCJkEZzG8HUe
         kUOt1jlFd6Df+tcafpvj4ss20Vn+KX4sQYdKZMYzMIP3nNCHMcokhgk+hVo2GNZuaJW0
         EXYP65Pr1mfDWWQP6boM/QS6fy8ygcIeu/r/gCcmiMbziiNaCMuUO9Gb3sSCVxEqO5eK
         T0JwNIeHnXt0VJw1mB2ELtYoeWwXOegaVYJBFcYsOevcV0chvev4fPvpLlU7VVNXUqoC
         yMMg==
X-Gm-Message-State: AO0yUKX3p37agAzOW0JfsbJG5FKbZvRWhXm7XwKjcma06eRDeHbdDygB
        2MRCw+XqPJOTRSn5jQCLUwhS3VCFJO7nrJ9ebKHUtw==
X-Google-Smtp-Source: AK7set/Un9qW8bmzOkq5SY8B6Vw038uDJX44LA+Y2DrfyekNDESqBLes3NC6vzqrx9n6Qq0/fZB2Vg==
X-Received: by 2002:a05:6602:2f04:b0:758:9dcb:5d1a with SMTP id q4-20020a0566022f0400b007589dcb5d1amr11766576iow.2.1680024982329;
        Tue, 28 Mar 2023 10:36:22 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p15-20020a056638216f00b00403089c2a1dsm9994115jak.108.2023.03.28.10.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:36:22 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/8] IB/qib: make qib_write_iter() deal with ITER_UBUF iov_iter
Date:   Tue, 28 Mar 2023 11:36:11 -0600
Message-Id: <20230328173613.555192-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328173613.555192-1-axboe@kernel.dk>
References: <20230328173613.555192-1-axboe@kernel.dk>
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

Don't assume that a user backed iterator is always of the type
ITER_IOVEC. Handle the single segment case separately, then we can
use the same logic for ITER_UBUF and ITER_IOVEC.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/infiniband/hw/qib/qib_file_ops.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index 80fe92a21f96..577d972ba048 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -2244,10 +2244,18 @@ static ssize_t qib_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct qib_filedata *fp = iocb->ki_filp->private_data;
 	struct qib_ctxtdata *rcd = ctxt_fp(iocb->ki_filp);
 	struct qib_user_sdma_queue *pq = fp->pq;
+	int nr_segs = iovec_nr_user_vecs(from);
 
-	if (!iter_is_iovec(from) || !from->nr_segs || !pq)
+	if (!from->user_backed)
+		return -EFAULT;
+	if (!nr_segs || !pq)
 		return -EINVAL;
 
+	if (nr_segs == 1) {
+		struct iovec iov = iov_iter_iovec(from);
+		return qib_user_sdma_writev(rcd, pq, &iov, 1);
+	}
+
 	return qib_user_sdma_writev(rcd, pq, from->iov, from->nr_segs);
 }
 
-- 
2.39.2

