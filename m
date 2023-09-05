Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1AD793128
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 23:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244576AbjIEVpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 17:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244638AbjIEVol (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89093E5C
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 14:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693950167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cw3DqXN0nAqgICZcLU+deZuKVK3JziD/s0/YHmFn328=;
        b=F8vv3UVlUcnGG3TwQmHglH33tfViEKeFb971EE/527Rj4rX4jbzU+spgRdlHDZgxVngJ0v
        Q/Np+UbNap1Fc13YgLFYYZ5kKTLarXqWuuLsCCiV4fkU+4mCF5SS1aoeytA+FkoNxdU9E0
        sbqNxGsQ6KGlxhGuxYMV+TKDoa5CD9Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-x7Yhf8inNwiBmUTOilUZUg-1; Tue, 05 Sep 2023 17:42:46 -0400
X-MC-Unique: x7Yhf8inNwiBmUTOilUZUg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76f191e26f5so91401085a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 14:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693950166; x=1694554966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cw3DqXN0nAqgICZcLU+deZuKVK3JziD/s0/YHmFn328=;
        b=eHyCL/qwHvzYKhIx7sX+gb10bTHSZBHGX07pJcv2vD+taCEvK/VGpGCOutJfrTUtsN
         n24e1/OZOXJSn5rpSd2zgW7KzjPyN9oxrpUT03iJ//pZIBbINYhQVoxF5l4TuHnnQHT0
         xz0Hkef+jWStJwHB5twI+duoUneIaDrXAjzZE+sCtcnZtyNahv+LQwjjCjlUG45bF3yb
         tv3woVC5TYZe+LpBaNJp/++YKGKuiyuj1vKYB8uZb7NaC09oMUbNNJXqGCCRMJk+XBVh
         l+mDlUiiA0fvcftXbx0wnt6LUNRBwTX75piYHAzxuhQb8fc4XBFvkthHpKolfHIH2lHc
         GGnA==
X-Gm-Message-State: AOJu0YxQZs57dZDRQxu3dPApz/muUeKiPD+xa06TJt+199zDZpE/+hP5
        +rDf1uxBfUbzHQiaT3jF+XG3qDuzyubDFMDNy6qd02r+gYbA4xzVsxWUtMbveEGfPKei4i4PRDU
        7US/ShC79ZGvGu6jGImETG74t5A==
X-Received: by 2002:a05:620a:4712:b0:76f:1b38:e74a with SMTP id bs18-20020a05620a471200b0076f1b38e74amr15367604qkb.4.1693950165774;
        Tue, 05 Sep 2023 14:42:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjHmAQEBZtigx4G4B3sp1ASlOU6CNSzPZeJM4WgpbfHkl1dq3l/QojNcctzg5rIDRzuMLaUA==
X-Received: by 2002:a05:620a:4712:b0:76f:1b38:e74a with SMTP id bs18-20020a05620a471200b0076f1b38e74amr15367597qkb.4.1693950165524;
        Tue, 05 Sep 2023 14:42:45 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id i2-20020a37c202000000b007682af2c8aasm4396938qkm.126.2023.09.05.14.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:42:45 -0700 (PDT)
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
Subject: [PATCH 6/7] selftests/mm: Create uffd_fault_thread_create|join()
Date:   Tue,  5 Sep 2023 17:42:34 -0400
Message-ID: <20230905214235.320571-7-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214235.320571-1-peterx@redhat.com>
References: <20230905214235.320571-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make them common functions to be reused.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-common.c | 46 ++++++++++++++++++++++
 tools/testing/selftests/mm/uffd-common.h |  4 ++
 tools/testing/selftests/mm/uffd-stress.c | 49 ++++--------------------
 3 files changed, 57 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index aded06cab285..851284395b29 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -555,6 +555,52 @@ void *uffd_poll_thread(void *arg)
 	return NULL;
 }
 
+void *uffd_read_thread(void *arg)
+{
+	struct uffd_args *args = (struct uffd_args *)arg;
+	struct uffd_msg msg;
+
+	sem_post(&uffd_read_sem);
+	/* from here cancellation is ok */
+
+	for (;;) {
+		if (uffd_read_msg(uffd, &msg))
+			continue;
+		uffd_handle_page_fault(&msg, args);
+	}
+
+	return NULL;
+}
+
+void uffd_fault_thread_create(pthread_t *thread, pthread_attr_t *attr,
+			      struct uffd_args *args, bool poll)
+{
+	if (poll) {
+		if (pthread_create(thread, attr, uffd_poll_thread, args))
+			err("uffd_poll_thread create");
+	} else {
+		if (pthread_create(thread, attr, uffd_read_thread, args))
+			err("uffd_read_thread create");
+		sem_wait(&uffd_read_sem);
+	}
+}
+
+void uffd_fault_thread_join(pthread_t thread, int cpu, bool poll)
+{
+	char c = 1;
+
+	if (poll) {
+		if (write(pipefd[cpu*2+1], &c, 1) != 1)
+			err("pipefd write error");
+	} else {
+		if (pthread_cancel(thread))
+			err("pthread_cancel()");
+	}
+
+	if (pthread_join(thread, NULL))
+		err("pthread_join()");
+}
+
 static void retry_copy_page(int ufd, struct uffdio_copy *uffdio_copy,
 			    unsigned long offset)
 {
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 521523baded1..9d66ad5c52cb 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -114,6 +114,10 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args);
 int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
 int copy_page(int ufd, unsigned long offset, bool wp);
 void *uffd_poll_thread(void *arg);
+void *uffd_read_thread(void *arg);
+void uffd_fault_thread_create(pthread_t *thread, pthread_attr_t *attr,
+			      struct uffd_args *args, bool poll);
+void uffd_fault_thread_join(pthread_t thread, int cpu, bool poll);
 
 int uffd_open_dev(unsigned int flags);
 int uffd_open_sys(unsigned int flags);
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 7219f55ae794..915795e33432 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -125,23 +125,6 @@ static int copy_page_retry(int ufd, unsigned long offset)
 	return __copy_page(ufd, offset, true, test_uffdio_wp);
 }
 
-static void *uffd_read_thread(void *arg)
-{
-	struct uffd_args *args = (struct uffd_args *)arg;
-	struct uffd_msg msg;
-
-	sem_post(&uffd_read_sem);
-	/* from here cancellation is ok */
-
-	for (;;) {
-		if (uffd_read_msg(uffd, &msg))
-			continue;
-		uffd_handle_page_fault(&msg, args);
-	}
-
-	return NULL;
-}
-
 static void *background_thread(void *arg)
 {
 	unsigned long cpu = (unsigned long) arg;
@@ -186,16 +169,10 @@ static int stress(struct uffd_args *args)
 		if (pthread_create(&locking_threads[cpu], &attr,
 				   locking_thread, (void *)cpu))
 			return 1;
-		if (bounces & BOUNCE_POLL) {
-			if (pthread_create(&uffd_threads[cpu], &attr, uffd_poll_thread, &args[cpu]))
-				err("uffd_poll_thread create");
-		} else {
-			if (pthread_create(&uffd_threads[cpu], &attr,
-					   uffd_read_thread,
-					   (void *)&args[cpu]))
-				return 1;
-			sem_wait(&uffd_read_sem);
-		}
+
+		uffd_fault_thread_create(&uffd_threads[cpu], &attr,
+					 &args[cpu], bounces & BOUNCE_POLL);
+
 		if (pthread_create(&background_threads[cpu], &attr,
 				   background_thread, (void *)cpu))
 			return 1;
@@ -220,21 +197,9 @@ static int stress(struct uffd_args *args)
 		if (pthread_join(locking_threads[cpu], NULL))
 			return 1;
 
-	for (cpu = 0; cpu < nr_cpus; cpu++) {
-		char c;
-		if (bounces & BOUNCE_POLL) {
-			if (write(pipefd[cpu*2+1], &c, 1) != 1)
-				err("pipefd write error");
-			if (pthread_join(uffd_threads[cpu],
-					 (void *)&args[cpu]))
-				return 1;
-		} else {
-			if (pthread_cancel(uffd_threads[cpu]))
-				return 1;
-			if (pthread_join(uffd_threads[cpu], NULL))
-				return 1;
-		}
-	}
+	for (cpu = 0; cpu < nr_cpus; cpu++)
+		uffd_fault_thread_join(uffd_threads[cpu], cpu,
+				       bounces & BOUNCE_POLL);
 
 	return 0;
 }
-- 
2.41.0

