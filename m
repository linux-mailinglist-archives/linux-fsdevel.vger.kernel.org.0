Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CC91D5E33
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 May 2020 05:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgEPDUY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 23:20:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43214 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgEPDUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 23:20:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id v63so1921053pfb.10;
        Fri, 15 May 2020 20:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vwSG5ItKx2r5dbDOPcw9Nyt7jOYmxP5wgs6FTcAWgW0=;
        b=N4wlRF8X2a+WSScdS073qLAmZNTdK5aqHvvkYF75cO8DW8xslivIFMLFG60Qyrs23J
         qVGRrpZMhmpEpqL5+A1dE1yohricljlPwAOXjENBvjbSznV7Fg2h30NTOMGjq/VUjFUB
         2c2HWS7Hngs4lpyMa1ocQ/Ztkdt+idgRAgf92TijAXWAS1Bskvnza2vSHN3TARp/d9d3
         SCFTZ5Zxls/okAKBVxfZIjmNCil4dpi96G/Rio6sTiH0BciJXFWqpQji9rEm1B4VsXok
         i5AEv/yp071yao8mQbIbQ6X0uYItpsMb+ISAkyx3Bmdx1appkHkxnKYKbAoEbHqgNRSy
         2dsQ==
X-Gm-Message-State: AOAM533f0BzafIUizszWJLbMUD+wgbWwhTFYml78vMGCHrCwVI2J2NsQ
        x4VupU1ibd2b8vPdsrqDFopMWv9lOI6iFw==
X-Google-Smtp-Source: ABdhPJwU3+TI8g+EyIeQPhXO+/cx+sT8afNbB1U4k6Kb4bGm6M4IeutMRhzShn9t7OeCKVjIaOL/UA==
X-Received: by 2002:a63:da10:: with SMTP id c16mr2649800pgh.208.1589599206435;
        Fri, 15 May 2020 20:20:06 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id z18sm3070391pfj.148.2020.05.15.20.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 20:20:04 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BBBAC422E5; Sat, 16 May 2020 03:19:59 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v5 6/7] blktrace: break out of blktrace setup on concurrent calls
Date:   Sat, 16 May 2020 03:19:55 +0000
Message-Id: <20200516031956.2605-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200516031956.2605-1-mcgrof@kernel.org>
References: <20200516031956.2605-1-mcgrof@kernel.org>
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
 kernel/trace/blktrace.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 6c10a1427de2..ac6650828d49 100644
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
@@ -493,6 +496,16 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	 */
 	strreplace(buts->name, '/', '_');
 
+	/*
+	 * bdev can be NULL, as with scsi-generic, this is a helpful as
+	 * we can be.
+	 */
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
2.26.2

