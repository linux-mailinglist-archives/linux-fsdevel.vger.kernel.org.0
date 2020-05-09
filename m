Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F831CBCCD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 05:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgEIDLG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 23:11:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42350 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgEIDLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 23:11:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id f7so1983634pfa.9;
        Fri, 08 May 2020 20:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cEK33y5M3evHk3zepZBRBq1zuAEKJAta0bGSZcp5I7U=;
        b=P2MMSNtH09kHBsfo9hEs/+6n8k/UR8fx/+4he9p+vl1kfCZOEQAghgyjGgkzYXH+5E
         HElIJqtCpOuwB61c+GewMyswsUFwBAUCtvv5Aeq+Oz6BZinoYc1IQcmud5RQsOfZ+VT7
         EN7uQBp2EhLxzB2Cpb3LZmVVRwHrSA7QfSPvmuxJoghJr8+SD/0WIzofgJTVPglH7KTa
         5oeeDsNQThlLijuu0ezNJ3diYzlH4cukZRKISP69yFbAdk3uNSaNFwe1uP0jprTujjNr
         D1BQkJDrMBQVrwc+qF3Tj8ZkbYhW80W8Icowji4ftAnPnruuXyyo588NGDc3lBbZBpXE
         x9Lw==
X-Gm-Message-State: AGi0PuY/uTbcihKn7NwY6cssG08fbE/DLCrrJjV2rnf/PtM62hR3JWOF
        xQnQ/CvJjICz3Qh5J89PWQc=
X-Google-Smtp-Source: APiQypLJMN/211bTPotanM4jUsK4k4pu+kicwA68ZAITFqqfkEyvZgoqNiyBViyjSN8+owsWBeCmNA==
X-Received: by 2002:a62:6545:: with SMTP id z66mr5765485pfb.87.1588993863018;
        Fri, 08 May 2020 20:11:03 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id k186sm2518635pga.94.2020.05.08.20.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 20:11:00 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0657241D67; Sat,  9 May 2020 03:11:00 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v4 4/5] blktrace: break out of blktrace setup on concurrent calls
Date:   Sat,  9 May 2020 03:10:57 +0000
Message-Id: <20200509031058.8239-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200509031058.8239-1-mcgrof@kernel.org>
References: <20200509031058.8239-1-mcgrof@kernel.org>
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
 kernel/trace/blktrace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 6c10a1427de2..bd5ec2184d46 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -3,6 +3,9 @@
  * Copyright (C) 2006 Jens Axboe <axboe@kernel.dk>
  *
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
 #include <linux/blktrace_api.h>
@@ -493,6 +496,12 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	 */
 	strreplace(buts->name, '/', '_');
 
+	if (q->blk_trace) {
+		pr_warn("Concurrent blktraces are not allowed on %s\n",
+			buts->name);
+		return -EBUSY;
+	}
+
 	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
 	if (!bt)
 		return -ENOMEM;
-- 
2.25.1

