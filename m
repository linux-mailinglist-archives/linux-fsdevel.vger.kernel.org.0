Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF22429F47A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgJ2TFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31134 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725778AbgJ2TFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603998305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0p3CSFWKBf8bTXWU5gbr4v+f3iD+GqD+deWi2r7Opo=;
        b=Q5y2sd3DD/I9iW3St+mCWTpNx6o9/6C3aVbo4hXJFMn+aFKHHhO7hFh7x/MGwn2l1vDt0E
        oQDvLvevtIMGYN28zahomxXax5jCGikMCP5MUnO/dCYaJ9Iszz06dRxv/tTUVzb0IXjeLT
        pL4Zrd4eyskZZFl1gQRuSZJjZNAPGBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-ZXpHjZW0NkuUgGUJ31IWBw-1; Thu, 29 Oct 2020 15:05:01 -0400
X-MC-Unique: ZXpHjZW0NkuUgGUJ31IWBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EC321009E41;
        Thu, 29 Oct 2020 19:05:00 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-17.rdu2.redhat.com [10.10.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA3836EF68;
        Thu, 29 Oct 2020 19:04:57 +0000 (UTC)
Subject: Re: [PATCH v2] inotify: Increase default inotify.max_user_watches
 limit to 1048576
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Luca BRUNO <lucab@redhat.com>
References: <20201029154535.2074-1-longman@redhat.com>
 <CAOQ4uxjT8rWLr1yCBPGkhJ7Rr6n3+FA7a0GmZaMBHMzk9t1Sag@mail.gmail.com>
 <ccec54cd-cbb5-2808-3800-890cda208967@redhat.com>
 <CAOQ4uximGK1DnM7fYabChp-8pNqt3cSHeDWZYNKSwr6qSnxpug@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4695fee5-3446-7f5b-ae89-dc48d431a8fe@redhat.com>
Date:   Thu, 29 Oct 2020 15:04:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAOQ4uximGK1DnM7fYabChp-8pNqt3cSHeDWZYNKSwr6qSnxpug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/29/20 2:46 PM, Amir Goldstein wrote:
> On Thu, Oct 29, 2020 at 8:05 PM Waiman Long <longman@redhat.com> wrote:
>> On 10/29/20 1:27 PM, Amir Goldstein wrote:
>>> On Thu, Oct 29, 2020 at 5:46 PM Waiman Long <longman@redhat.com> wrote:
>>>> The default value of inotify.max_user_watches sysctl parameter was set
>>>> to 8192 since the introduction of the inotify feature in 2005 by
>>>> commit 0eeca28300df ("[PATCH] inotify"). Today this value is just too
>>>> small for many modern usage. As a result, users have to explicitly set
>>>> it to a larger value to make it work.
>>>>
>>>> After some searching around the web, these are the
>>>> inotify.max_user_watches values used by some projects:
>>>>    - vscode:  524288
>>>>    - dropbox support: 100000
>>>>    - users on stackexchange: 12228
>>>>    - lsyncd user: 2000000
>>>>    - code42 support: 1048576
>>>>    - monodevelop: 16384
>>>>    - tectonic: 524288
>>>>    - openshift origin: 65536
>>>>
>>>> Each watch point adds an inotify_inode_mark structure to an inode to
>>>> be watched. It also pins the watched inode as well as an inotify fdinfo
>>>> procfs file.
>>>>
>>>> Modeled after the epoll.max_user_watches behavior to adjust the default
>>>> value according to the amount of addressable memory available, make
>>>> inotify.max_user_watches behave in a similar way to make it use no more
>>>> than 1% of addressable memory within the range [8192, 1048576].
>>>>
>>>> For 64-bit archs, inotify_inode_mark plus 2 inode have a size close
>>>> to 2 kbytes. That means a system with 196GB or more memory should have
>>>> the maximum value of 1048576 for inotify.max_user_watches. This default
>>>> should be big enough for most use cases.
>>>>
>>>> With my x86-64 config, the size of xfs_inode, proc_inode and
>>>> inotify_inode_mark is 1680 bytes. The estimated INOTIFY_WATCH_COST is
>>>> 1760 bytes.
>>>>
>>>> [v2: increase inotify watch cost as suggested by Amir and Honza]
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>>    fs/notify/inotify/inotify_user.c | 24 +++++++++++++++++++++++-
>>>>    1 file changed, 23 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
>>>> index 186722ba3894..37d9f09c226f 100644
>>>> --- a/fs/notify/inotify/inotify_user.c
>>>> +++ b/fs/notify/inotify/inotify_user.c
>>>> @@ -37,6 +37,16 @@
>>>>
>>>>    #include <asm/ioctls.h>
>>>>
>>>> +/*
>>>> + * An inotify watch requires allocating an inotify_inode_mark structure as
>>>> + * well as pinning the watched inode and adding inotify fdinfo procfs file.
>>> Maybe you misunderstood me.
>>> There is no procfs file per watch.
>>> There is a procfs file per inotify_init() fd.
>>> The fdinfo of that procfile lists all the watches of that inotify instance.
>> Thanks for the clarification. Yes, I probably had misunderstood you
>> because of the 2 * sizeof(inode) figure you provided.
>>>> + * The increase in size of a filesystem inode versus a VFS inode varies
>>>> + * depending on the filesystem. An extra 512 bytes is added as rough
>>>> + * estimate of the additional filesystem inode cost.
>>>> + */
>>>> +#define INOTIFY_WATCH_COST     (sizeof(struct inotify_inode_mark) + \
>>>> +                                2 * sizeof(struct inode) + 512)
>>>> +
>>> I would consider going with double the sizeof inode as rough approximation for
>>> filesystem inode size.
>>>
>>> It is a bit less arbitrary than 512 and it has some rationale behind it -
>>> Some kernel config options will grow struct inode (debug, smp)
>>> The same config options may also grow the filesystem part of the inode.
>>>
>>> And this approximation can be pretty accurate at times.
>>> For example, on Ubuntu 18.04 kernel 5.4.0:
>>> inode_cache        608
>>> nfs_inode_cache      1088
>>> btrfs_inode            1168
>>> xfs_inode              1024
>>> ext4_inode_cache   1096
>> Just to clarify, is your original 2 * sizeof(struct inode) figure
>> include the filesystem inode overhead or there is an additional inode
>> somewhere that I needs to go to 4 * sizeof(struct inode)?
> No additional inode.
>
> #define INOTIFY_WATCH_COST     (sizeof(struct inotify_inode_mark) + \
>                                                        2 * sizeof(struct inode))
>
> Not sure if the inotify_inode_mark part matters, but it doesn't hurt.
> Do note that Jan had a different proposal for fs inode size estimation (1K).
> I have no objection to this estimation if Jan insists.
>
> Thanks,
> Amir.
>
Thanks for the confirmation. 2*sizeof(struct inode) is more than 1k. 
Besides with debugging turned on, the size will increase more. So that 
figure is good enough.

Cheers,
Longman

