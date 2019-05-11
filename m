Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF11D1A86A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 18:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfEKQ06 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 12:26:58 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:52820 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbfEKQ06 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 12:26:58 -0400
Received: from [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6] (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 6A55DC02FF2;
        Sat, 11 May 2019 16:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1557592014;
        bh=/2ZxlW7aDDfy0xvGK0ueGLfxt5kcabacHzvoULV0rjU=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=ZjuYN/44wkI+Hle09CQImdeO9pDg3bKjvNke1007vdYO3czOgacv7FpErC+6DvkM2
         WZDCxaJ+ouQsZfFBSOAcZx/B2mi8bnHA9N4KjzieIowxo3VUJj24QcB6UqJcVq4ZSR
         RvCz+WT57JR2ewnMfm6r9ACQ5Y0bKbIGyXAECiqA=
Subject: Re: io_uring: closing / release
From:   =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <366484f9-cc5b-e477-6cc5-6c65f21afdcb@stbuehler.de>
 <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
 <87f76da1-5525-086e-7a9c-3bdb2ad12188@stbuehler.de>
Openpgp: preference=signencrypt
Message-ID: <e57a384b-fa46-7caa-3800-bcc9bc6ced90@stbuehler.de>
Date:   Sat, 11 May 2019 18:26:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87f76da1-5525-086e-7a9c-3bdb2ad12188@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 27.04.19 23:07, Stefan Bühler wrote:
> Hi,
> 
> On 23.04.19 22:31, Jens Axboe wrote:
>> On 4/23/19 1:06 PM, Stefan Bühler wrote:
>>> I have one other question: is there any way to cancel an IO read/write
>>> operation? I don't think closing io_uring has any effect, what about
>>> closing the files I'm reading/writing?  (Adding cancelation to kiocb
>>> sounds like a non-trivial task; and I don't think it already supports it.)
>>
>> There is no way to do that. If you look at existing aio, nobody supports
>> that either. Hence io_uring doesn't export any sort of cancellation outside
>> of the poll case where we can handle it internally to io_uring.
>>
>> If you look at storage, then generally IO doesn't wait around in the stack,
>> it's issued. Most hardware only supports queue abort like cancellation,
>> which isn't useful at all.
>>
>> So I don't think that will ever happen.
>>
>>> So cleanup in general seems hard to me: do I have to wait for all
>>> read/write operations to complete so I can safely free all buffers
>>> before I close the event loop?
>>
>> The ring exit waits for IO to complete already.
> 
> I now understand at least how that part is working;
> io_ring_ctx_wait_and_kill calls wait_for_completion(&ctx->ctx_done),
> which only completes after all references are gone; each pending job
> keeps a reference.
> 
> But wait_for_completion is not interruptible; so if there are "stuck"
> jobs even root can't kill the task (afaict) anymore.
> 
> Once e.g. readv is working on pipes/sockets (I have some local patches
> here for that), you can easily end up in a situation where a
> socketpair() or a pipe() is still alive, but the read will never finish
> (I can trigger this problem with an explicit close(uring_fd), not sure
> how to observe this on process exit).
> 
> For a socketpair() even both ends could be kept alive by never ending
> read jobs.
> 
> Using wait_for_completion seems like a really bad idea to me; this is a
> problem for io_uring_register too.

As far as I know this is not a problem yet in 5.1 as reads on pipes and
sockets are still blocking the submission, and SQPOLL is only for
CAP_SYS_ADMIN.

But once my "punt to workers if file doesn't support async" patch (or
something similar) goes in, this will become a real problem.

My current trigger looks like this: create socketpair(), submit read
from both ends (using the same iovec... who cares), wait for the workers
to pick up the reads, munmap everything and exit.

The kernel will then cleanup the files: but the sockets are still in use
by io_uring, and it will only close the io_uring context, which will
then get stuck in io_ring_ctx_wait_and_kill.

In my qemu test environment "nobody" can leak 16 contexts before hitting
some resource limits.

cheers,
Stefan
