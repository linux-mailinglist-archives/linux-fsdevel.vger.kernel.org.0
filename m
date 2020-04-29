Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660721BD672
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 09:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgD2Hq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 03:46:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44106 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgD2Hqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:46:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so535768plr.11;
        Wed, 29 Apr 2020 00:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M3p9eZkDL4rEHA+mf+DziMPxePr/ZoUmDl5szec5+p8=;
        b=SQV9umeKoYqs/LvpvjbPzVTZmvd9T7nZE09+WXrOJK0A6uBYHfpYE8SQWR1s7iMQ5I
         Fcp2PPmm1n8Pi3SLVZ/SWMCT5rs+zYzbBF5C54gDtcBetoohMwVfCWmJ7vXwNnSWmFhS
         F2FQWta4t2wNEJKaVnr7loOcoHcAdGlb6sqJt3axmbihHo25r077K7iGAUNiFGyKYXgJ
         v6nnAXnBWxpd62nrBReZsLeHcdTnrFIFzgScDHpL0MRMh824SOETJZHJ4kUFIhIpjBGx
         wtgMISok+P0VkRjqYeCt1e2hXPphooxu32rWu25NvnG1XQ5MYnJOG5OVwp6Fv4/0xoBU
         /bFg==
X-Gm-Message-State: AGi0PuYc7/oRufAu6gOncbkr7r/KHpSdAZMZ5sddMROYtJ6S4Ks8Fgo2
        0evT8jXrZvJZYyB3Yncm9o8=
X-Google-Smtp-Source: APiQypIepM7UkpDZsnPZzlZJGdqb5bC+BXdvy5fR4OB7A7AnaI0/jrmsFgVoflR1BJYu333zB+xnmQ==
X-Received: by 2002:a17:90a:fa8d:: with SMTP id cu13mr1631966pjb.27.1588146394821;
        Wed, 29 Apr 2020 00:46:34 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r31sm387473pgl.86.2020.04.29.00.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:46:30 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E693841C23; Wed, 29 Apr 2020 07:46:29 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 3/6] blktrace: move blktrace debugfs creation to helper function
Date:   Wed, 29 Apr 2020 07:46:24 +0000
Message-Id: <20200429074627.5955-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200429074627.5955-1-mcgrof@kernel.org>
References: <20200429074627.5955-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the work to create the debugfs directory used into a helper.
It will make further checks easier to read. This commit introduces
no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/trace/blktrace.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ca39dc3230cb..2c6e6c386ace 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -468,6 +468,18 @@ static void blk_trace_setup_lba(struct blk_trace *bt,
 	}
 }
 
+static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
+					    struct blk_trace *bt)
+{
+	struct dentry *dir = NULL;
+
+	dir = debugfs_lookup(buts->name, blk_debugfs_root);
+	if (!dir)
+		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
+
+	return dir;
+}
+
 /*
  * Setup everything required to start tracing
  */
@@ -509,9 +521,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	ret = -ENOENT;
 
-	dir = debugfs_lookup(buts->name, blk_debugfs_root);
-	if (!dir)
-		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
+	dir = blk_trace_debugfs_dir(buts, bt);
 
 	bt->dev = dev;
 	atomic_set(&bt->dropped, 0);
-- 
2.25.1

