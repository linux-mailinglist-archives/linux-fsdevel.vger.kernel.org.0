Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5C413AEB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgANQMe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:12:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbgANQMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kUvZdbrxgXYM+XtmN49YBQ9SrUjZBQUmtmFMa7zViEA=; b=LRd1rAVdu7xTOpYjtX3JQ4QZqG
        OqE7DLd8J2fmEAv0BXF5eYeuB+Q4dCGgSpqnyXC/I+SAPH2yKKm2W8AGVklxNeHrCc1aMXKfFPqh3
        FftbCFmQR9IbEawSShE+O3RO0vdHjoG5zBSXk6SDvo6YgfFtI01W1ebtS0qaocS8cQyK9O7GSYqZx
        5UM81HbcAvgOK6roMBpJ7uqBXhC5VacnY/zdsuGhGItpqfMqGz3rcy0umTAJQXsjxlnxGk4qs8+UO
        mklssD83lByYvKT7G3flWLK7WiKJVLPSMW6Cg4vdkf0oaB2HzWfW+ruX2oiypP9+wwGm7uH9HiCzy
        9qiyXnxw==;
Received: from [2001:4bb8:18c:4f54:fcbb:a92b:61e1:719] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irOnw-00007u-QN; Tue, 14 Jan 2020 16:12:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 02/12] locking/rwsem: Exit early when held by an anonymous owner
Date:   Tue, 14 Jan 2020 17:12:15 +0100
Message-Id: <20200114161225.309792-3-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114161225.309792-1-hch@lst.de>
References: <20200114161225.309792-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The rwsem code overloads the owner field with either a task struct or
negative magic numbers.  Add a quick hack to catch these negative
values early on.  Without this spinning on a writer that replaced the
owner with RWSEM_OWNER_UNKNOWN, rwsem_spin_on_owner can crash while
deferencing the task_struct ->on_cpu field of a -8 value.

XXX: This might be a bit of a hack as the code otherwise doesn't use
the ERR_PTR family macros, better suggestions welcome.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/locking/rwsem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 44e68761f432..6adc719a30a1 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -725,6 +725,8 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
 	state = rwsem_owner_state(owner, flags, nonspinnable);
 	if (state != OWNER_WRITER)
 		return state;
+	if (IS_ERR(owner))
+		return state;
 
 	rcu_read_lock();
 	for (;;) {
-- 
2.24.1

