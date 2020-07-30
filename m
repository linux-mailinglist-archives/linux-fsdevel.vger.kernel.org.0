Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982A12333C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 16:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgG3OHO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 10:07:14 -0400
Received: from relay.sw.ru ([185.231.240.75]:60808 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726581AbgG3OHO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:07:14 -0400
Received: from [192.168.15.64]
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k19Cu-00048F-94; Thu, 30 Jul 2020 17:06:52 +0300
Subject: Re: [PATCH 01/23] ns: Add common refcount into ns_common add use it
 as counter for net_ns
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <159611036589.535980.1765795847221907147.stgit@localhost.localdomain>
 <20200730133526.4lhkmlamgxjdssip@wittgenstein>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <7d30f8ec-d0b7-3bae-942f-49e2f8f233e9@virtuozzo.com>
Date:   Thu, 30 Jul 2020 17:07:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730133526.4lhkmlamgxjdssip@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30.07.2020 16:35, Christian Brauner wrote:
> On Thu, Jul 30, 2020 at 02:59:25PM +0300, Kirill Tkhai wrote:
>> Currently, every type of namespaces has its own counter,
>> which is stored in ns-specific part. Say, @net has
>> struct net::count, @pid has struct pid_namespace::kref, etc.
>>
>> This patchset introduces unified counter for all types
>> of namespaces, and converts net namespace to use it first.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
> 
> Any reason the refcount changes need to be tied to the procfs changes?
> Seems that should be a separate cleanup patchset which we can take
> independent of procfs changes.

Yes, patches [1-8] are cleanup, it may go separately. 

For me there is no a problem to resend them also as a separate patchset,
say at v2, or if there is a change in 1-8, but I'm afraid to bomb mailboxes.

If there is no a request for rework in 1-8, can they be picked directly from here?

>>  include/linux/ns_common.h     |    1 +
>>  include/net/net_namespace.h   |   11 ++++-------
>>  net/core/net-sysfs.c          |    6 +++---
>>  net/core/net_namespace.c      |    6 +++---
>>  net/ipv4/inet_timewait_sock.c |    4 ++--
>>  net/ipv4/tcp_metrics.c        |    2 +-
>>  6 files changed, 14 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
>> index 5fbc4000358f..27db02ebdf36 100644
>> --- a/include/linux/ns_common.h
>> +++ b/include/linux/ns_common.h
>> @@ -8,6 +8,7 @@ struct ns_common {
>>  	atomic_long_t stashed;
>>  	const struct proc_ns_operations *ops;
>>  	unsigned int inum;
>> +	refcount_t count;
>>  };
>>  
>>  #endif
>> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
>> index 2ee5901bec7a..cb4b33d7834b 100644
>> --- a/include/net/net_namespace.h
>> +++ b/include/net/net_namespace.h
>> @@ -60,9 +60,6 @@ struct net {
>>  	refcount_t		passive;	/* To decide when the network
>>  						 * namespace should be freed.
>>  						 */
>> -	refcount_t		count;		/* To decided when the network
>> -						 *  namespace should be shut down.
>> -						 */
>>  	spinlock_t		rules_mod_lock;
>>  
>>  	unsigned int		dev_unreg_count;
>> @@ -245,7 +242,7 @@ void __put_net(struct net *net);
>>  
>>  static inline struct net *get_net(struct net *net)
>>  {
>> -	refcount_inc(&net->count);
>> +	refcount_inc(&net->ns.count);
>>  	return net;
>>  }
>>  
>> @@ -256,14 +253,14 @@ static inline struct net *maybe_get_net(struct net *net)
>>  	 * exists.  If the reference count is zero this
>>  	 * function fails and returns NULL.
>>  	 */
>> -	if (!refcount_inc_not_zero(&net->count))
>> +	if (!refcount_inc_not_zero(&net->ns.count))
>>  		net = NULL;
>>  	return net;
>>  }
>>  
>>  static inline void put_net(struct net *net)
>>  {
>> -	if (refcount_dec_and_test(&net->count))
>> +	if (refcount_dec_and_test(&net->ns.count))
>>  		__put_net(net);
>>  }
>>  
>> @@ -275,7 +272,7 @@ int net_eq(const struct net *net1, const struct net *net2)
>>  
>>  static inline int check_net(const struct net *net)
>>  {
>> -	return refcount_read(&net->count) != 0;
>> +	return refcount_read(&net->ns.count) != 0;
>>  }
>>  
>>  void net_drop_ns(void *);
>> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
>> index 9de33b594ff2..655a88b0071c 100644
>> --- a/net/core/net-sysfs.c
>> +++ b/net/core/net-sysfs.c
>> @@ -1025,7 +1025,7 @@ net_rx_queue_update_kobjects(struct net_device *dev, int old_num, int new_num)
>>  	while (--i >= new_num) {
>>  		struct kobject *kobj = &dev->_rx[i].kobj;
>>  
>> -		if (!refcount_read(&dev_net(dev)->count))
>> +		if (!refcount_read(&dev_net(dev)->ns.count))
>>  			kobj->uevent_suppress = 1;
>>  		if (dev->sysfs_rx_queue_group)
>>  			sysfs_remove_group(kobj, dev->sysfs_rx_queue_group);
>> @@ -1603,7 +1603,7 @@ netdev_queue_update_kobjects(struct net_device *dev, int old_num, int new_num)
>>  	while (--i >= new_num) {
>>  		struct netdev_queue *queue = dev->_tx + i;
>>  
>> -		if (!refcount_read(&dev_net(dev)->count))
>> +		if (!refcount_read(&dev_net(dev)->ns.count))
>>  			queue->kobj.uevent_suppress = 1;
>>  #ifdef CONFIG_BQL
>>  		sysfs_remove_group(&queue->kobj, &dql_group);
>> @@ -1850,7 +1850,7 @@ void netdev_unregister_kobject(struct net_device *ndev)
>>  {
>>  	struct device *dev = &ndev->dev;
>>  
>> -	if (!refcount_read(&dev_net(ndev)->count))
>> +	if (!refcount_read(&dev_net(ndev)->ns.count))
>>  		dev_set_uevent_suppress(dev, 1);
>>  
>>  	kobject_get(&dev->kobj);
>> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
>> index dcd61aca343e..5f658cbedd34 100644
>> --- a/net/core/net_namespace.c
>> +++ b/net/core/net_namespace.c
>> @@ -44,7 +44,7 @@ static struct key_tag init_net_key_domain = { .usage = REFCOUNT_INIT(1) };
>>  #endif
>>  
>>  struct net init_net = {
>> -	.count		= REFCOUNT_INIT(1),
>> +	.ns.count	= REFCOUNT_INIT(1),
>>  	.dev_base_head	= LIST_HEAD_INIT(init_net.dev_base_head),
>>  #ifdef CONFIG_KEYS
>>  	.key_domain	= &init_net_key_domain,
>> @@ -248,7 +248,7 @@ int peernet2id_alloc(struct net *net, struct net *peer, gfp_t gfp)
>>  {
>>  	int id;
>>  
>> -	if (refcount_read(&net->count) == 0)
>> +	if (refcount_read(&net->ns.count) == 0)
>>  		return NETNSA_NSID_NOT_ASSIGNED;
>>  
>>  	spin_lock(&net->nsid_lock);
>> @@ -328,7 +328,7 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
>>  	int error = 0;
>>  	LIST_HEAD(net_exit_list);
>>  
>> -	refcount_set(&net->count, 1);
>> +	refcount_set(&net->ns.count, 1);
>>  	refcount_set(&net->passive, 1);
>>  	get_random_bytes(&net->hash_mix, sizeof(u32));
>>  	net->dev_base_seq = 1;
>> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
>> index c411c87ae865..437afe392e66 100644
>> --- a/net/ipv4/inet_timewait_sock.c
>> +++ b/net/ipv4/inet_timewait_sock.c
>> @@ -272,14 +272,14 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
>>  				continue;
>>  			tw = inet_twsk(sk);
>>  			if ((tw->tw_family != family) ||
>> -				refcount_read(&twsk_net(tw)->count))
>> +				refcount_read(&twsk_net(tw)->ns.count))
>>  				continue;
>>  
>>  			if (unlikely(!refcount_inc_not_zero(&tw->tw_refcnt)))
>>  				continue;
>>  
>>  			if (unlikely((tw->tw_family != family) ||
>> -				     refcount_read(&twsk_net(tw)->count))) {
>> +				     refcount_read(&twsk_net(tw)->ns.count))) {
>>  				inet_twsk_put(tw);
>>  				goto restart;
>>  			}
>> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
>> index 279db8822439..39710c417565 100644
>> --- a/net/ipv4/tcp_metrics.c
>> +++ b/net/ipv4/tcp_metrics.c
>> @@ -887,7 +887,7 @@ static void tcp_metrics_flush_all(struct net *net)
>>  		pp = &hb->chain;
>>  		for (tm = deref_locked(*pp); tm; tm = deref_locked(*pp)) {
>>  			match = net ? net_eq(tm_net(tm), net) :
>> -				!refcount_read(&tm_net(tm)->count);
>> +				!refcount_read(&tm_net(tm)->ns.count);
>>  			if (match) {
>>  				*pp = tm->tcpm_next;
>>  				kfree_rcu(tm, rcu_head);
>>
>>

