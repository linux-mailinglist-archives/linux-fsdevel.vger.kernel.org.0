Return-Path: <linux-fsdevel+bounces-8789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7394383B10E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF72B36C3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 18:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559D7129A97;
	Wed, 24 Jan 2024 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="gtUgpZij"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3247E568;
	Wed, 24 Jan 2024 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119316; cv=fail; b=TBwA7CDt65pL2/k4TpeMaHL6JkzI/6ZTOv/eNXK9EgjjZAJyifPuuRuZO/LzJPqf5ueA5HqUQFMcQWaFraanRiZXTJgy5+SbVSZTp7erWDj+cTps1YGSMGqc5DxmB2nG+pwGxK12C3QFNOKz3cKd82b+nD02nQKMvjuq42bljlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119316; c=relaxed/simple;
	bh=RgLHY1ZHWF1Eese526LFtmvLkQEA5RHBGJ85INHOv78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a6Ifk9OxYAqcBKB3FQko6aBN+yvZhdJLmuvvOg8tQdr2t6Bfas3U5K9sNmeaNmdYeKEsFmYyJsCi8SOLsnSVFolywAXKFhdycKjRvoM1jjTdU0fU7cs06mRNtKvgfKZN2m0NxbhgI88+V/nN3YoVwlINMRKL0BjMpGl57Msqp6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=gtUgpZij; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp5nqHmFdcyzNxvE2Xh2q+a1JbD8x8mORPpwYm9hTE6g0Usw5wAFFdKDlHcL+1HMbFM7w1HCKiUUW9RITTwJKZHmcuIc3P9CiD9R8f1GwvJ/2vvM7d/JpBYFz5cK+A7J+3tE6Zo+JvWpm0yiAh+HvTQX5bF11kydCm/6mNHViM7kB09WKmaFY5/Ax//KT4v38qGNC1UZc2Auc6WpwRM1eHRKUUY23Qt3huxtc6ylqQ3dguFM6UzNU4zerPLs1LRdMAvMRx1esi2WeGP/UhEKcG6VoVZrYe08l0+ZFKhSMYMDLeVc+HECp0UHBOU1mxVIUCRc/yYjwaw1HAA2XmQ0ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvLwW8c9dkhEDqP73nc9wJ9FJvDxWXHI73wkPHjbwbE=;
 b=YXbVshTTCmCk8Unj4Z8ArDKLv5sfPPAkOa+WJMkwzldWyBygRsezwC5yTcIlgMvxvLz/dZ0DrneMLiGmDFeSOgdypjnm/54JbiepF5QcOn/7RNhugzQfkByVNH22XhSYbTFy2vn1lrMzzzi6C2oA1eIgov5cJwnsZF4KjuOG62QkYIZPahV6/re8kr0Npk9N14ALfWQWl2HpgUynwQSiMDrgJxrv9BltWV3BbAplK+2lhv+YM/HPs76t7bLKkTEy5243b4QTbIwj6K6r+AnqyVQQQvAe4AsXMwifM5qF5cBeCQIhzZe7x8ZxL5yjyrvO8CmOi+f0GLz1Tq1oQXmlAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvLwW8c9dkhEDqP73nc9wJ9FJvDxWXHI73wkPHjbwbE=;
 b=gtUgpZijkZf2zQsZm8PSnLQ5aIImD4VIqo4xHAh4TwR3RSGvyV22TluFqftdGkfYjViK2pE9VYFXGpwVRRp1LPqqsT73qM18wGyK35vXltPlEroGtosZj2qOW2SwG6LAhfHdsAXPX/COMxPunxNlFr/TE+9JPUv5Rx8W4An/u+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CY5PR17MB6119.namprd17.prod.outlook.com (2603:10b6:930:34::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 18:01:46 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7228.023; Wed, 24 Jan 2024
 18:01:46 +0000
Date: Wed, 24 Jan 2024 13:01:37 -0500
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
Subject: Re: [PATCH v2 3/3] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE
 for weighted interleaving
Message-ID: <ZbFQgSFfqDF+UvSX@memverge.com>
References: <20240119175730.15484-1-gregory.price@memverge.com>
 <20240119175730.15484-4-gregory.price@memverge.com>
 <87jzo0vjkk.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Za9GiqsZtcfKXc5m@memverge.com>
 <Za9LnN59SBWwdFdW@memverge.com>
 <87a5owv454.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZbAvR+U+tyLvsh8R@memverge.com>
 <87jznzts6f.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jznzts6f.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CY5PR17MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3e36c8-6430-4203-b108-08dc1d068755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sTFxdOJtyWUr256owJj57cdkliOU0rLdr3kPojwEFFTYirfd3sePlNrbZJeqhk6ddY6junMQ9OMi5rCYnV+PpGWi/d+ApdjLQ3jFnJySU40+idxQuOp62W0QZjtlpfWNJQqlsNAhUq/tc9GUClmHKI7tV17dmhzTbRAdm++2lFnYqX3Y3UxPvx6PmpoS/958rQLOsSiYsRikDbSiK2FnDDvYRwpTk0vwsGXbtq9NxMqXPtjAV43xEgzwz/CY2BioOrgtSNVMFX4qZWu4Rk5KhDsZ3wXPagyZSuq0x+MsBLp5/D3lHrZRUet80oXA2h6im5XEkTtm9wsrRfbsSqRddp/uzdljbzTwkZ/VVnk13eQRqL5jFKaC5eiAn+a0v3rezbDgFkaEqYoHoXnC3habo9Ug7HpWrq2qs3qqo6u1AwqAjRcDqUot7JMJd6Rl7z56XuiIRzZj8aelQkYUKIHwnL2uXgzSLCspE7SJWfZeZ+nUxhFSrU4Ub8EhCwvN1gcoTcuMSUbTTMPPbHXAeFF11bTfzMoLn5lKENZdyjqiTN0wMgVgZyf4gsBsPbpj46dJuhMkBsxEIviyyktw+L7pno9gvtqQn5uF3IszplVVJc+nfZ4901a2U13xOh5CcV1nxSRPQRjDGioww27vcXh4yQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39850400004)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66946007)(6486002)(478600001)(38100700002)(26005)(83380400001)(6512007)(7416002)(6506007)(6666004)(6916009)(316002)(54906003)(5660300002)(44832011)(2906002)(8936002)(4326008)(8676002)(36756003)(86362001)(66556008)(66476007)(2616005)(41300700001)(16393002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xXe61j14uOW/NTzODJ7KockrPDERel3UGo5QQWJUSNdyRVyqKIGheofBCHXs?=
 =?us-ascii?Q?TeASf7JqGcuTo9lg4kljB/xPpknyQTwk+bhhp09ghZ/1++1Ke1HUNFGFdcsw?=
 =?us-ascii?Q?fZz5VtdTQ7vvlp3IX5/hzY2IDwMH0koIidQQNFcwlvKcY1YzECJ7dbHVkG83?=
 =?us-ascii?Q?WvG2umVbSqqE37v2pcB7oux6uYFIVq5aQt0Blcg9O+ss+9Y+qcVLiakl4vCQ?=
 =?us-ascii?Q?RFrgT5jVakHtC2cRxKz45jRJ0/ncWNRu51Lyn2pSh/SFBz5nit0Otq0hwQ+6?=
 =?us-ascii?Q?HzgKSAPbiI76ajMi4jisTfsM6qKPVUF1JkCWQg9Q5TUH1qN0vrxhQbxMgmTb?=
 =?us-ascii?Q?6LbB8jhNE+smx2sTt8VL651Qvlsz5jDWf/dQ5yFF+HnkN9QC1HCpYF5OPaFG?=
 =?us-ascii?Q?Np99SaaFt0+23ENQ94Og54a52tTz0SCUiwQ//dOsePf8BUbKmqNpk82GzGqM?=
 =?us-ascii?Q?YzSbdVvkOQGj1hVpAuAziIKGlCb7+RirJRoywCebzB1TFOk+2v+0RTh3DCJV?=
 =?us-ascii?Q?FfCQK3Gawd3Q5pdp6nxLaNMX6OXaS6STqlhE58baBUtij85F8lW1WWSn1hs5?=
 =?us-ascii?Q?h7o9Jx01HELG05YP5upAHHLayre0pyj0SdsD0PPBTsn+IS+7Q6xJzaz5RKoE?=
 =?us-ascii?Q?xoL2T6U6SJHZjBNHhnwEB3l3q/IzEQE/oIvyNrTvSXNwjXyQijbR/obVuJwZ?=
 =?us-ascii?Q?vYAXAOSYcVApPx9MfRRgpH8DUeYGNHL0XjToE2TdWDBJ31toHETjut/1jgc6?=
 =?us-ascii?Q?VWdanCsJe9aCFRwV7WkMyCrXM4E8BBDvNufY6Q/64mhPW10RRHUmZPIZneI4?=
 =?us-ascii?Q?cUTa15MHb0KwWojNn2R9QO2JX0wSTawBHpIViTHfUaTzy50ZmaMAUUkJno1j?=
 =?us-ascii?Q?+NGNTkH5KAXgklCA6Yr8Y1JoBs61/WqGF6BRTwBWVOnqL/4HrJPumQxLwbbH?=
 =?us-ascii?Q?a8J71IEAWuhrMCJ6cyaiTZ3u72FfdBNmQn3hSSey6Smb2BlYLwn0R1tT+Y9t?=
 =?us-ascii?Q?fCrEw0tfLG2+DPJRJRfyOg388oN97tYK7giCs8DMO6CP+GkjW60yZ16AAs/e?=
 =?us-ascii?Q?8c0eaC0YP0TcxlHKj4FhsaNQjcTVFnrUxLt000gBlAsmu2I6R6+AZ3iX+XQU?=
 =?us-ascii?Q?iT+c6HoxQPF7hKuqUeWpi4MPXKWYY+L8dRECp0fLUlyP+EvZUopQ09i0rb1N?=
 =?us-ascii?Q?20vgYuVHKYgHRBFScinj+uML+VjGVqOb3iDnKvY6bbxrUR4oihI6VAIY2Gxy?=
 =?us-ascii?Q?NDO3IW+hdNDPxf278pmP7zjHEFY0GJM4b4no5RgNkXJtJ4IhdEJ97n3MrRI0?=
 =?us-ascii?Q?nN4vbQxQ4UEvj0hV2V+cWOQN/pCno4VDPzcPO4sFvXCPPNmn1GZ1BVytXld0?=
 =?us-ascii?Q?Yj3yI6r8Jm5RrmJPuhGTHRmljTk7qH+oAm+xBAgg8sy1G8zjH3HDsj7mCl4G?=
 =?us-ascii?Q?z4Yo6rvvyKd0CqC41F3KM+1H3TF+XxKxPS7xbqzhUS6NE4j3nH6x8E2r55Ey?=
 =?us-ascii?Q?T3eNFI0u/5occ6tBCzeWfedIWcBlruib54yNCd31ReDOgRUN/Qlw27plfKVH?=
 =?us-ascii?Q?510smHmlmuHU9AXsAl3m+kJY3Y2nfax7bupTSsuJTZ0dE8nriUwUQREEizGo?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3e36c8-6430-4203-b108-08dc1d068755
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 18:01:45.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjIGpS17U/R3JFY+Q/NV7f0Y2kx0Se0gcbdOObpPXwUs9v93BljS49t952oxohs6rQpp4UWtYBSFO/OR3RNEoE+5fon1IWpGDkpC02F1IlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR17MB6119

On Wed, Jan 24, 2024 at 09:51:20AM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> +	if (new && (new->mode == MPOL_INTERLEAVE ||
> +		    new->mode == MPOL_WEIGHTED_INTERLEAVE))
>  		current->il_prev = MAX_NUMNODES-1;
>  	task_unlock(current);
>  	mpol_put(old);
> 
> I don't think we need to change this.
>

Ah you're right it's set to MAX_NUMNODES-1 here, but NUMA_NO_NODE can be
passed in as an argument to alloc_pages_bulk_array_mempolicy, like here:

vm_area_alloc_pages()
	if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
		nr = alloc_pages_bulk_array_mempolicy(bulk_gfp,
			nr_pages_request,
			pages + nr_allocated);

> > (cur_weight = 0) can happen in two scenarios:
> >   - initial setting of mempolicy (NUMA_NO_NODE w/ cur_weight=0)
> >   - weighted_interleave_nodes decrements it down to 0
> >
> > Now that i'm looking at it - the second condition should not exist, and
> > we can eliminate it. The logic in weighted_interleave_nodes is actually
> > annoyingly unclear at the moment, so I'm going to re-factor it a bit to
> > be more explicit.
> 
> I am OK with either way.  Just a reminder, the first condition may be
> true in alloc_pages_bulk_array_weighted_interleave() and perhaps some
> other places.
> 

Yeah, the bulk allocator handles it correctly, it's just a matter of
clarity for weighted_interleave_nodes.



What isn't necessarily handled correctly is the rebind code. Rebind due
to a cgroup/mems_allowed change can cause a stale weight to be carried.

Basically cur_weight is not cleared, but the node it applied to may no
longer be the next node when next_node_in() is called.

The race condition is 1) exceedingly rare, and 2) not necessarily harmful,
just inaccurate. The worst case scenario is that a node receives up to 255
additional allocations once after a rebind (but more likely 10-20).

I was considering forcing the interleave forward like this:

@@ -356,6 +361,10 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
                tmp = *nodes;

        pol->nodes = tmp;
+
+       /* Weighted interleave policies are forced forward to the next node */
+       if (pol->mode & MPOL_WEIGHTED_INTERLEAVE)
+               pol->wil.cur_weight = 0;
 }


But this creates 2 race conditions when we read cur_weight and nodemask
in the allocator path.

Example 1:
1) bulk allocator READ_ONCE(mask), READ_ONCE(cur_weight)
2) rebind changes nodemask and { cur_weight = 0; }
3) bulk allocator sets pol->wil.cur_weight

In this scenario, resume_weight is stale coming out of bulk allocations
if the resume_node has been removed from the node mask.

Example 2:
1) rebind changes nodemask
2) bulk allocator READ_ONCE(mask), READ_ONCE(cur_weight)
3) rebind sets { cur_weight = 0; }

In this scenario, cur_weight is stale going into bulk allocations.

Neither of these can force a violation of mems_allowed, just a
mis-application of a weight.


I'll need to think on this a bit.  We can either leave this as-is,
meaning the first allocation after a rebind may apply the wrong weight
to a node, or we can try to track the current-interleave-node and
validate next_node_in(mask) == current-interleave-node before leaving
the allocator path (this may also be just as racey).


turns out concurrent counting is still hard :]

~Gregory

