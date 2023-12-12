Return-Path: <linux-fsdevel+bounces-5715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A2B80F1B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91028281805
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A933977649;
	Tue, 12 Dec 2023 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="ZT/wc2Js"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA72AA;
	Tue, 12 Dec 2023 07:59:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxC/426LU/wtHKA+BnlH3NB7hO1iwyF4nQ11RL1D2cKXKBN00wwB8JCxP8fN+SwUZF9mbDgMXZfdw6IKdDxllZXmDhs2g4okKj/Kb8AURiuAIbzZLOjRHn7iGLRYVmZ94aUBHEImGfMJqTyK6SRcPoQEFrQyqF7qC8bfp0voVK3oRCx8iskhQUilfCLCtIj8erDciYz3Zs1fX43F0vCtoT6shrwWYDtnpQo5aE4X+OmyFAfjFniC0wV78ackQT4AWTbutFBmtRy5V6URAj5oQoAO1F0QJzgqdFL+k8BeeJjUketfrnIiwnAcweKUVpeB1NNdL+NrlqAx4kQu10yFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETVv9IVOPuZwFuu1RONN+q9OvrA1tFu1scKt0AjuDm4=;
 b=BriY6R5iQOzxIQIWaMZnzAVfthRkRRQjhY9vZrw9TXnD87bpJABh8zHbqx0EU0CnAF2CPYnLqDkiTo3yTqQ/USzLJ/Gg+4pj2tHYB4NPAxZ23uyk6MtVO44I5beFxejSSyieIY0vGuOduF20jKTd1jgPgkCuc9CSh+b9FhV0z4SVj2fHAwC1Xlnh68tg88ItmvsUarB4HuIzq5uNjP30BTVssRTkFaccV99NlivJcv9I4r5HVLIAZN8RV9Z/KGSqLZoJOEyrHODYxV5deTgBtyGd8ihA+PrhFh9BZXCKKV7ycQlXv2ckoUVd066JvRxh1yd7L4BkKT8QIdBjfhXPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETVv9IVOPuZwFuu1RONN+q9OvrA1tFu1scKt0AjuDm4=;
 b=ZT/wc2Jsrzp9aKGwp8LEsn/rkSTmhEAx3kyg8ZXn7b1s9JsY6O+whZOuUQlU/E1VIlwamItyWyFH+1JXNI/DXf35PpRVs4PtKIUDLq3X9mY5QSFpnU/x967XbCjPibIjyc4aGxv9F2RbXskDLT8kLgy8pMcPpxHGDyx7IpGyemk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SN7PR17MB6483.namprd17.prod.outlook.com (2603:10b6:806:359::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 15:59:12 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 15:59:12 +0000
Date: Tue, 12 Dec 2023 10:59:06 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	arnd@arndb.de, tglx@linutronix.de, luto@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, mhocko@kernel.org, tj@kernel.org,
	corbet@lwn.net, rakie.kim@sk.com, hyeongtak.ji@sk.com,
	honggyu.kim@sk.com, vtavarespetr@micron.com, peterz@infradead.org,
	jgroves@micron.com, ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Hasan Al Maruf <hasanalmaruf@fb.com>, Hao Wang <haowang3@fb.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Frank van der Linden <fvdl@google.com>,
	John Groves <john@jagalactic.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 00/11] mempolicy2, mbind2, and weighted interleave
Message-ID: <ZXiDSrdNfbv8/Ple@memverge.com>
References: <20231209065931.3458-1-gregory.price@memverge.com>
 <87r0jtxp23.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZXc74yJzXDkCm+BA@memverge.com>
 <87plzbx5hz.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plzbx5hz.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::14) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SN7PR17MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1ef72c-d893-4ee3-ae00-08dbfb2b4893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7BrZyukzSsN0SEnD74MbsJKesD3ver2YH0NAi2ZwsILjdIgnTqkiYOk7GFnmd6UoVvlKAUHhyX5zNTelH3qU3CXNEQ//k0+04q0/s/3+doUE2+52rxDsAtMfYPhfBO+YWBSGLmfY7jYWeSNQJ97/sBDXbc9tkt875JSkB1RjcgLK/5JfBcns3UAzXz1iCrIB/FMJVKwK4p/fO40N3dyshFEXdDqxHOx75mgJWttprOreowwDGOr03Mzu+e8QVUUQN73QjoNtfZCXsikc6uI3ExUVSvi8qVviFGV0KmRNLB/osx6TbPyF2WTrHNhW//xY9tgp2+919jvicIu1arWFNyuXJVnH+kM7VYoD690HWkR7ioeWDhFdx9dkCpRdoYWJCAsKpvz/xEMpMaTqIfKgeTZ8O+qQfkp8oCW/2HziPwzUoW750DfcFMTykbI5+j2Ufn5Eph1VZJOn0BftsZnLMCbOdn8D2j4w8lnAnh+P4UzQXD9AqED6s6/7BIBjwpwguI6FH4B6Azisbd0q/UHLxwDoIgqph5V6KXhd4VOL5u+xoxR1EjlDLgmi7iN3151FYYwZa2U0nGjOU+sflsu+EBtai85mwOV12wIEmOvljibKWkKhH5DitBWw24n42CBw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39840400004)(346002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(5660300002)(7416002)(44832011)(7406005)(8676002)(8936002)(4326008)(41300700001)(316002)(66946007)(66476007)(54906003)(6916009)(66556008)(478600001)(6486002)(2616005)(6512007)(6666004)(26005)(6506007)(36756003)(38100700002)(86362001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cUDIT1RUMW1buLYnH0XADOIO6FV/AKX1ug/NlUIDaCs/INPodrn08CfIpqN/?=
 =?us-ascii?Q?3vMyXJ0OpgD7XoETEmnZEJe+bLTICB2A8ouKS6uRH/4viI8pEUW/feNzQzpv?=
 =?us-ascii?Q?BpHTj74Zc3ZFUl/UE33BieMr8CFYj+4y2XfojIzi3+4pU/ACOuMafOHd5eJu?=
 =?us-ascii?Q?BlfqhKupowILip5CjGKJ6ANPdMRJrKPPisegUUEqzo7BOSdmm5WhLlXHFrII?=
 =?us-ascii?Q?pAN37nELkvn739Ve3jOs8Px5i2iRQHwO47czLR2rqSigGiXoa58836Ui+QrA?=
 =?us-ascii?Q?XHdV0oUMCvvcTzYsFVSDOhK9nxm1PBtfIqIG9Z2yIroWcgedvtv+rrqnHKV7?=
 =?us-ascii?Q?RaWtjBmIrTZhHH7+zokkzqT0zq2yeI+UK+XYzaW3XRyr5bp0Inr5wDsHwVri?=
 =?us-ascii?Q?41pU/Me7PwK1DjZjkOWGu0ip2/f9uRd+vcuDafZb6cmtCrQgmAylgZGG06CV?=
 =?us-ascii?Q?DKrMPBBTm7jO+4kLNIls0GBLKtl8si7oMqVsGlvKHsFBRFKkIsJlFyzLP1up?=
 =?us-ascii?Q?N2OYVq35FLC42CgG5IvTYv5cPANsAR0LOFggCrwyZ0Z0+66s3NZashCe9FNG?=
 =?us-ascii?Q?nEpxu24wWrn49e2/mRjpmcf5A0GIcE4rnZ0aDd1SeEsyHb5b8IOS1sP/1+/x?=
 =?us-ascii?Q?YiLz99dJgl04ug+WRExNRbaE5qXBQLD0MQFrs2ldaAS69AV31vfPVfM7i6PZ?=
 =?us-ascii?Q?+mli+v1GBmY7ycgGcrUrAlE3TNW7+nSctx54bLzp7TOuT6A9/nR7mUsETYir?=
 =?us-ascii?Q?plvz3CcXz4gNdgf6EVX5QHrO5GCo+mXsVqjETDEG31yjW3qgsELZ856tRb75?=
 =?us-ascii?Q?rxu8xe5iKZQNmzEyKlLscNttcuXgQoYJYKWrc4hK+IDB7rJgEdKlXqNoiA/a?=
 =?us-ascii?Q?zSDW8LxE8lCVXLoJW8kbMwf/DjV8efzcdLQf/0ET0s1kHxyI61FHauZrEHfZ?=
 =?us-ascii?Q?egg22267zNhUnUtVv1QK+noBlMptkrsp8pgZw2lkeFR8S1W8KAH05DoEN9IV?=
 =?us-ascii?Q?E6dID4MM2TCWFyl54TwdGn17MP4Ot2Drei9Lbpqy5kt0WE48KRw4A+oHiROk?=
 =?us-ascii?Q?v1FU1+XYAif5nlee+xIZQxJmNhgdz94WeM85wyPQQ2ER5ccX4CzIVhLcCvf0?=
 =?us-ascii?Q?tbptXXENv9TB7KfIJ0LvTcCGTAcpxegqJl9B0l/6xwPxoiX2ZkTI+fHSjibF?=
 =?us-ascii?Q?jRP72260uCUNIC/3/Alovg6S4LRpxNg8ZKLqAKENljVjqMVyadb/DVyN/4WR?=
 =?us-ascii?Q?PvglkuK2CvPZhN0oN8qEcEvExeSmEG4djD7J/4JmdOoPR7fvClQwidHGtgLC?=
 =?us-ascii?Q?EaQI7DZYeQFiHle4SwGu6jE9VsxHvq4WMTU2YVO/u0dPKnNA9fCQUkhSGJFQ?=
 =?us-ascii?Q?e/KGPQI4ELeYydf0FuPEWNlEOcbxkKWVxp2Teq60eXTiP0Jdn/SCyXqtNomc?=
 =?us-ascii?Q?R6vewHwULw0wWW3gSltsjdE32Li8BUwmRgWSQfGI9Ry+NHJH1Y2doc8U+Z2Q?=
 =?us-ascii?Q?9unNHlEs3dnnRVrXBcnYg8bS692L8zVyKPEfX1fuF2S43uBrLFKnIcdP76Z0?=
 =?us-ascii?Q?HPPHPEByHVDRPERgOZ53+v3af5yJozQXCGGOvZHnekmFJVd2f8WSNg28He1E?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1ef72c-d893-4ee3-ae00-08dbfb2b4893
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 15:59:12.4440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuYZw9TscuJYleWasYe1kJc6odmkEC5HgoUzZgeXEjfMKc/V/cP8OxIBEkko9arlobNSH1WNtLSKv4FHgUBgY7OOxZHV1jxTv79kFeoaaK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR17MB6483

On Tue, Dec 12, 2023 at 03:08:24PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> >> For example, can we use something as below?
> >> 
> >>   long set_mempolicy2(int mode, const unsigned long *nodemask, unsigned int *il_weights,
> >>                           unsigned long maxnode, unsigned long home_node,
> >>                           unsigned long flags);
> >> 
> >>   long mbind2(unsigned long start, unsigned long len,
> >>                           int mode, const unsigned long *nodemask, unsigned int *il_weights,
> >>                           unsigned long maxnode, unsigned long home_node,
> >>                           unsigned long flags);
> >> 
> >
> > Your definition of mbind2 is impossible.
> >
> > Neither of these interfaces solve the extensibility issue.  If a new
> > policy which requires a new format of data arrives, we can look forward
> > to set_mempolicy3 and mbind3.
> 
> IIUC, we will not over-engineering too much.  It's hard to predict the
> requirements in the future.
> 

Sure, but having the mempolicy struct at least gives us more flexibility
than the original interface.

> >> A struct may be defined to hold mempolicy iteself.
> >> 
> >> struct mpol {
> >>         int mode;
> >>         unsigned int home_node;
> >>         const unsigned long *nodemask;
> >>         unsigned int *il_weights;
> >>         unsigned int maxnode;
> >> };
> >> 
> >
> > addr could be pulled out for get_mempolicy2, so i will do that
> >
> > 'addr_node' and 'policy_node' are warts that came from the original
> > get_mempolicy.  Removing them increases the complexity of handling
> > arguments in the common get_mempolicy code.
> >
> > I could probably just drop support for retrieving the addr_node from
> > get_mempolicy2, since it's already possible with get_mempolicy.  So I
> > will do that.
> 
> If it's necessary, we can add another struct for get_mempolicy2().  But
> I don't think that it's necessary to add get_mempolicy2() specific
> parameters for set_mempolicy2() or mbind2().

After edits, the only parameter that doesn't have parity between
interfaces is `addr_node` and `policy_node`.  This was an unfortunate
wart on the original get_mempolicy() that multiplexed the output of
(*mode) based on whether MPOL_F_NODE was set.

Example:
if (MPOL_F_ADDR | MPOL_F_NODE), then get_mempolicy() would return
details about a VMA mempolicy + the node of that address in (*mode).

Right now in get_mempolicy2() I fetch this unconditionally instead of
requiring MPOL_F_NODE.  I did not want to multiplexing (*mode) output.

I see two options:
1) Get rid of MPOL_F_NODE functionality in get_mempolicy2()
   If a user wants that information, they can still use get_mempolicy()

2) Keep MPOL_F_NODE and mpol_args->addr_node/policy_node, but don't allow
   any future extensions that create this kind of situation.

I'm fine with either.  I originally aimed for get_mempolicy2() to be
all of get_mempolicy() features + new data, but that obviously isn't
required.

~Gregory

