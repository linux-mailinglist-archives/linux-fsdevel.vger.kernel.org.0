Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406B929AE11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 14:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368008AbgJ0Nzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 09:55:40 -0400
Received: from casper.infradead.org ([90.155.50.34]:41602 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368005AbgJ0Nzg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pWNWXU0q2YTOp9LS6CIUuWc+DOyY6dTv9ZJgSxrytoA=; b=u+kVoBLbLajl9QDJRDWxaY+83/
        kr4BsivC1jiJYACOGKucrHQfU91AaP4S9sGGpl7EKOSXufEKnwDNcx5x1ndBpwRAd3MNeKwRB5xx0
        owgw2wA+y00Bj+5ZjaPZol5Vcf/0aacpfcKfE5/UJBfJrfHgp5fCpVjRONDEwJq4MjFgyyOw66Rj+
        fLNsCmO+GnbPmIE/rSKL8DWiYtY7yjA0WrdQ7HSBd9WQlgkeX33AdEKH+HWnXW56nIuY/pMiAqobL
        kEFCkRYWdczGCkwnFanEM9m/XWvVS3kTKyQYE8KnvURJCYvYW9+UPN5TnjnCAuobFn4XCU5WtCqgi
        5Mbj0H5A==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXPRe-00009T-1M; Tue, 27 Oct 2020 13:55:26 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat Linux))
        id 1kXPRd-002iLb-KB; Tue, 27 Oct 2020 13:55:25 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     bonzini@redhat.com
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] eventfd: Export eventfd_ctx_do_read()
Date:   Tue, 27 Oct 2020 13:55:21 +0000
Message-Id: <20201027135523.646811-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027135523.646811-1-dwmw2@infradead.org>
References: <1faa5405-3640-f4ad-5cd9-89a9e5e834e9@redhat.com>
 <20201027135523.646811-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

Where events are consumed in the kernel, for example by KVM's
irqfd_wakeup() and VFIO's virqfd_wakeup(), they currently lack a
mechanism to drain the eventfd's counter.

Since the wait queue is already locked while the wakeup functions are
invoked, all they really need to do is call eventfd_ctx_do_read().

Add a check for the lock, and export it for them.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 fs/eventfd.c            | 5 ++++-
 include/linux/eventfd.h | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index df466ef81ddd..e265b6dd4f34 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -182,11 +182,14 @@ static __poll_t eventfd_poll(struct file *file, poll_table *wait)
 	return events;
 }
 
-static void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
+void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
 {
+	lockdep_assert_held(&ctx->wqh.lock);
+
 	*cnt = (ctx->flags & EFD_SEMAPHORE) ? 1 : ctx->count;
 	ctx->count -= *cnt;
 }
+EXPORT_SYMBOL_GPL(eventfd_ctx_do_read);
 
 /**
  * eventfd_ctx_remove_wait_queue - Read the current counter and removes wait queue.
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index dc4fd8a6644d..fa0a524baed0 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -41,6 +41,7 @@ struct eventfd_ctx *eventfd_ctx_fileget(struct file *file);
 __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n);
 int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *wait,
 				  __u64 *cnt);
+void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
 
 DECLARE_PER_CPU(int, eventfd_wake_count);
 
@@ -82,6 +83,11 @@ static inline bool eventfd_signal_count(void)
 	return false;
 }
 
+static inline void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
+{
+
+}
+
 #endif
 
 #endif /* _LINUX_EVENTFD_H */
-- 
2.26.2

