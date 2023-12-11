Return-Path: <linux-fsdevel+bounces-5526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC0780D276
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7712D28107A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8070E3B785;
	Mon, 11 Dec 2023 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="Ryf8/I7U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDB0B3;
	Mon, 11 Dec 2023 08:42:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7XZUPDtxyB7zcSDA0VLhya8ozo4tnCIEwY/A5KU3QOvLqWV/V2FL7OWhmohqGHllzBupic0N3xm+93OjFGUOLvD1AlXyyJUN4F3206U2J/9dDdtv10SaYL2KOYcJJiHKvZyEstWup0hgUw7z3Qcw1oD5RSDgm8mbDEOGNe0BFdTdzMyIf72nqdX5xR5CbsCK9pUtMndZosfpNLJnC4949Zw0PaDxeLM/sXj3LQyr3Na4u2TzB+Fwmpl3TPa+J0NKzd/DEovpJOzxAQgBJQhokV/eDMZhQtD4IByehHaPbTgYzkJlekWsVJXCy/WsS9mxpZsKRDRgt7c615FyNHUcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbV9N7mUMX45hSh1DHcgLbAg1typCMcIHV7LlMHJabA=;
 b=Rkris1wKWotBhk3PKFxS1zKjQAQR2vTNnVlI3S80Vkv1pu2FX8E0bliAzzkEKPjQbPCR6x9tuF4/xBuWoGSNPY3vbknU1g3eqpVEfzumF1NMaBEnoyLzsVKrn6oKku3xftklHMpLwEHhtiNXwep+1dHZJFS2wtNCuBHq2eWVB1tzvyBRFaPUxhK6TryMuZwO5HUoAbLOxZWAJR6IeT+7xGmdnJLn98NhLwSAdCaWSuxKM2Amoyax3u9lW1c4KteWe9qov9l0GEjTLZ4MmpO1Mi7CJFYJSNaR3Dhsg6ay4BdUik5Ist0YsmygQyGYXBumhV3dbgQUwS2JLl0CIbxkVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbV9N7mUMX45hSh1DHcgLbAg1typCMcIHV7LlMHJabA=;
 b=Ryf8/I7UHIYN1e6bi6NphGYcxe2n10kBuAADdHSVKn9HHI28xBl2KuKLpsv21s0lHrC32781Hd7V290jlVtsJjm9RzTnfArrHxO7Crja88GxcD43GfJ7aWoTYfd4peHfTFF97qajMmwZxpvYkkTAF5piLUPZ0TFJutoRxwZtYqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA1PR17MB5153.namprd17.prod.outlook.com (2603:10b6:806:1c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 16:42:23 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 16:42:23 +0000
Date: Mon, 11 Dec 2023 11:42:11 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	arnd@arndb.de, tglx@linutronix.de, luto@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, mhocko@kernel.org, tj@kernel.org,
	corbet@lwn.net, rakie.kim@sk.com, hyeongtak.ji@sk.com,
	honggyu.kim@sk.com, vtavarespetr@micron.com, peterz@infradead.org,
	jgroves@micron.com, ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Hasan Al Maruf <hasanalmaruf@fb.com>, Hao Wang <haowang3@fb.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Frank van der Linden <fvdl@google.com>,
	John Groves <john@jagalactic.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 00/11] mempolicy2, mbind2, and weighted interleave
Message-ID: <ZXc74yJzXDkCm+BA@memverge.com>
References: <20231209065931.3458-1-gregory.price@memverge.com>
 <87r0jtxp23.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0jtxp23.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::7) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA1PR17MB5153:EE_
X-MS-Office365-Filtering-Correlation-Id: 1595f734-67f7-425f-476d-08dbfa682662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UZD4ZNW7ig17h0Bqh7Js/AwBYXaghw/Arst05tKYRJNwts31zZYhZZaUl8k6RwrZIAMtmWhMKPOuHXux1C5K5y535l1CriyBGysQ01TlF9GeiNbIbAKkwL1xS/Kc38c+e+r+W0BSh5MTl+FYOe9/Hn2+HiEPo33WNbjRgRVvkIQEXpYGBKe0aYGZ3dLUtJWMeugoE2rOR59M6knm07ASgQhGoOyj4zTbyBWPwHLnwkMwfrSvMlZswQWT/cvWK2b8fNADqS7zlHRPsyvDKTxjovFdqZE07/2pSJDPj7UlLFZDcFVXqmxvnblpFydYKvTYh9tMeeHIrB3uh6cXVjQK93ROtK9fBhjyIsrotN1vPZ8PKaeOPvh9SMus2JC+JJd55fTxksnVvyB7YhDCLvJOWqv8FOufyb2cNgXKOTOIVvbw80WO6I3EPxUsAt5F0O6Zx4p+2eyDClPbvtl1cFwkxLRP4fvl4x57zKFGE3UHQCQAg4lT+4FhPAQlaAC+GEpuTUQD8swqwAleGRnItW5VBxs7pZKe6NWHNBRngFJ2xVCxZo2RXgfoSOYp1Pg3eGnQuejZ0jsIlNzBF4wWqzxgrKkhJtf09+gBFSxs87macNUk9k7zkzER2Dy0tpiuafDYRI7WdDwKcRWZ+Me4+gVMvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(346002)(366004)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(2616005)(6666004)(6506007)(6512007)(83380400001)(7416002)(7406005)(5660300002)(44832011)(41300700001)(2906002)(478600001)(6486002)(66556008)(66946007)(8936002)(66476007)(4326008)(8676002)(316002)(6916009)(54906003)(86362001)(38100700002)(36756003)(16393002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnpjcUdRaElmV2VVMWdOZXZUUEJ2QnRiZ2xnKzhmdXVUTFExWEtPS29HVWxu?=
 =?utf-8?B?NXdqWXNRWHJ2enFsYXNPS3ROVlU3N0ZjYWpPdHlTQUErU1FqVWNTY2ROd0du?=
 =?utf-8?B?aFlqOTRrdSs4dDk1ZDBwQWF6dmlWNDBLOGxUWEt0bko3Y3EwOGZRR3NhRk1j?=
 =?utf-8?B?TEFOOUhkZTVtd1h5cng3cUhiNXJaU1lsOW5RUzBnYmUrV0pvMEpENWRqU2Zi?=
 =?utf-8?B?Qi9XeGRHRndwd2RSMVpqTUZaemhUSEVyd1VjZDE4WmxGbUhWalZ3Nkx0NUNw?=
 =?utf-8?B?Q1Y5MWt3SFdVTE14M00rU3FpNHBOTWVhT1JSb011cjZVOXovZFdlakpIUXFW?=
 =?utf-8?B?RlVpVmpOS01rRFcwaDlxWTBENlU5dm5RUFk3TmFpbCtSd2sxNWxrb1ZxMkF4?=
 =?utf-8?B?Ti9ZYlR0ZkxJZ21tbEkxNjVhdTg5YTNXd2xUc3J3RWJ3OEdiSXorL2p6Zk16?=
 =?utf-8?B?RDhFMFI1QTlrM0xWa05qRG1USEhyd1ZibDVyU0hvZysrNTIxL2x2ZDhMVzY2?=
 =?utf-8?B?WGRpVHRhTEVuVjVHelB5RUFOUWs1RGw5UTU0RjZSTVJSZkNzZ3FuNklrUUxo?=
 =?utf-8?B?bEFMTzBPaWdMcEI5blZMOHNrcFk5N0xTU3Q0eFFwYW1yL0xQN3Y0aFBxOU5Y?=
 =?utf-8?B?Q0VoOUZSUWFuNW8zejFVR0VkTE44aEhscGJWL1crUkNJb0NMUXJkMGRxQytr?=
 =?utf-8?B?dGJwOEM3M0szbzZBZFlXdkMyMXR5RnRoNEdFMXFiY2MzUzYreWZ3ckV5Vmhi?=
 =?utf-8?B?M0lkRGRVdzRscEppSXRQSmtoMEg4cERMQnFrWEcwVXlxYW5ZUlMyeDczbDlH?=
 =?utf-8?B?KzhQZlEvai9KUDIvRjdncit3UWxDWHpXMUtaTEM3dE93aHZCSFJKbGRCNmY3?=
 =?utf-8?B?MDJBVHNwVTFpY1I3dTRPNDc4UDhBNHNYUWMxWUZ2TUxaU2c5UllkdUZOOVRG?=
 =?utf-8?B?dlNYb0gyVjMvMXkvejBKMy91d0F1UWkvZ00wUFh5WnJqRXlEdE1wM1hjbDlS?=
 =?utf-8?B?aHFnVlV4NnhFMG12ZU8vckJsMjNwRUdwV21OYmVaOG1DSW5oQ3RFVzNkcU1W?=
 =?utf-8?B?K2pEbnpjMzdqSUwrUUEzMm1RK3hLZUxERUlYVjBkdGhlcjVkMTh2Q0pLVVBC?=
 =?utf-8?B?MitmcmkzKy9xclkrc2dXb1lOVVAraG1BYSt0RWNxSHhGZkg5dXpJMHJ4blRI?=
 =?utf-8?B?YkpiWWp0THVHUGdhOEdVWm9PbVRodDJ5Z3p0Z1ptNitGME82cmRHOUJPODlB?=
 =?utf-8?B?M1ovS0Z2aUh3UzJSeGZROEJ0MXVYYmZsNXYydis4Y29QZlpRelVlU01OdzB0?=
 =?utf-8?B?c3JTTlpvY29aNHJUczhqZmU5TWhBcVBFWnYwQnpnczB4c2dhaFB6cC9TcHhJ?=
 =?utf-8?B?TjJEQzZCYjEwT1o4VURYQTc4ZmJlNlVNTmhCRnorb1FjcGdSaDhOODFCSzBL?=
 =?utf-8?B?WFg5c1NVVjFTdHhCYzMwT2JtVUg3SFAvZnVpaUcrTHZEa3JvTTJtZGx1Nk5Z?=
 =?utf-8?B?dVcrdGFrR3Z2b1Rhd1Rka0dGVUVUdkZvdWR5VzVrWENZRlpzSmlSQktXeXlZ?=
 =?utf-8?B?WFFPazN3N1JsYVJCVU5Rc0d4bUptMlVEUFM2aURnVHcwQXlOMlU1ZU14Zm9L?=
 =?utf-8?B?Q1pCM1RjSnpiZ3pDVVl2VWgrQzlwYjRPNllDM0g2ZU5hUDhTK3Q1OUg4bE95?=
 =?utf-8?B?YmNUOVg0MFdaL0k5djhLajJvRkFmT21pbTFoREluMzRRVGxVR1Y5OSs1Yy8x?=
 =?utf-8?B?ZWEySzdYTkkrc2xjbnNQY294SFBYVXhaa2tLVEFvbFRjMXZTMERFMjhYUk9U?=
 =?utf-8?B?NHg0S3RHMklLeEdXNXVhR2lOUjBxSkdQZ3Y5QnM2eDMwZmV2elV0ZUFCVlRk?=
 =?utf-8?B?ZU80Z09USjgxMlJ6YTlmWTFpWTRoME9YM3lMQ2YrRko5ZlRtUG1WQktpVTBt?=
 =?utf-8?B?SkhTWmJJaEhxL0s1TlJoYldENXdmMXdjcEdISnpISkl4Wjl0Nnh6SUZJMDhQ?=
 =?utf-8?B?bkFtV2J0aXJMcmlJL210TTlzZDZjeEgyb0ljTmxkaDUxeHNFbkNsajlZREx5?=
 =?utf-8?B?UjA3RWJpWTVnR3hyRnZMKzRqYzUzb2JXVUxwU0JMdlVjU2kwWE5wWE1HOGlV?=
 =?utf-8?B?MlluTHk3OGRlUnJjWUI0NWRtV1Zob3M0VkRoNTBCYlZzbDJ0MDlyaWJRMzdy?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1595f734-67f7-425f-476d-08dbfa682662
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 16:42:23.2960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RzyFn5snwPbSwdiIPqj0NNIVi/btGEysfGydKaKmb78RviGejuIMYOfkFM7tg7PNS57LwrD6wJDQ5hU+AoWA5Ka1bJTXUjUZfG7oVc/V3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB5153

On Mon, Dec 11, 2023 at 01:53:40PM +0800, Huang, Ying wrote:
> Hi, Gregory,
> 
> Thanks for updated version!
> 
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > v2:
> >   changes / adds:
> > - flattened weight matrix to an array at requested of Ying Huang
> > - Updated ABI docs per Davidlohr Bueso request
> > - change uapi structure to use aligned/fixed-length members as
> >   Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > - Implemented weight fetch logic in get_mempolicy2
> > - mbind2 was changed to take (iovec,len) as function arguments
> >   rather than add them to the uapi structure, since they describe
> >   where to apply the mempolicy - as opposed to being part of it.
> >
> >     The sysfs structure is designed as follows.
> >
> >       $ tree /sys/kernel/mm/mempolicy/
> >       /sys/kernel/mm/mempolicy/
> >       ├── possible_nodes
> >       └── weighted_interleave
> >           ├── nodeN
> >           │   └── weight
> >           └── nodeN+X
> >               └── weight
> >
> > 'mempolicy' is added to '/sys/kernel/mm/' as a control group for
> > the mempolicy subsystem.
> 
> Is it good to add 'mempolicy' in '/sys/kernel/mm/numa'?  The advantage
> is that 'mempolicy' here is in fact "NUMA mempolicy".  The disadvantage
> is one more directory nesting.  I have no strong opinion here.
> 

i don't have a strong opinion here.

> > 'possible_nodes' is added to 'mm/mempolicy' to help describe the
> > expected structures under mempolicy directorys. For example,
> > possible_nodes describes what nodeN directories wille exist under
> > the weighted_interleave directory.
> 
> We have '/sys/devices/system/node/possible' already.  Is this just a
> duplication?  If so, why?  And, the possible nodes can be gotten via
> contents of 'weighted_interleave' too.
> 

I'll remove it

> And it appears not necessary to make 'weighted_interleave/nodeN'
> directory.  Why not just make it a file.
> 

Originally I wasn't sure whether there would be more attributes, but
this is probably fine.  I'll change it.

> And, can we add a way to reset weight to the default value?  For example
> `echo > nodeN/weight` or `echo > nodeN`.
> 

Seems reasonable.

> > =====================================================================
> > (Patches 7-10) set_mempolicy2, get_mempolicy2, mbind2
> >
> > These interfaces are the 'extended' counterpart to their relatives.
> > They use the userland 'struct mpol_args' structure to communicate a
> > complete mempolicy configuration to the kernel.  This structure
> > looks very much like the kernel-internal 'struct mempolicy_args':
> >
> > struct mpol_args {
> >         /* Basic mempolicy settings */
> >         __u16 mode;
> >         __u16 mode_flags;
> >         __s32 home_node;
> >         __aligned_u64 pol_nodes;
> >         __u64 pol_maxnodes;
> >         __u64 addr;
> >         __s32 policy_node;
> >         __s32 addr_node;
> >         __aligned_u64 *il_weights;      /* of size pol_maxnodes */
> > };
> 
> This looks unnecessarily complex.  I don't think that it's a good idea
> to use exact same parameter for all 3 syscalls.
>

It is exactly as complex as mempolicy is.  Everything here is already
described in the existing interfaces (except il_weights).

> For example, can we use something as below?
> 
>   long set_mempolicy2(int mode, const unsigned long *nodemask, unsigned int *il_weights,
>                           unsigned long maxnode, unsigned long home_node,
>                           unsigned long flags);
> 
>   long mbind2(unsigned long start, unsigned long len,
>                           int mode, const unsigned long *nodemask, unsigned int *il_weights,
>                           unsigned long maxnode, unsigned long home_node,
>                           unsigned long flags);
> 

Your definition of mbind2 is impossible.

Neither of these interfaces solve the extensibility issue.  If a new
policy which requires a new format of data arrives, we can look forward
to set_mempolicy3 and mbind3.

> A struct may be defined to hold mempolicy iteself.
> 
> struct mpol {
>         int mode;
>         unsigned int home_node;
>         const unsigned long *nodemask;
>         unsigned int *il_weights;
>         unsigned int maxnode;
> };
> 

addr could be pulled out for get_mempolicy2, so i will do that

'addr_node' and 'policy_node' are warts that came from the original
get_mempolicy.  Removing them increases the complexity of handling
arguments in the common get_mempolicy code.

I could probably just drop support for retrieving the addr_node from
get_mempolicy2, since it's already possible with get_mempolicy.  So I
will do that.

~Gregory

