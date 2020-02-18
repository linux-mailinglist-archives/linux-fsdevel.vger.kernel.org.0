Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15152163680
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 23:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgBRWxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 17:53:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34704 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgBRWxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:53:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01IMlx4S125643;
        Tue, 18 Feb 2020 22:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1Q62cPH1Xp8kxiw0GhNYjhX3s5Y04bDzwFnSLddrOUc=;
 b=l3++8akYe9ElvfQqjWDQpEwvdV8wwfreMQoxJcVn6Cllni9gF7QvrNJ+RVYjlZRt2Z5n
 pq7UQtB3EqR1bDBymj1nXZ8LyK2bS1TMkl/R6t0Ezvz9opnRvXqaodmsmOXZrgI+Q4vL
 nsicuYfBVVyTgmWGVXNEbXIT0vs1HkCBXqD/y2cLW5b2NUzDRuGisU8Zzz023OITk1x+
 8K+xhKeT9AxfztuI3IzZokmKhZwkrHVgGn7/b/xx2PxJo/qCk4eZ09T66IexBR2OwTj0
 h00TZXEntmvNNfCpqIv7x0WbanZiLxZKAJ07oljB/c/3rVg4kp/w/MZvSN7bn5QiURlO RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2y699rsdny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 22:53:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01IMrewJ108538;
        Tue, 18 Feb 2020 22:53:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2y6tc393hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 22:53:40 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01IMrS6Y020383;
        Tue, 18 Feb 2020 22:53:29 GMT
Received: from [10.132.96.37] (/10.132.96.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Feb 2020 14:50:44 -0800
Subject: Re: [RFC][PATCH] dax: Do not try to clear poison for partial pages
To:     Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "JANE.CHU" <jane.chu@oracle.com>
References: <20200129210337.GA13630@redhat.com>
 <f97d1ce2-9003-6b46-cd25-a908dc3bd2c6@oracle.com>
 <CAPcyv4ittXHkEV4eH_4F5vCfwRLoTTtDqEU1SmCs5DYUdZxBOA@mail.gmail.com>
 <x49v9o3brom.fsf@segfault.boston.devel.redhat.com>
 <583b5fc2-0358-ea9d-20eb-1323c8cedce2@oracle.com>
From:   jane.chu@oracle.com
Organization: Oracle Corporation
Message-ID: <17c0d27e-c23f-b686-1d47-a0ccace03211@oracle.com>
Date:   Tue, 18 Feb 2020 14:50:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <583b5fc2-0358-ea9d-20eb-1323c8cedce2@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180155
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/18/20 12:45 PM, jane.chu@oracle.com wrote:
> On 2/18/20 11:50 AM, Jeff Moyer wrote:
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>>> Right now the kernel does not install a pte on faults that land on a
>>> page with known poison, but only because the error clearing path is so
>>> convoluted and could only claim that fallocate(PUNCH_HOLE) cleared
>>> errors because that was guaranteed to send 512-byte aligned zero's
>>> down the block-I/O path when the fs-blocks got reallocated. In a world
>>> where native cpu instructions can clear errors the dax write() syscall
>>> case could be covered (modulo 64-byte alignment), and the kernel could
>>> just let the page be mapped so that the application could attempt it's
>>> own fine-grained clearing without calling back into the kernel.
>>
>> I'm not sure we'd want to do allow mapping the PTEs even if there was
>> support for clearing errors via CPU instructions.  Any load from a
>> poisoned page will result in an MCE, and there exists the possiblity
>> that you will hit an unrecoverable error (Processor Context Corrupt).
>> It's just safer to catch these cases by not mapping the page, and
>> forcing recovery through the driver.
>>
>> -Jeff
>>
> 
> I'm still in the process of trying a number of things before making an
> attempt to respond to Dan's response. But I'm too slow, so I'd like
> to share some concerns I have here.
> 
> If a poison in a file is consumed, and the signal handle does the
> repair and recover as follow: punch a hole the size at least 4K, then
> pwrite the correct data in to the 'hole', then resume the operation.
> However, because the newly allocated pmem block (due to pwrite to the 
> 'hole') is a different clean physical pmem block while the poisoned
> block remain unfixed, so we have a provisioning problem, because
>   1. DCPMEM is expensive hence there is likely little provision being
> provided by users;
>   2. lack up API between dax-filesystem and pmem driver for clearing
> poison at each legitimate point, such as when the filesystem tries
> to allocate a pmem block, or zeroing out a range >
> As DCPMM is used for its performance and capacity in cloud application,
> which translates to that the performance code paths include the error
> handling and recovery code path...
> 
> With respect to the new cpu instruction, my concern is about the API 
> including the error blast radius as reported in the signal payload.
> Is there a venue where we could discuss more in detail ?

For all the quarantined poison blocks, it's not practical to clear them 
poisons via ndctl/libndctl on a per namespace granularity for fear of
poisons occurred in valid pmem blocks during data at rest.

How to ultimately clear poisons in a dax-fs in current framework?
it seems to me poisons need to be cleared on the go automatically.

Regards,
-jane

> 
> Regards,
> -jane
> 
> 
> 
