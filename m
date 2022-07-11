Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE825704AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 15:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiGKNws (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 09:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiGKNwo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30D6F61D5D
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657547562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZZi7tQd5jc7PjCR++DRTDi/vBjqHkl8WrqcY6+kDf54=;
        b=dfLiIbaj07wvHLmrCrcMUYmkRWxveVy+zGIQRSrlrFvoNhBNGVYbILI1sP2CDDq43N5SKM
        X7VDvlqnmuwKqUMpKS3gvyv6D/iWB5ENvlTXLMiU44KwLCiyzBgrQfA65qhBE+bOMiBEHe
        WzStoXcF2kG0FThLuJkPQsF6vPahTFE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-2FbtIBGBPJiSAqOprJ_oBg-1; Mon, 11 Jul 2022 09:52:39 -0400
X-MC-Unique: 2FbtIBGBPJiSAqOprJ_oBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D31431C01B23;
        Mon, 11 Jul 2022 13:52:38 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.32.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EA4618EA8;
        Mon, 11 Jul 2022 13:52:38 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ikent@redhat.com, onestero@redhat.com, willy@infradead.org
Subject: [PATCH v2 4/4] procfs: use efficient tgid pid search on root readdir
Date:   Mon, 11 Jul 2022 09:52:37 -0400
Message-Id: <20220711135237.173667-5-bfoster@redhat.com>
In-Reply-To: <20220711135237.173667-1-bfoster@redhat.com>
References: <20220711135237.173667-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

find_ge_pid() walks every allocated id and checks every associated
pid in the namespace for a link to a PIDTYPE_TGID task. If the pid
namespace contains processes with large numbers of threads, this
search doesn't scale and can notably increase getdents() syscall
latency.

For example, on a mostly idle 2.4GHz Intel Xeon running Fedora on
5.19.0-rc2, 'strace -T xfs_io -c readdir /proc' shows the following:

  getdents64(... /* 814 entries */, 32768) = 20624 <0.000568>

With the addition of a dummy (i.e. idle) process running that
creates an additional 100k threads, that latency increases to:

  getdents64(... /* 815 entries */, 32768) = 20656 <0.011315>

While this may not be noticeable to users in one off /proc scans or
simple usage of ps or top, we have users that report problems caused
by this latency increase in these sort of scaled environments with
custom tooling that makes heavier use of task monitoring.

Optimize the tgid task scanning in proc_pid_readdir() by using the
more efficient find_get_tgid_task() helper. This significantly
improves readdir() latency when the pid namespace is populated with
processes with very large thread counts. For example, the above 100k
idle task test against a patched kernel now results in the
following:

Idle:
  getdents64(... /* 861 entries */, 32768) = 21048 <0.000670>

"" + 100k threads:
  getdents64(... /* 862 entries */, 32768) = 21096 <0.000959>

... which is a much smaller latency hit after the high thread count
task is started.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/proc/base.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8dfa36a99c74..b3bff6d26dcc 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3429,24 +3429,9 @@ struct tgid_iter {
 };
 static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter iter)
 {
-	struct pid *pid;
-
 	if (iter.task)
 		put_task_struct(iter.task);
-	rcu_read_lock();
-retry:
-	iter.task = NULL;
-	pid = find_ge_pid(iter.tgid, ns);
-	if (pid) {
-		iter.tgid = pid_nr_ns(pid, ns);
-		iter.task = pid_task(pid, PIDTYPE_TGID);
-		if (!iter.task) {
-			iter.tgid += 1;
-			goto retry;
-		}
-		get_task_struct(iter.task);
-	}
-	rcu_read_unlock();
+	iter.task = find_get_tgid_task(&iter.tgid, ns);
 	return iter;
 }
 
-- 
2.35.3

