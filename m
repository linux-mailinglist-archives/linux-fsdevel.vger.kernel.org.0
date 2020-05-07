Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C00A1C997D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 20:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgEGSnR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 14:43:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46476 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGSnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 14:43:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047IbgcN004211;
        Thu, 7 May 2020 18:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=mEDzEEDSb5jTK1bCppRO0q98+bzWMLYtdC4AbIqeGDQ=;
 b=p67mYIkdiwJsmnC7ru/mh2/Yfh7z9rNBCXeRFzXgPFjCOGcc6I/jf3cI3t6jZOTbWonM
 nrcSzlCIQt+vCOOmQ/QHgtwcbiTxDxYwCMIRsCfZg9MO/a2lQzY2bzVgx0RBUj9W7WR4
 WoXDElaGKcpiCo0hEvUgaktAI5Hm931tQRG3DGXkUcl15yZqquCGX7wNaqqTAh6RNGwp
 roIaOjY0Q8kbCj8TBaOv7qBq0ccyMZ0+dsll3Io87z1wQ08LfzFH9Uq74xr2J0iYjz+t
 pKvSm6/u3weJp62HWoSStAEc9eR/JZCV8uDuCKATw4q2+0vtEYn3HjHH6uRkJLw5jOHm sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30vhvyj79h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 18:42:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047IavNE026231;
        Thu, 7 May 2020 18:42:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30sjdyq2v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 18:42:00 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 047IfuCW023296;
        Thu, 7 May 2020 18:41:56 GMT
Received: from [10.154.153.82] (/10.154.153.82)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 May 2020 11:41:55 -0700
Subject: Re: [RFC 21/43] x86/KASLR: PKRAM: support physical kaslr
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@linux.ibm.com, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, masahiroy@kernel.org, ardb@kernel.org,
        ndesaulniers@google.com, dima@golovin.in, daniel.kiper@oracle.com,
        nivedita@alum.mit.edu, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, zhenzhong.duan@oracle.com,
        jroedel@suse.de, bhe@redhat.com, guro@fb.com,
        Thomas.Lendacky@amd.com, andriy.shevchenko@linux.intel.com,
        hannes@cmpxchg.org, minchan@kernel.org, mhocko@kernel.org,
        ying.huang@intel.com, yang.shi@linux.alibaba.com,
        gustavo@embeddedor.com, ziqian.lzq@antfin.com,
        vdavydov.dev@gmail.com, jason.zeng@intel.com, kevin.tian@intel.com,
        zhiyuan.lv@intel.com, lei.l.li@intel.com, paul.c.lai@intel.com,
        ashok.raj@intel.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
 <1588812129-8596-22-git-send-email-anthony.yznaga@oracle.com>
 <202005071049.2D0939137D@keescook>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
Organization: Oracle Corporation
Message-ID: <62a1c002-ad7b-a364-5797-6d7f5545d5cf@oracle.com>
Date:   Thu, 7 May 2020 11:41:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <202005071049.2D0939137D@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070151
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/7/20 10:51 AM, Kees Cook wrote:
> On Wed, May 06, 2020 at 05:41:47PM -0700, Anthony Yznaga wrote:
>> Avoid regions of memory that contain preserved pages when computing
>> slots used to select where to put the decompressed kernel.
> This is changing the slot-walking code instead of updating
> mem_avoid_overlap() -- that's where the check for a "reserved" memory
> area should live.
>
> For example, this is how both mem_avoid_memmap() and the setup_data
> memory areas are handled.
>
> Is there a reason mem_avoid_overlap() can't be used here?
>

I was thinking it would be more efficient to process just
the regions that did not contain preserved pages rather
than checking for preserved pages in mem_avoid_overlap(),
but I see that may just be adding unnecessary complexity.
I'll investigate modifying mem_avoid_overlap().
Thank you for the comments!

Anthony
