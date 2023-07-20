Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B4675A945
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 10:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjGTI21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 04:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjGTI2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:28:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5312C2686;
        Thu, 20 Jul 2023 01:28:23 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R65N85vy8ztRZ2;
        Thu, 20 Jul 2023 16:25:12 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 16:28:20 +0800
Message-ID: <1e839238-c78d-71e0-28ae-7efff0e04953@huawei.com>
Date:   Thu, 20 Jul 2023 16:28:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 3/4] selinux: use vma_is_initial_stack() and
 vma_is_initial_heap()
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-perf-users@vger.kernel.org>,
        <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
References: <20230719075127.47736-1-wangkefeng.wang@huawei.com>
 <20230719075127.47736-4-wangkefeng.wang@huawei.com>
 <CAJ2a_DfGvPeDuN38UBXD4f2928n9GZpHFgdiPo9MoSAY7YXeOg@mail.gmail.com>
 <dc8223db-b4ac-7bee-6f89-63475a7dcaf8@huawei.com>
 <CAHC9VhQzJ3J0kEymDUn3i+dnP_34GMNRjaCHXc4oddUCFb0Ygw@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAHC9VhQzJ3J0kEymDUn3i+dnP_34GMNRjaCHXc4oddUCFb0Ygw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/19 23:25, Paul Moore wrote:
> On Wed, Jul 19, 2023 at 6:23 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> On 2023/7/19 17:02, Christian Göttsche wrote:
>>> On Wed, 19 Jul 2023 at 09:40, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>>
>>>> Use the helpers to simplify code.
>>>>
>>>> Cc: Paul Moore <paul@paul-moore.com>
>>>> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
>>>> Cc: Eric Paris <eparis@parisplace.org>
>>>> Acked-by: Paul Moore <paul@paul-moore.com>
>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> ---
>>>>    security/selinux/hooks.c | 7 ++-----
>>>>    1 file changed, 2 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>>> index d06e350fedee..ee8575540a8e 100644
>>>> --- a/security/selinux/hooks.c
>>>> +++ b/security/selinux/hooks.c
>>>> @@ -3762,13 +3762,10 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
>>>>           if (default_noexec &&
>>>>               (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
>>>>                   int rc = 0;
>>>> -               if (vma->vm_start >= vma->vm_mm->start_brk &&
>>>> -                   vma->vm_end <= vma->vm_mm->brk) {
>>>> +               if (vma_is_initial_heap(vma)) {
>>>
>>> This seems to change the condition from
>>>
>>>       vma->vm_start >= vma->vm_mm->start_brk && vma->vm_end <= vma->vm_mm->brk
>>>
>>> to
>>>
>>>       vma->vm_start <= vma->vm_mm->brk && vma->vm_end >= vma->vm_mm->start_brk
>>>
>>> (or AND arguments swapped)
>>>
>>>       vma->vm_end >= vma->vm_mm->start_brk && vma->vm_start <= vma->vm_mm->brk
>>>
>>> Is this intended?
>>
>> The new condition is to check whether there is intersection between
>> [startbrk,brk] and [vm_start,vm_end], it contains orignal check, so
>> I think it is ok, but for selinux check, I am not sure if there is
>> some other problem.
> 
> This particular SELinux vma check is see if the vma falls within the
> heap; can you confirm that this change preserves this?

Yes, within is one case of new vma scope check.

> 
