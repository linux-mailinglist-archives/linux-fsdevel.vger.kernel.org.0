Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA342ECA6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 07:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbhAGGPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 01:15:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10555 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbhAGGPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 01:15:25 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DBGBV0kb3zMF8D;
        Thu,  7 Jan 2021 14:13:22 +0800 (CST)
Received: from [10.67.102.197] (10.67.102.197) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 7 Jan 2021 14:14:25 +0800
Subject: Re: [PATCH] proc_sysclt: fix oops caused by incorrect command
 parameters.
To:     Kees Cook <keescook@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>,
        <yzaikin@google.com>, <adobriyan@gmail.com>, <vbabka@suse.cz>,
        <linux-fsdevel@vger.kernel.org>, <mhocko@suse.com>,
        <mhiramat@kernel.org>, <wangle6@huawei.com>
References: <20201224074256.117413-1-nixiaoming@huawei.com>
 <202101061539.966EBB293@keescook>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <5ad6d160-3a4e-28bd-4e89-cb01a1815861@huawei.com>
Date:   Thu, 7 Jan 2021 14:14:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <202101061539.966EBB293@keescook>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/1/7 7:46, Kees Cook wrote:
> subject typo: "sysclt" -> "sysctl"
> 
> On Thu, Dec 24, 2020 at 03:42:56PM +0800, Xiaoming Ni wrote:
>> The process_sysctl_arg() does not check whether val is empty before
>>   invoking strlen(val). If the command line parameter () is incorrectly
>>   configured and val is empty, oops is triggered.
>>
>> For example, "hung_task_panic=1" is incorrectly written as "hung_task_panic".
>>
>> log:
>> 	Kernel command line: .... hung_task_panic
>> 	....
>> 	[000000000000000n] user address but active_mm is swapper
>> 	Internal error: Oops: 96000005 [#1] SMP
>> 	Modules linked in:
>> 	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.1 #1
>> 	Hardware name: linux,dummy-virt (DT)
>> 	pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
>> 	pc : __pi_strlen+0x10/0x98
>> 	lr : process_sysctl_arg+0x1e4/0x2ac
>> 	sp : ffffffc01104bd40
>> 	x29: ffffffc01104bd40 x28: 0000000000000000
>> 	x27: ffffff80c0a4691e x26: ffffffc0102a7c8c
>> 	x25: 0000000000000000 x24: ffffffc01104be80
>> 	x23: ffffff80c22f0b00 x22: ffffff80c02e28c0
>> 	x21: ffffffc0109f9000 x20: 0000000000000000
>> 	x19: ffffffc0107c08de x18: 0000000000000003
>> 	x17: ffffffc01105d000 x16: 0000000000000054
>> 	x15: ffffffffffffffff x14: 3030253078413830
>> 	x13: 000000000000ffff x12: 0000000000000000
>> 	x11: 0101010101010101 x10: 0000000000000005
>> 	x9 : 0000000000000003 x8 : ffffff80c0980c08
>> 	x7 : 0000000000000000 x6 : 0000000000000002
>> 	x5 : ffffff80c0235000 x4 : ffffff810f7c7ee0
>> 	x3 : 000000000000043a x2 : 00bdcc4ebacf1a54
>> 	x1 : 0000000000000000 x0 : 0000000000000000
>> 	Call trace:
>> 	 __pi_strlen+0x10/0x98
>> 	 parse_args+0x278/0x344
>> 	 do_sysctl_args+0x8c/0xfc
>> 	 kernel_init+0x5c/0xf4
>> 	 ret_from_fork+0x10/0x30
>> 	Code: b200c3eb 927cec01 f2400c07 54000301 (a8c10c22)
>>
>> Fixes: 3db978d480e2843 ("kernel/sysctl: support setting sysctl parameters
>>   from kernel command line")
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>> ---
>>   fs/proc/proc_sysctl.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>> index 317899222d7f..4516411a2b44 100644
>> --- a/fs/proc/proc_sysctl.c
>> +++ b/fs/proc/proc_sysctl.c
>> @@ -1757,6 +1757,9 @@ static int process_sysctl_arg(char *param, char *val,
>>   	loff_t pos = 0;
>>   	ssize_t wret;
>>   
>> +	if (!val)
>> +		return 0;
>> +
>>   	if (strncmp(param, "sysctl", sizeof("sysctl") - 1) == 0) {
>>   		param += sizeof("sysctl") - 1;
> 
> Otherwise, yeah, this is a good test to add. I would make it more
> verbose, though:
> 
> 	if (!val) {
> 		pr_err("Missing param value! Expected '%s=...value...'\n", param);
> 		return 0;
> 	}
> 
Yes, it's better to add log output.
Thank you for your review.
Do I need to send V2 patch based on review comments?

Thanks
Xiaoming Ni

