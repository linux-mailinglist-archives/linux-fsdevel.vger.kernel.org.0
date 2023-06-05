Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AB2722561
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 14:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjFEMRK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 08:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjFEMRH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:17:07 -0400
Received: from out-6.mta0.migadu.com (out-6.mta0.migadu.com [91.218.175.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16286E8
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 05:17:00 -0700 (PDT)
Message-ID: <f7139906-3e2c-fa5c-b6ce-f7a8a0b1eefc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685967418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YhVBOZuHIkY3kwdMn7s1Rc/a88j2t62m0s4mkt3wwRQ=;
        b=LSzXQMijVDW3EQzjd0yL9ajDzlWGMdqrsTX4vHGs8tcpBtTANgnzCWIqHs8tvDLd+Z4+fo
        KCDIBwwPPJ42v4rB6vey0w4WvxDA5wWqoUkGhSP4xAXrA9uHo9GonP8fnYAY8yaWwDAnRi
        YG1Rshxg7bAINwqMD6t6x+GcXexK/K8=
Date:   Mon, 5 Jun 2023 20:16:48 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 6/8] xfs: introduce xfs_fs_destroy_super()
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, tkhai@ya.ru
Cc:     Dave Chinner <david@fromorbit.com>, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, vbabka@suse.cz, viro@zeniv.linux.org.uk,
        hughd@google.com, paulmck@kernel.org, muchun.song@linux.dev,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
 <20230531095742.2480623-7-qi.zheng@linux.dev>
 <ZHfc3V4KKmW8QTR2@dread.disaster.area>
 <b85c0d63-f6a5-73c4-e574-163b0b07d80a@linux.dev>
 <ZHkkWjt0R1ptV7RZ@dread.disaster.area>
 <2f34a702-1a57-06a5-1bd9-de54a67a839e@linux.dev>
 <20230602151532.GP16865@frogsfrogsfrogs>
 <20230605-halbtags-gesplittet-c482c62cb2c9@brauner>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20230605-halbtags-gesplittet-c482c62cb2c9@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/6/5 19:50, Christian Brauner wrote:
> On Fri, Jun 02, 2023 at 08:15:32AM -0700, Darrick J. Wong wrote:
>> On Fri, Jun 02, 2023 at 11:13:09AM +0800, Qi Zheng wrote:
>>> Hi Dave,
>>>
>>> On 2023/6/2 07:06, Dave Chinner wrote:
>>>> On Thu, Jun 01, 2023 at 04:43:32PM +0800, Qi Zheng wrote:
>>>>> Hi Dave,
>>>>> On 2023/6/1 07:48, Dave Chinner wrote:
>>>>>> On Wed, May 31, 2023 at 09:57:40AM +0000, Qi Zheng wrote:
>>>>>>> From: Kirill Tkhai <tkhai@ya.ru>
>>>>>> I don't really like this ->destroy_super() callback, especially as
>>>>>> it's completely undocumented as to why it exists. This is purely a
>>>>>> work-around for handling extended filesystem superblock shrinker
>>>>>> functionality, yet there's nothing that tells the reader this.
>>>>>>
>>>>>> It also seems to imply that the superblock shrinker can continue to
>>>>>> run after the existing unregister_shrinker() call before ->kill_sb()
>>>>>> is called. This violates the assumption made in filesystems that the
>>>>>> superblock shrinkers have been stopped and will never run again
>>>>>> before ->kill_sb() is called. Hence ->kill_sb() implementations
>>>>>> assume there is nothing else accessing filesystem owned structures
>>>>>> and it can tear down internal structures safely.
>>>>>>
>>>>>> Realistically, the days of XFS using this superblock shrinker
>>>>>> extension are numbered. We've got a lot of the infrastructure we
>>>>>> need in place to get rid of the background inode reclaim
>>>>>> infrastructure that requires this shrinker extension, and it's on my
>>>>>> list of things that need to be addressed in the near future.
>>>>>>
>>>>>> In fact, now that I look at it, I think the shmem usage of this
>>>>>> superblock shrinker interface is broken - it returns SHRINK_STOP to
>>>>>> ->free_cached_objects(), but the only valid return value is the
>>>>>> number of objects freed (i.e. 0 is nothing freed). These special
>>>>>> superblock extension interfaces do not work like a normal
>>>>>> shrinker....
>>>>>>
>>>>>> Hence I think the shmem usage should be replaced with an separate
>>>>>> internal shmem shrinker that is managed by the filesystem itself
>>>>>> (similar to how XFS has multiple internal shrinkers).
>>>>>>
>>>>>> At this point, then the only user of this interface is (again) XFS.
>>>>>> Given this, adding new VFS methods for a single filesystem
>>>>>> for functionality that is planned to be removed is probably not the
>>>>>> best approach to solving the problem.
>>>>>
>>>>> Thanks for such a detailed analysis. Kirill Tkhai just proposeed a
>>>>> new method[1], I cc'd you on the email.
>>>>
>>>> I;ve just read through that thread, and I've looked at the original
>>>> patch that caused the regression.
>>>>
>>>> I'm a bit annoyed right now. Nobody cc'd me on the original patches
>>>> nor were any of the subsystems that use shrinkers were cc'd on the
>>>> patches that changed shrinker behaviour. I only find out about this
>>>
>>> Sorry about that, my mistake. I followed the results of
>>> scripts/get_maintainer.pl before.
>>
>> Sometimes I wonder if people who contribute a lot to a subsystem should
>> be more aggressive about listing themselves explicitly in MAINTAINERS
>> but then I look at the ~600 emails that came in while I was on vacation
>> for 6 days over a long weekend and ... shut up. :P
>>
>>>> because someone tries to fix something they broke by *breaking more
>>>> stuff* and not even realising how broken what they are proposing is.
>>>
>>> Yes, this slows down the speed of umount. But the benefit is that
>>> slab shrink becomes lockless, the mount operation and slab shrink no
>>> longer affect each other, and the IPC no longer drops significantly,
>>> etc.
>>
>> The lockless shrink seems like a good thing to have, but ... is it
>> really true that the superblock shrinker can still be running after
>> ->kill_sb?  /That/ is surprising to me.
> 
> So what's the plan here? If this causes issues for filesystems that rely
> on specific guarantees that are broken by the patch then either it needs
> a clean fix or a revert.

If the reduction in umount speed is really unacceptable, I think we can
try the patch[1] from Kirill Tkhai. At least the granularity of the
shrinker rwsem lock is reduced, and the file system code does not need
to be modified.

And IIUC, after clearing SHRINKER_REGISTERED under the write lock of
shrinker->rwsem, we can guarantee that the shrinker won't be running.
So synchronize_srcu() doesn't need to be called in unregister_shrinker()
anymore. So we don't need to split unregister_shrinker().

[1]. 
https://lore.kernel.org/lkml/bab60fe4-964c-43a6-ecce-4cbd4981d875@ya.ru/

> 
>>
>> --D
>>
>>> And I used bpftrace to measure the time consumption of
>>> unregister_shrinker():
>>>
>>> ```
>>> And I just tested it on a physical machine (Intel(R) Xeon(R) Platinum
>>> 8260 CPU @ 2.40GHz) and the results are as follows:
>>>
>>> 1) use synchronize_srcu():
>>>
>>> @ns[umount]:
>>> [8K, 16K)             83 |@@@@@@@       |
>>> [16K, 32K)           578
>>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>>> [32K, 64K)            78 |@@@@@@@       |
>>> [64K, 128K)            6 |       |
>>> [128K, 256K)           7 |       |
>>> [256K, 512K)          29 |@@       |
>>> [512K, 1M)            51 |@@@@      |
>>> [1M, 2M)              90 |@@@@@@@@       |
>>> [2M, 4M)              70 |@@@@@@      |
>>> [4M, 8M)               8 |      |
>>>
>>> 2) use synchronize_srcu_expedited():
>>>
>>> @ns[umount]:
>>> [8K, 16K)             31 |@@       |
>>> [16K, 32K)           803
>>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>>> [32K, 64K)           158 |@@@@@@@@@@       |
>>> [64K, 128K)            4 |       |
>>> [128K, 256K)           2 |       |
>>> [256K, 512K)           2 |       |
>>> ```
>>>
>>> With synchronize_srcu(), most of the time consumption is between 16us and
>>> 32us, the worst case between 4ms and 8ms. Is this totally
>>> unacceptable?
>>>
>>> This performance regression report comes from a stress test. Will the
>>> umount action be executed so frequently under real workloads?
>>>
>>> If there are really unacceptable, after applying the newly proposed
>>> method, umount will be as fast as before (or even faster).
>>>
>>> Thanks,
>>> Qi
>>>
>>>>
>>>> The previous code was not broken and it provided specific guarantees
>>>> to subsystems via unregister_shrinker(). From the above discussion,
>>>> it appears that the original authors of these changes either did not
>>>> know about or did not understand them, so that casts doubt in my
>>>> mind about the attempted solution and all the proposed fixes for it.
>>>>
>>>> I don't have the time right now unravel this mess and fully
>>>> understand the original problem, changes or the band-aids that are
>>>> being thrown around. We are also getting quite late in the cycle to
>>>> be doing major surgery to critical infrastructure, especially as it
>>>> gives so little time to review regression test whatever new solution
>>>> is proposed.
>>>>
>>>> Given this appears to be a change introduced in 6.4-rc1, I think the
>>>> right thing to do is to revert the change rather than make things
>>>> worse by trying to shove some "quick fix" into the kernel to address
>>>> it.
>>>>
>>>> Andrew, could you please sort out a series to revert this shrinker
>>>> infrastructure change and all the dependent hacks that have been
>>>> added to try to fix it so far?
>>>>
>>>> -Dave.
>>>
>>> -- 
>>> Thanks,
>>> Qi
