Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7D310A0C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 17:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEAP33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 11:29:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34852 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfEAP33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 11:29:29 -0400
Received: by mail-io1-f66.google.com with SMTP id r18so15126737ioh.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w9icvTpHr/0UAUYKXVxAi0Mjttdtx3G15AY7sawXcdw=;
        b=GmHq9NsEB0M1Qo6k1yWcAHJTK0LWrOuMLjXx9IWyix/blgs73E4lFLnPvnhmLAAS5u
         nwqL5nI6DiCbISjtx1RjtFET5bxHiEOPGBOyCGyDbh/tfZlYZTXA6UDZVjaqSVCb60Bh
         Og8GxSsoOVPGIn+hKcIX6dSyo0eablzlos+vwYtQayNZgF4rWR3xH5xVSlpYyteP3SDS
         3SoEqVtQn4apu/yRc564DLei1YlkoLjOn93D2lvn8uWV+fK8AMgTkGWwbsTHZnHqwfZs
         fs7npyoefdRfvUWewCSTCEurMzYSKUFufcv/2sLNSRT5WUMow1oL5g+kogrIdBZWEIih
         abFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w9icvTpHr/0UAUYKXVxAi0Mjttdtx3G15AY7sawXcdw=;
        b=VJeuG0kynispmsKyV5FS8GDP24F+2fdliJJkiOXoCwuRf5ZMh3Jmu5HB1TzfsQ6IlZ
         wS4W4CC5eeWiihJ6mdWERUorlXtZ5CgHE6CisEcEZD7osfFbFxAhSPwtrubrFnW0/2CK
         nzai7FK2FV6TX9gDYuC9OIlOrtw+6Cqd6cSRz8zgE8jGi99ewGRo7d4u5F9jgQ0wPjIR
         xXf+9OPpsJ0CJjqJXOcQJTkPnNSzu0wOl9WGUxaIrkfELRCZs/SHFGyZHs8fYFppoNbR
         SRUWe5HNYKfNCheQJNfyIva/DEnAcQworbvGLmswmrbFvXApDHef5Dltn/EkqznmEDYp
         v03w==
X-Gm-Message-State: APjAAAVHeQ148tdSsLIE59wsGxW0CWyKQrhFCnZZfcOVbWUOkdzgjPxY
        alrnuZ3BmVkhcLsetPxZFauJS8L8M6Zs+Q==
X-Google-Smtp-Source: APXvYqxxdhXPqY0wown7mv3DfGcCQbx7MWnNeZLu50Ky50fVdx2xvbdy2IE0njr544wEEG5wdyV9qQ==
X-Received: by 2002:a6b:6f11:: with SMTP id k17mr20872583ioc.76.1556724568160;
        Wed, 01 May 2019 08:29:28 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y7sm4851938ioq.87.2019.05.01.08.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 08:29:26 -0700 (PDT)
Subject: Re: [PATCH] io_uring: avoid page allocation warnings
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <20190430132405.8268-1-mark.rutland@arm.com>
 <20190430141810.GF13796@bombadil.infradead.org>
 <20190430145938.GA8314@lakrids.cambridge.arm.com>
 <a1af3017-6572-e828-dc8a-a5c8458e6b5a@kernel.dk>
 <20190430170302.GD8314@lakrids.cambridge.arm.com>
 <0bd395a0-e0d3-16a5-e29f-557e97782a48@kernel.dk>
 <20190501103026.GA11740@lakrids.cambridge.arm.com>
 <710a3048-ccab-260d-d8b7-1d51ff6d589d@kernel.dk>
 <20190501150921.GE11740@lakrids.cambridge.arm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <88fee953-ea3e-b9c0-650c-60faea07dd04@kernel.dk>
Date:   Wed, 1 May 2019 09:29:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501150921.GE11740@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/19 9:09 AM, Mark Rutland wrote:
> On Wed, May 01, 2019 at 06:41:43AM -0600, Jens Axboe wrote:
>> On 5/1/19 4:30 AM, Mark Rutland wrote:
>>> On Tue, Apr 30, 2019 at 12:11:59PM -0600, Jens Axboe wrote:
>>>> On 4/30/19 11:03 AM, Mark Rutland wrote:
>>>>> I've just had a go at that, but when using kvmalloc() with or without
>>>>> GFP_KERNEL_ACCOUNT I hit OOM and my system hangs within a few seconds with the
>>>>> syzkaller prog below:
>>>>>
>>>>> ----
>>>>> Syzkaller reproducer:
>>>>> # {Threaded:false Collide:false Repeat:false RepeatTimes:0 Procs:1 Sandbox: Fault:false FaultCall:-1 FaultNth:0 EnableTun:false EnableNetDev:false EnableNetReset:false EnableCgroups:false EnableBinfmtMisc:false EnableCloseFds:false UseTmpDir:false HandleSegv:false Repro:false Trace:false}
>>>>> r0 = io_uring_setup(0x378, &(0x7f00000000c0))
>>>>> sendmsg$SEG6_CMD_SET_TUNSRC(0xffffffffffffffff, &(0x7f0000000240)={&(0x7f0000000000)={0x10, 0x0, 0x0, 0x40000000}, 0xc, 0x0, 0x1, 0x0, 0x0, 0x10}, 0x800)
>>>>> io_uring_register$IORING_REGISTER_BUFFERS(r0, 0x0, &(0x7f0000000000), 0x1)
>>>>> ----
>>>>>
>>>>> ... I'm a bit worried that opens up a trivial DoS.
>>>>>
>>>>> Thoughts?
>>>>
>>>> Can you post the patch you used?
>>>
>>> Diff below.
>>
>> And the reproducer, that was never posted.
> 
> It was; the "Syzakller reproducer" above is the reproducer I used with
> syz-repro.
> 
> I've manually minimized that to C below. AFAICT, that hits a leak, which
> is what's triggering the OOM after the program is run a number of times
> with the previously posted kvmalloc patch.
> 
> Per /proc/meminfo, that memory isn't accounted anywhere.
> 
>> Patch looks fine to me. Note
>> that buffer registration is under the protection of RLIMIT_MEMLOCK.
>> That's usually very limited for non-root, as root you can of course
>> consume as much as you want and OOM the system.
> 
> Sure.
> 
> As above, it looks like there's a leak, regardless.

The leak is that we're not releasing imu->bvec in case of error. I fixed
a missing kfree -> kvfree as well in your patch, with this rolled up
version it works for me.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 18cecb6a0151..3e817d40fb96 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2443,7 +2443,7 @@ static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
 
 		if (ctx->account_mem)
 			io_unaccount_mem(ctx->user, imu->nr_bvecs);
-		kfree(imu->bvec);
+		kvfree(imu->bvec);
 		imu->nr_bvecs = 0;
 	}
 
@@ -2533,11 +2533,11 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 
 		ret = 0;
 		if (!pages || nr_pages > got_pages) {
-			kfree(vmas);
-			kfree(pages);
-			pages = kmalloc_array(nr_pages, sizeof(struct page *),
+			kvfree(vmas);
+			kvfree(pages);
+			pages = kvmalloc_array(nr_pages, sizeof(struct page *),
 						GFP_KERNEL);
-			vmas = kmalloc_array(nr_pages,
+			vmas = kvmalloc_array(nr_pages,
 					sizeof(struct vm_area_struct *),
 					GFP_KERNEL);
 			if (!pages || !vmas) {
@@ -2549,7 +2549,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 			got_pages = nr_pages;
 		}
 
-		imu->bvec = kmalloc_array(nr_pages, sizeof(struct bio_vec),
+		imu->bvec = kvmalloc_array(nr_pages, sizeof(struct bio_vec),
 						GFP_KERNEL);
 		ret = -ENOMEM;
 		if (!imu->bvec) {
@@ -2588,6 +2588,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 			}
 			if (ctx->account_mem)
 				io_unaccount_mem(ctx->user, nr_pages);
+			kvfree(imu->bvec);
 			goto err;
 		}
 
@@ -2610,12 +2611,12 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 
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
Jens Axboe

