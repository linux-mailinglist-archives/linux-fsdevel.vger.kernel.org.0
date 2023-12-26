Return-Path: <linux-fsdevel+bounces-6961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAFE81F03D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 17:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF41E282FF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 16:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D1945C18;
	Wed, 27 Dec 2023 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="HPDU71Nm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E9445BF9;
	Wed, 27 Dec 2023 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoDHcm9ySJ7WN51Rqm49aRBigfK6xOKD9Ux3nnIZuhLJz4LCpBiMXp7eWIU1ipz4tP/NHCTle1nvRs9G1qKdYmrUn7F4qcdy1N6otDfi5wXWKvvZFAQguYGVNmsNbUJ+LLGJpNIFh/BJlmNOKKyTQxVsrxZC1ueni7ZcJ6DmkgVch2N7y6srWBNGWwi4iUifGhSxmP3lHhtigIJI9v901E9bOfc4vzHI9MI4IxvL249rDEkSAjCcS1xso65DM9gBaXUrb1RVY+l2l7sXUVlKmzRGsnf05/4EBPKdh1PTmXTGbB46ZzEmZqPQgESYKfTVOsAn4LA1DOasMVze5rTVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPdSZ3wzhqFjSlR4l/lPUXQ+naNPFoQsQtaZD3rTkoo=;
 b=mOWmZzzzFt736x8RzQTpYd9gDvuvoc6gWeIvuAGgEWAgkiDGSPqSrFxNGboFVOjizicrBvAWaFHVaMKDPaFxG4zH8aCO7ApFOZ/KOn69mYn12CY8NodF6DLTxCIgouYI9FT6gIxn3np5h1oy/7Kt/BhexLjRJJrUQI6EEEL4vdpUSoxLSSAFiuVHrxxcMc1DjybDzgh4PY+FNXTUqa02+3CqhpMLgGJcjEUYTgQb9uJFsdurPkw4eQp66UuAjwHbHOGSPp5HtSKUd2pbCoTUJpL9pmpZcrMcSjJKDhoDM+PMAAblMXoKN91f//g4gH9N2HV5qbzD+z9aDr7v5oT0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPdSZ3wzhqFjSlR4l/lPUXQ+naNPFoQsQtaZD3rTkoo=;
 b=HPDU71NmbCujlxRcjSGOXgcdp6J8u1+4RDpLoENjcmUxyAd8WIM/VZ/liMhqcEGMWqOeU9Ss3419BAKowYP/oiCzZK+9R58D4RTNqY88DIKggrPNrF5mRHux44Zbi3Ahgxt5EZeyeZ28mlcfeJ2/iZzCVUARSPK4zjldxCGiW/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB4725.namprd17.prod.outlook.com (2603:10b6:a03:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 16:22:15 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 16:22:15 +0000
Date: Tue, 26 Dec 2023 02:45:18 -0500
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
Subject: Re: [PATCH v5 00/11] mempolicy2, mbind2, and weighted interleave
Message-ID: <ZYqEjsaqseI68EyJ@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
 <87frzqg1jp.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frzqg1jp.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BYAPR01CA0007.prod.exchangelabs.com (2603:10b6:a02:80::20)
 To SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB4725:EE_
X-MS-Office365-Filtering-Correlation-Id: 280b7e9f-d8c7-4a40-dd94-08dc06f7fd09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PkdJPdcmHA4NtPVpZoTmsjiWo8msjeclDXSVZ2O6wbFU/YvgF4fizZ87OnlLlD6CDYlTITz7//kfTdQ7cG/oaPj3OhJWUQ/jNsLKgwGxKWDuQIsDaMkTpK0/M6EmJuvnw+cRTddEX+wYFAr00bP7UqDhYdhzbIgzuVdv0uEQwI0vWhCBcD9vpqv4DLkPHCg2j1CClt5gp/nMPguzUBTP7oQ4Wkakv68ADtNPvLls2BioaLIMWOf0vL2vlQWyem/fnTABMtYDdVnBE7Bs3COKHbGapqKMglwOrnODpEEPqY7ylBmIF6l93LZM2Mz/vKmtyAIz9K1NFSCy1HPHoFYQQ7fzmFjjeIrvyPJBRvwGr3Dmkqo0oNhWjTWzGVmRvimlBdFTTkJ5UANbiZh5xfDh3jq0/CGwEwAS+UtfcnUJ3bLqko43ziRTBP8DoS2NcXMKxRKvrusIprwQpE3649MBm/wCjE14VlAl5e4rXu9Xzj1UG1B8k2qRPj2PEzwJF4iA7otyXf//AFcHK4C843aYEMORdw89ZrVOtxODDzEt+gEOyuaqKFiw7rM2+b4cbWmy3cdTDrPEaFuDdq6A6BdXulIrcbsHzLWR2zTzlkAtEJo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39850400004)(346002)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(26005)(6512007)(83380400001)(8676002)(4326008)(6916009)(66556008)(54906003)(316002)(66476007)(66946007)(6506007)(966005)(6486002)(38100700002)(86362001)(8936002)(478600001)(44832011)(5660300002)(7416002)(7406005)(2906002)(36756003)(41300700001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4/SEXUQX/+LcIwszLNTrnj5/7t0pqP+NPpQQr2NNeY0Cxs41mjaaa0hJZEf6?=
 =?us-ascii?Q?W2+yUnK5oRi81wng/ZV593IPKYpghwnHykWMUaovPmZOv1pBEIDOzRJKV71E?=
 =?us-ascii?Q?J0fUe2AeETUR12CJxswT0jecpqnEkVrvMU1iCfW3D4BfRM2z/x/Jk/SLlQXb?=
 =?us-ascii?Q?g1dPv/XumKToRxPgu8yLeHPdZ89sWnA+1voOuRy+HIu21cRzXxuDEDdMGNG+?=
 =?us-ascii?Q?QoB0nLVOxYChszEhnffCy4Qs6b7iLjvzFyzUgw0Jr1ci0oQMh9ob6OV3l6zI?=
 =?us-ascii?Q?ZcLHIlxOzBZw6/uyQg3lAxIe8ro7ivOif8od1fbboaU1Pd80QUAjhUrO45ES?=
 =?us-ascii?Q?nLwjcCaSrFECHe/jNEyVR1C+JuptU7pGhu0OiTNrnJxonMuoYylkK0oM+LkY?=
 =?us-ascii?Q?gS9+q3GhTxCJIcRe8WDCLHqWHTX1dMVvwT5sEt0WV2OIOz7DKq3TDSN6CoLK?=
 =?us-ascii?Q?tA39lPIXfRMCBTHPCpgXBD2Ryr4WYaK33ufp7YlbAumr+sOe8PHJ9YUZm3Qa?=
 =?us-ascii?Q?9zmmx2MAXBqdBeS+pcNvfZZkYwVlDUjLyevaUsAlijpSge4gIEnifEMH6rms?=
 =?us-ascii?Q?tDMa6DYRTJGbpzTUIJBKJcyzPbVEb5YvkQgN9J4atIj29YNTYUZpIL8ZJrLI?=
 =?us-ascii?Q?b9dKLGZZFs89oDkvgiW614YwRQcCQltEJO/NFkzTKLAClZmSivvLLzYFDvM+?=
 =?us-ascii?Q?R49XCxV5wf+2C9SI5TAgVNwlHgElCXsrdTajPBI53JaK/G5u7NlQ7BsHYr+5?=
 =?us-ascii?Q?IKaYVNhjZFRSF2y9XrrHv5uGtV+l0B60eCyALJNmQfpPgSy20HXdayesYGbE?=
 =?us-ascii?Q?0IHLBHEssWvHXDKEMwxwmJPlRzWnayKG5atRl6/DU2JtRhtVd842W0J4PeLs?=
 =?us-ascii?Q?l4Q4r2F6Y+yqvXAgkQHHCjA/3CI2VYFtF3htLrh0oSvoEZ6Ik+2kimy6rqxm?=
 =?us-ascii?Q?bH0gJyuyse+BDehK/j8aNBL8TWcYIToJBNRZCCB9hNrlcFMc5Hqq6O/2nfEm?=
 =?us-ascii?Q?8CtFKjUUvEcDRWovXawzM9xHhQA8oLgjW8IOXar3DCkWtxst0fbb1zr5htaz?=
 =?us-ascii?Q?0dWk/kU/PlA9JbcwelzYljPrGEBq3yfoO2V+iORViPVKriYWLK/1zsuGAB5T?=
 =?us-ascii?Q?/Vp2gOTue5r6my+0paToNHcyDAoWMhYjPNIIC9Sxfu8PETF8CwnKdM8Op5na?=
 =?us-ascii?Q?38ouDXJ25ewMbkyBkMHJ9fMlWfDo30sLMZlC/YPYfRKVHNw2LglvNy1OkBr7?=
 =?us-ascii?Q?qNdaUPLxI/96T2Slu1c01WWrRiQnVDMYspcTOZnBU774ZXqF8SQtNty5kyQ+?=
 =?us-ascii?Q?+QhlLjRzfctxzMDEBG6+Y6QSQBn4hp+QV40jBX06MzVLN+Aha3oQu3/81JRw?=
 =?us-ascii?Q?Paf5Af/n22VSDCe+hngH4hVvea8h4QAkY2NcmX48T5Vm982f6INGVH9zPAnp?=
 =?us-ascii?Q?2J92D7ShSMeOXElQhVJVn6di7o21LuVJlhaSAVNTdwKEKdmX2FQ0SCr7/0Fk?=
 =?us-ascii?Q?7uAlPWL3pwfzd2h2ga3StPDfKEvf58pIpmFpcoOS+sB19YweT494B3nNWQ2G?=
 =?us-ascii?Q?O8ooduetOOHzPZL7FZT0xff15WzKDWIYhnAfDFBKOMMgYQu6u4LGIotd4YIk?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280b7e9f-d8c7-4a40-dd94-08dc06f7fd09
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 16:22:15.3564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zm884rhV+/41dyantHAHvMSTpviNUukaocAHDcfANZgNQeU8b0YDTy/0TQhy3pzfxYyD8suatNGG/KpvFG9yipd2NDQ2ES+3Yed84HMX5O0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4725

On Mon, Dec 25, 2023 at 03:54:18PM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > For example, the stream benchmark demonstrates that default interleave
> > is actively harmful, where weighted interleave is beneficial.
> >
> > Hardware: 1-socket 8 channel DDR5 + 1 CXL expander in PCIe x16
> > Default interleave : -78% (slower than DRAM)
> > Global weighting   : -6% to +4% (workload dependant)
> > Targeted weights   : +2.5% to +4% (consistently better than DRAM)
> >
> > If nothing else, this shows how awful round-robin interleave is.
> 
> I guess the performance of the default policy, local (fast memory)
> first, may be even better in some situation?  For example, before the
> bandwidth of DRAM is saturated?
> 

Yes - but it's more complicated than that.

Global weighting here means we did `numactl -w --interleave ...`, which
means *all* memory regions will be interleaved.  Code, stack, heap, etc.

Targeted weights means we used mbind2() with local weights, which only
targted specific heap regions.

The default policy was better than global weighting likely as a result
of things like stack/code being distributed to higher latency memory
produced a measurable overhead.

To provide this, we only applied weights to bandwidth driving regions,
and as a result we demonstrated a measurable performance increase.

So yes, the defautl policy may be better in some situations - but that
will be true of any policy.

> I understand that you may want to limit the memory usage of the fast
> memory too.  But IMHO, that is another requirements.  That should be
> enforced by something like per-node memory limit.
> 

This interface does not limit memory usage of a particular node, it 
distributes data according to the requested policy.

Nuanced distinction, but important.  If nodes become exhausted, tasks
are still free to allocate memory from any node in the nodemask, even if
it violates the requested mempolicy.

This is consistent with the existing behavior of mempolicy.

> > =====================================================================
> > (Patches 3-6) Refactoring mempolicy for code-reuse
> >
> > To avoid multiple paths of mempolicy creation, we should refactor the
> > existing code to enable the designed extensibility, and refactor
> > existing users to utilize the new interface (while retaining the
> > existing userland interface).
> >
> > This set of patches introduces a new mempolicy_args structure, which
> > is used to more fully describe a requested mempolicy - to include
> > existing and future extensions.
> >
> > /*
> >  * Describes settings of a mempolicy during set/get syscalls and
> >  * kernel internal calls to do_set_mempolicy()
> >  */
> > struct mempolicy_args {
> >     unsigned short mode;            /* policy mode */
> >     unsigned short mode_flags;      /* policy mode flags */
> >     int home_node;                  /* mbind: use MPOL_MF_HOME_NODE */
> >     nodemask_t *policy_nodes;       /* get/set/mbind */
> >     unsigned char *il_weights;      /* for mode MPOL_WEIGHTED_INTERLEAVE */
> > };
> 
> According to
> 
> https://www.geeksforgeeks.org/difference-between-argument-and-parameter-in-c-c-with-examples/
> 
> it appears that "parameter" are better than "argument" for struct name
> here.  It appears that current kernel source supports this too.
> 
> $ grep 'struct[\t ]\+[a-zA-Z0-9]\+_param' -r include/linux | wc -l
> 411
> $ grep 'struct[\t ]\+[a-zA-Z0-9]\+_arg' -r include/linux | wc -l
> 25
> 

Will change.

> > This arg structure will eventually be utilized by the following
> > interfaces:
> >     mpol_new() - new mempolicy creation
> >     do_get_mempolicy() - acquiring information about mempolicy
> >     do_set_mempolicy() - setting the task mempolicy
> >     do_mbind()         - setting a vma mempolicy
> >
> > do_get_mempolicy() is completely refactored to break it out into
> > separate functionality based on the flags provided by get_mempolicy(2)
> >     MPOL_F_MEMS_ALLOWED: acquires task->mems_allowed
> >     MPOL_F_ADDR: acquires information on vma policies
> >     MPOL_F_NODE: changes the output for the policy arg to node info
> >
> > We refactor the get_mempolicy syscall flatten the logic based on these
> > flags, and aloow for set_mempolicy2() to re-use the underlying logic.
> >
> > The result of this refactor, and the new mempolicy_args structure, is
> > that extensions like 'sys_set_mempolicy_home_node' can now be directly
> > integrated into the initial call to 'set_mempolicy2', and that more
> > complete information about a mempolicy can be returned with a single
> > call to 'get_mempolicy2', rather than multiple calls to 'get_mempolicy'
> >
> >
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
> >         __u64 pol_maxnodes;
> 
> I understand that we want to avoid hole in struct.  But I still feel
> uncomfortable to use __u64 for a small.  But I don't have solution too.
> Anyone else has some idea?
>

maxnode has been an `unsigned long` in every other interface for quite
some time.  Seems better to keep this consistent rather than it suddenly
become `unsigned long` over here and `unsigned short` over there.

> >         __aligned_u64 pol_nodes;
> >         __aligned_u64 *il_weights;      /* of size pol_maxnodes */
> 
> Typo?  Should be,
> 

derp derp

> >
> > The 'flags' argument for mbind2 is the same as 'mbind', except with
> > the addition of MPOL_MF_HOME_NODE to denote whether the 'home_node'
> > field should be utilized.
> >
> > The 'flags' argument for get_mempolicy2 allows for MPOL_F_ADDR to
> > allow operating on VMA policies, but MPOL_F_NODE and MPOL_F_MEMS_ALLOWED
> > behavior has been omitted, since get_mempolicy() provides this already.
> 
> I still think that it's a good idea to make it possible to deprecate
> get_mempolicy().  How about use a union as follows?
> 
> struct mpol_mems_allowed {
>          __u64 maxnodes;
>          __aligned_u64 nodemask;
> };
> 
> union mpol_info {
>         struct mpol_args args;
>         struct mpol_mems_allowed mems_allowed;
>         __s32 node;
> };
> 

See my other email.  I've come around to see mems_allowed as a wart that
needs to be removed.  The same information is already available via
sysfs cpusets.mems and cpusets.mems_effective.

Additionally, mems_allowed isn't even technically part of the mempolicy,
so if we did want an interface to acquire the infomation, you'd prefer
to just implement a stand-alone syscall.

The sysfs interface seems sufficient though.


`policy_node` is a similar "why does this even exist" type feature,
except that it can still be used from get_mempolicy() and if there is an
actual reason to extend it to get_mempolicy2() it can be added to
mpol_params.

~Gregory

