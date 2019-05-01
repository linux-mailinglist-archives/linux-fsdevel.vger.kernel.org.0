Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B728A109CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 17:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfEAPJ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 11:09:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60714 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfEAPJZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 11:09:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38D97A78;
        Wed,  1 May 2019 08:09:25 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9B6F3F719;
        Wed,  1 May 2019 08:09:23 -0700 (PDT)
Date:   Wed, 1 May 2019 16:09:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] io_uring: avoid page allocation warnings
Message-ID: <20190501150921.GE11740@lakrids.cambridge.arm.com>
References: <20190430132405.8268-1-mark.rutland@arm.com>
 <20190430141810.GF13796@bombadil.infradead.org>
 <20190430145938.GA8314@lakrids.cambridge.arm.com>
 <a1af3017-6572-e828-dc8a-a5c8458e6b5a@kernel.dk>
 <20190430170302.GD8314@lakrids.cambridge.arm.com>
 <0bd395a0-e0d3-16a5-e29f-557e97782a48@kernel.dk>
 <20190501103026.GA11740@lakrids.cambridge.arm.com>
 <710a3048-ccab-260d-d8b7-1d51ff6d589d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710a3048-ccab-260d-d8b7-1d51ff6d589d@kernel.dk>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 01, 2019 at 06:41:43AM -0600, Jens Axboe wrote:
> On 5/1/19 4:30 AM, Mark Rutland wrote:
> > On Tue, Apr 30, 2019 at 12:11:59PM -0600, Jens Axboe wrote:
> >> On 4/30/19 11:03 AM, Mark Rutland wrote:
> >>> I've just had a go at that, but when using kvmalloc() with or without
> >>> GFP_KERNEL_ACCOUNT I hit OOM and my system hangs within a few seconds with the
> >>> syzkaller prog below:
> >>>
> >>> ----
> >>> Syzkaller reproducer:
> >>> # {Threaded:false Collide:false Repeat:false RepeatTimes:0 Procs:1 Sandbox: Fault:false FaultCall:-1 FaultNth:0 EnableTun:false EnableNetDev:false EnableNetReset:false EnableCgroups:false EnableBinfmtMisc:false EnableCloseFds:false UseTmpDir:false HandleSegv:false Repro:false Trace:false}
> >>> r0 = io_uring_setup(0x378, &(0x7f00000000c0))
> >>> sendmsg$SEG6_CMD_SET_TUNSRC(0xffffffffffffffff, &(0x7f0000000240)={&(0x7f0000000000)={0x10, 0x0, 0x0, 0x40000000}, 0xc, 0x0, 0x1, 0x0, 0x0, 0x10}, 0x800)
> >>> io_uring_register$IORING_REGISTER_BUFFERS(r0, 0x0, &(0x7f0000000000), 0x1)
> >>> ----
> >>>
> >>> ... I'm a bit worried that opens up a trivial DoS.
> >>>
> >>> Thoughts?
> >>
> >> Can you post the patch you used?
> > 
> > Diff below.
> 
> And the reproducer, that was never posted.

It was; the "Syzakller reproducer" above is the reproducer I used with
syz-repro.

I've manually minimized that to C below. AFAICT, that hits a leak, which
is what's triggering the OOM after the program is run a number of times
with the previously posted kvmalloc patch.

Per /proc/meminfo, that memory isn't accounted anywhere.

> Patch looks fine to me. Note
> that buffer registration is under the protection of RLIMIT_MEMLOCK.
> That's usually very limited for non-root, as root you can of course
> consume as much as you want and OOM the system.

Sure.

As above, it looks like there's a leak, regardless.

Thanks,
Mark.

---->8----
#include <stdint.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <linux/uio.h>

// NOTE: arm64 syscall numbers
#ifndef __NR_io_uring_register
#define __NR_io_uring_register 427
#endif
#ifndef __NR_io_uring_setup
#define __NR_io_uring_setup 425
#endif

#define __IORING_REGISTER_BUFFERS         0
	
struct __io_sqring_offsets {
	uint32_t head;
	uint32_t tail;
	uint32_t ring_mask;
	uint32_t ring_entries;
	uint32_t flags;
	uint32_t dropped;
	uint32_t array;
	uint32_t resv1;
	uint64_t resv2;
};

struct __io_uring_params {
	uint32_t sq_entries;
	uint32_t cq_entries;
	uint32_t flags;
	uint32_t sq_thread_cpu;
	uint32_t sq_thread_idle;
	uint32_t resv[5];
	struct __io_sqring_offsets sq_off;
	struct __io_sqring_offsets cq_off;

};

static struct __io_uring_params params; 

static struct iovec iov = {
	.iov_base = (void *)0x10,
	.iov_len  = 1024 * 1024 * 1024,
};

int main(void)
{
	int fd;

	fd = syscall(__NR_io_uring_setup, 0x1, &params);
	syscall(__NR_io_uring_register, fd, __IORING_REGISTER_BUFFERS, &iov, 1);

	return 0;
}
