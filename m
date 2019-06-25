Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B48B254F76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 14:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfFYM5u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 08:57:50 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33034 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728022AbfFYM5u (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:57:50 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 3E2D18746ED2E5F5F6B2;
        Tue, 25 Jun 2019 13:57:48 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 25 Jun
 2019 13:57:37 +0100
Subject: Re: [PATCH v4 00/14] ima: introduce IMA Digest Lists extension
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20190614175513.27097-1-roberto.sassu@huawei.com>
 <9029dd14-1077-ec89-ddc2-e677e16ad314@huawei.com>
Message-ID: <88d368e6-5b3c-0206-23a0-dc3e0aa385f0@huawei.com>
Date:   Tue, 25 Jun 2019 14:57:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <9029dd14-1077-ec89-ddc2-e677e16ad314@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/17/2019 8:56 AM, Roberto Sassu wrote:
> On 6/14/2019 7:54 PM, Roberto Sassu wrote:
>> This patch set introduces a new IMA extension called IMA Digest Lists.
>>
>> At early boot, the extension preloads in kernel memory reference digest
>> values, that can be compared with actual file digests when files are
>> accessed in the system.
>>
>> The extension will open for new possibilities: PCR with predictable 
>> value,
>> that can be used for sealing policies associated to data or TPM keys;
>> appraisal based on reference digests already provided by Linux 
>> distribution
>> vendors in the software packages.
>>
>> The first objective can be achieved because the PCR values does not 
>> depend
>> on which and when files are measured: the extension measures digest lists
>> sequentially and files whose digest is not in the digest list.
>>
>> The second objective can be reached because the extension is able to
>> extract reference measurements from packages (with a user space tool) and
>> use it as a source for appraisal verification as the reference came from
>> the security.ima xattr. This approach will also reduce the overhead as 
>> only
>> one signature is verified for many files (as opposed to one signature for
>> each file with the current implementation).
>>
>> This version of the patch set provides a clear separation between current
>> and new functionality. First, the new functionality must be explicitly
>> enabled from the kernel command line. Second, results of operations
>> performed by the extension can be distinguished from those obtained from
>> the existing code: measurement entries created by the extension have a
>> different PCR; mutable files appraised with the extension have a 
>> different
>> security.ima type.
>>
>> The review of this patch set should start from patch 11 and 12, which
>> modify the IMA-Measure and IMA-Appraise submodules to use digest lists.
>> Patch 1 to 5 are prerequisites. Patch 6 to 10 adds support for digest
>> lists. Finally, patch 13 introduces two new policies to measure/appraise
>> rootfs and patch 14 adds the documentation (including a flow chart to
>> show how IMA has been modified).
>>
>> The user space tools to configure digest lists are available at:
>>
>> https://github.com/euleros/digest-list-tools/releases/tag/v0.3
>>
>> The patch set applies on top of linux-integrity/next-queued-testing
>> (73589972b987).
>>
>> It is necessary to apply also:
>> https://patchwork.kernel.org/cover/10957495/
> 
> Another dependency is:
> 
> https://patchwork.kernel.org/cover/10979341/
> 
> Roberto
I uploaded this patch set and all the required dependencies to:

https://github.com/euleros/linux/releases/tag/ima-digest-lists-v4

It should be easy to test. Let me know if you have questions about the
installation.


Mimi, do you have any thoughts on this version?

Thanks

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
