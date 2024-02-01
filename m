Return-Path: <linux-fsdevel+bounces-9789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9797C844EF2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 03:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEB71C2699F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 02:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D31D10A32;
	Thu,  1 Feb 2024 02:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="E3UOeauO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2110.outbound.protection.outlook.com [40.107.244.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926C2FC14;
	Thu,  1 Feb 2024 02:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706752878; cv=fail; b=b9Vx3HJaO1ToUeW2v1cWp7SypDTwWpCLhjhOPmrkHPCyQBZEjgcn0e3k2LZf5DqTW7f1zGcrPXNK015PaXsrkEIzancvVPhztPLW9jf8uK+NzpPXjCyZv6QB3LZ6aBtMgZ9UBGfTKseIDQVXWebsNB9RuFzeKIzvOKg06YGHVLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706752878; c=relaxed/simple;
	bh=CCXwS3LRPC2VM4lrPwmOvwtQpa7WeHQXUG0Y86YpiiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qzLSJHQ/NiNCpy56NbQ0hVSs3ZS2QvAcukdqWN0DTL2h7VzNyZd8P23CHyARVL5mQn0HEaIrZ1w3vkG8eP2nXfx9DmHR/oIWAimmfzvC+VC12MWu1aS4NmVQnApcqMFJ8sYI+JB0TW9e4cUQBT17n5BQT7taN7JwxaL24O2HSTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=E3UOeauO; arc=fail smtp.client-ip=40.107.244.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuNUgMINKm/R7hEP9k6WAwuefdbcZnUU6ANm/7Jw1fqrHjti4nhafqxdITn4RlbuVxBwx+PLZmMwStiqyJs3HWsABjVfpU0dfqPjxv+7R/NTp/bx0qF+r9sYWDw6y046YYWbaEt5awqPB99oFGsquOiCYYLcsHCMFScT4KunxAXv0fa4GMnn2OqLjm9EU3qCno57UE4PV9OAH7NWUOngZO2OD3gAAno4YCsl9HduSHSWO1b50pDToUrSWABjXdNkuzU6yaBTeKX1k8GLG9K1zRcHYtCot/rJ4WK0XKrgMIheHFgK8M26Ga0r9o0sqXU9evUaU1j7IzgRaXAWeDGZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVjVkooVbPRw3vwlMOqLorO9qpYDJaaMeOD0+bjpfzk=;
 b=fYtwVpMyqV+eHV/IUyhlhEuLm4OjUMyZ61FTdTsj7GkJ2QotYI5Qv5wSTv/8oPqV6hVBq1DC/O2+/5eUA4GPFN1/5KdrdgsqCvi3A+QrkTQX5WK4P4xuqSCWWNrb24QtF1o7YohER4HNndE/dHQWNdNFXvFI4Hi0Gyn7Qrn5Y2HCVIMGl2qqzJHSp4NcRqsU04+udDydte8+ZXGKtqlnVIcRLO7n1MDr/flm0sXw7qmDEluotmYA3HKKMQNhD3ww1tyg5jC3uu9jtsPlIoXsnqzeUHWxm4Miyii5k6L5w21Y+GVAc4QngkAA077v7R/VNPZacVr2ca5Qx07sj4+a5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVjVkooVbPRw3vwlMOqLorO9qpYDJaaMeOD0+bjpfzk=;
 b=E3UOeauOMRv8ujkD5PfN4yFadKE7KVorwj25jt0cm1K5xUz783Ek1LFbXxj/XvR5g57eO4x70OHc/mw/VH7XvqUReqSkeksTSQ5HDE/ks51P/fzjQt5J0zumeltURllNEnxiDlf0sc6WjgJK1E3b1SdPd2EAfF7VuQCFQ+uJNmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW3PR17MB4217.namprd17.prod.outlook.com (2603:10b6:303:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 02:01:12 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 02:01:12 +0000
Date: Wed, 31 Jan 2024 21:01:07 -0500
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
	hannes@cmpxchg.org, dan.j.williams@intel.com,
	Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Subject: Re: [PATCH v4 3/3] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE
 for weighted interleaving
Message-ID: <Zbr7YzjFrrIWXomI@memverge.com>
References: <20240130182046.74278-1-gregory.price@memverge.com>
 <20240130182046.74278-4-gregory.price@memverge.com>
 <877cjqgfzz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Zbn6FG3346jhrQga@memverge.com>
 <87y1c5g8qw.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZbqDgaOsAeXnqRP2@memverge.com>
 <871q9xeyo4.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q9xeyo4.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BYAPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::28) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW3PR17MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: e981c151-c0e2-4185-5402-08dc22c9aa86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4dHMDda+64xbKQBPWi63MHu+UgvlPmuxDdV7kVLz4URiaxkcoFJ3VG9licgntzuB/Dqn/Hd7DghM5KlZd/Dh9RPINMup+xCiog7AZQQQoPD6Q8TY3roSoQu6eoQeGTQEIpwIoWIH+Im+R/LxxG4TULrsTbIb3g368u26OVRK8GJTgye802LxvknTnx24J4A84Hli+bmZbvYK1P+5yOA6jYCOHhhB8WZ2ayThN8nBSBYotSlGgP9q12jO7KAeK8CGRA01ElbiIsaS323qkx/xTXbJr5fQIzxZTqTSLsENtxaHGDKHhJrbq6JoC0E7qWN5sHJdrL40O8GKL6HAQDjJxRQBFpOqQujWLPcDJe7QpkwNoz5/HHYCf70zpLX+GXbsl+aaQcvaWRpIKLrMj1Pnb7+iwbPJYRavYiTtHMQ0J60CqerRf6FFIDhaFrlqmP+0FT3xNKgnv5dMgMuX9jwaZjAZdU3KlnnTkytbWrPLz8EwtsTjbW3J+jo2xLR1f/cE1Ck3vp2lg+7TVYdtUZYjJyYR/+FTpScfXPTqb0VK/OvmWwOaeIJZA7ikbGaXL4FBP+mhbopuP/hcqqDPle4apwRXxmE7IBGYDAHEyGxkOjc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39850400004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6666004)(316002)(66946007)(86362001)(54906003)(66556008)(6916009)(66476007)(38100700002)(4326008)(44832011)(8936002)(7416002)(8676002)(478600001)(2616005)(6512007)(26005)(6506007)(6486002)(5660300002)(966005)(83380400001)(36756003)(2906002)(41300700001)(16393002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1usUWRG110xduUaJ6+CUUNdEDudc+icOMzI2tfTe/xSp2jaSfZeHmMEaPaCy?=
 =?us-ascii?Q?LnA12d+Zn/1LTqv2WmAHqeGrSaOXdjROxMhZ5/U0p0bYgKewUHDcIb9mxJVV?=
 =?us-ascii?Q?XWoH+u2MENy1NwMAhjn33R+7eMxlWrSvtG+w44SeFad3TRsLK9zpW2ylYPGq?=
 =?us-ascii?Q?f3C7mfP3SWji6g04CUlTurMNeyczSHEVNH6Rd/Z0thpLzuLXBH4BFJvLsljh?=
 =?us-ascii?Q?xvXucyfxpTYaTHmum27PCYHRoEpX9i9+i8htDi4fi4iKZN70wQawTsy4xMEn?=
 =?us-ascii?Q?cAWNv0vvfxX4DlBIENuGe1YtjiTxA30mKRp0yPpnPRbvoGQWyAled5+OvXYd?=
 =?us-ascii?Q?yhQOedo5ArxsolahPGA5LSGKB+QydtApaZLtCIPW+owAq+PQdUog8Q3GjfLM?=
 =?us-ascii?Q?78W7Lkdivstk+GBUh1TQJChwx3y41kVlHovVHS46bXwneEDcB9Qg/RuC5LjQ?=
 =?us-ascii?Q?fy9Fr7wHdYMH1QTSRsrNcWzQX98JNjyazJdcrZi/F61zMwbev8gHhawCo9ZG?=
 =?us-ascii?Q?YgQDLsHh2ieS1IDckUrFevAixv/F3BGut7iFDj5TKIF28aqupJiR98DCDCeM?=
 =?us-ascii?Q?cd4w4Z0cBVXyuowVy/FnMAuNp6WKuhDu9a9A4+gY7/ih+ZHmG4vPI/l2ydds?=
 =?us-ascii?Q?xC1LS1SvKKeWzg0TY4wNFw6w2Uho8J6X3Xxdm5l+5/YZ1O1rNHQBGGtkQX+E?=
 =?us-ascii?Q?xrldUF9D4d8JDPYwdLFbtJUSkBs+dwfieZlKwMHgzqCMYf/Pe/TzwoN6nNCB?=
 =?us-ascii?Q?TvdGpqsJCMuu0mvUAY8iS8aqQ9uBM4rgwF05lTKPT9xeCeLKTMDeNmk/soa6?=
 =?us-ascii?Q?YFim75jLmhk5pCi/WMyFaawzv5awyKbicjIgxhoiZmxGQTHDzzuSBiKOsS3u?=
 =?us-ascii?Q?M3R9C/ofRqAwCTH3HjZDAZQcMIGeKpbAn5Sqo5k+fLLHMRxdno6lmVUw0h+Y?=
 =?us-ascii?Q?SCl2fp9+MFOo9v1wFqURtUR/XgXXxnwaQ1ueKZWZnid7WQibX7OLrAqPn2Y3?=
 =?us-ascii?Q?SQAbTJzlWFO9vKbPY0xFBtEZpw0ZpOQht1KAs3MJXLBClZkrpmzNTc/2SaUX?=
 =?us-ascii?Q?88Vs+yS9rMUIisHOvLc7FjZpoRwbM2HWAbsstMlkj/ANwidumnobKKoi2FAD?=
 =?us-ascii?Q?su+EpWrb/itFun63Gfge09iB9lmd9+r9MOLxaLT1LdRN27Kkj7Rl35kjWHRm?=
 =?us-ascii?Q?2fYGiWZ59nBy8kk0L5w565nWbJPD9Q6OwJA4wcxd/8QjnqBqBUvp6q/eIswT?=
 =?us-ascii?Q?EoP2CRRE+9WL/eNH1P+FJPqXHFQAGONyhluM4s54VfU+G7iYPjJmaqFGinp2?=
 =?us-ascii?Q?tLBoczCSLn6HMr+b/jkLI5pQcFHYJRJLQwBS/EGsxE/BDZDoqc/9JJnEfNrW?=
 =?us-ascii?Q?AFC713MNtjek5zmey8/dUOLOonlsE9TJgVXMfDMthIvefNTmSmzRi3hpVL+1?=
 =?us-ascii?Q?F5IILDJ5yaaIqyujJEziCC97BW+/OlOK/L+ns1W3yxEKX7jXktOfkeoI2dx3?=
 =?us-ascii?Q?cIx7+ncFAHZncT+vXL7Mtk2lgLNi7+V3xPDCEIW81pdhbe6A8VFRpBK+a43D?=
 =?us-ascii?Q?VioHhed7Nc5k69WjSeHBdEa0srWJGVL6HXqbcTajAt7LUXJM/PiaIHGl6o4b?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e981c151-c0e2-4185-5402-08dc22c9aa86
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 02:01:12.5523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85Tl/0z3LQwgYidFQ/8172QgbvMADVkERUsl543WBFFHpgkgDPCqK2+0n1OJsBR5VKikkINBwQlJJSmSDoF3S7LPaJ60CwA+TTvsMcD6gYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR17MB4217

On Thu, Feb 01, 2024 at 09:55:07AM +0800, Huang, Ying wrote:
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index b1437396c357..dfd097009606 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -2391,7 +2391,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
> >         unsigned long nr_allocated = 0;
> >         unsigned long rounds;
> >         unsigned long node_pages, delta;
> > -       u8 __rcu *table, *weights, weight;
> > +       u8 __rcu *table, __rcu *weights, weight;
> 
> The __rcu usage can be checked with `sparse` directly.  For example,
> 
> make C=1 mm/mempolicy.o
> 
> More details can be found in
> 
> https://www.kernel.org/doc/html/latest/dev-tools/sparse.html
> 
> Per my understanding, we shouldn't use "__rcu" here.  Please search
> "__rcu" in the following document.
> 
> https://www.kernel.org/doc/html/latest/RCU/checklist.html
> 

Thanks for this, I will sort this out and respond here with changes
before v5.

> > @@ -2460,17 +2454,10 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
> >                         node_pages += weight;
> >                         delta -= weight;
> >                 } else if (delta) {
> > +                       /* when delta is deleted, resume from that node */
>                                            ~~~~~~~
>                                            depleted?

ack.

> > +retry:
> > +       /* to prevent miscount use tsk->mems_allowed_seq to detect rebind */
> > +       cpuset_mems_cookie = read_mems_allowed_begin();
> >         if (!current->il_weight || !node_isset(node, policy->nodes)) {
> >                 node = next_node_in(node, policy->nodes);
> 
> node will be changed in the loop.  So we need to change the logic here.
> 

Good catch, stupid mistake. ack.

> > @@ -2388,10 +2401,17 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
> >         int prev_node;
> >         int i;
> >
> > +
> 
> Change by accident?
>

ack.

~Gregory

