Return-Path: <linux-fsdevel+bounces-8506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DFF838674
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 05:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067B528B024
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 04:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E472107;
	Tue, 23 Jan 2024 04:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="XYl6jWnE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FAC1FA5;
	Tue, 23 Jan 2024 04:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705985694; cv=fail; b=tjXsHEsIKelHLcP2TCyfRdUBXpRzojfeAEKFuu7fRKZ8S8QMKJBBeKBdi6L8t/1S1fQQ1xcSA37Dv4mLIjBpm/cSGhhqsRk1XdSIhoXOPoyEZipJgB2CKF+o/VSj7JHasrwqtjxzkKt9q/D5sWy21X98Y0ORxcIr/FiPQMbsFc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705985694; c=relaxed/simple;
	bh=25yTJGlGnYMDJkDWqG6a917ho/+r98nmOKdmFrmLbQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ckgZ8HPBtUAwkOOdruvK3285o4Rzm+VP3PbCdFOB6GAy2FsTQVv9RJ0JKDFJUA8wTuUMp/dChpFABrNxBqm/BOmDxuBZk9NibCMOCtLtSfFMDUMojLv2m6lf0yV3M7bpEP62xiN415YYEbDinGsXYmg+x8+O4wuUrUhffQ5CVco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=XYl6jWnE; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=el9oW4WNi+8xqpkQ1ofT3qxRgmvtf/lhl+ziU3476ihNys53mepRlo9W0LaK0s/vJwqDhBkd7opbODdOqsS2jDRPjYaTqwFgOanSJHljXdqb07Zan6bG8WxCh6cYZeiBZeXn7zOj71YNfEWXsa5JlM0TLI9hD5CYe8PbYZZzLiPpqvDne8Kb2idP2iCVtoHOric2eVD1wwfOOBwKVsekQOOd+f1zy+DQPHk6rjjRRyWSTb+ro/umkS6yqD2eC1tijH/Wd2MZvNZeG+kGDG68OX2j4cGl+gX8XObBZuVC7OXlLwMKQpeGIvPErr7BfO3Z9gN+rsK3uFU6PVEeBlD0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ldk1salz11lWaYWF1zve1uY7D5V6EoXHndU/VObP8k=;
 b=HqZyQmI0SxDmMJ5e1B+wHh6esW1DNaq+GUbRJeHBEa7c2VgYuoPlm1slUP0Fe1h3VJa3Q1T6cABMiYwcivMHUIV9OaRNfya0vWngzKCKEK3R138HiWy1eiBUEp0CKWNX5MhD0lQIN0wamO8E+YF1AemmpkBV++3ReD4mB1U6mmVAUB1MqiSmakzNjPvhjrbCLANFbB/YEiAtoFW6XdpsxYRFDf1cK9/PW0ZZ5zD6hgv0L9zOog+KmR1ywRR8pNG/UrPA4W85sopgi2Lz/uWG2L9kz9tq1SYIB0er1CW1C7dz5mtoP6bTnOkko23X/tvDp0au2cU5WkvumVa0ARGg2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ldk1salz11lWaYWF1zve1uY7D5V6EoXHndU/VObP8k=;
 b=XYl6jWnElqEtPL/gZJ6/uRoOhE6J3XXlg9J1H3In9KXo+yR/m/8NCJsDDjd7jD0JbbBsjIzkm2H/HTs8KhRJp7KBX9+qke9HxKS2fzJ26JKR3mhf49YHfio/cLKyJDslzjTnKL7OTT9+dxN8/lYUGRFak5jB96hpfKriVtg9OpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM6PR17MB3754.namprd17.prod.outlook.com (2603:10b6:5:256::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 04:54:43 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 04:54:42 +0000
Date: Mon, 22 Jan 2024 23:54:34 -0500
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
Message-ID: <Za9GiqsZtcfKXc5m@memverge.com>
References: <20240119175730.15484-1-gregory.price@memverge.com>
 <20240119175730.15484-4-gregory.price@memverge.com>
 <87jzo0vjkk.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzo0vjkk.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM6PR17MB3754:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f289b9-e36a-4dcf-7d3c-08dc1bcf699b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zWfRpQ+xJMjGfHgilcBlndXJSk99TLRCGYNE1Fc1m9SG74lgiZn2+h28rQRXIgID4/bE1lB90bPig4EalECbBZYCnTz2Op3p44JtmgHrqo/d8gmkeW5upVY36D9d/2FBT50mmFokN2EUS2lIZ1JjjaZX6WxWRT02ddv9BN4FGtb15pb9ontrEE6jn+J0ozWDUMDtv7hO79ueU1exLelqVYsenqHcbTO1vQmdarzL51K/4w/XsLVRUefjgfFEyj3G4iCkmRU/2ReFDZ7M4j94Xk7RMs2urrhsV7AuAiBy0l2NDqtfC6CyFlSg4s0dP24ECM4SNQx2MaZMlK9libw3srgVuydIb2bC3NN/CI1oa4VdY7ljYdj/s8pPfk1JttQMG4/QGei0HD17Q8nuzEKEzMTOEq5wXyBK8Yp1mr0gGOCqL4udznQcwk8zlHy1odHBjjd5u9XFO5LuPWidtA5nRQcm7DKZlcVqOw50dD8OBOTHsa3MfHFloXmeKeVoOj5vdxOokPwWLj98BFHjwWAkvOgrDjzr43+n7QTDY+uf8d43y73f+FOWpaxJqbfELYi7s5CnOcd9EuvdM57A9Z0NeJnaEZfmSepVTdzgN835GQw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39840400004)(396003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(44832011)(4326008)(83380400001)(8936002)(8676002)(7416002)(38100700002)(86362001)(41300700001)(36756003)(2906002)(5660300002)(66946007)(66476007)(66556008)(316002)(54906003)(2616005)(6916009)(6506007)(6512007)(6666004)(6486002)(478600001)(26005)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZfdcxP9nRkZWTxP5kPsdmBgFD6dKlxX/J+j8DkVP4wnRRXAoQ68QEdpBBVWv?=
 =?us-ascii?Q?sTvid21yPzGT1GX+wokci0h4TaZUrz69kE9p6/ijZ4HmU7kdQzF+mZBZt4c5?=
 =?us-ascii?Q?eWo2F3G37xWb245o6uo0NYcQy19kh9nzXyoNLI1OWFzPw18L2veOgwciUREt?=
 =?us-ascii?Q?YxBxsMtYD0cd60bRGZsyVhbZLe5lkWxeqRx6hjawdntlhDGzlvgMoBqXEDux?=
 =?us-ascii?Q?zcBet7rSbFUNXwhxtsPRsqxbd4OANvXSa/2HhnMT2kd3PESH60ONDSfWVy3b?=
 =?us-ascii?Q?RPp618LbbtrD9nSugMQI82/VB+P6d4fBAsm4f3UNEAUNqGEQhXCj1NilXKCs?=
 =?us-ascii?Q?p8xX7iqczs9gFfUvFD8Z3h3JGZ0AmEkwgYLs1Xlvw0JlNqAxDhahWOq/pdlz?=
 =?us-ascii?Q?fDQ//ag5KZL41g2+nMfhIduOJ/PXKp6zV+wIX++1WD2jMJLgDd8V50RHP5ZP?=
 =?us-ascii?Q?NKs1pPFvaKcJsdA+9khWRQrmO+R6k0GkKd+CbuFRAfKGC86n4TnMtDOJkqt4?=
 =?us-ascii?Q?ypx+XLPvOZxJnq9e27Wq5lVdC6tmTspIZJNzJWTD8/eFJ+E0pTcCZpGDqLc8?=
 =?us-ascii?Q?ocWIxTYWCdKzFfF40GfS9L8Rf6GJJMn4+vwzCT3RjSsSGpvEITSfVoW6DB06?=
 =?us-ascii?Q?veSXLq5zU3NrXcgxYmsGYn9KkFVHZCfm7l7VuOxvauVkPp8Tp8TghWf9mG5D?=
 =?us-ascii?Q?6SreRB7scjXUc4D7nONmagnFdWdk+I4RZL+8sfqI4su6dsDxNSkNMoe20+C3?=
 =?us-ascii?Q?d4MU0r8XDPnEQ+L2alLAFfOiqZWnjz1PWmltJYArbGMzc4yuj6xWmvUAzWEN?=
 =?us-ascii?Q?FHd06jiivUPQnFIuZSY73cRlRTCw+0/ZqqdS69y7d1InAQH52DQW0H1TuSgI?=
 =?us-ascii?Q?u22+lLY62xpVZ6MfkGQq37xnvCUX1kCHDFmF49zUzJkOvgckpL5rU1NkY9t/?=
 =?us-ascii?Q?w8eVu5+m9hfCnU1i4VvmyFC4jr6uH1lkkb5xcDVRTWvYDMzVXkOsImjXFAe+?=
 =?us-ascii?Q?X62g8scpTBlnZmt7fhW1/cwO5UhIIkeKXjLs0cno4dHRTJizw8ESK51EuajD?=
 =?us-ascii?Q?Vs5IjC9GNEsKoqmmPUcKszBVrH6m1itnE2JXVsZhegIh99jl9laXOESuaop1?=
 =?us-ascii?Q?wrAZHSznWl38/I5lwZR6lfr60PAIttdCkptQaoVmsnncK24Mdi+iQ67ElFpG?=
 =?us-ascii?Q?p1C4kKVwr9DtugY/WVPGY5Ey7vikql3tMsNDKn3aOMeWiMvSSox6TOGS9kz+?=
 =?us-ascii?Q?wwfRYnX9y22zz1YXIaPxyjs7DtsM2cs724yZkyjHGzOZEpoLNJZmelNM+sKu?=
 =?us-ascii?Q?rvzVaCzI1VxFS8XcTF9UdbZLMOsGWAnsvJlTb5ll2P/pJ9B2AtGrCBbKCt8o?=
 =?us-ascii?Q?jHSv2m04q9N6DrTbV5ix/1PKRQDIGfTce2XIiMF4SnRqapizldxTdI+VzzVG?=
 =?us-ascii?Q?nh/9lfKCJ8Aa4x/A2Vq41Q+pOCF/zeeuS+yW0FAYkARRxHRjHwT/P+b7QrxU?=
 =?us-ascii?Q?4n4oZHV3aC+zUZeuu0T2TTnwESKaktmy9ey+J4RZcU5pFsK/iQKbepmqEpAy?=
 =?us-ascii?Q?6ikUrQ026hundDLLE9votC/Bazy2HID+K5KkOTJXZjuAB6U25Kecrv6uS3/7?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f289b9-e36a-4dcf-7d3c-08dc1bcf699b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 04:54:42.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wW0ygHTOKYb6uX0Hh6fTSS2wjyJVpGBWh3pDekvHVjEz3IjJ9FrpTdvt7lX27s92SYc5qoM/6M4SJMHsyjVi/mpYh8HV9WdqDs8/VKQ1oTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB3754

On Tue, Jan 23, 2024 at 11:02:03AM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > +	int prev_node = NUMA_NO_NODE;
> 
> It appears that we should initialize prev_node with me->il_prev?
> Details are as below.
> 

yeah good catch, was a rebase error from my tested code, where this is
the case.  patching now.

> > +		if (rem_pages <= pol->wil.cur_weight) {
> > +			pol->wil.cur_weight -= rem_pages;
> 
> If "pol->wil.cur_weight == 0" here, we need to change me->il_prev?
> 
you are right, and also need to fetch the next cur_weight.  Seems I
missed this specific case in my tests.  (had this tested with a single
node but not 2, so it looked right).

Added to my test suite.

> We can replace "weight_nodes" with "i" and use a "for" loop?
> 
> > +	while (weight_nodes < nnodes) {
> > +		node = next_node_in(prev_node, nodes);
> 
> IIUC, "node" will not change in the loop, so all "weight" below will be
> the same value.  To keep it simple, I think we can just copy weights
> from the global iw_table and consider the default value?
> 

another rebase error here from my tested code, this should have been
node = prev_node;
while (...)
    node = next_node_in(node, nodes);

I can change it to a for loop as suggested, but for more info on why I
did it this way, see the chunk below

> > +		} else if (!delta_depleted) {
> > +			/* if there was no delta, track last allocated node */
> > +			resume_node = node;
> > +			resume_weight = i < (nnodes - 1) ? weights[i+1] :
> > +							   weights[0];
                        ^ this line acquires the weight of the *NEXT* node
			  another chunk prior to this does the same
			  thing.  I suppose i can use next_node_in()
			  instead and just copy the entire weigh array
			  though, if that is preferable.
> > +		}
> 
> Can the above code be simplified as something like below?
> 
>         resume_node = prev_node;
>         resume_weight = 0;
>         for (...) {
>                 ...
>                 if (delta > weight) {
> 			node_pages += weight;
> 			delta -= weight;
> 		} else if (delta) {
> 			node_pages += delta;
>         		/* if delta depleted, resume from this node */
>                         if (delta < weight) {
>                                 resume_node = prev_node;
>                                 resume_weight = weight - delta;
>                         } else {
>                                 resume_node = node;
>                         }
> 			delta = 0;
>                 }
>                 ...
>         }
> 

I'll take another look at it, but this logic is annoying because of the
corner case:  me->il_prev can be NUMA_NO_NODE or an actual numa node.

If it's NUMA_NO_NODE, then the logic you have above will say "the next
node has no remaining weights assigned" and skip it on the next call to
weighted_interleave_nid or weighted_interleave_nodes.

This is incorrect - we want the weight of the first node to be
resume_weight, which is what this chunk does:

if (delta >= weight) {
    /* if delta == weight, get next node weight */
    resume_weight = i < (nnodes - 1) ? weights[i+1] : weights[0];
else if (delta) { /* delta < weight */
    /* there's a remaining weight, use the that for resume weight */
    resume_weight = weight - (node_pages % weight);
} else if (!delta_depleted) {
    /* there was never a delta, track the last node and get the weight
     * of the node AFTER that node, that's the resume weight */
    resume_weight = i < (nnodes - 1) ? weights[i+1] : weights[0];
}

If il_prev is an actual node, and delta == 0, we want to return with
(il_prev = prev_node) but with the weight set to the weight of the
first node we're about to allocate from.

This is the reason for the annoying logic here: We have to come out of
this loop with the actual node and the actual weight.

I'll try to clean it up further and get my test suite to pass.

~Gregory

