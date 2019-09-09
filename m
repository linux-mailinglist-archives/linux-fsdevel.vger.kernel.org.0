Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86D7AE191
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 01:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbfIIXwT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 19:52:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2254 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730370AbfIIXwT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 19:52:19 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 16035839126179043B18;
        Tue, 10 Sep 2019 07:52:17 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Sep 2019
 07:52:15 +0800
Subject: Re: [Virtio-fs] [PATCH 00/18] virtiofs: Fix various races and
 cleanups round 1
To:     Stefan Hajnoczi <stefanha@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
 <20190906103613.GH5900@stefanha-x1.localdomain>
 <CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
 <866a1469-2c4b-59ce-cf3f-32f65e861b99@huawei.com>
 <20190909161455.GG20875@stefanha-x1.localdomain>
CC:     Miklos Szeredi <miklos@szeredi.hu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        <linux-kernel@vger.kernel.org>, <virtio-fs@redhat.com>,
        <linux-fsdevel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5D76E5AE.3090006@huawei.com>
Date:   Tue, 10 Sep 2019 07:52:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20190909161455.GG20875@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/9/10 0:14, Stefan Hajnoczi wrote:
> On Sun, Sep 08, 2019 at 07:53:55PM +0800, piaojun wrote:
>>
>>
>> On 2019/9/6 19:52, Miklos Szeredi wrote:
>>> On Fri, Sep 6, 2019 at 12:36 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>>>
>>>> On Fri, Sep 06, 2019 at 10:15:14AM +0200, Miklos Szeredi wrote:
>>>>> On Thu, Sep 5, 2019 at 9:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Michael Tsirkin pointed out issues w.r.t various locking related TODO
>>>>>> items and races w.r.t device removal.
>>>>>>
>>>>>> In this first round of cleanups, I have taken care of most pressing
>>>>>> issues.
>>>>>>
>>>>>> These patches apply on top of following.
>>>>>>
>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4
>>>>>>
>>>>>> I have tested these patches with mount/umount and device removal using
>>>>>> qemu monitor. For example.
>>>>>
>>>>> Is device removal mandatory?  Can't this be made a non-removable
>>>>> device?  Is there a good reason why removing the virtio-fs device
>>>>> makes sense?
>>>>
>>>> Hot plugging and unplugging virtio PCI adapters is common.  I'd very
>>>> much like removal to work from the beginning.
>>>
>>> Can you give an example use case?
>>
>> I think VirtFS migration need hot plugging, or it may cause QEMU crash
>> or some problems.
> 
> Live migration is currently unsupported.  Hot unplugging the virtio-fs
> device would allow the guest to live migrate successfully, so it's a
> useful feature to work around the missing live migration support.
> 
> Is this what you mean?

Agreed, migration support is necessary for user, and hot
plugging/unplugging is also common for virtio device.

Jun
