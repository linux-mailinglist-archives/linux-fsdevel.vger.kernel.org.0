Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE87126DC01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 14:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgIQMtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 08:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgIQMts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:49:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886F4C06174A;
        Thu, 17 Sep 2020 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SMn65b1Ip8Ki5T6DVuzVOZrtWMuF5zN5A9x9ed/EeiM=; b=DwWnLbTRETJm4THXgzUPgbIB8/
        SC1nOfGV2bZdTxx+07wbcuWc8lb9XWM5j9y335xTIHsHypuOD7qzOsHC4odGHFOcCSYcH+AmL/Gq1
        iblgnQWzT40BL1wzR758SRxNkHWAkom/+X+guJ+XE4+SRxL7Pwv+H6MLIf3MOqvP37LDcleJZ30gR
        SRHgSRXwpI2i53nFf67X4a0DdM7mMQrb8hP0qEYBz07UHcBjUP8Z7inoike2zBOMKs7EosLgAr3bx
        hHq3yw/cC+Rq27i5N9EwjmHWmgeVYxfdfVIuGj7soXOcmrBO4YOExyPqSVxL+Efg5o3vYJa+Ug+u6
        BB1qTPIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kItL4-0000g3-MY; Thu, 17 Sep 2020 12:48:39 +0000
Date:   Thu, 17 Sep 2020 13:48:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Boaz Harrosh <boaz@plexistor.com>, Hou Tao <houtao1@huawei.com>,
        peterz@infradead.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200917124838.GT5449@casper.infradead.org>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
 <20200917120132.GA5602@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917120132.GA5602@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 02:01:33PM +0200, Oleg Nesterov wrote:
> IIUC, file_end_write() was never IRQ safe (at least if !CONFIG_SMP), even
> before 8129ed2964 ("change sb_writers to use percpu_rw_semaphore"), but this
> doesn't matter...
> 
> Perhaps we can change aio.c, io_uring.c and fs/overlayfs/file.c to avoid
> file_end_write() in IRQ context, but I am not sure it's worth the trouble.

If we change bio_endio to invoke the ->bi_end_io callbacks in softirq
context instead of hardirq context, we can change the pagecache to take
BH-safe locks instead of IRQ-safe locks.  I believe the only reason the
lock needs to be IRQ-safe is for the benefit of paths like:

mpage_end_io
page_endio
end_page_writeback
test_clear_page_writeback

Admittedly, I haven't audited all the places that call end_page_writeback;
there might be others called from non-BIO contexts (network filesystems?).
That was the point where I gave up my investigation of why we use an
IRQ-safe spinlock when basically all page cache operations are done
from user context.
