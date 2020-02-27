Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58F85171130
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 07:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgB0G7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 01:59:46 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:33030 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726575AbgB0G7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 01:59:46 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id CF1532E15F8;
        Thu, 27 Feb 2020 09:59:41 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id cydo0sNlfQ-xeOKmSoa;
        Thu, 27 Feb 2020 09:59:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1582786781; bh=LwWjZiS5EzXEz+bSSOqPaeyqH6VUxngb/TfuxMV5n4s=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=MQx13QXIYnIgGnoIddsDtjWXj5iwUdpAoMGhZ9JO/GzvdsHSpbM6VrS4LWai5sple
         PkJxDiDaM7iG3Xoz/aXydRRT5eA+J70ZEK3iujiCyky9qKcsdjTOY+aeEsax0kC8G9
         IJ6L4a2sRvi7aH+lDVR8Hw6nRMQRdGKB7GxfSic0=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 4wLRz4WkJW-xeVm1Z4H;
        Thu, 27 Feb 2020 09:59:40 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC 5/5] ext4: Add fallocate2() support
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     tytso@mit.edu, viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        snitzer@redhat.com, jack@suse.cz, ebiggers@google.com,
        riteshh@linux.ibm.com, krisman@collabora.com, surajjs@amazon.com,
        dmonakhov@gmail.com, mbobrowski@mbobrowski.org, enwlinux@gmail.com,
        sblbir@amazon.com, khazhy@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <158272447616.281342.14858371265376818660.stgit@localhost.localdomain>
 <20200226155521.GA24724@infradead.org>
 <06f9b82c-a519-7053-ec68-a549e02c6f6c@virtuozzo.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <19bddb89-c3c4-0f38-dca3-70164dc81a57@yandex-team.ru>
Date:   Thu, 27 Feb 2020 09:59:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <06f9b82c-a519-7053-ec68-a549e02c6f6c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26/02/2020 23.05, Kirill Tkhai wrote:
> On 26.02.2020 18:55, Christoph Hellwig wrote:
>> On Wed, Feb 26, 2020 at 04:41:16PM +0300, Kirill Tkhai wrote:
>>> This adds a support of physical hint for fallocate2() syscall.
>>> In case of @physical argument is set for ext4_fallocate(),
>>> we try to allocate blocks only from [@phisical, @physical + len]
>>> range, while other blocks are not used.
>>
>> Sorry, but this is a complete bullshit interface.  Userspace has
>> absolutely no business even thinking of physical placement.  If you
>> want to align allocations to physical block granularity boundaries
>> that is the file systems job, not the applications job.
> 
> Why? There are two contradictory actions that filesystem can't do at the same time:
> 
> 1)place files on a distance from each other to minimize number of extents
>    on possible future growth;
> 2)place small files in the same big block of block device.
> 
> At initial allocation time you never know, which file will stop grow in some future,
> i.e. which file is suitable for compaction. This knowledge becomes available some time later.
> Say, if a file has not been changed for a month, it is suitable for compaction with
> another files like it.
> 
> If at allocation time you can determine a file, which won't grow in the future, don't be afraid,
> and just share your algorithm here.
> 
> In Virtuozzo we tried to compact ext4 with existing kernel interface:
> 
> https://github.com/dmonakhov/e2fsprogs/blob/e4defrag2/misc/e4defrag2.c
> 
> But it does not work well in many situations, and the main problem is blocks allocation
> in desired place is not possible. Block allocator can't behave excellent for everything.
> 
> If this interface bad, can you suggest another interface to make block allocator to know
> the behavior expected from him in this specific case?

Controlling exact place is odd. I suppose main reason for this that defragmentation
process wants to control fragmentation during allocating new space.

Maybe flag FALLOC_FL_DONT_FRAGMENT (allocate exactly one extent or fail) could solve that problem?

Defragmentator could try allocate different sizes and automatically balance fragmentation factor
without controlling exact disk offsets. Also it could reserve space for expected file growth.
