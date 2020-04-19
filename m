Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0701D1AFDBD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 21:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgDSTqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 15:46:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43539 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgDSTpq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:45:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id x26so3958754pgc.10;
        Sun, 19 Apr 2020 12:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2K7EZXYN6Xe1jPwFmqZWg/LsfDQ8FxEGzorYIUkLfM=;
        b=gZSXBx4e+IW+hhj5NGIM5wStvfIBMt58IrDpPpdDDO6ujIjmP5OlcSyiGA+RJvgAlR
         u4J3TAXJ49XmMpQHPBl/RHqLvoeymtWQ33ogEe0xJLe1ADQOmYV45Z4DepAamC/qPkdY
         nVlqSB27JHgnFMxA5pjxAf99ruzt8RPDW5oyJgd0kWtyJsBKJWB8OiiN+39Vza2TDEHK
         7RW3vI0k2tSLINvNoe3fpi3jteT1qnjF4qWyu6DMWUAH0m+zqQjv+2zdSDnZVr01Ulvx
         +L5csmaYI6JY/KonTUpujfYmR8QJyPY/W1sC2bGksPD27MCi4Q/t2LXPXir8W6hFjfmr
         jEpg==
X-Gm-Message-State: AGi0Pub7nChwkSk7y8heGnlCil78S9dy45MHhN5Caqp4/Ha2ArHZ+kwX
        DwebKWbOxVR92/dxm40DqpiejYqv0CQ=
X-Google-Smtp-Source: APiQypIMWS/ShJP5LZ41kIXm9G1F2gs0Kheeswgp6JGQgly3HmDS9WmGOoUUTQl9T2/u5sowlGqZhg==
X-Received: by 2002:a63:7c2:: with SMTP id 185mr2478993pgh.131.1587325545506;
        Sun, 19 Apr 2020 12:45:45 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a23sm19365100pfo.145.2020.04.19.12.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:45:43 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E685642000; Sun, 19 Apr 2020 19:45:38 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 06/10] blk-debugfs: upgrade warns to BUG_ON() if directory is already found
Date:   Sun, 19 Apr 2020 19:45:25 +0000
Message-Id: <20200419194529.4872-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200419194529.4872-1-mcgrof@kernel.org>
References: <20200419194529.4872-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we have moved release_queue from being asynchronous to
synchronous, and fixed how we use the debugfs directory with blktrace
we should no longer have expected races with device removal/addition
and other operations with the debugfs directory.

If races do happen however, we want to be informed of *how* this races
happens rather than dealing with a debugfs splat, so upgrading this to a
BUG_ON() should capture better information about how this can happen
in the future.

This is specially true these days with funky reproducers in userspace
for which we have no access to, but only a bug splat.

Note that on addition the gendisk kobject is used as the parent for the
request_queue kobject, and upon removal, now that request_queue removal
is synchronous, blk_unregister_queue() is called prior to the gendisk
device_del(). This means we expect to see a sysfs clash first now prior
to running into a race with the debugfs dentry; so this bug would be
considered highly unlikely.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-debugfs.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
index d84038bce0a5..761318dcbf40 100644
--- a/block/blk-debugfs.c
+++ b/block/blk-debugfs.c
@@ -19,16 +19,8 @@ void blk_debugfs_register(void)
 
 int __must_check blk_queue_debugfs_register(struct request_queue *q)
 {
-	struct dentry *dir = NULL;
-
 	/* This can happen if we have a bug in the lower layers */
-	dir = debugfs_lookup(kobject_name(q->kobj.parent), blk_debugfs_root);
-	if (dir) {
-		pr_warn("%s: registering request_queue debugfs directory twice is not allowed\n",
-			kobject_name(q->kobj.parent));
-		dput(dir);
-		return -EALREADY;
-	}
+	BUG_ON(debugfs_lookup(kobject_name(q->kobj.parent), blk_debugfs_root));
 
 	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
 					    blk_debugfs_root);
-- 
2.25.1

