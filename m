Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A6B26DCEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 15:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgIQNey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 09:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgIQNeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:34:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE17C061756;
        Thu, 17 Sep 2020 06:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+x95TOveSKANVP/4NXP/85j+F/QDHBxfUXKmd3k4IkY=; b=KQDtXc5QckJn09Jm/Ja39DH+Uk
        xxcqqwltSK9fZ6w7Kd6V1hBp9ikMoXg8gbomb9s7kP2XHhd7lM0naQBMg6RjjPyGlTBnZ9CqAewZP
        YBMrkVSsWNv4P//FrPhdNdQmWpCFvyupNp/qno+NoxUvgiSbQKqfKolCuygblFt8iWbThqohs3hWl
        poBHmOUUGUHFooTp12KKoDbiSxegWSjxaxIUxEoacl+BH7Gz+8C5zwbDPN/4KqU33J4uCDwI1dPIK
        kM4wXFBSnpaxgF4lCFnvHE/xHjx2qEpyzqLl/r7jiVavDy6uIXbji7LU4O0hBDMsY2X8tCbWi4E1Q
        q9GbsMrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kItrt-0002Kk-1K; Thu, 17 Sep 2020 13:22:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 873F93006D0;
        Thu, 17 Sep 2020 15:22:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 369752BACAEF2; Thu, 17 Sep 2020 15:22:30 +0200 (CEST)
Date:   Thu, 17 Sep 2020 15:22:30 +0200
From:   peterz@infradead.org
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Boaz Harrosh <boaz@plexistor.com>,
        Hou Tao <houtao1@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200917132230.GG1362448@hirez.programming.kicks-ass.net>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
 <20200917120132.GA5602@redhat.com>
 <20200917124838.GT5449@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917124838.GT5449@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 01:48:38PM +0100, Matthew Wilcox wrote:
> On Thu, Sep 17, 2020 at 02:01:33PM +0200, Oleg Nesterov wrote:
> > IIUC, file_end_write() was never IRQ safe (at least if !CONFIG_SMP), even
> > before 8129ed2964 ("change sb_writers to use percpu_rw_semaphore"), but this
> > doesn't matter...
> > 
> > Perhaps we can change aio.c, io_uring.c and fs/overlayfs/file.c to avoid
> > file_end_write() in IRQ context, but I am not sure it's worth the trouble.
> 
> If we change bio_endio to invoke the ->bi_end_io callbacks in softirq
> context instead of hardirq context, we can change the pagecache to take

SoftIRQ context has exactly the same problem vs __this_cpu*().
