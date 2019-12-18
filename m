Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 289EA124A7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 15:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLRO6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 09:58:11 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34736 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfLRO6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:58:11 -0500
Received: by mail-qt1-f195.google.com with SMTP id 5so2174049qtz.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 06:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7me7J7sKczgizgQK29nWZIo2pltkRAZWuA71/GjVg3I=;
        b=cwN2S8P2SpCsdT7CE/EAu6UYqFCSpI7RM/GMkmR7x5qHJ/hnrNvhyJTs2/ZBWjhAIN
         iRcW/PIt24w9aNqvSV0Rq/5AIK4HEsjz54EsYV6xEul3axz4XqTCkL2a/VZ5jZCA1XQ7
         rRS/gMqAs+KJuMLKy2SUUZJxe1IBrFDgeSewKx9VptZOCaoi/q6sTPUU8RgdDf/OEKrd
         75wOpbFeCaTn+kx2rxZ12r4gZAE/MASb0akziYhOJ26kGaSzY6EziO4T4TsY5IAFQaB9
         gneyD8vzbeuQsSPe6PaR9Nk8UGUEl5hmno5cmEAEdf7jcp72kXlIXEyD9FAEZsvFbvJN
         WCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7me7J7sKczgizgQK29nWZIo2pltkRAZWuA71/GjVg3I=;
        b=LuZibVga3H4P1/hev/gnFW39EEoMvEXw4EHRm3OxFwJE2RDLnAFjVHFq4e401l76rr
         JMGdbyWiTx6f2+7OEpyc0Zv9LgQLUI1BErpSNv/8xGzEgVfUYxZd8gSy1SeLvQQkDzT0
         X8MUPi6XI7Li9rjDx9DJBMK5CMbjFW+8sDtNTlfwp+nsIcUzfdmd1O3sYrUVyEwLkt7a
         8nCBoKkKn8KEzD/jgGF+UvXyBOITGRF/YxydEoIfdqTbFcmsQdPRrhdJceAKGummRhPf
         E6IS96QR91DDzaGjaJk6DCTiQzhNTxfRd71HsHG+mft3xXa+X5scX/6v05Z2Twi1vPnG
         NVNw==
X-Gm-Message-State: APjAAAWFXYQBJEN9XgdVxl90Jlnyk0ssecyATd9COmjPRBJg0y4NQ1KX
        7cSb2JkqRRkKjnDoN7UEQ1MCEK83LEJ/9A==
X-Google-Smtp-Source: APXvYqw/dc12PAr/N2b/xbYEM+sjKCZBK09ETWuxZeLQuKzzQeZSn0gA6i1V+EN2NuE2BPomKgdVnA==
X-Received: by 2002:ac8:86b:: with SMTP id x40mr2539800qth.366.1576681089494;
        Wed, 18 Dec 2019 06:58:09 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s26sm718638qkj.24.2019.12.18.06.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 06:58:08 -0800 (PST)
Subject: Re: [PATCH v6 23/28] btrfs: support dev-replace in HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-24-naohiro.aota@wdc.com>
 <2157b1bb-a64b-eed3-0451-09a8480d0db2@toxicpanda.com>
 <20191218060033.ubfidtuhvzdbkk3o@naota.dhcp.fujisawa.hgst.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d8514c65-08f8-ac50-959a-42e980aea3f4@toxicpanda.com>
Date:   Wed, 18 Dec 2019 09:58:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191218060033.ubfidtuhvzdbkk3o@naota.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/18/19 1:00 AM, Naohiro Aota wrote:
> On Tue, Dec 17, 2019 at 04:05:25PM -0500, Josef Bacik wrote:
>> On 12/12/19 11:09 PM, Naohiro Aota wrote:
>>> We have two type of I/Os during the device-replace process. One is a I/O to
>>> "copy" (by the scrub functions) all the device extents on the source device
>>> to the destination device.  The other one is a I/O to "clone" (by
>>> handle_ops_on_dev_replace()) new incoming write I/Os from users to the
>>> source device into the target device.
>>>
>>> Cloning incoming I/Os can break the sequential write rule in the target
>>> device. When write is mapped in the middle of a block group, that I/O is
>>> directed in the middle of a zone of target device, which breaks the
>>> sequential write rule.
>>>
>>> However, the cloning function cannot be simply disabled since incoming I/Os
>>> targeting already copied device extents must be cloned so that the I/O is
>>> executed on the target device.
>>>
>>> We cannot use dev_replace->cursor_{left,right} to determine whether bio is
>>> going to not yet copied region.  Since we have time gap between finishing
>>> btrfs_scrub_dev() and rewriting the mapping tree in
>>> btrfs_dev_replace_finishing(), we can have newly allocated device extent
>>> which is never cloned nor copied.
>>>
>>> So the point is to copy only already existing device extents. This patch
>>> introduces mark_block_group_to_copy() to mark existing block group as a
>>> target of copying. Then, handle_ops_on_dev_replace() and dev-replace can
>>> check the flag to do their job.
>>>
>>> Device-replace process in HMZONED mode must copy or clone all the extents
>>> in the source device exctly once.  So, we need to use to ensure allocations
>>> started just before the dev-replace process to have their corresponding
>>> extent information in the B-trees. finish_extent_writes_for_hmzoned()
>>> implements that functionality, which basically is the removed code in the
>>> commit 042528f8d840 ("Btrfs: fix block group remaining RO forever after
>>> error during device replace").
>>>
>>> This patch also handles empty region between used extents. Since
>>> dev-replace is smart to copy only used extents on source device, we have to
>>> fill the gap to honor the sequential write rule in the target device.
>>>
>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>
>> Can you split up the copying part and the cloning part into different patches, 
>> this is a bear to review.  Also I don't quite understand the zeroout behavior. 
>> It _looks_ like for cloning you are doing a zeroout for the gap between the 
>> last wp position and the current cloned bio, which makes sense, but doesn't 
>> this gap exist because copying is ongoing?  Can you copy into a zero'ed out 
>> position?  Or am I missing something here?  Thanks,
>>
>> Josef
> 
> OK, I will split this in the next version. (but, it's mostly "copying"
> part)
> 
> Let me clarify first that I am using "copying" for copying existing
> extents to the new device and "cloning" for cloning a new incoming BIO
> to the new device.
> 
> For zeroout, it is for "copying" which is done with the scrub code to
> copy existing extents on the source devie to the destination
> device. Since copying or scrub only scans for living extents, there
> can be a gap between two living extents. So, we need to fill a gap
> with zeroout to make the writing stream sequential.
> 
> And "cloning" is only done for new block groups or already fully
> copied block groups. So there is no gaps for them because the
> allocator and the IO locks ensures the sequential allocation and
> submit.
> 

Got it, thanks.  It looked like the cloning part was using the zeroout behavior 
which was what was confusing me.

Josef
