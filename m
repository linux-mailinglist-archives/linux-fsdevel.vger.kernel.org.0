Return-Path: <linux-fsdevel+bounces-9790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47090844F14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 03:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97BA28DC22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 02:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2D71A27C;
	Thu,  1 Feb 2024 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="BvNbdoF/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2125.outbound.protection.outlook.com [40.107.92.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6819F504;
	Thu,  1 Feb 2024 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706753945; cv=fail; b=XewkQ1XkWji+HdxwxJkyFSayNh+Gno8Q9J0dkNIgYEh826sfBBDKvkXfT/kE3VR4HsDmDWoDBlxCkSErHnvdXzPQOamxPcpo3LoMtQkvxC4QRfGb+tqhtmA9xDNqKmIuTSt8Cstou2/A8TtmldXMb8PpBVD9jQvJqXFv/WsD6jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706753945; c=relaxed/simple;
	bh=MgvLlGJ2Plgp5RIssM1vL84dDdn5qjK3/h6FmbXo9Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UuXm+sBgCqyHs8CULg6tkU00CdRv3ooEip/ROFze3yU3Fhs+Cax37gCsSwXlwU0OIaEMEBiiPCwWwpRK4NaSTz9jTUG08/Bg2XlFFZK7FWmfB8wIoane0LV1OhS8Omp5CvDBSA/sahPOBKlaQs/q5kebKXUNespNTGZhpxQZUSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=BvNbdoF/; arc=fail smtp.client-ip=40.107.92.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcU2t1Ihxn77fOmQzwFeaB6596KNvMTJqBrZo98F5xBp99VCi+8xNegFziEc/EVbFuvYDLDqQ5BwEYuh/fC1rWSGf40sfohzKIshLEfceELCU6ZqbPS84Z9NnuT+1yA8SPjVokTVteN8MLzhBSU6dVfDU7umc6pTvEQ9h8qrnwRhMeQq+rPZ9l+NmWeOfBD+htS8hyY8jGkgn4VO3p+FnYGvsHMgDsVuJ4T2KivVdSyYkvKhss+YSGntFtdeg2zyCiYCoRUTF9g7GhqsPFWwEsNAvHGFHKeTshh0T7d+pf4otZ0yWMHVhRVdmc0S/Bfvy2e1o7oRXoF7IIfZGc8I6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJNQdC4DY/Jo6ggOm5vDn+vMqxcJugLZxLSnTEFZmVA=;
 b=X3FAQUvnvaPIgcahlIVkX7EiZ3ZApiHZf8jvFd04oHV0GbOnIfLsBhAY6YcVIngedVHvUuR1qbfd/gl6qZYPnyjQFCaOMqHieuevx/rAVliAfKx/rs8jUCxnV1sCdDDb0sFJ14P5cdzdmxlAcAX5Boj3SdPe/Ilx0/P5bBW42qAc429NTMgTOsrG1t/fQLcy0vgauMIVsuRsYmMKiNL8a/Z0gIDFs0KhMqInPzUvp2eiXAfTCaB97WQ11gHhAw1g/YILABZ1ivaMXNt4S3WWB/IBjtu7ds9KFbolfX2igqVS+HUc+zMMSrsZYYUrs4I3F7/mnZ4YDnbWjq252txV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJNQdC4DY/Jo6ggOm5vDn+vMqxcJugLZxLSnTEFZmVA=;
 b=BvNbdoF/4BkNPctZi2obVkoFe+0jiy2L3Nz0GdZ0p3y8p3HCCkKfHYF6DSBMkchTKGDiJ3R4n20rbsyhCLKtikuZOc92O9UAs0CRguLEMIlYfrOYQzrewn7fAoXFoBQI6KZpuBLIOeCcPkYRi2JX1cwuE4KroAtUUSfMg9Zdy1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH7PR17MB5973.namprd17.prod.outlook.com (2603:10b6:510:159::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.37; Thu, 1 Feb
 2024 02:18:59 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 02:18:59 +0000
Date: Wed, 31 Jan 2024 21:18:50 -0500
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
Message-ID: <Zbr/iv3IfVqhOglE@memverge.com>
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
X-ClientProxiedBy: BYAPR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::20) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH7PR17MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b65ebd-665b-4b7e-4073-08dc22cc25e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RzEiKVPo94wQt2qF2SL7hMcfQyKVrbleSkYqRz6vICru3Xuo+OPWbMNmorropp6GOHF3sNXOLtfweqPBQC0F65nCDjkTW1VEcdOjVlViYsoa/PPoD3NM2fYhK299tlwUY58vmROl7CDfJzO5MCuG2TXPz450uIFze+hXkgfmpuSXdpH8MQWzwrdgv+9I5UchxM2NlY5VwrUAkKOc3GicMB6HtW06EZI+jBL0sWIdJF58Bqe631WTJyp+u6ckyLKRRYmXGh0Op0G+hiDy7vQ1WPV6gTEFg7KopQCiVqa5MWEMZDf2GdqUnWoc9E+5WpOB5h6SsZ9mu1WijYmVYdAZqJQ9Stts1E77NvxBZn7J+iTy8tkveuKTQU1eY9AQn8oinhD2Yfg5BIhMFTaFzSL8bNViNwBvmgNo03YdWeDMX3rsMAfaDPUO1bSEVVeovAhZI7Tr89J7ogtprWB+c99WFba81UQjTEW+D2rtXrojTfq4iJzV4RZIfs9VL+N+7cOZu6M0Lbxqk97hCKYSPNvH7YiMy6pXfwMzGdaQPbAaxRIoBbXZg8N46QBmbPVo+8xEezuHGjgTF0pbp3PcobXm5NQaD8qQZLEbtRlK6WSfg2iBHFkk3mkVnVdU4n8Q3jlt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39850400004)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(36756003)(41300700001)(86362001)(38100700002)(316002)(6666004)(4326008)(66476007)(54906003)(6506007)(8676002)(8936002)(6916009)(6486002)(66946007)(66556008)(26005)(478600001)(2906002)(7416002)(83380400001)(2616005)(44832011)(6512007)(16393002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iz28Mpn/QGj3sJx6Tbloen01Y6PsJF/Ry1IHAAPoq7ceOmDdk4Wv6fzFFbZ/?=
 =?us-ascii?Q?UZk2ov7489vlpb06H1NTRQvqOCDVJxuo8xe1MBmThAkyR+LhyKeZzkRYHfjN?=
 =?us-ascii?Q?9epb/o4Sg1LZx5aqOfDEnkJvqV65oZee72kbyzt9eDya5Jhuem09AsW07tZW?=
 =?us-ascii?Q?XMzIlVlnsaTV1Jdz1cUgI/AYuldBHHeXuXlgiLteZoJrtBvUL/6fZbHaNuWx?=
 =?us-ascii?Q?DCeYPcozQys8Xf04Ul9qdb21Y0kztsKzuFJNV3Mb9ca6jL/aBogSkuQKReHe?=
 =?us-ascii?Q?ugM2UQn6k43j4MbM9+OmYRjU4hUCo2M5RuYrm8bcUOXQxIdZdvOX0nnvE8oa?=
 =?us-ascii?Q?9UlFB33xOzt1MyyYxHJxP4FocE5njAQaNkx1/QreTDVsMXbuH7h6Cqi561Jg?=
 =?us-ascii?Q?satXWBesYN7gGzT0ISdKiu3HlF2d8jlmfdF9XZv8zVDxFsr2YvYkwpT/gmac?=
 =?us-ascii?Q?5KSQbi/dX7sYITaOrr0zJ4QIUJjEgM5unThrgM7RXu2AaNrJ0knSwasvzB+j?=
 =?us-ascii?Q?jf1CDhDWBMljg/b5F7gHwcmNJ7+LQv2X2r2d4XQjWJzjTqaEIUXahbDYNY3D?=
 =?us-ascii?Q?tHgHQmDDRnMP+v0RWsQBu5RBBwz91W28EKygRnmxM/hx6/swL43Y4zsoewn6?=
 =?us-ascii?Q?sXaL272roMy3xcaYjtnZZO8QIVIHDsQn3IzxHip1H59tvaCCGG12NmrkAnY3?=
 =?us-ascii?Q?md3l46sV0oVzSEO3abwpYZeW0MKfnRl/qQVTykBpfXO3cBHHbnMFVbNHuUbR?=
 =?us-ascii?Q?B+BQzdScU5NJ/Jnu6m9tud5uweAWZqoKjCdFf5q+wnY4KMoG5PKIIKbr4FJu?=
 =?us-ascii?Q?uw/vKbmI9PCf1+m1tykssZL7mAvsLK1ggJkSXhBTkrUOsQl2uxNGDkdonz1F?=
 =?us-ascii?Q?2SGKMP8ujzS7+o3DwmcoYmAyqy7IZOSFNbrEJgaJgPPUjyAEKnNLhrtLID5t?=
 =?us-ascii?Q?B78zoNnBHRxHKcF7n1X2TY3LPlQp8et/BrL4TRe4D1BOapwOiR4fi4pNzbG5?=
 =?us-ascii?Q?KRE7OGV64oq1KCpOrFZdWcYVIsH1CCSZdl7Lc3EqNBiamzecAkN/TLfo6Ri/?=
 =?us-ascii?Q?EyFjl/ud5xgZkxobXInrFQfOdIxrcS4oExrExugauul0diZ9F2iRqTSeW7ty?=
 =?us-ascii?Q?kmoBoA8UxnRX1nQgeC44JL1fs/1c/NT9KAlUsyXlJliuiBx7duQjO1wqn0ug?=
 =?us-ascii?Q?Mnmr08CkDXzO3q8zVXYO0m8OBPiqfobCwym1hOCLmG2BqP9B70Oz9a7fqkE7?=
 =?us-ascii?Q?RY5mvsgFQmbMxB5mtwr3SJz3G51riEEnA9xlgNH1vIV+OhRMOKNR8Ji/A5GV?=
 =?us-ascii?Q?UM8Pw67qHxEiyw1B6Mvol9ybLuyENSTFN9BK48/zS3ktBOX2X52VYyQPSBN2?=
 =?us-ascii?Q?4Z3IDmMBVBkuQW7nqsYyHZKWK999w9n6a7q8jAuzTQWh7UtZ+h1wERngU8XS?=
 =?us-ascii?Q?hHXF56P+tNAlsgYZsMmLdzSr6gYpEz8I/O/niGzrnjm2cF3XnVNpxiyt9ooF?=
 =?us-ascii?Q?eP23PBvAqA4foLC5Ns/JOp1WLG7GoVmmg7ToDLhahg3WSao1Z8OYmRwiEXiY?=
 =?us-ascii?Q?DqeeEuerj0IG1EH/acbuMny553jcyPMRrZALJEtQEE5a3uj4u1pYe+oBFhNR?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b65ebd-665b-4b7e-4073-08dc22cc25e4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 02:18:58.9553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Si/3WD/5GXAyxiouzn5oHfyWRlwWMHXYORJrjbGm8yzRN+bA0ovFOnCdfwaSd8Z8XkKZReEbIpgwHvyKhCWjaSy9Tx02/fs7V8mCYWkTnNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR17MB5973

On Thu, Feb 01, 2024 at 09:55:07AM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> > -       u8 __rcu *table, *weights, weight;
> > +       u8 __rcu *table, __rcu *weights, weight;
> 
> The __rcu usage can be checked with `sparse` directly.  For example,
> 
> make C=1 mm/mempolicy.o
> 

fixed and squashed, all the __rcu usage i had except the global pointer
have been used.  Thanks for the reference material, was struggling to
understand that.

> > task->mems_allowed_seq protection (added as 4th patch)
> > ------------------------------------------------------
> >
> > +       cpuset_mems_cookie = read_mems_allowed_begin();
> >         if (!current->il_weight || !node_isset(node, policy->nodes)) {
> >                 node = next_node_in(node, policy->nodes);
> 
> node will be changed in the loop.  So we need to change the logic here.
> 

new patch, if it all looks good i'll ship it in v5

~Gregory


diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d8cc3a577986..4e5a640d10b8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1878,11 +1878,17 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)

 static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
 {
-       unsigned int node = current->il_prev;
-
-       if (!current->il_weight || !node_isset(node, policy->nodes)) {
-               node = next_node_in(node, policy->nodes);
-               /* can only happen if nodemask is being rebound */
+       unsigned int node;
+       unsigned int cpuset_mems_cookie;
+
+retry:
+       /* to prevent miscount use tsk->mems_allowed_seq to detect rebind */
+       cpuset_mems_cookie = read_mems_allowed_begin();
+       if (!current->il_weight ||
+           !node_isset(current->il_prev, policy->nodes)) {
+               node = next_node_in(current->il_prev, policy->nodes);
+               if (read_mems_allowed_retry(cpuset_mems_cookie))
+                       goto retry;
                if (node == MAX_NUMNODES)
                        return node;
                current->il_prev = node;
@@ -1896,8 +1902,14 @@ static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
 static unsigned int interleave_nodes(struct mempolicy *policy)
 {
        unsigned int nid;
+       unsigned int cpuset_mems_cookie;
+
+       /* to prevent miscount, use tsk->mems_allowed_seq to detect rebind */
+       do {
+               cpuset_mems_cookie = read_mems_allowed_begin();
+               nid = next_node_in(current->il_prev, policy->nodes);
+       } while (read_mems_allowed_retry(cpuset_mems_cookie));

-       nid = next_node_in(current->il_prev, policy->nodes);
        if (nid < MAX_NUMNODES)
                current->il_prev = nid;
        return nid;
@@ -2374,6 +2386,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
                struct page **page_array)
 {
        struct task_struct *me = current;
+       unsigned int cpuset_mems_cookie;
        unsigned long total_allocated = 0;
        unsigned long nr_allocated = 0;
        unsigned long rounds;
@@ -2391,7 +2404,13 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
        if (!nr_pages)
                return 0;

-       nnodes = read_once_policy_nodemask(pol, &nodes);
+       /* read the nodes onto the stack, retry if done during rebind */
+       do {
+               cpuset_mems_cookie = read_mems_allowed_begin();
+               nnodes = read_once_policy_nodemask(pol, &nodes);
+       } while (read_mems_allowed_retry(cpuset_mems_cookie));
+
+       /* if the nodemask has become invalid, we cannot do anything */
        if (!nnodes)
                return 0;

