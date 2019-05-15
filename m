Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E21F6FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 16:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfEOOyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 10:54:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48524 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbfEOOyR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 10:54:17 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 65276E3A67B464E2C90D;
        Wed, 15 May 2019 22:54:14 +0800 (CST)
Received: from [127.0.0.1] (10.184.225.177) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 15 May 2019
 22:54:06 +0800
Subject: Re: [PATCH next] sysctl: add proc_dointvec_jiffies_minmax to limit
 the min/max write value
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <ebiederm@xmission.com>, <pbonzini@redhat.com>,
        <viro@zeniv.linux.org.uk>, <adobriyan@gmail.com>
CC:     <mingfangsen@huawei.com>, <wangxiaogang3@huawei.com>,
        "Zhoukang (A)" <zhoukang7@huawei.com>
References: <032e024f-2b1b-a980-1b53-d903bc8db297@huawei.com>
 <3e421384-a9cb-e534-3370-953c56883516@huawei.com>
Message-ID: <d5138655-41a8-0177-ae0d-c4674112bf56@huawei.com>
Date:   Wed, 15 May 2019 22:53:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <3e421384-a9cb-e534-3370-953c56883516@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.225.177]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Friendly ping...

ÔÚ 2019/4/24 12:04, Zhiqiang Liu Ð´µÀ:
> 
> Friendly ping...
> 
>> From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>>
>> In proc_dointvec_jiffies func, the write value is only checked
>> whether it is larger than INT_MAX. If the write value is less
>> than zero, it can also be successfully writen in the data.
>>
>> However, in some scenarios, users would adopt the data to
>> set timers or check whether time is expired. Generally, the data
>> will be cast to an unsigned type variable, then the negative data
>> becomes a very large unsigned value, which leads to long waits
>> or other unpredictable problems.
>>
>> Here, we add a new func, proc_dointvec_jiffies_minmax, to limit the
>> min/max write value, which is similar to the proc_dointvec_minmax func.
>>
>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> Reported-by: Qiang Ning <ningqiang1@huawei.com>
>> Reviewed-by: Jie Liu <liujie165@huawei.com>
>> ---
>>  include/linux/sysctl.h |  2 ++
>>  kernel/sysctl.c        | 44 +++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 45 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index b769ecf..8bde8a0 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -53,6 +53,8 @@ extern int proc_douintvec_minmax(struct ctl_table *table, int write,
>>  				 loff_t *ppos);
>>  extern int proc_dointvec_jiffies(struct ctl_table *, int,
>>  				 void __user *, size_t *, loff_t *);
>> +extern int proc_dointvec_jiffies_minmax(struct ctl_table *, int,
>> +				 void __user *, size_t *, loff_t *);
>>  extern int proc_dointvec_userhz_jiffies(struct ctl_table *, int,
>>  					void __user *, size_t *, loff_t *);
>>  extern int proc_dointvec_ms_jiffies(struct ctl_table *, int,
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index c9ec050..8e1eb59 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -2967,10 +2967,15 @@ static int do_proc_dointvec_jiffies_conv(bool *negp, unsigned long *lvalp,
>>  					 int *valp,
>>  					 int write, void *data)
>>  {
>> +	struct do_proc_dointvec_minmax_conv_param *param = data;
>> +
>>  	if (write) {
>>  		if (*lvalp > INT_MAX / HZ)
>>  			return 1;
>>  		*valp = *negp ? -(*lvalp*HZ) : (*lvalp*HZ);
>> +		if ((param->min && (*param->min)*HZ > *valp) ||
>> +		    (param->max && (*param->max)*HZ < *valp))
>> +			return -EINVAL;
>>  	} else {
>>  		int val = *valp;
>>  		unsigned long lval;
>> @@ -3053,7 +3058,37 @@ int proc_dointvec_jiffies(struct ctl_table *table, int write,
>>  			  void __user *buffer, size_t *lenp, loff_t *ppos)
>>  {
>>      return do_proc_dointvec(table,write,buffer,lenp,ppos,
>> -		    	    do_proc_dointvec_jiffies_conv,NULL);
>> +			    do_proc_dointvec_jiffies_conv, NULL);
>> +}
>> +
>> +/**
>> + * proc_dointvec_jiffies_minmax - read a vector of integers as seconds with min/max values
>> + * @table: the sysctl table
>> + * @write: %TRUE if this is a write to the sysctl file
>> + * @buffer: the user buffer
>> + * @lenp: the size of the user buffer
>> + * @ppos: file position
>> + *
>> + * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
>> + * values from/to the user buffer, treated as an ASCII string.
>> + * The values read are assumed to be in seconds, and are converted into
>> + * jiffies.
>> + *
>> + * This routine will ensure the values are within the range specified by
>> + * table->extra1 (min) and table->extra2 (max).
>> + *
>> + * Returns 0 on success or -EINVAL on write when the range check fails.
>> + */
>> +int proc_dointvec_jiffies_minmax(struct ctl_table *table, int write,
>> +			  void __user *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +	struct do_proc_dointvec_minmax_conv_param param = {
>> +		.min = (int *) table->extra1,
>> +		.max = (int *) table->extra2,
>> +	};
>> +
>> +	return do_proc_dointvec(table, write, buffer, lenp, ppos,
>> +				do_proc_dointvec_jiffies_conv, &param);
>>  }
>>
>>  /**
>> @@ -3301,6 +3336,12 @@ int proc_dointvec_jiffies(struct ctl_table *table, int write,
>>  	return -ENOSYS;
>>  }
>>
>> +int proc_dointvec_jiffies_minmax(struct ctl_table *table, int write,
>> +		    void __user *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +	return -ENOSYS;
>> +}
>> +
>>  int proc_dointvec_userhz_jiffies(struct ctl_table *table, int write,
>>  		    void __user *buffer, size_t *lenp, loff_t *ppos)
>>  {
>> @@ -3359,6 +3400,7 @@ static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
>>  EXPORT_SYMBOL(proc_dointvec);
>>  EXPORT_SYMBOL(proc_douintvec);
>>  EXPORT_SYMBOL(proc_dointvec_jiffies);
>> +EXPORT_SYMBOL(proc_dointvec_jiffies_minmax);
>>  EXPORT_SYMBOL(proc_dointvec_minmax);
>>  EXPORT_SYMBOL_GPL(proc_douintvec_minmax);
>>  EXPORT_SYMBOL(proc_dointvec_userhz_jiffies);
>>
> 
> 
> .
> 

