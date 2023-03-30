Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635066D0BAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 18:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjC3Qr3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 12:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjC3QrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:47:11 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DCBD321
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:10 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id bl9so8534180iob.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680194829; x=1682786829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbAbvx+wulf4ZJIYePr1YK4tcZKpHnBQRhSua/RrBns=;
        b=kL1/24VbKbclc2SL6+pLwEoAwOn+lLr8s8ZhOEEwS7zybypTEX+bmLnySP0qETe4L7
         YR5nuACtL2KzdXUhdkdEeN4126lrd2ddDVv6zD1UeXe8nc+RcbkradeC4LdBH0eRpViy
         SqorCzyTPS19rTISlGmMoTzk/Fnb7S3n7gl4lrpfe6DjSHgu2hM9sv+WrhaIsMKgivvF
         7Kp5ao7+f0p4DLSqFY5VaYyZ3vc8kkD9vUca3lSCnxHB4vXe82zQnx5L6MOXaoSlzaYZ
         jF4wOsEz+4wI6a6GzcKTApsvz7wm/MJNY0DNEfqVBoJbPjtr/1u1aIf5/kLMgoRluum/
         HnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194829; x=1682786829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbAbvx+wulf4ZJIYePr1YK4tcZKpHnBQRhSua/RrBns=;
        b=M+8jpFuKKVkc9Y5noxFTtbosWSpLwYqMhEaiXkGNoeN1cv1yfPi0gAz0Tz4l6yO7WY
         Ict4wdEvBWwgKa41OyTNVcla9kY6owwpp5G8MVu//F5e92kNWc4HTyd1+IARlYTpMi90
         uLuo5V6hbv6PQPq0SrNNYwYrfqouDEjJWFYyG1twfrYbTsEts2nzV7UWEzMI6tjXa7II
         J9EhWx9WKhC7/O/PUosWnBa7x8qq7la1FrNMLZnUuhrGM7sAK4eRIeX1WICwc7NxwR9r
         JlVYHexWxEfQEsd0KBy8yquv3LAtYkFVGIBwD+8Zhno3wmgRYqmUuoSMTtW4QWkCcOlt
         jIwQ==
X-Gm-Message-State: AAQBX9c/5Da/fn0mHPFuW3Z2c0EOVnogLijuWII63EMtxL5/Bz4P8kgE
        /sIDq6puz/EdwS4Bqz8Hzbq/ws+wD/cLf+ArR2avQw==
X-Google-Smtp-Source: AKy350bnN5FddadbaEMOudAStd3VJtKvQcQK/dO0ZTlvJH28BAglkAMw3/Nn8Akv4zU9xVyk1aq3mw==
X-Received: by 2002:a6b:8d8c:0:b0:758:9dcb:5d1a with SMTP id p134-20020a6b8d8c000000b007589dcb5d1amr1413507iod.2.1680194829721;
        Thu, 30 Mar 2023 09:47:09 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v21-20020a056638251500b003a53692d6dbsm20876jat.124.2023.03.30.09.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:47:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/11] IB/qib: check for user backed iterator, not specific iterator type
Date:   Thu, 30 Mar 2023 10:46:55 -0600
Message-Id: <20230330164702.1647898-5-axboe@kernel.dk>
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

