Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B46B480BE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Dec 2021 18:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbhL1RKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Dec 2021 12:10:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236650AbhL1RKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640711452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fIBVy+hA8YnjW75VVgRUSX7sqW1UFeQMpluWbq0Iuzc=;
        b=KqPGIunXgOs3607TgH+vx7hicjGR2poY0M5294a54XE8v7FzYKYGQD6/uLK2sBX84rYwZW
        KcPnWBXfiUnmpMvjldm/jhmG2I64m4vA1tq0tbJF9itYF/9lrLnZPQL7UwacF2jOB+htrk
        hl65fLiANOqszyidQ5T6fJrAuT9OvvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-iGJ0NmWiNw2qo6kE4eIvag-1; Tue, 28 Dec 2021 12:10:48 -0500
X-MC-Unique: iGJ0NmWiNw2qo6kE4eIvag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0C86102CB2A;
        Tue, 28 Dec 2021 17:10:45 +0000 (UTC)
Received: from wcosta.com (ovpn-116-95.gru2.redhat.com [10.97.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ACBE77440;
        Tue, 28 Dec 2021 17:10:00 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Gladkov <legion@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Rolf Eike Beer <eb@emlix.com>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC v2 1/4] exec: add a flag indicating if an exec file is a suid/sgid
Date:   Tue, 28 Dec 2021 14:09:05 -0300
Message-Id: <20211228170910.623156-2-wander@redhat.com>
In-Reply-To: <20211228170910.623156-1-wander@redhat.com>
References: <20211228170910.623156-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
index 537d92c41105..ec07b36fdbb4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1619,11 +1619,13 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
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

