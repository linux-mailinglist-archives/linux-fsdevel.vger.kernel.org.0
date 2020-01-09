Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECEA135137
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 03:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgAICD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 21:03:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38638 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgAICD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 21:03:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id f20so1882246plj.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2020 18:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bvQg+LxFMIJ5CUVmtu63eojL5hkuYWw8tQBem5norCI=;
        b=GebOjeBTPu8s5SIYddRsBbZUSpUo6Lht+ASKHIGR0mvZs8tWBpypz9mJTWppcmoReg
         +riQFYlZUyMak9BFuKcPRtyEhuHOWVVDW4HB096mTRyGvLJd42wl/IpWfXToK2PbepOw
         7WLzMYS80CXiXjpcCWgRpQodilbgSFG7ZAzA4qNRj5O0ZSmib0CL3qoM3Tj7QkKdbS+G
         aaoispdLcZDPzMkAhBeeAUjwXkDWZoTz479JIu2N1S01KsjT4pA3P1g7EKmZ4qJA725c
         RpFTNUMxSj4+JoCROd/1Cc2KM6cILw5k2iLo5iSm5sZ3X4Sba9sXQmkdy5ENnwF/1CJF
         B6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bvQg+LxFMIJ5CUVmtu63eojL5hkuYWw8tQBem5norCI=;
        b=VoHkE94jOWjzfaONsq+MG6nhUjr0wB4ynxraW4ok15nk70krknuENdEHSoXFxAhIwp
         /qdiZhUv9wLqMPTbuyvlwo4fNCsvW0JaOpHgj7sue56iqc02omrGk9JAuhezxIn6B3Zf
         QAYESBr9GTNwFYdnHIbvs75gi1tOC+xhEuSE/SVjiNlh/9BsOXFpwOK4u52j++UuFpvG
         +l+neS8eAai0WcfE2nBFCkJm+pMRIyE99KX0xOX6oOo61acVyGSHDerUuYrMHw+BHXOa
         wpPZSNF1ezb7jk50hBkgkpjaYp7GLeUluj/H6+h3R9oHMj0pX0imwjKKHl5ykAB4f8Ei
         3jUQ==
X-Gm-Message-State: APjAAAWtp63n48gx42P5ar3E/hKuAEUgqiohfSDVjtyY/lujeY6WwrEi
        GudIG6T2viEfVkDFJjq5YAvbxw==
X-Google-Smtp-Source: APXvYqysci+ybBBfFoBTS8pypSqrLYiTCkceL+OSgmospOeEaAA9rc6LaU0pICjLVT7ARdNXuk2VJQ==
X-Received: by 2002:a17:902:7d94:: with SMTP id a20mr6050657plm.297.1578535435212;
        Wed, 08 Jan 2020 18:03:55 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id a16sm5019329pgb.5.2020.01.08.18.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 18:03:54 -0800 (PST)
Subject: Re: [PATCHSET v2 0/6] io_uring: add support for open/close
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Metzmacher <metze@samba.org>, io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20200107170034.16165-1-axboe@kernel.dk>
 <e4fb6287-8216-529e-9666-5ec855db02fb@samba.org>
 <4adb30f4-2ab3-6029-bc94-c72736b9004a@kernel.dk>
 <4dffd58e-5602-62d5-d1af-343c4a091ed9@samba.org>
 <eb99e387-f385-c36d-b1d9-f99ec470eba6@kernel.dk>
Message-ID: <9a407238-5505-c446-80b7-086646dd15be@kernel.dk>
Date:   Wed, 8 Jan 2020 19:03:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <eb99e387-f385-c36d-b1d9-f99ec470eba6@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/8/20 6:02 PM, Jens Axboe wrote:
> On 1/8/20 4:05 PM, Stefan Metzmacher wrote:
>> Am 08.01.20 um 23:57 schrieb Jens Axboe:
>>> On 1/8/20 2:17 PM, Stefan Metzmacher wrote:
>>>> Am 07.01.20 um 18:00 schrieb Jens Axboe:
>>>>> Sending this out separately, as I rebased it on top of the work.openat2
>>>>> branch from Al to resolve some of the conflicts with the differences in
>>>>> how open flags are built.
>>>>
>>>> Now that you rebased on top of openat2, wouldn't it be better to add
>>>> openat2 that to io_uring instead of the old openat call?
>>>
>>> The IORING_OP_OPENAT already exists, so it would probably make more sense
>>> to add IORING_OP_OPENAT2 alongside that. Or I could just change it. Don't
>>> really feel that strongly about it, I'll probably just add openat2 and
>>> leave openat alone, openat will just be a wrapper around openat2 anyway.
>>
>> Great, thanks!
> 
> Here:
> 
> https://git.kernel.dk/cgit/linux-block/log/?h=for-5.6/io_uring-vfs
> 
> Not tested yet, will wire this up in liburing and write a test case
> as well.

Wrote a basic test case, and used my openbench as well. Seems to work
fine for me. Pushed prep etc support to liburing.

-- 
Jens Axboe

