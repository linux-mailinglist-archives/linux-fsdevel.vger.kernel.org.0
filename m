Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3DBD1A3C1A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 23:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgDIVpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 17:45:36 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39805 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgDIVpf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:45:35 -0400
Received: by mail-pj1-f65.google.com with SMTP id z3so26341pjr.4;
        Thu, 09 Apr 2020 14:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eoDxljTp5vbr3aoHKkBfKXVECAcC7qfX/D5k3HZf/M0=;
        b=P1CySppNDyG4X/dJQjTjZVVcnrzipKQxDqaLUpx7gMZigXiTJSleZAEmUqaV14KU0+
         xyrSTUO3SW7RjVxd/flCjnrt++5fRlxmEh1ra2oni4C+T/bTItHjrxDSP/4sCqsh0Et6
         WyE1UwWp4kg+A1SDJfOpnWZ2PMzuwADHH4VaiqKI6cMB5y/XjfojEg4snVHXS371oRVO
         mB7P54CGtUOvlffE7Iz9n94N3XCfeYzJawWXTtYc00nzydEfS7DDUIBzu182doNmRMME
         6aPl5sPYEnQ7rAEGGwxWjilC/Ciob4N3HfnKhbc6SlZ6ZkZx36bxiKsARkmiQvPA+0Ze
         sVFQ==
X-Gm-Message-State: AGi0Pua+Abv9HUsXk43pU0iUUvSBj47sLsvut5vUCdyypEHUH7Bms78D
        O1uejfjQd6/wrt2Y0EIfn+w=
X-Google-Smtp-Source: APiQypJjM7OsXoNAVoK/beb/tphg54XlEChQn9RFbJNqZgnvlVR9rMP+bWm17T1MuhZd12Ok+Iemmg==
X-Received: by 2002:a17:902:ba86:: with SMTP id k6mr1675518pls.47.1586468735123;
        Thu, 09 Apr 2020 14:45:35 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u186sm42297pfu.205.2020.04.09.14.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 14:45:32 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4DC0C41D00; Thu,  9 Apr 2020 21:45:32 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [RFC v2 3/5] blktrace: ref count the request_queue during ioctl
Date:   Thu,  9 Apr 2020 21:45:28 +0000
Message-Id: <20200409214530.2413-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200409214530.2413-1-mcgrof@kernel.org>
References: <20200409214530.2413-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure that the reqest_queue ref counts the request_queue
during its full ioctl cycle. This avoids possible races against
removal, given blk_get_queue() also checks to ensure the queue
is not dying.

This small race is possible if you defer removal of the reqest_queue
and userspace fires off an ioctl for the device in the meantime.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: yu kuai <yukuai3@huawei.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/trace/blktrace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 15086227592f..17e144d15779 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -701,6 +701,9 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	if (!q)
 		return -ENXIO;
 
+	if (!blk_get_queue(q))
+		return -ENXIO;
+
 	mutex_lock(&q->blk_trace_mutex);
 
 	switch (cmd) {
@@ -729,6 +732,9 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	}
 
 	mutex_unlock(&q->blk_trace_mutex);
+
+	blk_put_queue(q);
+
 	return ret;
 }
 
-- 
2.25.1

