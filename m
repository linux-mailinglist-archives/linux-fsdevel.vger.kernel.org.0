Return-Path: <linux-fsdevel+bounces-6516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD06818F4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 19:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA591F25070
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 18:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C123C37D1E;
	Tue, 19 Dec 2023 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="UZ3iX+rG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A4A37D00;
	Tue, 19 Dec 2023 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTs0k7awVyhWmfs3CcW8T6JXVSjbg4RfoQPUlZ+goNdOir3by6x0wUAydoMJbpOqyYoMc2fLVkCW/uugmthZ5r3jqMtjguyKoRyhSmya66MfgEzx8B8ZWFhlr9lBFXxLmPpUOUPIvLPkdE332BU/8jCu4mJIXL8FpMMaAOdHtcvPmEU2ukEFcPhrU5PCuV1libnzUde0DehO5kKoCVDC2TthgqqhEWQJH8xNMWP2H3+3jI/qbndvSygPi29871tk66/8mbjJ9/vapU4zA9cl0dmfTEI21jk8jckN+u8mA+cPclYtseKNp8ZKROZdI0DJZ1d5qnU0/YcmGNgj5p5WAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gc1dvVvEDDUGNeebCxCoW8yWbeAe/uVJwIXr7FzFCTg=;
 b=A7cMRSrbtvG/i6EjmYMBWZEdhhR9nN0zm0pexa0V42JuzAAM2SJ+ixhFNQb9GqNBYAiXUQj0k0iuh9s4TJMqgFCCXs7YUi+BCJHRT6x15YQXtpo7XhGMwUPS6ZEY0F7XSGqR70k1HFAwmMyg6ARlUSInIQIHvO0vlAKJx/TyPCiOq7Zp6zBwRvPSkvrxJTYJq9AJDQQUIcyvGeKu8h4egzKDd1tbC6y851o5TkhVjKyMDkEd+aBwkW4z0sV4PWi5ktnbKBxcz8PFJr30u9yUOPJFQWfXPhOYXvywwphax+quLIhO8ZUamY9cLkP6QCWTSXXFoSnO5TH7ikwLlYpHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc1dvVvEDDUGNeebCxCoW8yWbeAe/uVJwIXr7FzFCTg=;
 b=UZ3iX+rGL8gp8FCU8uE8pbDN5jlc623EX+Pm1mGbkCXBIkojoTHIGIraykZtljidUKgjDMZfWHWnG7Bd3apOqdv6oOQpR/bJp3K30o0cVGOfVckQGJ85BZ9RH5DMRVl5r9W16I9jUmgDTTxe0iNBYvauZaoMZl6V+JN7W7SHYfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BLAPR17MB4097.namprd17.prod.outlook.com (2603:10b6:208:27a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 18:09:09 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 18:09:08 +0000
Date: Tue, 19 Dec 2023 13:09:02 -0500
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
Message-ID: <ZYHcPiU2IzHr/tbQ@memverge.com>
References: <20231218194631.21667-1-gregory.price@memverge.com>
 <87wmtanba2.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmtanba2.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BYAPR01CA0007.prod.exchangelabs.com (2603:10b6:a02:80::20)
 To SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BLAPR17MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 047b7cb4-bb97-4138-04cf-08dc00bd982d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rM2FKnD3I1/SZpnJOb9AmuhPHh7r+UEEZH+W2xomjgBF3RHp5+6ngF3sxnXmpYdzD7V8GlAVtcWJUxg0F/mkuyaSVp2excByM9yFxIZk7vtbITlB97uP1wxpBEfryyk/QUie4E0dJ370BDxrvs4fPHWYaASuBz31UIqd3Q94q4zRICj9AZmY6SsuiT0rBDZNH3nPkMGcsEjQnygGdo6qUSsYaFo8TP2cgiRstovnRJbhVhpFFsvDm+Mjd+3uuOrAq29K8uxHorbw1YqwFs9WkjjKv8zFTeqJUkTWtei3UCG4UJUlLnV/3fCtCm0ZKHaz41RAXdI9BTZaYyQpZdRQbUKoxQIIkxLeO0wXh2Rx3QHEEOGrlNMngcBnNENuKdei9vnpvzx2Yn75X29wxcFjcvJsfSclEuE99Ra5Ja629wDzTOyEOu9t0O+9JvQtULbSMHtQuc69QPFmK99KQXPzmzP/QiJ+O54hShmyTp5gZk7ogOP7ITMtyQlhYSBgQAlIz9wP54D1Pb79a0RYhnRysy9L+JZx/pIa/rDb11XyAdwYRxzdM8sY6O1fp5AcB0jUNBOEm4zRRRG2P3qumgGMTKAAMx+yTLvJPiKKLd1IICdVVSMfEWnFEXvttzIkOBp7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39840400004)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(478600001)(4326008)(26005)(38100700002)(7416002)(44832011)(7406005)(41300700001)(8936002)(2616005)(5660300002)(6512007)(6486002)(2906002)(66556008)(66946007)(6666004)(6506007)(8676002)(54906003)(316002)(66476007)(6916009)(36756003)(86362001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8vVI8WMMe2BfP7jCoOY2RC05UlpJpM0uHTfWxnccPNlRpLBKTlZT9Zi5HKPR?=
 =?us-ascii?Q?/j+K3W7n3yH2m2ThCEV3I9SouqDDO+LWyy81g64kU2MAIalBCmpE9zTUjIJW?=
 =?us-ascii?Q?/P0ePH+YSwLNgK6ONTZKsmhMNaQtbkjC1ysRuE7fa7VWY8aZMkyirVzitrB6?=
 =?us-ascii?Q?laXS+MlR8rzCN5/hFmXTogM+plUczMA/F1tcg5Q6hPCfiBLVq15VqqHjxccU?=
 =?us-ascii?Q?ybw1K3lqTkVRrYQr7jyNF74VRKtONWook/hh1cAn/lpQgR8bLZgGph63350N?=
 =?us-ascii?Q?89WtmsG9cqkO2Xq0Kk5fHJGVnq409Kj4TX5RxKI3Uv/9ZOVkOjOuyyfsgUPQ?=
 =?us-ascii?Q?VMJKrQUa3ip/gd7/7RBqDyecpxZ2y9l7MDS9W2stDZ2483MXE7I8Z5gdkIgw?=
 =?us-ascii?Q?7bnBTv69rLMf0y10oY2H3XKB7bNPIWG54aRo0UzIlEnqgBKsj3yv699Sz1vI?=
 =?us-ascii?Q?kQ4Y+0uUlhXO/0/zle+1IliJNBaxYBUN5uX6udhbU+pkuUfckX+rZKDENMAx?=
 =?us-ascii?Q?x+G5Db/ipIp+32sAeBDOAOwx3Lx0QbJkkhkDRMYFzLm1NdnICpfkT0g78/Nz?=
 =?us-ascii?Q?HnjqSxxX8FQuIuiLs7eCBYjUN4Bji0yqKUGErpruEe/MJCSug/xxI7M6hbF/?=
 =?us-ascii?Q?umiq4Qe8HOHNQapHwCfUcTl/nes9Iyo7tbqoLPEGnQyn71WcW3IiQjBZcTyh?=
 =?us-ascii?Q?X/nxyhfz/o9ns+RfyqYZysW14EAsUaYFnY3q0LTlw1L6lbcnKGXzJOUHTb4a?=
 =?us-ascii?Q?o/jdBV1qoOO5VXPNVlkesmB0Mf2j68edShvUlLy5YbkpbiZt1dVvHEIGkk5M?=
 =?us-ascii?Q?UyUSHaHulgzn7myE4ugk8f2QfUpsgiJN/8hQoK4+gWWa4/JkBI13uyfeKkkn?=
 =?us-ascii?Q?8UHMUhbMwsv3ePzxoN5FsxkqIoaMMMpgYahTX/7ocRN978x5Xi9C8xa/FG8l?=
 =?us-ascii?Q?XKfePxlGrBZDcjCVHrOZ5c4kDNsWqyqcIzyQuJSmwqJAKug+l5SBgoQfTKoo?=
 =?us-ascii?Q?1dqnTOz7WvZz7REX0E3DLtUo7ZiRkd07UhLao2LbCHNPomcx+DvEauP1IFBt?=
 =?us-ascii?Q?Vxqfw7jCSUiyNMhVhAqBMtDzs23r5lljhPqnjuORzJG+0ax7eUvM9BZ/dAiW?=
 =?us-ascii?Q?xyPsAhMgY5y5gNZL2VcTmvcvPzry6wnc/vMWWapHJlKE/b+fx3tK7oe5c1VW?=
 =?us-ascii?Q?7xtqpX/kY+Wd0XzWURVjQxIv3Ky2x/Hjy4L6KdvCTOF9q69K4pTJkcmhcNB5?=
 =?us-ascii?Q?wJeyuHYsbescMcmaKi7pgtpQVhl1AwBm/U0EKTq8h530xT9lb71muhVkvkSn?=
 =?us-ascii?Q?K8T9RJXN0W83b89OUy2iGrwiXMHpRVSxUnT9iUUZmOlSLOEzjYCrbB5iJ9XL?=
 =?us-ascii?Q?4lVX6ccY2g8J43hrhmWZ4n0DfU8AXsmJNF1s3KjLwd+QaCscgj+G3iCpiO+G?=
 =?us-ascii?Q?WqdeYnBEAY8dMIZVxA1CEprvMgL1Uujgp12wUWVT+LlW2ZPkp8DvpWnjlQj1?=
 =?us-ascii?Q?S8lrWShK6oqh/GBFIAVWvWIeVmkUjYEytwjmx6cKr6R6VRePhUn2w77uMDOZ?=
 =?us-ascii?Q?MzVBXV/STVqbG/r/qtOfytcd8dPFicfp/z1MJPnxoLsYtSE7x5nKl8q40A2n?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047b7cb4-bb97-4138-04cf-08dc00bd982d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 18:09:08.3407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1OtG37z6u48cOprkEcDcGVk4g/HcCPGzNw+prGsE/8ZjiQcmAixYIe4EPGQ7HwwA9dusC/DwCF7V+PI3FJtVwJde0EhCNTT/7VfoYPls5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR17MB4097

On Tue, Dec 19, 2023 at 11:04:05AM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > This patch set extends the mempolicy interface to enable new
> > mempolicies which may require extended data to operate.
> >
> > MPOL_WEIGHTED_INTERLEAVE is included as an example extension.
> 
> Per my understanding, it's better to describe why we need this patchset
> at the beginning.  Per my understanding, weighted interleave is used to
> expand DRAM bandwidth for workloads with real high memory bandwidth
> requirements.  Without it, DRAM bandwidth will be saturated, which leads
> to poor performance.
> 

Will add more details, thanks.

> > struct mempolicy_args {
> >     unsigned short mode;            /* policy mode */
> >     unsigned short mode_flags;      /* policy mode flags */
> >     int home_node;                  /* mbind: use MPOL_MF_HOME_NODE */
> >     nodemask_t *policy_nodes;       /* get/set/mbind */
> >     unsigned char *il_weights;      /* for mode MPOL_WEIGHTED_INTERLEAVE */
> >     int policy_node;                /* get: policy node information */
> > };
> 
> Because we use more and more parameters to describe the mempolicy, I
> think it's a good idea to replace some parameters with struct.  But I
> don't think it's a good idea to put unrelated stuff into the struct.
> For example,
> 
> struct mempolicy_param {
>     unsigned short mode;            /* policy mode */
>     unsigned short mode_flags;      /* policy mode flags */
>     int home_node;                  /* mbind: use MPOL_MF_HOME_NODE */
>     nodemask_t *policy_nodes;
>     unsigned char *il_weights;      /* for mode MPOL_WEIGHTED_INTERLEAVE */
> };
> 
> describe the parameters to create the mempolicy.  It can be used by
> set/get_mempolicy() and mbind().  So, I think that it's a good
> abstraction.  But "policy_node" has nothing to do with set_mempolicy()
> and mbind().  So I think that we shouldn't add it into the struct.  It's
> totally OK to use different parameters for different functions.  For
> example,
> 
> long do_set_mempolicy(struct mempolicy_param *mparam);
> long do_mbind(unsigned long start, unsigned long len,
>                 struct mempolicy_param *mparam, unsigned long flags);
> long do_get_task_mempolicy(struct mempolicy_param *mparam, int
>                 *policy_node);
> 
> This isn't the full list.  My point is to use separate parameter for
> something specific for some function.
>

this is the internal structure, but i get the point, we can drop it from
the structure and extend the arg list internally.

I'd originally thought to just remove the policy_node stuff all
together from get_mempolicy2().  Do you prefer to have a separate struct
for set/get interfaces so that the get interface struct can be extended?

All the MPOL_F_NODE "alternate data fetch" mechanisms from
get_mempolicy() feel like more of a wart than a feature.  And presently
the only data returned in policy_node is the next allocation node for
interleave.  That's not even particularly useful, so I'm of a mind to
remove it.

Assuming we remove policy_node altogether... do we still break up the
set/get interface into separate structures to avoid this in the future?

> > struct mpol_args {
> >         /* Basic mempolicy settings */
> >         __u16 mode;
> >         __u16 mode_flags;
> >         __s32 home_node;
> >         __aligned_u64 pol_nodes;
> >         __aligned_u64 *il_weights;      /* of size pol_maxnodes */
> >         __u64 pol_maxnodes;
> >         __s32 policy_node;
> > };
> 
> Same as my idea above.  I think we shouldn't add policy_node for
> set_mempolicy2()/mbind2().  That will make users confusing.  We can use
> a different struct for get_mempolicy2().
> 

See above.

~Gregory

