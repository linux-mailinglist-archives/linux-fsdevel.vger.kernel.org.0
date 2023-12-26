Return-Path: <linux-fsdevel+bounces-6970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 317F381F1AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 20:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4251F2308E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 19:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CF747F53;
	Wed, 27 Dec 2023 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="awjCQzKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A260347761;
	Wed, 27 Dec 2023 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKVuGxYMr2aO1NbJ6WFsgbmvKGfLcROnJiimAf/ONPY7z6fZftqbdX2LWLZd3I1y0xuppHJkQabOHuIAKOxLW9kEkdAFF6XoLudBqH19W5zTFxmJnpD9MmBtuazyqTMKHuBO09LFnzAUfbHActVqVmfcQ31Pm+EeTfpDZPyllYHRI5hgPyspCMB2gC+q+++KnamI4ebUOsOnLCi5aQc4vHnCWdqPzKwQ50UOo2VOtlcAfV4oJjaL9pYVCDK36FSLCKECcJri73kzydtpUdNTVp/rB20ayWd5PgyoLcSLGKvsp6GjNqWBXnkMHf3mMm8VRRr02D90B+tk/av2ypcs8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtjAlTX2HzUw5cC2SujbNKCIunnZGkeGftLbnj0MQzU=;
 b=fHULR3lznkl6SR6zNJdNzhnXae7BaZEzAPQAAEmH+k7VhWJRF9JIZ2WBnfqyLNPfsjIdXTWT3qA1cT9UMVTSPAbYpozyX7iywBNmc+mMEn3LOkylpMntmZ4nfcFNPX1DirbnDeH13dJ0A5WtdMcETy7pCGtx7ndHZKx9bnqztUAzKXJiaByTjAxZM+CJI4+Okm5HHanwW6S9cxCgdyyetjHCpFEuU0dxoHv9XR/41fqJfw95bSRWnnxJeVJ+URkxDpYTbqbBGNf4AY4ayTu0J2fo37PnVniaDDIRptPPUENTQfCGaq6mC5S2TsTytnU98Hi7I3CaBAiRTNaSZHABUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtjAlTX2HzUw5cC2SujbNKCIunnZGkeGftLbnj0MQzU=;
 b=awjCQzKknGDS4ROKDrWtet97dh9K7MxfDPRNip55o1ZFqqn1SNeAO3upZF0i9+m+9RuahTwJLnapjgy591oSpQjmh8w46mgG6LRH3wwoI4N5h3aa5sDWlL5JBnJUi0U5eQTpR0Vx5pAh0xtqIPku3/9LoaLhlJr2DTxYpVUwqdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM4PR17MB6939.namprd17.prod.outlook.com (2603:10b6:8:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18; Wed, 27 Dec
 2023 19:52:20 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 19:52:19 +0000
Date: Tue, 26 Dec 2023 06:32:54 -0500
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
Message-ID: <ZYq55i03DIYCuC0u@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
 <20231223181101.1954-3-gregory.price@memverge.com>
 <8734vof3kq.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZYp6ZRLZQVtTHest@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYp6ZRLZQVtTHest@memverge.com>
X-ClientProxiedBy: BYAPR01CA0045.prod.exchangelabs.com (2603:10b6:a03:94::22)
 To SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM4PR17MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: e86497ec-4eaa-4e48-1dfe-08dc071555d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	azhoa98W2TmDNFX7YPBhdSW3Q+USs/98wnpOrXgeo3jYnW1dmG6yw4mpj6fRr8ya0H1zOxCqu9fy1WVhvDqPBilZB3XMX+tpV6b67fWCMdc94dje9bc0Fq0GLx9CgOu647ZGnsZD8M8v6B2YQQUx2f+JzMhNOyH8eWPdH+aQ2qnWHETWu1nPgHPrXfdgr1JONE/kpf9oSKmnsKyOxyyvPMWV94Rssv4fcz2yJ73oouWwYnfJsj3UWl5z3qnYezpa/0qdhaFRn8sXUMCQ7cbgWVWOcifYaJ4FeqBmAveGsi41x0GYs7Hui9vunyIc47rwBsI2I27Gos0BllWYic8hMbh1QrPCSXSDosCW1BiIST7DVeMm51Olfewr+kd4Vu7tw57RczlqiFe48vtYjAehZDH9oGC05SYfPWFfOpSlFi5mz6uW9Maykouj8mMoKXw+DMJ4+OFTwFQg/2S6yBXxTLrAIE4J0H7gvYOxtSFNTsGpY+J+i2fF5zn7LXJiQJtX/Eh5Di0LXJNHNZLbpgRmaUUJSr4mX7mjZgs8GaLhk1Rr8GzH/2EUvUsqmJnKcN60dREVO+0ZQt3pEyWAvtIjlKCSq7nzfUyjKkJd1g5VnXGgi21KoqC8TPvSj0l6Kd/m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(366004)(396003)(136003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(36756003)(6916009)(6666004)(6506007)(6486002)(66946007)(66556008)(66476007)(86362001)(6512007)(38100700002)(26005)(5660300002)(2616005)(41300700001)(8936002)(4744005)(7406005)(44832011)(2906002)(478600001)(4326008)(8676002)(7416002)(54906003)(316002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xuj8GFvvxUBEl8iE9MqV23Y0gq5q3la1yfi03L/68cLHr2BzjNoqbxO8jR1/?=
 =?us-ascii?Q?rIn8saXfe0FREsqGAe+IuxWR1rsJbylOuwVgepSw6gpcZGC0EeyySWvmtRDI?=
 =?us-ascii?Q?ZoTE6NY6eNG6heC++Nlo+MyNch48bMYV+WSUL0OROBEMLcTyfJ0tsE24wkmV?=
 =?us-ascii?Q?KczpRJgQjcJinSGC/GEu3pktBIheCCyxkXwu+RMiSqVCtg+44KOe5dBXNpy3?=
 =?us-ascii?Q?IiIBoLIaS1PNGgVTIOj0MD3IN/2FLnJ2WmnuM+WFnns+Xs9GTR2U1+hvIOGn?=
 =?us-ascii?Q?pmYzJ7pNZGJ/bbMJI2Q2j3ER3sxTWyD1V2oDygeqbmjDvlOY/xmekVlSKH0K?=
 =?us-ascii?Q?c8R4bH1NZyyD7+sr8UP4vcOUSOGUdfTQdemR6+u6qAGXyx1yjdTZvTpHzoDH?=
 =?us-ascii?Q?m7HSZD6XfPGCqGGJaOvp0FvAtwtJ+3Qb5B342t4aN8ygsgUtJ4atyuYSorYM?=
 =?us-ascii?Q?euD04WDm1JdC8emk39OMAYCn0WbxBQxqp/u0y0MORnXSbZdL3Ag2jRz1r8IT?=
 =?us-ascii?Q?Ept5gjqsBmV5FhHx0R+J5mT8myUfWLklq9M6Lv0I0PCSFBmc7YyOgj2NV3Bq?=
 =?us-ascii?Q?Ocj71NeQ1+V/C778ftGELsBy1RYlFxLcDi0UNuH6irwTu9cnl2p5wU88Kbbh?=
 =?us-ascii?Q?WMI7Cqe9pxnNzZl75X+TrXvl049Bsanv2NQb9Z3dVz2kTq5CLrYV4DXf+OeR?=
 =?us-ascii?Q?S3L372yDEPdIYrNBSR0pW9AWZbfcq1fMxoGdZAJII4XIDpceySrwPgo+fFDg?=
 =?us-ascii?Q?FyUQtIfoHMVIDnZO0p7fHqTxTgfWHFOKaRaqhuUnnDn1OA7ZA39sZZDC4xlQ?=
 =?us-ascii?Q?JVnkQe1oSGJr01A8TIURxsNe1gwPBp9HMk7x47d/3kMp+/Qrks+QjeWd60FW?=
 =?us-ascii?Q?CGeD0WMtn150OUz/mU6VJQsramF4V/SvdEHrB7VIzfUiAeGA2Gn6krBhh3/5?=
 =?us-ascii?Q?8csEzjKZK0/aLGzMWnziEMHGYvEKoJh31GDpqx4uAF/bE8sapFHQMFNjK+Oy?=
 =?us-ascii?Q?3LDF82DbJvyYeM6pcbofMxsILf5A+DH86JbscbBvEV1/w/trctbJjVWULfmZ?=
 =?us-ascii?Q?oqjPVUad9mhWiqo1Z2ASwdWcQ6/tTwNbXg1no8CPTS/6ziATtWJcbwDEA34M?=
 =?us-ascii?Q?TMPVHcSny+lsz0W2UozZuIVDUbOzcDqsbAIVrQ+gCPRgmftYFpPFjPVYDQMZ?=
 =?us-ascii?Q?OLdbW1EpRKcBFe1yf2Mmf1fQddk37Xsxe+mCLUsWRCGr3ks6ZiGzWVa7/jDp?=
 =?us-ascii?Q?Pw/ME2NU5Jjp448NgH00gn7rkjzSJ+2wozLzm+nTJopID3+cwUjBHzIX/SS9?=
 =?us-ascii?Q?a93gY9WSSiFp8xhHAJ+QeEMfC+6AScZ/qVEUeZrxPDZ4gNbdUX8cfVPWObN/?=
 =?us-ascii?Q?WXxrBmfvP8w3ZE9otM1HIZvhf0otUYiKhvWYU4zleW/c2IWDsKAesv96KnJ0?=
 =?us-ascii?Q?FwDB/vyF12boUPRlrAzktNVyQXD+MVNPxpWwp0xwtuf/C6X4ejXA0dyNu80k?=
 =?us-ascii?Q?1UrIxb23OdMrnB/Gd3F2wukwrqS4QtTm6QtYCZ5vQtJKJ/HT979lXiVSNnaK?=
 =?us-ascii?Q?SO1EQoeidTPb0o/ctkT9GdEBFEcNJ3YOBVYVDdC5CBUraX4CotxwIdlWdMR7?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86497ec-4eaa-4e48-1dfe-08dc071555d0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 19:52:19.7089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4G2XUfLVQro0x8advvzpB+eXVO2qdGYaMGShVc7L66e8SzMfeLrZaLoqbf1FnYDOOtQx23CqW8oHSi+iGTbWppwwKfrQXAq8hHcVc7mTE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB6939

On Tue, Dec 26, 2023 at 02:01:57AM -0500, Gregory Price wrote:
> On Wed, Dec 27, 2023 at 04:32:37PM +0800, Huang, Ying wrote:
> > Gregory Price <gourry.memverge@gmail.com> writes:
> 
> Barrier is to stabilize nodemask on the stack, but yes i'll carry the
> comment from interleave_nid into this barrier as well.
> 
> > > +
> > > +	/* first ensure we have a valid nodemask */
> > > +	nid = first_node(nodemask);
> > > +	if (nid == MAX_NUMNODES)
> > > +		return nid;
> > 
> > It appears that this isn't necessary, because we can check whether
> > weight_total == 0 after the next loop.
> > 
> 
> fair, will snip.
> 

Follow up - this is only possible if the nodemask is invalid / has no
nodes, so it's better to check for this explicitly.  If nodemask is
valid, then it's not possible to have a weight_total of 0, because
weights cannot be 0.

~Gregory

