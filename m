Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53051C988C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 20:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEGSAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 14:00:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45780 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgEGSAn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 14:00:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047HxGbk193256;
        Thu, 7 May 2020 17:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=eNm8TslRfbAqOJ0il5EFDqQ5BbtyQf+gW8C4YjNf6PU=;
 b=ShBlW6b+n76I0t9PPaaK17p3bBhSBnnb7APKXKt0xU81bRyii/HW/DnnUz187lUXB0Db
 19TPylcypXK/RaCiEmBvy5W/nB47m+OxYI3u+s2NN//Ix/p4w2K0Hvu2jDGEu+3MYL99
 Qo85BTFXBQ96wnkQ3ijxYKAFsfuLJAsNWbHFN9cqWDvAaHLm1BV4sjvHi9jAG7GrAuln
 /UA6XKyfijbSLx+PDkE/GzrhOeTfGCvDVEIvyfh6bZRNgy8+IKEarcvlclUQc7uA4uEM
 cK57Sw1XRPjYEPgexJP0teLXh+6SSWCieUghGtU+di0hwYA0HUrQN5upxz+wRn8/cKRj Xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30usgq8st7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 17:59:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047HrXse152229;
        Thu, 7 May 2020 17:59:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30sjnq543d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 17:59:22 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 047HxEnw031926;
        Thu, 7 May 2020 17:59:14 GMT
Received: from [10.154.153.82] (/10.154.153.82)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 May 2020 10:59:13 -0700
Subject: Re: [RFC 34/43] shmem: PKRAM: multithread preserving and restoring
 shmem pages
To:     Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@linux.ibm.com, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, masahiroy@kernel.org, ardb@kernel.org,
        ndesaulniers@google.com, dima@golovin.in, daniel.kiper@oracle.com,
        nivedita@alum.mit.edu, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, zhenzhong.duan@oracle.com,
        jroedel@suse.de, bhe@redhat.com, guro@fb.com,
        Thomas.Lendacky@amd.com, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, hannes@cmpxchg.org, minchan@kernel.org,
        mhocko@kernel.org, ying.huang@intel.com,
        yang.shi@linux.alibaba.com, gustavo@embeddedor.com,
        ziqian.lzq@antfin.com, vdavydov.dev@gmail.com,
        jason.zeng@intel.com, kevin.tian@intel.com, zhiyuan.lv@intel.com,
        lei.l.li@intel.com, paul.c.lai@intel.com, ashok.raj@intel.com,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
 <1588812129-8596-35-git-send-email-anthony.yznaga@oracle.com>
 <4e44858d-a416-696e-0d65-0b5ca8836b7d@infradead.org>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
Organization: Oracle Corporation
Message-ID: <533ec65c-6d92-a75b-b151-aaa3f43224f8@oracle.com>
Date:   Thu, 7 May 2020 10:59:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4e44858d-a416-696e-0d65-0b5ca8836b7d@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070147
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/7/20 9:30 AM, Randy Dunlap wrote:
> On 5/6/20 5:42 PM, Anthony Yznaga wrote:
>> Improve performance by multithreading the work to preserve and restore
>> shmem pages.
>>
>> Add 'pkram_max_threads=' kernel option to specify the maximum number
>> of threads to use to preserve or restore the pages of a shmem file.
>> The default is 16.
> Hi,
> Please document kernel boot options in Documentation/admin-guide/kernel-parameters.txt.

I'll do that.  Thanks!

Anthony

>
>> When preserving pages each thread saves chunks of a file to a pkram_obj
>> until no more no more chunks are available.
>>
>> When restoring pages each thread loads pages using a copy of a
>> pkram_stream initialized by pkram_prepare_load_obj(). Under the hood
>> each thread ends up fetching and operating on pkram_link pages.
>>
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> ---
>>  include/linux/pkram.h |   2 +
>>  mm/shmem_pkram.c      | 101 +++++++++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 101 insertions(+), 2 deletions(-)
> thanks.

