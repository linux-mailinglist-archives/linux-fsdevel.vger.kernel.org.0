Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36379793121
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 23:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242202AbjIEVoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 17:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244431AbjIEVoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E134E46
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 14:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693950165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i4qwgXUgzQeLfKMT3tv3YVc7S/hLt8ARXOPSgsfGIQ4=;
        b=GVvzjIixE/gC1e/RMKsa5QLbfGh0hq9vH7IkpfXZC5uBygeayeVtrz7wbeaVgb9lk9mZVm
        2jAUnj2Krbz5aLTn5pD3MKWQFM3G5L1OHbn6stCTaoefDm70LHq5Kk/4MR21faa/AK257m
        dad7Lcci/aOT8eBxOCV/1yxd51SoqkA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-23XmAZG3NQGHlw4WilLdLw-1; Tue, 05 Sep 2023 17:42:43 -0400
X-MC-Unique: 23XmAZG3NQGHlw4WilLdLw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-63d2b88325bso6453446d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 14:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693950163; x=1694554963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4qwgXUgzQeLfKMT3tv3YVc7S/hLt8ARXOPSgsfGIQ4=;
        b=IOZlajhRU++c3a2IWoccFHWrmzHBLNrRdHWUlDTjlzCmEonH0LUAZdUY9vFOPZaBkI
         hiBUtv6BfszjT7eC22yJptU3Cf2IVOhHMNaKxkQMzHBk4lj4uSrjL8MCThNWAOxIc5sD
         C9+yDe78frXtngzWLUpNB1M+SkMeEd1n/05Mm1Cf31fsDnJXdORQzFP8n76KKv+wD+Vk
         65pyBa+z1HBc1+EoVwfdT0qBj8tpCuOUP9nXY1c5nuoXiJibQBPealIDntw17S7EZSSq
         Rpn/mbQnSIhAQIwFm0krruWqNm92AQlHUXVhohXpR+95VIufQPDlGSnXG/kBYrJLYFGi
         vuEg==
X-Gm-Message-State: AOJu0YyZWbe9cexqMBSXNkUHABS+Y1XuwuMHdpazh5G/JBQT3+gbhmx3
        gT5mTwdnTdn6bGS5NFXdWHhCI93rIxGh1TyvkfFvWgmyO0IUpL4byBW7m/4Ojqq87sEIHzRx6Wg
        OyXMRxLo7dZxi+dsefzGJzBHbUA==
X-Received: by 2002:a05:6214:21e4:b0:64a:8d39:3378 with SMTP id p4-20020a05621421e400b0064a8d393378mr17304043qvj.4.1693950163016;
        Tue, 05 Sep 2023 14:42:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlS4tLxX3RT0SNIZn/SUsnHB3xGIbADDb9sPouLrcBV//Rq31qTbeRmNhRZtJnSN5gXEiBhA==
X-Received: by 2002:a05:6214:21e4:b0:64a:8d39:3378 with SMTP id p4-20020a05621421e400b0064a8d393378mr17304030qvj.4.1693950162797;
        Tue, 05 Sep 2023 14:42:42 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id i2-20020a37c202000000b007682af2c8aasm4396938qkm.126.2023.09.05.14.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:42:42 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Anish Moorthy <amoorthy@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Christian Brauner <brauner@kernel.org>, peterx@redhat.com,
        linux-fsdevel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 4/7] fs/userfaultfd: Use exclusive waitqueue for poll()
Date:   Tue,  5 Sep 2023 17:42:32 -0400
Message-ID: <20230905214235.320571-5-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214235.320571-1-peterx@redhat.com>
References: <20230905214235.320571-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Userfaultfd is the kind of fd that does not need a wake all semantics when
wake up.  Enqueue using the new POLL_ENQUEUE_EXCLUSIVE flag.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index f7fda7d0c994..9c39adc398fc 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -994,7 +994,7 @@ static __poll_t userfaultfd_poll(struct file *file, poll_table *wait)
 	struct userfaultfd_ctx *ctx = file->private_data;
 	__poll_t ret;
 
-	poll_wait(file, &ctx->fd_wqh, wait);
+	poll_wait_exclusive(file, &ctx->fd_wqh, wait);
 
 	if (!userfaultfd_is_initialized(ctx))
 		return EPOLLERR;
-- 
2.41.0

