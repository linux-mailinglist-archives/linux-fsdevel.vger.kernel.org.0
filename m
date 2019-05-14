Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AD61CDD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 19:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfENRUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 13:20:15 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32940 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbfENRUO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 13:20:14 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 29233CEC22E624BEE688;
        Tue, 14 May 2019 18:20:12 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 14 May
 2019 18:20:07 +0100
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Andy Lutomirski <luto@kernel.org>, Rob Landley <rob@landley.net>,
        "Arvind Sankar" <niveditas98@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        <initramfs@vger.kernel.org>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <CALCETrV3b205L38xqPr6QqwGn6-vxQdPoJGUygJJpgM-JqqXfQ@mail.gmail.com>
 <9357cb32-3803-2a7e-4949-f9e4554c1ee9@huawei.com>
 <20190514165842.GC28266@kroah.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <f01ad775-54de-033f-d8cb-f27f36e92f0c@huawei.com>
Date:   Tue, 14 May 2019 19:20:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190514165842.GC28266@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/14/2019 6:58 PM, Greg KH wrote:
> On Tue, May 14, 2019 at 06:33:29PM +0200, Roberto Sassu wrote:
>> On 5/14/2019 5:19 PM, Andy Lutomirski wrote:
>>> On Mon, May 13, 2019 at 5:47 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>>>>
>>>> On 5/13/2019 11:07 AM, Rob Landley wrote:
>>>>>
>>>>>
>>>>> On 5/13/19 2:49 AM, Roberto Sassu wrote:
>>>>>> On 5/12/2019 9:43 PM, Arvind Sankar wrote:
>>>>>>> On Sun, May 12, 2019 at 05:05:48PM +0000, Rob Landley wrote:
>>>>>>>> On 5/12/19 7:52 AM, Mimi Zohar wrote:
>>>>>>>>> On Sun, 2019-05-12 at 11:17 +0200, Dominik Brodowski wrote:
>>>>>>>>>> On Thu, May 09, 2019 at 01:24:17PM +0200, Roberto Sassu wrote:
>>>>>>>>>>> This proposal consists in marshaling pathnames and xattrs in a file called
>>>>>>>>>>> .xattr-list. They are unmarshaled by the CPIO parser after all files have
>>>>>>>>>>> been extracted.
>>>>>>>>>>
>>>>>>>>>> Couldn't this parsing of the .xattr-list file and the setting of the xattrs
>>>>>>>>>> be done equivalently by the initramfs' /init? Why is kernel involvement
>>>>>>>>>> actually required here?
>>>>>>>>>
>>>>>>>>> It's too late.  The /init itself should be signed and verified.
>>>>>>>>
>>>>>>>> If the initramfs cpio.gz image was signed and verified by the extractor, how is
>>>>>>>> the init in it _not_ verified?
>>>>>>>>
>>>>>>>> Ro
>>>>>>>
>>>>>>> Wouldn't the below work even before enforcing signatures on external
>>>>>>> initramfs:
>>>>>>> 1. Create an embedded initramfs with an /init that does the xattr
>>>>>>> parsing/setting. This will be verified as part of the kernel image
>>>>>>> signature, so no new code required.
>>>>>>> 2. Add a config option/boot parameter to panic the kernel if an external
>>>>>>> initramfs attempts to overwrite anything in the embedded initramfs. This
>>>>>>> prevents overwriting the embedded /init even if the external initramfs
>>>>>>> is unverified.
>>>>>>
>>>>>> Unfortunately, it wouldn't work. IMA is already initialized and it would
>>>>>> verify /init in the embedded initial ram disk.
>>>>>
>>>>> So you made broken infrastructure that's causing you problems. Sounds unfortunate.
>>>>
>>>> The idea is to be able to verify anything that is accessed, as soon as
>>>> rootfs is available, without distinction between embedded or external
>>>> initial ram disk.
>>>>
>>>> Also, requiring an embedded initramfs for xattrs would be an issue for
>>>> systems that use it for other purposes.
>>>>
>>>>
>>>>>> The only reason why
>>>>>> opening .xattr-list works is that IMA is not yet initialized
>>>>>> (late_initcall vs rootfs_initcall).
>>>>>
>>>>> Launching init before enabling ima is bad because... you didn't think of it?
>>>>
>>>> No, because /init can potentially compromise the integrity of the
>>>> system.
>>>
>>> I think Rob is right here.  If /init was statically built into the
>>> kernel image, it has no more ability to compromise the kernel than
>>> anything else in the kernel.  What's the problem here?
>>
>> Right, the measurement/signature verification of the kernel image is
>> sufficient.
>>
>> Now, assuming that we defer the IMA initialization until /init in the
>> embedded initramfs has been executed, the problem is how to handle
>> processes launched with the user mode helper or files directly read by
>> the kernel (if it can happen before /init is executed). If IMA is not
>> yet enabled, these operations will be performed without measurement and
>> signature verification.
> 
> If you really care about this, don't launch any user mode helper
> programs (hint, you have the kernel option to control this and funnel
> everything into one, or no, binaries).  And don't allow the kernel to
> read any files either, again, you have control over this.
> 
> Or start IMA earlier if you need/want/care about this.

Yes, this is how it works now. It couldn't start earlier than
late_initcall, as it has to wait until the TPM driver is initialized.

Anyway, it is enabled at the time /init is executed. And this would be
an issue because launching /init and reading xattrs from /.xattr-list
would be denied (the signature is missing).

And /.xattr-list won't have a signature, if initramfs is generated
locally.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
