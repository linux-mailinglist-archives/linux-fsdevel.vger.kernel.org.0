Return-Path: <linux-fsdevel+bounces-8458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3FC836DF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 18:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD751F24D93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 17:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807154776B;
	Mon, 22 Jan 2024 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="N2UdSnQi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F363D979;
	Mon, 22 Jan 2024 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942748; cv=fail; b=riYXz2JWb/R2tobnXObyTZt6Qw9gyENjG2IFVGoNkofeiVwERGlKEDqN1bkKB8ebQIQCHG8Q0pwODwIJgy6HWXoh8W4ALVVRy5PYyDjB7h7JaRwdi1hsXHXBJlG8Teyoz5NpSWPy8fpaxB1hYMl3t0lmg+3Yoza+4wtdalktHAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942748; c=relaxed/simple;
	bh=NEyIc1ZA8j2ft0W2vU4tsNVHuVyRXpOECbM0fGuhkoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JTeO0TdjBHYjjsuAHsD/DXhbwH5DINaHpsevo1fkHV2Qua+lmxgNjOIwQP6tHR3ihW8afCYzXfvxvx3RXJpvlpE+mPyw5gH+wjnJTlou5lVT5h2sfXWen21c81RgoXqZuIfPWSTPJrfXHoH8aCvQVD+vHAycJpe+uviCCKqmVkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=N2UdSnQi; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfgLwPis64mExwESkqlU+9tD0FfKNJh4Qw7cOfY7ZZQStklC6r5L1MgKQwJnkH+dwizOMCyC3SzLkGcoelUE+sDNWgpkR5g2vfHIs0V4ddZ4rlOK6eemn6PQqNYYUa9FbvFab9m7dOA5hVoAK9mwazfsenkss7xcexB2ak35b+0AOwzvDA6uIZ09OYRe+9j/tzb2SF61AwcMCFy4Euor4m+A+qUOIZEuonu/zeN9fartzlMZDATZUfWOq0YZmr+GK1gC7vhFMLglyihntOoTgEYwpnYa47Lcgkno5ADXAiXgSELx9dHyOvmh2xD4X35Sv6dskJ74qPMuI6He8IqoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZftK7/1Nuelm1zubFQqGPPnw7SHv6l109c95ZMRkg0=;
 b=IwKnR/maHRAs6LUhkY3/5Yl9PCs33DMjYS0bRZSiS5PTASbn+uEKBz2vD71jykNFO6U1VL069Wr+0EIwNchc5mpseMP6X2N7i5pv6sq9bfN5J01Aa1juYjFYv9prNW5P2IDYAx9qhHM21nljjSDUgF5cWXTBFbWjdI8KE+bYU5RezhhQpLdxix9OA1T+5HzGhxQJ8aZgu4GctpASWRLWuXriyjubALGu+ngJMK5ZXgj3PV7tcwPllDw3CLOa1iYAIqk3cNtNBTZH68gwTVPJM5cLHvXzTeHV/lqeDidvWDHFtBzGi7+yQl9tVcYy3siTl2ymhiBow+bd1ak6zlj6tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZftK7/1Nuelm1zubFQqGPPnw7SHv6l109c95ZMRkg0=;
 b=N2UdSnQioIz13rkLtQW5LEr5IIXwNoOHzSB5+q2+RTIxYLFYBVF4B3NbPFMKR0dwwOCLZIq4bHxMI0MN6d7597H+752TUOHwM+O/+qatfIBdyjExoQ6Eopz2n9JX0N7I6PRNaFfIE8S/f1TsiIb8kDCWc3oQw7za40RBsZBa7ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DS0PR17MB6374.namprd17.prod.outlook.com (2603:10b6:8:135::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 16:59:03 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 16:59:03 +0000
Date: Mon, 22 Jan 2024 11:58:53 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	corbet@lwn.net, akpm@linux-foundation.org, honggyu.kim@sk.com,
	rakie.kim@sk.com, hyeongtak.ji@sk.com, mhocko@kernel.org,
	vtavarespetr@micron.com, jgroves@micron.com,
	ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com,
	hannes@cmpxchg.org, dan.j.williams@intel.com
Subject: Re: [PATCH v2 1/3] mm/mempolicy: implement the sysfs-based
 weighted_interleave interface
Message-ID: <Za6ezSUjXc5Lyz/i@memverge.com>
References: <20240119175730.15484-1-gregory.price@memverge.com>
 <20240119175730.15484-2-gregory.price@memverge.com>
 <875xzlx09i.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xzlx09i.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DS0PR17MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a10807-d9fe-454c-9585-08dc1b6b6fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fmyd1Mon5dQL7t++hFNUtdRmxuzGf9SXL6zVA2a8repYOH1YYK6pYeXaR7H9yitje290+44GigG54NnvSYRBoJSq9zQcexhDCaUiJ9CfcfW8/dyUcJXNaIJejllHlWFJUbhw2HR99F5c223kbRrtWYHv05r3ZMXthavpjyArREqbPdjw+8LV0DdMEFYj4v5fVaeaoLUSwKZ4rcczttvxuwpoJwqLSC7pRyq6EInSGjzL6dZSkTa01JkxGeJ6jp0DZGs25ZOjQFGBhyA8Kz3rjquV4pFDTZFw7DFNUJFn4o6XEKIVdrUYQVPRAO2H+3cuyPp06qaHJuUNsbxuzuKeRYZqH2WKolwVs5KqvpT55mnUZcrl7wW6hJ8m/UwY9Y+pbLLBy/WWWjYiGRYe3m5mLu0bYA2KFo9vD9UC2J3meIEOt1HjXhLv9r7Bj3lu1RljYbFYyERlwksTa16rGqz1bIxzJYz7x2EgZo5jEyFE2t/LANMybxvUlN8lZuKS7+CJCawc6UnV6T04lkspkxfiR92pE1veKfQOhX/8aLz515yzB5lPnKx6vvXdKc0ZA24Bni2W29RZV/+qrFQX4YkHPf/2zl6zKU7w6EMHSdlcSS+qBaLoIJcgKBoCY1At6tkz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(366004)(396003)(376002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6916009)(66556008)(2906002)(66946007)(66476007)(66899024)(26005)(6512007)(7416002)(6486002)(6506007)(4326008)(6666004)(478600001)(316002)(8936002)(8676002)(5660300002)(2616005)(44832011)(83380400001)(38100700002)(36756003)(86362001)(41300700001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4hinJODD6RNziFdQiwp8OgPZPu71y65AtFHjkGJnUU4bcaRNXwYJHAp0lEz9?=
 =?us-ascii?Q?rDiOT5cdUaHihL6eJP6PwTirDD/jBzZw/Cn6A/7kMy7XYl03EzDuUw3yqcU6?=
 =?us-ascii?Q?vGjp6Uuxc7XcVZAFw98nqKR/az5Id8FmS9HJvmgstNw+gx0PS4H+3x2MhQLn?=
 =?us-ascii?Q?utMmqHHxk7XH5tEKUPSBlDUDh6R/Nh5xS+QjumtmkaS2RKmLtM4bESXx8yT5?=
 =?us-ascii?Q?u5x7YT+dqygGh6BAKGFoDyRwRxMKbMvzqGl5uNXxLBCgJZ/4SKUwi1lFPadx?=
 =?us-ascii?Q?yclMqG1z2jK3kIyMouDXeYvL0neSgCH2cGiOCUjKRVQ0ypn5uqfWOPqC44sk?=
 =?us-ascii?Q?OQ/F/pyA7BFgH5zouYKALcfHtnIgj8KmoW94TAiszsOD4sVL3yzvywf2o+/W?=
 =?us-ascii?Q?NsU/DNIjiMVeVuSi3EutczygPw3+03RKaNk6ji2rsqib9IvbWzUSpjpmeTUM?=
 =?us-ascii?Q?YeV+8GLMQK29+dsj6Pa91dPaiKqmeZRu6NJelKVWz3idqRqVwZpv/lpPWr5a?=
 =?us-ascii?Q?unFoHov36FmipNkJkv/47zPxPiykGMgGH36g0DVvD41hLR3ZbTEsgtVehgpE?=
 =?us-ascii?Q?HXfGh5iAqxeSseD2qtxohIcHh/SFUyNdu4VYGOq5iJLGROllLq/vZB/Ur3PQ?=
 =?us-ascii?Q?bAzPbgQxPstYz40/6jTMECidE9Jd5x5OrmF8WjZeChAHu6ylFl3yShT3qOCh?=
 =?us-ascii?Q?w9XJ9QGwdiJbD2uOZXSlOlLqfN6u1XpY4cF8YhUl5o1nWP20Q79/Fx9MIZZI?=
 =?us-ascii?Q?IKpfrXFg96dlektI3sMh+zaHltFwys4Wd4Uezm0AC9AJUSgVOJn/xkv4ppF0?=
 =?us-ascii?Q?r7XxHLp1Bm6CyvXk+OVFIpqu2z+GjKB9NUzuqtUcleMtDLSWWT/U9Nugxc1+?=
 =?us-ascii?Q?7ClPFVoOVW4CLHUHM3gGPE3TQ74VdMO6CtpcYRuP9H2VRPcMtjyGbuEy7wwp?=
 =?us-ascii?Q?hfaMOfiVRHdutjhGE8kLE77aToQViSWuzfoLWqWSv/ljdHHbt9IQNBuhSuY4?=
 =?us-ascii?Q?tc5ZyDmp5eW/IIKmrbWCeCsrNWW+wKIbcaQLOOtjXjQNEKyPnY7P5U/fIZ2x?=
 =?us-ascii?Q?s05OYof+MqHnqz2hGQ0Lh4hwaqPYNDtLE1/bzx2z9rFuNePH6AYshrnYw4Bb?=
 =?us-ascii?Q?ayT3EHIdiA4phrPwCuANJ8ejkCwCUOWkO+m7aTSTkyTcHzWgGrEnLaRyoThH?=
 =?us-ascii?Q?tCVZQwZvpWNnwKBqIwUSMnl6mWImXb8LuC3P8uXrNpO5hdzarQeouH0/IyJX?=
 =?us-ascii?Q?aRIy5gYkQbwm/+DmFzJifb8tzqTOGlTULwxWFZldEivNC2wKyJuT32qUyFLM?=
 =?us-ascii?Q?BxNgt1/gCFhRDTAMSjF3K0shmpwx6jwSAf0MA1MOR3CjNU9e14oqSs0bBgvG?=
 =?us-ascii?Q?Sra1Caro2NZdSyJP273IEiIfc52i3AaKkboplymMT4Q2gCZuhlEmNOWzGjfH?=
 =?us-ascii?Q?XCzqtfBCZW8IsJzWzb6+kMXN1QhUZr0VgPh/9mVVxqDvPkW3lK7JkQgw0eca?=
 =?us-ascii?Q?j9q1u80dyYhtYFbGZ3q72DxCH4QBLh7hzPhwIB4Rw2s44LyEiuaNY4hJEYJE?=
 =?us-ascii?Q?5dWGG9giDrDe/uiQl+ehMdbS1oRHCzrxAH1LiDz/3Vc8uHxA5jD/j9B2IQqf?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a10807-d9fe-454c-9585-08dc1b6b6fea
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 16:59:03.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4Bs/yE38EwfSQoV/Z7f0+9vraxxbktDjZTiAKcVFIFYYAjsLPiYPpmSfvZBqZtsYXLmTglQt0fB/RcyD7Pj/EKNdEMn685QlZskXA2UIsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6374

On Mon, Jan 22, 2024 at 04:03:53PM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > +	/*
> > +	 * The default weight is 1 (for now), when the kernel-internal
> > +	 * default weight array is implemented, this should be updated to
> > +	 * collect the system-default weight of the node if the user passes 0.
> > +	 */
> > +	if (!weight)
> > +		weight = 1;
> 
> From functionality point of view, it's OK to set "weight = 1" here now.
> But when we add system default weight table in the future, we need to
> use "weight = 0".  Otherwise, we cannot distinguish whether the default
> value have been customized via sysfs.  So, I suggest to use that rule.
>
[... snip ...]
> > +	else
> > +		memset(new, 1, nr_node_ids);
> 
> With similar reason as above ("From functionality..."), I suggest to set
> "0" here.
> 

blah - the comment is misleading at best.  The future patch should pass
0 through to the sysfs table and the allocators updated to collect the
system-default weight of the node.

re: doing it this way right now -

I chose to do it this way for now because it ultimately simplifies the
logic in the allocators - all of which will need to be updated with the
future patch set regardless of our implementation choice now.

e.g.

rcu_read_lock();
table = rcu_dereference(iw_table);
if (!policy->wil.cur_weight)
	policy->wil.cur_weight = table ? table[next] : 1;
	                         ^^^ only need single conditional now
rcu_read_unlock();

This logic will need to be updated to use default table values, so I
chose the simpler implementation and left the change to be explicit
at the time the default table is implemented.

If you prefer it the other way now, I can change it, but this seemed
cleaner and simpler for the time being.

> > +	new[node_attr->nid] = weight;
> > +	rcu_assign_pointer(iw_table, new);
> > +	mutex_unlock(&iw_table_lock);
> > +	synchronize_rcu();
> > +	kfree(old);
> > +	return count;
> > +}
> > +
> > +static struct iw_node_attr *node_attrs[MAX_NUMNODES];
> 
> node_attrs[] can be allocated dynamically too.  Just a suggestion.
> 

ack to this and other references to nr_node_ids, will change.

> > +	kfree(old);
> 
> It appears unnecessary to free iw_table in error path.  But this isn't a
> big deal because error path will almost never be executed in practice.
>

checkpatch.pl yells at you if you do null checks before kfree :]

> > +	int err;
> > +	struct kobject *mempolicy_kobj;
> 
> This overrides the global "mempolicy_kobj" defined before function.  But
> I don't think we need the global definition.
> 

Assuming the exit path isn't needed then yeah the global isn't needed.

> > +static int __init mempolicy_sysfs_init(void)
> > +{
> > +	/* A NULL iw_table is interpreted by interleave logic as "all 1s" */
> > +	iw_table = NULL;
> > +	return 0;
> > +}
> > +
> > +static void __exit mempolicy_exit(void) { }
> > +#endif /* CONFIG_SYSFS */
> > +late_initcall(mempolicy_sysfs_init);
> > +module_exit(mempolicy_exit);
> 
> mempolicy.c will not be compiled as module, so we don't need
> module_exit().
> 

ack

