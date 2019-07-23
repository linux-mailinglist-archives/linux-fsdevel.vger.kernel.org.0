Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C096872233
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 00:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392483AbfGWWTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 18:19:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41287 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392422AbfGWWTg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:19:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so19835006pff.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2019 15:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AKF9O0VPcuMNVYBDlFT/wJSrPR+R77gWBK4FrFweTp4=;
        b=MfayciM9oDbhZYdaY2bszuTdPhpuXMVEQtfXwy0I5acwSMbdDNmPDH/q0Fb5UmTXHp
         N8go8fTkZCcJMcwcmhHcDJyrGje2y3FyJIrcjcv/rmDE7VaepFBJkSrZ3zRgEo0w0jHi
         pXSx5a8t+CA2aWWmD9YTgmYWKho1ny0fcS9MQjSm+ak+Ut2kRqNukboYKz+VotYd5INP
         s8DCEB3wFG3oWDQlMcsSpNFWJ+jcQ8+nL1iybSggJTDSKDfnLDidZ4/imR2R6+QK/VSF
         0z0+CKY5zu4PYOc/qEPz7IT7uFdz6pFhAiZw1EKtqSa7KURNUStyshqdMu3l4gEmR/Y3
         INFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AKF9O0VPcuMNVYBDlFT/wJSrPR+R77gWBK4FrFweTp4=;
        b=YqK9r1e0TkqVIt1n4jnSmq45I3GZv+ZVOSm//S9LzOGmA/Rk+hcz+T3PAZLioVdZz/
         MY+9faLF2XLjfnNi3L1n23g0G+JMYzbMVdUOCplKetlI0IEDpWEN8rFhN3OZzbHjf/3n
         4nSwGrtKjaSTHHcCAWYRHox/O1SE0CXp4ez6M6KFoe6ztfsRWZJlgIebymWFI1e1Nu+7
         rGpZ10WcsyrqLq0wOz3p1xR+yheGmET2feS8bW/IRobCe43HjCAxOAiCE2zfZXVKYlwz
         KrLDEdckpCldYdSSRD9C2985ARPkVW77kWb/K0ooiqjV90uQ+KoIwC85oht0AUMXHYcR
         sBGA==
X-Gm-Message-State: APjAAAXBBkznyVtEM4pKVa/DzMYa3KiUMiyIelmLPJMBPbtOJ39h4nqI
        Yu9jh9KfYwZw522h08DeQXo=
X-Google-Smtp-Source: APXvYqyc2RtAxrLY1ZQBqy+qwMS5aH33kzKRJZSIlRooo2b77qgeyFwxKNHU2T8TTilFy1Hpj+WQ/g==
X-Received: by 2002:a17:90b:f0e:: with SMTP id br14mr84234704pjb.117.1563920375183;
        Tue, 23 Jul 2019 15:19:35 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id v184sm41482902pgd.34.2019.07.23.15.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 15:19:33 -0700 (PDT)
Subject: Re: EIO with io_uring O_DIRECT writes on ext4
To:     Dave Chinner <david@fromorbit.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20190723080701.GA3198@stefanha-x1.localdomain>
 <9a13c3b9-ecf2-6ba7-f0fb-c59a1e1539f3@kernel.dk>
 <20190723220502.GX7777@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d875750c-62ce-5773-39a7-74d5bf920aaf@kernel.dk>
Date:   Tue, 23 Jul 2019 16:19:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723220502.GX7777@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/23/19 4:05 PM, Dave Chinner wrote:
> On Tue, Jul 23, 2019 at 09:20:05AM -0600, Jens Axboe wrote:
>> On 7/23/19 2:07 AM, Stefan Hajnoczi wrote:
>>> Hi,
>>> io_uring O_DIRECT writes can fail with EIO on ext4.  Please see the
>>> function graph trace from Linux 5.3.0-rc1 below for details.  It was
>>> produced with the following qemu-io command (using Aarushi's QEMU
>>> patches from https://github.com/rooshm/qemu/commits/io_uring):
>>>
>>>     $ qemu-io --cache=none --aio=io_uring --format=qcow2 -c 'writev -P 185 131072 65536' tests/qemu-iotests/scratch/test.qcow2
>>>
>>> This issue is specific to ext4.  XFS and the underlying LVM logical
>>> volume both work.
>>>
>>> The storage configuration is an LVM logical volume (device-mapper linear
>>> target), on top of LUKS, on top of a SATA disk.  The logical volume's
>>> request_queue does not have mq_ops and this causes
>>> generic_make_request_checks() to fail:
>>>
>>>     if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q))
>>>             goto not_supported;
>>>
>>> I guess this could be worked around by deferring the request to the
>>> io_uring work queue to avoid REQ_NOWAIT.  But XFS handles this fine so
>>> how can io_uring.c detect this case cleanly or is there a bug in ext4?
>>
>> I actually think it's XFS that's broken here, it's not passing down
>> the IOCB_NOWAIT -> IOMAP_NOWAIT -> REQ_NOWAIT. This means we lose that
>> important request bit, and we just block instead of triggering the
>> not_supported case.
> 
> I wouldn't say XFS is broken, we didn't implement it because it
> meant that IOCB_NOWAIT did not work on all block devices. i.e. the
> biggest issue IOCB_NOWAIT is avoiding is blocking on filesytem
> locks, and blocking in the request queue was largely just noise for
> the applications RWF_NOWAIT was initially implemented for.

Blocking due to resource starvation (like requests) is definitely not
just noise, in some case it's cases it's an equal or larger amount of
time.

> IOWs, if you have the wrong hardware, you can't use RWF_NOWAIT at

Define wrong...

> all, despite it providing massive benefits for AIO at the filesystem
> level. Hence to say how IOMAP_NOWAIT is implemented (i.e. does not
> set REQ_NOWAIT) is broken ignores the fact that RWF_NOWAIT was
> originally intended as a "don't block on contended filesystem locks"
> directive, not as something that is conditional on block layer
> functionality...

RWF_NOWAIT should have nothing to do with the block layer at all, each
storage layer would have to support it.

>> Outside of that, that case needs similar treatment to what I did for
>> the EAGAIN case here:
>>
>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=893a1c97205a3ece0cbb3f571a3b972080f3b4c7
> 
> I don't see REQ_NOWAIT_INLINE in 5.3-rc1.

That's because it isn't in 5.3-rc1 :-)

> However, nobody checks the cookie returned by submit_bio() for error
> status. It's only a recent addition for block polling and so the
> only time it is checked is if we are polling and it gets passed to
> blk_poll when RWF_HIPRI is set. So this change, by itself, doesn't
> solve any problem.

REQ_NOWAIT wasn't introduced as part of the polling work, it was done
earlier for libaio.

You don't have to check the cookie for REQ_NOWAIT, you'd only have to
check it for REQ_NOWAIT_INLINE.

> In fact, the way the direct IO code is right now a multi-bio DIO
> submission will overwrite the submit cookie repeatedly and hence may
> end up only doing partial submission but still report success
> because the last bio in the chain didn't block and REQ_NOWAIT_INLINE
> doesn't actually mark the bio itself with an error, so the bio
> completion function won't report it, either.

Agree, details around multi-bio was largely ignored for the polling,
since multi-bio implies larger IO and that was somewhat ignored (as less
interesting).

>> It was a big mistake to pass back these values in an async fashion,
> 
> IMO, the big mistake was to have only some block device
> configurations support REQ_NOWAIT - that was an expedient hack to
> get block layer polling into the kernel fast. The way the error is
> passed back is largely irrelevant from that perspective, and
> REQ_NOWAIT_INLINE doesn't resolve this problem at all.

Again, it has nothing to do with polling. But yes, going forward it
needs to get divorced from being tied to the fact that the queue is
blk-mq or not, and stacking drivers should opt-in to supporting it.

> Indeed, I think REQ_NOWAIT is largely redundant, because if we care
> about IO submission blocking because the request queue is full, then
> we simply use the existing bdi_congested() interface to check.
> That works for all types of block devices - not just random mq
> devices - and matches code we have all over the kernel to avoid
> blocking async IO submission on congested reuqest queues...

No... The congestion logic is silly and I think a design mistake from
way back when. There's no race free way to answer that question and
utilize the answer safely, it can only truly be done as part of the
resource allocation when the IO is going through the stack. That's
looking at the simple case of just a basic storage setup, with stacked
layers it becomes even worse and a nightmare to support. And you still
get the racy answer.

> So, yeah, I think REQ_NOWAIT needs to die and the direct IO callers
> should do just congestion checks on IOCB_NOWAIT/IOMAP_NOWAIT rather
> than try to add new error reporting mechanisms into bios that lots
> of code will need to be changed to support....

See above, totally disagree on that conclusion.

-- 
Jens Axboe

