Return-Path: <linux-fsdevel+bounces-9481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFDB841A95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 04:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE271F227CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 03:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AF1376E9;
	Tue, 30 Jan 2024 03:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="Yq81/c9c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B22037179;
	Tue, 30 Jan 2024 03:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585648; cv=fail; b=U5iRWsvcjtx2DXIZJSFfDmdZV54v9V0Ce/bs98OgTye934GqAHTn7AGVclY2IFkzwk5sKa/F3KKwicFvWHcgDWC94+MGcX+4z/85DmgBb3V2sUDdDhtZg0HuzS4uQos9B+ChJufUBBSFhe1rNU8zjh9GnYflpo1aYlTp2QL966g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585648; c=relaxed/simple;
	bh=fhQX8V9GDH5mchNPpUc3wnynPOHyBJb71oau9dMivFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lofy90nk87+kMM9+MaKuYDqytWXeom2bBQJ4Jti7hsuPViKu1CKMxzgsGfse9JIJyQ/OTAHeQAVhvJqOz/GEMATgR0vyDDbVQlY/Yxx13aPTpclplvvfZMSKlEAJSQ9DqsZd0ykFbWI7UaTUwg2IGC8um2krEDxXUUAvpnsavB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=Yq81/c9c; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RT5nulvyO7gmPKVsbsdlsHZqe9RLDn88Cim2jEf6Zn4vOaLqr+IFVvo4UbQVOulEqWK+ptdN+0eaV+85UZKJkL6CMp/sstiYMQv7kf/p2BIfkGUDPRfCwZ2C2FxnxpiBV5A29maxt+TX7XSPe4Aj2bkmJ6Lubk3ZQwNscgEgXY/PI4OEayV1S3jqKoyYVHxQWj25Osz0NF+/gEg5FL8GMqw80hOQ0tvqwkEhHusfxvjW5Bnajpee3HIBk738OnkSXhf0nJtJR/5u/044fAPvZc1eryELobcD8KcfTGetxCDOLe55GJ0Ql0cKOiA9L73344UtUaZnY7z5fPCAORPF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La4Cdg6aFM1LlfEkyKv2rVusN5IygLDSbsfwmud+clA=;
 b=PeeOTR7oIHbtpPPfxV6TKJ0I9kC5yyU4fP8+W+avXRDdDRiaSTM5Jb8JamMAtJQUf17LYyUXvETIJ/c9xwWkVY6xTKkAkCWisyYkJffvgNTTBPntkjbtTQWss9V+EYc5FMdiBFJ4r2i0tpSeDgGlVaHOLRzKkPrV800iZCRJZqmrXPax0QTGpNARjLihNYRkveAUChbOrHpATT0fCRLPnzqnd9P5Pwawe8Ob2KxCe9iNnzuor9NfxJY+53rwtEqm2HkK+yYo9V/2PGtsIox54PJvdJaV7sYAGveeJVlDoMdb7ArzTXowzL3z+3yjswjXZVSth/FJDHJtJYOnFXpi0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La4Cdg6aFM1LlfEkyKv2rVusN5IygLDSbsfwmud+clA=;
 b=Yq81/c9ckIwuabY1unKE77Mer02u7HQYs1YFJs9OVGjhrztef/+oHxiguQNzYWdOiOKxLEyXTm8Gxrhy97m/mzlwPgpC/Svlm0GyH0mg69rqO3KRp14I2P4SzWTuAF/K5gQ+ADRKtGV0bdGLUNtuZAVqSPoLvIG0wz+DqNeVj8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA0PR17MB4282.namprd17.prod.outlook.com (2603:10b6:806:ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Tue, 30 Jan
 2024 03:34:03 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 03:34:02 +0000
Date: Mon, 29 Jan 2024 22:33:57 -0500
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
Message-ID: <ZbhuJTBp68e8eLRv@memverge.com>
References: <20240125184345.47074-1-gregory.price@memverge.com>
 <20240125184345.47074-5-gregory.price@memverge.com>
 <87sf2klez8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZbPf6d2cQykdl3Eb@memverge.com>
 <877cjsk0yd.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZbfI3+nhgQlNKMPG@memverge.com>
 <ZbfqVHA9+38/j3Mq@memverge.com>
 <875xzbika0.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xzbika0.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA0PR17MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 598d13bb-a308-46e1-2bbf-08dc21444dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	poH0aLavCCoG5qLp3Yz2AxP/8/ALlC/BOuMYFQxv3O2PEDAGBpufXXEP/aGO1a1gbBfZJgnBi+W4FQcjmB0Lv6YoQQOwrZglgmzRs9ltSiXM0NqA1SItyQSrr0ICO/Dce3TxK9OUk0BPSX81rKWhOjtJCyaFkoLmgAbcR40Tsfa45XjQyDBVlMeV6PyGTJqZKMdWEp6E/1/zK2XefSYop4rmRHw0Ek68ZAjiZwgt0oZA+8LfmK8Ji6GmfbFJ0dyPSrLZ/jYsupvhYvybkUzlvJGh19oeiWMZvOgEoLSi5XLDnZQ5xQSYMmeuAa4ysw730HaaFoVZLhoigJ+FTj1VtpXPJOouTM9nozs6e4J7R1C6q1elFFyC3M1uZzbaLaBkKYyPKRtzWk+s3Sfx/EdXh1g4l2ELVP8K+hZlqpu+5dxWp0LlC5iicoEdfMGvOp+Vmu9jcTXgm1/bKPQjwplfPYHpI+YGdiP5bPeFgx2yoXSmauylp6mMwsY8KTlP93M51tp8SASVSV+3Xt1pDEi2wcxZYzF6y+3TQUzvbNxCUUtnsfRpyUORLKU+ZQTJIGZxw/+MfKav3HO/86rnyO8XDykYvstGP4ogu3JNz0hFEYE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39850400004)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(8676002)(4326008)(8936002)(38100700002)(66476007)(66556008)(6916009)(316002)(86362001)(66946007)(36756003)(41300700001)(2906002)(44832011)(7416002)(5660300002)(6486002)(83380400001)(6512007)(6666004)(6506007)(26005)(478600001)(2616005)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XSO7zTeGpvlrIKx37QqonTKuabk25VHFh2C1zsfK9RaHkAnSPb6DPN4etKQa?=
 =?us-ascii?Q?Ynmo+T2erlx+yOc8mt7NzCoVbD5Z/kHjXJ6br1TqKCuTvQQYx5JaP+Lsqg03?=
 =?us-ascii?Q?hGyLif0j2sz/Ko1zCD2urxJ6tdRFJwavtGfMAem8zjBad5hd7eRlTQ0swrul?=
 =?us-ascii?Q?0iDEjTGbrGhXmucuKw/miglTxvhe9OsVIdo5FNP524IHMXPqMnY56uFuOq3v?=
 =?us-ascii?Q?YaPL8IMuYLaWcQgw0APdC+ZFCNk7EUZpUeX7jaD06Ta5CvQytVHR8MNq9+8G?=
 =?us-ascii?Q?0y5C7SYbYP9IIRQTa0GU9bb7/L5GwlFwsZpv7GrTi9GEtQmW8cnACbXBSRf0?=
 =?us-ascii?Q?LngumgJD5HbOSfNUl4646P3XW60uaT9C83SpF49Lcewiy972Xw+vqMCGmW4e?=
 =?us-ascii?Q?Tsjy3OYCXANfyeSH1jqoFsZ7rYPSCleUT7lqGHfMgdwHToSSZzlFjIiMEpXl?=
 =?us-ascii?Q?4ysBG5/2YQMW3P/kDlsXPZUnpGDkt+D0bW/w836rTpQx1iiaIQVeHVphsF6N?=
 =?us-ascii?Q?3phvgjRRJbvcIlXjyuzzRh5OoUKPtUXqsr8WRtn9fJoiwx1MhjPNvw5PRUYk?=
 =?us-ascii?Q?8oAvkjSS45RHtKfPrxHVvTFC8LRqVkkBA7d06bAdQ6LsZ4HD0SStcIuHf/+a?=
 =?us-ascii?Q?RwRWsOrIsEBCZpdYmbrQRSj/wnQuZpgasvl2IA44QI728MBpVZInyZjmZi4L?=
 =?us-ascii?Q?l+hyhht5MKcJdgGOj6f967f+q3QOLBYi7A7OGi/ckvX75QP1VjQr2newsvV3?=
 =?us-ascii?Q?H4qd7UO9I5gTNZoYEYYAvetjY4m0Ct3+JbOu13dEgtm5hBH+byI4scGGEkvG?=
 =?us-ascii?Q?7AxdiaPj8rNImclBUpUlJoFSaGh2xnHifxTK4LOQBgs7OymHOlf73ihirOhC?=
 =?us-ascii?Q?cUtEbsC5ToJakVyJWE0+Sy8irEyp0P+wEaVlnveZx0Ix2bsbcYQ4uzNoQbq8?=
 =?us-ascii?Q?uYoJa/Dh9RS6SplUZ1zFQoSWJYE+TTAIBXL7tKgFbd3ybCxorUHp5rF6H7zW?=
 =?us-ascii?Q?hywhCPqmJxANburtglmVnP0k51f6E2toTlwNcF1AS5KuLbuxDu6m3y30/+uK?=
 =?us-ascii?Q?0eqXKIri4DBGuNMsSJulxvYc5znz9PdTUDqq+YKnoT8WxYiwP0r2Uo3PzJiB?=
 =?us-ascii?Q?b9tmO1smujNv8ssoIHcXzQzNhFxJ0/Wryd6mUvrZGrorWYJyn81Vq4mAVI5i?=
 =?us-ascii?Q?vTZLuB97zKAiHHyI8Pqgr3KqMMDDeLyFlcRNxblsrMu9aIoohntNGHQyAiJz?=
 =?us-ascii?Q?heN4MUcAM/nm4whPxt4sz3JAmUVQrDBoe5f10qbt5O0G5M8AVKG8QPiGCJpg?=
 =?us-ascii?Q?3Jv2CTj2i9NUt6a8QsxJtzdLlDXqa5B5yXJq3FKxTs8W49hhfR6GeSw0TGH8?=
 =?us-ascii?Q?2/10Zecxe5I1ZrUN1aqt8xx6/x/Po1Ss1ziCubBI8uoCbO/b4mPnUm61CJJ9?=
 =?us-ascii?Q?FwPwqAzCZdk+lGnGdl9J0vew+3/gs7+TeObnHgfQjH8bmfA471mGQgXEX0Fe?=
 =?us-ascii?Q?YgwcJ0z9QJbzUCE8pAuVNH/bDuulmGowzKdQklPRKVj2F7hdKjts/zAFFVZT?=
 =?us-ascii?Q?MbMKB/lFiiiyGr7UKJDfydBvNWEZBu4d8luUHegOTHUAWi9j0b1VmbRrBnBX?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598d13bb-a308-46e1-2bbf-08dc21444dc2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 03:34:02.7626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7Px/sInCVRCI+J9ch4Rtq6sGIq1Ga7bKGpdSloKOnkEduwQaOI2NleoRfnEEIgRGa7dQfuIAu3UopJcEeBqKLxJzQ/gIxL1IdOtCoUVISc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR17MB4282

On Tue, Jan 30, 2024 at 11:15:35AM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > On Mon, Jan 29, 2024 at 10:48:47AM -0500, Gregory Price wrote:
> >> On Mon, Jan 29, 2024 at 04:17:46PM +0800, Huang, Ying wrote:
> >> > Gregory Price <gregory.price@memverge.com> writes:
> >> > 
> >> > But, in contrast, it's bad to put task-local "current weight" in
> >> > mempolicy.  So, I think that it's better to move cur_il_weight to
> >> > task_struct.  And maybe combine it with current->il_prev.
> >> > 
> >> Style question: is it preferable add an anonymous union into task_struct:
> >> 
> >> union {
> >>     short il_prev;
> >>     atomic_t wil_node_weight;
> >> };
> >> 
> >> Or should I break out that union explicitly in mempolicy.h?
> >> 
> >
> > Having attempted this, it looks like including mempolicy.h into sched.h
> > is a non-starter.  There are build issues likely associated from the
> > nested include of uapi/linux/mempolicy.h
> >
> > So I went ahead and did the following.  Style-wise If it's better to just
> > integrate this as an anonymous union in task_struct, let me know, but it
> > seemed better to add some documentation here.
> >
> > I also added static get/set functions to mempolicy.c to touch these
> > values accordingly.
> >
> > As suggested, I changed things to allow 0-weight in il_prev.node_weight
> > adjusted the logic accordingly. Will be testing this for a day or so
> > before sending out new patches.
> >
> 
> Thanks about this again.  It seems that we don't need to touch
> task->il_prev and task->il_weight during rebinding for weighted
> interleave too.
> 

It's not clear to me this is the case.  cpusets takes the task_lock to
change mems_allowed and rebind task->mempolicy, but I do not see the
task lock access blocking allocations.

Comments from cpusets suggest allocations can happen in parallel.

/*
 * cpuset_change_task_nodemask - change task's mems_allowed and mempolicy
 * @tsk: the task to change
 * @newmems: new nodes that the task will be set
 *
 * We use the mems_allowed_seq seqlock to safely update both tsk->mems_allowed
 * and rebind an eventual tasks' mempolicy. If the task is allocating in
 * parallel, it might temporarily see an empty intersection, which results in
 * a seqlock check and retry before OOM or allocation failure.
 */


For normal interleave, this isn't an issue because it always proceeds to
the next node. The same is not true of weighted interleave, which may
have a hanging weight in task->il_weight.

That is why I looked to combine the two, so at least node/weight were
carried together.

> unsigned int weighted_interleave_nodes(struct mempolicy *policy)
> {
>         unsigned int nid;
>         struct task_struct *me = current;
> 
>         nid = me->il_prev;
>         if (!me->il_weight || !node_isset(nid, policy->nodes)) {
>                 nid = next_node_in(...);
>                 me->il_prev = nid;
>                 me->il_weight = weights[nid];
>         }
>         me->il_weight--;
> 
>         return nid;
> }

I ended up with this:

static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
{
       unsigned int node;
       u8 weight;

       get_wil_prev(&node, &weight);
       /* If nodemask was rebound, just fetch the next node */
       if (!weight) {
               node = next_node_in(node, policy->nodes);
               /* can only happen if nodemask has become invalid */
               if (node == MAX_NUMNODES)
                       return node;
               weight = get_il_weight(node);
       }
       weight--;
       set_wil_prev(node, weight);
       return node;
}

~Gregory

