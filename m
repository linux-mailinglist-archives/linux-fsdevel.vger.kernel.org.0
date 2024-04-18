Return-Path: <linux-fsdevel+bounces-17255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1020C8AA129
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 19:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E0F281EA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8286174EFF;
	Thu, 18 Apr 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JMLBZWMe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED7C174EFB
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461611; cv=none; b=ATdnyJOke+3ACIiotVNF2JQh2kq851FGdjSIDZ4pHMYVFjzro57HpELEbgUdAnGbw/foqboC2mJdCdO3hcQ+Lza9ELZJ/fnRU1UN6ao0xPpLWmnPvP0SHj1iZ3UPKBTIJ93j+mXH9dJmEq5CgTuOBHWIAKoB/aJ4oJyEK18+qhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461611; c=relaxed/simple;
	bh=vVoc5zq0qVRDbnyGYqUu5jY97W87uQbiK+3UuEoP9F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWZGvVkbfKBOGCUq8/uqobXTN56OBUFYZY+uLr6/M8hrgee1Hjv8G5vw4TBMdPEvZQDrOEi8Ly2VgSiJXper88URdPFUwqcemyBPLsfRxnNcapplyx0QSiIhrVpDKY10ovJCFrj4ZGYhqykaX6edS8Qax8U9Ke4Nt4b0uc9SmIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JMLBZWMe; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-22fa7e4b0beso734820fac.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 10:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713461608; x=1714066408; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Su/0jhVB60Wlg9G5Him3VvxG/87i2p2Lv2g9MqI6bUU=;
        b=JMLBZWMeoJ3pn4AjTfN4NPROPvKxhG7zRayH4/JQoWirBjKQTbdwp8L5kuyP6meJZq
         xF3Qe9AU9k01C8tIlKlvZZUt8rIgxWP8YJKZjNa+kiJoqpp41Ng9Q2MoElau9z+9Qj7j
         LlygJe2LBcQocZo5FQMsOscxXv57A3G+8A0y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713461608; x=1714066408;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Su/0jhVB60Wlg9G5Him3VvxG/87i2p2Lv2g9MqI6bUU=;
        b=aKtlZU2vki+39ya6Dvgpdfs2VtqD1Wrk0Sah3In2SZfzFjezyxv5LG2IbaboPkx0a4
         zX1Z1UNS5x18cQtsfxkFCUgIwanzC47vKPm2RsJvdfXO8vhZbpNGUo9T7pat8N9CXL9f
         Ew8Ua5J8MMWKVz1C+O+Nmu8WY0JZIQe/V9B19Dsh5AIy8ZbeeEKt48mIgCKfxvBVrZrg
         LaZFAd/aTVQhv0ibrNSyY2EtQmAJlVq8A1qvZc84jwFQvaJqcxV2795fiLodJMcUXDyh
         EozYChtK8Qx6kC+x6Sl1/hEr6pIDqnfNXMw9fZHkinTSKH2Ecde1sueTgSeAntxCXDqM
         dJOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpuwBJFfZfWtPJDrGA5EZ88gq+Wp9InqTtVpMVx1BqkseLK5J2NE9UBYlVNPLsGa8ayZIMJC6d/4E2aX1K0qEAuVWJ/5IV1dqJcuKSDw==
X-Gm-Message-State: AOJu0YwtUsUERiFed0PdIn6KZlOuQ0xhS1IXCp7bSnEjwcIw9tZ/mjGt
	u2Cin64PtnSzSQwCbLdnPeHh2eb/noF+wQqOYYlgv1FfmsZZNtJwPByS4tbsow==
X-Google-Smtp-Source: AGHT+IGA2jtQNRvB9rGrp0xvC3LVrf3b0mrd0c1k+WW3TidBwOQ3bB57iP8v8X9wDFCdBcLCvEqCvQ==
X-Received: by 2002:a05:6870:e8c5:b0:22e:959b:cf74 with SMTP id r5-20020a056870e8c500b0022e959bcf74mr4409603oan.40.1713461608313;
        Thu, 18 Apr 2024 10:33:28 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s21-20020a632155000000b005cd8044c6fesm1689076pgm.23.2024.04.18.10.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 10:33:27 -0700 (PDT)
Date: Thu, 18 Apr 2024 10:33:27 -0700
From: Kees Cook <keescook@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	Joerg Reuter <jreuter@yaina.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-hams@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
	linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2] sysctl: treewide: constify
 ctl_table_header::ctl_table_arg
Message-ID: <202404181026.1E2AA3457@keescook>
References: <20240418-sysctl-const-table-arg-v2-1-4012abc31311@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418-sysctl-const-table-arg-v2-1-4012abc31311@weissschuh.net>

On Thu, Apr 18, 2024 at 11:40:08AM +0200, Thomas Weiﬂschuh wrote:
> To be able to constify instances of struct ctl_tables it is necessary to
> remove ways through which non-const versions are exposed from the
> sysctl core.
> One of these is the ctl_table_arg member of struct ctl_table_header.
> 
> Constify this reference as a prerequisite for the full constification of
> struct ctl_table instances.
> No functional change.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Add link to original monolithic series
> - Send to all maintainers again
> - Link to v1: https://lore.kernel.org/r/20240322-sysctl-const-table-arg-v1-1-88436d34961b@weissschuh.net
> ---
> This is a standalone version of PATCH 11 from my original const-sysctl
> series at
> https://lore.kernel.org/lkml/20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net/
> 
> It is based upon the branch constfy of
> https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/
> 
> This patch is meant to be applied through the sysctl tree.
> 
> It was implemented by manually searching for "ctl_table_arg"
> throughout the tree and inspecing each found site.
> 
> If somebody comes up with a cocciscript for this, I'll be happy to use
> that.

My simple attempt doesn't find any additional instances:

@constify@
identifier VAR;
expression EXP;
@@

-       struct ctl_table *VAR;
+       const struct ctl_table *VAR;
        ...
        VAR = (EXP)->ctl_table_arg

it actually misses a few. :P

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  drivers/net/vrf.c                       | 2 +-
>  include/linux/sysctl.h                  | 2 +-
>  ipc/ipc_sysctl.c                        | 2 +-
>  ipc/mq_sysctl.c                         | 2 +-
>  kernel/ucount.c                         | 2 +-
>  net/ax25/sysctl_net_ax25.c              | 2 +-
>  net/bridge/br_netfilter_hooks.c         | 2 +-
>  net/core/sysctl_net_core.c              | 2 +-
>  net/ieee802154/6lowpan/reassembly.c     | 2 +-
>  net/ipv4/devinet.c                      | 2 +-
>  net/ipv4/ip_fragment.c                  | 2 +-
>  net/ipv4/route.c                        | 2 +-
>  net/ipv4/sysctl_net_ipv4.c              | 2 +-
>  net/ipv4/xfrm4_policy.c                 | 2 +-
>  net/ipv6/addrconf.c                     | 2 +-
>  net/ipv6/netfilter/nf_conntrack_reasm.c | 2 +-
>  net/ipv6/reassembly.c                   | 2 +-
>  net/ipv6/sysctl_net_ipv6.c              | 6 +++---
>  net/ipv6/xfrm6_policy.c                 | 2 +-
>  net/mpls/af_mpls.c                      | 4 ++--
>  net/mptcp/ctrl.c                        | 2 +-
>  net/netfilter/nf_conntrack_standalone.c | 2 +-
>  net/netfilter/nf_log.c                  | 2 +-
>  net/sctp/sysctl.c                       | 2 +-
>  net/smc/smc_sysctl.c                    | 2 +-
>  net/unix/sysctl_net_unix.c              | 2 +-
>  net/xfrm/xfrm_sysctl.c                  | 2 +-
>  27 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index bb95ce43cd97..66f8542f3b18 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -1971,7 +1971,7 @@ static int vrf_netns_init_sysctl(struct net *net, struct netns_vrf *nn_vrf)
>  static void vrf_netns_exit_sysctl(struct net *net)
>  {
>  	struct netns_vrf *nn_vrf = net_generic(net, vrf_net_id);
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  
>  	table = nn_vrf->ctl_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(nn_vrf->ctl_hdr);
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 47bd28ffa88f..09db2f2e6488 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -171,7 +171,7 @@ struct ctl_table_header {
>  		struct rcu_head rcu;
>  	};
>  	struct completion *unregistering;
> -	struct ctl_table *ctl_table_arg;
> +	const struct ctl_table *ctl_table_arg;
>  	struct ctl_table_root *root;
>  	struct ctl_table_set *set;
>  	struct ctl_dir *parent;
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index 19b2a67aef40..113452038303 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -305,7 +305,7 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
>  
>  void retire_ipc_sysctls(struct ipc_namespace *ns)
>  {
> -	struct ctl_table *tbl;
> +	const struct ctl_table *tbl;
>  
>  	tbl = ns->ipc_sysctls->ctl_table_arg;
>  	unregister_sysctl_table(ns->ipc_sysctls);
> diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
> index 43c0825da9e8..068e7d5aa42b 100644
> --- a/ipc/mq_sysctl.c
> +++ b/ipc/mq_sysctl.c
> @@ -159,7 +159,7 @@ bool setup_mq_sysctls(struct ipc_namespace *ns)
>  
>  void retire_mq_sysctls(struct ipc_namespace *ns)
>  {
> -	struct ctl_table *tbl;
> +	const struct ctl_table *tbl;
>  
>  	tbl = ns->mq_sysctls->ctl_table_arg;
>  	unregister_sysctl_table(ns->mq_sysctls);
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 90300840256b..366a2c1971f5 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -119,7 +119,7 @@ bool setup_userns_sysctls(struct user_namespace *ns)
>  void retire_userns_sysctls(struct user_namespace *ns)
>  {
>  #ifdef CONFIG_SYSCTL
> -	struct ctl_table *tbl;
> +	const struct ctl_table *tbl;
>  
>  	tbl = ns->sysctls->ctl_table_arg;
>  	unregister_sysctl_table(ns->sysctls);
> diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
> index db66e11e7fe8..e0128dc9def3 100644
> --- a/net/ax25/sysctl_net_ax25.c
> +++ b/net/ax25/sysctl_net_ax25.c
> @@ -171,7 +171,7 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
>  void ax25_unregister_dev_sysctl(ax25_dev *ax25_dev)
>  {
>  	struct ctl_table_header *header = ax25_dev->sysheader;
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  
>  	if (header) {
>  		ax25_dev->sysheader = NULL;
> diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
> index 35e10c5a766d..a09118c56c7d 100644
> --- a/net/bridge/br_netfilter_hooks.c
> +++ b/net/bridge/br_netfilter_hooks.c
> @@ -1268,7 +1268,7 @@ static int br_netfilter_sysctl_init_net(struct net *net)
>  static void br_netfilter_sysctl_exit_net(struct net *net,
>  					 struct brnf_net *brnet)
>  {
> -	struct ctl_table *table = brnet->ctl_hdr->ctl_table_arg;
> +	const struct ctl_table *table = brnet->ctl_hdr->ctl_table_arg;
>  
>  	unregister_net_sysctl_table(brnet->ctl_hdr);
>  	if (!net_eq(net, &init_net))
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index 6973dda3abda..903ab4a51c17 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -743,7 +743,7 @@ static __net_init int sysctl_core_net_init(struct net *net)
>  
>  static __net_exit void sysctl_core_net_exit(struct net *net)
>  {
> -	struct ctl_table *tbl;
> +	const struct ctl_table *tbl;
>  
>  	tbl = net->core.sysctl_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(net->core.sysctl_hdr);
> diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
> index 6dd960ec558c..2a983cf450da 100644
> --- a/net/ieee802154/6lowpan/reassembly.c
> +++ b/net/ieee802154/6lowpan/reassembly.c
> @@ -399,7 +399,7 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
>  
>  static void __net_exit lowpan_frags_ns_sysctl_unregister(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  	struct netns_ieee802154_lowpan *ieee802154_lowpan =
>  		net_ieee802154_lowpan(net);
>  
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 7a437f0d4190..7592f242336b 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -2749,7 +2749,7 @@ static __net_init int devinet_init_net(struct net *net)
>  static __net_exit void devinet_exit_net(struct net *net)
>  {
>  #ifdef CONFIG_SYSCTL
> -	struct ctl_table *tbl;
> +	const struct ctl_table *tbl;
>  
>  	tbl = net->ipv4.forw_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(net->ipv4.forw_hdr);
> diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
> index a4941f53b523..6b9285fd6f06 100644
> --- a/net/ipv4/ip_fragment.c
> +++ b/net/ipv4/ip_fragment.c
> @@ -632,7 +632,7 @@ static int __net_init ip4_frags_ns_ctl_register(struct net *net)
>  
>  static void __net_exit ip4_frags_ns_ctl_unregister(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  
>  	table = net->ipv4.frags_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(net->ipv4.frags_hdr);
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index c8f76f56dc16..af30b5942ba4 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -3590,7 +3590,7 @@ static __net_init int sysctl_route_net_init(struct net *net)
>  
>  static __net_exit void sysctl_route_net_exit(struct net *net)
>  {
> -	struct ctl_table *tbl;
> +	const struct ctl_table *tbl;
>  
>  	tbl = net->ipv4.route_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(net->ipv4.route_hdr);
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 7e4f16a7dcc1..ce5d19978a26 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -1554,7 +1554,7 @@ static __net_init int ipv4_sysctl_init_net(struct net *net)
>  
>  static __net_exit void ipv4_sysctl_exit_net(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  
>  	kfree(net->ipv4.sysctl_local_reserved_ports);
>  	table = net->ipv4.ipv4_hdr->ctl_table_arg;
> diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
> index c33bca2c3841..1dda59e0aeab 100644
> --- a/net/ipv4/xfrm4_policy.c
> +++ b/net/ipv4/xfrm4_policy.c
> @@ -186,7 +186,7 @@ static __net_init int xfrm4_net_sysctl_init(struct net *net)
>  
>  static __net_exit void xfrm4_net_sysctl_exit(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  
>  	if (!net->ipv4.xfrm4_hdr)
>  		return;
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 247bd4d8ee45..9c34a351f115 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -7235,7 +7235,7 @@ static int __addrconf_sysctl_register(struct net *net, char *dev_name,
>  static void __addrconf_sysctl_unregister(struct net *net,
>  					 struct ipv6_devconf *p, int ifindex)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  
>  	if (!p->sysctl_header)
>  		return;
> diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
> index 1a51a44571c3..98809f846229 100644
> --- a/net/ipv6/netfilter/nf_conntrack_reasm.c
> +++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
> @@ -105,7 +105,7 @@ static int nf_ct_frag6_sysctl_register(struct net *net)
>  static void __net_exit nf_ct_frags6_sysctl_unregister(struct net *net)
>  {
>  	struct nft_ct_frag6_pernet *nf_frag = nf_frag_pernet(net);
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  
>  	table = nf_frag->nf_frag_frags_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(nf_frag->nf_frag_frags_hdr);
> diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
> index acb4f119e11f..ee95cdcc8747 100644
> --- a/net/ipv6/reassembly.c
> +++ b/net/ipv6/reassembly.c
> @@ -487,7 +487,7 @@ static int __net_init ip6_frags_ns_sysctl_register(struct net *net)
>  
>  static void __net_exit ip6_frags_ns_sysctl_unregister(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  
>  	table = net->ipv6.sysctl.frags_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(net->ipv6.sysctl.frags_hdr);
> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> index 888676163e90..75de55f907b0 100644
> --- a/net/ipv6/sysctl_net_ipv6.c
> +++ b/net/ipv6/sysctl_net_ipv6.c
> @@ -313,9 +313,9 @@ static int __net_init ipv6_sysctl_net_init(struct net *net)
>  
>  static void __net_exit ipv6_sysctl_net_exit(struct net *net)
>  {
> -	struct ctl_table *ipv6_table;
> -	struct ctl_table *ipv6_route_table;
> -	struct ctl_table *ipv6_icmp_table;
> +	const struct ctl_table *ipv6_table;
> +	const struct ctl_table *ipv6_route_table;
> +	const struct ctl_table *ipv6_icmp_table;
>  
>  	ipv6_table = net->ipv6.sysctl.hdr->ctl_table_arg;
>  	ipv6_route_table = net->ipv6.sysctl.route_hdr->ctl_table_arg;
> diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
> index 42fb6996b077..4891012b692f 100644
> --- a/net/ipv6/xfrm6_policy.c
> +++ b/net/ipv6/xfrm6_policy.c
> @@ -218,7 +218,7 @@ static int __net_init xfrm6_net_sysctl_init(struct net *net)
>  
>  static void __net_exit xfrm6_net_sysctl_exit(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  
>  	if (!net->ipv6.sysctl.xfrm6_hdr)
>  		return;
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index 6dab883a08dd..973881b8faa3 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -1438,7 +1438,7 @@ static void mpls_dev_sysctl_unregister(struct net_device *dev,
>  				       struct mpls_dev *mdev)
>  {
>  	struct net *net = dev_net(dev);
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  
>  	if (!mdev->sysctl)
>  		return;
> @@ -2706,7 +2706,7 @@ static void mpls_net_exit(struct net *net)
>  {
>  	struct mpls_route __rcu **platform_label;
>  	size_t platform_labels;
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  	unsigned int index;
>  
>  	table = net->mpls.ctl->ctl_table_arg;
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 13fe0748dde8..8d661156ab8c 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -198,7 +198,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
>  
>  static void mptcp_pernet_del_table(struct mptcp_pernet *pernet)
>  {
> -	struct ctl_table *table = pernet->ctl_table_hdr->ctl_table_arg;
> +	const struct ctl_table *table = pernet->ctl_table_hdr->ctl_table_arg;
>  
>  	unregister_net_sysctl_table(pernet->ctl_table_hdr);
>  
> diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
> index 0ee98ce5b816..bb9dea676ec1 100644
> --- a/net/netfilter/nf_conntrack_standalone.c
> +++ b/net/netfilter/nf_conntrack_standalone.c
> @@ -1122,7 +1122,7 @@ static int nf_conntrack_standalone_init_sysctl(struct net *net)
>  static void nf_conntrack_standalone_fini_sysctl(struct net *net)
>  {
>  	struct nf_conntrack_net *cnet = nf_ct_pernet(net);
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  
>  	table = cnet->sysctl_header->ctl_table_arg;
>  	unregister_net_sysctl_table(cnet->sysctl_header);
> diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
> index 370f8231385c..efedd2f13ac7 100644
> --- a/net/netfilter/nf_log.c
> +++ b/net/netfilter/nf_log.c
> @@ -514,7 +514,7 @@ static int netfilter_log_sysctl_init(struct net *net)
>  
>  static void netfilter_log_sysctl_exit(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  
>  	table = net->nf.nf_log_dir_header->ctl_table_arg;
>  	unregister_net_sysctl_table(net->nf.nf_log_dir_header);
> diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> index f65d6f92afcb..25bdf17c7262 100644
> --- a/net/sctp/sysctl.c
> +++ b/net/sctp/sysctl.c
> @@ -624,7 +624,7 @@ int sctp_sysctl_net_register(struct net *net)
>  
>  void sctp_sysctl_net_unregister(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  
>  	table = net->sctp.sysctl_header->ctl_table_arg;
>  	unregister_net_sysctl_table(net->sctp.sysctl_header);
> diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> index a5946d1b9d60..4e8baa2e7ea4 100644
> --- a/net/smc/smc_sysctl.c
> +++ b/net/smc/smc_sysctl.c
> @@ -133,7 +133,7 @@ int __net_init smc_sysctl_net_init(struct net *net)
>  
>  void __net_exit smc_sysctl_net_exit(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  
>  	table = net->smc.smc_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(net->smc.smc_hdr);
> diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
> index 3e84b31c355a..44996af61999 100644
> --- a/net/unix/sysctl_net_unix.c
> +++ b/net/unix/sysctl_net_unix.c
> @@ -52,7 +52,7 @@ int __net_init unix_sysctl_register(struct net *net)
>  
>  void unix_sysctl_unregister(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  
>  	table = net->unx.ctl->ctl_table_arg;
>  	unregister_net_sysctl_table(net->unx.ctl);
> diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
> index 7fdeafc838a7..e972930c292b 100644
> --- a/net/xfrm/xfrm_sysctl.c
> +++ b/net/xfrm/xfrm_sysctl.c
> @@ -76,7 +76,7 @@ int __net_init xfrm_sysctl_init(struct net *net)
>  
>  void __net_exit xfrm_sysctl_fini(struct net *net)
>  {
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  
>  	table = net->xfrm.sysctl_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(net->xfrm.sysctl_hdr);
> 
> ---
> base-commit: 48a8b5270db856be233021e47a5f1dc02d47ed0d
> change-id: 20231226-sysctl-const-table-arg-2c828e0264dc
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 

-- 
Kees Cook

