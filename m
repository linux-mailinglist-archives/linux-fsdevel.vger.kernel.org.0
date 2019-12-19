Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD7E8126423
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 15:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLSOBm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 09:01:42 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40562 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfLSOBm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:01:42 -0500
Received: by mail-qk1-f193.google.com with SMTP id c17so4676548qkg.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2019 06:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qR4c1dD0XrJAlH3z5XZDFwRfHl5HxkHPVhqaJb/3ohE=;
        b=PTFKlfjhkWZV90/Y6FzfSKlJNuAycHUW7pplH+onH/7fCV18Pom2WJG/4VVZyTABVM
         nMatX4VOQoqI/jCM+2JPX/6epZDrpaF3pAU2yEE7jdXz7b+GnhnU4LgfIXvJgzfBgBeL
         2Q12uo+oPjwaARBqMbkOYwiKL2uLUdtjgvDDTOdxFsFcjTym3kCJlfkcUuUC2VA+hXsH
         mH1jdYPtbpJ9PgF6sNdyd8JkOQ1Vz+D/URpc/eWRbQclVKBlCI48R3w5bK4OlsoonTEm
         g1WbfrqXaBbqqr99dyjDIkYQwEvRiONTtlJboqEo4DDC4IvF53O1CHHq8JvgTqp5WYCs
         +pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qR4c1dD0XrJAlH3z5XZDFwRfHl5HxkHPVhqaJb/3ohE=;
        b=aGURj6u4rpjXxMeeg4SrqRoK+XThyZukB8KTsDUMG/klZlY4cbYNeaim82NTXXOb28
         WEZu+yDhhyNAQJTTg9//NOgSmR5EdowvqDf50IZYsYRoVP6FxvTl+i9UBemnxKb3IxvC
         5887pZ3y8QwJbWl6MwlR90I03Mec+Ck9oaU8LldBgtHL0T/T1Kr37Q6Zjog74rc/1prf
         qo0FFZ30pOhq3Ff7vKO9lBeYGZK73kv7Z6KV5FzL2BMarpG4hMNehZgZaW4SDOh/q+cI
         Jbpj+VDgScFPvlbvmk42iH74jPJj2XiKBg7rYX7JzGlmP3QHWWo2x0IVeZuA8njl1UM1
         HU0w==
X-Gm-Message-State: APjAAAXsGDWZ2Ob/27KGqeokG4xrsl9ohdB0bIIpXT4prCPtRtQvpdgT
        zhhkmQwjZ1IVpp2BeAKiVbYn0wCzjWElBQ==
X-Google-Smtp-Source: APXvYqwoGMA04LgMhVuLQALxe7/1jFTVFw72o+sPwtFOBbkseIDnVzHH5hTS8Von63zR5xpCEN8XrA==
X-Received: by 2002:a37:6287:: with SMTP id w129mr8089623qkb.381.1576764100110;
        Thu, 19 Dec 2019 06:01:40 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d8sm1828954qtr.53.2019.12.19.06.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 06:01:38 -0800 (PST)
Subject: Re: [PATCH v6 15/28] btrfs: serialize data allocation and submit IOs
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-16-naohiro.aota@wdc.com>
 <b11ca55e-adb6-6aa7-4494-cffafedb487f@toxicpanda.com>
 <20191219065457.rhd4wcycylii33c3@naota.dhcp.fujisawa.hgst.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ce94fc27-0167-087e-28f1-17e885ff5ddb@toxicpanda.com>
Date:   Thu, 19 Dec 2019 09:01:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191219065457.rhd4wcycylii33c3@naota.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/19/19 1:54 AM, Naohiro Aota wrote:
> On Tue, Dec 17, 2019 at 02:49:44PM -0500, Josef Bacik wrote:
>> On 12/12/19 11:09 PM, Naohiro Aota wrote:
>>> To preserve sequential write pattern on the drives, we must serialize
>>> allocation and submit_bio. This commit add per-block group mutex
>>> "zone_io_lock" and find_free_extent_zoned() hold the lock. The lock is kept
>>> even after returning from find_free_extent(). It is released when submiting
>>> IOs corresponding to the allocation is completed.
>>>
>>> Implementing such behavior under __extent_writepage_io() is almost
>>> impossible because once pages are unlocked we are not sure when submiting
>>> IOs for an allocated region is finished or not. Instead, this commit add
>>> run_delalloc_hmzoned() to write out non-compressed data IOs at once using
>>> extent_write_locked_rage(). After the write, we can call
>>> btrfs_hmzoned_data_io_unlock() to unlock the block group for new
>>> allocation.
>>>
>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>
>> Have you actually tested these patches with lock debugging on?  The 
>> submit_compressed_extents stuff is async, so the unlocker owner will not be 
>> the lock owner, and that'll make all sorts of things blow up. This is just 
>> straight up broken.
> 
> Yes, I have ran xfstests on this patch series with lockdeps and
> KASAN. There was no problem with that.
> 
> For non-compressed writes, both allocation and submit is done in
> run_delalloc_zoned(). Allocation is done in cow_file_range() and
> submit is done in extent_write_locked_range(), so both are in the same
> context, so both locking and unlocking are done by the same execution
> context.
> 
> For compressed writes, again, allocation/lock is done under
> cow_file_range() and submit is done in extent_write_locked_range() and
> unlocked all in submit_compressed_extents() (this is called after
> compression), so they are all in the same context and the lock owner
> does the unlock.
> 
>> I would really rather see a hmzoned block scheduler that just doesn't submit 
>> the bio's until they are aligned with the WP, that way this intellligence 
>> doesn't have to be dealt with at the file system layer. I get allocating in 
>> line with the WP, but this whole forcing us to allocate and submit the bio in 
>> lock step is just nuts, and broken in your subsequent patches.  This whole 
>> approach needs to be reworked. Thanks,
>>
>> Josef
> 
> We tried this approach by modifying mq-deadline to wait if the first
> queued request is not aligned at the write pointer of a zone. However,
> running btrfs without the allocate+submit lock with this modified IO
> scheduler did not work well at all. With write intensive workloads, we
> observed that a very long wait time was very often necessary to get a
> fully sequential stream of requests starting at the write pointer of a
> zone. The wait time we observed was sometimes in larger than 60 seconds,
> at which point we gave up.

This is because we will only write out the pages we've been handed but do 
cow_file_range() for a possibly larger delalloc range, so as you say there can 
be a large gap in time between writing one part of the range and writing the 
next part.

You actually solve this with your patch, by doing the cow_file_range and then 
following it up with the extent_write_locked_range() for the range you just cow'ed.

There is no need for the locking in this case, you could simply do that and then 
have a modified block scheduler that keeps the bio's in the correct order.  I 
imagine if you just did this with your original block layer approach it would 
work fine.  Thanks,

Josef
