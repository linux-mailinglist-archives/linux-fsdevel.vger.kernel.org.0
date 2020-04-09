Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0831A3C17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 23:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgDIVpj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 17:45:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41867 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgDIVpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:45:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id b8so133201pfp.8;
        Thu, 09 Apr 2020 14:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zps5dpYPJW545FaPYLeIjK5QW6MnaSH8AGIMhRszEiQ=;
        b=ZfTe0U5SQPDNlQ+zDNnRPiqCpHPAwhYzHmI/Op3uG9TWjENYlTgDRmTT7G7JjxTgWo
         zksDCIyf+6PFYxkmsHxeykJIeMRNaZahcwGWfANXKpDBlwPMBj9zqV3VG7mA9xnJU803
         COwS11xdibc0EG/w+br9sLxPIumbvcA6DOL5zmVURtmqJJifXXt5EWWQW8PCcfEHruN+
         nZCxRBsPH3kHe7G17piNVEDeU0FEqNBth8EKWBVuNsdWfRJ2vkKbcROXU/fAGg4QpQRX
         onksLvJNJWzND3JuGK3q9RWYBWV27ZWw7v9ufIz51t6Kw9UUsyNZ4byc7coqGPUsM0Jb
         MgIA==
X-Gm-Message-State: AGi0Puap0ZJWDAyZvMvPYCGe63IOII+KaJiVpWs9zAhi0dIeuAoOIJdH
        a8zd1D0JsmMgxivN3k7ezVc=
X-Google-Smtp-Source: APiQypKG6gQPVfMD+0afCeX7kVugM0CXqtzTx9olvPQK5ZLuzXpo7Y7xI9ctxu781oEvpMwFytQxKA==
X-Received: by 2002:a63:31c4:: with SMTP id x187mr1464572pgx.56.1586468737362;
        Thu, 09 Apr 2020 14:45:37 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id mn18sm124100pjb.13.2020.04.09.14.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 14:45:32 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5DA2941DAA; Thu,  9 Apr 2020 21:45:32 +0000 (UTC)
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
Subject: [RFC v2 4/5] mm/swapfile: refcount block and queue before using blkcg_schedule_throttle()
Date:   Thu,  9 Apr 2020 21:45:29 +0000
Message-Id: <20200409214530.2413-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200409214530.2413-1-mcgrof@kernel.org>
References: <20200409214530.2413-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

block device are refcounted so to ensure once its final user goes away it
can be cleaned up by the lower layers properly. The block device's
request_queue structure is also refcounted, however if the last
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
 mm/swapfile.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6659ab563448..5f6f3a61b5c0 100644
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
@@ -3771,8 +3772,18 @@ void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
 	plist_for_each_entry_safe(si, next, &swap_avail_heads[node],
 				  avail_lists[node]) {
 		if (si->bdev) {
+			bdev = bdgrab(si->bdev);
+			if (!bdev)
+				continue;
+			/*
+			 * By adding our own bdgrab() we ensure the queue
+			 * sticks around until disk_release(), and so we ensure
+			 * our release of the request_queue does not happen in
+			 * atomic context.
+			 */
 			blkcg_schedule_throttle(bdev_get_queue(si->bdev),
 						true);
+			bdput(bdev);
 			break;
 		}
 	}
-- 
2.25.1

