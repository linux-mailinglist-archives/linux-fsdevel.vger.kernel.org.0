Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8F4480C00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Dec 2021 18:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbhL1RNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Dec 2021 12:13:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236066AbhL1RNn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640711623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PRytPH178REvN8Uq5T4UrkS8ZBRAkLw6uslccqzTXjU=;
        b=GKqgy18iyBdfp2dHCdkbsKMstex+/Z87ozj+6UMeiS6tqL/H9vIQwkrDg2Jwqj5mwcHnvY
        HKPAJIovjSddO7utoCWGTLWyi+0h2MlgEEj3hPy5iZn9/gLkaUg1EcfC5hSfwpH6Bv8CjL
        R/35C0tAEnjXnk9L/4NxMbG2GsJ+t6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-tAnc3_h7NpytNCGKi0S5cg-1; Tue, 28 Dec 2021 12:13:39 -0500
X-MC-Unique: tAnc3_h7NpytNCGKi0S5cg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97F28801B0C;
        Tue, 28 Dec 2021 17:13:37 +0000 (UTC)
Received: from wcosta.com (ovpn-116-95.gru2.redhat.com [10.97.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 195727744A;
        Tue, 28 Dec 2021 17:12:23 +0000 (UTC)
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
        Helge Deller <deller@gmx.de>,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Hildenbrand <david@redhat.com>,
        Rolf Eike Beer <eb@emlix.com>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC v2 4/4] exec: only set the suid flag if the current proc isn't root
Date:   Tue, 28 Dec 2021 14:09:08 -0300
Message-Id: <20211228170910.623156-5-wander@redhat.com>
In-Reply-To: <20211228170910.623156-1-wander@redhat.com>
References: <20211228170910.623156-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The goal of PF_SUID flag is to check if it is safe to coredump the
process. If the current process is already privileged, there is no
point in performing security checks because the name image is a
set-uid process.

Because of that, we don't set the suid flag if the forked process
already runs as root.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 fs/exec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 81d6ab9a4f64..1a3458c6c9b7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1310,7 +1310,11 @@ int begin_new_exec(struct linux_binprm * bprm)
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
 					PF_NOFREEZE | PF_NO_SETAFFINITY);
 
-	if (bprm->suid_bin)
+	/*
+	 * We set the PF_SUID flags for security reasons. There is no
+	 * point in setting it if the parent is root.
+	 */
+	if (bprm->suid_bin && !capable(CAP_SYS_ADMIN))
 		me->flags |= PF_SUID;
 
 	flush_thread();
-- 
2.27.0

