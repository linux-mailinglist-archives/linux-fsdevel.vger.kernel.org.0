Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33921CB8BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 22:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgEHUAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 16:00:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25097 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726825AbgEHUAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 16:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588968016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XcJYYGDxYUxU0RX7aa3X/KiDcquP9abnqc3PijumMy4=;
        b=EWexSIE2aO/qJx1SPfKm6l9KE3qfqiV9w55SIg2ISa47a0oL2Di2zC3jWsOEOJc8wgDYU8
        jGQemRWpEXolvxdxdNXuXdb0iyqAiQE80CN6qNpOvb8qEt1/IXKoOUCri85xy5ix0TXrGc
        o/cola7kn5gpKdTa1F49Q3gydtF55XU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-L3-e7MSpOJmw5tlWsXZj_Q-1; Fri, 08 May 2020 16:00:11 -0400
X-MC-Unique: L3-e7MSpOJmw5tlWsXZj_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 254501800D42;
        Fri,  8 May 2020 20:00:10 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-83.rdu2.redhat.com [10.10.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26BD61E4;
        Fri,  8 May 2020 20:00:09 +0000 (UTC)
Subject: Re: [PATCH RFC 1/8] dcache: show count of hash buckets in sysctl
 fs.dentry-state
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>
References: <158893941613.200862.4094521350329937435.stgit@buzz>
 <158894059427.200862.341530589978120554.stgit@buzz>
 <7c1cef87-2940-eb17-51d4-cbc40218b770@redhat.com>
 <ac1ece33-46ea-175a-98ef-c79fcd1ced90@yandex-team.ru>
 <741172f7-a0d2-1428-fb25-789e38978d4e@redhat.com>
 <1f137f70-3d37-eb70-2e85-2541e504afbd@yandex-team.ru>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <34ed1b12-1bee-8158-3084-fb1059b6686a@redhat.com>
Date:   Fri, 8 May 2020 16:00:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1f137f70-3d37-eb70-2e85-2541e504afbd@yandex-team.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/8/20 3:38 PM, Konstantin Khlebnikov wrote:
>
>
> On 08/05/2020 22.05, Waiman Long wrote:
>> On 5/8/20 12:16 PM, Konstantin Khlebnikov wrote:
>>> On 08/05/2020 17.49, Waiman Long wrote:
>>>> On 5/8/20 8:23 AM, Konstantin Khlebnikov wrote:
>>>>> Count of buckets is required for estimating average length of hash 
>>>>> chains.
>>>>> Size of hash table depends on memory size and printed once at boot.
>>>>>
>>>>> Let's expose nr_buckets as sixth number in sysctl fs.dentry-state
>>>>
>>>> The hash bucket count is a constant determined at boot time. Is 
>>>> there a need to use up one dentry_stat entry for that? Besides one 
>>>> can get it by looking up the kernel dmesg log like:
>>>>
>>>> [    0.055212] Dentry cache hash table entries: 8388608 (order: 14, 
>>>> 67108864 bytes)
>>>
>>> Grepping logs since boot time is a worst API ever.
>>>
>>> dentry-state shows count of dentries in various states.
>>> It's very convenient to show count of buckets next to it,
>>> because this number defines overall scale. 
>>
>> I am not against using the last free entry for that. My only concern 
>> is when we want to expose another internal dcache data point via 
>> dentry-state, we will have to add one more number to the array which 
>> can cause all sort of compatibility problem. So do we want to use the 
>> last free slot for a constant that can be retrieved from somewhere else?
>
> I see no problem in adding more numbers into sysctl.
> Especially into such rarely used.
> This interface is designed for that.
>
> Also fields 'age_limit' and 'want_pages' are unused since kernel 2.2.0

Well, I got rebuke the last time I want to reuse one of 
age_limit/want_pages entry for negative dentry count because of the 
potential of breaking some really old applications or tools. Changing 
dentry-state to output one more number can potentially break 
compatibility too. That is why I am questioning if it is a good idea to 
use up the last free slot.

Cheers,
Longman


