Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E24F5124A67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 15:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfLROyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 09:54:50 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39841 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfLROyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:54:49 -0500
Received: by mail-qk1-f196.google.com with SMTP id c16so1761724qko.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EkeXzVcGFTYw2aKgHC5XgIAT2OnHUHtvGugS3Qvhf/k=;
        b=KrldYorIusjivBBDjyIIrzRr9ZfJRWJcOt2FNnf48Z6vNeUsRIl/w+JqH9Sic4VLgn
         ihXe/GY7IPSspuTsItXY7oZXgOulPW2s0dpkrgeEHcJKN1nMaztWC/+FYg78HVfDotIt
         wmN6CCzYxXxkWg1loPgpd+n+7qPSBhwnHqsvdy26srsnt4FQcuyVgb6EwT6sl2CIrk7q
         seAozkDwejhPAl65Br1qsMhshHvNYwL/yQsAgJf6DQwqlfrTJ6ImVUxDD30em6tWG8XM
         P+wh7ycPgAe57HxS+iMadW1jfjhqYOZJD0EH2MAhqU3+B40BzfomTOMc1NvrRH9mTtTL
         m9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EkeXzVcGFTYw2aKgHC5XgIAT2OnHUHtvGugS3Qvhf/k=;
        b=Hm2lgZ67KOIyo0G1BJAY7MODZ9g1rY9xofWxpeMgEbHvYFBbsi5is0rZ616ynUfdy0
         leXbmR6TfhgS5U2eGc9kdPLsrYQgyY2V0okVAWWhlmMIlVScVx2ABIshGhhn//I9ewk2
         jV+dEii+TRM44tDbnmLQDPfLumiXX0yvaVJEzxSIaG9arWod3xZ20pp3ef61M/QWmQV7
         9jQllgRn2PJxL23z4ighQz058eWK2spBuTULEI392bTcbA4qzJGOyaXq/FGOiccwJ4Li
         XtWK4/+7hPaSloFRsuxSp/dJJlwnUN2v0WMRS9iRH1HvPFTCju8z2Vt1IYP1WOeLWIMA
         ooFw==
X-Gm-Message-State: APjAAAXaifrZGi0KC5uUZV6EbXEkyvDJ+UCar0usAjV6Z+Ly0Mqvi0u0
        gLc6tOi97gtMh9EmYZRdW+pGsQ/7N3zgYw==
X-Google-Smtp-Source: APXvYqxteD2/pVJLzAd5udrr7rxqmqc8H8goZfYzxi1C2gtGTKT67uJLLNL+/R9X28zWz/EZOu9jOw==
X-Received: by 2002:a05:620a:1136:: with SMTP id p22mr2971128qkk.8.1576680888024;
        Wed, 18 Dec 2019 06:54:48 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c13sm704834qko.87.2019.12.18.06.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 06:54:47 -0800 (PST)
Subject: Re: [PATCH v6 11/28] btrfs: make unmirroed BGs readonly only if we
 have at least one writable BG
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-12-naohiro.aota@wdc.com>
 <78769962-9094-3afc-f791-1b35030c67dc@toxicpanda.com>
 <20191218073518.zqtzfdgz7ctwlicn@naota.dhcp.fujisawa.hgst.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2a3a7692-e488-0985-28eb-f782322908f8@toxicpanda.com>
Date:   Wed, 18 Dec 2019 09:54:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191218073518.zqtzfdgz7ctwlicn@naota.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/18/19 2:35 AM, Naohiro Aota wrote:
> On Tue, Dec 17, 2019 at 02:25:37PM -0500, Josef Bacik wrote:
>> On 12/12/19 11:08 PM, Naohiro Aota wrote:
>>> If the btrfs volume has mirrored block groups, it unconditionally makes
>>> un-mirrored block groups read only. When we have mirrored block groups, but
>>> don't have writable block groups, this will drop all writable block groups.
>>> So, check if we have at least one writable mirrored block group before
>>> setting un-mirrored block groups read only.
>>>
>>> This change is necessary to handle e.g. xfstests btrfs/124 case.
>>>
>>> When we mount degraded RAID1 FS and write to it, and then re-mount with
>>> full device, the write pointers of corresponding zones of written block
>>> group differ. We mark such block group as "wp_broken" and make it read
>>> only. In this situation, we only have read only RAID1 block groups because
>>> of "wp_broken" and un-mirrored block groups are also marked read only,
>>> because we have RAID1 block groups. As a result, all the block groups are
>>> now read only, so that we cannot even start the rebalance to fix the
>>> situation.
>>
>> I'm not sure I understand.  In degraded mode we're writing to just one mirror 
>> of a RAID1 block group, correct?  And this messes up the WP for the broken 
>> side, so it gets marked with wp_broken and thus RO.  How does this patch 
>> help?  The block groups are still marked RAID1 right? Or are new block groups 
>> allocated with SINGLE or RAID0?  I'm confused. Thanks,
>>
>> Josef
> 
> First of all, I found that some recent change (maybe commit
> 112974d4067b ("btrfs: volumes: Remove ENOSPC-prone
> btrfs_can_relocate()")?) solved the issue, so we no longer need patch
> 11 and 12. So, I will drop these two in the next version.
> 
> So, I think you may already have no interest on the answer, but just
> for a note... The situation was like this:
> 
> * before degrading
>    - All block groups are RAID1, working fine.
> 
> * degraded mount
>    - Block groups allocated before degrading are RAID1. Writes goes
>      into RAID1 block group and break the write pointer.
>    - Newly allocated block groups are SINGLE, since we only have one
>      available device.
> 
> * mount with the both drive again
>    - RAID1 block groups are markd RO because of broken write pointer
>    - SINGLE block groups are also marked RO because we have RAID1 block
>      groups
> 
> and at this point, btrfs was somehow unable to allocate new block
> group or to start blancing.

Oooh ok I see, I had it in my head we would still allocate RAID1 chunks, but we 
allocate SINGLE, so that makes sense.  Go ahead and drop those patches, and 
thanks for the explanation.

Josef
