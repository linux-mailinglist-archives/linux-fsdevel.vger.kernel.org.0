Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8343848051E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 23:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbhL0Wg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 17:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233812AbhL0Wg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 17:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640644588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I2MPpu4RRED/PxNo7vsNt+qZUGBH+EFljvAOqHQFBbM=;
        b=hmVD3pZTa+ibUKJ3HR0fGgOG8LnttH/asFFR7I3eAzsXNwR+FCvo1+SYQnSpx98hR88WZ+
        lsY1RPaZ9CdLCyGI1bGMTOC0wAIxyky+gEo9hK5lnroDSCFd9SPmBAfy5S8i//g5MKLvuX
        1P70hhfi6K556qUmWDs1ICqIt+EuagQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-BaBpK_k9NfyzWgxzx5evvA-1; Mon, 27 Dec 2021 17:36:25 -0500
X-MC-Unique: BaBpK_k9NfyzWgxzx5evvA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAF84800480;
        Mon, 27 Dec 2021 22:36:22 +0000 (UTC)
Received: from wcosta.com (ovpn-116-95.gru2.redhat.com [10.97.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 442E078D8F;
        Mon, 27 Dec 2021 22:35:41 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Laurent Vivier <laurent@vivier.eu>,
        Wander Lairson Costa <wander@redhat.com>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Phil Auld <pauld@redhat.com>, Rolf Eike Beer <eb@emlix.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 1/4] exec: add a flag indicating if an exec file is a suid/sgid
Date:   Mon, 27 Dec 2021 19:34:32 -0300
Message-Id: <20211227223436.317091-2-wander@redhat.com>
In-Reply-To: <20211227223436.317091-1-wander@redhat.com>
References: <20211227223436.317091-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We create an additional flag in the struct linux_bprm to indicate a
suid/sgid binary. We will use this information in a later commit to
set the task_struct flags accordingly.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 fs/exec.c               | 2 ++
 include/linux/binfmts.h | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 2bb8dd6a4e2a..3913b335b95f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1621,11 +1621,13 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	if (mode & S_ISUID) {
 		bprm->per_clear |= PER_CLEAR_ON_SETID;
 		bprm->cred->euid = uid;
+		bprm->suid_bin = 1;
 	}
 
 	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 		bprm->per_clear |= PER_CLEAR_ON_SETID;
 		bprm->cred->egid = gid;
+		bprm->suid_bin = 1;
 	}
 }
 
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 049cf9421d83..c4b41b9711d2 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -41,7 +41,11 @@ struct linux_binprm {
 		 * Set when errors can no longer be returned to the
 		 * original userspace.
 		 */
-		point_of_no_return:1;
+		point_of_no_return:1,
+		/*
+		 * Is this a suid/sgid binary?
+		 */
+		suid_bin:1;
 #ifdef __alpha__
 	unsigned int taso:1;
 #endif
-- 
2.27.0

