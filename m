Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAA86D0BAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 18:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjC3Qr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 12:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjC3QrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:47:11 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A1ECDF7
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:09 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e13so8562962ioc.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680194829; x=1682786829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xGS1WJPD4n46wbrdJA3HTeawxdexvwLRq+jxow2GHk=;
        b=Pm080zNxEKZihq5GCHr1WApWy6jkwiuEYJ71qEAmlp6adzXucMDNsMWMLV2yARIa20
         ArosHCZXaw1A0j1C6MkBECtcfZYECQkUa+ydrZ63aJDp5XsltUDkKfPHstWqALvD5dr8
         zn9YGjZtPZ3Tqy5cSNXl7WzYhxKfe9rE6nbV0LQFD8uM+9Fj456ELIR5V866prwPBq3L
         t4ujRGHi86iBwUbWGKTGgFcIPUvOiSfId+V8tYf6DX54m/GFpa5gcd6PArm/R+KCzjS4
         hG4NCHxQkmQhfp94rd8QpX8fTZVR1EB/jxopy9+fuwTQtaMhFYYtDewwzSTUqGVsG6aU
         h38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194829; x=1682786829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xGS1WJPD4n46wbrdJA3HTeawxdexvwLRq+jxow2GHk=;
        b=vGnLnkmYpimk78DUq0+XAXuh0gIWBMQhXzM8V0Pm7RhlnPCJ4HvztODDMmbrJ2k9sq
         ppv9Di7rwiQHrW091IgtUf1TTq6eVJ7lSPSCgOHYTXai9IpUD+EpbZfLkx7TbOv1sfsG
         Gl0fKI4KBZdw59rWIl9F5+KorOreEdd0OU/MEK4J9RQY/swKgAHcVBqCxeB89TcABJi4
         ZJpD1wt2oYW1Ltg/ZdzqdgNMYsFRpJhNlwiS7SniN4r4ViHPfv5N7kE+i/OY6kPTiqsm
         2I/sEfS5p2rsfSoqBYwWcm+yHHJIMzG65q5erg0smGyq8QPAK8UWenH/mb+r+ofTHB7m
         SBRQ==
X-Gm-Message-State: AO0yUKXZjoHbTSkwFYnENBb3L5+3Uh7o24EPDhkuhOgqtJkPk2lZWIup
        W7oow41iQSHS/80G0W5/4/sZBmKXXnXejZthONQP9A==
X-Google-Smtp-Source: AK7set/t0aXp+50AvjikBji+4hFd3QZt8YBWpHXN4zlaXGaQ9GF8mFpKHnacNLf++FhLec5k+dDWAA==
X-Received: by 2002:a5d:9d96:0:b0:757:f2a2:affa with SMTP id ay22-20020a5d9d96000000b00757f2a2affamr14783063iob.1.1680194828806;
        Thu, 30 Mar 2023 09:47:08 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v21-20020a056638251500b003a53692d6dbsm20876jat.124.2023.03.30.09.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:47:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/11] IB/hfi1: check for user backed iterator, not specific iterator type
Date:   Thu, 30 Mar 2023 10:46:54 -0600
Message-Id: <20230330164702.1647898-4-axboe@kernel.dk>
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

