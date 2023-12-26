Return-Path: <linux-fsdevel+bounces-6960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219D581F00C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 17:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DB31C219A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 16:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E0645C06;
	Wed, 27 Dec 2023 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="XUpGsCGt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43DD45BEB;
	Wed, 27 Dec 2023 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awVQTGJOPUkgtOirWMOaUZ0ET7zZioo+bfEUgjw21C0dXfJSeJOefvDf6NB+7uyipBnhw0veD4HZKeTKocfyLZIXAiSXGRoHCv7tzMWhh5EjKIiuhJ7j0guVhCEQk0X1oPBsVo4G7k9eiDTE02pn+B7O0rVBcif/uwwV2lljPrHV23Dt7VrsfRXOnLrTYRFUDMGpqdLST13DmoEoOVLVGzAA2URp5j1J3DNNt7xKbwCq71twy0beJ9jL2iA4pUSsG+SWmHrFelQ+rKbGohUPkCLnOGPYlZZ9pq57sna7RHeHViASpK8qTjwp5lxEvGZshgmcyFF3WOjI9iXoimItdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6XOEWugcZGK9J+zv82cKVOd8BoJBqNEzFzKijCIJjg=;
 b=oEs+RrxT9R9ovIeVXCX67MWpF+5YjdFDI3SRB9oZjFI7xX9mRFnnM9dqXARFv/DASxd8ekPbq46f/L0bVSMiiW2mwDMt5fGJ1ENKbhfe57D05bOYchX08tiMIioa5WdwQk02CLh8vXmWoh1RWIzvLfHxkyLo+Zih3qJ7cQVJWk3FX/reLunkMv12rR1gecUr4no3XL8IB+EnRTU+DwREyHizmK5Mw3+XRmK8CL/+3j/EshInOQFIw90tPTLKpjVAEqqo5TvV8mzsNRMQsW58Y8+g4GJMBep9dAWjh4Sb/UvhksU23NUog8oTcpxUqzp/ElfK6keSuxYmBoFRpFq8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6XOEWugcZGK9J+zv82cKVOd8BoJBqNEzFzKijCIJjg=;
 b=XUpGsCGtXtTwAvYZgZwaEVrA65qgAiRPoGbOOzUGwpe6oZQfKrRYJ3/l/cUD7Wb4+7gHctPFxrgA1FTHyGXxOnM8SXbxCcoBR6dOCXORswJ4gXJbCvib660QZ7WR5v8e02Rs5XyAQN8k3vUToAhmzKiS1bm8iDhQdPX1UWWYuc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH3PR17MB7126.namprd17.prod.outlook.com (2603:10b6:610:196::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Wed, 27 Dec
 2023 16:04:44 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 16:04:44 +0000
Date: Tue, 26 Dec 2023 02:26:21 -0500
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
	seungjun.ha@samsung.com, Johannes Weiner <hannes@cmpxchg.org>,
	Hasan Al Maruf <hasanalmaruf@fb.com>, Hao Wang <haowang3@fb.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Frank van der Linden <fvdl@google.com>,
	John Groves <john@jagalactic.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 00/11] mempolicy2, mbind2, and weighted interleave
Message-ID: <ZYqAHesihJ+XCCyy@memverge.com>
References: <20231218194631.21667-1-gregory.price@memverge.com>
 <87wmtanba2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZYHcPiU2IzHr/tbQ@memverge.com>
 <87zfy5libp.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfy5libp.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::16) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH3PR17MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 89af706c-6f89-4bc0-868c-08dc06f58ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2FCRcRwM0DtoGl9D+NVhahNiJMngu+t7WpC2o6Kwy6+J7J/AGm5SoUYxrHaSVBR9ZncuuO/BmbPQhd1HBlLOrW2nYf3qzowp+/vtLWGcKkPqGh1LI+rEnio3dcQ9WKWVphk5NqHKdSxz/pG6eR22/jIoOp2nB+Q43RlO3UeVnoYB6Htbg2oqv/HW21t9/WrL1FEdI6choWL4esJD9UcGJMmXqgtFhRgz51pmnv+CbjqnkevpvEsDLywLQyS0rA2iRs7OPcxoX9V8U5gBay4jDj5hm8qINlO7wSyj4flmke6js1TX2uXdtMZ5+22F56el+OAKo7AD1yq4AlX8TIVqzCEbKH8XDO2qIWH+jYdeyuOK7ZONI2dFfJwHHSGw8XmvZ6klk0CCUs8GgjulocLiz/uU+5deqOSvDdaad1rL33ANW7BlsgwF8EkstCSExek/A20FE3mSmSIt4v+7HgoBobk4P52EmB0qrkTYi06x7FQ4Xq7hIv4pxh0LzhtNPNVyXj4+1o15Z+2WL3hRxLnOXb7ZfiC9eeYsKHLnGD9ggnMNLL4MuZEK9U2GG7B00C1ivMyMLJhw6SHQ9kl0XQnz1VnX9o5o0fwKa//cfF3TiB1wozeVbnCKp4Zf8ThUd1Mon1XnUGUlkdckLDxEmRSa+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39840400004)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(26005)(83380400001)(38100700002)(8676002)(54906003)(66556008)(66476007)(6916009)(8936002)(316002)(66946007)(5660300002)(2906002)(4326008)(7416002)(7406005)(44832011)(6506007)(6512007)(2616005)(41300700001)(6486002)(6666004)(478600001)(86362001)(36756003)(16393002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q3Rsq2gvqakmX/SL9/44et3aJ+WiM0XEOvWdxFh3igEAr5hraQFINwQOViOS?=
 =?us-ascii?Q?AqvLEbwhrow7GSXW+LoRC1j7/+7prmi4/o5IPClcAvX4plF1CN1GLpIhsbsf?=
 =?us-ascii?Q?i+5RRRVecPRTT4gTg9KcDzobd7F5BPHQPFk0ehYF5tDLQzbSEwflBBevYm3y?=
 =?us-ascii?Q?1iQ6Mxqmg11yXIYK+Yob/zVXYawuzDgd6aes/7KPlS2QfX0fHuWaVTa6b970?=
 =?us-ascii?Q?Arvy/FGwc7eOAxeKZLdd8jGxmfOIXpNGqKm7bpiffox6Z6WOGGR7bZtgb/+f?=
 =?us-ascii?Q?7sUrhyTrAsyI7PlQvfqhqmtYU/a4qOlJpnBQClYWOWxsHHMqPzJQPggMTOsF?=
 =?us-ascii?Q?oe8cc5n3+7BMpqwxjCfcESVJ8P8lUdHztLYu+2fDp78EMJ7htYEHsZYidmGc?=
 =?us-ascii?Q?heWiI+M6k0Hr6Kciys5n6L1JtJCmlY5zaSHc3uyAPhX+4hbZDE08nEtoyTqA?=
 =?us-ascii?Q?ETRcMHm4Agz1WukZRNsXsNW8Q19H5wb9dC/ddjjwcF2oxm+kFZni3RcMyeSs?=
 =?us-ascii?Q?QXifaXFzCocMyC6eZf3DDAD8hTF8UNFkO3U4+Xt8uFPkmgoO0BAiD6I+XaER?=
 =?us-ascii?Q?EZpYEj0kGfuXNLfmCsU2Gx4T8tM3xluYtsnpTpAQ1RfdEWeXq8LfVdUzw9Bi?=
 =?us-ascii?Q?Br4MNcVUsi/ubJ4PxczLM7SGCfHvDQgY2cKc8Z61rpUUg6QCGGBOZthR3DBK?=
 =?us-ascii?Q?4rR4vhpCc1cT1xCwGx6v6EHURnhXjK//wO/B2LH6aCQu9Bzg4vkeAKbcDjFY?=
 =?us-ascii?Q?iDlJTzbXJnUGMT0Far4mYjZhFDgYM4/uDFJYS4qhwnIWXqP734vL4hwtsLIs?=
 =?us-ascii?Q?ePezZoN3CosJzgt8MKAOWCnJFAewkO4v7NYuUI3Gw5n4/2HnKYENSbKDcTaM?=
 =?us-ascii?Q?FNmXHlq5Vj/Zyhc4icogljnGqYHSwDyJwlmEDUNUSIvKXH7PNAmf8CtBj8BC?=
 =?us-ascii?Q?kl+YRfYg2cVeQwjmIz9gtNhezZfxAeGLWydl+DjGbAR4/hCryhX5mzTEkc8H?=
 =?us-ascii?Q?qjGwfN+jF4r1EjS38vhYbZUAgE21Vd+VZfgqqG1p7+7gOxAOan9gl4De4S0M?=
 =?us-ascii?Q?PhJwujK35AiVkfOQ1jZJdGi66cEeC4eXkLuDo0bUc1x2Ljzl0W2EuqHBitIl?=
 =?us-ascii?Q?BQhs5ppWiv1xN5HXMg2kjmPV09u6yPJBqc20gE6Coc2knpGt4ooSOnam1hip?=
 =?us-ascii?Q?bqK5+3Bnw0ANSf8Ku5W3PC6J/omPxHPnTxZfzqfHCTYxbGY/DFaOcj4lk6mg?=
 =?us-ascii?Q?i6e9rB8Ua7AVkP3vIbfs+YZkk0A9Xm1Wp5e0h0VJ3UrjgRCASc5bK28LlhBK?=
 =?us-ascii?Q?7qk62M+qYv5jQAU/qedqjf211bp2W6PSrq72LqqrDH6tUHqfr3taJXcy7Xmj?=
 =?us-ascii?Q?yLNj0BI5duLX3WlWEW5bxvSom931TlOY9u6v2o/vGkYQNYLSC5bg9joyEbkz?=
 =?us-ascii?Q?GWk86oPIEGuq58BM/HU5MNtJBpyG/HRhV6g3VuWDlY47oVnAH1tC15LVZB+Q?=
 =?us-ascii?Q?PlPdmg1oDLjHnIp2eIXq85hmoY8ABslHuQ3DM9r25NiIpLd3hQ2LgMG5OPbl?=
 =?us-ascii?Q?VES5BgEeYJ0yDhwBRGto8x6jX3OudKSEbQiMwqneDyups8L5fXp9bBfbl26d?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89af706c-6f89-4bc0-868c-08dc06f58ada
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 16:04:44.7442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xvpx8QNvf5bTI2jcV1GvQTohpTJ73hpUIU/kqPlwlzrMmGu4yIsDnnJ3eVXOIuBe1EHpTQyM33mPZas3/MzKX0N3rEZCPr5s+lFrqskghPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR17MB7126

On Wed, Dec 20, 2023 at 10:27:06AM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > Assuming we remove policy_node altogether... do we still break up the
> > set/get interface into separate structures to avoid this in the future?
> 
> I have no much experience at ABI definition.  So, I want to get guidance
> from more experienced people on this.
> 
> Is it good to implement all functionality of get_mempolicy() with
> get_mempolicy2(), so we can deprecate get_mempolicy() and remove it
> finally?  So, users don't need to use 2 similar syscalls?
> 
> And, IIUC, we will not get policy_node, addr_node, and policy config at
> the same time, is it better to use a union instead of struct in
> get_mempolicy2()?
> 

We discussed using flags to change the operation of mempolicy earlier
and it was expressed that multiplexing syscalls via flags is no longer
a preferred design because it increases complexity in the long term.

The mems_allowed extension to get_mempolicy() is basically this kind of
multiplexing.  So ultimately I think it better to simply remove that
functionality from get_mempolicy2().

Further: it's not even technically *part* of mempolicy, it's part of
cpusets, and is accessible via sysfs through some combination of
cpuset.mems and cpuset.mems.effective.

So the mems_allowed part of get_mempolicy() has already been deprecated
in that way.  Doesn't seem worth it to add it to mempolicy2.


The `policy_node` is more of a question as to whether it's even useful.
Right now it only applies to interleave policies... but it's also
insanely racey.  The moment you pluck the next interleave target, it's
liable to change.  I don't know how anyone would even use this.

If we drop it, we can alway add it back in with an extension if someone
actually has a use-case for it and we decide to fully deprecate
get_mempolicy() (which seems unlikely, btw).


In either case, the extension I made allows get_mempolicy() to be used
to fetch policy_node via the original method, for new policies, so that
would cover it if anyone is actually using it.

~Gregory

