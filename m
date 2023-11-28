Return-Path: <linux-fsdevel+bounces-4075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 430F07FC381
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 19:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FBF1C20D1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22883D0D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="BNZT1N5p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF8091;
	Tue, 28 Nov 2023 10:09:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmXhB38m0m5oq/l0kxnmuq5vMq78ahv2Vezk70JRyBCaX3kia7O2eW2/48AWtGqm3l0CW54q/Dv2wEe4lqwTyuk5qztM3rwWG0MriHgvQTnqqwl58d0QZfBXXe93bFJifyM5DBxKWPxV19boLHxaIs3KRnZhmb7nSVRWed3VQ/0eK/ODzdEvd6LmEU8GGrc7i4qmRHk4qPG+kDXWKU6YdH2SF+4F5qqq+uXf6Upc22DweSI0hg/2sQaPvPhB1wiu1gnTzoeSE5kYttKMMwlSsJpBMXHmpenpErCD30FBnrkcwBLoeEfc3KOuFrYh0Y1kqrZ6f5LBG6+joiaNvMNq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5s9J5/ZfVDp/yhvkUTjP/J14nJ8PKRu3+g5cl68Ajvg=;
 b=g1/9esN/EO7bqLkRz5TTkAx9cjn8WLvZJklIS1MNGy9+134eF3fjoxOSyXo4s1GZ8OQqNXaFHGQFgL5ZqSvNCHwBPGsX2TtqQVkElr7oTHmV0SNei7mfUJEDIM9O5ZAyboWIg2KLBtaNgnbEQYNmYS/JvoURxjpI2mXGKcTEbLE+1jxuTfBEiQz4XLkwyq9vOMM4IQI7yhdWbaNGW4eTdFujyRiR4Kuo+ECqfhgRxGVmeeWnY1ECTMOSROlfLH/PyNvtz7ZgiDsq8NBqnOtk/6sSagqePcLZvba8CYPCz+l/UuYNsYHSapwrU5ovf2iMPgC8fQUmkr03D+MSpKDIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5s9J5/ZfVDp/yhvkUTjP/J14nJ8PKRu3+g5cl68Ajvg=;
 b=BNZT1N5pVbeLbjnj1Y2bj4RQZemJrbFap7YjgHTjT1y05sHSw71K2R8qMU2E8y/AtPte5vOvYpHHDQkiwE5rxZsfkOn6e0UA+TNwvnrXl0A0daYNfhcTfP3y8TpTjkgfX2omAuKYCqYe+xY/vzKvBadMoc/5BivcXqJiM8QkSJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BL3PR17MB6115.namprd17.prod.outlook.com (2603:10b6:208:3bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 18:09:03 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 18:09:02 +0000
Date: Tue, 28 Nov 2023 13:08:54 -0500
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
Message-ID: <ZWYsth2CtC4Ilvoz@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
 <20231122211200.31620-7-gregory.price@memverge.com>
 <ZWX0-hEjqkmnR1Nq@tiehlicka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWX0-hEjqkmnR1Nq@tiehlicka>
X-ClientProxiedBy: BYAPR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:a03:60::24) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BL3PR17MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 460d3026-f316-42e6-db2e-08dbf03d1a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W1oy1oHfQVtbCNTpAVNjp9lXkDzVtyUzz1KRao9bKIL0lli7HKny1kD6lK/gZAoaOBOqM6x5HFvaaeBE4rzaTL45GZl0YxkdQ77EkQ7zrg6olwdNaDLGNbVXE+s+KEEnn2VRyxRWGWWxh/b4nCoKXQoxd0citKkuecJiZLIFnLFnFwyXcICgzoWq1zs+64ls6SINkHJROUSpQ4bxeaxxmYtVzb3X/HZPpTfUajsBIY1tNxSGNlGJKlB1mDoVdamR2NW7ZV5OFNh4g5TPkrOGsenLhYuqrFDworsgCjQDycLpjwC91OQejMJRIungvx2CBr0pV9cbunafBup74GBZCftNjW3k9UquUCk2o3lHOdPa6PKJXAASFA7ilrZMiYrr7pNq9IWDfx8CIECzmhzLriMhXrCZVNWyal+10jjPprUJoXAX1/Je3EnjsMOgTzYKfVHR3wDv7IFfuZNrsmYKwS2l1mGeeKU8vgqRpmlPs8WRhw49NcedjG9/J3DA9Sn55bCQDXKYGC7GvuBqIz5e4y9e38GGxgVBezj1FSex9ybbPc4KnzG9AgQpZQ70zzcZbL2qgkh8e9QIvYxLjXzy+7O2fn0P8U0lvP6im057nz9iaSebLxk7mA/+gzWrBPnw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39850400004)(366004)(230922051799003)(230173577357003)(230273577357003)(186009)(451199024)(64100799003)(1800799012)(2616005)(26005)(6512007)(6916009)(8676002)(4326008)(8936002)(2906002)(5660300002)(7416002)(86362001)(6486002)(478600001)(44832011)(66946007)(66556008)(316002)(66476007)(38100700002)(83380400001)(6506007)(6666004)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p8iKQnv0ouZBlMziW8Y/m769PvbnR8YxqMCzWexsVtosM/X3uslABOaputJX?=
 =?us-ascii?Q?1FZvqUjJocc3uLROa7FFluY/IjRnJVoVDEZ4vR8k2/7p16DT5oU0hwb0PODj?=
 =?us-ascii?Q?7t1mzd6N6L1XOhfXpNpbNRgHETBHpLvsRolUwBMnrXIvohyvMctjlhoHBzkh?=
 =?us-ascii?Q?lLxYjj/oWRZn9+AGx6Py9BksSlLoTyBFjd+7128mzN3RGcRZ5esIvPpA2hWJ?=
 =?us-ascii?Q?GKbYImk7NanScPqrFCjuiKOYnIufv2C0sJ1vCN72p6XN8TnYmq9eeFlcY3us?=
 =?us-ascii?Q?Gix7CZPVrzTtO/yB0HZ+mEv8obO6lXs8r4mR5AGtn2mNdTNlWxRYnysAEz7b?=
 =?us-ascii?Q?FG+qyArWpYEx4Ss8zOBxvf/+o9QckVd+99Zs6Lv9vn92HEnLkR8Olhm4dVtF?=
 =?us-ascii?Q?whaXF7VycfVu0U/VESn+xCSdjbbePhS28IrFidvxHv4OfpIuXplYXlOTeFJB?=
 =?us-ascii?Q?W5zt4V2Y36Yp82r7MDBUWmCSdkH+cgDwRLqv7P4E8lMA8SQe9sOvoqLeYQDz?=
 =?us-ascii?Q?563EKERSSA75W+scXy6rgSKNZDBCu+ThkJW6QA8HY/yUdJvmwSmv1klt2n55?=
 =?us-ascii?Q?CC7f7v49a1dLVC4iPPdP0TYezj6Ga1R3dui4fN4Gb8Tz3h6GrRrBFW6ehma8?=
 =?us-ascii?Q?j+Qpg7bAEbyAYZy4a9CQTSDOWlo08qJeCV81ZE4vyJ0yuDP1T3Qat65X5dQ8?=
 =?us-ascii?Q?3AMQtkbZz7HWoj8Bf5K5I8kej/zDZDTXLx/Z4sypM85JIn4lQW4iVZhqY7Sz?=
 =?us-ascii?Q?hn1DCgvdb7UFV/S2KihrfLe40/yJO9XmN/ksb7Q6fFriuNetVoYwCSH4h28y?=
 =?us-ascii?Q?l43e4/gBRrDgOwU6R6Vb2EL5B7FB71aA75NLGuB3a19N8JzHexH1MOZ+bSiJ?=
 =?us-ascii?Q?Hp3ncGh6HqyoV2aQ0Exb7ARvwmc1DpWshyPXhUz03eJ88B94kgFHhrb1Ctb5?=
 =?us-ascii?Q?ky31t5xfQsr/PBNMh7DrdE1cQStpigLaYDOa1/DzJznpClTRrg20Odav9LKm?=
 =?us-ascii?Q?QkgKaJfi9tLxisuL1mydRRNScYEF03cnCJLc4EWSYP8TENLU769DynyAyd/v?=
 =?us-ascii?Q?XRXM3NNb3NO7mRiyF8rPEyWTF8UwyUL2KxLC64v1ht3dvJQ9kWXlsLye3xaK?=
 =?us-ascii?Q?68yV2Jl6/Umi/4H9nkP1Zv0jL8dqjS4vsz4SIRR5o7yUfrFebPM9lSSCi0fv?=
 =?us-ascii?Q?a0Q6EZ5jPhNekv8CZ58YYxkW7netmDVZWZwbidghqVnV35V1yCicqjqlufME?=
 =?us-ascii?Q?WBIfSAmRa9mY7PvIAhcBsGk6yr4m8PVwhJXnCB9/ZALJscqTuwEq/5wAXM49?=
 =?us-ascii?Q?pQUSnexS45p9GOfuVrnIrB7LJFhPwSghR3V0U+AX+EaDb4uZEKYKHyQAL00S?=
 =?us-ascii?Q?Pqss56uRzLnIOkJMX5rHBsu4eYk3I7DYKJC2PGCkXmBWA3dZmq7+omIAWtfF?=
 =?us-ascii?Q?i5I0bYUGkMW/q8VJvB0Krw9xxh/tP4KiikG7i7h2dKSDqtaydbcEn9EUQebQ?=
 =?us-ascii?Q?lanOjDDWGDdJiRTM6nAmqgmwF8zAA5HiMrD1IV/6XBggashGWiCT1+WXWBjm?=
 =?us-ascii?Q?dNAi0RsAtNNnqE5UyW3lGe6XRV2RlvWH6K8ZsjbU64yMofnBjO3IZfd1lu9f?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460d3026-f316-42e6-db2e-08dbf03d1a35
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 18:09:02.8419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65ac3Ko3Bqt++bu1Fq0Lu2HqkJVHjBm17C87CyjmadIrjwRVZ0TJjbQB97+vTj8PQLb8IuilIG4TD17cQzsPeH+6U6wAXhF7SLHPwoRwFEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR17MB6115

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
> Also I do not see policy_nodemask to be handled anywhere. That one is
> used along with get_vma_policy (sometimes hidden like in
> alloc_pages_mpol). It has a dependency on
> cpuset_nodemask_valid_mems_allowed. That means that e.g. mbind on a
> remote task would be constrained by current task cpuset when allocating
> migration targets for the target task. I am wondering how many other
> dependencies like that are lurking there.

So after further investigation, I'm going to have to back out the
changes that make home_node and mbind modifiable by an external task
and revisit it at a later time.

Right now, there's a very nasty rats nest of entanglement between
mempolicy and vma/shmem that hides a bunch of accesses to current.

It only becomes apparently when you start chasing all the callers of
mpol_dup, which had another silent access to current->cpusets.

mpol_dup calls the following:
	current_cpuset_is_being_rebound
	cpuset_mems_allowed(current)

So we would need to do the following
1) create mpol_dup_task and make current explicit, not implicit
2) chase down all callers to mpol_dup and make sure it isn't generated
   from any of the task interfaces
3) if it is generated from the task interfaces, plumb a reference to
   current down through... somehow... if possible...

Here's a ~1 hour chase that lead me to the conclusion that this will
take considerably more work, and is not to be taken lightly:

do_mbind
	mbind_range
		vma_modify_policy
			split_vma
				__split_vma
					vma_dup_policy
						mpol_dup
		vma_replace_policy
			mpol_dup
			vma->vm_ops->set_policy - see below

__set_mempolicy_home_node
	mbind_range
		... same as above ...

digging into vma->vm_ops->set_policy we end up in mm/shmem.c

shmem_set_policy
	mpol_set_shared_policy
		sp_alloc
			mpol_dup
				current_cpuset_is_being_rebound()
				cpuset_mems_allowed(current)

Who knows what else is burried in the vma stack, but making vma
mempolicies externally modifiable looks to be a much more monumental
task than just simply making the task policy modifiable.

For now i'm going to submit a V2 with home_node and mbind removed from
the proposal.  Those will take far more investigation.

This also means that process_set_mempolicy should not be extended to
allow for vma policy replacements.

~Gregory

