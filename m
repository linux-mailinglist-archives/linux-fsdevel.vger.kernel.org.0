Return-Path: <linux-fsdevel+bounces-9079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0951083DEE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 17:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E30F1C22A73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 16:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9882D1DDE9;
	Fri, 26 Jan 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="GCHV494j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E78D1D545;
	Fri, 26 Jan 2024 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287096; cv=fail; b=t2F4qyKf8tslKKF22k31/rz5pFz7pYDQIBdxX1dA1U4Iw6B1LLEEljoJDu10j9uJRE8G1gfPRKJ3jt7xJNDppqFgO8eEZLcZAmJtNCaVFqLk+3EdyHgEJxDRBiWjGp+jbBo/Hd1VzPCkkjWQgAQ5v1MuI4k3KZfhphIpIgFlViQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287096; c=relaxed/simple;
	bh=25RQDc0+dCvtN9XR5hMskUU7VDhwvLPiI+HpQ2qMVQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tCrR9XhNS599NzSo+m33ibGInVFqn7H8nHNV8rA5o07FVTQGgvSAC+jwg4cxI4Sl2eW4m27XTKP1pRg5BzceSlm3R8XNxh2jeMUGLvN9dUm3o91SU7XxC9MIE0x/D910IPF4lSUKRsr4MWQDZCBh3wS+TSjYYshHWP2eCa+Ych8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=GCHV494j; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRd1+SywwMuQiYLpLiDm3SiXSgxlxohD3lzqvhtVp0KBMIgin+3im8AGP35HySinAZ8RGOhYgIS4CpW8r4aSMkaGQsA/Xgr6LENFdMF5E9l7DBY8re6z1TAHFIl6YkovKPUbquhlmJ/YLVmETUlZHBuWmAjjvJmJ1KtVbnwim2H61B0vYpgNAg9XQsM8cKO6JwMXt3pkja/RKBrxomptkRxACqO7QYg+JfvKFtRzgt3TmAlU4w7C9Lw4eGfIbmZ1RFwH7gUI+kKLROTUdrG4+CDO6d+CnMIhyJ8ajHAvYYdh1la4zsgQC6CIGNga1WxpSOjIgQ89aSTpr3cQM6Hs1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyvE83uNCyl5GXlZUT2iW4d834QAQmbuEb0YkKBEjWw=;
 b=nvaLV9k67y+XNKQ+lpVOR/Q4nh7CXZAsW9cKBpB27/qOt9xDc3Ng61jxnQdecy/mSbeldMmw1T8EIiIy1sLrq1R3BE1bXHFOAyW4i+09i+32w8wFjEBOGHJwEgWRNIc7vU984ajLV4k3bSjFvdCcfmxrKFxBFolLbXWmczOy2GpD3UDGRsBb0BZDSuWBxRUXSQEyrv8HZVm3pUzFnxV5w6AiroVGXCN89Px4LT03/wg76Tss5xiuvugShDW5FrmzJZS9vi0uesb2vOeUcfvu3IeDBXjSgMeaRNrp+Xj1fmi0SQEw3aXBg3cTRjLOs2uS3OYGV71uoG+hl+h4xW6RHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyvE83uNCyl5GXlZUT2iW4d834QAQmbuEb0YkKBEjWw=;
 b=GCHV494juis3lREmlSvGzEalF5txu3B7kDKFydUu6+oJhnpRYW6MCEh4l3JGRY9vgEdLLGJb/OSJ1oA1b8PwKvuJzqVRcTTsqUj+ZsdqqgEMbgomBSl4a2d+aiom0w1x7Pz4bGP7L61cU5EZaK6mRIBSOd14eVmzvQlaIus8JOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB4537.namprd17.prod.outlook.com (2603:10b6:303:ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 16:38:11 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 16:38:11 +0000
Date: Fri, 26 Jan 2024 11:38:01 -0500
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
	hannes@cmpxchg.org, dan.j.williams@intel.com
Subject: Re: [PATCH v3 4/4] mm/mempolicy: change cur_il_weight to atomic and
 carry the node with it
Message-ID: <ZbPf6d2cQykdl3Eb@memverge.com>
References: <20240125184345.47074-1-gregory.price@memverge.com>
 <20240125184345.47074-5-gregory.price@memverge.com>
 <87sf2klez8.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf2klez8.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BYAPR07CA0061.namprd07.prod.outlook.com
 (2603:10b6:a03:60::38) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB4537:EE_
X-MS-Office365-Filtering-Correlation-Id: 88dba959-1831-475e-58f7-08dc1e8d2f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kNzSFZE5u/LPp2srox+xt858t1kbyugRByX757vFZO13lPGXTHfKPPnKMzLYXQHA1kgf59wkisqjVDJVi2+lrJzyQkzTYpnl/WZGUwj3IKt/pv7zXMrRC6GpbW3YNw2aCr0500UnCgiF1vrb6wKznTbAbCqinSPwQ3y06en2ZK7QT22MUcnEyh6qFuE1dJB94Uafo2plDCdzEGzSNqybRD4eIVJtkA8kJ922VtPkIa8hOW+P5+Yib24TBrwLmQD/oyBeQ1f/Z7cbujGr7S5WqtZ4aq/eMiUumKUD5QC5d5k37llYTEyYN23xvf4l2Pv6chx3vmyqV+6FaH3iUGvCvebALLFUOugyRLu11FSnZ6gwmWTzUSe4sO1MSUdnAtLLnaf7uXr1u5IiexxGA2uP3HVwYgyKzJ5XOWLfyDMZAea3CMFH1PqHc++0H153lWXKv3TUizKArEM6FvattYC6cbzswPO86YUbeKTZwiVed6sBTBOo+lfxyOgs5DxuqvgijDPIyRgRYSqmKK5RGGM8d9VOPPFwyd5oCNjBUWaZy2+cw8P+u9lFrcc2nuu1Abn9Z2e817RgielLTybKGuTVl/ScjABeNF+/hnRIs91LkIo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39840400004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(478600001)(6486002)(6666004)(2616005)(38100700002)(26005)(36756003)(41300700001)(83380400001)(86362001)(6506007)(6512007)(44832011)(8936002)(5660300002)(7416002)(8676002)(4326008)(2906002)(6916009)(66556008)(316002)(66946007)(66476007)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z+WugfFt/IfMKlE48oWzkeEtFD3c73JgpgUGNff7+eGpKhwtHRXjpWajW73O?=
 =?us-ascii?Q?NANm9o/LnfC2mZF3N92Hf5XNA4J1xQfKkvogxwGfE8yDWcbxvh7kxLnJMYuh?=
 =?us-ascii?Q?uIqz1LGm+yXJj+TF9ZdgArTBXf8hD6GhyXq3dJT+V4xWhhv9WpppvyHvJ8rM?=
 =?us-ascii?Q?A1hs9sI5mnXPP7+8GyKnxX8BcG7ALGY6f92yz0RfGe+wm67WFoIGqr6aHj8T?=
 =?us-ascii?Q?gwRObPT8FT2mndhdqgd7Htzk9GyDmFIUXeMqd+xdcOyAQ+Ph2oetcl9fJnuF?=
 =?us-ascii?Q?8vQT+WlBNRbVfBSgkyKUyYfYiYHJAzv4WYcWXy4b9vFwoB9CJUr4fHhzAagP?=
 =?us-ascii?Q?U3pmZnZslE8FG9zHHkl3y6ZpAAPKqFXJgc0Llu/COGUt75vmGPDjqsDjuovl?=
 =?us-ascii?Q?IqIkJ3OeBs0Kai+KQ20rt7vx64T6+plFztptNC/grdpnXCsh8nVB4JbQ8nmX?=
 =?us-ascii?Q?39cceuxS9roVStwLbHqqFu30AhW+byzeO2wcTtdLg/ScgSns73DjsPor3H5h?=
 =?us-ascii?Q?uH+0LJ+TqP5iCjlOza3VarlM71kArvghS+9n6zYKCuJZYGu5NkrBeqxHzHqs?=
 =?us-ascii?Q?U+Y5FlpwicEJUC1g3OfJ8MtFEROTmIG1qAO6vjYOD++YqjtneXY3plI6bYn+?=
 =?us-ascii?Q?NFfwTWfIqQSU27wUE0oZi9xkpMMbLfA/GTIoVXiJA+F9lSnEmrPbhHUK4Bwq?=
 =?us-ascii?Q?egQ1DdycELrvVt3l64HfxwnA2mih0kIJchCWZQU5UuO3pQyWUGhnHp98kOH7?=
 =?us-ascii?Q?ncjxgHtvJUobjlkGEDGUAAKI3wqYn59bLzuktJODl1VPuQ0H36TDrG6qPFzS?=
 =?us-ascii?Q?5gAD8eyfOao79A8fWZWO4aMme2grSLm2w6N2nZCXGbjZnRdaeYiR4J2jC0Qc?=
 =?us-ascii?Q?3YSYXkspFHrRXNim310Hp0H2KNl/fy/vmagjM+qCicR0Djs7CJlf+O0HaIEH?=
 =?us-ascii?Q?/azu8Xnd5SEcMHvo99hwFc+JjVfqHhWxt3kpwd8zI4gA7WBcy7aa7qtIP0Hh?=
 =?us-ascii?Q?VBBJ5vinwZv0joLbJrjt0skXERUsbbmYzwhZLQWLoLFiLCDqwkt49j0noGVv?=
 =?us-ascii?Q?3+IpWS4djnaVz1/X/s+/Km4DAxjka9473JV86W/X31WyK/WffujKZMEtAMU7?=
 =?us-ascii?Q?LTamtTCdAIi4SzDoyemi28qkly4Voxxa/YLtRMd97VCkS5Wq1ijoiAgDFbVl?=
 =?us-ascii?Q?0G8hbqjqLNBmbVYctFTGxMuyTlzWWO59Zqgk8IeaiG9qEHd0SNM7AjXC/Izy?=
 =?us-ascii?Q?qZJB9V7YljVLclEfCQVg230h55I022ybpX6ZFB+yUFIKP6flwMCxp8qcLsHl?=
 =?us-ascii?Q?ZGnPRPupQJxLCZ3js0wP4Ts3BxrgfvT4aIBIEgse5FXz2Qj2+xI3TTx9HuBL?=
 =?us-ascii?Q?f7dATMb8Yu14wWTeiGZESfqWZHCuvCs99Rpdl7XDqdviQD31ROgrLCEiBPm9?=
 =?us-ascii?Q?Ld/4peZ0EN7428dOdaO81I4N74x3gJPex7EcZX1MXrAQJY3Knw3vwX3QeOsV?=
 =?us-ascii?Q?5UJWgB5eXTkNm4SjMjf9aFoW0o8/eJxQl4OSHzzg4zsNmVyiapqtaVwKb6ar?=
 =?us-ascii?Q?MahM/VLMuHio+jsNRxfEUXvyiBC3eCT8PbuErewAAMQdonhXMHKba6an/ULi?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88dba959-1831-475e-58f7-08dc1e8d2f1e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 16:38:11.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oe4gaOmOY38dGHbGizVvHnUEnlx5c5PGJs5QEk4eAB83HzK99r3R3oWxVRq/rA2PbLLxLWx3rYVWEwo7FkGsp9tKNDujiBPEZCSbiPmeOQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4537

On Fri, Jan 26, 2024 at 03:40:27PM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > Two special observations:
> > - if the weight is non-zero, cur_il_weight must *always* have a
> >   valid node number, e.g. it cannot be NUMA_NO_NODE (-1).
> 
> IIUC, we don't need that, "MAX_NUMNODES-1" is used instead.
> 

Correct, I just thought it pertinent to call this out explicitly since
I'm stealing the top byte, but the node value has traditionally been a
full integer.

This may be relevant should anyone try to carry, a random node value
into this field. For example, if someone tried to copy policy->home_node
into cur_il_weight for whatever reason.

It's worth breaking out a function to defend against this - plus to hide
the bit operations directly as you recommend below.

> >  	/* Weighted interleave settings */
> > -	u8 cur_il_weight;
> > +	atomic_t cur_il_weight;
> 
> If we use this field for node and weight, why not change the field name?
> For example, cur_wil_node_weight.
> 

ack.

> > +			if (cweight & 0xFF)
> > +				*policy = cweight >> 8;
> 
> Please define some helper functions or macros instead of operate on bits
> directly.
> 

ack.

> >  			else
> >  				*policy = next_node_in(current->il_prev,
> >  						       pol->nodes);
> 
> If we record current node in pol->cur_il_weight, why do we still need
> curren->il_prev.  Can we only use pol->cur_il_weight?  And if so, we can
> even make current->il_prev a union.
> 

I just realized that there's a problem here for shared memory policies.

from weighted_interleave_nodes, I do this:

cur_weight = atomic_read(&policy->cur_il_weight);
...
weight--;
...
atomic_set(&policy->cur_il_weight, cur_weight);

On a shared memory policy, this is a race condition.


I don't think we can combine il_prev and cur_wil_node_weight because
the task policy may be different than the current policy.

i.e. it's totally valid to do the following:

1) set_mempolicy(MPOL_INTERLEAVE)
2) mbind(..., MPOL_WEIGHTED_INTERLEAVE)

Using current->il_prev between these two policies, is just plain incorrect,
so I will need to rethink this, and the existing code will need to be
updated such that weighted_interleave does not use current->il_prev.

~Gregory


