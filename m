Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8D5371FE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 21:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391702AbfGWTEm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 15:04:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43353 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbfGWTEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 15:04:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so19863401pgv.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2019 12:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iX2rdum8LwS0b+uhjozcZFGbYT8krqFFlh+UkKmMIgQ=;
        b=efKs1W8UckyexrvbFaX1JVWquDQAPbnXf/uV6DA/2BeX7Sq1FLUVmAIsm9FHX1Cs5n
         TAyM32QYxzLcWNgCnSAZ5VyuJekiCCSBWpzpyfwqq0bL6dHay0ud6YtB/9dkNbEY0Ua2
         wHzWXgxYXBdRfbSQr4znDfnX8VifzQgMK4YE+UhYSliRgNsmeV6S20yvFiMUaTGctRS1
         u4LWrgauSDB8KeFRRR6V0WU8oMA5rtXxd+04yUifdRITayoCQu94fv+0LKJcOQ/PKV6x
         WWMD2T3RJCVuvzTE/F58mSllGUJ/vN3I9YGGgQUodn9Oq18qDjE8y/8qgI8uTrqBfdm4
         MmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iX2rdum8LwS0b+uhjozcZFGbYT8krqFFlh+UkKmMIgQ=;
        b=CFCorx03MisM0WM/T7+asti/ZNGCVW2jDWNtYEK/5j0HtaX/oHDouYBlOzkKqLnDeB
         3KiqRGU2AGVZqgpZebwlMCQQbneMEt3bmKFrwREcbX0rtj5Bd3xJji1WEBG/M/6gfADl
         0zLFIuqkbKfgRam+sbqqX8024pyQt84bscaMBAkcKTcYiZsxALfQGP+/Opdrk5JvCXwo
         VbofieqU1K5qXb5szFOa17JhXEzX9mhur06Ga0pF8zKhuIRx/WkgYd/KU+xGvKJQT2SY
         3zo1aOE8GE56iRb43A7TQ3YhMVA2qx6imAGrtSSdkwm34m+m5btPrwNuB/V4ILK+63yo
         uCeA==
X-Gm-Message-State: APjAAAVkh4PisDqDcm5OqF1WXnnr/qok4QOWSgy7bNABR/O8RRDGzYVZ
        X7ySkYjGVzHsmDTA5F3FjF8=
X-Google-Smtp-Source: APXvYqxKieWmko2TRxQnmNvA4D7SHmkxX9uOaU1GAx9OGn5S18fj4nXY5cRSKlu4xGUuC4LMy0Mh8A==
X-Received: by 2002:a63:c03:: with SMTP id b3mr13433296pgl.23.1563908681249;
        Tue, 23 Jul 2019 12:04:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:a7f8])
        by smtp.gmail.com with ESMTPSA id r2sm59085807pfl.67.2019.07.23.12.04.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 12:04:40 -0700 (PDT)
Date:   Tue, 23 Jul 2019 15:04:38 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] psi: annotate refault stalls from IO submission
Message-ID: <20190723190438.GA22541@cmpxchg.org>
References: <20190722201337.19180-1-hannes@cmpxchg.org>
 <20190723000226.GV7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723000226.GV7777@dread.disaster.area>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CCing Jens for bio layer stuff

On Tue, Jul 23, 2019 at 10:02:26AM +1000, Dave Chinner wrote:
> Even better: If this memstall and "refault" check is needed to
> account for bio submission blocking, then page cache iteration is
> the wrong place to be doing this check. It should be done entirely
> in the bio code when adding pages to the bio because we'll only ever
> be doing page cache read IO on page cache misses. i.e. this isn't
> dependent on adding a new page to the LRU or not - if we add a new
> page then we are going to be doing IO and so this does not require
> magic pixie dust at the page cache iteration level

That could work. I had it at the page cache level because that's
logically where the refault occurs. But PG_workingset encodes
everything we need from the page cache layer and is available where
the actual stall occurs, so we should be able to push it down.

> e.g. bio_add_page_memstall() can do the working set check and then
> set a flag on the bio to say it contains a memstall page. Then on
> submission of the bio the memstall condition can be cleared.

A separate bio_add_page_memstall() would have all the problems you
pointed out with the original patch: it's magic, people will get it
wrong, and it'll be hard to verify and notice regressions.

How about just doing it in __bio_add_page()? PG_workingset is not
overloaded - when we see it set, we can generally and unconditionally
flag the bio as containing userspace workingset pages.

At submission time, in conjunction with the IO direction, we can
clearly tell whether we are reloading userspace workingset data,
i.e. stalling on memory.

This?

---
From 033e0c4789ef4ceefb2d8038b4e162dfb434d03d Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 11 Jul 2019 16:01:40 -0400
Subject: [PATCH] psi: annotate refault stalls from IO submission

psi tracks the time tasks wait for refaulting pages to become
uptodate, but it does not track the time spent submitting the IO. The
submission part can be significant if backing storage is contended or
when cgroup throttling (io.latency) is in effect - a lot of time is
spent in submit_bio(). In that case, we underreport memory pressure.

Annotate submit_bio() to account submission time as memory stall when
the bio is reading userspace workingset pages.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 block/bio.c               |  3 +++
 block/blk-core.c          | 23 ++++++++++++++++++++++-
 include/linux/blk_types.h |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 29cd6cf4da51..6156cb1b9c2c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -805,6 +805,9 @@ void __bio_add_page(struct bio *bio, struct page *page,
 
 	bio->bi_iter.bi_size += len;
 	bio->bi_vcnt++;
+
+	if (PageWorkingset(page))
+		bio_set_flag(bio, BIO_WORKINGSET);
 }
 EXPORT_SYMBOL_GPL(__bio_add_page);
 
diff --git a/block/blk-core.c b/block/blk-core.c
index 5d1fc8e17dd1..5993922d63fb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -36,6 +36,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/debugfs.h>
 #include <linux/bpf.h>
+#include <linux/psi.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -1127,6 +1128,10 @@ EXPORT_SYMBOL_GPL(direct_make_request);
  */
 blk_qc_t submit_bio(struct bio *bio)
 {
+	bool workingset_read = false;
+	unsigned long pflags;
+	blk_qc_t ret;
+
 	/*
 	 * If it's a regular read/write or a barrier with data attached,
 	 * go through the normal accounting stuff before submission.
@@ -1142,6 +1147,8 @@ blk_qc_t submit_bio(struct bio *bio)
 		if (op_is_write(bio_op(bio))) {
 			count_vm_events(PGPGOUT, count);
 		} else {
+			if (bio_flagged(bio, BIO_WORKINGSET))
+				workingset_read = true;
 			task_io_account_read(bio->bi_iter.bi_size);
 			count_vm_events(PGPGIN, count);
 		}
@@ -1156,7 +1163,21 @@ blk_qc_t submit_bio(struct bio *bio)
 		}
 	}
 
-	return generic_make_request(bio);
+	/*
+	 * If we're reading data that is part of the userspace
+	 * workingset, count submission time as memory stall. When the
+	 * device is congested, or the submitting cgroup IO-throttled,
+	 * submission can be a significant part of overall IO time.
+	 */
+	if (workingset_read)
+		psi_memstall_enter(&pflags);
+
+	ret = generic_make_request(bio);
+
+	if (workingset_read)
+		psi_memstall_leave(&pflags);
+
+	return ret;
 }
 EXPORT_SYMBOL(submit_bio);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 6a53799c3fe2..2f77e3446760 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -209,6 +209,7 @@ enum {
 	BIO_BOUNCED,		/* bio is a bounce bio */
 	BIO_USER_MAPPED,	/* contains user pages */
 	BIO_NULL_MAPPED,	/* contains invalid user pages */
+	BIO_WORKINGSET,		/* contains userspace workingset pages */
 	BIO_QUIET,		/* Make BIO Quiet */
 	BIO_CHAIN,		/* chained bio, ->bi_remaining in effect */
 	BIO_REFFED,		/* bio has elevated ->bi_cnt */
-- 
2.22.0

