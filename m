Return-Path: <linux-fsdevel+bounces-4041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9A07FBD37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 15:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E83F1F20F99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 14:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B715C06A;
	Tue, 28 Nov 2023 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="xnWvHOZ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2247710E4;
	Tue, 28 Nov 2023 06:51:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faLTWgLz9q/Ed5nrkYTlLWcqF9tgFPBwjkBqpTy0IRP/WV0kSXNGkxCU/fjeAUtfiIkU/WvdLBcomh1PgFL1Nm6I8/YmNmH8zmWaCHE7sVpRGUipud6ULdynEt52VMfcKpbWDFjFLbwh2rgvZnJJiSnitnBp5kbbJ9HixugnxHnlQHM12+JDXMXgbJei4twG8Q1Vbw4m1jA2A22R2cQsNy7hEg5ASx5SoxGejNdxOTGuqagNimRTEgJgOZM90es2tr7ZfPE1ZD93pbrx7RrndA31FudNZpoo0RWDJgzPFJIkrtTL1BAFcG53lCSVx7gkBXMm2KdRS3XqcivR6/b3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hn8zTSBx0EECv8Se1zHPIwuPb6kgjkjZ5pWXIZ28jvU=;
 b=RQido1zZtvf3Im3FEdINaxqfUGZoT+ZgLI6KhX8INQRGi9BNRWLYCCzzt9Parpi/issDI1VR1mwNzKtckxuXfyhPrykJ4mr35sypt0ATO7zEu1XmSNgt9ogcGO6Ri2iUzv/snAd1pvnDlHn+V4tm5Lnl3qp2fnc2YFnoKCjXuxn5lbI37Odzg/3KPfKTxjyzOVdRo6DvvpcAVPrGbOMEWGpjyDGDzg2wrvNcrxFtFMU7XlQBvZai5yHqpfTzYlowdyxcGv2URVKBX2wb7vVCemdQaXa5fT+MTynIsNRzkwAfSL4Ts9Rplo48fWuKVPkTWAiHklArS6CvIRac8BIHTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn8zTSBx0EECv8Se1zHPIwuPb6kgjkjZ5pWXIZ28jvU=;
 b=xnWvHOZ2jxtIMGBkC+TDqJRvnmF9ZWBdjpHr6qyDFRX6PNZdwZ6sgx7Yz+aRr1LkkS/RwRHuQC5ZmMxC7nAyFI7kCtkMuBX9yx8VZTRybH696OA2akn6svRqdMB2aE5sRJbG3s5q1isd728rVtMm8HFyd7ZdENgn3fDGdrHCYeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH3PR17MB6665.namprd17.prod.outlook.com (2603:10b6:610:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 14:51:17 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:51:17 +0000
Date: Tue, 28 Nov 2023 09:51:08 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	arnd@arndb.de, tglx@linutronix.de, luto@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, tj@kernel.org, ying.huang@intel.com
Subject: Re: [RFC PATCH 06/11] mm/mempolicy: modify do_mbind to operate on
 task argument instead of current
Message-ID: <ZWX+XL7+gmr/l/go@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
 <20231122211200.31620-7-gregory.price@memverge.com>
 <ZWX0-hEjqkmnR1Nq@tiehlicka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWX0-hEjqkmnR1Nq@tiehlicka>
X-ClientProxiedBy: PH0PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:510:5::21) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH3PR17MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 4810fc7d-0249-4544-5943-08dbf02179a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	71PBl1X4/90/P4PmUZBXSRSL+Hw7aFQLuJvIPjHGcji2ngKZNd/GtkNkkDqGjkfAJkq+Zdh1rCgj2a3KZb335g/6TJ0kgMIdz3GEOmtoH4dyQqpsHyZFQh8CYZCZOMbGqeUkaYaZF3+zYGmAyHZkn3Pro2S4N5VhBlU0xGTXez7na20pbRdm5gnCmyCa++4JLW/DjLRzw9LsZMMkBB5AVy69JyaHevlYln6M9UQjB2Km6Zx3HUTaRvnyjbGlP/6XI/BqD0kKf5pVxtnCboTyaHbcxu+c/zf97SeM2ApJCo1zluKpkyN389GC02kqeQhjd8QCnM8yb3uyl1uOQKYCQ0qSlJGj7QXMDyZUKF2EWE4Fqfi+37iatQcVCCh52zEmbEk3hmmsiSEtZ2HJhsR0J9mwO3l3IqVL6kcrs69CqQ+wcHuT9NfY/GwKsuXvMScicayslVfZnbOAAvC+ZfKOev9r7FgELbY0k5Hf3CW1VvSg+ideKGpy/sX172NfcrSiCofa97Q8c/iBZVHIcqFiXhs4iwYTBm4u8At3Ajjv0ui3i2PxQNJrJ+yE+s5/Rx56e0fSKbEExJrKtlG7JhiuDiQZBdtF9BGb7DFLwxeOGytjNBa8YP2yXcwFtpjDLjk6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39850400004)(396003)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(86362001)(2906002)(5660300002)(6512007)(6506007)(8676002)(4326008)(7416002)(41300700001)(44832011)(8936002)(83380400001)(316002)(38100700002)(36756003)(2616005)(478600001)(6486002)(6666004)(66476007)(66946007)(6916009)(26005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gyyk/Iy4Cvamq0arg7zCpgtUF4FFWXj0WoXRNm84sE+0BPED70VtMxgGXbBa?=
 =?us-ascii?Q?Lnti6Q+EDHfH2HmgM9RPBXqQ/HbuBJ2oQWtNsIgISucPBswnFgyN09IzKJze?=
 =?us-ascii?Q?o0j3qESMs9D0qWGCwRBDIMmr63HCUmWAcHpZR3G0d/JjJyfdxamen/NFTiza?=
 =?us-ascii?Q?8O7oiQEd0VZ3tcL+4ANF+tLEmvSDYiorZAb3FqqPLhvdb6uW1FvJhnDBvkMT?=
 =?us-ascii?Q?WMm0JwEj3K1qPqOkeYFXzVMHffXwErKwBcXuWzSyxzd3AFSSPmQ5Rem7I1nP?=
 =?us-ascii?Q?31I1fa22ehf7jvqrJM6V2pnZWWINAlaM/FqLV8G+CIYQD1Gnq3esU68ssJLn?=
 =?us-ascii?Q?aBd6LtD0nncrbj3cEXNVgz36jHPTcXa+txZN6ZSX2zRKo9DEMwJ6ZCo4yvSL?=
 =?us-ascii?Q?1bA8BDAF3yBY8m207DTYKOjwdZfjgAYIe6+iOkdPaftaMjdXeBW/7PA+ZxU8?=
 =?us-ascii?Q?zOPIxfbF9u8b/E2pUPWPbpDoVRtTlOjwJG6yDpa5x3mjYum2YKBs2HqNL04c?=
 =?us-ascii?Q?9AyBmEXlpdWfVkO4x/udibgTAGCwEH8toncBUpTISh0dt6nbbShMs5mowHY/?=
 =?us-ascii?Q?PsgQ9C85FCV4dTrkvpWiMeiybMDW9u9cDsuUVLed2PiOkgaWCD0voUtP90MF?=
 =?us-ascii?Q?4FkQtZR6JVKXAP1y6SnLfOpo/oCgkKKql+ceOOVVKWK8VoN0drpJSjuHpnS/?=
 =?us-ascii?Q?lFIMHKJEBCCTZmSMtcL4LsNedX3N5LM1iuy6xcRTjodzdgppp/jxsgD6Cedf?=
 =?us-ascii?Q?KAbszsU96HqMWYczVdqEHtThu1s0yORWEevt+O7O9ltELea2bzZPcf8FGhSv?=
 =?us-ascii?Q?pKq9kai+WjIGA1HMfhry9He1sOD6piCfiwlOkT1DCuIolcdpE98nQbJllkqf?=
 =?us-ascii?Q?84gh3yhSCZ/fBZWGvwZAerwbshvlR42/UnEUvWh00L8VIGuipIUcQZZE00Mc?=
 =?us-ascii?Q?CWYI+KfoKPiZNqb7fldVe5rLbyN6SwpUWWCECzwS3pfXSzK0JlKF/izuJ2SJ?=
 =?us-ascii?Q?RVGf3RafSuYN8KnuyaQydpSpPzyQJTSIyb5iiuV7CMJqH0At/GG0PrNKGmo6?=
 =?us-ascii?Q?VkTyGpdPq4dLo5Hgrq9dzqpD0z4+FojfioyLSK6a/kkQzT4DViOt3+dcyspz?=
 =?us-ascii?Q?gKPRPKPcO0IPB8uHp9oLKFNXlZLENaDq2rz9E3RQiYVdlvBqOPiNfhquLD6L?=
 =?us-ascii?Q?EGstIcPx0O50Jdk4LOWSxCC8crkCWZ3Na2jYfdsJhjK4XLUQ6mCqCNzRlBgI?=
 =?us-ascii?Q?1kGgGhmGO4sz1vVhGCdVxZd6kd8fV5iyqd9R5AfO7SjFrW9xVMYgHPKziQWy?=
 =?us-ascii?Q?ks33geCxYIGnbNxqHc3t/7E91voG2qSZ2rWO3OHGq47jR4So4xlnlBpTp9H/?=
 =?us-ascii?Q?dwIS3JkN+BQZx8N7aF0pS2Rmud3xrrmkIgU5de07gD+xKfVrpPlZQBEyhg5N?=
 =?us-ascii?Q?0gQ0lCCBsGpiJ0U7HgtJWUhZ+JwJR/OadRfuaL6BqJJbUqgvBlJsmt/bnt3m?=
 =?us-ascii?Q?inDjEzA8ng0PeMfNVfn/If/nwhD7FVno0tJQ7/SsJK5+IEUEZ+4EUlj2dau/?=
 =?us-ascii?Q?cQxyqVKRtOiZ+Xm3Q/2VcuYEBrhZfCGbZH690IWZ93plADeFF19sDFonN9iU?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4810fc7d-0249-4544-5943-08dbf02179a3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:51:16.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vTYPlIXuVqEoU3frhq0qus2YCCPhKuV+iv6xXe93YXRPvlKMdWY5b3Ik2YiDwznCUE5dfFOaQAJIsAHKrtl+wyrB2VTrwXuKbhSlTigD/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR17MB6665

On Tue, Nov 28, 2023 at 03:11:06PM +0100, Michal Hocko wrote:
> On Wed 22-11-23 16:11:55, Gregory Price wrote:
> [...]
> > + * Like get_vma_policy and get_task_policy, must hold alloc/task_lock
> > + * while calling this.
> > + */
> > +static struct mempolicy *get_task_vma_policy(struct task_struct *task,
> > +					     struct vm_area_struct *vma,
> > +					     unsigned long addr, int order,
> > +					     pgoff_t *ilx)
> [...]
> 
> You should add lockdep annotation for alloc_lock/task_lock here for clarity and 
> also...  
> > @@ -1844,16 +1899,7 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
> >  struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
> >  				 unsigned long addr, int order, pgoff_t *ilx)
> >  {
> > -	struct mempolicy *pol;
> > -
> > -	pol = __get_vma_policy(vma, addr, ilx);
> > -	if (!pol)
> > -		pol = get_task_policy(current);
> > -	if (pol->mode == MPOL_INTERLEAVE) {
> > -		*ilx += vma->vm_pgoff >> order;
> > -		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
> > -	}
> > -	return pol;
> > +	return get_task_vma_policy(current, vma, addr, order, ilx);
> 
> I do not think that all get_vma_policy take task_lock (just random check
> dequeue_hugetlb_folio_vma->huge_node->get_vma_policy AFAICS)
> 

hm, i might have gotten turned around on this one.  Forgot to check for
external references to get_vma_policy.  I thought I considered it, but i
clearly did not leave myself any notes if I did.

This pattern is troublesome, we're holding the task lock during the
callback stack in __get_vma_policy - just incase that returns NULL so we
can return the task policy instead.  If that vma is shared, it will take
the vma shared policy lock (sp->lock)

I almost want to change this interface to return NULL if the VMA doesn't
have one, and change callers to fetch the task policy explicitly instead
of implicitly returning the task policy.  At least then we'd only take
the task lock on an explicit access to the *Task* policy.

> Also I do not see policy_nodemask to be handled anywhere. That one is
> used along with get_vma_policy (sometimes hidden like in
> alloc_pages_mpol). It has a dependency on
> cpuset_nodemask_valid_mems_allowed. That means that e.g. mbind on a
> remote task would be constrained by current task cpuset when allocating
> migration targets for the target task. I am wondering how many other
> dependencies like that are lurking there.

bah!

thought i dug all these out, but i missed alloc_migration_target_by_mpol
from do_mbind.

I'll need to take another look at the calls to cpusets interfaces to
make sure i dig this out.  The number of hidden accesses to current is
really nasty :[ 

> -- 
> Michal Hocko
> SUSE Labs

