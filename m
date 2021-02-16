Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFC231D21D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 22:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhBPVbT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 16:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhBPVbP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 16:31:15 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F29C061574;
        Tue, 16 Feb 2021 13:30:34 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w18so7003590pfu.9;
        Tue, 16 Feb 2021 13:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xUh3CEqdSSKuvizlFupLbkEBddVx3zr4k3RSY54OT4Y=;
        b=NM1DIdK0kYbseTKMsjWst8byp45H5S9NfZds6OsuvdvCJs8jkSAtc7kZyhNY4qjswM
         Fujh9R8op0lc9Buq9wmf9WaxojtlROwchTm4a9ebQDkw/vCFH4ZHcv/pfzFVMvZ1gVnk
         x4hUT8hxdD7cEJm32J6y3RG3+BjXW8sbCIHxwjN4uetqd4JqaKXKZiCRjc2+OwabbXJr
         sjFu2nfqN1QkBKfieVUmDX+biIHLxIVpO7F27u8ul2SsoVJBheDnZlKe7dT4PggsiaDb
         YmIUAAbt32mlp11R2j8dcx77StDtr4xbHkAIIti9oXxkYRDqxqi8tQd4ol4wiStmUAdT
         uFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xUh3CEqdSSKuvizlFupLbkEBddVx3zr4k3RSY54OT4Y=;
        b=hcDbj5Lqcdsjw0kIY65qtbW7jTAQcwbV8DNuPrHn4ZcefPSIJPZ3l18E/Idvv3GidW
         NrvGFBgiE2BrntZDIMhwxeBq6bXup1VLEVSP23nspp49aKHEWsj+Y/FoczUV5+W3Qq9C
         r/Sr58UAy+0FYDg7kI3nfjP7zKweaJr4WTeInJQuPU/GvTXIEFOJn8PBaghHSntzL4yi
         pv7AKNgCVX94gJEq3CHx9sw5aW07/nSfCAtS0FMcIYfvBrt5lOlKBPw9ybOv4PR/PC/I
         CsBni+oedXm5ujkK0f6/HaQgw53OVCTG1hZ8MwN1241aYSaKdmKwWXdIWnLKQ4+GBIhH
         T/Cw==
X-Gm-Message-State: AOAM532r/XZE8lft9z6G0JBriAgvH35Z5ZUoBkIh06LLXBm2dgmMIbbo
        eK8kOzUY6Cm+FfyI+ckSbqQ=
X-Google-Smtp-Source: ABdhPJwsn7pEQ8cmgx84W2wsuWyc794tUwXJok/ipmRpvvIjkHYT/WYi9aZXLNpkV+3bK9pFspCtvA==
X-Received: by 2002:a62:14d4:0:b029:1e3:34e7:5797 with SMTP id 203-20020a6214d40000b02901e334e75797mr21993866pfu.43.1613511034569;
        Tue, 16 Feb 2021 13:30:34 -0800 (PST)
Received: from google.com ([2620:15c:211:201:cdf7:1c5d:c444:e341])
        by smtp.gmail.com with ESMTPSA id i67sm23417148pfe.19.2021.02.16.13.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 13:30:33 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 16 Feb 2021 13:30:31 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgoldswo@codeaurora.org,
        linux-fsdevel@vger.kernel.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, joaodias@google.com
Subject: Re: [RFC 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YCw5d2BTsFgq/mZa@google.com>
References: <20210216170348.1513483-1-minchan@kernel.org>
 <20210216182242.GJ2858050@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216182242.GJ2858050@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 06:22:42PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 16, 2021 at 09:03:47AM -0800, Minchan Kim wrote:
> > LRU pagevec holds refcount of pages until the pagevec are drained.
> > It could prevent migration since the refcount of the page is greater
> > than the expection in migration logic. To mitigate the issue,
> > callers of migrate_pages drains LRU pagevec via migrate_prep or
> > lru_add_drain_all before migrate_pages call.
> > 
> > However, it's not enough because pages coming into pagevec after the
> > draining call still could stay at the pagevec so it could keep
> > preventing page migration. Since some callers of migrate_pages have
> > retrial logic with LRU draining, the page would migrate at next trail
> > but it is still fragile in that it doesn't close the fundamental race
> > between upcoming LRU pages into pagvec and migration so the migration
> > failure could cause contiguous memory allocation failure in the end.
> 
> Have you been able to gather any numbers on this?  eg does migration
> now succeed 5% more often?

What I measured was how many times migrate_pages retried with force mode
below debug code.
The test was android apps launching with cma allocation in background.
Total cma allocation count was about 500 during the entire testing 
and have seen about 400 retrial with below debug code.
With this patchset(with bug fix), the retrial count was reduced under 30.

What I measured was how many times the migrate_pages 
diff --git a/mm/migrate.c b/mm/migrate.c
index 04a98bb2f568..caa661be2d16 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1459,6 +1459,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
                                                private, page, pass > 2, mode,
                                                reason);

+                       if (rc && reason == MR_CONTIG_RANGE && pass > 2) {
+                               printk(KERN_ERR, "pfn 0x%lx reason %d\n", page_to_pfn(page), rc);
+                               dump_page(page, "fail to migrate");
+                       }
+

