Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A4B79311F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 23:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjIEVoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 17:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244212AbjIEVnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781C4CCB
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 14:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693950160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yL/LhjyJgEaE1ERsjh3smTILDBi2p+nbzGXe8vQHohc=;
        b=cExvXWBzwFl1JDZHXDuFq5M1VzgMv2DqitvxY09rqBT/BtoQBAPX+KrZZelMhZK7VX4HbU
        RSGr7B2beMoy0ooDg1W/e2PTRNHQve6gf1JNV/8/rvxqHG1HLf+yImRdGYMWu0Lzsp8yn3
        Ggd2iOPryx+gZ+cCCdyzTPByQiFd2/g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-qqeJ7uK4MSSohBCoqVFJog-1; Tue, 05 Sep 2023 17:42:39 -0400
X-MC-Unique: qqeJ7uK4MSSohBCoqVFJog-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76f025ed860so44174685a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 14:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693950159; x=1694554959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL/LhjyJgEaE1ERsjh3smTILDBi2p+nbzGXe8vQHohc=;
        b=RMlkXC1icrE9DFyNwzUI7I0QMu86fB8WtHV7wZctVfagcWr+fOjkCamGtb6Qrfcf5p
         zG9J7Urnvi8CHoC2RagupCn5lrL67MSQRJQDZtlo0i0XK1Bh9RuTofXPjVqWT5wDd3Cv
         SNbfNYA+aM45rGvZiHheU2LCk95AQUxXmS+/FELQrB8EYGBmgTGbEZAN+k2ThpdcSJRg
         UGBAPC5COUSmoxeXCd+AJxV6u2jE3WUhHdjvGK3+c2toDEUOyD5kzbN04Nv/Of/Nbbq2
         AOGPczlY/qbZlg+e+xmtc23n7bUAzMni2fKoUCdoAu/0Pf1WxfJKZ/OjSU3ImZ0NPYqN
         C1gg==
X-Gm-Message-State: AOJu0YwxyRtmwRpUgUy6NqsPwPAAMbIJtR6/1yzk+xZHJRj3mSl8u03g
        NuZt4VWK7cbowl69HnvlzEIP0UdQqGoZ1u/jWYKKXbJReN/rhlM+n4JcFo/AVcK+HL7TN/IxixE
        22zrj2Flox/FtoHRlQ9PbXjWu2Q==
X-Received: by 2002:a05:620a:1aa4:b0:76f:1614:577d with SMTP id bl36-20020a05620a1aa400b0076f1614577dmr16479343qkb.4.1693950158925;
        Tue, 05 Sep 2023 14:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdEZxCLbQuYXO7d4fPer9qvq4VofEooWqnv//Ff0/KOa/Ui0Gkdskd8CCG0Sg9WRZVsAXIfA==
X-Received: by 2002:a05:620a:1aa4:b0:76f:1614:577d with SMTP id bl36-20020a05620a1aa400b0076f1614577dmr16479333qkb.4.1693950158658;
        Tue, 05 Sep 2023 14:42:38 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id i2-20020a37c202000000b007682af2c8aasm4396938qkm.126.2023.09.05.14.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:42:38 -0700 (PDT)
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
Subject: [PATCH 1/7] mm/userfaultfd: Make uffd read() wait event exclusive
Date:   Tue,  5 Sep 2023 17:42:29 -0400
Message-ID: <20230905214235.320571-2-peterx@redhat.com>
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

From: Andrea Arcangeli <aarcange@redhat.com>

When a new message is generated for an userfaultfd, instead of waking up
all the readers, we can wake up only one exclusive reader to process the
event.  Waking up >1 readers for 1 message will be a waste of resource,
where the rest readers will see nothing again and re-queue.

This should make userfaultfd read() O(1) on wakeups.

Note that queuing on head is intended (rather than tail) to make sure the
readers are waked up in LIFO fashion; fairness doesn't matter much here,
but caching does.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
[peterx: modified subjects / commit message]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 56eaae9dac1a..f7fda7d0c994 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1061,7 +1061,11 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 
 	/* always take the fd_wqh lock before the fault_pending_wqh lock */
 	spin_lock_irq(&ctx->fd_wqh.lock);
-	__add_wait_queue(&ctx->fd_wqh, &wait);
+	/*
+	 * Only wake up one exclusive reader each time there's an event.
+	 * Paired with wake_up_poll() when e.g. a new page fault msg generated.
+	 */
+	__add_wait_queue_exclusive(&ctx->fd_wqh, &wait);
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		spin_lock(&ctx->fault_pending_wqh.lock);
-- 
2.41.0

