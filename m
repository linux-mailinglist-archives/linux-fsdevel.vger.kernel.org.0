Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA75410922
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 16:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfEAOcq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 10:32:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfEAOcq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 10:32:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A600D3082DCE;
        Wed,  1 May 2019 14:32:45 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDF1161D34;
        Wed,  1 May 2019 14:32:44 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Shenghui Wang <shhuiw@foxmail.com>, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] io_uring: use cpu_online() to check p->sq_thread_cpu instead of cpu_possible()
References: <20190501072430.6674-1-shhuiw@foxmail.com>
        <x49wojaxuaa.fsf@segfault.boston.devel.redhat.com>
        <cd55b1e4-9395-a8b7-707e-ceed9d6c0c15@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 01 May 2019 10:32:43 -0400
In-Reply-To: <cd55b1e4-9395-a8b7-707e-ceed9d6c0c15@kernel.dk> (Jens Axboe's
        message of "Wed, 1 May 2019 08:15:33 -0600")
Message-ID: <x49o94mxn1w.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 01 May 2019 14:32:45 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 5/1/19 5:56 AM, Jeff Moyer wrote:
>> Shenghui Wang <shhuiw@foxmail.com> writes:
>> 
>>> This issue is found by running liburing/test/io_uring_setup test.
>>>
>>> When test run, the testcase "attempt to bind to invalid cpu" would not
>>> pass with messages like:
>>>    io_uring_setup(1, 0xbfc2f7c8), \
>>> flags: IORING_SETUP_SQPOLL|IORING_SETUP_SQ_AFF, \
>>> resv: 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000, \
>>> sq_thread_cpu: 2
>>>    expected -1, got 3
>>>    FAIL
>>>
>>> On my system, there is:
>>>    CPU(s) possible : 0-3
>>>    CPU(s) online   : 0-1
>>>    CPU(s) offline  : 2-3
>>>    CPU(s) present  : 0-1
>>>
>>> The sq_thread_cpu 2 is offline on my system, so the bind should fail.
>>> But cpu_possible() will pass the check. We shouldn't be able to bind
>>> to an offline cpu. Use cpu_online() to do the check.
>>>
>>> After the change, the testcase run as expected: EINVAL will be returned
>>> for cpu offlined.
>>>
>>> Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
>>> ---
>>>  fs/io_uring.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index 0e9fb2cb1984..aa3d39860a1c 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -2241,7 +2241,7 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
>>>  	ctx->sqo_mm = current->mm;
>>>  
>>>  	ret = -EINVAL;
>>> -	if (!cpu_possible(p->sq_thread_cpu))
>>> +	if (!cpu_online(p->sq_thread_cpu))
>>>  		goto err;
>>>  
>>>  	if (ctx->flags & IORING_SETUP_SQPOLL) {
>>> @@ -2258,7 +2258,7 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
>>>  
>>>  			cpu = array_index_nospec(p->sq_thread_cpu, NR_CPUS);
>>>  			ret = -EINVAL;
>>> -			if (!cpu_possible(p->sq_thread_cpu))
>>> +			if (!cpu_online(p->sq_thread_cpu))
>>>  				goto err;
>>>  
>>>  			ctx->sqo_thread = kthread_create_on_cpu(io_sq_thread,
>> 
>> Hmm.  Why are we doing this check twice?  Oh... Jens, I think you
>> braino'd commit 917257daa0fea.  Have a look.  You probably wanted to get
>> rid of the first check for cpu_possible.
>
> Added a fixup patch the other day:
>
> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=362bf8670efccebca22efda1ee5a5ee831ec5efb

@@ -2333,13 +2329,14 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 			ctx->sq_thread_idle = HZ;
 
 		if (p->flags & IORING_SETUP_SQ_AFF) {
-			int cpu;
+			int cpu = p->sq_thread_cpu;
 
-			cpu = array_index_nospec(p->sq_thread_cpu, NR_CPUS);
 			ret = -EINVAL;
-			if (!cpu_possible(p->sq_thread_cpu))
+			if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
 				goto err;
 
+			cpu = array_index_nospec(cpu, nr_cpu_ids);
+

Why do you do the array_index_nospec last?  Why wouldn't that be written
as:

	if (p->flags & IORING_SETUP_SQ_AFF) {
		int cpu = array_index_nospec(p->sq_thread_cpu, nr_cpu_ids);

		ret = -EINVAL;
		if (!cpu_possible(cpu))
			goto err;

		ctx->sqo_thread = kthread_create_on_cpu(io_sq_thread,
						ctx, cpu,
						"io_uring-sq");
	} else {
...

That would take away some head-scratching for me.

Cheers,
Jeff
