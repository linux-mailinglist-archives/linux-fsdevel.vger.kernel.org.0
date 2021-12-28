Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0524480BE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Dec 2021 18:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbhL1RKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Dec 2021 12:10:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236637AbhL1RKH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640711405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zcyx31DoFdfPdC5vlZBLQMcpObsl0QbQgiHxbQ2ymUE=;
        b=U8LxtFjCAOKgoo9CCCaTc1WD8CVB0zKfApa8cyyXC6mrfOxuFRdKjoL55/TEE8+wB7od33
        iFYVC5L/AwxtWs8eqO5TsDsPeVdcKemBUeb6b0Qhb4QDxdnqdpVopwbh/u5fdUJSVuq8or
        lAFSZIVdGt4P158gWFQFpSFcM4gxbDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-bXRy1wkWMIqgm9lBuGByyQ-1; Tue, 28 Dec 2021 12:10:01 -0500
X-MC-Unique: bXRy1wkWMIqgm9lBuGByyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16CC2102CB2A;
        Tue, 28 Dec 2021 17:09:58 +0000 (UTC)
Received: from wcosta.com (ovpn-116-95.gru2.redhat.com [10.97.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D689377449;
        Tue, 28 Dec 2021 17:09:32 +0000 (UTC)
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
        Laurent Vivier <laurent@vivier.eu>,
        Wander Lairson Costa <wander@redhat.com>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Gladkov <legion@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Rolf Eike Beer <eb@emlix.com>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC v2 0/4] coredump: mitigate privilege escalation of process coredump
Date:   Tue, 28 Dec 2021 14:09:04 -0300
Message-Id: <20211228170910.623156-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v2
==

Patch 02 conflicted with commit 92307383082d("coredump:  Don't perform
any cleanups before dumping core") which I didn't have in my tree. V2
just changes the hunk

+#define PF_SUID   0x00000008

To

+#define PF_SUID   0x01000000

To merge cleanly. Other than that, it is the same patch as v1.

v1
==

A set-uid executable might be a vector to privilege escalation if the
system configures the coredump file name pattern as a relative
directory destiny. The full description of the vulnerability and
a demonstration of how we can exploit it can be found at [1].

This patch series adds a PF_SUID flag to the process in execve if it is
set-[ug]id binary and elevates the new image's privileges.

In the do_coredump function, we check if:

1) We have the SUID_FLAG set
2) We have CAP_SYS_ADMIN (the process might have decreased its
   privileges)
3) The current directory is owned by root (the current code already
   checks for core_pattern being a relative path).
4) non-privileged users don't have permission to write to the current
   directory.

If all four conditions match, we set the need_suid_safe flag.

An alternative implementation (and more elegant IMO) would be saving
the fsuid and fsgid of the process in the task_struct before loading the
new image to the memory. But this approach would add eight bytes to all
task_struct instances where only a tiny fraction of the processes need
it and under a configuration that not all (most?) distributions don't
adopt by default.

Wander Lairson Costa (4):
  exec: add a flag indicating if an exec file is a suid/sgid
  process: add the PF_SUID flag
  coredump: mitigate privilege escalation of process coredump
  exec: only set the suid flag if the current proc isn't root

 fs/coredump.c           | 15 +++++++++++++++
 fs/exec.c               | 10 ++++++++++
 include/linux/binfmts.h |  6 +++++-
 include/linux/sched.h   |  1 +
 kernel/fork.c           |  2 ++
 5 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.27.0

