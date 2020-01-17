Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D97C1140DB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 16:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgAQPVD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 10:21:03 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42459 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgAQPVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:21:03 -0500
Received: by mail-io1-f68.google.com with SMTP id n11so26372319iom.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 07:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lV41RpA2QhEA5rHH6ZyOIv8ERiJPbYKFmYjuUSaG+xY=;
        b=b0LSOflu7YITfOb8w5wi0kKgHuwAAYbt8QhYhVXfdHzo6JF5FBQMQ/andumpi0YUYg
         N7pZyOhFoH9UOwBkIoLvHc4ft7vLlAf4n2RuRbFRMW+B71ipf5wcO7wCSFkVVLHkO5jI
         3K+n8FE27awtwWIdLKVOXTTCYsCR1knctOe4COEYGMl2D1Qf4FsICFacb/2OHmiAN87A
         yUKNszWjYYQQmfIsktyb3QGim0W77+mQShRvXvCNxplZqMe/TRPpiC6su1QfbuWXjZZJ
         AlZ4N54EMBE1getHFCe7JiEjLmKRGbkGevpTj2GpVyKdzJEKUL5nl2BNtnWpmM6D9sqi
         hpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lV41RpA2QhEA5rHH6ZyOIv8ERiJPbYKFmYjuUSaG+xY=;
        b=bm0okB7Xue9DrJOFw1gyUG9gdcMhIrQyo+6B/zSVClMv6z7PTYRdzCNr/tyjub+ljD
         ragRRitEivUeN/kr5e0TJV6aQc177LNVoIFq1T25K4YAPUNUXvCWjU9LB11ZF3FBfrmT
         wLnTAWH5mJPmG+HAYEWD5L3M/XG31cwU+0bMJx4VEb8gF5NXyAoiPAtVu0KpOZUsq1C0
         lpQNEw5DIZnwLkx/r/kORJmUaxQKGyLip2Ff9mZT2EZvFIHDc6rP7yfzcrhhXeaouT9A
         fCgP9gI7nQ5QZ7k+/dOXGyxFRJcm5zeW9SgAggTMl6khkcpg45ArwPsRhx2oRKumWDs2
         jucQ==
X-Gm-Message-State: APjAAAVVlFsSw8ct8ytybr3Qu8TB6y6k+u9XQQV+hSj2K0dbGd0XxK9G
        iY1mxSFJXpz5Un7RRmwZicPQsoNWi2U=
X-Google-Smtp-Source: APXvYqxNdfKQ23cTwPqlKSciggsxkHP5nNwk+VgMM0sAWv9fvINW/lRRXEihWek+ZKUh4pmgWY7zeA==
X-Received: by 2002:a6b:1443:: with SMTP id 64mr30082191iou.116.1579274462723;
        Fri, 17 Jan 2020 07:21:02 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p69sm8016553ilb.48.2020.01.17.07.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 07:21:01 -0800 (PST)
Subject: Re: [PATCHSET v2 0/6] io_uring: add support for open/close
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Colin Walters <walters@verbum.org>,
        Stefan Metzmacher <metze@samba.org>, io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
References: <20200107170034.16165-1-axboe@kernel.dk>
 <e4fb6287-8216-529e-9666-5ec855db02fb@samba.org>
 <4adb30f4-2ab3-6029-bc94-c72736b9004a@kernel.dk>
 <4dffd58e-5602-62d5-d1af-343c4a091ed9@samba.org>
 <eb99e387-f385-c36d-b1d9-f99ec470eba6@kernel.dk>
 <9a407238-5505-c446-80b7-086646dd15be@kernel.dk>
 <d4d3fa40-1c59-a48a-533b-c8b221e0f221@samba.org>
 <1e8a9e98-67f8-4e2f-8185-040b9979bc1a@www.fastmail.com>
 <964c01cc-94f5-16b2-cc61-9ee5789b1f43@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cbdb0621-3bc8-fc41-a365-56b2639e39a0@kernel.dk>
Date:   Fri, 17 Jan 2020 08:21:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <964c01cc-94f5-16b2-cc61-9ee5789b1f43@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/17/20 2:32 AM, Pavel Begunkov wrote:
> On 1/17/2020 3:44 AM, Colin Walters wrote:
>> On Thu, Jan 16, 2020, at 5:50 PM, Stefan Metzmacher wrote:
>>> The client can compound a chain with open, getinfo, read, close
>>> getinfo, read and close get an file handle of -1 and implicitly
>>> get the fd generated/used in the previous request.
>>
>> Sounds similar to  https://capnproto.org/rpc.html too.
>>
> Looks like just grouping a pack of operations for RPC.
> With io_uring we could implement more interesting stuff. I've been
> thinking about eBPF in io_uring for a while as well, and apparently it
> could be _really_ powerful, and would allow almost zero-context-switches
> for some usecases.
> 
> 1. full flow control with eBPF
> - dropping requests (links)
> - emitting reqs/links (e.g. after completions of another req)
> - chaining/redirecting
> of course, all of that with fast intermediate computations in between
> 
> 2. do long eBPF programs by introducing a new opcode (punted to async).
> (though, there would be problems with that)
> 
> Could even allow to dynamically register new opcodes within the kernel
> and extend it to eBPF, if there will be demand for such things.

We're also looking into exactly that at Facebook, nothing concrete yet
though. But it's clear we need it to take full advantage of links at
least, and it's also clear that it would unlock a lot of really cool
functionality once we do.

Pavel, I'd strongly urge you to submit a talk to LSF/MM/BPF about this.
It's the perfect venue to have some concrete planning around this topic
and get things rolling.

https://lore.kernel.org/bpf/20191122172502.vffyfxlqejthjib6@macbook-pro-91.dhcp.thefacebook.com/

-- 
Jens Axboe

