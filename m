Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3892AAF63
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 03:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgKICRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 21:17:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729381AbgKICRi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604888256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i30PpoZ3ncDE41feRaeC6jT4a2UBvss9Fqk6sZ2j5No=;
        b=GzrMfroHYbWHCvj7Ei22kO5Jd/iYkUpOuYJA9slizVurhl97UeAD0Ja9wZLBYuTYYZXkOb
        LD9cK0NfKarPO4xOtl7sL8FsA0Ggbbk6mWoeFeJNAYyMtwzYDHdiJD+/8vIeOxBK7h7/2y
        zmDNfTIxkhrjy1ubh+6fVz1+ADPwCRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-8eRDGP6kPiunpNCEztr0-Q-1; Sun, 08 Nov 2020 21:17:34 -0500
X-MC-Unique: 8eRDGP6kPiunpNCEztr0-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88317107464F;
        Mon,  9 Nov 2020 02:17:33 +0000 (UTC)
Received: from llong.remote.csb (ovpn-113-56.rdu2.redhat.com [10.10.113.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C12091002391;
        Mon,  9 Nov 2020 02:17:29 +0000 (UTC)
Subject: Re: [PATCH v3] inotify: Increase default inotify.max_user_watches
 limit to 1048576
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca BRUNO <lucab@redhat.com>
References: <20201029194256.7954-1-longman@redhat.com>
 <20201030105752.GB19757@quack2.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <abca71ed-79c5-7485-3053-6eca0bddc53e@redhat.com>
Date:   Sun, 8 Nov 2020 21:17:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20201030105752.GB19757@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 6:57 AM, Jan Kara wrote:
> On Thu 29-10-20 15:42:56, Waiman Long wrote:
>> The default value of inotify.max_user_watches sysctl parameter was set
>> to 8192 since the introduction of the inotify feature in 2005 by
>> commit 0eeca28300df ("[PATCH] inotify"). Today this value is just too
>> small for many modern usage. As a result, users have to explicitly set
>> it to a larger value to make it work.
>>
>> After some searching around the web, these are the
>> inotify.max_user_watches values used by some projects:
>>   - vscode:  524288
>>   - dropbox support: 100000
>>   - users on stackexchange: 12228
>>   - lsyncd user: 2000000
>>   - code42 support: 1048576
>>   - monodevelop: 16384
>>   - tectonic: 524288
>>   - openshift origin: 65536
>>
>> Each watch point adds an inotify_inode_mark structure to an inode to
>> be watched. It also pins the watched inode.
>>
>> Modeled after the epoll.max_user_watches behavior to adjust the default
>> value according to the amount of addressable memory available, make
>> inotify.max_user_watches behave in a similar way to make it use no more
>> than 1% of addressable memory within the range [8192, 1048576].
>>
>> For 64-bit archs, inotify_inode_mark plus 2 vfs inode have a size that
>> is a bit over 1 kbytes (1284 bytes with my x86-64 config).  That means
>> a system with 128GB or more memory will likely have the maximum value
>> of 1048576 for inotify.max_user_watches. This default should be big
>> enough for most use cases.
>>
>> [v3: increase inotify watch cost as suggested by Amir and Honza]
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Overall this looks fine. Some remaining nits below.
>
>> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
>> index 186722ba3894..f8065eda3a02 100644
>> --- a/fs/notify/inotify/inotify_user.c
>> +++ b/fs/notify/inotify/inotify_user.c
>> @@ -37,6 +37,15 @@
>>   
>>   #include <asm/ioctls.h>
>>   
>> +/*
>> + * An inotify watch requires allocating an inotify_inode_mark structure as
>> + * well as pinning the watched inode. Doubling the size of a VFS inode
>> + * should be more than enough to cover the additional filesystem inode
>> + * size increase.
>> + */
>> +#define INOTIFY_WATCH_COST	(sizeof(struct inotify_inode_mark) + \
>> +				 2 * sizeof(struct inode))
>> +
>>   /* configurable via /proc/sys/fs/inotify/ */
>>   static int inotify_max_queued_events __read_mostly;
>>   
>> @@ -801,6 +810,18 @@ SYSCALL_DEFINE2(inotify_rm_watch, int, fd, __s32, wd)
>>    */
>>   static int __init inotify_user_setup(void)
>>   {
>> +	unsigned int watches_max;
>> +	struct sysinfo si;
>> +
>> +	si_meminfo(&si);
>> +	/*
>> +	 * Allow up to 1% of addressible memory to be allocated for inotify
> 			     ^^^^ addressable
>
>> +	 * watches (per user) limited to the range [8192, 1048576].
>> +	 */
>> +	watches_max = (((si.totalram - si.totalhigh) / 100) << PAGE_SHIFT) /
>> +			INOTIFY_WATCH_COST;
> 			^^^ So for machines with > 1TB of memory
> watches_max would overflow. So you probably need to use ulong for that.
>
>
>> +	watches_max = min(1048576U, max(watches_max, 8192U));
> 			^^^ use clamp() here?

Yes, it will be easier to read to use clamp() here. Will send out v4 
withat those changes.

Thanks,
Longman

