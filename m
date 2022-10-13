Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001D45FD015
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Oct 2022 02:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiJMAY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 20:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiJMAXd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 20:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E72101E1;
        Wed, 12 Oct 2022 17:20:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFDBB616E1;
        Thu, 13 Oct 2022 00:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF295C433C1;
        Thu, 13 Oct 2022 00:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665620409;
        bh=65OQIF2TZJuQiwOc2TEY9Dne2mpIqXtPwuvl01EMQCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmsDvKLM+/D9lfLtbO45t64NgWwX5LssOrRrQWR2irzSG4eBTd3kvui0j+1nTrqwg
         RBeoQn+f31dh30VgpIJm+lLQXPb2r6B6mifw3KMg/SXbYdHZDW0LLKJDgTlV8emTJm
         9QGI1DG2kN+kWwxz68ytlQrMDBJfMx8Mkf+5vLtWE15Jr9Tr16R45ERwBHgH8x7ncl
         zhK7KqDg3Wd2XrwRk0if9hvc21zFAxgblpIauDxx9dcOrjDgsB1dVM6XfYnsxwMiiS
         6Ybf7SA1UOYBKiS1Ik2DRjoPiOGWSg+IHQW5abmH4p8KtElYwqBSZiosMJZZn8/R1L
         vYP/He1HEPp6g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dylan Yudaken <dylany@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, viro@zeniv.linux.org.uk,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 34/63] eventfd: guard wake_up in eventfd fs calls as well
Date:   Wed, 12 Oct 2022 20:18:08 -0400
Message-Id: <20221013001842.1893243-34-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013001842.1893243-1-sashal@kernel.org>
References: <20221013001842.1893243-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dylan Yudaken <dylany@fb.com>

[ Upstream commit 9f0deaa12d832f488500a5afe9b912e9b3cfc432 ]

Guard wakeups that the user can trigger, and that may end up triggering a
call back into eventfd_signal. This is in addition to the current approach
that only guards in eventfd_signal.

Rename in_eventfd_signal -> in_eventfd at the same time to reflect this.

Without this there would be a deadlock in the following code using libaio:

int main()
{
	struct io_context *ctx = NULL;
	struct iocb iocb;
	struct iocb *iocbs[] = { &iocb };
	int evfd;
        uint64_t val = 1;

	evfd = eventfd(0, EFD_CLOEXEC);
	assert(!io_setup(2, &ctx));
	io_prep_poll(&iocb, evfd, POLLIN);
	io_set_eventfd(&iocb, evfd);
	assert(1 == io_submit(ctx, 1, iocbs));
        write(evfd, &val, 8);
}

Signed-off-by: Dylan Yudaken <dylany@fb.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Link: https://lore.kernel.org/r/20220816135959.1490641-1-dylany@fb.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventfd.c            | 10 +++++++---
 include/linux/eventfd.h |  2 +-
 include/linux/sched.h   |  2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 3627dd7d25db..c0ffee99ad23 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -69,17 +69,17 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
 	 * it returns false, the eventfd_signal() call should be deferred to a
 	 * safe context.
 	 */
-	if (WARN_ON_ONCE(current->in_eventfd_signal))
+	if (WARN_ON_ONCE(current->in_eventfd))
 		return 0;
 
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
-	current->in_eventfd_signal = 1;
+	current->in_eventfd = 1;
 	if (ULLONG_MAX - ctx->count < n)
 		n = ULLONG_MAX - ctx->count;
 	ctx->count += n;
 	if (waitqueue_active(&ctx->wqh))
 		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
-	current->in_eventfd_signal = 0;
+	current->in_eventfd = 0;
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
 
 	return n;
@@ -253,8 +253,10 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 		__set_current_state(TASK_RUNNING);
 	}
 	eventfd_ctx_do_read(ctx, &ucnt);
+	current->in_eventfd = 1;
 	if (waitqueue_active(&ctx->wqh))
 		wake_up_locked_poll(&ctx->wqh, EPOLLOUT);
+	current->in_eventfd = 0;
 	spin_unlock_irq(&ctx->wqh.lock);
 	if (unlikely(copy_to_iter(&ucnt, sizeof(ucnt), to) != sizeof(ucnt)))
 		return -EFAULT;
@@ -301,8 +303,10 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 	}
 	if (likely(res > 0)) {
 		ctx->count += ucnt;
+		current->in_eventfd = 1;
 		if (waitqueue_active(&ctx->wqh))
 			wake_up_locked_poll(&ctx->wqh, EPOLLIN);
+		current->in_eventfd = 0;
 	}
 	spin_unlock_irq(&ctx->wqh.lock);
 
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index 305d5f19093b..30eb30d6909b 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -46,7 +46,7 @@ void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
 
 static inline bool eventfd_signal_allowed(void)
 {
-	return !current->in_eventfd_signal;
+	return !current->in_eventfd;
 }
 
 #else /* CONFIG_EVENTFD */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6d877c7e22ff..e02dc270fa2c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -934,7 +934,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_EVENTFD
 	/* Recursion prevention for eventfd_signal() */
-	unsigned			in_eventfd_signal:1;
+	unsigned			in_eventfd:1;
 #endif
 #ifdef CONFIG_IOMMU_SVA
 	unsigned			pasid_activated:1;
-- 
2.35.1

