Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E45D6B9A16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 16:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjCNPni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 11:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCNPnd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:43:33 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC01429E1C
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 08:42:53 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id bf15so6574616iob.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678808531; x=1681400531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHz2nZLJ4+lOFDzcTjzzzwSr1D9I38tSW7UFA8xP/Wc=;
        b=iViwvskyUrD//4VJS4EeDiJQJ9+jLVfuS3UhjpR6NN4jYjmy5SnVln807bJL41/L9H
         ig7FPnvJfEC5Ax0q72Ynsq3b+XGieUKQ0sHtUF/YR8BMQu6wzRMFcPWxX3BJ3jXXt3zo
         YplZGA+P/iff7aZfIPQHHFv8P8juSPLAvqcXkW2NAOVOj27gQ8GbJoHIrb89mjxX/pSx
         xfS3gpLDhOMQHYhmeH/L1/rdVt5NeIka91iZomNgoxEahN4YvBWJPxfWhivVmo9hIeGV
         N/hSJMh9iBRfPT7BedXGhdhbWc5oXGi1Sz/+k/LNPHjYeDEmuYuvH2HozT5B4CN8h83x
         CO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678808531; x=1681400531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHz2nZLJ4+lOFDzcTjzzzwSr1D9I38tSW7UFA8xP/Wc=;
        b=S4BFlyYGY8df6XozgmasVblXHU2yd2XU56GT5L6hJ9A8WjbZ53t0kO3GB6HuarMGTi
         R0+sLlWEXjdRYDbh9U4XmrXXw86lqVfSkLfdG3pq+ofW/FCZe069M0KeFmVz1unx3f2E
         f3hrfbQDjq61Xf1SGVQpUyeQEgQEYd8BOHT0pUgVJDOGlXHkTJ/WjvMWkZNCAys2nZ+2
         kJ+ruskiT45xraC82EiqbLqaG+5S1iNP3Wxd8tIBhNNtbZkg8zRGoOIRsqv10a0MSuY8
         sK2u0s9bkgSdsYPobo7op8syp0tPiJjCFhsJkyv2DSeTb0Nk1A21dI/a6J6I+oZ8uR4v
         /8sg==
X-Gm-Message-State: AO0yUKVCRMpC9qrMHjgTYpe+/+RYaInGV/s9tQ41i9vYhTe4lJcPtK31
        7NfvLlNPfirPKNRQ7Qr41ihMVA==
X-Google-Smtp-Source: AK7set8g0uVZ/TbXbVx1cBaqfSdKLbgSZ8iRV9KZ/U2mVbIm19U5+LVCfYmZY9YcN8rUxjj93Z9RoQ==
X-Received: by 2002:a6b:6e08:0:b0:74e:8718:a174 with SMTP id d8-20020a6b6e08000000b0074e8718a174mr13396ioh.1.1678808531079;
        Tue, 14 Mar 2023 08:42:11 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u9-20020a02cb89000000b003b0692eb199sm867929jap.20.2023.03.14.08.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:42:10 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     brauner@kernel.org, Jens Axboe <axboe@kernel.dk>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 3/3] pipe: set FMODE_NOWAIT on pipes
Date:   Tue, 14 Mar 2023 09:42:03 -0600
Message-Id: <20230314154203.181070-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314154203.181070-1-axboe@kernel.dk>
References: <20230314154203.181070-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The read/write path is now prepared to deal with IOCB_NOWAIT, hence
enable support for that via setting FMODE_NOWAIT on new pipes.

Acked-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/pipe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index dc00b20e56c8..b7e380952fca 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -999,6 +999,9 @@ static int __do_pipe_flags(int *fd, struct file **files, int flags)
 	audit_fd_pair(fdr, fdw);
 	fd[0] = fdr;
 	fd[1] = fdw;
+	/* pipe groks IOCB_NOWAIT */
+	files[0]->f_mode |= FMODE_NOWAIT;
+	files[1]->f_mode |= FMODE_NOWAIT;
 	return 0;
 
  err_fdr:
-- 
2.39.2

