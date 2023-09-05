Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD02793122
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 23:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244172AbjIEVoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 17:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbjIEVoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8B3CE5
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 14:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693950166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uQJce4v94fBnSsGo2eU4ZKQw/Wk8m14ksf+Px8TLSGM=;
        b=ZBE8Hs7oczX6PZ8XChPGE5ZUsFIMv36rZzXvpmcXUxVYgo1iXbPiJC6YJDSLYMul5tmdt7
        beT4rpG+ztXE2xqrNiP82JEmhbU5XvS108E2oBKz+6YDSBZw1FSOadKaEss0upzlNOSujn
        9Viw6tkBlRLT6OgcpP4ac6hPCq8vXwY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-2blVHz9vM_m9FpJG1qOWhQ-1; Tue, 05 Sep 2023 17:42:44 -0400
X-MC-Unique: 2blVHz9vM_m9FpJG1qOWhQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76f025ed860so44176885a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 14:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693950164; x=1694554964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQJce4v94fBnSsGo2eU4ZKQw/Wk8m14ksf+Px8TLSGM=;
        b=LWgEK7HaXpUE21HNmgkwidteBIZalKfJn5SlZ6XNjw813HtGu3kHQol9ayPCD9pqeo
         uK+r361KSAUdILMN0yjbR0Xo2QNl6QrnM1c8dEIMVIn+MDXxvsHpTzgg6ZIjKWBX3FVT
         YlkPL3lArzI2Hr9rIxXzrtrsSaskSS5biTmwPZR7QQ3u2e4KL+6BxUzW6L6LJ51qy/uA
         EbA8nvW17/IJ/xnlZRMTvoKl3qaCqFprQTWQqzgLaD8vv55g2vQ/sPZtXJSp+Kqyiuye
         PTW4C3hlLbwBK7DwyramAiG7gtDid4jynZE8x0cALWt4hnw9APGonouslSOFAygEddOZ
         ypZA==
X-Gm-Message-State: AOJu0YwF+bkYxD9Eof9X4Nr/aAKg5Gc7g3VpYsajPMG5aSsyR1KFuc4l
        f/FArFSRKC7AJMPTmaNxjYjqqQQYFziwIMhjgYp0d3zGe+MvBt8w8RShQ9ISzoRGn7AJTQR/VXV
        Yg2uET6XddVGt0/ZRJozjWOhZ1Q==
X-Received: by 2002:a05:620a:1aa4:b0:76f:1614:577d with SMTP id bl36-20020a05620a1aa400b0076f1614577dmr16479573qkb.4.1693950164463;
        Tue, 05 Sep 2023 14:42:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0CeamzOJT7Goeqq7g3UHhRHuitMC171tC//j49BSbILvNCZigPeU/QwAtYa7Vbv4u1ikW+A==
X-Received: by 2002:a05:620a:1aa4:b0:76f:1614:577d with SMTP id bl36-20020a05620a1aa400b0076f1614577dmr16479552qkb.4.1693950164161;
        Tue, 05 Sep 2023 14:42:44 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id i2-20020a37c202000000b007682af2c8aasm4396938qkm.126.2023.09.05.14.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:42:43 -0700 (PDT)
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
Subject: [PATCH 5/7] selftests/mm: Replace uffd_read_mutex with a semaphore
Date:   Tue,  5 Sep 2023 17:42:33 -0400
Message-ID: <20230905214235.320571-6-peterx@redhat.com>
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

Each uffd read threads unlocks the read mutex first, probably just to make
sure the thread is reaching a stage where pthread_cancel() can always work
before the main thread moves on.

However keeping the mutex locked always and unlock in the thread is a bit
hacky.  Replacing it with a semaphore which should be much clearer, where
the main thread will wait() and the thread will just post().  Move it to
uffd-common.* to be reused later.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-common.c | 1 +
 tools/testing/selftests/mm/uffd-common.h | 2 ++
 tools/testing/selftests/mm/uffd-stress.c | 8 +++-----
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 02b89860e193..aded06cab285 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -17,6 +17,7 @@ bool map_shared;
 bool test_uffdio_wp = true;
 unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
+sem_t uffd_read_sem;
 
 static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 {
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 7c4fa964c3b0..521523baded1 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -32,6 +32,7 @@
 #include <inttypes.h>
 #include <stdint.h>
 #include <sys/random.h>
+#include <semaphore.h>
 
 #include "../kselftest.h"
 #include "vm_util.h"
@@ -97,6 +98,7 @@ extern bool map_shared;
 extern bool test_uffdio_wp;
 extern unsigned long long *count_verify;
 extern volatile bool test_uffdio_copy_eexist;
+extern sem_t uffd_read_sem;
 
 extern uffd_test_ops_t anon_uffd_test_ops;
 extern uffd_test_ops_t shmem_uffd_test_ops;
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 469e0476af26..7219f55ae794 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -125,14 +125,12 @@ static int copy_page_retry(int ufd, unsigned long offset)
 	return __copy_page(ufd, offset, true, test_uffdio_wp);
 }
 
-pthread_mutex_t uffd_read_mutex = PTHREAD_MUTEX_INITIALIZER;
-
 static void *uffd_read_thread(void *arg)
 {
 	struct uffd_args *args = (struct uffd_args *)arg;
 	struct uffd_msg msg;
 
-	pthread_mutex_unlock(&uffd_read_mutex);
+	sem_post(&uffd_read_sem);
 	/* from here cancellation is ok */
 
 	for (;;) {
@@ -196,7 +194,7 @@ static int stress(struct uffd_args *args)
 					   uffd_read_thread,
 					   (void *)&args[cpu]))
 				return 1;
-			pthread_mutex_lock(&uffd_read_mutex);
+			sem_wait(&uffd_read_sem);
 		}
 		if (pthread_create(&background_threads[cpu], &attr,
 				   background_thread, (void *)cpu))
@@ -258,7 +256,7 @@ static int userfaultfd_stress(void)
 	zeropage = area;
 	bzero(zeropage, page_size);
 
-	pthread_mutex_lock(&uffd_read_mutex);
+	sem_init(&uffd_read_sem, 0, 0);
 
 	pthread_attr_init(&attr);
 	pthread_attr_setstacksize(&attr, 16*1024*1024);
-- 
2.41.0

