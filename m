Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159201DA703
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 03:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgETBOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 21:14:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56808 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbgETBOV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 21:14:21 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 45F0110543B7D5B6A0A6;
        Wed, 20 May 2020 09:14:19 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 20 May 2020
 09:14:08 +0800
Subject: Re: [PATCH v4 2/4] sysctl: Move some boundary constants form sysctl.c
 to sysctl_vals
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        <keescook@chromium.org>
CC:     <mcgrof@kernel.org>, <yzaikin@google.com>, <adobriyan@gmail.com>,
        <mingo@kernel.org>, <gpiccoli@canonical.com>, <rdna@fb.com>,
        <patrick.bellasi@arm.com>, <sfr@canb.auug.org.au>,
        <akpm@linux-foundation.org>, <mhocko@suse.com>, <vbabka@suse.cz>,
        <tglx@linutronix.de>, <peterz@infradead.org>,
        <Jisheng.Zhang@synaptics.com>, <khlebnikov@yandex-team.ru>,
        <bigeasy@linutronix.de>, <pmladek@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <wangle6@huawei.com>, <alex.huangjianhui@huawei.com>
References: <1589859071-25898-1-git-send-email-nixiaoming@huawei.com>
 <1589859071-25898-3-git-send-email-nixiaoming@huawei.com>
 <1bf1aefb-adfd-4f43-35c7-5b320d43faf8@i-love.sakura.ne.jp>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <550a55b8-d2a8-0de3-0bed-8f93a4513efe@huawei.com>
Date:   Wed, 20 May 2020 09:14:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1bf1aefb-adfd-4f43-35c7-5b320d43faf8@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/5/19 12:44, Tetsuo Handa wrote:
> On 2020/05/19 12:31, Xiaoming Ni wrote:
>> Some boundary (.extra1 .extra2) constants (E.g: neg_one two) in
>> sysctl.c are used in multiple features. Move these variables to
>> sysctl_vals to avoid adding duplicate variables when cleaning up
>> sysctls table.
>>
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> I feel that it is use of
> 
> 	void *extra1;
> 	void *extra2;
> 
> in "struct ctl_table" that requires constant values indirection.
> Can't we get rid of sysctl_vals using some "union" like below?
> 
> struct ctl_table {
> 	const char *procname;           /* Text ID for /proc/sys, or zero */
> 	void *data;
> 	int maxlen;
> 	umode_t mode;
> 	struct ctl_table *child;        /* Deprecated */
> 	proc_handler *proc_handler;     /* Callback for text formatting */
> 	struct ctl_table_poll *poll;
> 	union {
> 		void *min_max_ptr[2];
> 		int min_max_int[2];
> 		long min_max_long[2];
> 	};
> } __randomize_layout;
> 
> .
> 

net/decnet/dn_dev.c:
static void dn_dev_sysctl_register(struct net_device *dev, struct 
dn_dev_parms *parms)
{
	struct dn_dev_sysctl_table *t;
	int i;

	char path[sizeof("net/decnet/conf/") + IFNAMSIZ];

	t = kmemdup(&dn_dev_sysctl, sizeof(*t), GFP_KERNEL);
	if (t == NULL)
		return;

	for(i = 0; i < ARRAY_SIZE(t->dn_dev_vars) - 1; i++) {
		long offset = (long)t->dn_dev_vars[i].data;
		t->dn_dev_vars[i].data = ((char *)parms) + offset;
	}

	snprintf(path, sizeof(path), "net/decnet/conf/%s",
		dev? dev->name : parms->name);

	t->dn_dev_vars[0].extra1 = (void *)dev;

	t->sysctl_header = register_net_sysctl(&init_net, path, t->dn_dev_vars);
	if (t->sysctl_header == NULL)
		kfree(t);
	else
		parms->sysctl = t;
}

A small amount of code is not used as a boundary value when using 
extra1. This scenario may not be suitable for renaming to min_max_ptr.

Should we add const to extra1 extra2 ?

--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -124,8 +124,8 @@ struct ctl_table {
         struct ctl_table *child;        /* Deprecated */
         proc_handler *proc_handler;     /* Callback for text formatting */
         struct ctl_table_poll *poll;
-       void *extra1;
-       void *extra2;
+       const void *extra1;
+       const void *extra2;
  } __randomize_layout;


Thanks
Xiaoming Ni







