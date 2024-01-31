Return-Path: <linux-fsdevel+bounces-9631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DA084381C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 08:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6F4287194
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 07:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6C35577C;
	Wed, 31 Jan 2024 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="N7Owz6Yu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562A5810C;
	Wed, 31 Jan 2024 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687017; cv=fail; b=FGkLUyX4infSKMtwBFPNG8VG9q0Ru8iCzPTwaU60M/5int16Dycl5CVjChPq9YiF/ArpKvywAXxlcAhJBEQ0eJ/GLTLaxzr2uH0uKD4iE7dyZkw4khpczsUlu0sf/bd9Tz4oXh+NvsliR8j9/G80vmUUHdKpnpvQoQJtuohZ+BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687017; c=relaxed/simple;
	bh=dkSD3RxH5v0LL00xz1qdA4trSL+3OIJAshNX3ZBGXCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QPxiMYlNAQBfOdCnqh4SQCY7HYWKOsjs5JiJQ59HAaHXEj18ESGsIjlOA+zaXdOnZv5B+fJU6Whyn9u1bCdupWyqxpycfeq8jVggitqbPqP0rhgTQQLCHUAVaGc29Dlv3Y07Q5bA8s8+54XIiRGELtjV1GJo1bUAkhEa3SVlylw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=N7Owz6Yu; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6cZUS4R8LHJm+Ue1U5kdzfXicjQ86drm3AOJhoWFs8mFWIisC56RAzQglydRLDLyxhU3HAZ/Ass6FlezSj/zF1Q/vxWcFFnx7xVxojwcVg8HL3kp2WPdImv37ZDM2We7JrSvptKQfugw3UciLo94SFz5RH5/xYVXpOHC6CfJPdXnAGcKrzYu7SqydTSKNtsfi8Wjzl8Ox11EUvQ7+8W+qnIoW0avL/JOvfKb4e5REx26nEiZarrbRozh8jIHcQTd7aItfLUT42rMjUznZRBVTpgQ2GWK8aA2P3yVN6MJAF7XWuL46S/yo5TMGP5F4JUGuJ8AFaRslicl0oddoFPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mq1KnTeKU9wJk/xMTzH/bqeM/vJDiFlbZhoFqSsaKRA=;
 b=ii/Mgv8xXeSOSmU5fCKsUtTnHfapenidfH1s1UABYLjGcrJnqiKpA4aXSy/KWpDYzLvYV5fnxNvPLOL1hTsHeMgVZa9ryd/KSZOaNYPEEAiZ5aDIIPpt57I4jzEgb6L6Bcb9CtVd9zuAedCzMrcDavSBQu9X85XosvDyOWEqhvy3z9rnK2AVAFhq7vnAVNnCqTWpKx8MQ/pJ7RARKff+8xc3GrwCyiJ360Rd2yyCMWgzILsEiHZrdmxWRrj7pVIvYG6rETYK9cpCOXlNdF2ZvEKhoYhthvJbydOLakgXdQHg4devzuVY4MtdR9k2LB8K0qL3M95yQbjr8srGDlI2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq1KnTeKU9wJk/xMTzH/bqeM/vJDiFlbZhoFqSsaKRA=;
 b=N7Owz6YuhRZjD/kL8Wa55+22QU/sQwNWq2ePQzg/NZ2iXyCP/m8BJS8sbw+kS9d5TrBGb9XCRXpvRTTr4lo2aNLrLy4p+8mUvdddj75tUIbUBYQ+5CGNNxVCwWqbcqq/xBCsPc2ozzYplG5/4CPNxBFkMhUGzVlNGX8WBpYnxJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA1PR17MB6997.namprd17.prod.outlook.com (2603:10b6:208:44e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 07:43:31 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 07:43:31 +0000
Date: Wed, 31 Jan 2024 02:43:16 -0500
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
Message-ID: <Zbn6FG3346jhrQga@memverge.com>
References: <20240130182046.74278-1-gregory.price@memverge.com>
 <20240130182046.74278-4-gregory.price@memverge.com>
 <877cjqgfzz.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cjqgfzz.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::19) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA1PR17MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c86463-78e9-40dc-be00-08dc22305251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	udtQ39RA9WEM2Z/cXlh2JJ0fnD7AvVUqCS2/xbZc7wPK0ccZBzfYyfZlloukAwLvIrWZ5Oi5XDCC7Qn1C0OEswYee3dp16WIGRQEOF8arXu8cildQ5w8FgxCpXxe6ddFc57a2unFRVxCx1qJOA/iRvoxzQ+oZ35h/4le+sFC3Y+hjRDi/R2hhmV5pzm0B1wH/GQTuLM0EBbPzTanT7+O+iRR/gZPrCll2aeuqeya8DIUel1z/RlFdBoJHquIIo/JW9Ibg7S8Zu/n+AHWmEhfD2jHmXjSsVDkEZfnmSUBq5hiMOCSmEcyXx3+ZqWmYEmGech5AfiDAS09kIRxgluV8LpIqOZ8kDtBXhIAwm78AtCDoLFIzvLB3MZHFEy4PgHF+Jrx1YaRHqLI8f7NMb5DcaUHErXysqrm7SrJvu8b6wIBPTfBU+dhRP00xF3vvqIPVklaXqzsAQFYBm4wEVWv+2hH0VlxIPEOsUbfu4Qroh0W5sYbaaP7I6vG9Z3Ik5bwlk2Kim38/OOFc8NmsXmO7IJziw+9qV7AXck6Xnkoze5IHOTLPAm25b8UOUBczT1+kZTg7dH0fPCCMUXVok0TtbIVk+amxTL/HzV+bu19fmMmbLrEsq8Ue+NFnmVTBohF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39850400004)(136003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(83380400001)(26005)(6512007)(2616005)(38100700002)(8936002)(8676002)(4326008)(5660300002)(7416002)(2906002)(478600001)(6486002)(6506007)(6666004)(44832011)(54906003)(66476007)(66556008)(66946007)(6916009)(316002)(86362001)(36756003)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tXXdquaLa2BcLmiqXrRKq5WEZ0I9Cy4BMfSnlt5u+QhM+ZuJj66jMj1ZVBZm?=
 =?us-ascii?Q?V9EnKzIQw3hlBt81+H/uzBjiDjp0fVXMHNx9NTR30o00QXbeyUDmLZKpCLnv?=
 =?us-ascii?Q?eNsTz9Vqhnz/dB8K0RDU9xe2wbMr4g4xz6uwjB3+VdVcJotOyPMbP9Kx7sq6?=
 =?us-ascii?Q?gNbUsl9SiU+uhwdPkBzifDtsnE0LwloiZANoQfC/BrIqUohayT0hzwMI2R9w?=
 =?us-ascii?Q?0YR76q70bfSeg41OnmKeG3BOHTfOOkASAPYw+1580E7GnpHiz8NCxKKmttAy?=
 =?us-ascii?Q?NfFVS0bCQPMZJuQqXbLyLUgnDoVx6vGUnJcEQ86f+/cw0QZLiQfG+4QAOFL1?=
 =?us-ascii?Q?UrNpgEZDcsts787wzIVDtfD7H8DsegZK+AGpDirhy2Yh+hEIAJwpaEJHaVki?=
 =?us-ascii?Q?8hkJMqodo1BtonwnNpNAlmOXobZaGVCiVAcUu6HzWO74DbXlIb76XLfOsKLJ?=
 =?us-ascii?Q?i1JScKCQYIHer6oiHPUkYyE8rQgf/U/ItYUM36El2aEdrAned+pS8fU+DhW8?=
 =?us-ascii?Q?kuOpEpndoeKQQCMgDa6NoO4EC52a82fSrHgeV0F5jbZI95ZJyR6lHXXTznNg?=
 =?us-ascii?Q?Z41xwHbUNgGUXaYmz7/QUPDkkyF/NOOAtXl++juZukhlpV0QQqUYErh1Sjco?=
 =?us-ascii?Q?hjFuO/HlZG107yOOPJYSIV95R+MaEkoCq02t3W5pGCq6dPh5ux+wL4ss4hF/?=
 =?us-ascii?Q?fn7+TXF9SxkiO+5sXU9HK1PvNdj5FOhpH3OWXZIXGgXKluXlwkpJNWDiVOiV?=
 =?us-ascii?Q?Ll9cis2Dth5UhSOLyW8B4iF815X+Egtx3TLCv1D0Eie8zV5lrvB4P8r7FCwr?=
 =?us-ascii?Q?iyz9RV163gFwjjcvdqg54WWbR27t5K7j42U9wM8aFwjSqHs2VkHMnqvLk4QV?=
 =?us-ascii?Q?WZ4Og6Z6PNVwa94YjOt/AzWV3PlD+3vazKbLZr8rENvSpBXbk1oeFllxuJap?=
 =?us-ascii?Q?YYT7QB6E3/ewQZbwnOsugFka8U35t105IhXd9oabrIWxslR6MqznFkDL+7Pf?=
 =?us-ascii?Q?6jhkWStE5FiDDz/hZfDRmVzeQ+goOgafpTuc+jMIIWaHJxqIiqglbCE6mdPz?=
 =?us-ascii?Q?Z7MVfhiav6DCQFtt3fjXBoelSSGFV5eM7WAfpoldF80rn0eIJ5sgL+2gKtH9?=
 =?us-ascii?Q?p8RmXjoCC7yRWBrccKN3FJngExgsi/MsMvC+Dqpt7HcWhW5g18g4uC7PR5pk?=
 =?us-ascii?Q?r+1NpBOw4gxqulqpb83eWeGVdXv5ibwWf77gn29QgxsyC6Ssso8eERVVpf7u?=
 =?us-ascii?Q?UO6pfDIev73RyHKQEe69/kYLMdNRa1k9nbqyR+2HeY55HRX+mkbGNEq4mPFw?=
 =?us-ascii?Q?RWfmAkgG+7Hzozq1VYN6MaavJSQJ8mhn/gvGOQ5cssUKMFlQi8idvYEdM58T?=
 =?us-ascii?Q?9gpkhcv0QunOdMUUaJVSilO/NWGcmSrr45D/ktXVYL9SU2tjsoXJOhrWE8Kt?=
 =?us-ascii?Q?EG1hrxd+1gSu5zR08usI8JYVbOeop340/Tz7NDTJPB9s1Qzmt40C6M1U/o1/?=
 =?us-ascii?Q?+HetoH+SoBSQuICIqhS7X0KCxmnzMUHIuiee1NBKFcGv2tnNU0QuxKAGhicr?=
 =?us-ascii?Q?GejUwGxYSL9pCRWH+o/oBB49qEHPpRtBloKJXgVC7Z0ebJ85Jrpqp/7VEEcs?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c86463-78e9-40dc-be00-08dc22305251
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 07:43:31.6931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3ug6fIYZ8FirlPIXVNVZpRuZc/9q/NVSRhPjR9IKWvvwUgmaQAmstJO//Bdh0ROhL6El6FcuH+3NS8mGN3+Ry/IVhUC6Jo5ZSW9tnVpoCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6997


On Wed, Jan 31, 2024 at 02:43:12PM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> >  
> > +static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
> > +{
> > +	unsigned int node = current->il_prev;
> > +
> > +	if (!current->il_weight || !node_isset(node, policy->nodes)) {
> > +		node = next_node_in(node, policy->nodes);
> > +		/* can only happen if nodemask is being rebound */
> > +		if (node == MAX_NUMNODES)
> > +			return node;
> 
> I feel a little unsafe to read policy->nodes at same time of writing in
> rebound.  Is it better to use a seqlock to guarantee its consistency?
> It's unnecessary to be a part of this series though.
> 

I think this is handled already? It is definitely an explicit race
condition that is documented elsewhere:

/*
 * mpol_rebind_policy - Migrate a policy to a different set of nodes
 *
 * Per-vma policies are protected by mmap_lock. Allocations using per-task
 * policies are protected by task->mems_allowed_seq to prevent a premature
 * OOM/allocation failure due to parallel nodemask modification.
 */

example from slub:

do {
	cpuset_mems_cookie = read_mems_allowed_begin();
	zonelist = node_zonelist(mempolicy_slab_node(), pc->flags);
	...
} while (read_mems_allowed_retry(cpuset_mems_cookie));

quick perusal through other allocators, show similar checks.

page_alloc.c  -  check_retry_cpusetset()
filemap.c     -  filemap_alloc_folio()

If we ever want mempolicy to be swappable from outside the current task
context, this will have to change most likely - but that's another
feature for another day.

> > +	while (target) {
> > +		/* detect system default usage */
> > +		weight = table ? table[nid] : 1;
> > +		weight = weight ? weight : 1;
> 
> I found duplicated pattern as above in this patch.  Can we define a
> function like below to remove the duplication?
> 
> u8 __get_il_weight(u8 *table, int nid)
> {
>         u8 weight;
> 
>         weight = table ? table[nid] : 1;
>         return weight ? : 1;
> }
> 

When we implement the system-default array, this will change to:

weight = sysfs_table ? sysfs_table[nid] : default_table[nid];

This cleanup will get picked up in that patch set since this code is
going to change anyway.

> > +			if (delta == weight) {
> > +				/* boundary: resume from next node/weight */
> > +				resume_node = next_node_in(node, nodes);
> > +				resume_weight = weights[resume_node];
> > +			} else {
> > +				/* remainder: resume this node w/ remainder */
> > +				resume_node = node;
> > +				resume_weight = weight - delta;
> > +			}
> 
> If we are comfortable to leave resume_weight == 0, then the above
> branch can be simplified to.
> 
>         resume_node = node;
>         resume_weight = weight - delta;
> 
> But, this is a style issue again.  I will leave it to you to decide.

Good point, and in fact there's a similar branch in the first half of
the function that can be simplified.  Will follow up with a style patch.

 mm/mempolicy.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

My favorite style of patch :D


Andrew if you happen to be monitoring, this is the patch (not tested
yet, but it's pretty obvious, otherwise i'll submit individually
tomorrow).


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


> 
> So, except the issue you pointed out already.  All series looks good to
> me!  Thanks!  Feel free to add
> 
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> 
> to the whole series.
> 

Thank you so much for your patience with me! I appreciate all the help.

I am looking forward to this feature very much!

~Gregory

