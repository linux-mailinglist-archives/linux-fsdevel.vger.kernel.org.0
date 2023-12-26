Return-Path: <linux-fsdevel+bounces-6957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A0F81EFC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 16:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4DC1C215A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 15:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538C14596E;
	Wed, 27 Dec 2023 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="K+B4/0UV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF5245945;
	Wed, 27 Dec 2023 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MExrlb4EV1/aSrsXORvZCZGUVjOZyB3us847IyF6TBv4cLpoJe5Y9FvVvlBstTEtGFv5EpF8f0UlMncQ0cIH2foYO9W3KVTr0efacC56U3QsprweWsr/xCDlbe+AFnDAPTB2Bx1Aa2haJYcXhyTWzC5R6ltb8VJV0uRNDR51MflLcgZxT0PIyXxWlGgR5xjGIvYy0mW0p5WZGery2IJE7evubwNK9UdMqCEagm6qqU0VCvyCOx52xreZN+u5K/bdTPDHWN8rXkE3+yZ4Hl7RVJhKuolvtBPOPhLuSeADtilVOPj8F7vP/AIEHwF8pMANDlUueHJW5HL7IuSdK+bTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SCie4LiyBmBcd42exlaOWGFfRUnotAoWlMTSp+guEo=;
 b=UNPNig0AI9iecLTqGI/BPEjrIB/oYz6reR2sOzKwrzDB7mZ/K/rmdQojVlw9DEoDdCTKXbcXwrYAtfHT31qVyBMCpee8dh0zI6q4/6qEn/Il6UTLHdR7XYfDZi9NGYWKVZhPJvdhKNoTnf8aVXhMqG5VWnne0Kbgm7D39fZS49+v9fEHk+qz2YwhlL5WxgzJWPNg5d7hSSRKZLKpML7ycwwWtB2PEa5U5K4sxo8+9mTZVzPK3ebYTS6BCbGz3mODuJMTiyvoEAcnvcgWW98X3b9Wq7/rpeJXM4/cSnx+qyYPQGhaSMhODCR2KTBwKir7ZIAHphsWTpXUK8bStXj7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SCie4LiyBmBcd42exlaOWGFfRUnotAoWlMTSp+guEo=;
 b=K+B4/0UV33XTETHrz3dshvBP+1SRYCTLOtlt+dun+kvmvCvInXDJtOjC91YIGiBZN17Y1ddshuDWYNds0ZCNBwwS9YgUvUjXC7RbIPfYY2q1FYmP9aNCR+9ZiODNaGK2AW+K9cLeLVPRKknuERdxCIPDMNZ6VhsWycU8X4/FKWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB6548.namprd17.prod.outlook.com (2603:10b6:a03:4e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Wed, 27 Dec
 2023 15:29:26 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 15:29:25 +0000
Date: Tue, 26 Dec 2023 01:48:05 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
	tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mhocko@kernel.org,
	tj@kernel.org, corbet@lwn.net, rakie.kim@sk.com,
	hyeongtak.ji@sk.com, honggyu.kim@sk.com, vtavarespetr@micron.com,
	peterz@infradead.org, jgroves@micron.com, ravis.opensrc@micron.com,
	sthanneeru@micron.com, emirakhur@micron.com, Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com
Subject: Re: [PATCH v5 01/11] mm/mempolicy: implement the sysfs-based
 weighted_interleave interface
Message-ID: <ZYp3JbcCPQc4fUrB@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
 <20231223181101.1954-2-gregory.price@memverge.com>
 <877cl0f8oo.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cl0f8oo.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BYAPR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:40::22) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 62deed50-ec3c-49fd-7f62-08dc06f09bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GZlJy2kprro7uWtVtXNjqk+mKO60/u8MjR5Vqk/YWEpOMuCDzcoL9Tp+CGKkKu/Q7SRsMqJiW8ckUxZ0qhnhn2u9xBQl4u2bckhr0vZxeOAmrkCIyTk7gIbLG81HCp3C37Hv9XxpxG0pAicE4Q3JHxOdYYXwsbZZ2A4vhrcA6z0hlCvqqhRZp5TcQjj8ds5dNUKlpsZphEkU69uOP47yVjPg92s4bZZLx8qL1nFQIHXkRiS1r/9VZZHPgAsnehprEKBtZhqp7ABiLUAZTewNmq2niVzApJCye+qQNB+gXU3ycq3mLrs9LlMdUu0F+lXquBOg3KWxMz83Yg7a8a5O5fr1aOcZishqq/1RddFsZ5K/EyyYcU7rHN+fWdq5TwWXTL87fg6HbhF8zZTWQzyTLn3K6qFcBRrqEfi8S8v0MtQYqA4R1zxoUMizap82nKT8uHJBzCjy89qdOXQqbfe7pWp6SjmAgZuoDDoUxfGeHDNj/gge3SOukJEvYneC6LfYr/TndpyPsCmDaOj7gGr7SUQpLWg33pC9jmTfRsfg77EBNZdw5HdxH62x7RFRCM+8frXdUbKC15PTTqzAcNIfpQv6ixqKSjRv1znG+1puOAXgZyp7ZzVQcZyTNVP+U/rsIIzMdNOOJ65TkX9aty4H6dlREc83jnEwSFzwEzvjQOs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39840400004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(26005)(83380400001)(38100700002)(8676002)(66556008)(66476007)(6916009)(8936002)(316002)(66946007)(5660300002)(2906002)(4326008)(7406005)(7416002)(44832011)(6506007)(6512007)(2616005)(41300700001)(6486002)(6666004)(478600001)(86362001)(36756003)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OYPdG4aDkf1FTRiD7Nl6AIz3MvE+/I7cc9K+BTOCSvCIODkMhHJ2c5Hkcels?=
 =?us-ascii?Q?SfSK1YHaEl3tM+s+poxzdMlrUrU7LO4tNV+kA5ou8ZB/p3FOqvMVVVWTO7LD?=
 =?us-ascii?Q?9FQTbGPb7x4X9rWFv7GBvBjQLfo12QKPS67UhkILvuCVN2I0W6ZqJqx9gSla?=
 =?us-ascii?Q?zdfvnjejtXiH/6Vl8wrbzSKjmsteaUSsECSNpdKrfetnX8oInfdfrnTGF4Y9?=
 =?us-ascii?Q?++LtF+mQutQXIQAclFodzQUFQRA/b3YHqKgZqxtmqN7Cx7Ll0HWVOqY67f3I?=
 =?us-ascii?Q?3mey55dDCMw1WfMb8fzrYfJD/ozsB+z+Ey/eYMtsGt4Cw4SAdStvZs5tRI50?=
 =?us-ascii?Q?525c4MvqrWf7o/9yrXS3Ibf7DSy+9C6TkSWLP2dghpuawPxXHPwvwfitNXME?=
 =?us-ascii?Q?1H0xvULMl5K1EYLTaikitFnR9nUvLUJLbJw5ynWsjcr5/zh5xDyr9eWsraQz?=
 =?us-ascii?Q?aEXgOUS7x2LVoAhpLMT2T5wkzy7jCykwFfBbLQFBx2RtGygTXlicaxFIUW+H?=
 =?us-ascii?Q?5/tVwSYKooB5HKy9MYQsQeueQ4qyICIlOaw7fnjXsPyNqBEjUS3ddPPFEkX0?=
 =?us-ascii?Q?f5EYPPMScZTg8N9hfuEIiVDcCev3G3Ng4ZARv9ZPq77mmNbQ0Xs6sz92JxVe?=
 =?us-ascii?Q?uHPtnc9NvJFVL8aXpww8BOdPjvCV2bsvp5QFiYt0qGCCaNLHo6sarBAu78X2?=
 =?us-ascii?Q?TcHfrp610TtR2cIhLgtviEpELEdBbtpC01YjcekB3aZPFIRyyoy8C3qHJz5E?=
 =?us-ascii?Q?CiNWNAUIXnZ7+xSNEyqMUMlEqctF9fBmwJw/HdTVf7qZvhdMawPIkcSFDK7T?=
 =?us-ascii?Q?5AVjRcVQzL6rqa/mfZvfxWRUrvm9SwDPaObXBRB/LOVM0lIHYNeHxAsSQfBx?=
 =?us-ascii?Q?Ww7pNPEl0UA3pBK9qhpTBFNPBT1n0dtLOkqF+4gZ0zIif2TUkk9XZmTqUTjc?=
 =?us-ascii?Q?bmJswCaDus2QtXVAkAgzVTKtMcNZOgrHHshmtbBPuUiv/CsDfcsiy0f1AjHr?=
 =?us-ascii?Q?TYK3HCw3wRrnRFUZzF3wUIAdet7EKgX4liICBSo2IsXF/otjraXPB0z85FRQ?=
 =?us-ascii?Q?GhIcObE4rnhJQEcnvSNe+lJ//4oIkjW7HWCCmz8JcDw7f3iO7PeBmoFT4IGI?=
 =?us-ascii?Q?r4CIftQCcesXN2TtufUNInOvlf+Fgv4SjkBKUA75AF1Crz3rkr5BMhSp9p6s?=
 =?us-ascii?Q?gXQM6CKPyoxtauc1L8Xqo3wcy/A0H87OQazO5pxvzsLbDXqElqysnINO/tZW?=
 =?us-ascii?Q?MXmtzSyvLI2EiAZM4D8BlK2HzSJ43+bAd1+7CNvKJ/vKJPf0usO/Z9gT/Tvd?=
 =?us-ascii?Q?S77kpsy5Mo/jU/ZX85N9nzf6m5/fUy6rmadygOyHCd2jrZH/qXZpgG1ABHUL?=
 =?us-ascii?Q?wwuH1IIFmoRHBD7XAhaKodMLI1pgehAhlLpZsxmcqc9NX8/QiZ/sj9EelX/q?=
 =?us-ascii?Q?6ZTrbFrqURBkQiPvJ1wxts0Rr/QCilUNEi+Hfw++xLSXXnfGpoMkNcg4Fau3?=
 =?us-ascii?Q?isvRTEEiW71Fge2GEDyKMhixuv/NPgbVXFYLGvf7llkJz4azvKutkTUhQqfI?=
 =?us-ascii?Q?c2d/yvR1lztgzCmpPfGAqbGO9aZpQeNA/j3pcGM95DSd/1MMceUQTVU8Pfze?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62deed50-ec3c-49fd-7f62-08dc06f09bdb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 15:29:25.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88gQ0xnxDEI7ZLr/uEzGef25HQ3bqlfqEsty13iitzl5SDwqISfXLX0dIRDa1AR2+NeVGTL2ZRszKTrC9hXdrT9sWN+iGFkIvPXRogTrU0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB6548

On Wed, Dec 27, 2023 at 02:42:15PM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > +		These weights only affect new allocations, and changes at runtime
> > +		will not cause migrations on already allocated pages.
> > +
> > +		Writing an empty string resets the weight value to 1.
> 
> I still think that it's a good idea to provide some better default
> weight value with HMAT or CDAT if available.  So, better not to make "1"
> as part of ABI?
> 

That's the eventual goal, but this is just the initial mechanism.

My current thought is that the CXL driver will apply weights as the
system iterates through devices and creates numa nodes.  In the
meantime, you have to give the "possible" nodes a default value to
prevent nodes onlined after boot from showing up with 0-value.

Not allowing 0-value weights is simply easier in many respects.

> > +
> > +		Minimum weight: 1
> 
> Can weight be "0"?  Do we need a way to specify that a node don't want
> to participate weighted interleave?
> 

In this code, weight cannot be 0.  My thoguht is that removing the node
from the nodemask is the way to denote 0.

The problem with 0 is hotplug, migration, and cpusets.mems_allowed.  

Example issue:  Use set local weights to [1,0,1,0] for nodes [0-3],
and has a cpusets.mems_allowed mask of (0, 2).

Lets say the user migrates the task via cgroups from nodes (0,2) to
(1,3).

The task will instantly crash as basically OOM because weights of
[1,0,1,0] will prevent memory from being allocations.

Not allowing nodes weights of 0 is defensive.  Instead, simply removing
the node from the nodemask and/or mems_allowed is both equivalent to and
the preferred way to apply a weight of 0.

> > +		Maximum weight: 255
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 10a590ee1c89..0e77633b07a5 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -131,6 +131,8 @@ static struct mempolicy default_policy = {
> >  
> >  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
> >  
> > +static char iw_table[MAX_NUMNODES];
> > +
> 
> It's kind of obscure whether "char" is "signed" or "unsigned".  Given
> the max weight is 255 above, it's better to use "u8"?
>

bah, stupid mistake.  I will switch this to u8.

> And, we may need a way to specify whether the weight has been overridden
> by the user.
> A special value (such as 255) can be used for that.  If
> so, the maximum weight should be 254 instead of 255.  As a user space
> interface, is it better to use 100 as the maximum value?
> 

There's global weights and local weights.  These are the global weights.

Local weights are stored in task->mempolicy.wil.il_weights.

(policy->mode_flags & MPOL_F_GWEIGHT) denotes the override.
This is set if (mempolicy_args->il_weights) was provided.

This simplifies the interface.

(note: local weights are not introduced until the last patch 11/11)

> > +
> > +static void sysfs_mempolicy_release(struct kobject *mempolicy_kobj)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < MAX_NUMNODES; i++)
> > +		sysfs_wi_node_release(node_attrs[i], mempolicy_kobj);
> 
> IIUC, if this is called in error path (such as, in
> add_weighted_interleave_group()), some node_attrs[] element may be
> "NULL"?
> 

The null check is present in sysfs_wi_node_release

if (!node_attr)
	return;

Is it preferable to pull this out? Seemed more defensive to put it
inside the function.

~Gregory

