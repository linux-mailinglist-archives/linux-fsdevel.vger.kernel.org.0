Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E676233861
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 20:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgG3S2I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 14:28:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36808 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgG3S2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:28:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UIGvNI092335;
        Thu, 30 Jul 2020 18:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Mrk5eWbP8fSGwrV33j3TTul01WXb6p2DuUr4h0aNQjE=;
 b=EVFXOxKNsyjLE7Mz9OC5iCUHTCcKYcSYOvVSBF6GvCRP1fPAUb1vsi8UbE5YhDKmTK/h
 u4q8dX3diP8UavnbfzQ2elsGw/j5XuLY2t1czN0ce8N9sx/TBhNGiCMuVFKYqCxkZCvA
 On4v9NhMLT4fRyGOjSByg3SQSp2UVC9x7iONmyLjntPdtdGFFyHZFVA2Q9MQ+I/jGdFx
 rfqOKHCti5lUSjYhQHLkrI/zoyeou+pvBdayRhDRPE+r0OMsLmorCvDgTF8iDvMOZ6Wl
 KWUE641IG2TKXQZyG88aaRJ0fUoBIVhV1oTDSIj9fYF6THvVIA3gXFDS4Gvl7vtVjOVO zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32hu1jna4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 18:27:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UIIoKJ054143;
        Thu, 30 Jul 2020 18:27:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 32hu5xrwua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 18:27:32 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06UIRP4c002811;
        Thu, 30 Jul 2020 18:27:26 GMT
Received: from [10.39.200.60] (/10.39.200.60)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jul 2020 11:27:25 -0700
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        gerg@linux-m68k.org, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <20200730152250.GG23808@casper.infradead.org>
 <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
 <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
Date:   Thu, 30 Jul 2020 14:27:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730174956.GK23808@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300130
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/30/2020 1:49 PM, Matthew Wilcox wrote:
> On Thu, Jul 30, 2020 at 01:35:51PM -0400, Steven Sistare wrote:
>> mshare + VA reservation is another possible solution.
>>
>> Or MADV_DOEXEC alone, which is ready now.  I hope we can get back to reviewing that.
> 
> We are.  This is the part of the review process where we explore other
> solutions to the problem.
> 
>>>> Also, we need to support updating legacy processes that already created anon segments.
>>>> We inject code that calls MADV_DOEXEC for such segments.
>>>
>>> Yes, I was assuming you'd inject code that called mshare().
>>
>> OK, mshare works on existing memory and builds a new vma.
> 
> Actually, reparents an existing VMA, and reuses the existing page tables.
> 
>>> Actually, since you're injecting code, why do you need the kernel to
>>> be involved?  You can mmap the new executable and any libraries it depends
>>> upon, set up a new stack and jump to the main() entry point, all without
>>> calling exec().  I appreciate it'd be a fair amount of code, but it'd all
>>> be in userspace and you can probably steal / reuse code from ld.so (I'm
>>> not familiar with the details of how setting up an executable is done).
>>
>> Duplicating all the work that the kernel and loader do to exec a process would
>> be error prone, require ongoing maintenance, and be redundant.  Better to define 
>> a small kernel extension and leave exec to the kernel.
> 
> Either this is a one-off kind of thing, in which case it doesn't need
> ongoing maintenance, or it's something with broad applicability, in
> which case it can live as its own userspace project.  It could even
> start off life as part of qemu and then fork into its own project.

exec will be enhanced over time in the kernel.  A separate user space implementation
would need to track that.

Reimplementing exec in userland would be a big gross mess.  Not a good solution when
we have simple and concise ways of solving the problem.

> The idea of tagging an ELF executable to say "I can cope with having
> chunks of my address space provided to me by my executor" is ... odd.

I don't disagree.  But it is useful.  We already pass a block of data containing
environment variables and arguments from one process to the next.  Preserving 
additional segments is not a big leap from there.

- Steve
