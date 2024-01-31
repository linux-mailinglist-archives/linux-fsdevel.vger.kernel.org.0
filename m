Return-Path: <linux-fsdevel+bounces-9681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03B844641
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C548B24981
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2BA12DD8A;
	Wed, 31 Jan 2024 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="iP3sDh6Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6312CDAB;
	Wed, 31 Jan 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722192; cv=fail; b=PgdlvVdr80KaMAUL3mGj+goRvnysQ+yeaus/jrO86qKV/yWthXguOPZ/r59SV+D1QkF1hNPBVfZy5wkntJPuAH+75RXFbbkQSVuB589MRmz8bDfXYcX+SaogHZed4j+oephroOesCgtM8DBhnoKGbNwKDakUepaYC3eiUZztAL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722192; c=relaxed/simple;
	bh=dDOlY03el/qcbetRNJg3RA0SuBk1foKLLoC+SIGEWDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B4b5A5qES6xwf/vP6uoYg0N5Mw/QQzJNDV/vbMno+4uM79LVRfXtyWh1TUcot1qDSrBlvfnZKVKkgOq8QI+A5jBzcRTSBGU71TuUmi4BInj42o9aOqpyH561gkUfNHp2xzbdbrtZiFMfdUK9xTBWswIBDR1qVY6dh/HZygixOzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=iP3sDh6Q; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LR7g2+qrzf0N3tk/74qFtLe+7kl9ueBiQasCGRN2ReR1fRhBUwXlW9p4wfD/Q7PC0SoR8OgnJEvXYGYmTxceIfeSVsKAe/rOYBPXKuE2ENngFB0TInRJo1frgIMO0hoIxaAuV4pHWVK1j2XuYbn9MmODJO9P3nIvSbln2MIJU5fwbgUt/60Hh5MylJcVtfyAtM7jlOVELHK/PhgU7khervBMWnWBbzG+X6pDsRToL1K8gbnN/Oo0KNWeV8JvagrFHdVGdeJ4Ed5EPaCVrnQlR0nQhg71xlj9y9Xll/Oed1RRUva36mfxgsKl6NxYFmKtEaGweEWASd6pBi5KFI8m0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33+ilKcc9gWuJy+9M1x8kW3xAAFlQl2WX3X4XcnPsjk=;
 b=PJX4g+7wKFg+4YvxR6kL2tZhOihU/VzbIzn+N4XRTujXjquK+CAy3UA9frt+G4vjypzuOXJ0tp/8kAV1fXcrnT6l3/zEN8CwH4LjHlWZDE+eFP1lMzEYzOU58Z5qbMaoTeujmQVL5/uUVri5HOMUiGWj59HZLl9QxPlkHxekzl8mIyS2nSSaQ51uoNdREyacsvBbprQOFbdpoartFgqBoynlbkwgGzaTOve622wlcQOIKew/VeU+WbXPwOpzbYNQ17LsO8FJgi7qvCdT65yvMnTzV9fDUVWuLVHfnHIq83NZ/Xhsm3KtOYYc1NPQfUK3a6YgQgV7NB6hsrRditg7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33+ilKcc9gWuJy+9M1x8kW3xAAFlQl2WX3X4XcnPsjk=;
 b=iP3sDh6QyQxr7lcgIaimnK2JY0YO+gtOEvJofNmyukFyr5TRlgqsFmafvLvD/Xztv9hl6fDwtfR/k7MJ43Qd+mFqQrGu3M49WSVcFSJo4jdt9l0a+CjMEn4prHENZM/bycAdpg1bHN+8pq4mdf+extq7UiXhO7PjMfEbvi4g5Bc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA1PR17MB6193.namprd17.prod.outlook.com (2603:10b6:208:3a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 17:29:46 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 17:29:45 +0000
Date: Wed, 31 Jan 2024 12:29:37 -0500
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
Message-ID: <ZbqDgaOsAeXnqRP2@memverge.com>
References: <20240130182046.74278-1-gregory.price@memverge.com>
 <20240130182046.74278-4-gregory.price@memverge.com>
 <877cjqgfzz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Zbn6FG3346jhrQga@memverge.com>
 <87y1c5g8qw.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1c5g8qw.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR13CA0217.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::12) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA1PR17MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb0675c-fd4d-4bfd-bc29-08dc22823751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rRoI2ngjsUPQqsq2GnF8RQAY40reTbRiOH6soXgOVOP80hbVRzjMRN3rwFqQFxCc+XRv+CVvfxicrCFFKcBDMUk/ryT4RURpsOdVDqitgO8Ptf6MpfKIy5HGRxBbRoCHfwnou2vD2SQSSzgm2tePl4YqqqzBnFNzpMiP6j/KXlR8aRqgWQe9Ilv6ob0C7+EQk1LMqfMBBj/Q/zB1k8CfUCI8rNYCgeq5t0sSghGQ6Uo1eBmOHfZ0FEmNaMvzPfKGdAOaGxkXNKnxhh+LoxNIaP6FCvolD4+ICQgzLajYtq/+LeO9RylOd0L/LsuEFSigLAwTkC9Oj9uOXMDqhceYylXo412krXCJUKBjOcTPoQz94FnnplqCvc3SGq9PbDmfCYdTTmotV8zRurDlB+vW/r2onGNkhnitwRA5AgnS+gbjUUC/2V3SqCrDXhIMcI5pZ6ggVPkk/70j6pNW4ztZIHEnp1tLOPEr9BKazxxvpHccLlxWCbObVR15oUs+fTQrYxqPiTXtCdNPoxKGXV5LpNSh0c70J4f6ToTpBCcob5/slw+Wx7zB8uiq7V2ay01bC0VBYbvomB6GmIhIaZV/h31xg1kK29r0NyKLAvSPQ6Dlp8E6Y9wVqmDZBXNjgDFZ4XmjZfw3zNRmT6bWjYMbREtS8F9G4sJeMuwUedfsTxA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(396003)(366004)(136003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(26005)(2616005)(83380400001)(478600001)(6486002)(41300700001)(6506007)(6666004)(66899024)(8676002)(6512007)(4326008)(8936002)(36756003)(44832011)(316002)(66476007)(66556008)(6916009)(66946007)(54906003)(2906002)(5660300002)(7416002)(38100700002)(86362001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xGdUsHW/mc+rEsyZGNR34ZfjHdxDhaSw8W9KECdlaj8oQ5t0YnawSdr8urrM?=
 =?us-ascii?Q?0EdH4dBCVbNxFPCWGIF+RR/kqWXpqWycshulR3CjZd30QRcFrGCdwgNYGIfJ?=
 =?us-ascii?Q?nARhUDJk0/tW/OhjC/GeR2crU9bd4k4Oe7gyCizlxC+DzK23y6b/zniR6xqc?=
 =?us-ascii?Q?gHLX+hl6b5p4nzK6jibIF57r5BTyArc09MgwLsP2UBON2mWOtXZfl2aHHO2X?=
 =?us-ascii?Q?MBmTJEB2mFUEys8KlbfDDX5u25vDpJWu+kVn76smPXU5bY7+suLsmOYwFhRM?=
 =?us-ascii?Q?j1iHysvZnUY4PvEwQNKtENu22tAoxSDSjMeAxAHkyJgx3eWf0PF/JmuQvA++?=
 =?us-ascii?Q?YM8GqoE6ACFALLmp2khNvGz/t76Qc8O2bitJ6Y7niVCWezagsOljopg9IMLz?=
 =?us-ascii?Q?JxTZH6tef1mSALwcTd39SKduyEP8gk1Qnjach0rztJjQwYLe8HaqfDW2/H0o?=
 =?us-ascii?Q?1ILfRmmrgDvTGz8ppO+PDdZdoiE9oWuBoP4DrgJiqJ8J5dTut3eJZLYrIBn3?=
 =?us-ascii?Q?s1zBA9pBn/Ol3jDhOZDpqP75QPUL6/sfyHG+a9U96Foy3nc4JSQt2hk4M7wn?=
 =?us-ascii?Q?Nw4Sgi2USiYTTWtn8oJphZOSPGQt0kKwDncgtFoi3jeZBfXGZq5Ve4RUhcrr?=
 =?us-ascii?Q?cBeR3Jzt97qO1EfHmEYOWysbcYhCKulbZP5ioKEHUDohU10Jx5slYqjspWbf?=
 =?us-ascii?Q?jr7gHwHssrg7Qah1MnfdqX5XPlFSOiRknqqjSldo17WbFg3Rs+A/ZUE+vYHK?=
 =?us-ascii?Q?QsLK/3C8dAKR5YmDnY0zlmi5p/SzBRu5mjRo6qKNDx7TIuLAYoa/+2GSu0Y3?=
 =?us-ascii?Q?/EEIu/5kIpE54uNqkUBSkgTd0zVpVTF92oq7SNiHoeZ9vn044g3XNS5eys+T?=
 =?us-ascii?Q?UBhoHQIsmpF3xdfSFsph/KUK9OikFGwFwTjXyrVHtnyNOYrOmCTim/+e7eMb?=
 =?us-ascii?Q?IoT9kgYXm/yL2z0NWeWl77DX9/oHqu4CFDm58/f9NG3gy/904NB6OLlDcjvE?=
 =?us-ascii?Q?vtX+hUTOA+Tg13LjL6Bm8iHQN2iqfmUEBNqo16FJy/qoUum3BFI+telMglkT?=
 =?us-ascii?Q?lhefoMR/vEv5UYCr8/yGTd/fHKXI5wC1bRY+gFsHmKUrftz++hdMbIxjhcGw?=
 =?us-ascii?Q?n02tpaVcgET7MJk9TY0iPyFd6dNhCcqf8yzUNZbk80ZI3PSXwLW17ydqNwQm?=
 =?us-ascii?Q?fCAmhpb9+r5aVG9gQkvWOZ9tsN2WFF30eNExrsxyHlUdHQOnlEndXQ3W6o2P?=
 =?us-ascii?Q?hl/MVdb4d9Wtwh5/kn1EmFPIy3Yh6NZYIl4K0vPbIRg77iTGZ7L5kiMK/dwZ?=
 =?us-ascii?Q?jAonOWcUcF56E7lR9QF4iDza4Fxui2X5z/npyl8/PxG5FV/gwSRZjCF80dUy?=
 =?us-ascii?Q?SrYzacZq+2q1e0rI6ZN18vCKjA91p7cQew6+1/KFVrgYeVgU8eCzsfWFCsee?=
 =?us-ascii?Q?rfoEgQTZx232t4tkObZpN4BeEn0AEH2NiLCxZTQYJGTj10iDepO1fm+Hdmuf?=
 =?us-ascii?Q?/9Imgd5qqqs5oKun2Ewfd00hwRbZ/8Gj/1oqxjznZdymjQhqAVUny4NP/iMH?=
 =?us-ascii?Q?ErxMPOiqqBZVa45uCye+AVo6umEswQ+2Eb6YWWgnonVuaRP5VOW01ctxyUxl?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb0675c-fd4d-4bfd-bc29-08dc22823751
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 17:29:45.0486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cO1kstvtSkIh65seNPOaQ9SxMVN4a1lDM1IBEagJvfgC5CIqFS0NrSpeJzBGSsJY7qlMuE8xO4laWJo8jnSN+iD/s5uHnQeRurm7muaysxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6193

On Wed, Jan 31, 2024 at 05:19:51PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> >
> > I think this is handled already? It is definitely an explicit race
> > condition that is documented elsewhere:
> >
> > /*
> >  * mpol_rebind_policy - Migrate a policy to a different set of nodes
> >  *
> >  * Per-vma policies are protected by mmap_lock. Allocations using per-task
> >  * policies are protected by task->mems_allowed_seq to prevent a premature
> >  * OOM/allocation failure due to parallel nodemask modification.
> >  */
> 
> Thanks for pointing this out!
> 
> If we use task->mems_allowed_seq reader side in
> weighted_interleave_nodes() we can guarantee the consistency of
> policy->nodes.  That may be not deserved, because it's not a big deal to
> allocate 1 page in a wrong node.
> 
> It makes more sense to do that in
> alloc_pages_bulk_array_weighted_interleave(), because a lot of pages may
> be allocated there.
> 

To save the versioning if there are issues, here are the 3 diffs that
I have left. If you are good with these changes, I'll squash the first
2 into the third commit, keep the last one as a separate commit (it
changes the interleave_nodes() logic too), and submit v5 w/ your
reviewed tag on all of them.


Fix one (pedantic?) warning from syzbot:
----------------------------------------

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b1437396c357..dfd097009606 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2391,7 +2391,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
        unsigned long nr_allocated = 0;
        unsigned long rounds;
        unsigned long node_pages, delta;
-       u8 __rcu *table, *weights, weight;
+       u8 __rcu *table, __rcu *weights, weight;
        unsigned int weight_total = 0;
        unsigned long rem_pages = nr_pages;
        nodemask_t nodes;



Simplifying resume_node/weight logic:
-------------------------------------

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2c1aef8eab70..b0ca9bcdd64c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2405,15 +2405,9 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
                page_array += nr_allocated;
                total_allocated += nr_allocated;
                /* if that's all the pages, no need to interleave */
-               if (rem_pages < weight) {
-                       /* stay on current node, adjust il_weight */
+               if (rem_pages <= weight) {
                        me->il_weight -= rem_pages;
                        return total_allocated;
-               } else if (rem_pages == weight) {
-                       /* move to next node / weight */
-                       me->il_prev = next_node_in(node, nodes);
-                       me->il_weight = get_il_weight(me->il_prev);
-                       return total_allocated;
                }
                /* Otherwise we adjust remaining pages, continue from there */
                rem_pages -= weight;
@@ -2460,17 +2454,10 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
                        node_pages += weight;
                        delta -= weight;
                } else if (delta) {
+                       /* when delta is deleted, resume from that node */
                        node_pages += delta;
-                       /* delta may deplete on a boundary or w/ a remainder */
-                       if (delta == weight) {
-                               /* boundary: resume from next node/weight */
-                               resume_node = next_node_in(node, nodes);
-                               resume_weight = weights[resume_node];
-                       } else {
-                               /* remainder: resume this node w/ remainder */
-                               resume_node = node;
-                               resume_weight = weight - delta;
-                       }
+                       resume_node = node;
+                       resume_weight = weight - delta;
                        delta = 0;
                }
                /* node_pages can be 0 if an allocation fails and rounds == 0 */





task->mems_allowed_seq protection (added as 4th patch)
------------------------------------------------------

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b0ca9bcdd64c..b1437396c357 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1879,10 +1879,15 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
 static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
 {
        unsigned int node = current->il_prev;
+       unsigned int cpuset_mems_cookie;

+retry:
+       /* to prevent miscount use tsk->mems_allowed_seq to detect rebind */
+       cpuset_mems_cookie = read_mems_allowed_begin();
        if (!current->il_weight || !node_isset(node, policy->nodes)) {
                node = next_node_in(node, policy->nodes);
-               /* can only happen if nodemask is being rebound */
+               if (read_mems_allowed_retry(cpuset_mems_cookie))
+                       goto retry;
                if (node == MAX_NUMNODES)
                        return node;
                current->il_prev = node;
@@ -1896,10 +1901,17 @@ static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
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
+
        return nid;
 }

@@ -2374,6 +2386,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
                struct page **page_array)
 {
        struct task_struct *me = current;
+       unsigned int cpuset_mems_cookie;
        unsigned long total_allocated = 0;
        unsigned long nr_allocated = 0;
        unsigned long rounds;
@@ -2388,10 +2401,17 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
        int prev_node;
        int i;

+
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

