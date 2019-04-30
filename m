Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F63FFF72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 20:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfD3SMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 14:12:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43593 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfD3SMC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:12:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id e67so7441187pfe.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=keqoE4yrofLz8kYqjDMsHSkr0S8YueMxYzrRDWUbwAc=;
        b=nel2FF2xXr6lovHX+5X+lMHSYLpbHBP2n/K5tXZUUpLin3UbJtXhYnNgYyPfij7qIo
         BJ9uWdtOXq8wi0NQ5nwUPx5CUIAgXpAZ4y1XR0C4aL3LUHVdCK93F5EKXPgPuwdX9S+J
         I7ytgmMcPPyO5VBUGx7rbCK6J6BAkOaZAB/6yyHN0JCf9WAo0OAXirXbebwl+gyLWRWN
         j1Oxn1GaRKyXPS6ydD6j7sll8hiPZguc3LLILFJdntPk7IXRoOO9quyvCj7VeR8iJc85
         7M+M5c/lDdbpj0FJD7y5B1NoIt5SOLsBi3SHAkV7ueuw6eRKjyjuiHU3hMiQf+uOkgAA
         Kv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=keqoE4yrofLz8kYqjDMsHSkr0S8YueMxYzrRDWUbwAc=;
        b=SWtpsp0uYjhChJhHmT5/cbo+gH1USl0HU71smUxu/O8evZnO4slv61tttuDsoD4Zuu
         jaM07Z/hPzpK0DAXwMVfrJwAGlVMCnXtQ7RbPKymgmfIWiBUn020vlsv/Q/ZP05NQuGi
         mXdy4IO5PkQ4InOZgSH1rlrKRL1wjrG8wVwOtuol/tSwF0PtFI9Ya8WB8n6NaucXuQaZ
         q59bX70Oe/uS8egNF9F7PVopZtdT5N0g+AbQYSOxw4o8JtmVbxv2freOiUze1G4Z85oL
         TlD5p3Ornm3yp2yElbuWdF1K7inPIsI9mJfuqB99Jdu1Clc2FmzY8DLr4XtvZT9PHHJV
         Hs1Q==
X-Gm-Message-State: APjAAAWGIzvD1qM7HnQ38I2u7C+o74NSXvqOX97aIozg5IzylMXAXKJN
        y9nsN0jBKmUSk5A8sgnTY1lbkg==
X-Google-Smtp-Source: APXvYqxJznYkLaG36rMsocKbpuE5EXZvpj3VByEQMt0piXbUrjmJroHQ3MSuCS/BLz8CGIk3QrdYPA==
X-Received: by 2002:a63:7504:: with SMTP id q4mr37268203pgc.443.1556647921914;
        Tue, 30 Apr 2019 11:12:01 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id b144sm13157642pfb.68.2019.04.30.11.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 11:12:00 -0700 (PDT)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0bd395a0-e0d3-16a5-e29f-557e97782a48@kernel.dk>
Date:   Tue, 30 Apr 2019 12:11:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430170302.GD8314@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/30/19 11:03 AM, Mark Rutland wrote:
> On Tue, Apr 30, 2019 at 10:21:03AM -0600, Jens Axboe wrote:
>> On 4/30/19 8:59 AM, Mark Rutland wrote:
>>> On Tue, Apr 30, 2019 at 07:18:10AM -0700, Matthew Wilcox wrote:
>>>> On Tue, Apr 30, 2019 at 02:24:05PM +0100, Mark Rutland wrote:
>>>>> In io_sqe_buffer_register() we allocate a number of arrays based on the
>>>>> iov_len from the user-provided iov. While we limit iov_len to SZ_1G,
>>>>> we can still attempt to allocate arrays exceeding MAX_ORDER.
>>>>>
>>>>> On a 64-bit system with 4KiB pages, for an iov where iov_base = 0x10 and
>>>>> iov_len = SZ_1G, we'll calculate that nr_pages = 262145. When we try to
>>>>> allocate a corresponding array of (16-byte) bio_vecs, requiring 4194320
>>>>> bytes, which is greater than 4MiB. This results in SLUB warning that
>>>>> we're trying to allocate greater than MAX_ORDER, and failing the
>>>>> allocation.
>>>>>
>>>>> Avoid this by passing __GFP_NOWARN when allocating arrays for the
>>>>> user-provided iov_len. We'll gracefully handle the failed allocation,
>>>>> returning -ENOMEM to userspace.
>>>>>
>>>>> We should probably consider lowering the limit below SZ_1G, or reworking
>>>>> the array allocations.
>>>>
>>>> I'd suggest that kvmalloc is probably our friend here ... we don't really
>>>> want to return -ENOMEM to userspace for this case, I don't think.
>>>
>>> Sure. I'll go verify that the uring code doesn't assume this memory is
>>> physically contiguous.
>>>
>>> I also guess we should be passing GFP_KERNEL_ACCOUNT rateh than a plain
>>> GFP_KERNEL.
>>
>> kvmalloc() is fine, the io_uring code doesn't care about the layout of
>> the memory, it just uses it as an index.
> 
> I've just had a go at that, but when using kvmalloc() with or without
> GFP_KERNEL_ACCOUNT I hit OOM and my system hangs within a few seconds with the
> syzkaller prog below:
> 
> ----
> Syzkaller reproducer:
> # {Threaded:false Collide:false Repeat:false RepeatTimes:0 Procs:1 Sandbox: Fault:false FaultCall:-1 FaultNth:0 EnableTun:false EnableNetDev:false EnableNetReset:false EnableCgroups:false EnableBinfmtMisc:false EnableCloseFds:false UseTmpDir:false HandleSegv:false Repro:false Trace:false}
> r0 = io_uring_setup(0x378, &(0x7f00000000c0))
> sendmsg$SEG6_CMD_SET_TUNSRC(0xffffffffffffffff, &(0x7f0000000240)={&(0x7f0000000000)={0x10, 0x0, 0x0, 0x40000000}, 0xc, 0x0, 0x1, 0x0, 0x0, 0x10}, 0x800)
> io_uring_register$IORING_REGISTER_BUFFERS(r0, 0x0, &(0x7f0000000000), 0x1)
> ----
> 
> ... I'm a bit worried that opens up a trivial DoS.
> 
> Thoughts?

Can you post the patch you used?

-- 
Jens Axboe

