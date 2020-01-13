Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F55139C78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 23:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgAMWaZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 17:30:25 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:38088 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAMWaZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:30:25 -0500
Received: by mail-il1-f194.google.com with SMTP id f5so9631009ilq.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2020 14:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k+N6EqBsaB7b3M4wFU0SvYfMG1hIpZGU6ASZzJ6UTl4=;
        b=PSDW0TUlBjZMzpEfpmqINaE170+K96ZYbuTqtNK8OKRpS9zYiW5nQ+VaXAuIwd4hEV
         t1d4deNeeY8rgypRyTuxxpe5HNMdCHMSdj3SCjGxpE2as7yhK2oBMF3+GMKQEfdYCX1R
         ImtHQCRZ04rx+WXjgNX5+1W8BL0rZXWWDd9/4ZHtiGi1uK51TUrox3zKsr5ksqemrxik
         GHI0pPMF5luIK2i2S+UKVkymruVLNTfejOkAU5ueFVz9fL5Cng6se3ktGtwAk7EdmrhZ
         ZPvf0y+nV5dIz5SbdBhBGBZ5njZkw72F19JmTu9KcWmP9YT3ro47tpzw+TL+msJGZEc/
         IV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k+N6EqBsaB7b3M4wFU0SvYfMG1hIpZGU6ASZzJ6UTl4=;
        b=AkbqkMFeJmQHyNKYnMSQU2mDOaapG33qYAVM42psleV3AOJkeXKHfZTG/tIn4c2rog
         jH84DJUgAipL3cwOQfuv6LTMEMmseaU5LhId0TrO4/baQB+842LT7NbblufEMYugrTHb
         BCcKAueuy1gRyxXdAuOrywVyqyPLpDAbwP0lxUxcklLz/jar/Lfr91dSz86MWoZo/0Xo
         889eWw+NnrJ+Vd/q6rd+RzDwc+f/grZW9DTtKLeogv/88Bl0fHh+2Ix9RYRbp9VkAM+U
         PEDvXdoDbZmlOjtox2v9hCJOti0cI3J99ER+Pi6EzLXZMJU3zzVeY1fq38QSYRzl0iCq
         V+AA==
X-Gm-Message-State: APjAAAUNqdBUtnTBv5JBe1FlYDwONwpKnj/IvXv6SEDr5ldcUfe30FW9
        z9BGHffon4Jhq9Bnc55ICb/JVQ==
X-Google-Smtp-Source: APXvYqwpulFbecNjp01FP8m9Fmt8buf91/BlcUGL+RKHuAANAB/LsmPji7yYA7qA/Figg/iEhg1+aw==
X-Received: by 2002:a92:d805:: with SMTP id y5mr677625ilm.194.1578954624253;
        Mon, 13 Jan 2020 14:30:24 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v64sm4256078ila.36.2020.01.13.14.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 14:30:23 -0800 (PST)
Subject: Re: [RFC 0/8] Replacing the readpages a_op
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chris Mason <clm@fb.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
References: <20200113153746.26654-1-willy@infradead.org>
 <6CA4CD96-0812-4261-8FF9-CD28AA2EC38A@fb.com>
 <20200113174008.GB332@bombadil.infradead.org>
 <15C84CC9-3196-441D-94DE-F3FD7AC364F0@fb.com>
 <20200113215811.GA18216@bombadil.infradead.org>
 <910af281-4e2b-3e5d-5533-b5ceafd59665@kernel.dk>
 <20200113221047.GB18216@bombadil.infradead.org>
 <1b94e6b6-29dc-2e90-d1ca-982accd3758c@kernel.dk>
 <20200113222704.GC18216@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <03281e10-fe79-c329-9e8d-231549d86137@kernel.dk>
Date:   Mon, 13 Jan 2020 15:30:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113222704.GC18216@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/13/20 3:27 PM, Matthew Wilcox wrote:
> On Mon, Jan 13, 2020 at 03:14:26PM -0700, Jens Axboe wrote:
>> On 1/13/20 3:10 PM, Matthew Wilcox wrote:
>>> On Mon, Jan 13, 2020 at 03:00:40PM -0700, Jens Axboe wrote:
>>>> On 1/13/20 2:58 PM, Matthew Wilcox wrote:
>>>>> On Mon, Jan 13, 2020 at 06:00:52PM +0000, Chris Mason wrote:
>>>>>> This is true, I didn't explain that part well ;)  Depending on 
>>>>>> compression etc we might end up poking the xarray inside the actual IO 
>>>>>> functions, but the main difference is that btrfs is building a single 
>>>>>> bio.  You're moving the plug so you'll merge into single bio, but I'd 
>>>>>> rather build 2MB bios than merge them.
>>>>>
>>>>> Why don't we store a bio pointer inside the plug?  You're opencoding that,
>>>>> iomap is opencoding that, and I bet there's a dozen other places where
>>>>> we pass a bio around.  Then blk_finish_plug can submit the bio.
>>>>
>>>> Plugs aren't necessarily a bio, they can be callbacks too.
>>>
>>> I'm thinking something as simple as this:
>>
>> It's a little odd imho, the plugging generally collect requests. Sounds
>> what you're looking for is some plug owner private data, which just
>> happens to be a bio in this case?
>>
>> Is this over repeated calls to some IO generating helper? Would it be
>> more efficient if that helper could generate the full bio in one go,
>> instead of piecemeal?
> 
> The issue is around ->readpages.  Take a look at how iomap_readpages
> works, for example.  We're under a plug (taken in mm/readahead.c),
> but we still go through the rigamarole of keeping a pointer to the bio
> in ctx.bio and passing ctx around so that we don't end up with many
> fragments which have to be recombined into a single bio at the end.
> 
> I think what I want is a bio I can reach from current, somehow.  And the
> plug feels like a natural place to keep it because it's basically saying
> "I want to do lots of little IOs and have them combined".  The fact that
> the iomap code has a bio that it precombines fragments into suggests to
> me that the existing antifragmentation code in the plugging mechanism
> isn't good enough.  So let's make it better by storing a bio in the plug
> and then we can get rid of the bio in the iomap code.

But it doesn't fit the plug model very well. If you get preempted, it
could go away. Or if you have nested plugs, it also won't work at all. I
think it's much saner to keep the "current" bio _outside_ of the plug,
and work on it in peace until you want to submit it.

-- 
Jens Axboe

