Return-Path: <linux-fsdevel+bounces-8396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4A5835C47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 09:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB1A1F22FA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 08:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B3C1A70A;
	Mon, 22 Jan 2024 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8Z3j72X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF01A708;
	Mon, 22 Jan 2024 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910767; cv=none; b=ZAs3ITaIflru/LEQas5A/OgALpSrmBVnqL8ZMh05WoBJsDOPxhlxIZtsVzRnzf7sEM7gWz9F+aNMTz5/SgZmykj5y+snVb1KXIjjYcN77KgaTTgtdF6Nfv3YZt9RUrYHF7Vty/aB630q+OEr9uoHBaboBKpaV3yVnMI70lgIOkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910767; c=relaxed/simple;
	bh=JBDKnQVL6tb8bqKv5trl9rQTUbWDE/j0qE8XT64uxq4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C99bNP6GgQrL+KaM3AAIgEaQv83tT0nUr1T6JcKwEb0y0BZrlZHa+AkwTrZOSXr8R2ndZyPBbJpXd1SCJHq7PILZxgbtxq5he7HoaB3BSkMYPjXzJ+HTFJOjxo33mApXr+5ATMnQKh5UIXl/MKn09uf505lT2HQAmF4Jmlx6ZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8Z3j72X; arc=none smtp.client-ip=134.134.136.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705910765; x=1737446765;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=JBDKnQVL6tb8bqKv5trl9rQTUbWDE/j0qE8XT64uxq4=;
  b=W8Z3j72X/IPlrcQ0DxwPxI0GO14dQcq82ZNy5U+zXWVftXLbrahuEfm4
   /mht+BJM4yg0x52aPHrKFfYvs18BaLdCi9hBfu9X9ihlhI+lRs5s2Crlz
   +0H06TJbJRgMFtHDwSPzati1ZwKLrLzYAkzedZkMPfvINVz3JF+KbBasL
   ywaIHfBPAgqLuk3hyqFb7PbcfnMddnFyWOeOT2WVCCwv1aIcnsMW2y48W
   zUe13fGLxHzZBZJfmN7Rpui7POPVb0znNX0TipUuuY8hA06hrsXtJD6hI
   2BvT49w0FLIkx5emJ+SgY7QU9OLGXk9/UR2l3Li/Hty43lKCZype8K/hS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="467511622"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="467511622"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 00:05:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1217287"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 00:05:49 -0800
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
Subject: Re: [PATCH v2 1/3] mm/mempolicy: implement the sysfs-based
 weighted_interleave interface
In-Reply-To: <20240119175730.15484-2-gregory.price@memverge.com> (Gregory
	Price's message of "Fri, 19 Jan 2024 12:57:28 -0500")
References: <20240119175730.15484-1-gregory.price@memverge.com>
	<20240119175730.15484-2-gregory.price@memverge.com>
Date: Mon, 22 Jan 2024 16:03:53 +0800
Message-ID: <875xzlx09i.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> If a node value is set to `0`, the system-default value will be used.
> As of this patch, the system-default for all nodes is always 1.
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
>  mm/mempolicy.c                                | 231 ++++++++++++++++++
>  3 files changed, 261 insertions(+)
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

May be not a big deal.  The date should be "January 2024"?

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

s/processes/tasks or memory areas/

> +		MPOL_WEIGHTED_INTERLEAVE and have opted into global weights by
> +		omitting a task-local weight array.

Now, we haven't introduced task-local weight array.  So, leave this
until we introduce that?

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
> index 10a590ee1c89..ae925216798f 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -131,6 +131,16 @@ static struct mempolicy default_policy =3D {
>=20=20
>  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>=20=20
> +/*
> + * iw_table is the sysfs-set interleave weight table, a value of 0 denot=
es
> + * system-default value should be used. Until system-defaults are implem=
ented,
> + * the system-default is always 1.
> + *
> + * iw_table is RCU protected
> + */
> +static u8 __rcu *iw_table;
> +static DEFINE_MUTEX(iw_table_lock);
> +
>  /**
>   * numa_nearest_node - Find nearest node by state
>   * @node: Node id to start the search
> @@ -3067,3 +3077,224 @@ void mpol_to_str(char *buffer, int maxlen, struct=
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
> +	u8 __rcu *table;
> +
> +	node_attr =3D container_of(attr, struct iw_node_attr, kobj_attr);
> +
> +	rcu_read_lock();
> +	table =3D rcu_dereference(iw_table);
> +	weight =3D table ? table[node_attr->nid] : 1;
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
> +	u8 __rcu *new;
> +	u8 __rcu *old;
> +	u8 weight =3D 0;
> +
> +	node_attr =3D container_of(attr, struct iw_node_attr, kobj_attr);
> +	if (count =3D=3D 0 || sysfs_streq(buf, ""))
> +		weight =3D 0;
> +	else if (kstrtou8(buf, 0, &weight))
> +		return -EINVAL;
> +
> +	/*
> +	 * The default weight is 1 (for now), when the kernel-internal
> +	 * default weight array is implemented, this should be updated to
> +	 * collect the system-default weight of the node if the user passes 0.
> +	 */
> +	if (!weight)
> +		weight =3D 1;

From functionality point of view, it's OK to set "weight =3D 1" here now.
But when we add system default weight table in the future, we need to
use "weight =3D 0".  Otherwise, we cannot distinguish whether the default
value have been customized via sysfs.  So, I suggest to use that rule.

> +
> +	/* We only need to allocate up to the number of possible nodes */

This comment appears not necessary.

> +	new =3D kmalloc(nr_node_ids, GFP_KERNEL);
> +	if (!new)
> +		return -ENOMEM;
> +
> +	mutex_lock(&iw_table_lock);
> +	old =3D rcu_dereference_protected(iw_table,
> +					lockdep_is_held(&iw_table_lock));
> +	if (old)
> +		memcpy(new, old, nr_node_ids);
> +	else
> +		memset(new, 1, nr_node_ids);

With similar reason as above ("From functionality..."), I suggest to set
"0" here.

> +	new[node_attr->nid] =3D weight;
> +	rcu_assign_pointer(iw_table, new);
> +	mutex_unlock(&iw_table_lock);
> +	synchronize_rcu();
> +	kfree(old);
> +	return count;
> +}
> +
> +static struct iw_node_attr *node_attrs[MAX_NUMNODES];

node_attrs[] can be allocated dynamically too.  Just a suggestion.

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

Nitpick, nr_node_ids should be OK here.

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
> +	u8 __rcu *old;
> +
> +	mutex_lock(&iw_table_lock);
> +	old =3D rcu_dereference_protected(iw_table,
> +					lockdep_is_held(&iw_table_lock));
> +	rcu_assign_pointer(iw_table, NULL);
> +	mutex_unlock(&iw_table_lock);
> +	synchronize_rcu();
> +	/* Never free the default table, it's always in use */

Obsolete comment?

> +	kfree(old);

It appears unnecessary to free iw_table in error path.  But this isn't a
big deal because error path will almost never be executed in practice.

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

This overrides the global "mempolicy_kobj" defined before function.  But
I don't think we need the global definition.

> +
> +	/* A NULL iw_table is interpreted by interleave logic as "all 1s" */

As I suggested above, it will be "all 0s", that is, use default weight.

> +	iw_table =3D NULL;

The default value is NULL already, it appears unnecessary to do this.

> +	mempolicy_kobj =3D kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> +	if (!mempolicy_kobj) {
> +		pr_err("failed to add mempolicy kobject to the system\n");
> +		return -ENOMEM;
> +	}
> +	err =3D kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
> +				   "mempolicy");
> +	if (err) {
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
> +	/* A NULL iw_table is interpreted by interleave logic as "all 1s" */
> +	iw_table =3D NULL;
> +	return 0;
> +}
> +
> +static void __exit mempolicy_exit(void) { }
> +#endif /* CONFIG_SYSFS */
> +late_initcall(mempolicy_sysfs_init);
> +module_exit(mempolicy_exit);

mempolicy.c will not be compiled as module, so we don't need
module_exit().

--
Best Regards,
Huang, Ying

