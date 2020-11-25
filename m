Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A3B2C3D3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 11:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgKYKH5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 05:07:57 -0500
Received: from zaphod.cobb.me.uk ([213.138.97.131]:47704 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgKYKH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:07:56 -0500
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2020 05:07:55 EST
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 0B41C9C41A; Wed, 25 Nov 2020 09:59:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1606298395;
        bh=aAoXnxVR6HKYbDzJbx7GfbomSn0afY3yfgCKsARRCgI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GFH74jyO4lK8DyybHjwNwN35ASWbFAlwI8QLbDl1mMDH3tez+9r9mmhJ7ldBNswB2
         yUyonuYbdNRNatQeUH7s/sFPRKfMnrDl14QitWTD5sy6iDeJGKQOtTAK4duhq3LemO
         +dRSE85yIvHHvr7vhP56k9BW6Y9gW2ajUu3ZUxRQCRDdC7Trp3oRXwJIRFuDtuXNnn
         LECKvbjtHpWY4QtuWoDiC4RNiXZqaFl7TNelr65MdbnBWId0mIz+l++svU/pu3jL0f
         Dt+DnN00XJZ5V+dR8Zw2F86jDeXHudvEZ1N0eKyrHDjHE6GZKjAhyMb48U/cy3Kc9e
         lACv21OrlkcxQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 5FB899B9FE;
        Wed, 25 Nov 2020 09:59:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1606298381;
        bh=aAoXnxVR6HKYbDzJbx7GfbomSn0afY3yfgCKsARRCgI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hfYceWdYKjX2R0k0mk1lMT6uy8dfmuaUdm/4SuQu/h57nW+q5WCXh0er9PjlTYkzc
         poeowSmTlznt4JiyP/7SvzcRcD6gGzo/62XL4x69oaVB39k9dUOXFSMJTzGl+pq/64
         LqzCitKwkErJ7OefpWLpSv0Oi2BJ/fNg0blcq8UEMLnwb3GC5K+dw4ogF4dgdvF5SV
         BhpSJXTnmeDjJnj0OpjKZq5Yn8XRqUAYkGrM1vXM5gVLrbNjld147RqkEzzjAdcPjF
         hj4Da9/p2jcd9U5xSK4xAn2FCpcs/Q35+t+efcQM92JvlBFzEA0lGHmN/KUatfYa2b
         g/YjCx8jy4JHw==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 09FC21A1E24;
        Wed, 25 Nov 2020 09:59:41 +0000 (GMT)
Subject: Re: [PATCH v10 12/41] btrfs: implement zoned chunk allocator
To:     Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <e7896fe18651e3ad12a96ff3ec3255e3127c8239.1605007036.git.naohiro.aota@wdc.com>
 <9cec3af1-4f2c-c94c-1506-07db2c66cc90@oracle.com>
 <20201125015740.conrettvmrgwebus@naota.dhcp.fujisawa.hgst.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <a97ef4b3-4973-1078-8537-5e814a24ef32@cobb.uk.net>
Date:   Wed, 25 Nov 2020 09:59:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201125015740.conrettvmrgwebus@naota.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25/11/2020 01:57, Naohiro Aota wrote:
> On Tue, Nov 24, 2020 at 07:36:18PM +0800, Anand Jain wrote:
>> On 10/11/20 7:26 pm, Naohiro Aota wrote:
>>> This commit implements a zoned chunk/dev_extent allocator. The zoned
>>> allocator aligns the device extents to zone boundaries, so that a zone
>>> reset affects only the device extent and does not change the state of
>>> blocks in the neighbor device extents.
>>>
>>> Also, it checks that a region allocation is not overlapping any of the
>>> super block zones, and ensures the region is empty.
>>>
>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>
>> Looks good.
>>
>> Chunks and stripes are aligned to the zone_size. I guess zone_size won't
>> change after the block device has been formatted with it? For testing,
>> what if the device image is dumped onto another zoned device with a
>> different zone_size?
> 
> Zone size is a drive characteristic, so it never change on the same device.
> 
> Dump/restore on another device with a different zone_size should be banned,
> because we cannot ensure device extents are aligned to zone boundaries.

Does this mean 'btrfs replace' is banned as well? Or is it allowed to a
similar-enough device? What about 'add' followed by 'remove'?
