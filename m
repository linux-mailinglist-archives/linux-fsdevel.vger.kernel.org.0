Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822391A7273
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 06:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405261AbgDNETZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 00:19:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39409 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405233AbgDNETK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 00:19:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id g32so5456017pgb.6;
        Mon, 13 Apr 2020 21:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7GCMwZ+500s2UeOg6j11+a/fStJc20VLvn3M0bWMqk=;
        b=EkynL942Np0ynFvupyxP8+dtig/dz107SvF2dke+wp8Eys1WQF9p0GpIEJ5KqgyOGS
         FwWfIywhE7yPHcJShqHpl/CXX+gz4GThF3vh69hKPxG2KaFHNYJfa7hy0L8OdcnLYuFX
         Jr40/vrMWP/RJ07ucVIB4FgSoS4JsZjsrtwOw4rqi/JtGsyFxZ0ky4zemwwHvX3WCVAu
         oKAjsRbcHVOB00cl9ZRBIWQa71Ga2EE/sdkZSEFYpOw0fEEYKgF2/TDuWiiaHmu4LW1N
         gxONSH1PcIhxWsxcu+Da0X6edcnuR85mZbbT8rEFJwh17eCblZr96fdKM7i/FX85NNCq
         DPkQ==
X-Gm-Message-State: AGi0Publ4IUI+3MUXeeDh17nqT8rAUyFwwiEu0C4fpzLTjHKEhr8zcnA
        rVdvUaOb6HWsDqfS1pTaQKs=
X-Google-Smtp-Source: APiQypIhm3o5ig0Vl42dVHSMw8R//BDfhQcbCw+CHlsRTU54HdyPnw18cejKvzwRFkPw0xmS9mvYAQ==
X-Received: by 2002:aa7:9207:: with SMTP id 7mr20846200pfo.178.1586837949770;
        Mon, 13 Apr 2020 21:19:09 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a1sm9983484pfl.188.2020.04.13.21.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 21:19:06 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1DA65419AC; Tue, 14 Apr 2020 04:19:04 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 4/5] mm/swapfile: refcount block and queue before using blkcg_schedule_throttle()
Date:   Tue, 14 Apr 2020 04:19:01 +0000
Message-Id: <20200414041902.16769-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200414041902.16769-1-mcgrof@kernel.org>
References: <20200414041902.16769-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

block devices are refcounted so to ensure once its final user goes away it
can be cleaned up by the lower layers properly. The block device's
request_queue structure is also refcounted, however, if the last
blk_put_queue() is called under atomic context the block layer has
to defer removal.

By refcounting the block device during the use of blkcg_schedule_throttle(),
we ensure ensure two things:

1) the block device remains available during the call
2) we ensure avoid having to deal with the fact we're using the
   request_queue structure in atomic context, since the last
   blk_put_queue() will be called upon disk_release(), *after*
   our own bdput().

This means this code path is *not* going to remove the request_queue
structure, as we are ensuring some later upper layer disk_release()
will be the one to release the request_queue structure for us.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: yu kuai <yukuai3@huawei.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/swapfile.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6659ab563448..9285ff6030ca 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3753,6 +3753,7 @@ static void free_swap_count_continuations(struct swap_info_struct *si)
 void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
 				  gfp_t gfp_mask)
 {
+	struct block_device *bdev;
 	struct swap_info_struct *si, *next;
 	if (!(gfp_mask & __GFP_IO) || !memcg)
 		return;
@@ -3771,8 +3772,17 @@ void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
 	plist_for_each_entry_safe(si, next, &swap_avail_heads[node],
 				  avail_lists[node]) {
 		if (si->bdev) {
-			blkcg_schedule_throttle(bdev_get_queue(si->bdev),
-						true);
+			bdev = bdgrab(si->bdev);
+			if (!bdev)
+				continue;
+			/*
+			 * By adding our own bdgrab() we ensure the queue
+			 * sticks around until disk_release(), and so we ensure
+			 * our release of the request_queue does not happen in
+			 * atomic context.
+			 */
+			blkcg_schedule_throttle(bdev_get_queue(bdev), true);
+			bdput(bdev);
 			break;
 		}
 	}
-- 
2.25.1

