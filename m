Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D66C1D490B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 11:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgEOJGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 05:06:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4787 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726922AbgEOJGj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 05:06:39 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 95C3FEB4EA6DAC2EFC8B;
        Fri, 15 May 2020 17:06:36 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 15 May 2020
 17:06:29 +0800
Subject: Re: [PATCH 2/4] proc/sysctl: add shared variables -1
To:     Kees Cook <keescook@chromium.org>
CC:     <mcgrof@kernel.org>, <yzaikin@google.com>, <adobriyan@gmail.com>,
        <mingo@kernel.org>, <peterz@infradead.org>,
        <akpm@linux-foundation.org>, <yamada.masahiro@socionext.com>,
        <bauerman@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <skhan@linuxfoundation.org>, <dvyukov@google.com>,
        <svens@stackframe.org>, <joel@joelfernandes.org>,
        <tglx@linutronix.de>, <Jisheng.Zhang@synaptics.com>,
        <pmladek@suse.com>, <bigeasy@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <wangle6@huawei.com>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-3-git-send-email-nixiaoming@huawei.com>
 <202005150105.33CAEEA6C5@keescook>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <88f3078b-9419-b9c6-e789-7d6e50ca2cef@huawei.com>
Date:   Fri, 15 May 2020 17:06:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <202005150105.33CAEEA6C5@keescook>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/5/15 16:06, Kees Cook wrote:
> On Fri, May 15, 2020 at 12:33:42PM +0800, Xiaoming Ni wrote:
>> Add the shared variable SYSCTL_NEG_ONE to replace the variable neg_one
>> used in both sysctl_writes_strict and hung_task_warnings.
>>
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>> ---
>>   fs/proc/proc_sysctl.c     | 2 +-
>>   include/linux/sysctl.h    | 1 +
>>   kernel/hung_task_sysctl.c | 3 +--
>>   kernel/sysctl.c           | 3 +--
> 
> How about doing this refactoring in advance of the extraction patch?
Before  advance of the extraction patch, neg_one is only used in one 
file, does it seem to have no value for refactoring?


> 
>>   4 files changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>> index b6f5d45..acae1fa 100644
>> --- a/fs/proc/proc_sysctl.c
>> +++ b/fs/proc/proc_sysctl.c
>> @@ -23,7 +23,7 @@
>>   static const struct inode_operations proc_sys_dir_operations;
>>   
>>   /* shared constants to be used in various sysctls */
>> -const int sysctl_vals[] = { 0, 1, INT_MAX };
>> +const int sysctl_vals[] = { 0, 1, INT_MAX, -1 };
>>   EXPORT_SYMBOL(sysctl_vals);
>>   
>>   /* Support for permanently empty directories */
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index 02fa844..6d741d6 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -41,6 +41,7 @@
>>   #define SYSCTL_ZERO	((void *)&sysctl_vals[0])
>>   #define SYSCTL_ONE	((void *)&sysctl_vals[1])
>>   #define SYSCTL_INT_MAX	((void *)&sysctl_vals[2])
>> +#define SYSCTL_NEG_ONE	((void *)&sysctl_vals[3])
> 
> Nit: let's keep these value-ordered? i.e. -1, 0, 1, INT_MAX.
Thanks for guidance, your method is better

Thanks.
Xiaoming Ni

