Return-Path: <linux-fsdevel+bounces-60825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4444B51DDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 18:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90ABC4E21AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288462741B5;
	Wed, 10 Sep 2025 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="iXv8UaOt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842C2571DC;
	Wed, 10 Sep 2025 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522151; cv=none; b=cWMfqUhuzMMupJJJkTe1xJFScyM02Tiz6GZrEeVSOUpBKdmxXxD/ZJmDkQVlB0xUYVumcn7fgsYAs714wkdw5qwjytaKS9O17xxR/Ec4Sjn74gvhMrWvglhrKcpOhC1AM2jwZzpLSLQiI8PjwRFWhLdebGJTI233ufhgSaUi60I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522151; c=relaxed/simple;
	bh=hIPVaYko7BDYKctVrKWknRC7NjCsuKVwzM6fPLxUIlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwObHrN6IuKbuQxd8XAaxySlQf9qc0Jhu+ZIjU/c0DWhFVcYLQnZP25i0ck1raJknZBrmyY0ROwXCh7qqVp3FqGrwDeOcXkKZeAAhPmngYdmuy+t6AqZfRM3jmSKKfm8NIfm2dNB5aMvRXUFLtNWdb9zPst8ffKLU6TdTZYfsio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=iXv8UaOt; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cMRBf6H82z9tgj;
	Wed, 10 Sep 2025 18:35:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1757522138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ISUSB+4A4QiZm8J1MIRr9U3YqZEXpmL2zJqHP5EnkGs=;
	b=iXv8UaOtwnftTX1yz/C5CqmsGcmWpcNHR+mcrC4WClHQAW+GVMY+kB3BB44VGnu96ko/sk
	OeupdzwV8WHPsYssHV0v+j4B9QUMm2RSEoq7y0KbsGmJXX8kSS0GKqHKwB488AYNu3JK3c
	x3d3CaNiVl0+lJBEzH91gyAA7uTp0yZsGjhpyFQu09mPudKx0oRRi0wSBU6Bq6AZIgReVK
	hGYUPvOo96J8po92aU+OJNU/sNoTfVJXFvN3mDxCjPH157guj3Uj7tnUuUxN3HqUae2qlg
	+/cV0wjWP6DglHR3a7ihhl09SI2eY/28Xixg2QnBpB7pcU1E/D6cSMtmzEUPkA==
Date: Thu, 11 Sep 2025 02:35:21 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 25/32] ns: add to_<type>_ns() to respective headers
Message-ID: <2025-09-10-porous-grazing-java-din-c5K9DM@cyphar.com>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-25-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qxxnlkucx735eudc"
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-25-4dd56e7359d8@kernel.org>


--qxxnlkucx735eudc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 25/32] ns: add to_<type>_ns() to respective headers
MIME-Version: 1.0

On 2025-09-10, Christian Brauner <brauner@kernel.org> wrote:
> Every namespace type has a container_of(ns, <ns_type>, ns) static inline
> function that is currently not exposed in the header. So we have a bunch
> of places that open-code it via container_of(). Move it to the headers
> so we can use it directly.

Yes please! Feel free to add my

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/linux/cgroup.h         | 5 +++++
>  include/linux/ipc_namespace.h  | 5 +++++
>  include/linux/pid_namespace.h  | 5 +++++
>  include/linux/time_namespace.h | 4 ++++
>  include/linux/user_namespace.h | 5 +++++
>  include/linux/utsname.h        | 5 +++++
>  include/net/net_namespace.h    | 5 +++++
>  ipc/namespace.c                | 5 -----
>  kernel/cgroup/namespace.c      | 5 -----
>  kernel/pid_namespace.c         | 5 -----
>  kernel/time/namespace.c        | 5 -----
>  kernel/user_namespace.c        | 5 -----
>  kernel/utsname.c               | 5 -----
>  net/core/net_namespace.c       | 5 -----
>  14 files changed, 34 insertions(+), 35 deletions(-)
>=20
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index b18fb5fcb38e..9ca25346f7cb 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -794,6 +794,11 @@ extern struct cgroup_namespace init_cgroup_ns;
> =20
>  #ifdef CONFIG_CGROUPS
> =20
> +static inline struct cgroup_namespace *to_cg_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct cgroup_namespace, ns);
> +}
> +
>  void free_cgroup_ns(struct cgroup_namespace *ns);
> =20
>  struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
> diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
> index e8240cf2611a..924e4754374f 100644
> --- a/include/linux/ipc_namespace.h
> +++ b/include/linux/ipc_namespace.h
> @@ -129,6 +129,11 @@ static inline int mq_init_ns(struct ipc_namespace *n=
s) { return 0; }
>  #endif
> =20
>  #if defined(CONFIG_IPC_NS)
> +static inline struct ipc_namespace *to_ipc_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct ipc_namespace, ns);
> +}
> +
>  extern struct ipc_namespace *copy_ipcs(unsigned long flags,
>  	struct user_namespace *user_ns, struct ipc_namespace *ns);
> =20
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> index 7c67a5811199..ba0efc8c8596 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -54,6 +54,11 @@ extern struct pid_namespace init_pid_ns;
>  #define PIDNS_ADDING (1U << 31)
> =20
>  #ifdef CONFIG_PID_NS
> +static inline struct pid_namespace *to_pid_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct pid_namespace, ns);
> +}
> +
>  static inline struct pid_namespace *get_pid_ns(struct pid_namespace *ns)
>  {
>  	if (ns !=3D &init_pid_ns)
> diff --git a/include/linux/time_namespace.h b/include/linux/time_namespac=
e.h
> index 7f6af7a9771e..a47a4ce4183e 100644
> --- a/include/linux/time_namespace.h
> +++ b/include/linux/time_namespace.h
> @@ -33,6 +33,10 @@ struct time_namespace {
>  extern struct time_namespace init_time_ns;
> =20
>  #ifdef CONFIG_TIME_NS
> +static inline struct time_namespace *to_time_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct time_namespace, ns);
> +}
>  void __init time_ns_init(void);
>  extern int vdso_join_timens(struct task_struct *task,
>  			    struct time_namespace *ns);
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespac=
e.h
> index a0bb6d012137..a09056ad090e 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -168,6 +168,11 @@ static inline void set_userns_rlimit_max(struct user=
_namespace *ns,
> =20
>  #ifdef CONFIG_USER_NS
> =20
> +static inline struct user_namespace *to_user_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct user_namespace, ns);
> +}
> +
>  static inline struct user_namespace *get_user_ns(struct user_namespace *=
ns)
>  {
>  	if (ns)
> diff --git a/include/linux/utsname.h b/include/linux/utsname.h
> index bf7613ba412b..5d34c4f0f945 100644
> --- a/include/linux/utsname.h
> +++ b/include/linux/utsname.h
> @@ -30,6 +30,11 @@ struct uts_namespace {
>  extern struct uts_namespace init_uts_ns;
> =20
>  #ifdef CONFIG_UTS_NS
> +static inline struct uts_namespace *to_uts_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct uts_namespace, ns);
> +}
> +
>  static inline void get_uts_ns(struct uts_namespace *ns)
>  {
>  	refcount_inc(&ns->ns.count);
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index 42075748dff1..b9c5f6c7ee1e 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -263,6 +263,11 @@ void ipx_unregister_sysctl(void);
>  #ifdef CONFIG_NET_NS
>  void __put_net(struct net *net);
> =20
> +static inline struct net *to_net_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct net, ns);
> +}
> +
>  /* Try using get_net_track() instead */
>  static inline struct net *get_net(struct net *net)
>  {
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index 9f923c1a1eb3..89588819956b 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -209,11 +209,6 @@ void put_ipc_ns(struct ipc_namespace *ns)
>  	}
>  }
> =20
> -static inline struct ipc_namespace *to_ipc_ns(struct ns_common *ns)
> -{
> -	return container_of(ns, struct ipc_namespace, ns);
> -}
> -
>  static struct ns_common *ipcns_get(struct task_struct *task)
>  {
>  	struct ipc_namespace *ns =3D NULL;
> diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
> index fc12c416dfeb..5a327914b565 100644
> --- a/kernel/cgroup/namespace.c
> +++ b/kernel/cgroup/namespace.c
> @@ -89,11 +89,6 @@ struct cgroup_namespace *copy_cgroup_ns(unsigned long =
flags,
>  	return new_ns;
>  }
> =20
> -static inline struct cgroup_namespace *to_cg_ns(struct ns_common *ns)
> -{
> -	return container_of(ns, struct cgroup_namespace, ns);
> -}
> -
>  static int cgroupns_install(struct nsset *nsset, struct ns_common *ns)
>  {
>  	struct nsproxy *nsproxy =3D nsset->nsproxy;
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 228ae20299f9..9b327420309e 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -345,11 +345,6 @@ int reboot_pid_ns(struct pid_namespace *pid_ns, int =
cmd)
>  	return 0;
>  }
> =20
> -static inline struct pid_namespace *to_pid_ns(struct ns_common *ns)
> -{
> -	return container_of(ns, struct pid_namespace, ns);
> -}
> -
>  static struct ns_common *pidns_get(struct task_struct *task)
>  {
>  	struct pid_namespace *ns;
> diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
> index 408f60d0a3b6..20b65f90549e 100644
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -261,11 +261,6 @@ void free_time_ns(struct time_namespace *ns)
>  	kfree_rcu(ns, ns.ns_rcu);
>  }
> =20
> -static struct time_namespace *to_time_ns(struct ns_common *ns)
> -{
> -	return container_of(ns, struct time_namespace, ns);
> -}
> -
>  static struct ns_common *timens_get(struct task_struct *task)
>  {
>  	struct time_namespace *ns =3D NULL;
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index ade5b6806c5c..cfb0e28f2779 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -1325,11 +1325,6 @@ bool current_in_userns(const struct user_namespace=
 *target_ns)
>  }
>  EXPORT_SYMBOL(current_in_userns);
> =20
> -static inline struct user_namespace *to_user_ns(struct ns_common *ns)
> -{
> -	return container_of(ns, struct user_namespace, ns);
> -}
> -
>  static struct ns_common *userns_get(struct task_struct *task)
>  {
>  	struct user_namespace *user_ns;
> diff --git a/kernel/utsname.c b/kernel/utsname.c
> index 64155417ae0c..a682830742d3 100644
> --- a/kernel/utsname.c
> +++ b/kernel/utsname.c
> @@ -103,11 +103,6 @@ void free_uts_ns(struct uts_namespace *ns)
>  	kfree_rcu(ns, ns.ns_rcu);
>  }
> =20
> -static inline struct uts_namespace *to_uts_ns(struct ns_common *ns)
> -{
> -	return container_of(ns, struct uts_namespace, ns);
> -}
> -
>  static struct ns_common *utsns_get(struct task_struct *task)
>  {
>  	struct uts_namespace *ns =3D NULL;
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index b85e303400be..ca9b06f3925f 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -1539,11 +1539,6 @@ static struct ns_common *netns_get(struct task_str=
uct *task)
>  	return net ? &net->ns : NULL;
>  }
> =20
> -static inline struct net *to_net_ns(struct ns_common *ns)
> -{
> -	return container_of(ns, struct net, ns);
> -}
> -
>  static void netns_put(struct ns_common *ns)
>  {
>  	put_net(to_net_ns(ns));
>=20
> --=20
> 2.47.3
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--qxxnlkucx735eudc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaMGoyRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/CugD/Xt4TLCkzvwn881H1nU/d
+92XbQBoIIUqDamvG7o8wJAA/1jOO0+4srn0kp2+FeT2+Ej9Qa+yW9JVIoMU+bt+
XUME
=eOIc
-----END PGP SIGNATURE-----

--qxxnlkucx735eudc--

