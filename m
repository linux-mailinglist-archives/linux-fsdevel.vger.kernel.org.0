Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6E76CCC6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 23:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjC1V60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 17:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjC1V6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:58:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEC2101
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j13so12205216pjd.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680040701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxwDziOTETlNB1TsasU187NvE1wajWuHVah14pxhtB8=;
        b=5IgrwfOligvR2jM7jZP1lB59a4YqbzPl+YDPGihoIlBdDLyxpg4A1MVQBlvb5yXTvq
         x0lD9WAqbJ1N3bB6aaoSBUJtpbHMjxjcQv2S+KGX2nLbK93HzJavDePtwWxQiIiEmJ6f
         vjLgsGObxcCsD7dyFZkcWshg0cTtd3U8IMNz9iVbN9+g/fspznHAjWI24ZfduR69pEZw
         ZA6rApCMO0HlJM9ikN7eH/b2kKLCP7m35CxHVSUgVZsRvOMVZbZzqagdCeL+w2Si2tsC
         qC+cV7+E2iqfnyaR9vJoJGe6zOA8H7eXwfhCx0cY0IhRIpDHf+IBg9Z2QeoFgVf1SfNU
         JyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680040701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxwDziOTETlNB1TsasU187NvE1wajWuHVah14pxhtB8=;
        b=CGkHmrktkObG2SmcH3MclZrmwtVNsmxvS/deMlsmR3BYDfpQJJz8l2oSiZYiEaGRVK
         Q7C4xDNyX/rCoE6fOPJDb9y18ESCrSJ93SYTKhpVH7989ZakmjP+lbeHVJ2DJ/pvhDXl
         AlWdbYbPg3jSmZOsAM+wAOuKO+YxLayH8459HV2NhQ5zbdcvhDdk9jUEA7YFTs5Qs+sR
         rBjkcIWfy+ed9ngP64riHKxYmXKbW/Cup2xO5EbGKQJ1OON5il5j1ly9KBRZZ4I7Zmui
         zfSne6UCIk5ky1js0hjWUpWLkKTjNmcKp4p4n6Q7zWVsW44Mo7+JgZ08tHcHC2bJfzu8
         3hHw==
X-Gm-Message-State: AAQBX9fW5ARHc8/6XvO0RrQtcan3lFShYnuhrU9s8XkywCyaH8tEWZtR
        bgAoBmczH4tUP0WFdPEACXcdNvPp1ow6Nop/4vxKDw==
X-Google-Smtp-Source: AKy350bYNOyK8KvY4iAeRzqFeh3GJVjtKmufYAPFMLGqXM0SJ4w9JrH5MHz3+C4+Pybv2Mj5i1f2lg==
X-Received: by 2002:a17:902:ecd1:b0:1a0:53ba:ff1f with SMTP id a17-20020a170902ecd100b001a053baff1fmr15126619plh.0.1680040700744;
        Tue, 28 Mar 2023 14:58:20 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t20-20020a1709028c9400b001a04b92ddffsm21560171plo.140.2023.03.28.14.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 14:58:20 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/9] IB/hfi1: check for user backed iterator, not specific iterator type
Date:   Tue, 28 Mar 2023 15:58:07 -0600
Message-Id: <20230328215811.903557-6-axboe@kernel.dk>
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
swap the check for whether we are user backed or not. While at it, move
it outside the srcu locking area to clean up the code a bit.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/infiniband/hw/hfi1/file_ops.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index b1d6ca7e9708..fc2257c09b03 100644
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

