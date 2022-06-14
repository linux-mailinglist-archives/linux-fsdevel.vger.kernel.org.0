Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD77E54B851
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 20:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345139AbiFNSJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 14:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343661AbiFNSJy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E92DA45792
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655230192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpQuarki66IR7CQ0JeO2Q3emNhjmVObdjJYvYB9eELg=;
        b=DXHbNWs6N2IiHRc9iFZb4qG/M00yHfmBrDHYS9oXa4fexqXgJAEajDTda91lkUaPShQEBa
        QDuOObY2s668yEJdVCV1HHJFFrIPBbAtqG5jTPuJny9rmT+WFgw3XKh5jqvhUYz6oymXlV
        G2ZrbfhyVUviCEWJOeTLZ2SNgQpPkew=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-eKpFmPZfNvq5ByL94CXf4Q-1; Tue, 14 Jun 2022 14:09:50 -0400
X-MC-Unique: eKpFmPZfNvq5ByL94CXf4Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E2F63817A6C;
        Tue, 14 Jun 2022 18:09:50 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.16.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51D38492C3B;
        Tue, 14 Jun 2022 18:09:50 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ikent@redhat.com, onestero@redhat.com
Subject: [PATCH 3/3] proc: use idr tgid tag hint to iterate pids in readdir
Date:   Tue, 14 Jun 2022 14:09:49 -0400
Message-Id: <20220614180949.102914-4-bfoster@redhat.com>
In-Reply-To: <20220614180949.102914-1-bfoster@redhat.com>
References: <20220614180949.102914-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The tgid pid/task scan in proc_pid_readdir() is rather inefficient.
It linearly walks the pid_namespace and checks each allocated pid
for an associated PIDTYPE_TGID task. This has shown to impact
getdents() latency in environments that might have processes with
very large thread counts.

For example, on a mostly idle 2.4GHz Intel Xeon running Fedora on
5.19.0-rc2, 'strace -T xfs_io -c readdir /proc' shows the following:

  getdents64(... /* 814 entries */, 32768) = 20624 <0.000568>

With the addition of a dummy (i.e. idle) process running that
creates an additional 100k threads, that latency increases to:

  getdents64(... /* 815 entries */, 32768) = 20656 <0.011315>

While this may not be noticeable in one off /proc scans or simple
usage of ps or top, we have users that report problems caused by
this latency increase in these sort of scaled environments with
custom tooling that makes heavier use of task monitoring.

Optimize the tgid task scanning in proc_pid_readdir() by using
IDR_TGID tag lookups in the pid namespace tree. Tagged pids are not
guaranteed to have an associated PIDTYPE_TGID task, but pids that do
are always tagged. This significantly improves readdir() latency
when the pid namespace is populated with group leader tasks with
unusually large thread counts. For example, the above 100k idle task
test against a patched kernel now results in the following:

Idle:
  getdents64(... /* 861 entries */, 32768) = 21048 <0.000670>

"" + 100k threads:
  getdents64(... /* 862 entries */, 32768) = 21096 <0.000959>

... which is a much smaller latency hit after the high thread count
task is started.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/proc/base.c      |  2 +-
 include/linux/idr.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8dfa36a99c74..fd3c8a5f8c2d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3436,7 +3436,7 @@ static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter ite
 	rcu_read_lock();
 retry:
 	iter.task = NULL;
-	pid = find_ge_pid(iter.tgid, ns);
+	pid = find_tgid_pid(&ns->idr, iter.tgid);
 	if (pid) {
 		iter.tgid = pid_nr_ns(pid, ns);
 		iter.task = pid_task(pid, PIDTYPE_TGID);
diff --git a/include/linux/idr.h b/include/linux/idr.h
index 11e0ccedfc92..5ef32311b232 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -185,6 +185,20 @@ static inline bool idr_is_group_lead(struct idr *idr, unsigned long id)
 	return radix_tree_tag_get(&idr->idr_rt, id, IDR_TGID);
 }
 
+/*
+ * Find the next id with a potentially associated TGID task using the internal
+ * tag. Task association is not guaranteed and must be checked explicitly.
+ */
+static inline struct pid *find_tgid_pid(struct idr *idr, unsigned long id)
+{
+	struct pid *pid;
+
+	if (radix_tree_gang_lookup_tag(&idr->idr_rt, (void **) &pid, id, 1,
+				       IDR_TGID) != 1)
+		return NULL;
+	return pid;
+}
+
 /**
  * idr_for_each_entry() - Iterate over an IDR's elements of a given type.
  * @idr: IDR handle.
-- 
2.34.1

