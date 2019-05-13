Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0391B17B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 09:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfEMHs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 03:48:58 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32932 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727576AbfEMHs6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 03:48:58 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 7561DC2DECF36B16DA26;
        Mon, 13 May 2019 08:48:56 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 13 May
 2019 08:48:56 +0100
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Arvind Sankar <niveditas98@gmail.com>,
        Rob Landley <rob@landley.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <initramfs@vger.kernel.org>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
Date:   Mon, 13 May 2019 09:49:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190512194322.GA71658@rani.riverdale.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/12/2019 9:43 PM, Arvind Sankar wrote:
> On Sun, May 12, 2019 at 05:05:48PM +0000, Rob Landley wrote:
>> On 5/12/19 7:52 AM, Mimi Zohar wrote:
>>> On Sun, 2019-05-12 at 11:17 +0200, Dominik Brodowski wrote:
>>>> On Thu, May 09, 2019 at 01:24:17PM +0200, Roberto Sassu wrote:
>>>>> This proposal consists in marshaling pathnames and xattrs in a file called
>>>>> .xattr-list. They are unmarshaled by the CPIO parser after all files have
>>>>> been extracted.
>>>>
>>>> Couldn't this parsing of the .xattr-list file and the setting of the xattrs
>>>> be done equivalently by the initramfs' /init? Why is kernel involvement
>>>> actually required here?
>>>
>>> It's too late.  The /init itself should be signed and verified.
>>
>> If the initramfs cpio.gz image was signed and verified by the extractor, how is
>> the init in it _not_ verified?
>>
>> Ro
> 
> Wouldn't the below work even before enforcing signatures on external
> initramfs:
> 1. Create an embedded initramfs with an /init that does the xattr
> parsing/setting. This will be verified as part of the kernel image
> signature, so no new code required.
> 2. Add a config option/boot parameter to panic the kernel if an external
> initramfs attempts to overwrite anything in the embedded initramfs. This
> prevents overwriting the embedded /init even if the external initramfs
> is unverified.

Unfortunately, it wouldn't work. IMA is already initialized and it would
verify /init in the embedded initial ram disk. The only reason why
opening .xattr-list works is that IMA is not yet initialized
(late_initcall vs rootfs_initcall).

Allowing a kernel with integrity enforcement to parse the CPIO image
without verifying it first is the weak point. However, extracted files
are not used, and before they are used they are verified. At the time
they are verified, they (included /init) must already have a signature
or otherwise access would be denied.

This scheme relies on the ability of the kernel to not be corrupted in
the event it parses a malformed CPIO image. Mimi suggested to use
digital signatures to prevent this issue, but it cannot be used in all
scenarios, since conventional systems generate the initial ram disk
locally.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
