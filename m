Return-Path: <linux-fsdevel+bounces-8191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0403F830C37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 18:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7434AB24E37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 17:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40A522EEC;
	Wed, 17 Jan 2024 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="PWTnAMar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F51225D9;
	Wed, 17 Jan 2024 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705513578; cv=fail; b=QYXD6MbgHRyhSo0eEYkj28ESfFHZedCBqvlk8ecZkJadhoiFQDM5qneGgukEG1wYy8Pyn3HeYYRafd0p/i/cW7xcaWbn6lKBb+sZGq9tamBmEPF/FSu/qrTbYrSovqLmaU+vUT2Bb1u0TR4TcRcD7xTWvbWAQKNWMtx5q4STvQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705513578; c=relaxed/simple;
	bh=3PCe4rKGV9GAbI9m/DvJ8P7IR6KZb9qJ9FfYKSwmpqU=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=PSUhWlIgc3lNCkkuvSgmFCu+TWSyGOaDEmEveHNdQH6mZ70lFz4KXzwueghoxrrr/0fNtOjdLO4C0btuNIaG9MsembaD/weG+cvPKuUTXoE1jh8KcX6AE/83uj8CvEBHHcB8zDu1Pb7KBWFJoVHaNRlYavYP+WIu9GlxgxPT610=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=PWTnAMar; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEgqqTv9v5Q6PpUcJqJKGUKffS+aIAfR4eWRh3IY2U/zNwFtyyBeV3AYRcG9MS4jvu1ECktEPufPnvmU9t1/J9LXhgoaiQJchfrUK3yBtFjHVnE8gSoto8Jmt1oCiqOrEAycR+m7YwAPmSR5HCZJ97mh2CW7UIrNO2ak2fu/KdaDNbA9AngFGU60OOS8QjYIPVCOWclLcw74cVxZAuHdyHpTsSWz+sr8yTCeVOy+TTNLTkEy8YJdkyTtQf+lacJXu/xCDhwkhouO2cLjfYACrC9nfNGipc68EzK6jfl/iDFREFa33SeSQ+Vc/BMK5L2Ltf0m3TBQgWdorkzhfA3qhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSZZORtYz4RmGXqeJrrchaVb5t8o+R8JsKdCxgpbMGc=;
 b=RXloIi53fpLOlSLCwxDzB17DCNrJKpz7aY/LAl/OBjrPyP1u36LbOhUYLu3UTJ6dqHIZnpqjlqmATmV1d2tp8ClAk+AKSkx+M5AyYSQwTdMzxT3cS1SL9AMB0Zt8HtiTdlYs79MG71+C0kvrRNI0WErALbYXpvbQGjnTcQGAnUcT4AUlAF2X6sBfoVjBmVBWC7lS6VNXty4zrl1eUVrE8Ua03XhZ8VsllhLr416wj45utCTjOiusCCNIt0YYwghw9ACk02bnzHfJdGHNfbxZjHFN/ukvDR82vS6cMiJPl5b+2iaOgGdYsOEL6tp8QAQj/3521vnc61cm4kG9JOqCQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSZZORtYz4RmGXqeJrrchaVb5t8o+R8JsKdCxgpbMGc=;
 b=PWTnAMarKuMXB4qWQaT1H6cnaeCV8kqFXq7ctM0jKoyGwF3V1yfEd/LnLM+gY2p732VNXgfSvx3tPkMYLIsYz0sMwPSD9ZnbS2AM18nSIvMHXO5GJo0jF+WyOU86tVDVqLRM+NMJh18mA2FryeLSFTmeawD4r1ZEApZOH7WNUQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from MW4PR17MB5515.namprd17.prod.outlook.com (2603:10b6:303:126::5)
 by DS0PR17MB6890.namprd17.prod.outlook.com (2603:10b6:8:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Wed, 17 Jan
 2024 17:46:13 +0000
Received: from MW4PR17MB5515.namprd17.prod.outlook.com
 ([fe80::f5ca:336b:991c:167b]) by MW4PR17MB5515.namprd17.prod.outlook.com
 ([fe80::f5ca:336b:991c:167b%4]) with mapi id 15.20.7181.029; Wed, 17 Jan 2024
 17:46:13 +0000
Date: Wed, 17 Jan 2024 12:46:03 -0500
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
Subject: Re: [PATCH 1/3] mm/mempolicy: implement the sysfs-based
 weighted_interleave interface
Message-ID: <ZagSW5TXzZeKErlW@memverge.com>
References: <20240112210834.8035-1-gregory.price@memverge.com>
 <20240112210834.8035-2-gregory.price@memverge.com>
 <87le8r1dzr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZadkmWj3Rd483f68@memverge.com>
 <87o7dkzbsv.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7dkzbsv.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:a03:333::27) To MW4PR17MB5515.namprd17.prod.outlook.com
 (2603:10b6:303:126::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR17MB5515:EE_|DS0PR17MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd1f319-69f4-4600-b5ec-08dc17843250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N5zpcdKnO1oJJFMUuqBr9/fQfyAvarPM/FZkflc82TEGzDdWCKvI3a5YCJKMG+StDybWo26sFO/UE2JsU7UKljy7hs3PH88E1o7EUhFVu10/ofR+mdFmfKzJfDmQ05kIO+zd6/lHjm4PcT3/9nTeAWHvOxGKzvzdspIjEhGDws3JO5o0jUB+L5OLbHjKpLal3KuvgyKU8bXDCBkre4YmGatm1VVj76mdVTrqz9HnNtK/z/uYg+to5cQfr67hoH1rXecn1+Xp2OG1eOYtbicTNt/5i6252MWtJz6HgwV36WsY+dxPudUlyulRv+J01FaFmf/qPZN3gGZyZHpuWTKcLuS1Un4mi9z3kHzrsZ+2YTKBzS0jX5danlRJtYjrvAH00CvUhej+H4vC6+BBtTHlvc+xoikIVprUXNnRFXQCyV97VkNcK/k/f/Ea0oLarPtwiD+nUZwGef9ajZlvJ+yhM+E6CwO/Lf4ueKoLfmz+rQPN4teT3cTyL3jHhSgWgKGJJfHJELT6dGgIcKKB86+qsLZ00FuyL1/bAoU2ULnK+38Z1zcAxDE7wetGxsPTIY0FK/jJU7COfDuZi1rfDUvNImhV9lRHhdCwZju/MmIZW/1Yk2UbnoRdxiTY92PGhUkX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR17MB5515.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39850400004)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2616005)(26005)(6666004)(6506007)(6512007)(2906002)(83380400001)(7416002)(8676002)(478600001)(66556008)(5660300002)(6486002)(66946007)(4326008)(6916009)(66476007)(8936002)(44832011)(41300700001)(316002)(38100700002)(36756003)(86362001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j0cmSXBYdpFL0l1eBzxGyr1XropQu3o1m44KoyQCRKxJhXCqEERpBz2Lf2zF?=
 =?us-ascii?Q?zzVobL/l8p+O5J6UZurGDDfQx2bWdnofF1ZYn+InMCMjJaWkiAmAItzhk7OD?=
 =?us-ascii?Q?6CI0CsdsOAyXJz30MI/xJCAPg903LfBOGcL/Kvu+vhQvGQjekAHdwZg+cKr8?=
 =?us-ascii?Q?lQMrsXv/STxlU8Sz6Zd8KAKFfQIYGNwi6G6WKl2cDXzI7ZXJX8QfKrhGHFjZ?=
 =?us-ascii?Q?ore/+K0cQjNHXJeQIexb9jFuAWQplAgwgHS4+59hwQvRkzUaFfKlLEvSc9yf?=
 =?us-ascii?Q?7wVVj0jFMfyxn16FBx5KuxXdvv+g7Ip+ENkx5H3YP6FKqVULz4qA0eK2LacA?=
 =?us-ascii?Q?NuAugLI18u1b3tkZ22nWb8Qt1PdrdEkXt10FW+uzBB28IfAMSXlP68gZIzHA?=
 =?us-ascii?Q?y3bZ71kaM3wk51l8VX6k49KLUwgCM49eliuYI+GslvDAs/RoAhWakPcseLHM?=
 =?us-ascii?Q?kLTWDFqvb6dc3KQW56f3HbWTy3OYA3PWXszj/RsDvgYbXiONXWHKckQyUwAA?=
 =?us-ascii?Q?tdS/puKeYrKwdHAvsrKI53+djsAwxkho4Q9iFwnAJmLwxJ5hkUgr+5Q5U/j9?=
 =?us-ascii?Q?bwp1Yoqip25KWNjoIuGqVlyJ+uq4NhrxZRdidfdOXan6Tt9HiMCDc/Q7Zfbo?=
 =?us-ascii?Q?X/JELV7OFLSXNPkuuzmjTW019pTngEAtm+HT7ZBOfOBkxqKpSavYP3tkniOL?=
 =?us-ascii?Q?87EIJLrP94nleV7IjVaNVGmoyxRO+n07ezwujft0ZQLCaOikNDuQkw1lqVPm?=
 =?us-ascii?Q?x+DYcDoAwfdnGSt1pS+8LvjpMIIgPteDgC7a07e4wpRzFkNBK+Jo1KjbsgJe?=
 =?us-ascii?Q?+SUC4641n1CTj2BiVX+kWfrCu/T9iJ84Qd+8rKEcPCe/SdzCa4N2miWzyh54?=
 =?us-ascii?Q?YvduN7/CM+37alsEV4UHHuLx5/FA8wscBvaLSVq7q5WCdsq9PolUGKCINWzN?=
 =?us-ascii?Q?UWX05t3Vl/gdjeSc1SrhDxAD1d+9qcvN0w01IDFcXXrJpjZvuWz3sG4LU3vB?=
 =?us-ascii?Q?CyP0TVr8ELGmdkyrAfi033LJFq0ItmxFpnDKqy9XHroRkSlDPf7tO3wozAVU?=
 =?us-ascii?Q?6KM4/cwT18r4uW+9Ox0cyp2Z+RvVrrUJ/GM7BlXrWCJHaqdpPmtzOKFgEVQh?=
 =?us-ascii?Q?v1KxkaCE7eLjfMQJw8l+8zggVIUfr0BFcsHdogyKIRJeWOdcV45oJfuZiiGT?=
 =?us-ascii?Q?4NPu15zS3jlrTquQGg3q90tlDFsQoLDwPzRfOx4zlqzAoOTrP7tkVbQJ2meL?=
 =?us-ascii?Q?o9KCXqpetQxOHFpt93JJ09j3yLB/RlDDAWBnXDDEFCX9JUCerzzvfu04YQ1S?=
 =?us-ascii?Q?v5MfQfpC+oX0zecm+R7mu1FD2dLp0te/DZpOCw6xcOL/LI45/5l0FJghoLIq?=
 =?us-ascii?Q?Umoh5wkXV1+YgcJST2g0yqH7MaYkEqe+j6B99hqrjxiKtos4CPFIxCPZUCwj?=
 =?us-ascii?Q?XvMqjUmoS8qDqjjUL0FM7r2m00mOB7TB9H4selbHq87x2/LIA1wRZdcLFBI3?=
 =?us-ascii?Q?TZ9nLovvauyB8th8l+/vVJZpGXtEHFj/vXla7CT1oGvqWz/PRckyi1wuUFY1?=
 =?us-ascii?Q?E6vTcPKlxoxN0+ccLj/wYv+Rcdu1ek09qvnF0ldEoFAMot0I4kehWOXKzBLf?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd1f319-69f4-4600-b5ec-08dc17843250
X-MS-Exchange-CrossTenant-AuthSource: MW4PR17MB5515.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 17:46:12.9083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U91Xgsj2DB2IO3ZT8ALfEpxRlsvOjNkJGn90KIv2hVqcX8henYzCaeSLpTTZT9q9exnXNWejLbtb3wppMHAmYVF4Y3M7hIjO9CiW01VpTFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6890

On Wed, Jan 17, 2024 at 02:58:08PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > We haven't had the discussion on how/when this should happen yet,
> > though, and there's some research to be done.  (i.e. when should DRAM
> > weights be set? should the entire table be reweighted on hotplug? etc)
> 
> Before that, I'm OK to remove default_iw_table and use hard coded "1" as
> default weight for now.
> 

Can't quite do that. default_iw_table is a static structure because we
need a reliable default structure not subject to module initialization
failure.  Otherwise we can end up in a situation where iw_table is NULL
during some allocation path if the sysfs structure fails to setup fully.

There's no good reason to fail allocations just because sysfs failed to
initialization for some reason.  I'll leave default_iw_table with a size
of MAX_NUMNODES for now (nr_node_ids is set up at runtime per your
reference to `setup_nr_node_ids` below, so we can't use it for this).

> >
> >> u8 __rcu *iw_table;
> >> 
> >> Then, we only need to allocate nr_node_ids elements now.
> >> 
> >
> > We need nr_possible_nodes to handle hotplug correctly.
> 
> nr_node_ids >= num_possible_nodes().  It's larger than any possible node
> ID.
>

nr_node_ids gets setup at runtime, while the default_iw_table needs
to be a static structure (see above).  I can make default_iw_table
MAX_NUMNODES and subsequent allocations of iw_table be nr_node_ids,
but that makes iw_table a different size at any given time.

This *will* break if "true hotplug" ever shows up and possible_nodes !=
MAX_NUMNODES. But I can write it up if it's a sticking point for you.

Ultimately we're squabbling over, at most, about ~3kb of memory, just
keep that in mind. (I guess if you spawn 3000 threads and each tries a
concurrent write to sysfs/node1, you'd eat 3MB view briefly, but that
is a truly degenerate case and I can think of more denegerate things).

> 
> When "true node hotplug" becomes reality, we can make nr_node_ids ==
> MAX_NUMNODES.  So, it's safe to use it.  Please take a look at
> setup_nr_node_ids().
> 

~Gregory

