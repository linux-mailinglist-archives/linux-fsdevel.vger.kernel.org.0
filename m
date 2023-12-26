Return-Path: <linux-fsdevel+bounces-6958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D681EFD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 16:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8A21C2151B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 15:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6DE45979;
	Wed, 27 Dec 2023 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="yEgtBfpr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48104594F;
	Wed, 27 Dec 2023 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSSkc1zuSdVQBvssN4JMXdsqdsY4GcT6JWW6JbDcq3s7l4TyR2pwbNfUfsjycFaol8hhd3uiI8ZtIVw3Zk5uCAbZ+SNuz35bgbkynCLQEk/WGLyXnEw0PuMQ3pA1qbh6xhMXYL+w/XZes5R/CZCp92wnRHeSW8Yyd48NJeyP+mfxElm9ictlzuye1t8shQMmSxX7YQzf/L4000uU4VY5lnkHnO3CJcPP9Db9Kr1WXOzyNG9k6jBaXHeQmBz1yodiMNErK5G5Ui3NyADO2k8whIaOAY1cu/GHkOFvK7ezR+KfdCRupkNTt0QXMplD3GXjxYvJEAipsvoxhgUQEhel1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lV/r3wrzv/P1cpHKGf1oE/q17CRSaA7h4lEzm91iBvQ=;
 b=Z5qbIOL0NyJhvcK2ZCs2v3mfhhXmulMN4TeI2v1PkWN3GQyQxrzwRtOVpN1cirLI4anFalyvftDLUKVFO8EoqvOQPdAfJnjl5Vga27/I/LFedjDlK20g3mjJU6yoi5VPpOGzWM5vXMlf8tB1J9oYNNJ7sp8w5VvO4nhvexehet27ea0rMdQKUzC0Fey5VfqNGi6KaKhWhaOZ+48fv5abg2RWxOOTNeMgBzLNnL34QySrvvvQhQPMHLsudPmbghde4lWeLTylQz0U1TlqSeyhwPVEIfrEl+L7cK2oXFUkiRDxh0uQaYHx9SBgVNuk8kR9Ao2OTCGzgCM8051urQ6gig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV/r3wrzv/P1cpHKGf1oE/q17CRSaA7h4lEzm91iBvQ=;
 b=yEgtBfprCs2+LD3Jo/G4VjyeuJNZEvlgGc3KPDHWOrD0VehIrbnarerLdllvRx9KtDVs9wLoFhcHrPEVq34lVr3jmYuQYV/SCuwacVZX+di9U+Pu5aXv5IWETxo+4CpzPoEiRKmnbZjnS2Ju97dxFEus6+ZGMw2unbie19a4Uv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CY8PR17MB6577.namprd17.prod.outlook.com (2603:10b6:930:72::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 15:42:13 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 15:42:13 +0000
Date: Tue, 26 Dec 2023 02:01:57 -0500
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
	seungjun.ha@samsung.com,
	Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Subject: Re: [PATCH v5 02/11] mm/mempolicy: introduce
 MPOL_WEIGHTED_INTERLEAVE for weighted interleaving
Message-ID: <ZYp6ZRLZQVtTHest@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
 <20231223181101.1954-3-gregory.price@memverge.com>
 <8734vof3kq.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734vof3kq.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::7) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CY8PR17MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2f5ab2-42cc-416c-27d8-08dc06f2656e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nm1B0v2UmFowLmbgxX3TNFd457UVbINZGbzWRbmGFpZYNVhf22QbLUHDyMaTrK2lkhrjrNLYg5ccU1byHhug+m/VygQonT+UThhyltWC7FquMskuNUnad7sSMS35znAgZeEPEClkTOjBO8f8F2SKpfgRDZAvIPHsRP4+HJr2zegIlwWBXY4v+YIpi2879dlUA3dPpTPKIZbw3/PWpZmVqeLMgCxBWizG71v1Ui4dxC/gdNlsugzvw2piktVcqf0I2BEuRXNvsEByqNY43q3fXUwoh53w/4eBSMkHaMykq+b+Y+JMWDH98NhG8cG/0EDLRKd6EdvxHXWZ1oboiCbx/Nr3+CEMIZinjrfoPeuBxJklXxbLKXAYa2PA70nceU2fmGfJiAMJNlgwcjUTp88SKt+WRD5n5yOHDLaCWzm3jE6t7XGDwdzuxDW/mdN7MZEwozBLTxdNe/uf4mcQ9ST7t6eLgcKR8sBNVlDEQ7//St+g5o2x09qVCWerpWW9uGL/AXz0TdNi4Gh3DPwtLPzdsTxP/FLqSHHpH3Gb8uPGvotSgLpDhf/pmkj50T8AYirsZi/uCnaDHzBPSJwbKGsblIuAKo1ZJWvtvskFUSV8CvREHr1EWrcwUboTvfsP3j64
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(39840400004)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(4326008)(6512007)(26005)(8676002)(66946007)(54906003)(66476007)(66556008)(316002)(6916009)(83380400001)(6666004)(6506007)(38100700002)(8936002)(478600001)(6486002)(86362001)(44832011)(5660300002)(7416002)(7406005)(2906002)(36756003)(41300700001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BZSFl38f5Hmiq22pASl6SDhMkbWNFN/FwD1hEU6qKJkcJ57BVoDOUU6AIbZh?=
 =?us-ascii?Q?xTc//WMbmpFBayokTsYcByhZoTO1fAbKKU0rQsWvWl11pb86ftEBOAAqokLE?=
 =?us-ascii?Q?gOahcgwVP2ovx8np0E3MUzGVlHxpztDq9YzcXghquJ0dyCw0S0D5jUzt8wdz?=
 =?us-ascii?Q?FJ1wwMm1oTKx9AYZWcBAoi7Au+WQ+TsXpsjLUVqaF244QdGeNuPXHAi1CFxo?=
 =?us-ascii?Q?poaWr40CZDZbzPN6Wc1gAZ9vuH2Zxm0OjwhLltA8pwiH6q1mSmAUHDvSddhs?=
 =?us-ascii?Q?VYV4p/BrdvIzhqrYPjPFcUELsomI9nB8of0UpbXNWOeOr2KfkvyNxF5bNnih?=
 =?us-ascii?Q?Ld6CxknQY/1QCDq2l6+VEH2S1H/Xt4qPajuXviq3pJQSWebySq0HrAiERJBQ?=
 =?us-ascii?Q?AyyVY5xyzz8/bQfh0wBW0EXGCjk2vmxxtmVGJaYuF15ii3xaslJ3WEhhDmWG?=
 =?us-ascii?Q?6voRkji0Zo2feTrpQfZzNSr09Yv2QosR0tUD135jViZYIvWFKUrzXEIUdiAC?=
 =?us-ascii?Q?IkKtdlYqwOrNo2LQEmsJv0GoC+v6F5z1Tr8iT7R328t5vUJ/e2nd5lVJox7B?=
 =?us-ascii?Q?W59I3EbzaQ9dcShCxUWx67MDKAIWzmuq40LYTSnjTqrWV1CfyBS1Mj/LTIrA?=
 =?us-ascii?Q?bvXCDIhjMwKIWf9wUUwNbQrZMzEH10quwgJ5anhzmxhsxZJ4zrKn2mY3oYKl?=
 =?us-ascii?Q?KsRbmWvPF6N9sZ0xOeN4P6hsQ16h98Cu4257eCe+VIkuO0hQF/JsNwoNFmfy?=
 =?us-ascii?Q?UE7cQm/sIloV4h1qcYemFGylrizLUF+b1urJLgPtHpmLTglFnKxtpv1iDj6z?=
 =?us-ascii?Q?uO8rmAaREI7Q1qCRA3OTQBKnxVfLLpHPgCAP8abK9ox3Cff9Rw4U35rWdQCI?=
 =?us-ascii?Q?FjsjjGCyC8K0IbY5a/uZ0mGqszSw2jxYLdA+argOn6ARzM1yL2n3UQuozKvV?=
 =?us-ascii?Q?cEOgOHV/CcaB/BLcVWS1rCl726u/XxGQactqke4OiFsT/K+prYI1JmswPC2q?=
 =?us-ascii?Q?L0SnL1gtRq54HGtrHzkX2c/iu02JDSWIcVfaIscjREmedcua/vNORWwbFU6w?=
 =?us-ascii?Q?kV9e+MLGcE4iE5hEJKUgO0OQpRqw+wTTUksxY0cd6OQLlmsBJesO5U40TdUt?=
 =?us-ascii?Q?4TBtKC/zEdi6nB4VVOIWWJi+icrg9qC+gTyv8//A3j8eVfFeyflJLeOK+zLp?=
 =?us-ascii?Q?yMGOgBC/UT9tJtmyYX9wILTf3aIVANTC4INZCNGuim/M5v7pPcUoYZqBRxar?=
 =?us-ascii?Q?Aq5JYgtLLF83VEWBXqIWhTafXsz8uZrZFzIGERz79gFn0M8MsqRboQswtNhP?=
 =?us-ascii?Q?TPzdT+oD4t7+69VwP9ybLGOj2MIHGfUBu84shAB65r3Uoz0TjmnS40RKfPLq?=
 =?us-ascii?Q?WaUli35nbLyIt2lJGNzkBp1si1zNmfuWkt5yIfLyGdlUra5OxVLOK9yUTy+r?=
 =?us-ascii?Q?t1mtAMe/ta6HAPDXZtIZ74FXSVHJtBONicOwyDRbG8y0t/UQyCntmH5+osQ7?=
 =?us-ascii?Q?Q2Ii8I2ofSZUzJbSUGTAtXFWgz67r5HgMm30F5jVORYic3xBqlXgW6HQP7ia?=
 =?us-ascii?Q?7MjrL/Qb/8GhfTWRsInMtFanGf9Q/UklVUvLI2sVHdaGt92ZjFC5b+LogBJX?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2f5ab2-42cc-416c-27d8-08dc06f2656e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 15:42:13.5523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2PzBkEhcMNspzWJW55h0AcnfFx2sbMgw6jSzlJ0VPWP4j+cyeeTBvi+VQ31xx/4FPEsFzpv6PVyw1ACbyr3bOdpGx+Q4LubBWE7wkVh7AI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR17MB6577

On Wed, Dec 27, 2023 at 04:32:37PM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > +static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
> > +{
> > +	nodemask_t nodemask = pol->nodes;
> > +	unsigned int target, weight_total = 0;
> > +	int nid;
> > +	unsigned char weights[MAX_NUMNODES];
> 
> MAX_NUMNODSE could be as large as 1024.  1KB stack space may be too
> large?
> 

I've been struggling with a good solution to this.  We need a local copy
of weights to prevent weights from changing out from under us during
allocation (which may take quite some time), but it seemed unwise to
to allocate 1KB heap in this particular path.

Is my concern unfounded?  If so, I can go ahead and add the allocation
code.

> > +	unsigned char weight;
> > +
> > +	barrier();
> 
> Memory barrier needs comments.
> 

Barrier is to stabilize nodemask on the stack, but yes i'll carry the
comment from interleave_nid into this barrier as well.

> > +
> > +	/* first ensure we have a valid nodemask */
> > +	nid = first_node(nodemask);
> > +	if (nid == MAX_NUMNODES)
> > +		return nid;
> 
> It appears that this isn't necessary, because we can check whether
> weight_total == 0 after the next loop.
> 

fair, will snip.

> > +
> > +	/* Then collect weights on stack and calculate totals */
> > +	for_each_node_mask(nid, nodemask) {
> > +		weight = iw_table[nid];
> > +		weight_total += weight;
> > +		weights[nid] = weight;
> > +	}
> > +
> > +	/* Finally, calculate the node offset based on totals */
> > +	target = (unsigned int)ilx % weight_total;
> 
> Why use type casting?
> 

Artifact of old prototypes, snipped.

> > +
> > +	/* Stabilize the nodemask on the stack */
> > +	barrier();
> 
> I don't think barrier() is needed to wait for memory operations for
> stack.  It's usually used for cross-processor memory order.
>

This is present in the old interleave code.  To the best of my
understanding, the concern is for mempolicy->nodemask rebinding that can
occur when cgroups.cpusets.mems_allowed changes.

so we can't iterate over (mempolicy->nodemask), we have to take a local
copy.

My *best* understanding of the barrier here is to prevent the compiler
from reordering operations such that it attempts to optimize out the
local copy (or do lazy-fetch).

It is present in the original interleave code, so I pulled it forward to
this, but I have not tested whether this is a bit paranoid or not.

from `interleave_nid`:

 /*
  * The barrier will stabilize the nodemask in a register or on
  * the stack so that it will stop changing under the code.
  *
  * Between first_node() and next_node(), pol->nodes could be changed
  * by other threads. So we put pol->nodes in a local stack.
  */
 barrier();

> > +		/* Otherwise we adjust nr_pages down, and continue from there */
> > +		rem_pages -= pol->wil.cur_weight;
> > +		pol->wil.cur_weight = 0;
> > +		prev_node = node;
> 
> If pol->wil.cur_weight == 0, prev_node will be used without being
> initialized below.
> 

pol->wil.cur_weight is not used below.

> > +	}
> > +
> > +	/* Now we can continue allocating as if from 0 instead of an offset */
> > +	rounds = rem_pages / weight_total;
> > +	delta = rem_pages % weight_total;
> > +	for (i = 0; i < nnodes; i++) {
> > +		node = next_node_in(prev_node, nodes);
> > +		weight = weights[node];
> > +		node_pages = weight * rounds;
> > +		if (delta) {
> > +			if (delta > weight) {
> > +				node_pages += weight;
> > +				delta -= weight;
> > +			} else {
> > +				node_pages += delta;
> > +				delta = 0;
> > +			}
> > +		}
> > +		/* We may not make it all the way around */
> > +		if (!node_pages)
> > +			break;
> > +		/* If an over-allocation would occur, floor it */
> > +		if (node_pages + total_allocated > nr_pages) {
> 
> Why is this possible?
> 

this may have been a paranoid artifact from an early prototype, will
snip and validate.

~Gregory

