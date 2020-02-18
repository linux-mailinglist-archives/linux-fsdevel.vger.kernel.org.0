Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86B43163359
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 21:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBRUqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 15:46:25 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45744 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgBRUqZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:46:25 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01IKgles145865;
        Tue, 18 Feb 2020 20:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=d+zB9Q+hsQ04tUSy3v9iBkk/iREuKMJdCn9izc5iSwQ=;
 b=uS871BfP8q44BJQH6VY0wUmXIGo6Ewx4fTUtD7a3X64VQ4i5p4BXta8sm7lARlUyIbC3
 TIvAwsifWPlSA5mY8l2pu6v4+jRNPk28SfZRgfvqiMghq4JFjmh5dFCQIJNxGayi47pC
 Q8WxWeJ5ukmvJovBe340zMAYUQLNjQyl5lsCCVMZSGVg0+d+OBtB0GEwdqhscU1He3Ct
 jKKG84BuCySdPohrWojFNTgNK4Fft2NUaLQatN//uaViGB/qf/vhl5CkJJ7u5IpecrUB
 C3FLFgJrBiQp1Wd5vRz5tCjY4kN1evzgIHwx4AHe+hrly+RnMvFaxKqQ5qBsgUbiMy8R VA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2y7aq5v1bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 20:45:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01IKhZO2188535;
        Tue, 18 Feb 2020 20:45:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2y6tc328cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 20:45:36 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01IKjZIW026010;
        Tue, 18 Feb 2020 20:45:35 GMT
Received: from [10.132.96.37] (/10.132.96.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Feb 2020 12:45:35 -0800
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
From:   jane.chu@oracle.com
Organization: Oracle Corporation
Message-ID: <583b5fc2-0358-ea9d-20eb-1323c8cedce2@oracle.com>
Date:   Tue, 18 Feb 2020 12:45:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <x49v9o3brom.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1011 bulkscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180136
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/18/20 11:50 AM, Jeff Moyer wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
>> Right now the kernel does not install a pte on faults that land on a
>> page with known poison, but only because the error clearing path is so
>> convoluted and could only claim that fallocate(PUNCH_HOLE) cleared
>> errors because that was guaranteed to send 512-byte aligned zero's
>> down the block-I/O path when the fs-blocks got reallocated. In a world
>> where native cpu instructions can clear errors the dax write() syscall
>> case could be covered (modulo 64-byte alignment), and the kernel could
>> just let the page be mapped so that the application could attempt it's
>> own fine-grained clearing without calling back into the kernel.
> 
> I'm not sure we'd want to do allow mapping the PTEs even if there was
> support for clearing errors via CPU instructions.  Any load from a
> poisoned page will result in an MCE, and there exists the possiblity
> that you will hit an unrecoverable error (Processor Context Corrupt).
> It's just safer to catch these cases by not mapping the page, and
> forcing recovery through the driver.
> 
> -Jeff
> 

I'm still in the process of trying a number of things before making an
attempt to respond to Dan's response. But I'm too slow, so I'd like
to share some concerns I have here.

If a poison in a file is consumed, and the signal handle does the
repair and recover as follow: punch a hole the size at least 4K, then
pwrite the correct data in to the 'hole', then resume the operation.
However, because the newly allocated pmem block (due to pwrite to the 
'hole') is a different clean physical pmem block while the poisoned
block remain unfixed, so we have a provisioning problem, because
  1. DCPMEM is expensive hence there is likely little provision being
provided by users;
  2. lack up API between dax-filesystem and pmem driver for clearing
poison at each legitimate point, such as when the filesystem tries
to allocate a pmem block, or zeroing out a range.

As DCPMM is used for its performance and capacity in cloud application,
which translates to that the performance code paths include the error
handling and recovery code path...

With respect to the new cpu instruction, my concern is about the API 
including the error blast radius as reported in the signal payload.
Is there a venue where we could discuss more in detail ?

Regards,
-jane



