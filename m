Return-Path: <linux-fsdevel+bounces-7138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D087C822242
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 20:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C2A1C226BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 19:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FACB15EBF;
	Tue,  2 Jan 2024 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="lWMXEvMl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CFD15E9B;
	Tue,  2 Jan 2024 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heq+X1AflAAtE5DOPm6JKiAgS9+PhIO5yV1hEDBews8Hu15b1sVxh0keIBtEyRPn2LczyRmp4pDPuZom0NYMrnzQW2qMYPlalEBlJ/ddEAFwPtjczTkHX2ToAA5HQqAz1+DoNNlRU/tuBz8yiPoJOonNYzUVY5Cza9OtDFT3x5WWhIN+qfKR1JEq53fvqfVqLFtsaXJmBmclZupmagO4+HccRcuCPI7UIpHF3U25iG1m1+PIzSAhi19dBoL5i4xm292xJhJtfN8eIuwDaPL+QWdrQmj6Cru/h30bqqGr+fHa2tJbxdGE1/vDKqoTGG0+k2BwOyZtLJOX14oBQgD5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzubCsDBVqOU++etgznuujtNiVt1IyOkrSJerYlfspE=;
 b=nOFqP8wQqHdSKk1Rq4nF2Y/S3QzP8Bx06Fd3tXGhyUygETUC5Oif2aFeXzxmn+EKRGaVO3g25egfDgB4U+t88UjXTF+PG6vv5NE4bckLbjiuLBgv1MIw++viLVl454x0ecm9G7/789dUhCcvzXdsx304Ofp5QYvhlI+mMrPpog9theqc6U0TJZMK3GLjyEeHjTAVUMBRlI4r0zup0gSY/Y4XXIzxjINHmMDY2EDodfrP3S3BD9ZJUcnV06yi8TRlXFpeRNeo1bU7YFUpcg8zalbNkwFQUIR3DKp7LoT+D3Qc/+sQxcoT8OA/r+DSKe1p9Y+t//aV/YNPOoIuWnKWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzubCsDBVqOU++etgznuujtNiVt1IyOkrSJerYlfspE=;
 b=lWMXEvMl5DHcZOHMj+wX0/og3rC63sxX5VI3LiKJ2YS9DLJv6+KRhi6qqvAI4TqaYOSgfRVYDr1Y+Qf4JQxMonEJTQ6oaZ6dyaSOcFxHz94upmaku+l6QqQTe+J41F0JTPZPh9H2zfw4aB0kpbEclv6USAuNWSG0bSmkbobfzrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM6PR17MB4060.namprd17.prod.outlook.com (2603:10b6:5:25f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 19:45:32 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 19:45:32 +0000
Date: Tue, 2 Jan 2024 14:45:23 -0500
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
Message-ID: <ZZRn04IiZhet8peu@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
 <20231223181101.1954-2-gregory.price@memverge.com>
 <877cl0f8oo.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZYp3JbcCPQc4fUrB@memverge.com>
 <87h6jwdvxn.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6jwdvxn.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM6PR17MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc98c70-005b-4a48-d878-08dc0bcb616b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zUbQT/xQOy+TjuAEDB4pxsoWY86pKl/zid0x2jmDzuNNAHRzsidsQ/FO+JaoeUgsNS3/f4FsNVUz74Zto2oHO0DAUPA1bPT/IT44nCByb5Ohs4mbLM1h/aekOTCVVXq0CDLZl8d1qlHA5MYBV6kUL3HWiZmb8j7/uLZ+Jtd7/JIeK/m/suf2ZdVhEfXGuuLmgBywRXxx//R7Nvl9Rf5ArkVZUEus96H7FlX5PzOy5LaV457pihewCG1yqG0measm51q71cwtH6GZTDoXnnU5H37LeqtZJvfh8EHwOQrJyMxHaUH7RTbp2ShCSOohmRxUuhVcf/vIwkgxscRts0MUVOv0ZM/DEFkUTLx3a+T9J4lztXM0H3BsUtvMNd2sIcLduXn7myhIe/+JmfsEzD7vyXZvo4EY0qsDlJ11VR0xqZAj0moZGnSWg5TPEQVDpaE5jvGAtM12HK/bF8w//6p7rmnkRWjSPTV09waNr46kiqz47u/UqMN2tO6Kt7hXtTfEHgaS45MNAcYRpu8QaSomS82urk1Jsl/vzzWVEv2Ca4An6KvEy66ExG+Fa0Sm/RxvQ1wyStWs9lIkiTe2SLs1XIRc0uc5pYqADsJTGk1/D4Vcxc4o4YAOwOu2g/iQpd3d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39840400004)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6506007)(2616005)(26005)(6512007)(6666004)(4326008)(66946007)(7416002)(44832011)(5660300002)(7406005)(41300700001)(6486002)(2906002)(478600001)(6916009)(316002)(8936002)(8676002)(66476007)(66556008)(36756003)(86362001)(38100700002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dszv8xCzOQhwtlo7ElG/fTL9dHY5aysUczdrBuphMI/tby7UqkiPXCnRNxLp?=
 =?us-ascii?Q?XC63RethZ4YRDIzC2QpwgWh4mVWF25mHrwIcm8X0u8Oc+ydUIHMtkQFYIhlX?=
 =?us-ascii?Q?v7isez2xbTQfh/avxCqus8hchmlRa3ltnXlZvcGdXQk1eTkyo+j99NgThneP?=
 =?us-ascii?Q?znXgf/AVSU9wvOWSsDaed7ENqK4+LLtvVevfXG+ekF8xl9767e99b/lhKuvM?=
 =?us-ascii?Q?QP02ktNLEPTJoef/yiL4Xl9ZiSyofKLuhkVK5mtJvYu/dhOGd2btt4rB6DvP?=
 =?us-ascii?Q?7vVeBNoyGa6wqXFJPoKKgwJi2NJmFnYvczn+ok97WqolNjpUMKPZW4DL44lo?=
 =?us-ascii?Q?QzEZqb9V02EZXE/p3aSJoOs2AjPJaDQz/3+gli39+tHfbIaXRi3oQEw56cO3?=
 =?us-ascii?Q?TQdKuIMwHsDYZHZXz6eXykzMDKm2ujyoTCAyz8dTd5g32mgEYtTCGQUNL0pK?=
 =?us-ascii?Q?We2yKXmRTmTHHe49aT90h5k6IE474IUwyBl+WoYK39Ak2xYHgxsrSxnmIr3b?=
 =?us-ascii?Q?Y48abXYGQeSZWwqNst1Fn7AeWxZOXIRumH8ujZJY/W7kd8z0Lx19Gt8bhzcP?=
 =?us-ascii?Q?kf1HTq5nxxho5clcZkvxoF1ykzU3lEkmL/ib61APm2XdnmUKTMy1g3j3dL4T?=
 =?us-ascii?Q?7LZQobvAVl/6Hay+ixOFs7UxjsmMcWdNpqAvkVo45kefhNLaPRcRRUp9dDuV?=
 =?us-ascii?Q?gkHMue8DRzoAFIyjjjU5R5YBGv2Tr6JDoz8ddkQEXY+6o3gDFw3/h3Yp/t21?=
 =?us-ascii?Q?R91yPgigj+AlSMUQ7/MEvfbqhYS/5e0iz0tJrMI0OXYWWhNLSEufqKfWswQ+?=
 =?us-ascii?Q?CGK8xXfp7JROnGj7hyDrB2KLkNdNWF+1ibVG/Q18FYHYU16KlfPQAD3p/4M3?=
 =?us-ascii?Q?InSj5ScydOSvGMnYNs28grQY2ouCrze0sgIOobvw5mYZwrRucsKnwN+6DspZ?=
 =?us-ascii?Q?HxI1qJxuKMfjU+Y0ClsjX/64pJHzXuimHpq7fHDunHJN70wO1vk6vLa5PqPS?=
 =?us-ascii?Q?rZsTeOahknyXQ2XfWMl86ifOh1wvh2EVdEbxj0t+y5siQr8Jh1lKCXwGc19e?=
 =?us-ascii?Q?ZdzEfik+rGJSVrT2Axz/LvKAC2Am0pP1t+NFWoMx7U7Wj8jv8iK4GSnuaRS9?=
 =?us-ascii?Q?rVyWpTNRZbjdDlF0jeEg27mI6uIlMzGmPxzGoHS0id7uwrM5fI/8/PK92rxI?=
 =?us-ascii?Q?onM2XZjYs0BU4MP9GqIUkzl+NleyYanrjwPZqD05fhc3KuCTpejwEz06UJd/?=
 =?us-ascii?Q?sx/BnJ/JnNhUopuOq/lq++qX+DPsX/R8F8Q5L6331nUXNROusYvBq1ic7iAV?=
 =?us-ascii?Q?1DWEdMbUhQ2tI6pLRrpE3pm0ctJdVyKrgoIpi3CqtC6LQXRBPopBY+DF/v25?=
 =?us-ascii?Q?uHx9qJmlDpO33KTsR5ajrM60+IxftGyALSilC3bJB5yk6JHgy70TfYfveHoc?=
 =?us-ascii?Q?JI03+M+xNNNai8VY8FJJUEGOwhj3mPEPcnwnvsIy7XG6op3nAQtJeEwAPZT5?=
 =?us-ascii?Q?p6LcbTpw78udYKauuzvEEr49pVQyfhp/xdwIj0yG21gOJ1b0BmkQPyt3SBun?=
 =?us-ascii?Q?qw9lfsnvzfGLPYJ27rYgrG/Iv4MsH6vnkTQprJ93D9MQJJzfoGtbt1DtVI20?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc98c70-005b-4a48-d878-08dc0bcb616b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 19:45:32.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5jOEnBaqtttK7BYwshopAijyeEK1b7vRIL9FfcYkrsdxujBJup5yI8QB2IQ/mDRUw+DxRz1mFa73ksYByQcpBYeiV2GpZGCSAz1s0ukpF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB4060

On Tue, Jan 02, 2024 at 03:41:08PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
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

You're getting a bit ahead of the patch set.  There is "what is a
reasonable default weight" and "what is the minumum functionality".

The minimum functionality is everything receiving a default weight of 1,
such that weighted interleave's behavior defaults to round-robin
interleave. This gets the system off the ground.

We can then expose an internal interface to drivers for them to set the
default weight to some reasonable number during system and device
initialization. The question at that point is what system is responsible
for setting the default weights... node? cxl? anything? What happens on
hotplug? etc.  That seems outside the scope of this patch set.


If you want me to add the default_iw_table with special value 0 denoting
"use default" at each layer, I can do that.

The basic change is this snippet:
```
if (pol->flags & MPOL_F_GWEIGHT)
	pol_weights = iw_table;
else
	pol_weights = pol->wil.weights;

for_each_node_mask(nid, nodemask) {
	weight = pol_weights[nid];
	weight_total += weight;
	weights[nid] = weight;
}
```

changes to:
```
for_each_node_mask(nid, nodemask) {
	weight = pol->wil.weights[node]
	if (!weight)
		weight = iw_table[node]
	if (!weight)
		weight = default_iw_table[node]
	weight_total += weight;
	weights[nid] = weight
}
```

It's a bit ugly, but it allows a 0 value to represent "use default",
and default_iw_table just ends up being initialized to `1` for now.

I think it also allows MPOL_F_GWEIGHT to be eliminated.

~Gregory

