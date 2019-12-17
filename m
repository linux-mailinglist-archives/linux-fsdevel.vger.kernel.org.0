Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD1812357B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 20:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfLQTRH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 14:17:07 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36163 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfLQTRG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:17:06 -0500
Received: by mail-qk1-f196.google.com with SMTP id a203so8206876qkc.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 11:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hqEF2LmTWAr1MFcHmn2i1Ao0BiMv0XhsvylrrknmxMc=;
        b=GedxR/UG6x4tRa1Cu4ic5GRiWwVzcuT6JO/pxeNORgvKvTewYapuX95IcZMJltPJbj
         NKb7i43Rdm86kc4uKuJKWZM5Tui7Y4x25dZ1EH95ZpU/OYcBV4PiXHHkMFYwDXml8WkT
         2mkLp8zHypIi3MnjBxzK3Q+ms/KDsIX44J08EkbZMxw/ikqGr/BfAXsLqd6Y896gfv4d
         tZ7lhAGdcjFqtpMHlFgZpqAKx/BrNZ/Citu2CJunbymQ3JROJQi40kJUiX2G5tNPUAP8
         XCLfJSEVjMyBbeYzB9fDwXIB3syfrKR+/5OgaZzJdcjyV+ZKgbVcF/mgBaX3+LuYhXi1
         bGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hqEF2LmTWAr1MFcHmn2i1Ao0BiMv0XhsvylrrknmxMc=;
        b=S/k4kGDdmLO8Pvg/XQOLcCuFG6sfS9BVfR8eXz5/qyBonrfkFELW/2ZZsPOn2lwCoU
         XLdL4etarvbJLzudAYYEIdvQFNKILK4kLfelbETiU7puLoBQnE4CSTfXTaM7prmwjHJM
         n317VKQrps5k4g1WY/N2aG9HrxAlGX+a+FMReDvvBLZLKTGGBjh+AuD9GwEChiVkYGYB
         WgWSJ8Px0LoSnJTGuGxFceP9clAOqVT6v7CHZwazxuyoscZcBDaMnysd6JYq1QlDa3uY
         t/PJCJy+dSn5zfPRwIbQED5T0R+kb3+BpEEAft9RlVTEOXSHxCTeBpzaRyu53RyJLPsM
         0L8Q==
X-Gm-Message-State: APjAAAUavGgOxXhPSRlvFkhEZuvFa4Rgd95qUpcomdW03XMdw+fhkDuE
        kdsS/33Bnbkx0wwx7q9EE2KCI/GtnDP+fA==
X-Google-Smtp-Source: APXvYqxY16VeZ03LS9+r0bxZvNF71hQH0KG7416YzQOkoDuEakeZsJtTL389/w+LsTi4acjGkRIE7A==
X-Received: by 2002:a05:620a:1fa:: with SMTP id x26mr6739573qkn.311.1576610224944;
        Tue, 17 Dec 2019 11:17:04 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4217])
        by smtp.gmail.com with ESMTPSA id r10sm7316680qkm.23.2019.12.17.11.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:17:04 -0800 (PST)
Subject: Re: [PATCH v6 08/28] btrfs: implement log-structured superblock for
 HMZONED mode
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-9-naohiro.aota@wdc.com>
 <e5bdec6e-a38e-7789-922f-5998b4401d02@toxicpanda.com>
 <BYAPR04MB5816552C67964D6415A3FF70E7540@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <19b0d6a4-1ac6-9a63-0e14-6fef1a68e5ec@toxicpanda.com>
Date:   Tue, 17 Dec 2019 14:17:02 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816552C67964D6415A3FF70E7540@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/13/19 4:58 PM, Damien Le Moal wrote:
> Josef,
> 
> On 2019/12/14 1:39, Josef Bacik wrote:
>> On 12/12/19 11:08 PM, Naohiro Aota wrote:
>>> Superblock (and its copies) is the only data structure in btrfs which has a
>>> fixed location on a device. Since we cannot overwrite in a sequential write
>>> required zone, we cannot place superblock in the zone. One easy solution is
>>> limiting superblock and copies to be placed only in conventional zones.
>>> However, this method has two downsides: one is reduced number of superblock
>>> copies. The location of the second copy of superblock is 256GB, which is in
>>> a sequential write required zone on typical devices in the market today.
>>> So, the number of superblock and copies is limited to be two.  Second
>>> downside is that we cannot support devices which have no conventional zones
>>> at all.
>>>
>>> To solve these two problems, we employ superblock log writing. It uses two
>>> zones as a circular buffer to write updated superblocks. Once the first
>>> zone is filled up, start writing into the second buffer and reset the first
>>> one. We can determine the postion of the latest superblock by reading write
>>> pointer information from a device.
>>>
>>> The following zones are reserved as the circular buffer on HMZONED btrfs.
>>>
>>> - The primary superblock: zones 0 and 1
>>> - The first copy: zones 16 and 17
>>> - The second copy: zones 1024 or zone at 256GB which is minimum, and next
>>>     to it
>>>
>>
>> So the series of events for writing is
>>
>> -> get wp
>> -> write super block
>> -> advance wp
>>     -> if wp == end of the zone, reset the wp
> 
> In your example, the reset is for the other zone, leaving the zone that
> was just filled as is. The sequence would in fact be more like this for
> zones 0 & 1:
> 
> -> Get wp zone 0, if zone is full, reset it
> -> write super block in zone 0
> -> advance wp zone 0. If zone is full, switch to zone 1 for next update
> 
> This would come after the sequence:
> -> Get wp zone 1
> -> write super block in zone 1
> -> advance wp zone 1. If zone is full, switch to zone 0 for next update
> 

Ah ok I missed that.  Alright you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

To this one, thanks,

Josef
