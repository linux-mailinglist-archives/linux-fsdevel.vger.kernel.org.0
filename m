Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6195625719C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 03:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHaBnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 21:43:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59108 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726454AbgHaBnk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:43:40 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3608E90A6B87991AE549;
        Mon, 31 Aug 2020 09:43:37 +0800 (CST)
Received: from [127.0.0.1] (10.67.76.251) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 31 Aug 2020
 09:43:31 +0800
Subject: Re: [NAK] Re: [PATCH] fs: Optimized fget to improve performance
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yuqi Jin <jinyuqi@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
References: <1598523584-25601-1-git-send-email-zhangshaokun@hisilicon.com>
 <20200827142848.GZ1236603@ZenIV.linux.org.uk>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <dfa0ec1a-87fc-b17b-4d4a-c2d5c44e6dde@hisilicon.com>
Date:   Mon, 31 Aug 2020 09:43:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200827142848.GZ1236603@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.76.251]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

ÔÚ 2020/8/27 22:28, Al Viro Ð´µÀ:
> On Thu, Aug 27, 2020 at 06:19:44PM +0800, Shaokun Zhang wrote:
>> From: Yuqi Jin <jinyuqi@huawei.com>
>>
>> It is well known that the performance of atomic_add is better than that of
>> atomic_cmpxchg.
>> The initial value of @f_count is 1. While @f_count is increased by 1 in
>> __fget_files, it will go through three phases: > 0, < 0, and = 0. When the
>> fixed value 0 is used as the condition for terminating the increase of 1,
>> only atomic_cmpxchg can be used. When we use < 0 as the condition for
>> stopping plus 1, we can use atomic_add to obtain better performance.
> 
> Suppose another thread has just removed it from the descriptor table.
> 
>> +static inline bool get_file_unless_negative(atomic_long_t *v, long a)
>> +{
>> +	long c = atomic_long_read(v);
>> +
>> +	if (c <= 0)
>> +		return 0;
> 
> Still 1.  Now the other thread has gotten to dropping the last reference,
> decremented counter to zero and committed to freeing the struct file.
> 

Apologies that I missed it.

>> +
>> +	return atomic_long_add_return(a, v) - 1;
> 
> ... and you increment that sucker back to 1.  Sure, you return 0, so the
> caller does nothing to that struct file.  Which includes undoing the
> changes to its refecount.
> 
> In the meanwhile, the third thread does fget on the same descriptor,
> and there we end up bumping the refcount to 2 and succeeding.  Which
> leaves the caller with reference to already doomed struct file...
> 
> 	IOW, NAK - this is completely broken.  The whole point of
> atomic_long_add_unless() is that the check and conditional increment
> are atomic.  Together.  That's what your optimization takes out.
> 

How about this? We try to replace atomic_cmpxchg with atomic_add to improve
performance. The atomic_add does not check the current f_count value.
Therefore, the number of online CPUs is reserved to prevent multi-core
competition.

+
+static inline bool get_file_unless(atomic_long_t *v, long a)
+{
+       long cpus = num_online_cpus();
+       long c = atomic_long_read(v);
+       long ret;
+
+       if (c > cpus || c < -cpus)
+               ret = atomic_long_add_return(a, v) - a;
+       else
+               ret = atomic_long_add_unless(v, a, 0);
+
+       return ret;
+}
+
 #define get_file_rcu_many(x, cnt)      \
-       atomic_long_add_unless(&(x)->f_count, (cnt), 0)
+       get_file_unless(&(x)->f_count, (cnt))

Thanks,
Shaokun

> .
> 

