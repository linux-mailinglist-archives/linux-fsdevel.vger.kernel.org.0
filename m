Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE3A41CD57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 22:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346674AbhI2UZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 16:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43578 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346369AbhI2UZV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 16:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632947019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=l9h1XTy2+9znaKOPv2jvvVkbR7Fsg4CSbp1LYA7ZS1o=;
        b=bjU5qdai10MsH7ssHdiI/fNWAqTHm1IFotF6wdC3aZ20T64BYtnDBjTE3HyZwaz9y7CGsL
        wCcPOQTicE/lcgmfm3cWbVL2QYJO48fe3YtQs22oDM1goS3/C4z/XUDl+LdNN9c0EwOAa1
        p1a2jXoe1WFx/OPnHbgnrteV71q/JGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-1l0GWO55N1e1UR2lZCemeQ-1; Wed, 29 Sep 2021 16:23:38 -0400
X-MC-Unique: 1l0GWO55N1e1UR2lZCemeQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78A30101AFA7;
        Wed, 29 Sep 2021 20:23:36 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B201419729;
        Wed, 29 Sep 2021 20:23:34 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] procfs: Do not list TID 0 in /proc/<pid>/task
Date:   Wed, 29 Sep 2021 22:23:32 +0200
Message-ID: <8735pn5dx7.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a task exits concurrently, task_pid_nr_ns may return 0.

Signed-off-by: Florian Weimer <fweimer@redhat.com>
---
 fs/proc/base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 533d5836eb9a..54f29399088f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3800,6 +3800,9 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
 		char name[10 + 1];
 		unsigned int len;
 		tid = task_pid_nr_ns(task, ns);
+		if (!tid)
+			/* The task has just exited. */
+			continue;
 		len = snprintf(name, sizeof(name), "%u", tid);
 		if (!proc_fill_cache(file, ctx, name, len,
 				proc_task_instantiate, task, NULL)) {
-- 
2.31.1

