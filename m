Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C2A480524
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 23:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhL0WiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 17:38:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231834AbhL0WiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 17:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640644687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Uf/VTxgXWXe/MU6bZ79vAxvKJyPz0bXiu+f31mk1cc=;
        b=X08n57P1ou7h6Rc4wEsKYh2R6xxljjnq+UbRLDXh5ylc4rioZojb20R6MSdkqKlvyaJyjc
        /g4Lj8JGdbzA+2Qp0l6fPucScYmWBrtoCzTaRQrjoyOaVAMhfDrz4pFuobywuNA70Cxq2l
        JPPJk5cOumqcBUlfllvsYKxI0OiJ3rA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-0kjuCe4ENGeeTDfRukP9Yw-1; Mon, 27 Dec 2021 17:38:04 -0500
X-MC-Unique: 0kjuCe4ENGeeTDfRukP9Yw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E96B081CCB4;
        Mon, 27 Dec 2021 22:38:01 +0000 (UTC)
Received: from wcosta.com (ovpn-116-95.gru2.redhat.com [10.97.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 153BB78D8F;
        Mon, 27 Dec 2021 22:37:29 +0000 (UTC)
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
        YunQiang Su <ysu@wavecomp.com>,
        Laurent Vivier <laurent@vivier.eu>,
        Wander Lairson Costa <wander@redhat.com>,
        Helge Deller <deller@gmx.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rafael Aquini <aquini@redhat.com>,
        Phil Auld <pauld@redhat.com>, Rolf Eike Beer <eb@emlix.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 4/4] exec: only set the suid flag if the current proc isn't root
Date:   Mon, 27 Dec 2021 19:34:35 -0300
Message-Id: <20211227223436.317091-5-wander@redhat.com>
In-Reply-To: <20211227223436.317091-1-wander@redhat.com>
References: <20211227223436.317091-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index b4bd157a5282..d73b21b6298c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1312,7 +1312,11 @@ int begin_new_exec(struct linux_binprm * bprm)
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

