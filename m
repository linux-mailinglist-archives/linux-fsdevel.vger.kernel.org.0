Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BADB6CAC9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 20:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjC0SE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 14:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjC0SE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:04:56 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440DC268A
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:04:56 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7585535bd79so5157639f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679940295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPiNKiOlYrgP6omvQGmrOl81AEJmBJkx0lTBPz4b7B0=;
        b=2FAs0UHa5PbdBxQkOdD37QEeRqtQyUfu3yBnEySkLNPSeSmPke7p6FDAf/AMWMI3Vo
         WnChdq0LErNLgIqJAsuJN/2KLOKHJyhK/mJCrgkHHYKjALXDsRKmELMmYD0nITJ6l2Sz
         eN8IbSYeg67fLZunqCf+etMec2ts0RLI4dEt2wzYHm4I4i8J09ELNSGX/CPS337i4ept
         4GwBCguGd9kEXuobIcyGNk5RTd82nwIznFkOG8ZBNq0J5aLkuu3f7/hSrfQ6y9r9z4mD
         84TSy0VI0UwoAgU/3vE22BELQ6iFnczUG0mvRS5F5bbdFEh7pzfhuw6nLiq0BeS6Iaca
         DtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679940295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPiNKiOlYrgP6omvQGmrOl81AEJmBJkx0lTBPz4b7B0=;
        b=TWwfYH0Tc5XEsDgQcOUaQlylDrPycjcVkaegKimBd7O6GJrE54gOZ9nNfvWp9Yt1q7
         OLtryAqZyEFCDnsHSQTvC/YDfJmEDU8nJjsVl7/c26AkelNMZAxYm+tgQXD+wE9Xo7bR
         o6GcwTSBX/o828jPafxxEqINgFfz/+wlgnOuPFLVG8XGelyDwyL9CUVtpMJ1d3OmyqQy
         HqOxFqMm2HNbxIuXtivUMaNbeIhPwxnnw13Fov8AI61tQnmIVVk7SUIaaMd9MlIVC12T
         Zm0hHP01zgn9xZNLgPj3tk6MCczFZPYzP4Zwnfxq9g4zbtnIfF1ywX1h2VNvyBTkG0S+
         Mf0Q==
X-Gm-Message-State: AO0yUKW/GaEd5iw3ht8kiXzNMbpOQdKqpMkOa4EnKQ9PzqOuOCRPzyVG
        ZIq0OJwtNCJ/AXOD8QO/kHwHDRzCxnPvislJVTxKZw==
X-Google-Smtp-Source: AK7set9NlcEs/CUNvUhV04SXXajqAMjZurHOQLts04ilQGgM3ySXuM0RG7vcUd+qqQu8kLDOd5iy/g==
X-Received: by 2002:a05:6602:2d87:b0:759:485:41d with SMTP id k7-20020a0566022d8700b007590485041dmr7342874iow.0.1679940295300;
        Mon, 27 Mar 2023 11:04:55 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e28-20020a0566380cdc00b0040634c51861sm8853235jak.132.2023.03.27.11.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 11:04:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] fs: make do_loop_readv_writev() deal with ITER_UBUF
Date:   Mon, 27 Mar 2023 12:04:46 -0600
Message-Id: <20230327180449.87382-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327180449.87382-1-axboe@kernel.dk>
References: <20230327180449.87382-1-axboe@kernel.dk>
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

We caller this helper if we don't have a read_iter/write_iter available,
and it will go over the iov_iter manually copying data in/out as needed.
But it's currently assuming it's being passed an ITER_IOVEC. Enable
use of ITER_UBUF with this helper as well, in preparation for importing
single segment iovecs as ITER_UBUF.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/read_write.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 7a2ff6157eda..de9ce948d11a 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -748,10 +748,21 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
 	if (flags & ~RWF_HIPRI)
 		return -EOPNOTSUPP;
 
+	if (WARN_ON_ONCE(iter->iter_type != ITER_IOVEC &&
+			 iter->iter_type != ITER_UBUF))
+		return -EINVAL;
+
 	while (iov_iter_count(iter)) {
-		struct iovec iovec = iov_iter_iovec(iter);
+		struct iovec iovec;
 		ssize_t nr;
 
+		if (iter_is_ubuf(iter)) {
+			iovec.iov_base = iter->ubuf + iter->iov_offset;
+			iovec.iov_len = iov_iter_count(iter);
+		} else {
+			iovec = iov_iter_iovec(iter);
+		}
+
 		if (type == READ) {
 			nr = filp->f_op->read(filp, iovec.iov_base,
 					      iovec.iov_len, ppos);
-- 
2.39.2

