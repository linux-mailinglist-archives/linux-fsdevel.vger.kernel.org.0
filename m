Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8E5302082
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 03:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbhAYClO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jan 2021 21:41:14 -0500
Received: from relay.corp-email.com ([222.73.234.233]:18759 "EHLO
        relay.corp-email.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbhAYClL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jan 2021 21:41:11 -0500
Received: from ([183.47.25.45])
        by relay.corp-email.com ((LNX1044)) with ASMTP (SSL) id STM00155;
        Mon, 25 Jan 2021 10:39:55 +0800
Received: from GCY-EXS-15.TCL.com (10.74.128.165) by GCY-EXS-06.TCL.com
 (10.74.128.156) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 25 Jan
 2021 10:39:54 +0800
Received: from [172.16.34.11] (172.16.34.11) by GCY-EXS-15.TCL.com
 (10.74.128.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 25 Jan
 2021 10:39:53 +0800
Subject: Re: [PATCH RESEND V11 0/7] fuse: Add support for passthrough
 read/write
To:     Alessio Balsini <balsini@android.com>
CC:     <akailash@google.com>, <amir73il@gmail.com>, <axboe@kernel.dk>,
        <bergwolf@gmail.com>, <duostefano93@gmail.com>,
        <dvander@google.com>, <fuse-devel@lists.sourceforge.net>,
        <gscrivan@redhat.com>, <jannh@google.com>,
        <kernel-team@android.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <maco@android.com>,
        <miklos@szeredi.hu>, <palmer@dabbelt.com>,
        <paullawrence@google.com>, <trapexit@spawn.link>,
        <zezeozue@google.com>
References: <c1b6b083339536dd79e7f8e0e9596ef9@sslemail.net>
 <YAqxsWpH54moi+t6@google.com>
From:   "wu-yan@tcl.com" <wu-yan@tcl.com>
Message-ID: <f8badd23-1468-8d8c-8431-4db0c23232d0@tcl.com>
Date:   Mon, 25 Jan 2021 10:39:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YAqxsWpH54moi+t6@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.34.11]
X-ClientProxiedBy: GCY-EXS-04.TCL.com (10.74.128.154) To GCY-EXS-15.TCL.com
 (10.74.128.165)
tUid:   20211251039550fc344f5981a91c859305db0b63c51bd
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/22/21 7:06 PM, Alessio Balsini wrote:
> On Tue, Jan 19, 2021 at 12:34:23PM +0000, Alessio Balsini wrote:
>> On Tue, Jan 19, 2021 at 07:06:54PM +0800, Rokudo Yan wrote:
>>> on Mon, Jan 18, 2021 at 5:27 PM Alessio Balsini <balsini@android.com> wrote:
>>>>
>>>> This is the 11th version of the series, rebased on top of v5.11-rc4.
>>>> Please find the changelog at the bottom of this cover letter.
>>>>
>>>> Add support for file system passthrough read/write of files when enabled
>>>> in userspace through the option FUSE_PASSTHROUGH.
>>> [...]
>>>
>>>
>>> Hi Allesio,
>>>
>>> Could you please add support for passthrough mmap too ?
>>> If the fuse file opened with passthrough actived, and then map (shared) to (another) process
>>> address space using mmap interface. As access the file with mmap will pass the vfs cache of fuse,
>>> but access the file with read/write will bypass the vfs cache of fuse, this may cause inconsistency.
>>> eg. the reader read the fuse file with mmap() and the writer modify the file with write(), the reader
>>> may not see the modification immediately since the writer bypass the vfs cache of fuse.
>>> Actually we have already meet an issue caused by the inconsistency after applying fuse passthrough
>>> scheme to our product.
>>>
>>> Thanks,
>>> yanwu.
>>
>> Hi yanwu,
>>
>> Thank you for your interest in this change.
>>
>> FUSE passthrough for mmap is an extension that is already in my TODO
>> list, together with passthrough for directories.
>> For now I would prefer to keep this series minimal to make the review
>> process leaner and simpler.
>> I will start working on extending this series with new features and
>> addressing more corner cases as soon as these changes get merged, what
>> do you think?
>>
>> Thanks,
>> Alessio
> 
> Hi yanwu,
> 
> Sorry if I overlooked this issue. I added memory-mapping to my tests and
> could reproduce/verify this wrong behavior you mentioned.
> 
> I created this WIP (history may change) branch that has the missing mmap
> implementation:
> 
>    https://github.com/balsini/linux/commits/fuse-passthrough-v12-develop-v5.11-rc4
> 
> I did some mmap testing in the last days with this extra mmap
> implementation and couldn't find any issues, everything seems to be
> working as expected with the extra mmap patch. Can you please confirm
> this is fixed on your end too?
> I'm also going to revert in this branch the stacking policy changes to
> how they were in V10 as suggested by Amir if there are no concerns with
> that.
> I'm waiting for some extra tests to complete and, if no issue is
> detected, I'll post the V12 series super soon.
> 
> Thanks,
> Alessio
> 

Hi, Alessio

Thank you for your reply. I have already added mmap for passthrough in 
our product, and the issue mentioned before is fixed. And I will update 
if any new issuses found.

Thanks
yanwu
