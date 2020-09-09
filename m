Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC88C2627C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 09:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgIIHAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 03:00:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11274 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728663AbgIIHAA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:00:00 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A105FFA183E491D0C679;
        Wed,  9 Sep 2020 14:59:58 +0800 (CST)
Received: from [10.67.102.197] (10.67.102.197) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 14:59:51 +0800
Subject: Re: Question: Why is there no notification when a file is opened
 using filp_open()?
To:     Amir Goldstein <amir73il@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <wangle6@huawei.com>
References: <25817189-49a7-c64f-26ee-78d4a27496b6@huawei.com>
 <CAOQ4uxhejJzjKLZCt=b87KAX0sC3RAZ2FHEZbu4188Ar-bkmOg@mail.gmail.com>
 <e399cd17-e95e-def4-e03b-5cc2ae1f9708@huawei.com>
 <CAOQ4uxgvodepq2ZhmGEpkZYj017tH_pk2AgV=pUhWiONnxOQjw@mail.gmail.com>
 <20200908171859.GA29953@casper.infradead.org>
 <CAOQ4uxjX2GAJhD70=6SmwdXPH6TuOzGugtdYupDjLLywC2H5Ag@mail.gmail.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <96abf6e3-2442-8871-c9f3-be981c0a1965@huawei.com>
Date:   Wed, 9 Sep 2020 14:59:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxjX2GAJhD70=6SmwdXPH6TuOzGugtdYupDjLLywC2H5Ag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/9/9 11:44, Amir Goldstein wrote:
> On Tue, Sep 8, 2020 at 8:19 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Tue, Sep 08, 2020 at 04:18:29PM +0300, Amir Goldstein wrote:
>>> On Tue, Sep 8, 2020 at 3:53 PM Xiaoming Ni <nixiaoming@huawei.com> wrote:
>>>> For example, in fs/coredump.c, do_coredump() calls filp_open() to
>>>> generate core files.
>>>> In this scenario, the fsnotify_open() notification is missing.
>>>
>>> I am not convinced that we should generate an event.
>>> You will have to explain in what is the real world use case that requires this
>>> event to be generated.
>>
>> Take the typical usage for fsnotify of a graphical file manager.
>> It would be nice if the file manager showed a corefile as soon as it
>> appeared in a directory rather than waiting until some other operation
>> in that directory caused those directory contents to be refreshed.
> 
> fsnotify_open() is not the correct notification for file managers IMO.
> fsnotify_create() is and it will be called in this case.
> 
> If the reason you are interested in open events is because you want
> to monitor the entire filesystem then welcome to the future -
> FAN_CREATE is supported since kernel v5.1.
> 
> Is there another real life case you have in mind where you think users
> should be able to get an open fd for a file that the kernel has opened?
> Because that is what FAN_OPEN will do.
> 

There are also cases where file is opened in read-only mode using 
filp_open().

case1: nfsd4_init_recdir() call filp_open()
filp_open()
nfsd4_init_recdir() fs/nfsd/nfs4recover.c#L543

L70: static char user_recovery_dirname[PATH_MAX] = 
"/var/lib/nfs/v4recovery";
L543: nn->rec_file = filp_open(user_recovery_dirname, O_RDONLY | 
O_DIRECTORY, 0);


case2: ima_read_policy()
filp_open()
kernel_read_file_from_path()  fs/exec.c#L1004
ima_read_policy()  security/integrity/ima/ima_fs.c#L286
ima_write_policy() security/integrity/ima/ima_fs.c#L335
ima_measure_policy_ops   security/integrity/ima/ima_fs.c#L443
sys_write()

case3: use do_file_open_root() to open file
do_file_open_root()
file_open_root()   fs/open.c#L1159
kernel_read_file_from_path_initns()  fs/exec.c#L1029
fw_get_filesystem_firmware()  drivers/base/firmware_loader/main.c#L498

Do we need to add fsnotify_open() in these scenarios?

Thanks
Xiaoming Ni
