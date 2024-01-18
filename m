Return-Path: <linux-fsdevel+bounces-8227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 981BB831205
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 05:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FFB2839A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 04:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC2E7497;
	Thu, 18 Jan 2024 04:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="NBY0dNK1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602F8F69;
	Thu, 18 Jan 2024 04:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705550821; cv=fail; b=AVJe8XZnFNTikSNyEo7dL1//iVho6Sp8E4EKJbK+c238jaWCZEZK7crougapgQ0aEYRM7OF6Vw6Row6I9g8Q/eKEmKP7L8B/ilE2JjjiN5ilyYrNJd0bZx6HZz68Ut6/8uggXkNFbtxq7tHS3XAEkIfTxsmiebwoMMi5ZKsy1RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705550821; c=relaxed/simple;
	bh=L0FYRe0wpsNMm4Nfo5WxXRrl6r3UnMrMIwBxq2gxY0k=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=pIcjW20y+OQEe4y0dXb3G23AA9CDotSuqfgjkspqq3liDdLI24KA9JroJEQa2T500kua2rj0O0WyUQE7UzjMK7Dwg4NfEDddH4Pl+1Xf3j6ZiyQWf88QnmDFLSbSUSAn9AcLaxtB/ukX6W+pN08JF7Y6car4w73VzfrJt6MTe5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=NBY0dNK1; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EerixHZg0JlK+OPUkI4EepWqIy31cDFQqjTrfKgTvyae+TvgUpXG1u3HVY2OtBDBaeSijj8O6ec/pvPEBJLCnE3c1FocbB3Jt4XtcLhPYRuwwDMRkEivO+myUE8hgD1cXyDXYkFBObf388JysRfu3xgM25c6R5+nu1IL3EhvNuy9B7RdrpnTofGu5QtDxHIpn6g7QdW2/nEZNDO3Pzworyh1usgq5ZSmqkaDMgtkh0K/YNS2pLJkM8QQjIdtK7qWXt6Ech17l2T1iQUS6iTmABudiiO94ZJC+AVbTiCA0kEmGudRFMd9bgdLEv7WFQG8eBX4Z5/IuCFL5Ps1PrjcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDUufBOghQeLx0mQLKnGZexIse8grpNM/2D+EVuUCks=;
 b=UrbWEMJgDhrpP8RyuN/7o6ifsnnuxpJgOS5H5dGXAzaU2eZZ6bqcYerpX3uNJfa77QuCOVqY7VTdHwuvSXXLnUtjsWe8XUI6hRcmI71ly4oCOic0S8A5MVfQVh9YhqEKJpSClxQ/crwkCgECxv68nW6gkpZU1o1MZI5pVke9xW1CrQw27rDKAQD48nPDKmOZ0x/kxH3hJ/97F9IHAU5/dTdXtE8zydoqq9O91Ka4K84P4We14ROUFMZghubIiDCun2hnr/qpz7dy8BZ5Eh+f6V8EQ8kWU4HCxO8x/4DzNjTQtzm6ivEMfKFjC/mkz4Adh2lwzSdjwo1g6gt1lL98MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDUufBOghQeLx0mQLKnGZexIse8grpNM/2D+EVuUCks=;
 b=NBY0dNK1ALaO+jckOT6fJQ9IeGYMwbCZMY2X4OIFMpAoYIDPYDBNxwmC0Oot3tGFVygUud4RP2bzyPLEG1h2z7A6rlq8PNwCB8bqJvLxDoB3acuQZOrQSbnq2fFGzQkwZfaiYSZ8xUULPGI390S8YmzedYctlFM9KS27RLrvg8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CO3PR17MB5824.namprd17.prod.outlook.com (2603:10b6:303:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 04:06:56 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 04:06:56 +0000
Date: Wed, 17 Jan 2024 23:06:46 -0500
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
Subject: Re: [PATCH 3/3] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE for
 weighted interleaving
Message-ID: <Zaij1uA4GvWxdNNW@memverge.com>
References: <20240112210834.8035-1-gregory.price@memverge.com>
 <20240112210834.8035-4-gregory.price@memverge.com>
 <87fryvz6gf.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fryvz6gf.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BY5PR17CA0053.namprd17.prod.outlook.com
 (2603:10b6:a03:167::30) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CO3PR17MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ca821c-aac2-4d91-d207-08dc17dae8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ya9DnBCeB/wDky+1u07T3B+OTPAA3dYXi+MQRfYs/WjQuvQaKQNCvOa/5QGA6H6eBt7VIgGWvyYrw9YzlcYALX/Az8hCsTz/Tmvla37KRn4b751Ps9W6nGbEA9Vdhco33sQAIN/HU1+0YP7iPTv/xWpbbSNjZvPcS9nL3jAHoGUynYPjDktnLGXSxgwt5WmQYzpqi/1Hn4z6tHXZuG81ERunmpbRgkWNw1zqPT0FYmenTJYgdtFsiigXnEb9ib36Lugpb1BwUZnThDtvwhT7jIFzDdQVm8GEJXI4XEVSLLjXOoTxKJaHNroEvqtOptuVkPpiL/zAvPGfmseWszI4Weqw/SswjJHPOOyZY5Th2Mqz3TgFZt0R3kT3YFcLxI72uO3e+5nvXeD9+bgWgHVrwnVe1BORISsaBRpOamsptA/UHtS3zDgZVKx6lDvAUzdC0aNvD8aQ/TNIoA7WGtbXY7SRMYwownLHubD+eSwzmqiMh/D+NOYBhSlcJ3l9X1r6x2v0vbziRJRy4lh7Zl747HRU7ar2Q3tQI4M8yR1mwVA65x70HRD+ZPOYACBliZ6DR2e2SNN2bP8gFxVD3Mk6TZLzec84i7ufSarG2MkbRy4/Mvrr79q0tVBMTToOpflK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39840400004)(136003)(366004)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(4326008)(8676002)(8936002)(44832011)(7416002)(316002)(2616005)(6666004)(6506007)(41300700001)(2906002)(478600001)(26005)(36756003)(6486002)(86362001)(6512007)(6916009)(54906003)(66556008)(66476007)(66946007)(5660300002)(83380400001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LhQpRH3n25Hi3G8RgMXRiYxvR0NkuCHyItW0ZmNrFEyNo3cS+3XpJ6v3tw4i?=
 =?us-ascii?Q?gR7wOi/x+Xm2rceXnJIiIrCPQ40ntAqnofQXUmhcFFVTmxrjfy9RC4eoDs6E?=
 =?us-ascii?Q?PI9o9x7aW+iYV7Hu48hU0ETAQm7XkunyTZMFtziFDqz1Z+InD+9LSe9GoX7n?=
 =?us-ascii?Q?bRVhIWl2BDG3LpjY/LRFFmGe4/MOauFh/mYqhKoxc2Dr3P6ELJ1Y8vHcdz/c?=
 =?us-ascii?Q?KXHJ/0gABgp55SmQuAWt3LpV1wETUC1TlXJKi/L1TS9i6r3DwAYXwLUOZtJR?=
 =?us-ascii?Q?u0CC727AMUGOv2ZGkDsXs6c0VPFzzhdkGexAh0ww5qdKjE25HZ8uhFn/Q0LD?=
 =?us-ascii?Q?H3Bl6rujbZvsAmaXqFcZMWEIt02c6ssgmb0Ns8VbiM5iU3CoQ/ONR7MwAGq0?=
 =?us-ascii?Q?IbTeP6vJBjgCsSce+07D9w2jlIol321GRrKz8k5zVERN6rm+9hhSPmNEcJGb?=
 =?us-ascii?Q?IZO8EFbdmZcdK0BODxvo/xfz8QlFEtfKvVVuZAQ5BU4lT/iDJOSqxJgwLC0Y?=
 =?us-ascii?Q?6R2agVuxuIqEqE4O0LLJ1sdv7geX7bv8YNhEmiOFo2JqIGbDXg3R+B79+2NK?=
 =?us-ascii?Q?Upblzztv+dr+CQwH037MWcjyeWf5Zvu98kupKtZSaZAPkgkMEEfYUWq7aLvZ?=
 =?us-ascii?Q?SUATs4DdV+vowfEZ8RoT9ArTMQV+bOIqSk5seJzYF9zqN4cE7+Fr1hIGkvrX?=
 =?us-ascii?Q?u1NGamNOAdgqKQjkIMgiOeQkfxml6x8SIX7UTNTkOjZCi3p1JrritR4+dieN?=
 =?us-ascii?Q?2SyZl41eK2bkqO6kQOrnNpkUpJ7xIOrWzpCBAEeeGlpyB8msWUl6K1bzYXB5?=
 =?us-ascii?Q?5wiYyrs8NGuI3lsD2kTp55sma4tXU6Tk4mvSXb1PNCHybfg+1J+8AsAl9pz3?=
 =?us-ascii?Q?UhfEGv/+BpO4aZgxNnWOR6wl49fjWAJoPlLG1yTvFKmt0u6CqtSbq8raBZCT?=
 =?us-ascii?Q?lpv/B0EvKZDCtSF+omoHRTuidzO+/ZlvvBfoeEiFzyI912wk1ZQUK8wwvK3I?=
 =?us-ascii?Q?loTKBC04BxTIxkkOksnqO9Rzgwx+jCQh8o1CVn5sYepLbIyKYQ+EoyEy+Hsq?=
 =?us-ascii?Q?GCRR4UvMz0M+CVk8bMcLJLiFhuOzFZLxUGD4kx7S2YIs7QrqtZEvD28XfXqo?=
 =?us-ascii?Q?WiK5RIf+oqA9+ofxhyYn5AGH2hOSYJOuN3FWNbevcjw4CaiaaKcUQOhnf/J8?=
 =?us-ascii?Q?CRzGzjiFlZ2QbCIORtXWapE1YrJjEcFGme1AeIy0/x8nNdPumhgPppm4pt0E?=
 =?us-ascii?Q?MMB07xQAdATeIXDIfkfpGd7cJXOo33gUNopZ4OmdQ3IjLpKs5nOo1fAYqHUT?=
 =?us-ascii?Q?nNShqZv3n/MP8TbFqsCXZwOjYA24TwVvjiSqL70LJ9rs/jGV1yKNmdFy9M5m?=
 =?us-ascii?Q?/Nbr9caRS26J3fk+tcERo3g7Y6y5zuAZOF20toN7k5Rmludpqf166eWi2KX5?=
 =?us-ascii?Q?pPhmd+mZqyIPSNO9kVJFjgvKP8MBrRYFcnUZbjX5CbmNmzpvw1FVgyWKaOeI?=
 =?us-ascii?Q?8b1TfTpcImfnUlAIp7HoUJzFXO7GRlkt4rSyFvUTw98PJk9YMdub5gAgC+fw?=
 =?us-ascii?Q?3CRwyQK7coUaqp4RkDz9b3YLqk6HMjQIc/vHMcDqttEH8rUvAKVMLyyEz/HX?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ca821c-aac2-4d91-d207-08dc17dae8fe
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 04:06:56.0261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ie8mNkqaZXM6HtfBxqciChY2OLg88+VfxUgu9Q5e0isP1jkPFqDPxG8AUULHDwHfxcocB3SVhOVWcoJ0yyOdBTCSDmVBmsV/HnhPDNOXgj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR17MB5824

On Thu, Jan 18, 2024 at 11:05:52AM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> > +static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
> > +		struct mempolicy *pol, unsigned long nr_pages,
> > +		struct page **page_array)
> > +{
> > +	struct task_struct *me = current;
> > +	unsigned long total_allocated = 0;
> > +	unsigned long nr_allocated;
> > +	unsigned long rounds;
> > +	unsigned long node_pages, delta;
> > +	u8 weight;
> > +	struct iw_table __rcu *table;
> > +	u8 *weights;
> > +	unsigned int weight_total = 0;
> > +	unsigned long rem_pages = nr_pages;
> > +	nodemask_t nodes;
> > +	int nnodes, node, weight_nodes;
> > +	int prev_node = NUMA_NO_NODE;
> > +	int i;
> > +
> > +	nnodes = read_once_policy_nodemask(pol, &nodes);
> > +	if (!nnodes)
> > +		return 0;
> > +
> > +	/* Continue allocating from most recent node and adjust the nr_pages */
> > +	if (pol->wil.cur_weight) {
> > +		node = next_node_in(me->il_prev, nodes);
> > +		node_pages = pol->wil.cur_weight;
> > +		if (node_pages > rem_pages)
> > +			node_pages = rem_pages;
> > +		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
> > +						  NULL, page_array);
> > +		page_array += nr_allocated;
> > +		total_allocated += nr_allocated;
> > +		/* if that's all the pages, no need to interleave */
> > +		if (rem_pages <= pol->wil.cur_weight) {
> > +			pol->wil.cur_weight -= rem_pages;
> > +			return total_allocated;
> > +		}
> > +		/* Otherwise we adjust nr_pages down, and continue from there */
> > +		rem_pages -= pol->wil.cur_weight;
> > +		pol->wil.cur_weight = 0;
> > +		prev_node = node;
> > +	}
> > +
> > +	/* fetch the weights for this operation and calculate total weight */
> > +	weights = kmalloc(nnodes, GFP_KERNEL);
> > +	if (!weights)
> > +		return total_allocated;
> > +
> > +	rcu_read_lock();
> > +	table = rcu_dereference(iw_table);
> > +	weight_nodes = 0;
> > +	for_each_node_mask(node, nodes) {
> > +		weights[weight_nodes++] = table->weights[node];
> > +		weight_total += table->weights[node];
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	if (!weight_total) {
> > +		kfree(weights);
> > +		return total_allocated;
> > +	}
> > +
> > +	/* Now we can continue allocating as if from 0 instead of an offset */
> > +	rounds = rem_pages / weight_total;
> > +	delta = rem_pages % weight_total;
> > +	for (i = 0; i < nnodes; i++) {
> > +		node = next_node_in(prev_node, nodes);
> > +		weight = weights[i];
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
> > +		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
> > +						  NULL, page_array);
> > +		page_array += nr_allocated;
> > +		total_allocated += nr_allocated;
> > +		if (total_allocated == nr_pages)
> > +			break;
> > +		prev_node = node;
> > +	}
> > +
> > +	/*
> > +	 * Finally, we need to update me->il_prev and pol->wil.cur_weight
> > +	 * if there were overflow pages, but not equivalent to the node
> > +	 * weight, set the cur_weight to node_weight - delta and the
> > +	 * me->il_prev to the previous node. Otherwise if it was perfect
> > +	 * we can simply set il_prev to node and cur_weight to 0
> > +	 */
> > +	if (node_pages) {
> > +		me->il_prev = prev_node;
> > +		node_pages %= weight;
> > +		pol->wil.cur_weight = weight - node_pages;
> > +	} else {
> > +		me->il_prev = node;
> > +		pol->wil.cur_weight = 0;
> > +	}
> 
> 
> It appears that we should set me->il_prev and pol->wil.cur_weight when
> delta becomes 0?  That is, following allocation should start from there?
> 

So the observation is that when delta reaches 0, we know what the prior
node should be.  The only corner case being that delta is 0 when we
enter the loop (in which case current prev_node is the correct
prev_node).

Eyeballing it, this seems correct, but I'll do some additional
validation tomorrow. That should clean up the last block a bit.

Thanks!
~Gregory

