Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFD74846B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 18:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiADRLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 12:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiADRLP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:11:15 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A90C061761;
        Tue,  4 Jan 2022 09:11:15 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gj24so31933202pjb.0;
        Tue, 04 Jan 2022 09:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UboeUmb8H0AVGAmewa2oS6rOO216gnmYoMnDmA4f5dg=;
        b=CboQD2EBoXiAlB4NVewyVjgWRsGkcg5jedETFZOWB+mnMGz9VnOySZwfmCZTWhmywq
         L7QYy4gZiGqOJL5eyynTgYHDhJTMXSLi25CLTKG8SLRC0H5CgE8KQptXaJzzKYIIWt5f
         Nvv2DpTURZzHGAzxAMcKGwZfoTwXP+3KB+VXaL1UK4ywHkDx9UKu3nMR7qU2S2ONJQtT
         ysEhRs2tkZ8HZ9yB9gVPnaiR9yI0MwbDr1pudlucXGLhAjM116X7UNPzam2yzYJxMlpa
         42lWjF8CsPEPugCs70iBmBRLWY5zYDodkRrkVml+NiIypt8Ggf/gBkj32SHJx3lxjA56
         lQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UboeUmb8H0AVGAmewa2oS6rOO216gnmYoMnDmA4f5dg=;
        b=z5qqLVc1G2SquOvBxqpKHXeN/4BTp5KPWlwkie9kkAA9PIrCx/WppHOitpndEHw7kZ
         qHyamUhUq8eeq2stUuAxd82asD1beiVw8nZ0p/d95fPcbRuL2l7paXeKHfjg4hRuIwyl
         VNPpw/eR/CkTbiUzY7i5B+rCuun4qnCk2C3jvRg1W2hjFlgsneNbZEilG15QL26C4yd+
         pq6NkxSTE4gQ3x9DT8A89T/9tEg2lWPJu1IHAi4nEb0ViBJ/K9vwdO/b57PIhgH459jD
         Ea8Tzb29qRbtqXyvQBJ2xGYgEQlIEvdTgY17xJrmWcfKJxyD9cbRPAHH05tCkksr1QrY
         tDiQ==
X-Gm-Message-State: AOAM53194y2G23nEYBZAipFbM6as/rjUov5QZVwt69+if50p/BQw5/8S
        RXD+kRW2C+TwLrrehBFxpvrObL6gAZg=
X-Google-Smtp-Source: ABdhPJxy+peU+s5QAQimkKKq9pVTzjQlCisLmQBQbn2isAYCP/wA1mD4Xck0RuwvePEHpE6p0JFnqg==
X-Received: by 2002:a17:902:e282:b0:148:ef58:10d8 with SMTP id o2-20020a170902e28200b00148ef5810d8mr51800506plc.116.1641316274749;
        Tue, 04 Jan 2022 09:11:14 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:bd71:fea:c430:7b0a])
        by smtp.gmail.com with ESMTPSA id g16sm40746591pfv.159.2022.01.04.09.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:11:14 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH] fs/pipe: use kvcalloc to allocate a pipe_buffer array
Date:   Tue,  4 Jan 2022 09:10:58 -0800
Message-Id: <20220104171058.22580-1-avagin@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Right now, kcalloc is used to allocate a pipe_buffer array.  The size of
the pipe_buffer struct is 40 bytes. kcalloc allows allocating reliably
chunks with sizes less or equal to PAGE_ALLOC_COSTLY_ORDER (3). It means
that the maximum pipe size is 3.2MB in this case.

In CRIU, we use pipes to dump processes memory. CRIU freezes a target
process, injects a parasite code into it and then this code splices
memory into pipes. If a maximum pipe size is small, we need to
do many iterations or create many pipes.

kvcalloc attempt to allocate physically contiguous memory, but upon
failure, fall back to non-contiguous (vmalloc) allocation and so it
isn't limited by PAGE_ALLOC_COSTLY_ORDER.

The maximum pipe size for non-root users is limited by
the /proc/sys/fs/pipe-max-size sysctl that is 1MB by default, so only
the root user will be able to trigger vmalloc allocations.

Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 fs/pipe.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 6d4342bad9f1..45565773ec33 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -802,7 +802,7 @@ struct pipe_inode_info *alloc_pipe_info(void)
 	if (too_many_pipe_buffers_hard(user_bufs) && pipe_is_unprivileged_user())
 		goto out_revert_acct;
 
-	pipe->bufs = kcalloc(pipe_bufs, sizeof(struct pipe_buffer),
+	pipe->bufs = kvcalloc(pipe_bufs, sizeof(struct pipe_buffer),
 			     GFP_KERNEL_ACCOUNT);
 
 	if (pipe->bufs) {
@@ -845,7 +845,7 @@ void free_pipe_info(struct pipe_inode_info *pipe)
 	}
 	if (pipe->tmp_page)
 		__free_page(pipe->tmp_page);
-	kfree(pipe->bufs);
+	kvfree(pipe->bufs);
 	kfree(pipe);
 }
 
@@ -1260,8 +1260,7 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	if (nr_slots < n)
 		return -EBUSY;
 
-	bufs = kcalloc(nr_slots, sizeof(*bufs),
-		       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+	bufs = kvcalloc(nr_slots, sizeof(*bufs), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!bufs))
 		return -ENOMEM;
 
@@ -1288,7 +1287,7 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	head = n;
 	tail = 0;
 
-	kfree(pipe->bufs);
+	kvfree(pipe->bufs);
 	pipe->bufs = bufs;
 	pipe->ring_size = nr_slots;
 	if (pipe->max_usage > nr_slots)
-- 
2.33.1

