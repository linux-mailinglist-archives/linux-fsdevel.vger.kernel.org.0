Return-Path: <linux-fsdevel+bounces-6945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 807DA81ECB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 07:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B5B1C2234C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 06:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E14B5396;
	Wed, 27 Dec 2023 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/dL7NOt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976735228;
	Wed, 27 Dec 2023 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703659462; x=1735195462;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=VeQzlZbz/ixCeVbIgAPwCnOiwp06eabmtszK1CsD/84=;
  b=K/dL7NOtT+3DCeC9wrs3xFKyBY8GMdB5THHFPUruhYMszp0YSnxYBuuS
   ptNGd/CsNX1t2ugiBgkLopEMfFfZwg/E8cqN/TP0De4KQCjEKqOGGsS3L
   BMIII+Xqc1F2pAZWREIn3kZr9oMT1WGoY4nCKF9xmtY+RbufWGVsr9bE3
   bDJQULb30R9DUZdRxhrEe8JdwdyM2GVjP0XqF8aWF0td/DqUKyEKIR8YW
   7mYhqrn7wCtVUVdiejeMp+Qsqhp2l2AcmEUM1KWY0Dw7Ih59+Zg9rmmuf
   hKNF+qxtMVApXwe7unoMx5L501wYqkkuYpyyD+aKjlG5qFbsxr3Qj43Vq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="386842488"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="386842488"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 22:44:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="771356130"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="771356130"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 22:44:14 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org,  linux-doc@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  x86@kernel.org,  akpm@linux-foundation.org,
  arnd@arndb.de,  tglx@linutronix.de,  luto@kernel.org,  mingo@redhat.com,
  bp@alien8.de,  dave.hansen@linux.intel.com,  hpa@zytor.com,
  mhocko@kernel.org,  tj@kernel.org,  gregory.price@memverge.com,
  corbet@lwn.net,  rakie.kim@sk.com,  hyeongtak.ji@sk.com,
  honggyu.kim@sk.com,  vtavarespetr@micron.com,  peterz@infradead.org,
  jgroves@micron.com,  ravis.opensrc@micron.com,  sthanneeru@micron.com,
  emirakhur@micron.com,  Hasan.Maruf@amd.com,  seungjun.ha@samsung.com
Subject: Re: [PATCH v5 01/11] mm/mempolicy: implement the sysfs-based
 weighted_interleave interface
In-Reply-To: <20231223181101.1954-2-gregory.price@memverge.com> (Gregory
	Price's message of "Sat, 23 Dec 2023 13:10:51 -0500")
References: <20231223181101.1954-1-gregory.price@memverge.com>
	<20231223181101.1954-2-gregory.price@memverge.com>
Date: Wed, 27 Dec 2023 14:42:15 +0800
Message-ID: <877cl0f8oo.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> If sysfs is disabled in the config, the global interleave weights
> will default to "1" for all nodes.
>
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Co-developed-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> ---
>  .../ABI/testing/sysfs-kernel-mm-mempolicy     |   4 +
>  ...fs-kernel-mm-mempolicy-weighted-interleave |  22 +++
>  mm/mempolicy.c                                | 156 ++++++++++++++++++
>  3 files changed, 182 insertions(+)
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
> index 000000000000..aa27fdf08c19
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interl=
eave
> @@ -0,0 +1,22 @@
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
> +		Writing an empty string resets the weight value to 1.

I still think that it's a good idea to provide some better default
weight value with HMAT or CDAT if available.  So, better not to make "1"
as part of ABI?

> +
> +		Minimum weight: 1

Can weight be "0"?  Do we need a way to specify that a node don't want
to participate weighted interleave?

> +		Maximum weight: 255
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 10a590ee1c89..0e77633b07a5 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -131,6 +131,8 @@ static struct mempolicy default_policy =3D {
>=20=20
>  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>=20=20
> +static char iw_table[MAX_NUMNODES];
> +

It's kind of obscure whether "char" is "signed" or "unsigned".  Given
the max weight is 255 above, it's better to use "u8"?

And, we may need a way to specify whether the weight has been overridden
by the user.  A special value (such as 255) can be used for that.  If
so, the maximum weight should be 254 instead of 255.  As a user space
interface, is it better to use 100 as the maximum value?

>  /**
>   * numa_nearest_node - Find nearest node by state
>   * @node: Node id to start the search
> @@ -3067,3 +3069,157 @@ void mpol_to_str(char *buffer, int maxlen, struct=
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
> +
> +	node_attr =3D container_of(attr, struct iw_node_attr, kobj_attr);
> +	return sysfs_emit(buf, "%d\n", iw_table[node_attr->nid]);
> +}
> +
> +static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *a=
ttr,
> +			  const char *buf, size_t count)
> +{
> +	struct iw_node_attr *node_attr;
> +	unsigned char weight =3D 0;
> +
> +	node_attr =3D container_of(attr, struct iw_node_attr, kobj_attr);
> +	/* If no input, set default weight to 1 */
> +	if (count =3D=3D 0 || sysfs_streq(buf, ""))
> +		weight =3D 1;
> +	else if (kstrtou8(buf, 0, &weight) || !weight)
> +		return -EINVAL;
> +
> +	iw_table[node_attr->nid] =3D weight;

kstrtou8(), "unsigned char weight", "char iw_table[]" isn't completely
consistent.  It's better to make them consistent?

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
> +static void sysfs_mempolicy_release(struct kobject *mempolicy_kobj)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < MAX_NUMNODES; i++)
> +		sysfs_wi_node_release(node_attrs[i], mempolicy_kobj);

IIUC, if this is called in error path (such as, in
add_weighted_interleave_group()), some node_attrs[] element may be
"NULL"?

> +	kobject_put(mempolicy_kobj);
> +}
> +
> +static const struct kobj_type mempolicy_ktype =3D {
> +	.sysfs_ops =3D &kobj_sysfs_ops,
> +	.release =3D sysfs_mempolicy_release,
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
> +	err =3D kobject_init_and_add(wi_kobj, &mempolicy_ktype, root_kobj,
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
> +static int __init mempolicy_sysfs_init(void)
> +{
> +	int err;
> +	struct kobject *root_kobj;
> +
> +	memset(&iw_table, 1, sizeof(iw_table));
> +
> +	root_kobj =3D kobject_create_and_add("mempolicy", mm_kobj);
> +	if (!root_kobj) {
> +		pr_err("failed to add mempolicy kobject to the system\n");
> +		return -ENOMEM;
> +	}
> +
> +	err =3D add_weighted_interleave_group(root_kobj);
> +
> +	if (err)
> +		kobject_put(root_kobj);
> +	return err;
> +
> +}
> +#else
> +static int __init mempolicy_sysfs_init(void)
> +{
> +	/*
> +	 * if sysfs is not enabled MPOL_WEIGHTED_INTERLEAVE defaults to
> +	 * MPOL_INTERLEAVE behavior, but is still defined separately to
> +	 * allow task-local weighted interleave to operate as intended.
> +	 */
> +	memset(&iw_table, 1, sizeof(iw_table));
> +	return 0;
> +}
> +#endif /* CONFIG_SYSFS */
> +late_initcall(mempolicy_sysfs_init);

--
Best Regards,
Huang, Ying

