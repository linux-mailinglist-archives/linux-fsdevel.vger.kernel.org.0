Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCFD79311E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 23:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244206AbjIEVn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 17:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244104AbjIEVnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1436CE42
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 14:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693950163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BAc+MDavbWwJ6795LOxgDkxGvxMJL+vGI+ILCcyBkDQ=;
        b=PTgUd/sNxIM7N+a+OPfC/o/PAhnprxkaQ1Mc6p2YfCyAZDQeWRcROiI+8kB0Tq8sZzkHIb
        1oaCx5Sz3JtZgF0EESJ9rRgDOU3/NWVj8vFJlxXuvCJ6oaSFfXIkVGDBb2gbSoLWZM4vKn
        ovyrq76eFBsozNJXaSO5CTH2HNtylFA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-vzaHc_KjMeWJYYU3crm0tQ-1; Tue, 05 Sep 2023 17:42:42 -0400
X-MC-Unique: vzaHc_KjMeWJYYU3crm0tQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76f097b28ecso19718685a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 14:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693950162; x=1694554962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAc+MDavbWwJ6795LOxgDkxGvxMJL+vGI+ILCcyBkDQ=;
        b=DSqXaYTQ0xeAaee9LDH8s4ZPZfvAkn9qvxdKy7bLsHkcx91s1cWbkhbrOfJPODF49G
         BCSr5WZGHhvRVcrgug3SOdn1Fc44u5zdWO2jvmWVc/z5BxCmNDgPgey7NJ33/Z0dFD48
         8M4Bk6yFHkvbuP99imPNomHzQlSJ/t8IilAkYkWWngCdeiLFnUyIOe8yap26jXYqFlAc
         JPsk3U0Epzt8MNCIBJX0BrgQVBSHLdcL1mdJGT/g+m1PVitDizicVB6or2ULQza85Jhi
         9mh3KsNOsYn277I33VUZo/qBjRYVIPA32MR22mo4pDjS05aOFUNF4bXuJn/X8CJv5ldt
         9s0w==
X-Gm-Message-State: AOJu0Yzvu9rpWp9spub+Umn7LsJJ29hjc2uVXH9OnlosrmyQ7PdDLopl
        d+s8jenPdCAGnD1tPm1+UQ9nD3eOSpIeHuwPq1Lij7zAgw32+jomFauAn1w5MEcTIC/BJmSr+H+
        BVblVH8Rybw8Y33eUBVEH4dTCGA==
X-Received: by 2002:a05:620a:1a26:b0:76c:ed4e:ac10 with SMTP id bk38-20020a05620a1a2600b0076ced4eac10mr16770020qkb.6.1693950161778;
        Tue, 05 Sep 2023 14:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX81eRpvF4K65o6If4EOmXGS0BgJwHt7s35QflxCMt79X+rblwCZ36Xulk34UDBuMUSImVnw==
X-Received: by 2002:a05:620a:1a26:b0:76c:ed4e:ac10 with SMTP id bk38-20020a05620a1a2600b0076ced4eac10mr16769997qkb.6.1693950161469;
        Tue, 05 Sep 2023 14:42:41 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id i2-20020a37c202000000b007682af2c8aasm4396938qkm.126.2023.09.05.14.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:42:41 -0700 (PDT)
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
Subject: [PATCH 3/7] poll: POLL_ENQUEUE_EXCLUSIVE
Date:   Tue,  5 Sep 2023 17:42:31 -0400
Message-ID: <20230905214235.320571-4-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214235.320571-1-peterx@redhat.com>
References: <20230905214235.320571-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a flag for poll_wait() showing that the caller wants the enqueue to be
exclusive.  It is similar to EPOLLEXCLUSIVE for epoll() but grants kernel
poll users to opt-in with more efficient exclusive queuing where applicable.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/select.c          |  5 ++++-
 include/linux/poll.h | 20 ++++++++++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 0433448481e9..a3c9088e8d76 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -231,7 +231,10 @@ static void __pollwait(struct file *filp, wait_queue_head_t *wait_address,
 	entry->key = p->_key;
 	init_waitqueue_func_entry(&entry->wait, pollwake);
 	entry->wait.private = pwq;
-	add_wait_queue(wait_address, &entry->wait);
+	if (flags & POLL_ENQUEUE_EXCLUSIVE)
+		add_wait_queue_exclusive(wait_address, &entry->wait);
+	else
+		add_wait_queue(wait_address, &entry->wait);
 }
 
 static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
diff --git a/include/linux/poll.h b/include/linux/poll.h
index cbad520fc65c..11af98ae579c 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -29,6 +29,8 @@
 
 typedef unsigned int poll_flags;
 
+#define POLL_ENQUEUE_EXCLUSIVE  BIT(0)
+
 struct poll_table_struct;
 
 /* 
@@ -46,10 +48,24 @@ typedef struct poll_table_struct {
 	__poll_t _key;
 } poll_table;
 
-static inline void poll_wait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
+static inline void __poll_wait(struct file *filp, wait_queue_head_t *wait_address,
+			       poll_table *p, poll_flags flags)
 {
 	if (p && p->_qproc && wait_address)
-		p->_qproc(filp, wait_address, p, 0);
+		p->_qproc(filp, wait_address, p, flags);
+}
+
+static inline void poll_wait(struct file *filp, wait_queue_head_t *wait_address,
+			     poll_table *p)
+{
+	__poll_wait(filp, wait_address, p, 0);
+}
+
+static inline void poll_wait_exclusive(struct file *filp,
+				       wait_queue_head_t *wait_address,
+				       poll_table *p)
+{
+	__poll_wait(filp, wait_address, p, POLL_ENQUEUE_EXCLUSIVE);
 }
 
 /*
-- 
2.41.0

