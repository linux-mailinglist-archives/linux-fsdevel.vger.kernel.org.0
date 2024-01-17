Return-Path: <linux-fsdevel+bounces-8140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA042830050
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 08:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFF4288D61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 07:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B36F9465;
	Wed, 17 Jan 2024 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dC045jYB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3738D8821;
	Wed, 17 Jan 2024 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705474816; cv=none; b=X4eyEruQAFuZpqfVpiKIeAV0/0b1KpA6uLhSwwbekBpHcwZ+EIiaoDBx8YrJAK67hNVeLe92gXyuNYfqStxVYyK16r2b3ZYx/GMiyYsqxyi6YzLqbs15nIfrdxnl5Gsb1YGqYnlUyb6lM1tLsRAqFc87xtZLELOnLlYZsWkK0W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705474816; c=relaxed/simple;
	bh=k7OAtGL+2nxEw5zXMvTzAkCupl6TNovUqU9pBszDoZw=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type; b=oVhji3qY2ZDASvFIeKR64K0/TqlePKmrPcoNxgjIaf+iTMJvCMlBQ3SWCZnK4coyIfQpp1/bTlKjiKZhPx0xcfsjlfz4JpA1xkGCeH3flywncCEddwIj96VxbsQ03KXvh863CUW0Hc898AWKk0Df4ZlrXdVyhK9F2Bdk8qv45QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dC045jYB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705474814; x=1737010814;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=k7OAtGL+2nxEw5zXMvTzAkCupl6TNovUqU9pBszDoZw=;
  b=dC045jYBJ/qgdV8IuFIERlO5KYgi4A3hOAEBcnDiXjd/LS+eSZ24PBno
   ETE11v9wmP7J3vlX80uBPBwjpPsqtHRhOflpq9G4gaIP11PTLyC6lFHbu
   cnirBb1/FLKhXPugVCVyf+bSw2bltCCtcCsuJsFQx0pdduwy0hvIhgAwK
   /d+H1PobomQiJpViEpMp1sjjusqgps2k02xBuodsxj33tXVzK9Z1k2lm1
   5MEwR21zzlxMC/UMwpaum4WiNG6FfYXujvrmrLjG0Ej2LOB+Kt/bGJ2ne
   O2KMvPLlGa4/H4DbwBNL6G1+yYFK3gOBvQGFU9sk2/IiOJpHVDzIkZRBC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="6805784"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="6805784"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 23:00:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="957456948"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="957456948"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 23:00:06 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <linux-doc@vger.kernel.org>,
  <linux-fsdevel@vger.kernel.org>,  <linux-api@vger.kernel.org>,
  <corbet@lwn.net>,  <akpm@linux-foundation.org>,  <honggyu.kim@sk.com>,
  <rakie.kim@sk.com>,  <hyeongtak.ji@sk.com>,  <mhocko@kernel.org>,
  <vtavarespetr@micron.com>,  <jgroves@micron.com>,
  <ravis.opensrc@micron.com>,  <sthanneeru@micron.com>,
  <emirakhur@micron.com>,  <Hasan.Maruf@amd.com>,
  <seungjun.ha@samsung.com>,  <hannes@cmpxchg.org>,
  <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/3] mm/mempolicy: implement the sysfs-based
 weighted_interleave interface
In-Reply-To: <ZadkmWj3Rd483f68@memverge.com> (Gregory Price's message of "Wed,
	17 Jan 2024 00:24:41 -0500")
References: <20240112210834.8035-1-gregory.price@memverge.com>
	<20240112210834.8035-2-gregory.price@memverge.com>
	<87le8r1dzr.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZadkmWj3Rd483f68@memverge.com>
Date: Wed, 17 Jan 2024 14:58:08 +0800
Message-ID: <87o7dkzbsv.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Mon, Jan 15, 2024 at 11:18:00AM +0800, Huang, Ying wrote:
>> Gregory Price <gourry.memverge@gmail.com> writes:
>> 
>> > +static struct iw_table default_iw_table;
>> > +/*
>> > + * iw_table is the sysfs-set interleave weight table, a value of 0
>> > + * denotes that the default_iw_table value should be used.
>> > + *
>> > + * iw_table is RCU protected
>> > + */
>> > +static struct iw_table __rcu *iw_table;
>> > +static DEFINE_MUTEX(iw_table_mtx);
>> 
>> I greped "mtx" in kernel/*.c and mm/*.c and found nothing.  To following
>> the existing coding convention, better to name this as iw_table_mutex or
>> iw_table_lock?
>> 
>
> ack.
>
>> And, I think this is used to protect both iw_table and default_iw_table?
>> If so, it deserves some comments.
>> 
>
> Right now default_iw_table cannot be updated, and so it is neither
> protected nor requires protection.
>
> I planned to add the protection comment in the next patch series, which
> would implement the kernel-side interface for updating the default
> weights during boot/hotplug.
>
> We haven't had the discussion on how/when this should happen yet,
> though, and there's some research to be done.  (i.e. when should DRAM
> weights be set? should the entire table be reweighted on hotplug? etc)

Before that, I'm OK to remove default_iw_table and use hard coded "1" as
default weight for now.

>> > +static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>> > +			  const char *buf, size_t count)
>> > +{
>> > +	struct iw_node_attr *node_attr;
>> > +	struct iw_table __rcu *new;
>> > +	struct iw_table __rcu *old;
>> > +	u8 weight = 0;
>> > +
>> > +	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
>> > +	if (count == 0 || sysfs_streq(buf, ""))
>> > +		weight = 0;
>> > +	else if (kstrtou8(buf, 0, &weight))
>> > +		return -EINVAL;
>> > +
>> > +	new = kmalloc(sizeof(*new), GFP_KERNEL);
>> > +	if (!new)
>> > +		return -ENOMEM;
>> > +
>> > +	mutex_lock(&iw_table_mtx);
>> > +	old = rcu_dereference_protected(iw_table,
>> > +					lockdep_is_held(&iw_table_mtx));
>> > +	/* If value is 0, revert to default weight */
>> > +	weight = weight ? weight : default_iw_table.weights[node_attr->nid];
>> 
>> If we change the default weight in default_iw_table.weights[], how do we
>> identify whether the weight has been customized by users via sysfs?  So,
>> I suggest to use 0 in iw_table for not-customized weight.
>> 
>> And if so, we need to use RCU to access default_iw_table too.
>>
>
> Dumb simplification on my part, I'll walk this back and add the 
>
> if (!weight) weight = default_iw_table[node]
>
> logic back into the allocator paths accordinly.
>
>> > +	memcpy(&new->weights, &old->weights, sizeof(new->weights));
>> > +	new->weights[node_attr->nid] = weight;
>> > +	rcu_assign_pointer(iw_table, new);
>> > +	mutex_unlock(&iw_table_mtx);
>> > +	kfree_rcu(old, rcu);
>> 
>> synchronize_rcu() should be OK here.  It's fast enough in this cold
>> path.  This make it good to define iw_table as
>> 
> I'll take a look.
>
>> u8 __rcu *iw_table;
>> 
>> Then, we only need to allocate nr_node_ids elements now.
>> 
>
> We need nr_possible_nodes to handle hotplug correctly.

nr_node_ids >= num_possible_nodes().  It's larger than any possible node
ID.

> I decided to simplify this down to MAX_NUMNODES *juuuuuust in case*
> "true node hotplug" ever becomes a reality.  If that happens, then
> only allocating space for possible nodes creates a much bigger
> headache on hotplug.
>
> For the sake of that simplification, it seemed better to just eat the
> 1KB.  If you really want me to do that, I will, but the MAX_NUMNODES
> choice was an explicitly defensive choice.

When "true node hotplug" becomes reality, we can make nr_node_ids ==
MAX_NUMNODES.  So, it's safe to use it.  Please take a look at
setup_nr_node_ids().

>> > +static int __init mempolicy_sysfs_init(void)
>> > +{
>> > +	/*
>> > +	 * if sysfs is not enabled MPOL_WEIGHTED_INTERLEAVE defaults to
>> > +	 * MPOL_INTERLEAVE behavior, but is still defined separately to
>> > +	 * allow task-local weighted interleave and system-defaults to
>> > +	 * operate as intended.
>> > +	 *
>> > +	 * In this scenario iw_table cannot (presently) change, so
>> > +	 * there's no need to set up RCU / cleanup code.
>> > +	 */
>> > +	memset(&default_iw_table.weights, 1, sizeof(default_iw_table));
>> 
>> This depends on sizeof(default_iw_table.weights[0]) == 1, I think it's
>> better to use explicit loop here to make the code more robust a little.
>> 
>
> oh hm, you're right.  rookie mistake on my part.
>

--
Best Regards,
Huang, Ying

