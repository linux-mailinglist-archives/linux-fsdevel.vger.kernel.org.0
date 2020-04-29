Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CE91BD664
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 09:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgD2Hqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 03:46:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46917 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgD2Hqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:46:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id n24so532531plp.13;
        Wed, 29 Apr 2020 00:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lbuhBnmZzFbDhZxSJ1ni5AOA61z3VyXXGZL4QHqGGx0=;
        b=l6IvqM4q3E67p5USk5cFJW9FjX3zde8syyVjf12bVFyrikESDFS4ZTQ5fCpZ5kPrHb
         RbZwG/nIb5SNNZlGrgSr4l5fiImSy8ndVVnINrRhRms8GKTRHU0qs3ceQ7G+HSHBYuhV
         Hn8sJaRpW/0BLF+sXXyppZp41D041/M3PBYYINHKuFuocsG++cfR69bcAkOW4Vvdf/K4
         3CJfAS0T6dWxG3suJuefkdV4sHPI95g/TCb9q+v2iwRhYkJzdkQAEza7v8TcIKzyz7ok
         c+DJOiqzWQhDiTq/ca1uL4u+cbnEjopSKakJn0FYVvmV8ZNm5ANuHZXEZYi8Yr82J3iw
         PnBg==
X-Gm-Message-State: AGi0PuZk9vBVDnxzjosftK0R17ajExxCBau+MctVeDVB0n8EFLiUkm+a
        9tlS1aQKwYJ2k8S54qqurlk=
X-Google-Smtp-Source: APiQypKrREry4NDgPPBJilLfXP5Wql3EjomxOYfYxqGwUMX/NYY+ZmpZXVnkCpQ7jDJW/k/bn9/ubQ==
X-Received: by 2002:a17:90a:e382:: with SMTP id b2mr1640417pjz.110.1588146396679;
        Wed, 29 Apr 2020 00:46:36 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r31sm387543pgl.86.2020.04.29.00.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:46:35 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1548241DCA; Wed, 29 Apr 2020 07:46:30 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 5/6] blktrace: break out of blktrace setup on concurrent calls
Date:   Wed, 29 Apr 2020 07:46:26 +0000
Message-Id: <20200429074627.5955-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200429074627.5955-1-mcgrof@kernel.org>
References: <20200429074627.5955-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We use one blktrace per request_queue, that means one per the entire
disk.  So we cannot run one blktrace on say /dev/vda and then /dev/vda1,
or just two calls on /dev/vda.

We check for concurrent setup only at the very end of the blktrace setup though.

If we try to run two concurrent blktraces on the same block device the
second one will fail, and the first one seems to go on. However when
one tries to kill the first one one will see things like this:

The kernel will show these:

```
debugfs: File 'dropped' in directory 'nvme1n1' already present!
debugfs: File 'msg' in directory 'nvme1n1' already present!
debugfs: File 'trace0' in directory 'nvme1n1' already present!
``

And userspace just sees this error message for the second call:

```
blktrace /dev/nvme1n1
BLKTRACESETUP(2) /dev/nvme1n1 failed: 5/Input/output error
```

The first userspace process #1 will also claim that the files
were taken underneath their nose as well. The files are taken
away form the first process given that when the second blktrace
fails, it will follow up with a BLKTRACESTOP and BLKTRACETEARDOWN.
This means that even if go-happy process #1 is waiting for blktrace
data, we *have* been asked to take teardown the blktrace.

This can easily be reproduced with break-blktrace [0] run_0005.sh test.

Just break out early if we know we're already going to fail, this will
prevent trying to create the files all over again, which we know still
exist.

[0] https://github.com/mcgrof/break-blktrace
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/trace/blktrace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 5c52976bd762..383045f67cb8 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -4,6 +4,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
 #include <linux/blktrace_api.h>
@@ -516,6 +518,11 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	 */
 	strreplace(buts->name, '/', '_');
 
+	if (q->blk_trace) {
+		pr_warn("Concurrent blktraces are not allowed\n");
+		return -EBUSY;
+	}
+
 	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
 	if (!bt)
 		return -ENOMEM;
-- 
2.25.1

