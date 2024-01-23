Return-Path: <linux-fsdevel+bounces-8625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 921A6839B2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 22:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337261F21C40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 21:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E1C4E1BC;
	Tue, 23 Jan 2024 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="kV4svIQG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8AE53AB;
	Tue, 23 Jan 2024 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045270; cv=fail; b=a1tsSgrUJBnfJJ0XRy/36Sso1s/SGZ+GPmoLwJR/bb5ZzkfkppnuFS6ewNvYd5cUVvVfRMDhrHSjmeMKH9JmXkMD+HcAkSGcbxsz/VWdcPfsbHY3hZ/vnegN7T3M+iI7g7GVbrHQmNBoDPBAsAcRpXCOTZ7dPzBp4uEpqVHgdWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045270; c=relaxed/simple;
	bh=5Il5MnLnNBOSnK6cz3YR7ynIM3PfFg4KqZu0/Y/uTuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r/CXEsEJxGq5ydIcOR0X9Bhw48kgLL48QbxyclEucnFKsMLZ4NPM6Ozsw1rA2RqwAyU7bGrRCa0vcDatRanerrZccrfgwcv5stL8oW7C2ggI/OG1T2+qW1vg21tazkEXUTXRmij0ARSKVsJ9RlBVmP1y5Xcq9H6Am5e2IrF67d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=kV4svIQG; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5bnl28pQbwDk5ae4FoMvZ+xkiKLh7XKD6U3kioM9UTBz63uu4phsIWkah/xixL98qgpwo5aUt7t5kNAO5mH7JvOmoVoOYY/wsD6HD7eXQWK1WwERhoLgbyoYa9SCqrKaKUkRHmvEnoUBky+wLBHzm5oAmIJEPMmX2wmcCicp2NHvKEsBsopjo13uIvYvoQv+iwfI8ee+7i/rKnjAacFFiiEjARz3F4I5mcnJBp7tHmGB2snfv9FiBpjkhKRRdGIh59kP6J4iziZrp07AF1Ov1ZV9WYwRTLarToOLLlUNp6BJXbRBG8CQ+2k0pv4FVGwAc73XoR86PjIOowylhooyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uXAFGAn15May1pEX86LSoUj9Hyv7thC8GPpKvWgC3g=;
 b=QevWbTw13R0MGBMGM0biLYFJsqaLORS7A86aCgfk9J64o9ddJHel89p3JBA5Fe6V65qdUJUjFG1kkGpWeQ/2vS01Vl4+NQfHBH4XOKdryXUy7paQJh7N9ntNEprUsh5ZMK0oMaf1i2hEwlWTGZgzsTbMIonRfjS8Yuw+qbBnzu6GqgyfpCLdniilN6sWi0m8a2v/zSG5Fh3BhAUu5JQhDze5y/DN+7CSCjqYiBE9z3ViVk2OoVoyDk19DKZF3fhgbetK8ORjipcHeOu4OpNKdAJ+EntMBEaeBMkXeWhD3UcBD4+XRMlpguuh6Xl+kuBQ7idnlypn9jdSAPxRblGUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uXAFGAn15May1pEX86LSoUj9Hyv7thC8GPpKvWgC3g=;
 b=kV4svIQGC37SjUBMtESne5cG3GGHWAtzbEMEPkb1V6qVwwdefcZ79Ce5cKYnh1fV+8agjui/JN07zXikTLYM3XGsoj/QHYe7til4fxJ4TH+tF9LrmBLgBKUlBq/HTrI4XMiCy6YVE0SdJkq4bEq0hn/q/eBpsMK30qvkJVNoL2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB4374.namprd17.prod.outlook.com (2603:10b6:510:1d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 21:27:44 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 21:27:44 +0000
Date: Tue, 23 Jan 2024 16:27:35 -0500
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
Message-ID: <ZbAvR+U+tyLvsh8R@memverge.com>
References: <20240119175730.15484-1-gregory.price@memverge.com>
 <20240119175730.15484-4-gregory.price@memverge.com>
 <87jzo0vjkk.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Za9GiqsZtcfKXc5m@memverge.com>
 <Za9LnN59SBWwdFdW@memverge.com>
 <87a5owv454.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5owv454.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::28) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: de1dc1d1-f7af-4aec-e6e6-08dc1c5a22ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AAAaxjHUfWiiKCz+X4zRhd6F6idczRjmGEcrJd6oWgRe9Prw08fbMDY0jnDBHLykvh/jqTcbTrsbu0XZdWfYzH+8Kd+L1FJHxGJGFg0qbbLyMXFzj8g8zhkKJb48DrSwAMiIfRX+3vIuvuolD8vo4ngxPJLRhNXwXXVGLVKN0MwJoFsC3+8RpA6Qnccu1bf04zw9zUvWNayNhGAFH15UHDvnncWksn8K/Gps8ytWRSShx+S22z/eErp989923FYRNWSvCGKraSQZOsA9y63wP4iqWzgcZRdX/7/PqgbHazxHmut9YoeRj7koMLWlfFiWRz7ZQAD+UdkN+V5WN5jv+H1uK7VWw7QyUO+kVK/2o0ZpO5a9+VGJtlmxWiBB3OHrxP4mO2DCFLLo/niQ1lsWjtsKdof/IEP/N3Hr02ddCGzdBTuJKyUy6ZZVTXeF6PgzeCCbktkJkqHGAsxj9gBK5aOdZ69y3JDvPN8Ep50nskQKG+1Dfok/ynwW5ZP/IG8yUv+dXf8v83u0bj3WzhSTQeigYU0Ak4mJQ+K2IyIPgcZhsM5CNVpYYh7F87L9Vn4V6516nwCSiAz+cNYti40M1IEJ2QS/4vkZBDdskbmUUS0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(366004)(396003)(136003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(7416002)(5660300002)(44832011)(316002)(6916009)(66556008)(66476007)(54906003)(66946007)(4326008)(8676002)(8936002)(6486002)(6666004)(478600001)(36756003)(38100700002)(86362001)(26005)(6512007)(41300700001)(2616005)(6506007)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9osMhT33FDTSV7W1injJrk7wydqL2ha16DL7sq6V5Bkda5C65V6Hu4z2YQuq?=
 =?us-ascii?Q?/cWctv26+Xk0amJETwQ4t4CP0CfJqQyKF4z4Ov+jlTuNvtAFxVq+5rl6ve0w?=
 =?us-ascii?Q?ruUPQc/XbLxPirEuiBHvSvnuCT6PFzf7E46wULvgJMyqA3huikTK0gwKHV6p?=
 =?us-ascii?Q?A6u5EF8itTHvddgJmgFKKhw7hZMu7kHipKnrY1qoPP3Z/0wH8nszn65Pkom2?=
 =?us-ascii?Q?ym/VOBOCrFb8y+vzqioXeaifAJIFWY4zVHhqwar9fEqJXUjTbPu+KQ8vZnue?=
 =?us-ascii?Q?GbCvv7ET00l2xsoriBT2oRRpuyggwAbxsbPlQePL1R8/Wn/RBGFQCbD8hxnr?=
 =?us-ascii?Q?DvOAPLwy8BjJ6NrBhIC6APYJ2adYnYFMCSmZp77tBtfpqs7Zo61rP2A7wi6O?=
 =?us-ascii?Q?bT1rBo+74tfBW3HmO2kk9oCZESInYiZfLnqR72GY4tdsqtd3J8fya2IGyD/y?=
 =?us-ascii?Q?2j+Lz5PlYEghH9QGaQ5KumW47+zUWAQKZGEKPTyp8KtOpgkhH+MmBZ6+bKXa?=
 =?us-ascii?Q?0YnfDdoFhJPBTgFIokJrCG3QaZ+WToYQCXUgmb6sts6Iv5b9O2y4oQNKbueO?=
 =?us-ascii?Q?q5lipnzfAiWOoggBnRhlQi+q+bZIZPMOnt3VMIPVtyir4Djx/Kd79dtZ3zVL?=
 =?us-ascii?Q?SboXFXS9ynEf72pWeOhxuGdk+kZwDtNhedL4P7WFPeDQltqXdin2XbSZUpYj?=
 =?us-ascii?Q?s2yXWOTNil18KfF1bmbuIwZvK2tMxfw1R4oQ+0rerNi3kl04lL+7p4YjpV2Y?=
 =?us-ascii?Q?bnwWzBlLklHrX3o+gZmbrTcsnih9p8Rsfpa5nkXv6LpH/lxg03+kqkCFwFy3?=
 =?us-ascii?Q?m0DZtsYMq7hPSs0Px3IzEH2ETvMcZ1faGoVs24lqlQTaLHXPTU27/rjCF+Y7?=
 =?us-ascii?Q?0lgk74VW4wkr1HiGeFeNWfsaDKoP3pNsPcIAX6wbqff0/Gm+OEsmQrMdf6WV?=
 =?us-ascii?Q?p4q+23mEWOfilNeeNwWO1fvhfrBt57cO5jukN57fg438xQ8H+ZcU8xn1AB8k?=
 =?us-ascii?Q?qnet48SjS7M7F5Uh67q9HRedLOxdsNTK4mXQUg3HD7oXtFFcgu7ryPt/rXOr?=
 =?us-ascii?Q?rPzIjpqEU7sH773sWUKMgH8xOiCUpuh4eN7fDhkwEFwax6W7dYNmaRzsQ6cw?=
 =?us-ascii?Q?nc9OS/T6Z6r86A6YCdC73Ci0GrStPmxZxeyjEt/kSI7xsxdWaWpZ98+UA+Jj?=
 =?us-ascii?Q?QPbYeFXKqWq3jZ0ojH/dLBFxWeRPwEbgNvupsbfgQhLNk3HpEkBZWiLLXvi+?=
 =?us-ascii?Q?9r295ou8IBzo6/54jWmUqZKKrUC1FdiEgzT4eED0qI8O8T57C7rqENzmC1rV?=
 =?us-ascii?Q?wdEbK5gfcBKdl5JWbQ4yrS7YKJ/4/OGccwPa8YCMMKWEGyS3yJBPDaPiRotQ?=
 =?us-ascii?Q?FqujcnllVTsuVUIC4qoIzWkoT2jziN8/Lbf7mzYcgC8nAQ/nJ4LM9NPxGuG0?=
 =?us-ascii?Q?ZUVu3loctVIb6WdAaHdtRk6eS89b56aQ93ynmEW1W18uSjrA6wNFe65ywQTt?=
 =?us-ascii?Q?sMJR4X7TUCCDv636coW26QaMIX4y+TCbY7yZrqH1j3gK8OHpAerUZNoVwN5I?=
 =?us-ascii?Q?ztCPpsGUENXne++qXqopmd5gKnhDR+oip5oJolGKHWW1xaK5+Ppq2v2G0qSk?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1dc1d1-f7af-4aec-e6e6-08dc1c5a22ea
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 21:27:43.9741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJXAQFCME7akKKtGG+e4MkTWxTJFff70lYwI9qBx352jtMFvcgtKOfZQUOI5BhoGd29DfJpm8d9KfSVGI5ne3OHVexPQEpYuk7jsuMZGvc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4374

On Tue, Jan 23, 2024 at 04:35:19PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > On Mon, Jan 22, 2024 at 11:54:34PM -0500, Gregory Price wrote:
> >> > 
> >> > Can the above code be simplified as something like below?
> >> > 
> >> >         resume_node = prev_node;
> > ---         resume_weight = 0;
> > +++         resume_weight = weights[node];
> >> >         for (...) {
> >> >                 ...
> >> >         }
> >> > 
> >> 
> >> I'll take another look at it, but this logic is annoying because of the
> >> corner case:  me->il_prev can be NUMA_NO_NODE or an actual numa node.
> >> 
> >
> > After a quick look, as long as no one objects to (me->il_prev) remaining
> > NUMA_NO_NODE
> 
> MAX_NUMNODES-1 ?
> 

When setting a new policy, the il_prev gets set to NUMA_NO_NODE. It's
not harmful and is just (-1), which is functionally the same as
(MAX_NUMNODES-1) for the purpose of iterating the nodemask with
next_node_in(). So it's fine to set (resume_node = me->il_prev)
as discussed.

I have a cleaned up function I'll push when i fix up a few other spots.

> > while having a weight assigned to pol->wil.cur_weight,
> 
> I think that it is OK.
> 
> And, IIUC, pol->wil.cur_weight can be 0, as in
> weighted_interleave_nodes(), if it's 0, it will be assigned to default
> weight for the node.
> 

cur_weight is different than the global weights.  cur_weight tells us
how many pages are remaining to allocate for the current node.

(cur_weight = 0) can happen in two scenarios:
  - initial setting of mempolicy (NUMA_NO_NODE w/ cur_weight=0)
  - weighted_interleave_nodes decrements it down to 0

Now that i'm looking at it - the second condition should not exist, and
we can eliminate it. The logic in weighted_interleave_nodes is actually
annoyingly unclear at the moment, so I'm going to re-factor it a bit to
be more explicit.

~Gregory

