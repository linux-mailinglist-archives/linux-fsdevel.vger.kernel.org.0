Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F963822E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 02:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfFGAan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 20:30:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44358 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGAan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 20:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8+AuuVQwp2vg7JCBlgfWhyxi/K1ZGGkAIy7A/DW1qrc=; b=iBJNl485Nbobtm7jDHlWxroVj1
        nhhsUqpoO6euTOiWGbSBoHPpiCOcd7j9ofdMlmclDEIbGX37O4kX4V7M97vTx3OQ3r7DLlWq8RGf7
        NyyyCKBTVhjbXcvj0KQi5EAtVCDYG0Bm9vsdAb/VttFT4++HArJ6oF3OvBhFhCPZAfKlOi3gXeopf
        VnvDD4DxYRLBDD3XHIGPHc7+CVt+mPxW4wWVbick+RNdiSRFX1Yt/iELFOiGCojbJ4OOmYCahWHLz
        zV1DcKZMxnadiUhn09CxbgnXgY5MM3USvZq7DrsIKF0189wHzv2htonmZ+W2Oq3brVEGV0JwdAP2O
        R4Ve4qMQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hZ2mF-000891-RE; Fri, 07 Jun 2019 00:30:40 +0000
Subject: Re: [PATCH linux-next] mpls: don't build sysctl related code when
 sysctl is disabled
To:     Matteo Croce <mcroce@redhat.com>, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190606235742.1968-1-mcroce@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bc06bf54-9b3d-b1eb-5ce3-2c764e15e9ce@infradead.org>
Date:   Thu, 6 Jun 2019 17:30:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606235742.1968-1-mcroce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/6/19 4:57 PM, Matteo Croce wrote:
> Some sysctl related code and data structures are never referenced
> when CONFIG_SYSCTL is not set.
> While this is usually harmless, it produces a build failure since sysctl
> shared variables exist, due to missing sysctl_vals symbol:
> 
>     ld: net/mpls/af_mpls.o: in function `mpls_platform_labels':
>     af_mpls.c:(.text+0x162a): undefined reference to `sysctl_vals'
>     ld: net/mpls/af_mpls.o:(.rodata+0x830): undefined reference to `sysctl_vals'
>     ld: net/mpls/af_mpls.o:(.rodata+0x838): undefined reference to `sysctl_vals'
>     ld: net/mpls/af_mpls.o:(.rodata+0x870): undefined reference to `sysctl_vals'
> 
> Fix this by moving all sysctl related code under #ifdef CONFIG_SYSCTL
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Builds for me.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> ---
>  net/mpls/af_mpls.c | 389 ++++++++++++++++++++++++---------------------
>  1 file changed, 204 insertions(+), 185 deletions(-)
> 
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index c312741df2ce..5aacbf129ec5 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -37,9 +37,6 @@
>  
>  #define MPLS_NEIGH_TABLE_UNSPEC (NEIGH_LINK_TABLE + 1)
>  
> -static int label_limit = (1 << 20) - 1;
> -static int ttl_max = 255;
> -
>  #if IS_ENABLED(CONFIG_NET_IP_TUNNEL)
>  static size_t ipgre_mpls_encap_hlen(struct ip_tunnel_encap *e)
>  {
> @@ -1179,31 +1176,6 @@ static int mpls_netconf_msgsize_devconf(int type)
>  	return size;
>  }
>  
> -static void mpls_netconf_notify_devconf(struct net *net, int event,
> -					int type, struct mpls_dev *mdev)
> -{
> -	struct sk_buff *skb;
> -	int err = -ENOBUFS;
> -
> -	skb = nlmsg_new(mpls_netconf_msgsize_devconf(type), GFP_KERNEL);
> -	if (!skb)
> -		goto errout;
> -
> -	err = mpls_netconf_fill_devconf(skb, mdev, 0, 0, event, 0, type);
> -	if (err < 0) {
> -		/* -EMSGSIZE implies BUG in mpls_netconf_msgsize_devconf() */
> -		WARN_ON(err == -EMSGSIZE);
> -		kfree_skb(skb);
> -		goto errout;
> -	}
> -
> -	rtnl_notify(skb, net, 0, RTNLGRP_MPLS_NETCONF, NULL, GFP_KERNEL);
> -	return;
> -errout:
> -	if (err < 0)
> -		rtnl_set_sk_err(net, RTNLGRP_MPLS_NETCONF, err);
> -}
> -
>  static const struct nla_policy devconf_mpls_policy[NETCONFA_MAX + 1] = {
>  	[NETCONFA_IFINDEX]	= { .len = sizeof(int) },
>  };
> @@ -1362,6 +1334,36 @@ static int mpls_netconf_dump_devconf(struct sk_buff *skb,
>  #define MPLS_PERDEV_SYSCTL_OFFSET(field)	\
>  	(&((struct mpls_dev *)0)->field)
>  
> +#ifdef CONFIG_SYSCTL
> +
> +static int label_limit = (1 << 20) - 1;
> +static int ttl_max = 255;
> +
> +static void mpls_netconf_notify_devconf(struct net *net, int event,
> +					int type, struct mpls_dev *mdev)
> +{
> +	struct sk_buff *skb;
> +	int err = -ENOBUFS;
> +
> +	skb = nlmsg_new(mpls_netconf_msgsize_devconf(type), GFP_KERNEL);
> +	if (!skb)
> +		goto errout;
> +
> +	err = mpls_netconf_fill_devconf(skb, mdev, 0, 0, event, 0, type);
> +	if (err < 0) {
> +		/* -EMSGSIZE implies BUG in mpls_netconf_msgsize_devconf() */
> +		WARN_ON(err == -EMSGSIZE);
> +		kfree_skb(skb);
> +		goto errout;
> +	}
> +
> +	rtnl_notify(skb, net, 0, RTNLGRP_MPLS_NETCONF, NULL, GFP_KERNEL);
> +	return;
> +errout:
> +	if (err < 0)
> +		rtnl_set_sk_err(net, RTNLGRP_MPLS_NETCONF, err);
> +}
> +
>  static int mpls_conf_proc(struct ctl_table *ctl, int write,
>  			  void __user *buffer,
>  			  size_t *lenp, loff_t *ppos)
> @@ -1445,6 +1447,173 @@ static void mpls_dev_sysctl_unregister(struct net_device *dev,
>  	mpls_netconf_notify_devconf(net, RTM_DELNETCONF, 0, mdev);
>  }
>  
> +static int resize_platform_label_table(struct net *net, size_t limit)
> +{
> +	size_t size = sizeof(struct mpls_route *) * limit;
> +	size_t old_limit;
> +	size_t cp_size;
> +	struct mpls_route __rcu **labels = NULL, **old;
> +	struct mpls_route *rt0 = NULL, *rt2 = NULL;
> +	unsigned index;
> +
> +	if (size) {
> +		labels = kvzalloc(size, GFP_KERNEL);
> +		if (!labels)
> +			goto nolabels;
> +	}
> +
> +	/* In case the predefined labels need to be populated */
> +	if (limit > MPLS_LABEL_IPV4NULL) {
> +		struct net_device *lo = net->loopback_dev;
> +		rt0 = mpls_rt_alloc(1, lo->addr_len, 0);
> +		if (IS_ERR(rt0))
> +			goto nort0;
> +		RCU_INIT_POINTER(rt0->rt_nh->nh_dev, lo);
> +		rt0->rt_protocol = RTPROT_KERNEL;
> +		rt0->rt_payload_type = MPT_IPV4;
> +		rt0->rt_ttl_propagate = MPLS_TTL_PROP_DEFAULT;
> +		rt0->rt_nh->nh_via_table = NEIGH_LINK_TABLE;
> +		rt0->rt_nh->nh_via_alen = lo->addr_len;
> +		memcpy(__mpls_nh_via(rt0, rt0->rt_nh), lo->dev_addr,
> +		       lo->addr_len);
> +	}
> +	if (limit > MPLS_LABEL_IPV6NULL) {
> +		struct net_device *lo = net->loopback_dev;
> +		rt2 = mpls_rt_alloc(1, lo->addr_len, 0);
> +		if (IS_ERR(rt2))
> +			goto nort2;
> +		RCU_INIT_POINTER(rt2->rt_nh->nh_dev, lo);
> +		rt2->rt_protocol = RTPROT_KERNEL;
> +		rt2->rt_payload_type = MPT_IPV6;
> +		rt2->rt_ttl_propagate = MPLS_TTL_PROP_DEFAULT;
> +		rt2->rt_nh->nh_via_table = NEIGH_LINK_TABLE;
> +		rt2->rt_nh->nh_via_alen = lo->addr_len;
> +		memcpy(__mpls_nh_via(rt2, rt2->rt_nh), lo->dev_addr,
> +		       lo->addr_len);
> +	}
> +
> +	rtnl_lock();
> +	/* Remember the original table */
> +	old = rtnl_dereference(net->mpls.platform_label);
> +	old_limit = net->mpls.platform_labels;
> +
> +	/* Free any labels beyond the new table */
> +	for (index = limit; index < old_limit; index++)
> +		mpls_route_update(net, index, NULL, NULL);
> +
> +	/* Copy over the old labels */
> +	cp_size = size;
> +	if (old_limit < limit)
> +		cp_size = old_limit * sizeof(struct mpls_route *);
> +
> +	memcpy(labels, old, cp_size);
> +
> +	/* If needed set the predefined labels */
> +	if ((old_limit <= MPLS_LABEL_IPV6NULL) &&
> +	    (limit > MPLS_LABEL_IPV6NULL)) {
> +		RCU_INIT_POINTER(labels[MPLS_LABEL_IPV6NULL], rt2);
> +		rt2 = NULL;
> +	}
> +
> +	if ((old_limit <= MPLS_LABEL_IPV4NULL) &&
> +	    (limit > MPLS_LABEL_IPV4NULL)) {
> +		RCU_INIT_POINTER(labels[MPLS_LABEL_IPV4NULL], rt0);
> +		rt0 = NULL;
> +	}
> +
> +	/* Update the global pointers */
> +	net->mpls.platform_labels = limit;
> +	rcu_assign_pointer(net->mpls.platform_label, labels);
> +
> +	rtnl_unlock();
> +
> +	mpls_rt_free(rt2);
> +	mpls_rt_free(rt0);
> +
> +	if (old) {
> +		synchronize_rcu();
> +		kvfree(old);
> +	}
> +	return 0;
> +
> +nort2:
> +	mpls_rt_free(rt0);
> +nort0:
> +	kvfree(labels);
> +nolabels:
> +	return -ENOMEM;
> +}
> +
> +static int mpls_platform_labels(struct ctl_table *table, int write,
> +				void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct net *net = table->data;
> +	int platform_labels = net->mpls.platform_labels;
> +	int ret;
> +	struct ctl_table tmp = {
> +		.procname	= table->procname,
> +		.data		= &platform_labels,
> +		.maxlen		= sizeof(int),
> +		.mode		= table->mode,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= &label_limit,
> +	};
> +
> +	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
> +
> +	if (write && ret == 0)
> +		ret = resize_platform_label_table(net, platform_labels);
> +
> +	return ret;
> +}
> +
> +#define MPLS_NS_SYSCTL_OFFSET(field)		\
> +	(&((struct net *)0)->field)
> +
> +static const struct ctl_table mpls_table[] = {
> +	{
> +		.procname	= "platform_labels",
> +		.data		= NULL,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= mpls_platform_labels,
> +	},
> +	{
> +		.procname	= "ip_ttl_propagate",
> +		.data		= MPLS_NS_SYSCTL_OFFSET(mpls.ip_ttl_propagate),
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +	{
> +		.procname	= "default_ttl",
> +		.data		= MPLS_NS_SYSCTL_OFFSET(mpls.default_ttl),
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= &ttl_max,
> +	},
> +	{ }
> +};
> +
> +#else
> +
> +static int mpls_dev_sysctl_register(struct net_device *dev,
> +				    struct mpls_dev *mdev)
> +{
> +	return 0;
> +}
> +
> +static void mpls_dev_sysctl_unregister(struct net_device *dev,
> +				       struct mpls_dev *mdev)
> +{
> +}
> +
> +#endif
> +
>  static struct mpls_dev *mpls_add_dev(struct net_device *dev)
>  {
>  	struct mpls_dev *mdev;
> @@ -2497,168 +2666,12 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
>  	return err;
>  }
>  
> -static int resize_platform_label_table(struct net *net, size_t limit)
> -{
> -	size_t size = sizeof(struct mpls_route *) * limit;
> -	size_t old_limit;
> -	size_t cp_size;
> -	struct mpls_route __rcu **labels = NULL, **old;
> -	struct mpls_route *rt0 = NULL, *rt2 = NULL;
> -	unsigned index;
> -
> -	if (size) {
> -		labels = kvzalloc(size, GFP_KERNEL);
> -		if (!labels)
> -			goto nolabels;
> -	}
> -
> -	/* In case the predefined labels need to be populated */
> -	if (limit > MPLS_LABEL_IPV4NULL) {
> -		struct net_device *lo = net->loopback_dev;
> -		rt0 = mpls_rt_alloc(1, lo->addr_len, 0);
> -		if (IS_ERR(rt0))
> -			goto nort0;
> -		RCU_INIT_POINTER(rt0->rt_nh->nh_dev, lo);
> -		rt0->rt_protocol = RTPROT_KERNEL;
> -		rt0->rt_payload_type = MPT_IPV4;
> -		rt0->rt_ttl_propagate = MPLS_TTL_PROP_DEFAULT;
> -		rt0->rt_nh->nh_via_table = NEIGH_LINK_TABLE;
> -		rt0->rt_nh->nh_via_alen = lo->addr_len;
> -		memcpy(__mpls_nh_via(rt0, rt0->rt_nh), lo->dev_addr,
> -		       lo->addr_len);
> -	}
> -	if (limit > MPLS_LABEL_IPV6NULL) {
> -		struct net_device *lo = net->loopback_dev;
> -		rt2 = mpls_rt_alloc(1, lo->addr_len, 0);
> -		if (IS_ERR(rt2))
> -			goto nort2;
> -		RCU_INIT_POINTER(rt2->rt_nh->nh_dev, lo);
> -		rt2->rt_protocol = RTPROT_KERNEL;
> -		rt2->rt_payload_type = MPT_IPV6;
> -		rt2->rt_ttl_propagate = MPLS_TTL_PROP_DEFAULT;
> -		rt2->rt_nh->nh_via_table = NEIGH_LINK_TABLE;
> -		rt2->rt_nh->nh_via_alen = lo->addr_len;
> -		memcpy(__mpls_nh_via(rt2, rt2->rt_nh), lo->dev_addr,
> -		       lo->addr_len);
> -	}
> -
> -	rtnl_lock();
> -	/* Remember the original table */
> -	old = rtnl_dereference(net->mpls.platform_label);
> -	old_limit = net->mpls.platform_labels;
> -
> -	/* Free any labels beyond the new table */
> -	for (index = limit; index < old_limit; index++)
> -		mpls_route_update(net, index, NULL, NULL);
> -
> -	/* Copy over the old labels */
> -	cp_size = size;
> -	if (old_limit < limit)
> -		cp_size = old_limit * sizeof(struct mpls_route *);
> -
> -	memcpy(labels, old, cp_size);
> -
> -	/* If needed set the predefined labels */
> -	if ((old_limit <= MPLS_LABEL_IPV6NULL) &&
> -	    (limit > MPLS_LABEL_IPV6NULL)) {
> -		RCU_INIT_POINTER(labels[MPLS_LABEL_IPV6NULL], rt2);
> -		rt2 = NULL;
> -	}
> -
> -	if ((old_limit <= MPLS_LABEL_IPV4NULL) &&
> -	    (limit > MPLS_LABEL_IPV4NULL)) {
> -		RCU_INIT_POINTER(labels[MPLS_LABEL_IPV4NULL], rt0);
> -		rt0 = NULL;
> -	}
> -
> -	/* Update the global pointers */
> -	net->mpls.platform_labels = limit;
> -	rcu_assign_pointer(net->mpls.platform_label, labels);
> -
> -	rtnl_unlock();
> -
> -	mpls_rt_free(rt2);
> -	mpls_rt_free(rt0);
> -
> -	if (old) {
> -		synchronize_rcu();
> -		kvfree(old);
> -	}
> -	return 0;
> -
> -nort2:
> -	mpls_rt_free(rt0);
> -nort0:
> -	kvfree(labels);
> -nolabels:
> -	return -ENOMEM;
> -}
> -
> -static int mpls_platform_labels(struct ctl_table *table, int write,
> -				void __user *buffer, size_t *lenp, loff_t *ppos)
> -{
> -	struct net *net = table->data;
> -	int platform_labels = net->mpls.platform_labels;
> -	int ret;
> -	struct ctl_table tmp = {
> -		.procname	= table->procname,
> -		.data		= &platform_labels,
> -		.maxlen		= sizeof(int),
> -		.mode		= table->mode,
> -		.extra1		= SYSCTL_ZERO,
> -		.extra2		= &label_limit,
> -	};
> -
> -	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
> -
> -	if (write && ret == 0)
> -		ret = resize_platform_label_table(net, platform_labels);
> -
> -	return ret;
> -}
> -
> -#define MPLS_NS_SYSCTL_OFFSET(field)		\
> -	(&((struct net *)0)->field)
> -
> -static const struct ctl_table mpls_table[] = {
> -	{
> -		.procname	= "platform_labels",
> -		.data		= NULL,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> -		.proc_handler	= mpls_platform_labels,
> -	},
> -	{
> -		.procname	= "ip_ttl_propagate",
> -		.data		= MPLS_NS_SYSCTL_OFFSET(mpls.ip_ttl_propagate),
> -		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_ONE,
> -	},
> -	{
> -		.procname	= "default_ttl",
> -		.data		= MPLS_NS_SYSCTL_OFFSET(mpls.default_ttl),
> -		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ONE,
> -		.extra2		= &ttl_max,
> -	},
> -	{ }
> -};
> -
>  static int mpls_net_init(struct net *net)
>  {
> +#ifdef CONFIG_SYSCTL
>  	struct ctl_table *table;
>  	int i;
>  
> -	net->mpls.platform_labels = 0;
> -	net->mpls.platform_label = NULL;
> -	net->mpls.ip_ttl_propagate = 1;
> -	net->mpls.default_ttl = 255;
> -
>  	table = kmemdup(mpls_table, sizeof(mpls_table), GFP_KERNEL);
>  	if (table == NULL)
>  		return -ENOMEM;
> @@ -2674,6 +2687,12 @@ static int mpls_net_init(struct net *net)
>  		kfree(table);
>  		return -ENOMEM;
>  	}
> +#endif
> +
> +	net->mpls.platform_labels = 0;
> +	net->mpls.platform_label = NULL;
> +	net->mpls.ip_ttl_propagate = 1;
> +	net->mpls.default_ttl = 255;
>  
>  	return 0;
>  }
> 


-- 
~Randy
