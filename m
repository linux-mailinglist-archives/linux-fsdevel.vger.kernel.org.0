Return-Path: <linux-fsdevel+bounces-7151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B6082271F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 03:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721D21F22F30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 02:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF3C4A17;
	Wed,  3 Jan 2024 02:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="GtX79Qgf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD2246AC;
	Wed,  3 Jan 2024 02:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ci3GiM676QhWZiOW7/tqb5lNVe0uirR8vSqaEd0zT0Hujv+EFCGZyj733/QIRP8KxcZQ0nCwThYDmcFW8QO0vd+4ZOWK5YHKNxjF/I8fqJHaTlITHgubduEqnP+fglaPxYjM7rgxaGv9NajMq009wO5mqf8NgLP9R0VHmAx73AIqSOQpgYQGkx0p44upO/7uhHOrAVZSIvlIXohGb9gkrpLSecvdGhtp/y2j8bFcGxK5l/aO6ei6MAEls/0gN0l7U8aMtCbcD1Cx2FQ1bNsZVaojJbCLxq+thtzSkk9ZxooJ3jJw4rGTrt8dxpQxTk5MYUnUghlpRxlMGavBUsAa6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duisZm1qU002mNWUIdgkohJWndIH0l6aVZwBG4Ef+z8=;
 b=mL/Adn9WaTLEbAycF3f/Y4nN4bBj0638+XQqntcWQPo0Wm4FQsWHB8aZ26f4/A1RyRfWW5XmWENFb5ExDGmp7fACmEktbQlenYbXql8RpUjouj7hg5LgrWtG96UM0BWRKIrDzARuw7Kb9owp4Q6hp1NjNSYi0zSiPLmsSB+cor1BjWWKl4eBzmvECt5j0rXc+vYGKMtxwiTyZar0FRdN4v6py6yV3VejErMwGZOzm6icJN3tc+iuGhzfgDradQcbaz3XAZTpR+Bed7+Yxw5Lp852ZLQ8GFf9vmWjHB/jubjFGSjVn74QNWs+qPoFwy3UXcNYJPct8jstkSlphPFOjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duisZm1qU002mNWUIdgkohJWndIH0l6aVZwBG4Ef+z8=;
 b=GtX79Qgfy1WTDnQ2MgqpzFx1D0S0Ss1pw/QpWfyc//eEoyx8zGcRt+Z2Clqn4qdu5r+S8ELKczI6RAYP8sl+0DHO3ScJhyPjusMBT3pNRnk2CUNvn81fkBgBUqyIfPiORfEKIXASnBBO4sVhEhRQ8UZGHdjr0tijgsMYZN6BlkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH7PR17MB6563.namprd17.prod.outlook.com (2603:10b6:510:2b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 02:46:48 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 02:46:48 +0000
Date: Tue, 2 Jan 2024 21:46:38 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
	tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mhocko@kernel.org,
	tj@kernel.org, corbet@lwn.net, rakie.kim@sk.com,
	hyeongtak.ji@sk.com, honggyu.kim@sk.com, vtavarespetr@micron.com,
	peterz@infradead.org, jgroves@micron.com, ravis.opensrc@micron.com,
	sthanneeru@micron.com, emirakhur@micron.com, Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com
Subject: Re: [PATCH v5 01/11] mm/mempolicy: implement the sysfs-based
 weighted_interleave interface
Message-ID: <ZZTKjn3kngYPYXo0@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
 <20231223181101.1954-2-gregory.price@memverge.com>
 <877cl0f8oo.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZYp3JbcCPQc4fUrB@memverge.com>
 <87h6jwdvxn.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6jwdvxn.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BYAPR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::42) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH7PR17MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: e3baadcf-84ab-4071-7f4a-08dc0c063b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9tveMtsGlMFwVqICh/XO+tY6Glh4GPDZg2Uk+5YiFuAY4eyLKnbxQfcqyWFa3QqRQTIx1wWNAXw5O9cKH1ueVENgZ2d0BB0NHNwVNTwHqPUIUQJJLds7mEj5r9Wag+sUBKapatT+QxB2hUTMLxUI5Fjk75Jomay+CRRxV/OkNefzJ+0R5yJn0/HdOMPIBVwzW0sMIWYakbK0OpbAueLXcEjyO0RmSPWCFUKOpCUpF6ZLR3KrNjzIdLdpnQmtVab0ES6YJsuNAUyYyjzHRM1Knl1BaLA6FXmB+rajmp0WDVKloaGlZbxLO9fkqBtDetVc+/SyaO2mwghZeCS2j9VvD2i1MtBtjF2AQg/M9L3ypyTzL1u0oft4FJ4SJud45OvyF09tDaRwauD5RLvFWFhsChiYRs3IP9vsFYJ+Icv+dAjoAoxPJ+0NWZMLfvjqBrC7ZIISPtlcG3cvy5URCCcrd7/RUvypSXZurs/86Rz90V97q7N1e7i2a6wzxm+9puyHDSMe122QK5ni5SLRFzxHL+G7hoWmssD2SYpv0scDrc0hqVMBfwspslqqWeh2UoP+9yXZu+UlQH39f0f7sqBLO5n7LUsnFG1J1wcKb/w4QgrK7ZjY24E/bret0fLnmnd8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39850400004)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(36756003)(86362001)(66946007)(7416002)(6512007)(26005)(2616005)(6486002)(66556008)(6916009)(2906002)(6506007)(7406005)(6666004)(478600001)(66476007)(5660300002)(316002)(44832011)(8936002)(41300700001)(8676002)(4326008)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VqogLsjiCk2qnKiB1YtVyxkzuTcEaT8B1pa/JYsGIYG+4ealg6zNu3ibFIuM?=
 =?us-ascii?Q?FmTPBOpm52Ow4iaac+XI+YXubtCExosqR2CvwE2gat1UMsoF4ED2obmE3rHQ?=
 =?us-ascii?Q?SWk09i7ARKuMl2SdHvl2W0LXB5rig91HCe0C8I3E2KnVCLtvsmOMaPOox5hC?=
 =?us-ascii?Q?Y/hOMiz3vlrA6LS4rF0Gc7cgOuqqZyYfhg1R9wQ2APnI17u9svwDFWq8Yptm?=
 =?us-ascii?Q?iKuWaew/noPy+PAAdklCZjF71Wfpv30NqgM+LXYB0dBAO7cBtLitCLsnuw+w?=
 =?us-ascii?Q?JRBZjQI9fPG7rkX0kTG8Rw394LIzVFZUoO62LZF9llS4KnhM5px0kvbOtGr7?=
 =?us-ascii?Q?Y+hsaZEnLbTd3wGab3uy1VYCTAdWaR3bdk8agFSEmAa+wBURzBDuG0YCxC7h?=
 =?us-ascii?Q?1NXwl6VTKy96TOY0CJlRvi5l3jd7htn5QOxHc1HzD1YFaQiao9OcN+iX8SRJ?=
 =?us-ascii?Q?JbacBf9RKQ4dcx0awtQq50bdBM/f/ir//V8zOSI2xqWzN/8iuaC0Fhccen7x?=
 =?us-ascii?Q?p1ZWfCmRWjtO1Xn1LzbIjeqNnQTDp6QDNQG7esSAguYQsmq40vjINAmBPabY?=
 =?us-ascii?Q?r2uA7ScYzmeLs4sfeLyYm07nxJf7fluPBASaPdhlSV0byGTTEkEUumQdzfXp?=
 =?us-ascii?Q?2/ONhWsgqRzb48YO9bIWi0GBH13ft8kMD5udkJqNliEn5NbRWe3ojs5TeVdE?=
 =?us-ascii?Q?y7GshFQ/aqp9so96I5ONPAKCUJLspKaAvG0C3QPaOfAzDKpsiZEBiABg+Kgc?=
 =?us-ascii?Q?iarka/NTITIj+eVmfXEiFUvNIXD2Bl+77FN9LFSnLVEwDB3ujOxnGVpIf5wc?=
 =?us-ascii?Q?AigAoC7/+xpIhlNa+Qb1OTlYfB7lLa2LRjPyKFiYmRZm/JnC29VGxSlIYQJg?=
 =?us-ascii?Q?Daz/tutIZRY9l+f8j4yWaMPYrMz2pFlFgaWIiH4nLWklxvZ5rePtcO1IwcMO?=
 =?us-ascii?Q?izuweh36UzdDpzyJltcPaDJArMoLOOZ1OEb+2LVRBT6o3r/FWET06ThTZUA3?=
 =?us-ascii?Q?KiAXKBEKLPE4GhtoUgUxma06C4qP4jCUvSjUJ6dXpnSz2zvUGeIGultU87SL?=
 =?us-ascii?Q?h/8AX1jSfcfKph0V5jVadxedLfCKjz6fNGBzKpV2I9NwfxWS8FE3mIkP/Unj?=
 =?us-ascii?Q?k+qOdTgjWH9W4yZzBxzAvd/y2C2G6WYloKp/+3/IDWBWALbXak7T3Gqu2VUj?=
 =?us-ascii?Q?37Tm1HLwkjY4N1kE8uEGu80uj/TX9PBZsS7n0WAAVLbxmrOt3Uf4pOjhn7Zd?=
 =?us-ascii?Q?rFJcYB13qD1/im6sVo23iE3b1Pw2qw9zeyqMAPiX4/roS+jlbVXXcOnI/BN0?=
 =?us-ascii?Q?9dbbBP3kITt6f2QzjVO0wiRgU1c2oQxH6K7UHwhWj8wIeTlDmeRy1ld9gVxH?=
 =?us-ascii?Q?Q9GlcxwtZxqDgiWCo/oomtqkvu92Oyg7bWM+J7E9peJqBmfwim89qFiLOkAj?=
 =?us-ascii?Q?MEtA5pUTDgOLdReaEQYLkyqP+intOEKYTiCM5dNNbk+95pKfricw1B1g98uv?=
 =?us-ascii?Q?LSPFQq/s2V93uoTtyykGi6Y5tywZzXvCtYm8VH8WNNAGw4mnV13yzNlPmfaW?=
 =?us-ascii?Q?rmChVyVpkfdXl98iYlZDlQbjkRzAHOWx/CFdfCYXVeWQPnFPSS3ugPy+m3TL?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3baadcf-84ab-4071-7f4a-08dc0c063b14
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 02:46:48.2370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJQhAfnQRNInSCiB6D3W6Vshr0rHpCA19HGR/I8VUasX1RODI4hW98pt9PK37a+5uJRUBgnCDU3IWRHjGwy1IjnBBEQp8EHXizh15m8t8FE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR17MB6563

On Tue, Jan 02, 2024 at 03:41:08PM +0800, Huang, Ying wrote:
> Think about the default weight value via HMAT/CDAT again.  It may be not
> a good idea to use "1" as default even for now.
> 
> For example,
> 
> - The memory bandwidth of DRAM is 100GB, whose default weight is "1".
> 
> - We hot-plug CXL.mem A with memory bandwidth 20GB.  So, we change the
>   weight of DRAM to 5, and use "1" as the weight of CXL.mem A.
> 
> - We hot-plug CXL.mem B with memory bandwidth 10GB.  So, we change the
>   weight of DRAM to 10, the weight of CXL.mem A to 2, and use "1" as the
>   weight of CXL.mem B.
> 
> That is, if we use "1" as default weight, we need to change weights of
> nodes frequently because we haven't a "base" weight.  The best candidate
> base weight is the weight of DRAM node.  For example, if we set the
> default weight of DRAM node to be "16" and use that as the base weight,
> we don't need to change it in most cases.  The weight of other nodes can
> be set according to the ratio of its memory bandwidth to that of DRAM.
> 
> This makes it easy to set the default weight via HMAT/CDAT too.
> 
> What do you think about that?
> 

Giving this more thought.

Hotplug should be an incredibly rare event. I don't think swapping defaults
"frequently" is a real problem we should handle.

It's expected that dynamic capacity devices will not cause a node to
hotplug, but instead cause a node to grow/shrink.

Seems perfectly fine to rebalance weights in response to rare events.

~Gregory

