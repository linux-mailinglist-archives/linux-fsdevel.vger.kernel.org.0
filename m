Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD59233323
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 15:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgG3Nca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 09:32:30 -0400
Received: from relay.sw.ru ([185.231.240.75]:51876 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbgG3Nca (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:32:30 -0400
Received: from [192.168.15.64]
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k18fI-0003lW-N6; Thu, 30 Jul 2020 16:32:08 +0300
Subject: Re: [PATCH 09/23] ns: Introduce ns_idr to be able to iterate all
 allocated namespaces in the system
To:     Matthew Wilcox <willy@infradead.org>
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <159611040870.535980.13460189038999722608.stgit@localhost.localdomain>
 <20200730122319.GC23808@casper.infradead.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <485c01e6-a4ee-5076-878e-6303e6d8d5f3@virtuozzo.com>
Date:   Thu, 30 Jul 2020 16:32:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730122319.GC23808@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30.07.2020 15:23, Matthew Wilcox wrote:
> On Thu, Jul 30, 2020 at 03:00:08PM +0300, Kirill Tkhai wrote:
>> This patch introduces a new IDR and functions to add/remove and iterate
>> registered namespaces in the system. It will be used to list namespaces
>> in /proc/namespaces/... in next patches.
> 
> Looks like you could use an XArray for this and it would be fewer lines of
> code.
> 
>>  
>>  static struct vfsmount *nsfs_mnt;
>> +static DEFINE_SPINLOCK(ns_lock);
>> +static DEFINE_IDR(ns_idr);
> 
> XArray includes its own spinlock.
> 
>> +/*
>> + * Add a newly created ns to ns_idr. The ns must be fully
>> + * initialized since it becomes available for ns_get_next()
>> + * right after we exit this function.
>> + */
>> +int ns_idr_register(struct ns_common *ns)
>> +{
>> +	int ret, id = ns->inum - PROC_NS_MIN_INO;
>> +
>> +	if (WARN_ON(id < 0))
>> +		return -EINVAL;
>> +
>> +	idr_preload(GFP_KERNEL);
>> +	spin_lock_irq(&ns_lock);
>> +	ret = idr_alloc(&ns_idr, ns, id, id + 1, GFP_ATOMIC);
>> +	spin_unlock_irq(&ns_lock);
>> +	idr_preload_end();
>> +	return ret < 0 ? ret : 0;
> 
> This would simply be return xa_insert_irq(...);
> 
>> +}
>> +
>> +/*
>> + * Remove a dead ns from ns_idr. Note, that ns memory must
>> + * be freed not earlier then one RCU grace period after
>> + * this function, since ns_get_next() uses RCU to iterate the IDR.
>> + */
>> +void ns_idr_unregister(struct ns_common *ns)
>> +{
>> +	int id = ns->inum - PROC_NS_MIN_INO;
>> +	unsigned long flags;
>> +
>> +	if (WARN_ON(id < 0))
>> +		return;
>> +
>> +	spin_lock_irqsave(&ns_lock, flags);
>> +	idr_remove(&ns_idr, id);
>> +	spin_unlock_irqrestore(&ns_lock, flags);
>> +}
> 
> xa_erase_irqsave();

static inline void *xa_erase_irqsave(struct xarray *xa, unsigned long index)
{
	unsigned long flags;
        void *entry;

        xa_lock_irqsave(xa, flags);
        entry = __xa_erase(xa, index);
        xa_unlock_irqrestore(xa, flags);

        return entry;
}

>> +
>> +/*
>> + * This returns ns with inum greater than @id or NULL.
>> + * @id is updated to refer the ns inum.
>> + */
>> +struct ns_common *ns_get_next(unsigned int *id)
>> +{
>> +	struct ns_common *ns;
>> +
>> +	if (*id < PROC_NS_MIN_INO - 1)
>> +		*id = PROC_NS_MIN_INO - 1;
>> +
>> +	*id += 1;
>> +	*id -= PROC_NS_MIN_INO;
>> +
>> +	rcu_read_lock();
>> +	do {
>> +		ns = idr_get_next(&ns_idr, id);
>> +		if (!ns)
>> +			break;
> 
> xa_find_after();
> 
> You'll want a temporary unsigned long to work with ...
> 
>> +		if (!refcount_inc_not_zero(&ns->count)) {
>> +			ns = NULL;
>> +			*id += 1;
> 
> you won't need this increment.

Why? I don't see a way xarray allows to avoid this.
