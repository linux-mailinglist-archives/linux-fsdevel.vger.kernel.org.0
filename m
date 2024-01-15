Return-Path: <linux-fsdevel+bounces-7916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E15A82D348
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 04:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B5C1C20B37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 03:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB573D62;
	Mon, 15 Jan 2024 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhiRr59e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9E20E6;
	Mon, 15 Jan 2024 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705288804; x=1736824804;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=DKq70QKuyg6ZYb5ZhuN3+tjQWkuJKiyyLtA13mijGck=;
  b=ZhiRr59e52gt8LMb4qXlF2W5ByhSBnJqEU3JsRSuRCHc3SXN1JDAItMv
   IsbTd/b3S3Ii4KawDf5IU1blYz2SlwyRw57cZIpMX22T0HgnrqBS99d1q
   kg24VFZknomNI/tG9FsQ6MecK9/3Eh+U8z4l7d2NPz7AmypKcKk1CGO1E
   I+aOs+Ihw9eQvG8lar86W9gUO+ZYtStzjqFMXHQwGzKjp8DDDQShhTBnO
   1YcKMu2QCYpRTwG6FKKAQhlGpAcp/ANVEh7IH633C3eDsCCYGJP9BLeYR
   e2nHFINTqDTUZEYwQnhrGZuqMrxZWa/vKdwadcdC5o+epqi32NKrVI3O1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6239668"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="6239668"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 19:20:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="25651183"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 19:19:57 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-api@vger.kernel.org,  corbet@lwn.net,  akpm@linux-foundation.org,
  gregory.price@memverge.com,  honggyu.kim@sk.com,  rakie.kim@sk.com,
  hyeongtak.ji@sk.com,  mhocko@kernel.org,  vtavarespetr@micron.com,
  jgroves@micron.com,  ravis.opensrc@micron.com,  sthanneeru@micron.com,
  emirakhur@micron.com,  Hasan.Maruf@amd.com,  seungjun.ha@samsung.com,
  hannes@cmpxchg.org,  dan.j.williams@intel.com
Subject: Re: [PATCH 1/3] mm/mempolicy: implement the sysfs-based
 weighted_interleave interface
In-Reply-To: <20240112210834.8035-2-gregory.price@memverge.com> (Gregory
	Price's message of "Fri, 12 Jan 2024 16:08:32 -0500")
References: <20240112210834.8035-1-gregory.price@memverge.com>
	<20240112210834.8035-2-gregory.price@memverge.com>
Date: Mon, 15 Jan 2024 11:18:00 +0800
Message-ID: <87le8r1dzr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gregory Price <gourry.memverge@gmail.com> writes:

> From: Rakie Kim <rakie.kim@sk.com>
>
> This patch provides a way to set interleave weight information under
> sysfs at /sys/kernel/mm/mempolicy/weighted_interleave/nodeN
>
> The sysfs structure is designed as follows.
>
>   $ tree /sys/kernel/mm/mempolicy/
>   /sys/kernel/mm/mempolicy/ [1]
>   =E2=94=94=E2=94=80=E2=94=80 weighted_interleave [2]
>       =E2=94=9C=E2=94=80=E2=94=80 node0 [3]
>       =E2=94=94=E2=94=80=E2=94=80 node1
>
> Each file above can be explained as follows.
>
> [1] mm/mempolicy: configuration interface for mempolicy subsystem
>
> [2] weighted_interleave/: config interface for weighted interleave policy
>
> [3] weighted_interleave/nodeN: weight for nodeN
>
> Internally, there is a secondary table `default_iw_table`, which holds
> kernel-internal default interleave weights for each possible node.
>
> If the value for a node is set to `0`, the default value will be used.
>
> If sysfs is disabled in the config, interleave weights will default
> to use `default_iw_table`.
>
> Suggested-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Co-developed-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> ---
>  .../ABI/testing/sysfs-kernel-mm-mempolicy     |   4 +
>  ...fs-kernel-mm-mempolicy-weighted-interleave |  26 ++
>  mm/mempolicy.c                                | 251 ++++++++++++++++++
>  3 files changed, 281 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-w=
eighted-interleave
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy b/Docume=
ntation/ABI/testing/sysfs-kernel-mm-mempolicy
> new file mode 100644
> index 000000000000..2dcf24f4384a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
> @@ -0,0 +1,4 @@
> +What:		/sys/kernel/mm/mempolicy/
> +Date:		December 2023
> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> +Description:	Interface for Mempolicy
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted=
-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-=
interleave
> new file mode 100644
> index 000000000000..e6a38139bf0f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interl=
eave
> @@ -0,0 +1,26 @@
> +What:		/sys/kernel/mm/mempolicy/weighted_interleave/
> +Date:		December 2023
> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> +Description:	Configuration Interface for the Weighted Interleave policy
> +
> +What:		/sys/kernel/mm/mempolicy/weighted_interleave/nodeN
> +Date:		December 2023
> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> +Description:	Weight configuration interface for nodeN
> +
> +		The interleave weight for a memory node (N). These weights are
> +		utilized by processes which have set their mempolicy to
> +		MPOL_WEIGHTED_INTERLEAVE and have opted into global weights by
> +		omitting a task-local weight array.
> +
> +		These weights only affect new allocations, and changes at runtime
> +		will not cause migrations on already allocated pages.
> +
> +		The minimum weight for a node is always 1.
> +
> +		Minimum weight: 1
> +		Maximum weight: 255
> +
> +		Writing an empty string or `0` will reset the weight to the
> +		system default. The system default may be set by the kernel
> +		or drivers at boot or during hotplug events.
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 10a590ee1c89..5da4fd79fd18 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -131,6 +131,30 @@ static struct mempolicy default_policy =3D {
>=20=20
>  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>=20=20
> +struct iw_table {
> +	struct rcu_head rcu;
> +	u8 weights[MAX_NUMNODES];
> +};
> +/*
> + * default_iw_table is the kernel-internal default value interleave
> + * weight table. It is to be set by driver code capable of reading
> + * HMAT/CDAT information, and to provide mempolicy a sane set of
> + * default weight values for WEIGHTED_INTERLEAVE mode.
> + *
> + * By default, prior to HMAT/CDAT information being consumed, the
> + * default weight of all nodes is 1.  The default weight of any
> + * node can only be in the range 1-255. A 0-weight is not allowed.
> + */
> +static struct iw_table default_iw_table;
> +/*
> + * iw_table is the sysfs-set interleave weight table, a value of 0
> + * denotes that the default_iw_table value should be used.
> + *
> + * iw_table is RCU protected
> + */
> +static struct iw_table __rcu *iw_table;
> +static DEFINE_MUTEX(iw_table_mtx);

I greped "mtx" in kernel/*.c and mm/*.c and found nothing.  To following
the existing coding convention, better to name this as iw_table_mutex or
iw_table_lock?

And, I think this is used to protect both iw_table and default_iw_table?
If so, it deserves some comments.

> +
>  /**
>   * numa_nearest_node - Find nearest node by state
>   * @node: Node id to start the search
> @@ -3067,3 +3091,230 @@ void mpol_to_str(char *buffer, int maxlen, struct=
 mempolicy *pol)
>  		p +=3D scnprintf(p, buffer + maxlen - p, ":%*pbl",
>  			       nodemask_pr_args(&nodes));
>  }
> +
> +#ifdef CONFIG_SYSFS
> +struct iw_node_attr {
> +	struct kobj_attribute kobj_attr;
> +	int nid;
> +};
> +
> +static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *at=
tr,
> +			 char *buf)
> +{
> +	struct iw_node_attr *node_attr;
> +	u8 weight;
> +	struct iw_table __rcu *table;
> +
> +	node_attr =3D container_of(attr, struct iw_node_attr, kobj_attr);
> +
> +	rcu_read_lock();
> +	table =3D rcu_dereference(iw_table);
> +	weight =3D table->weights[node_attr->nid];
> +	rcu_read_unlock();
> +
> +	return sysfs_emit(buf, "%d\n", weight);
> +}
> +
> +static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *a=
ttr,
> +			  const char *buf, size_t count)
> +{
> +	struct iw_node_attr *node_attr;
> +	struct iw_table __rcu *new;
> +	struct iw_table __rcu *old;
> +	u8 weight =3D 0;
> +
> +	node_attr =3D container_of(attr, struct iw_node_attr, kobj_attr);
> +	if (count =3D=3D 0 || sysfs_streq(buf, ""))
> +		weight =3D 0;
> +	else if (kstrtou8(buf, 0, &weight))
> +		return -EINVAL;
> +
> +	new =3D kmalloc(sizeof(*new), GFP_KERNEL);
> +	if (!new)
> +		return -ENOMEM;
> +
> +	mutex_lock(&iw_table_mtx);
> +	old =3D rcu_dereference_protected(iw_table,
> +					lockdep_is_held(&iw_table_mtx));
> +	/* If value is 0, revert to default weight */
> +	weight =3D weight ? weight : default_iw_table.weights[node_attr->nid];

If we change the default weight in default_iw_table.weights[], how do we
identify whether the weight has been customized by users via sysfs?  So,
I suggest to use 0 in iw_table for not-customized weight.

And if so, we need to use RCU to access default_iw_table too.

> +	memcpy(&new->weights, &old->weights, sizeof(new->weights));
> +	new->weights[node_attr->nid] =3D weight;
> +	rcu_assign_pointer(iw_table, new);
> +	mutex_unlock(&iw_table_mtx);
> +	kfree_rcu(old, rcu);

synchronize_rcu() should be OK here.  It's fast enough in this cold
path.  This make it good to define iw_table as

u8 __rcu *iw_table;

Then, we only need to allocate nr_node_ids elements now.

> +	return count;
> +}
> +
> +static struct iw_node_attr *node_attrs[MAX_NUMNODES];
> +
> +static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> +				  struct kobject *parent)
> +{
> +	if (!node_attr)
> +		return;
> +	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
> +	kfree(node_attr->kobj_attr.attr.name);
> +	kfree(node_attr);
> +}
> +
> +static void sysfs_wi_release(struct kobject *wi_kobj)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < MAX_NUMNODES; i++)
> +		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> +	kobject_put(wi_kobj);
> +}
> +
> +static const struct kobj_type wi_ktype =3D {
> +	.sysfs_ops =3D &kobj_sysfs_ops,
> +	.release =3D sysfs_wi_release,
> +};
> +
> +static int add_weight_node(int nid, struct kobject *wi_kobj)
> +{
> +	struct iw_node_attr *node_attr;
> +	char *name;
> +
> +	node_attr =3D kzalloc(sizeof(*node_attr), GFP_KERNEL);
> +	if (!node_attr)
> +		return -ENOMEM;
> +
> +	name =3D kasprintf(GFP_KERNEL, "node%d", nid);
> +	if (!name) {
> +		kfree(node_attr);
> +		return -ENOMEM;
> +	}
> +
> +	sysfs_attr_init(&node_attr->kobj_attr.attr);
> +	node_attr->kobj_attr.attr.name =3D name;
> +	node_attr->kobj_attr.attr.mode =3D 0644;
> +	node_attr->kobj_attr.show =3D node_show;
> +	node_attr->kobj_attr.store =3D node_store;
> +	node_attr->nid =3D nid;
> +
> +	if (sysfs_create_file(wi_kobj, &node_attr->kobj_attr.attr)) {
> +		kfree(node_attr->kobj_attr.attr.name);
> +		kfree(node_attr);
> +		pr_err("failed to add attribute to weighted_interleave\n");
> +		return -ENOMEM;
> +	}
> +
> +	node_attrs[nid] =3D node_attr;
> +	return 0;
> +}
> +
> +static int add_weighted_interleave_group(struct kobject *root_kobj)
> +{
> +	struct kobject *wi_kobj;
> +	int nid, err;
> +
> +	wi_kobj =3D kzalloc(sizeof(struct kobject), GFP_KERNEL);
> +	if (!wi_kobj)
> +		return -ENOMEM;
> +
> +	err =3D kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
> +				   "weighted_interleave");
> +	if (err) {
> +		kfree(wi_kobj);
> +		return err;
> +	}
> +
> +	memset(node_attrs, 0, sizeof(node_attrs));
> +	for_each_node_state(nid, N_POSSIBLE) {
> +		err =3D add_weight_node(nid, wi_kobj);
> +		if (err) {
> +			pr_err("failed to add sysfs [node%d]\n", nid);
> +			break;
> +		}
> +	}
> +	if (err)
> +		kobject_put(wi_kobj);
> +	return 0;
> +}
> +
> +static void mempolicy_kobj_release(struct kobject *kobj)
> +{
> +	if (iw_table !=3D &default_iw_table)
> +		kfree(iw_table);
> +	kfree(kobj);
> +}
> +
> +static const struct kobj_type mempolicy_ktype =3D {
> +	.release =3D mempolicy_kobj_release
> +};
> +
> +static struct kobject *mempolicy_kobj;
> +static int __init mempolicy_sysfs_init(void)
> +{
> +	int err;
> +	struct kobject *mempolicy_kobj;
> +	struct iw_table __rcu *table =3D NULL;
> +
> +	/*
> +	 * If sysfs setup fails, utilize the default weight table
> +	 * This at least allows mempolicy to continue functioning safely.
> +	 */
> +	memset(&default_iw_table.weights, 1, MAX_NUMNODES);
> +	iw_table =3D &default_iw_table;
> +
> +	table =3D kzalloc(sizeof(struct iw_table), GFP_KERNEL);
> +	if (!table)
> +		return -ENOMEM;
> +
> +	memcpy(&table->weights, default_iw_table.weights,
> +	       sizeof(table->weights));
> +
> +	mempolicy_kobj =3D kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> +	if (!mempolicy_kobj) {
> +		kfree(table);
> +		pr_err("failed to add mempolicy kobject to the system\n");
> +		return -ENOMEM;
> +	}
> +	err =3D kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
> +				   "mempolicy");
> +	if (err) {
> +		kfree(table);
> +		kfree(mempolicy_kobj);
> +		return err;
> +	}
> +
> +	err =3D add_weighted_interleave_group(mempolicy_kobj);
> +
> +	if (err) {
> +		kobject_put(mempolicy_kobj);
> +		return err;
> +	}
> +
> +	iw_table =3D table;
> +	return err;
> +}
> +
> +static void __exit mempolicy_exit(void)
> +{
> +	if (mempolicy_kobj)
> +		kobject_put(mempolicy_kobj);
> +}
> +
> +#else
> +static int __init mempolicy_sysfs_init(void)
> +{
> +	/*
> +	 * if sysfs is not enabled MPOL_WEIGHTED_INTERLEAVE defaults to
> +	 * MPOL_INTERLEAVE behavior, but is still defined separately to
> +	 * allow task-local weighted interleave and system-defaults to
> +	 * operate as intended.
> +	 *
> +	 * In this scenario iw_table cannot (presently) change, so
> +	 * there's no need to set up RCU / cleanup code.
> +	 */
> +	memset(&default_iw_table.weights, 1, sizeof(default_iw_table));

This depends on sizeof(default_iw_table.weights[0]) =3D=3D 1, I think it's
better to use explicit loop here to make the code more robust a little.

> +	iw_table =3D default_iw_table;

iw_table =3D &default_iw_table;

?

> +	return 0;
> +}
> +
> +static void __exit mempolicy_exit(void) { }
> +#endif /* CONFIG_SYSFS */
> +late_initcall(mempolicy_sysfs_init);
> +module_exit(mempolicy_exit);

--
Best Regards,
Huang, Ying

