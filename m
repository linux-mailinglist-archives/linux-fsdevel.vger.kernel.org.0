Return-Path: <linux-fsdevel+bounces-9795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89A2844F70
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 04:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5005B1F2CD34
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 03:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8443A8C9;
	Thu,  1 Feb 2024 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="PKPoxSGz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2097.outbound.protection.outlook.com [40.107.93.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E88A3A1B4;
	Thu,  1 Feb 2024 03:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706757049; cv=fail; b=b+S3WHJWfZUqdyGm9OeUdmsh4LefyC7g2l0YFOeyaXzR3vcrdmXWeRRrydTjmzuyVKXjKBWg5T+ELXEEWIU2Gxg/Ib5cl7UwDoiEDmqe8BNrhxDRXocXDI00ombFHd9RpCi8cYi4VSp+JYF0ycRP+edSFQkBss1owCRaH0X22C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706757049; c=relaxed/simple;
	bh=OePdErj4IL9LwsD1CQBYy63KWrMIvO8+sHNgJqv1kps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AgWDr32oYsLGZZkcvD8OlpyNBppikKlXPSeA+53ZItuB3gdEDnMxNZyQXI6xMpGcGSZUJ5z399hsgDKJjBJ+J8JnA8ZuRYkRkGBjh/hGL9EdWbzSfCGGS5gbSsQjRBzgtBNv0sxSC5or2d6JTG6qTvAhhy9gW9nn02U0Q8Soz1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=PKPoxSGz; arc=fail smtp.client-ip=40.107.93.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baC0zCsid0o1+jewJgGJlgLD0PUKbnwL7+2oLbgcl65wOGoDn10BW+yscI/7apMU7CWFoBtBodWig5kh4TCSWH6awqqOfcWkyUvIb2tCZ66TTDHz1+9lQU6c8G/ulhZ8tpxjOxWlH0g9o6Wgs0BpxEtf5o4MLjzQR5KNkWnV+bYsmBXccD3csrwFzFz4RtO0j9Yf7LnrnV8uYBHqHNMGF7zMYtwvbOAO/5b231wuoFe4lU8oTLdjx6JMI75cslZd5GpSXoxjg9TxvoWb/2Bi0rXR4kDHZyrLL5kHgP+sQOBdNibsEIF8oBlmIwmQQkZ3irIi1XLPJMQl+GsLNoX6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZF7XftzB7/1wvP8PEseGYLNm0rHQGeAyeYjUm3fNKw=;
 b=cf/sXQm3SUYs513GhS4emlLgbA9MkEPoe+Uo38WkDHqWpy/Hx9oY1IX/xJM7eePpTs7wtlkwxNqNrBO9PY99oTcLCBIMIX4ABymKoU5wPxe2yRdbXDU1WCDvRp9vYCP4AQe+CH6u1u15Fvj6qYK2ah29SKhOHXvXpTqHn2Xm7zxx6318KF54cHHjZjzuffoOUTPROpGatQFl9Aw4Dc90Ey4KdL4dlRWYV2IGOILEY+AZWDL4XDtympR+RbR5xrf1K6n7X0ZiHiiloXB8UsY9GWA90i1vqexcl8QoMvVOTsKQBXQzBFLvc+KxyOVAAeFX65unQ15rcCJvsdsHxkrygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZF7XftzB7/1wvP8PEseGYLNm0rHQGeAyeYjUm3fNKw=;
 b=PKPoxSGzOZ8tibZ6y1qTCmI0EFr/GAN2tgJTgZFP15b1xMpz6UyVnxbkQcPu8MG0yMh/d9tTYlmmaTYn3iUVkxEKd680m2SIXdymeo6WJuG2t7x7/JJe4BGy2tBk5uxhnouPvhV5Z+GeuEmq4lnsZ0CJoFwinJBLQ+ypHwHyrDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA1PR17MB6421.namprd17.prod.outlook.com (2603:10b6:208:3fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 03:10:43 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 03:10:43 +0000
Date: Wed, 31 Jan 2024 22:10:34 -0500
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
Message-ID: <ZbsLqpUFywyVpu4A@memverge.com>
References: <20240130182046.74278-1-gregory.price@memverge.com>
 <20240130182046.74278-4-gregory.price@memverge.com>
 <877cjqgfzz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Zbn6FG3346jhrQga@memverge.com>
 <87y1c5g8qw.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZbqDgaOsAeXnqRP2@memverge.com>
 <871q9xeyo4.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Zbr/iv3IfVqhOglE@memverge.com>
 <87wmroevjc.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmroevjc.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BY3PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:217::16) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA1PR17MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de3f890-b496-44b3-3362-08dc22d36059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NSo6wTTCMC++NkfGS3Tz1m+JRiOv1Qe78cuYZqZjpVbIA5KyUZBMxmwffnb6LhNBW2w2qu+VEYef5GIKftuaf9LRBMkSEi9FkaOsCYVhjNOYVdeTIYd6C0vw0rWbSm67tqiTEuV1CmtgqzO7zafbrBAeQIuZmz0kDVHiRTM0LMviCZo9v6GSSfz8ry8+GQ2fsmrzREVPPDiKuhSMTlnPOXxhJGyygUaUzWiZlUJ/DexRj2utCWngxXnr87N6DRcXFad3fI7EDWjdNuG8IsgsA+S2CSUPsvNCcK8RN+K4SFyU53TR7ArHbVca/+Z5Qbn1GuCgCyjA8RN5fduocjLxovMzKpdvUK/dnomWIjKS25/JQ0L+WPOACWcXbpyYgh1KzFS+ntwBBulUgTMGACAKHgSSE39BkMB+EEr0Y7QIUqB1Sk7JBz770jIELfZl2TLOPPg0E2KPaALi+68+WxKBLri7KYJvL052ATwBi1tmTC+ZKckkm4c3sAD0HyDsu7iW72Sk8oAZEU70qk4pELphDazgW6XES6JFNLm7OmNvYj0oy80cMjAxLoD0Lc/yq/++AtlqCcSrDkcsMUtOLsSqXhHciIDgYvmJgn0kw42mHOAYvcKYBEWNYNNvZUbMEJGV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39850400004)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6512007)(4326008)(478600001)(5660300002)(6506007)(6916009)(316002)(44832011)(7416002)(8936002)(6666004)(8676002)(66946007)(6486002)(83380400001)(38100700002)(2906002)(66556008)(26005)(54906003)(66476007)(2616005)(86362001)(36756003)(41300700001)(16393002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5dzlZ0/e3NCIvDHHmX0u2jo4y38WBi2UvYXuANCe8APEF4fHi/fJZMp9W6Ft?=
 =?us-ascii?Q?egDyxUEp/ZowwrXw2JIKJiz1PBIOU7tE2tWz+1XmBKg89wHwIdte7O0tgyjk?=
 =?us-ascii?Q?AY9tJLRG6K03RKN50dd+/6Vzdk9OrWbJ0sqwDP1SsP2LH6I5aKSMUZbG0VGd?=
 =?us-ascii?Q?lY+aPnEjbo0iwJKkFHpcc5Gvec2vdL/1OIx14WZlNbL4WSdZYRPYuKS/CL6H?=
 =?us-ascii?Q?TwMVfGENqlsefogYvPhDZcR6EOuPEuLH9AnN0Bl69iZrXeqeX5wwnZA07vg+?=
 =?us-ascii?Q?q0bR3b3etwi2DcvASwzx9f3RrPjWxsnssLEQCAreLcevdJyPq/2BLnl2w8RS?=
 =?us-ascii?Q?4KnrDCVBFmTS7MylYtTtt3vnq6yup51G5GiGoW2UcYQAZA3xNpuho9unNfhb?=
 =?us-ascii?Q?1j3eVxeNft69K/VZz+nGe6aNUVexljmSm6ml5F40PfrIckpDj1Y9PiBqI7xg?=
 =?us-ascii?Q?WeN0GVR/1imjJBf1IrSbhyTuRC+8QSDHT06a6mB5ynOxnwqynJuquwf2d3hI?=
 =?us-ascii?Q?twzVaZ7zHl5EkiDA+jYQOG0/gznjQEr+8cjHroRCbdz0adOUGPN3UXaFHx1y?=
 =?us-ascii?Q?KDLZrXrgM9rfdHvfYwyex45Rtgnrki8KeivcKqF/s4Behd+4Lx94TreXQ+V5?=
 =?us-ascii?Q?nFGaIdpF0LZz4FKrA876e2G3T9qMv6bINKNj9ceKOglR729misumeXHtfZ14?=
 =?us-ascii?Q?CkDite8hf5tD5vZXgv3h6EI8QTRKmOvxAgV6KESjU6rKrOLfvRjI4GOHV//r?=
 =?us-ascii?Q?7f7x3oBcEfOzT8a+kVSgPg+jZQEgaJF1LJqVPdsK6wE9437YFghjj41i7m1O?=
 =?us-ascii?Q?AJfXK+/Agf/datjyamSoHYziWmRB8ICXku4SqL++v0B05UFEGGszBsQtrSzB?=
 =?us-ascii?Q?RnJtIMSD3cbxh2+0lVasIDmFFhc8FBfxJyLPlQhMnCW2crOS+kiZN7MksP3f?=
 =?us-ascii?Q?miHs7+yMPCJmQkkKks3G60bDVQ7WAi4gRYnuV1qJgidViKgpKP/d2xgLVh9P?=
 =?us-ascii?Q?eVkuNOqInATxCQZrfamSAxFleZrMZ3m/1IaGR6hhbigyaEV1EaOAzxeBpBeb?=
 =?us-ascii?Q?VvNMdZJgb99aLd5c31fnZL/a9QO2QpBuPd+xVOji+20hbL/LEUc+FxVY+KJO?=
 =?us-ascii?Q?Ptrl0N6jgJvpf5aLdn2jHeOh6cI68GZu5LGMkSVybCJts2iRmQHyXWxM7+gd?=
 =?us-ascii?Q?xT76caXxu8lSO3EuH//pmUIgTly4nifSsvGC4PS1XIboVwZFendFM16sOpK9?=
 =?us-ascii?Q?yxlsBYkx9GHZGD6Epk78MDAl8/+fom0E40JXWLR/5rOiFvpXajmMn7KV0jxV?=
 =?us-ascii?Q?ezEKBAwGYSvXejenHA5wnDwtxK2px6VXUySw7HHyzqGhmyWTkObG7BV2ZvY4?=
 =?us-ascii?Q?WYDaB/x0ReX6MW2CCs/IK8ziDZJe0oDI44si/AMFZwckTU7SG9b03zqq+ECe?=
 =?us-ascii?Q?iIf0xF3oktubrn31z/03D2eDat40K4ioY42FBHFjob+gvWZCNoAk1mWpYe2B?=
 =?us-ascii?Q?4HEVG7yjpqISfnUHbzVIiwnWULRHUrZrUDKLimkl+BFNYXDE2GPSwgB5sFHa?=
 =?us-ascii?Q?ozU4bucKNw05X7+I0LQYMgC+/uHY7xkg3zIIHLk9TiHcywlOUzrhwdZ9N7nJ?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de3f890-b496-44b3-3362-08dc22d36059
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 03:10:43.1319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eplS7YSYfZ5KkJ/xJOGeK9MOmZcNsILdlxKwl8n2zN7aQk2YbPoQYqiCJEUQC/bZvim2v/VYOpgV+hIkeo4heIZEFP3RCnMrf/SMawUVKf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6421

On Thu, Feb 01, 2024 at 11:02:47AM +0800, Huang, Ying wrote:
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index d8cc3a577986..4e5a640d10b8 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -1878,11 +1878,17 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
> >
> >  static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
> >  {
> > -       unsigned int node = current->il_prev;
> > -
> > -       if (!current->il_weight || !node_isset(node, policy->nodes)) {
> > -               node = next_node_in(node, policy->nodes);
> > -               /* can only happen if nodemask is being rebound */
> > +       unsigned int node;
> 
> IIUC, "node" may be used without initialization.
> 

ok i should slow down lol.  This should take care of it.


diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d8cc3a577986..ed0d5d2d456a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1878,11 +1878,17 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)

 static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
 {
-       unsigned int node = current->il_prev;
-
-       if (!current->il_weight || !node_isset(node, policy->nodes)) {
+       unsigned int node;
+       unsigned int cpuset_mems_cookie;
+
+retry:
+       /* to prevent miscount use tsk->mems_allowed_seq to detect rebind */
+       cpuset_mems_cookie = read_mems_allowed_begin();
+       node = current->il_prev;
+       if (!node || !node_isset(node, policy->nodes)) {
                node = next_node_in(node, policy->nodes);
-               /* can only happen if nodemask is being rebound */
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


