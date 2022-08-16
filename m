Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C917D595DE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 16:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiHPOAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 10:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbiHPOAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:00:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BDC491E7
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 07:00:30 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27G9inkf008361
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 07:00:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=VnKI2p9F7lsB7NxKiuJl2dToVpYX6lGSZuife1T99VQ=;
 b=HlILdw51Pn+QHWMYcgawEmOimsCw62pJKk5G0gCyg+UOiHd7v/lhq+c+/tBpwlLfzTzv
 y2K/99DB+ZRJJKAFl4VpjPgw0PAabI+1cW8/nFBdKZh6Sfz7tIp+QLnGHI9zPQzMbw4p
 LUJc7ElkmLznlsBQTc7Fgh/jtP1gdP0Ceac= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j08vdsbk0-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 07:00:29 -0700
Received: from twshared7556.02.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 16 Aug 2022 07:00:27 -0700
Received: by devbig038.lla2.facebook.com (Postfix, from userid 572232)
        id 786BA4A9B6F3; Tue, 16 Aug 2022 07:00:17 -0700 (PDT)
From:   Dylan Yudaken <dylany@fb.com>
To:     <viro@zeniv.linux.org.uk>, <bcrl@kvack.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-aio@kvack.org>,
        <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        <Kernel-team@fb.com>, Dylan Yudaken <dylany@fb.com>
Subject: [PATCH] eventfd: guard wake_up in eventfd fs calls as well
Date:   Tue, 16 Aug 2022 06:59:59 -0700
Message-ID: <20220816135959.1490641-1-dylany@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hwr_2f7Yftm3PorzgbkzL5MF5BbOsBrg
X-Proofpoint-ORIG-GUID: hwr_2f7Yftm3PorzgbkzL5MF5BbOsBrg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Guard wakeups that the user can trigger, and that may end up triggering a
call back into eventfd_signal. This is in addition to the current approac=
h
that only guards in eventfd_signal.

Rename in_eventfd_signal -> in_eventfd at the same time to reflect this.

Without this there would be a deadlock in the following code using libaio=
:

int main()
{
	struct io_context *ctx =3D NULL;
	struct iocb iocb;
	struct iocb *iocbs[] =3D { &iocb };
	int evfd;
        uint64_t val =3D 1;

	evfd =3D eventfd(0, EFD_CLOEXEC);
	assert(!io_setup(2, &ctx));
	io_prep_poll(&iocb, evfd, POLLIN);
	io_set_eventfd(&iocb, evfd);
	assert(1 =3D=3D io_submit(ctx, 1, iocbs));
        write(evfd, &val, 8);
}

Signed-off-by: Dylan Yudaken <dylany@fb.com>
---
 fs/eventfd.c            | 10 +++++++---
 include/linux/eventfd.h |  2 +-
 include/linux/sched.h   |  2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 3627dd7d25db..c0ffee99ad23 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -69,17 +69,17 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n=
)
 	 * it returns false, the eventfd_signal() call should be deferred to a
 	 * safe context.
 	 */
-	if (WARN_ON_ONCE(current->in_eventfd_signal))
+	if (WARN_ON_ONCE(current->in_eventfd))
 		return 0;
=20
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
-	current->in_eventfd_signal =3D 1;
+	current->in_eventfd =3D 1;
 	if (ULLONG_MAX - ctx->count < n)
 		n =3D ULLONG_MAX - ctx->count;
 	ctx->count +=3D n;
 	if (waitqueue_active(&ctx->wqh))
 		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
-	current->in_eventfd_signal =3D 0;
+	current->in_eventfd =3D 0;
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
=20
 	return n;
@@ -253,8 +253,10 @@ static ssize_t eventfd_read(struct kiocb *iocb, stru=
ct iov_iter *to)
 		__set_current_state(TASK_RUNNING);
 	}
 	eventfd_ctx_do_read(ctx, &ucnt);
+	current->in_eventfd =3D 1;
 	if (waitqueue_active(&ctx->wqh))
 		wake_up_locked_poll(&ctx->wqh, EPOLLOUT);
+	current->in_eventfd =3D 0;
 	spin_unlock_irq(&ctx->wqh.lock);
 	if (unlikely(copy_to_iter(&ucnt, sizeof(ucnt), to) !=3D sizeof(ucnt)))
 		return -EFAULT;
@@ -301,8 +303,10 @@ static ssize_t eventfd_write(struct file *file, cons=
t char __user *buf, size_t c
 	}
 	if (likely(res > 0)) {
 		ctx->count +=3D ucnt;
+		current->in_eventfd =3D 1;
 		if (waitqueue_active(&ctx->wqh))
 			wake_up_locked_poll(&ctx->wqh, EPOLLIN);
+		current->in_eventfd =3D 0;
 	}
 	spin_unlock_irq(&ctx->wqh.lock);
=20
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index 305d5f19093b..30eb30d6909b 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -46,7 +46,7 @@ void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64=
 *cnt);
=20
 static inline bool eventfd_signal_allowed(void)
 {
-	return !current->in_eventfd_signal;
+	return !current->in_eventfd;
 }
=20
 #else /* CONFIG_EVENTFD */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e7b2f8a5c711..8d82d6d32670 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -936,7 +936,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_EVENTFD
 	/* Recursion prevention for eventfd_signal() */
-	unsigned			in_eventfd_signal:1;
+	unsigned			in_eventfd:1;
 #endif
 #ifdef CONFIG_IOMMU_SVA
 	unsigned			pasid_activated:1;
--=20
2.30.2

