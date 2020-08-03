Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4A123A275
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 12:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgHCKD3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 06:03:29 -0400
Received: from relay.sw.ru ([185.231.240.75]:34516 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbgHCKD2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:03:28 -0400
Received: from [192.168.15.50]
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k2XJ4-0002KM-0N; Mon, 03 Aug 2020 13:02:58 +0300
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to
 expose namespaces lineary
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com
Cc:     davem@davemloft.net, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <87k0yl5axy.fsf@x220.int.ebiederm.org>
 <56928404-f194-4194-5f2a-59acb15b1a04@virtuozzo.com>
 <875za43b3w.fsf@x220.int.ebiederm.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <9ceb5049-6aea-1429-e35f-d86480f10d72@virtuozzo.com>
Date:   Mon, 3 Aug 2020 13:03:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <875za43b3w.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31.07.2020 01:13, Eric W. Biederman wrote:
> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
> 
>> On 30.07.2020 17:34, Eric W. Biederman wrote:
>>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
>>>
>>>> Currently, there is no a way to list or iterate all or subset of namespaces
>>>> in the system. Some namespaces are exposed in /proc/[pid]/ns/ directories,
>>>> but some also may be as open files, which are not attached to a process.
>>>> When a namespace open fd is sent over unix socket and then closed, it is
>>>> impossible to know whether the namespace exists or not.
>>>>
>>>> Also, even if namespace is exposed as attached to a process or as open file,
>>>> iteration over /proc/*/ns/* or /proc/*/fd/* namespaces is not fast, because
>>>> this multiplies at tasks and fds number.
>>>
>>> I am very dubious about this.
>>>
>>> I have been avoiding exactly this kind of interface because it can
>>> create rather fundamental problems with checkpoint restart.
>>
>> restart/restore :)
>>
>>> You do have some filtering and the filtering is not based on current.
>>> Which is good.
>>>
>>> A view that is relative to a user namespace might be ok.    It almost
>>> certainly does better as it's own little filesystem than as an extension
>>> to proc though.
>>>
>>> The big thing we want to ensure is that if you migrate you can restore
>>> everything.  I don't see how you will be able to restore these files
>>> after migration.  Anything like this without having a complete
>>> checkpoint/restore story is a non-starter.
>>
>> There is no difference between files in /proc/namespaces/ directory and /proc/[pid]/ns/.
>>
>> CRIU can restore open files in /proc/[pid]/ns, the same will be with /proc/namespaces/ files.
>> As a person who worked deeply for pid_ns and user_ns support in CRIU, I don't see any
>> problem here.
> 
> An obvious diffference is that you are adding the inode to the inode to
> the file name.  Which means that now you really do have to preserve the
> inode numbers during process migration.
>
> Which means now we have to do all of the work to make inode number
> restoration possible.  Which means now we need to have multiple
> instances of nsfs so that we can restore inode numbers.
> 
> I think this is still possible but we have been delaying figuring out
> how to restore inode numbers long enough that may be actual technical
> problems making it happen.

Yeah, this matters. But it looks like here is not a dead end. We just need
change the names the namespaces are exported to particular fs and to support
rename().

Before introduction a principally new filesystem type for this, can't
this be solved in current /proc?

Alexey, does rename() is prohibited for /proc fs?
 
> Now maybe CRIU can handle the names of the files changing during
> migration but you have just increased the level of difficulty for doing
> that.
> 
>> If you have a specific worries about, let's discuss them.
> 
> I was asking and I am asking that it be described in the patch
> description how a container using this feature can be migrated
> from one machine to another.  This code is so close to being problematic
> that we need be very careful we don't fundamentally break CRIU while
> trying to make it's job simpler and easier.
> 
>> CC: Pavel Tikhomirov CRIU maintainer, who knows everything about namespaces C/R.
>>  
>>> Further by not going through the processes it looks like you are
>>> bypassing the existing permission checks.  Which has the potential
>>> to allow someone to use a namespace who would not be able to otherwise.
>>
>> I agree, and I wrote to Christian, that permissions should be more strict.
>> This just should be formalized. Let's discuss this.
>>
>>> So I think this goes one step too far but I am willing to be persuaded
>>> otherwise.
>>>
> 
> Eric
> 

