Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B49106FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 12:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfEAKae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 06:30:34 -0400
Received: from foss.arm.com ([217.140.101.70]:57668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfEAKae (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 06:30:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 788C9A78;
        Wed,  1 May 2019 03:30:33 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37B9A3F719;
        Wed,  1 May 2019 03:30:32 -0700 (PDT)
Date:   Wed, 1 May 2019 11:30:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] io_uring: avoid page allocation warnings
Message-ID: <20190501103026.GA11740@lakrids.cambridge.arm.com>
References: <20190430132405.8268-1-mark.rutland@arm.com>
 <20190430141810.GF13796@bombadil.infradead.org>
 <20190430145938.GA8314@lakrids.cambridge.arm.com>
 <a1af3017-6572-e828-dc8a-a5c8458e6b5a@kernel.dk>
 <20190430170302.GD8314@lakrids.cambridge.arm.com>
 <0bd395a0-e0d3-16a5-e29f-557e97782a48@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd395a0-e0d3-16a5-e29f-557e97782a48@kernel.dk>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:11:59PM -0600, Jens Axboe wrote:
> On 4/30/19 11:03 AM, Mark Rutland wrote:
> > On Tue, Apr 30, 2019 at 10:21:03AM -0600, Jens Axboe wrote:
> >> On 4/30/19 8:59 AM, Mark Rutland wrote:
> >>> On Tue, Apr 30, 2019 at 07:18:10AM -0700, Matthew Wilcox wrote:
> >>>> On Tue, Apr 30, 2019 at 02:24:05PM +0100, Mark Rutland wrote:
> >>>>> In io_sqe_buffer_register() we allocate a number of arrays based on the
> >>>>> iov_len from the user-provided iov. While we limit iov_len to SZ_1G,
> >>>>> we can still attempt to allocate arrays exceeding MAX_ORDER.
> >>>>>
> >>>>> On a 64-bit system with 4KiB pages, for an iov where iov_base = 0x10 and
> >>>>> iov_len = SZ_1G, we'll calculate that nr_pages = 262145. When we try to
> >>>>> allocate a corresponding array of (16-byte) bio_vecs, requiring 4194320
> >>>>> bytes, which is greater than 4MiB. This results in SLUB warning that
> >>>>> we're trying to allocate greater than MAX_ORDER, and failing the
> >>>>> allocation.
> >>>>>
> >>>>> Avoid this by passing __GFP_NOWARN when allocating arrays for the
> >>>>> user-provided iov_len. We'll gracefully handle the failed allocation,
> >>>>> returning -ENOMEM to userspace.
> >>>>>
> >>>>> We should probably consider lowering the limit below SZ_1G, or reworking
> >>>>> the array allocations.
> >>>>
> >>>> I'd suggest that kvmalloc is probably our friend here ... we don't really
> >>>> want to return -ENOMEM to userspace for this case, I don't think.
> >>>
> >>> Sure. I'll go verify that the uring code doesn't assume this memory is
> >>> physically contiguous.
> >>>
> >>> I also guess we should be passing GFP_KERNEL_ACCOUNT rateh than a plain
> >>> GFP_KERNEL.
> >>
> >> kvmalloc() is fine, the io_uring code doesn't care about the layout of
> >> the memory, it just uses it as an index.
> > 
> > I've just had a go at that, but when using kvmalloc() with or without
> > GFP_KERNEL_ACCOUNT I hit OOM and my system hangs within a few seconds with the
> > syzkaller prog below:
> > 
> > ----
> > Syzkaller reproducer:
> > # {Threaded:false Collide:false Repeat:false RepeatTimes:0 Procs:1 Sandbox: Fault:false FaultCall:-1 FaultNth:0 EnableTun:false EnableNetDev:false EnableNetReset:false EnableCgroups:false EnableBinfmtMisc:false EnableCloseFds:false UseTmpDir:false HandleSegv:false Repro:false Trace:false}
> > r0 = io_uring_setup(0x378, &(0x7f00000000c0))
> > sendmsg$SEG6_CMD_SET_TUNSRC(0xffffffffffffffff, &(0x7f0000000240)={&(0x7f0000000000)={0x10, 0x0, 0x0, 0x40000000}, 0xc, 0x0, 0x1, 0x0, 0x0, 0x10}, 0x800)
> > io_uring_register$IORING_REGISTER_BUFFERS(r0, 0x0, &(0x7f0000000000), 0x1)
> > ----
> > 
> > ... I'm a bit worried that opens up a trivial DoS.
> > 
> > Thoughts?
> 
> Can you post the patch you used?

Diff below.

Mark.

---->8----
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 578b5494f9e5..c6dad90fab14 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2364,7 +2364,7 @@ static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
 
 		if (ctx->account_mem)
 			io_unaccount_mem(ctx->user, imu->nr_bvecs);
-		kfree(imu->bvec);
+		kvfree(imu->bvec);
 		imu->nr_bvecs = 0;
 	}
 
@@ -2456,9 +2456,9 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 		if (!pages || nr_pages > got_pages) {
 			kfree(vmas);
 			kfree(pages);
-			pages = kmalloc_array(nr_pages, sizeof(struct page *),
+			pages = kvmalloc_array(nr_pages, sizeof(struct page *),
 						GFP_KERNEL);
-			vmas = kmalloc_array(nr_pages,
+			vmas = kvmalloc_array(nr_pages,
 					sizeof(struct vm_area_struct *),
 					GFP_KERNEL);
 			if (!pages || !vmas) {
@@ -2470,7 +2470,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 			got_pages = nr_pages;
 		}
 
-		imu->bvec = kmalloc_array(nr_pages, sizeof(struct bio_vec),
+		imu->bvec = kvmalloc_array(nr_pages, sizeof(struct bio_vec),
 						GFP_KERNEL);
 		ret = -ENOMEM;
 		if (!imu->bvec) {
@@ -2531,12 +2531,12 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 
 		ctx->nr_user_bufs++;
 	}
-	kfree(pages);
-	kfree(vmas);
+	kvfree(pages);
+	kvfree(vmas);
 	return 0;
 err:
-	kfree(pages);
-	kfree(vmas);
+	kvfree(pages);
+	kvfree(vmas);
 	io_sqe_buffer_unregister(ctx);
 	return ret;
 }
-- 
2.11.0

