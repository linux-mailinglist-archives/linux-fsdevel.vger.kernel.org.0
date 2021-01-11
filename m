Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11322F0B95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 04:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbhAKDtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jan 2021 22:49:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11375 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbhAKDtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jan 2021 22:49:12 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DDfmJ6s6Rz7SYs;
        Mon, 11 Jan 2021 11:47:28 +0800 (CST)
Received: from [10.67.102.197] (10.67.102.197) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 11 Jan 2021 11:48:19 +0800
Subject: Re: [PATCH v2] proc_sysctl: fix oops caused by incorrect command
 parameters.
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
CC:     Kees Cook <keescook@chromium.org>, <linux-kernel@vger.kernel.org>,
        <mcgrof@kernel.org>, <yzaikin@google.com>, <adobriyan@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <vbabka@suse.cz>,
        <wangle6@huawei.com>
References: <20210108023339.55917-1-nixiaoming@huawei.com>
 <20210108092145.GX13207@dhcp22.suse.cz>
 <829bbba0-d3bb-a114-af81-df7390082958@huawei.com>
 <20210108114718.GA13207@dhcp22.suse.cz> <202101081152.0CB22390@keescook>
 <20210108201025.GA17019@dhcp22.suse.cz>
 <20210108175008.da3c60a6e402f5f1ddab2a65@linux-foundation.org>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <bc098af4-c0cd-212e-d09d-46d617d0acab@huawei.com>
Date:   Mon, 11 Jan 2021 11:48:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20210108175008.da3c60a6e402f5f1ddab2a65@linux-foundation.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/1/9 9:50, Andrew Morton wrote:
> On Fri, 8 Jan 2021 21:10:25 +0100 Michal Hocko <mhocko@suse.com> wrote:
> 
>>>> Why would that matter? A missing value is clearly a error path and it
>>>> should be reported.
>>>
>>> This test is in the correct place. I think it's just a question of the
>>> return values.
>>
>> I was probably not clear. The test for val is at the right place. I
>> would just expect -EINVAL and have the generic code to report.
> 
> It does seem a bit screwy that process_sysctl_arg() returns zero in all
> situations (parse_args() is set up to handle an error return from it).
> But this patch is consistent with all the other error handling in
> process_sysctl_arg().
> .
> 


Set the kernel startup parameter to "nosmp nokaslr hung_task_panic"
and test the startup logs of different patches.

patch1:
	+++ b/fs/proc/proc_sysctl.c
	@@ -1757,6 +1757,11 @@ static int process_sysctl_arg(char *param, char 
*val,
			loff_t pos = 0;
			ssize_t wret;

	+       if (!val) {
	+               pr_err("Missing param value! Expected 
'%s=...value...'\n", param);
	+               return 0;
	+       }
	+
			if (strncmp(param, "sysctl", sizeof("sysctl") - 1) == 0) {
					param += sizeof("sysctl") - 1;

sysctl log for patch1:
	Missing param value! Expected 'nosmp=...value...'
	Missing param value! Expected 'nokaslr=...value...'
	Missing param value! Expected 'hung_task_panic=...value...'

patch2:
	+++ b/fs/proc/proc_sysctl.c
	@@ -1756,6 +1756,8 @@ static int process_sysctl_arg(char *param, char *val,
			int err;
			loff_t pos = 0;
			ssize_t wret;
	+       if (!val)
	+               return -EINVAL;

			if (strncmp(param, "sysctl", sizeof("sysctl") - 1) == 0) {
					param += sizeof("sysctl") - 1;

sysctl log for patch2:
	Setting sysctl args: `' invalid for parameter `nosmp'
	Setting sysctl args: `' invalid for parameter `nokaslr'
	Setting sysctl args: `' invalid for parameter `hung_task_panic'

patch3:
	+++ b/fs/proc/proc_sysctl.c
	@@ -1770,6 +1770,9 @@ static int process_sysctl_arg(char *param, char *val,
							return 0;
			}

	+       if (!val)
	+               return -EINVAL;
	+
			/*
			 * To set sysctl options, we use a temporary mount of proc, look up the
			 * respective sys/ file and write to it. To avoid mounting it when no

sysctl log for patch3:
	Setting sysctl args: `' invalid for parameter `hung_task_panic'

patch4:
	+++ b/fs/proc/proc_sysctl.c
	@@ -1757,6 +1757,9 @@ static int process_sysctl_arg(char *param, char *val,
			loff_t pos = 0;
			ssize_t wret;

	+       if (!val)
	+               return 0;
	+
			if (strncmp(param, "sysctl", sizeof("sysctl") - 1) == 0) {
					param += sizeof("sysctl") - 1;

sysctl log for patch3:
	no log

When process_sysctl_arg() is called, the param parameter may not be the 
sysctl parameter.

Patch3 or patch4, which is better?

Thanks
Xiaoming Ni

