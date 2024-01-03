Return-Path: <linux-fsdevel+bounces-7154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46B3822753
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 04:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E6E2B22EDE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 03:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D384A2A;
	Wed,  3 Jan 2024 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="Sqb1xVjS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DC81798A;
	Wed,  3 Jan 2024 02:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpIrYzvIOG/xZMaPJRgnfKlgZj+PvJ/G17f2+viQxHiI7ARlaHEU94GfKMGYLw3mhWGqzmhRPV4yBNyDXUaFaEYgztDW2ifOtShHkYCFC7250EnPdIfckguUyihSxU7E+V0rn2tKd/9nuq6yclJJVCcj8LXAEPo0sRoMLa0dowNirTnpzlbOBJtiPgg0Fw7h6NXRTbsnRT/c2lu08A8kiuzEIcKFb353Ry1EEntNh1fWCD8VAYqK9LH6ACi27d0bhr7RQhuYi1sE/+y7So2lPwTqU4cwE810XWxQlWHUBd2nMrRikz92gGrmBAT9bYPtZ4Ky2ID5D5NKmreufKMvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5t6X1FBHMniySVIsTvf0TzQld9lbtdwuvMQ/RpBzDQ=;
 b=a2PwNv2sNCEfUypCdsHxtMLdE4qiWOar83GqUnDoCfX1y2dlVFa8vv4K9dPz40NVWsP2PAULGXxomK3a0+vS3w+SEsN/KuVz5T1j0nhw3TjMJbkuFaQLgGr+FQfzkjtmoQF7bBU6fa7Gy9GKIPrNeSMADA7pjqKub2ndFpRiBzp6tWtbwauImd14t65DYn5536gUaCXAPSoDbo4HWRbyq8UuOLwyviwVitxMusUBCbvPyi9tvbhYV2t9DVCDy/jpKrScQ9kWSeVqmwyhjsi1ZC+mr/VBMurFHUMmSKUhTkkW4yor+wR8Fpfpl3NUnJHlApxTgUZHKlxYt76AXYO04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5t6X1FBHMniySVIsTvf0TzQld9lbtdwuvMQ/RpBzDQ=;
 b=Sqb1xVjS8gqA5a8dsNt+LtHvAd3/V9IQGv3utHOzWa6bcl9wMICZCVwtb85rsmZvyfHpu9+VENOvr4kBKq4woS08t3unQTTmTL5/uzPHoJv3f3yoa885YLxXfcIVTwR0TwIUziZ5tk/K9YWFRFl8Q6kf4dBr3JYz4ySWJ0FVwkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM6PR17MB3897.namprd17.prod.outlook.com (2603:10b6:5:254::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 02:59:53 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 02:59:53 +0000
Date: Tue, 2 Jan 2024 21:59:48 -0500
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
Message-ID: <ZZTNpGhj8EmYBB70@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
 <20231223181101.1954-2-gregory.price@memverge.com>
 <877cl0f8oo.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZYp3JbcCPQc4fUrB@memverge.com>
 <87h6jwdvxn.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZZRn04IiZhet8peu@memverge.com>
 <87wmsrcexq.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmsrcexq.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::17) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM6PR17MB3897:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d75169-714c-47d9-5802-08dc0c080efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T1Dp7DK90B0WQRl3RK+isZ78jSCHs2RWta4ZyB0J3dtaK99Hcnhb2+rxII6uFUI8jk2Hc3nHm38DqBQnyKMItruCtjg+RQ9tQNh5SXwqmc+8tb6pUEquUTgf3neRxO3hajuJoqnYpjfqyRfeAe/qkVow133DhpFvGclqiImKy8Y+kCtuA/iZdR3J7VNZHeQ7RrNseMLWD0If5ucZVb9tyPrc8Ack/hHkcw31WJnt5vt3ho7JVph9vP7ImndBGru1fnTyeVUsKrynto0SUMHuIImmizQJ0qLuo9dA0RYPAbZ6/oBhuNyvlia2eTJo6tDqxuopTqKYoQM7QGwp0wTrMyhHcR4VpP2UUvyvaIV3EWTxIMY9aRu7b0Uskmgz9O0k+9HNfMnCDe847bQSq749eIaKc+GG1LbhYecA4Uulp1HeekUiBvoZZEZGd3xlm0tzN4oBjru48en7nq5pgjnbzO+Zh2PS2S9SrM0MB0J5XknYhKMIGwJznPhr82YQpRZugJFKgSNviqsCzU6vjW2RwqftTO+m22Zq3Bq9zlLdTohj8Ko2s2PM4eWoRTYrkLVGdopJfukD7a6re9ZB7cH6qeIVP5o1XKZ30w1aCLLuQcyNOVUZ01t7ylG75SUIRIG7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39840400004)(346002)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6506007)(26005)(2616005)(83380400001)(6666004)(6512007)(7406005)(7416002)(5660300002)(4326008)(44832011)(41300700001)(478600001)(6486002)(66946007)(2906002)(316002)(8676002)(8936002)(6916009)(66476007)(66556008)(86362001)(38100700002)(36756003)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QKw+WFjAFpyK1hRao2bU7qLCFyeuykkOLEWiqAIl4FmS1YY9CT6rgPV6BnbC?=
 =?us-ascii?Q?8+Svg2diQY6tegiIe96mqUItqeQWvmDMAUrCyGubrv15CIpP+zP0wbidalNh?=
 =?us-ascii?Q?LmhdHXgCv2Q2e1eNwe5tD0zDRIWueA1oJSApPuvfP74myE/nIrNUZgTsm/91?=
 =?us-ascii?Q?5Z7bi3bKOpxL/qncwc/L6q2uChTeB54vYem91ABI6RJILKGRTYhzXAswq0md?=
 =?us-ascii?Q?woSMRTIu6TU7dKk/zUaUH2M0bIh/Lv3yW9S98cdde5POuykbSVlg8yJS58lB?=
 =?us-ascii?Q?82va6SfFs4eW/7fZxkwlCzKB7Fc+//dvW9wVbmdPZ+qY44gjojMgpyLXa6Rk?=
 =?us-ascii?Q?/mows8Yp2FFWpEZF+8urxJj5Yqn/QRqJ+FmlK6XVai46qnRnWoG6NDCNxDdI?=
 =?us-ascii?Q?jjyvpFefo6HN0vsaxDemx47NqqE07zN9T6Z++B61iMfiRG6gA4bTv2g0wGwJ?=
 =?us-ascii?Q?u5PKp7NoQkznmA5ADyU2rDnhXn1wHB36jHJQGcN5xgdRBAks6pQqW0iaUKRL?=
 =?us-ascii?Q?q/kjcszdbnzE+MF8WAUsIcWwlq4/AxFERE3LvB5P/B6vXTl5e1COPULYpKqf?=
 =?us-ascii?Q?GcetfD6+QmCBiO81/I1PFijHmCGDTye8QVeUDIvnKdRJthZZlrwjjRT2alND?=
 =?us-ascii?Q?QCiYEcTI+GynuPVJAjyHyAj84jEFSRJncocpBmoF+MbiDCxObGbAKH4eNnfg?=
 =?us-ascii?Q?YKnH7fszvEqMPmk+h8LY252M4wMgJpnJ2OTsG83tN9+NTwMZtu6WPCSJuumi?=
 =?us-ascii?Q?EnQk98mV8Qtpiyul3eXp1q6n0YG0z56d3OZTCNDUp39DCfOurgWvi/1G7kfn?=
 =?us-ascii?Q?rI+i7DH/lCBGt45Ka/KnebuVN1p9jjJco2sUiwF+6cFwOcSYqLRrirOAO3ff?=
 =?us-ascii?Q?QOYzTejVF9NKpcS6TGc6KIQGqIK0DtQ063udEaX03g4y7jC/XBEvBJ+/4Qap?=
 =?us-ascii?Q?tbaOt5DNojPQiZdoMMkOwlxO5IgZcxfUF4aA8W4QHXG7jF1EG/6p5CAjKxF7?=
 =?us-ascii?Q?sx86968VW7Jd0zoIpg37HRZSaLzqx/nT3YpxMZquX5ZB4WDG4itjToKubWgh?=
 =?us-ascii?Q?weXjfiyQDI+gA6zcll2bzT8hB7aoHbpVjCY8wTAayChKzXr3ui8MUzS46dx0?=
 =?us-ascii?Q?H4mYCzbCm1W8mmdeEiHlJ6D2JwXVPQ3yzK5i8+bEI783ED7ohAMXbAU/11M4?=
 =?us-ascii?Q?grmBDeZrUDT/xDTnUDq4I9fz6tCUzsDhvVCyfSXG0wOdRr6OBh1j7wckfAM+?=
 =?us-ascii?Q?DnRblkTz1Vsusl/AsAtt8uPUxBF4xfQU1lN+oa/J1tdArYdd0hVP81zrOvNf?=
 =?us-ascii?Q?7fGFyZKTRbHW5FfND2KgZV5cq1FQ/2P7co7YyxMaQR1SXnWRJdzDgdybxEpB?=
 =?us-ascii?Q?Ylrx4LDDq2w45KuVZfkNh70sLUPcTqDkQqL1pDKuZTASqMDzqEP0e1l0TKD1?=
 =?us-ascii?Q?USsLoMukoJHEcepT17auPE5TKdOPQW0BW7jEOv3dSv8NX3Clc5qkPJ0+onng?=
 =?us-ascii?Q?n7bFmkfDfP3kHLyzIPHOnyjwVcIcG3EPoCWWE3qlPaNRUFTIluMofjzImKvQ?=
 =?us-ascii?Q?kz9sgZsIBtA+9nN4UsmmN4a5cXIV45l73XWY/oUxAJzgF/vw2kX8ifxvfMXR?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d75169-714c-47d9-5802-08dc0c080efb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 02:59:53.2291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdahE+vEOs+gKvb3qy1g9sPXaZX1pczML38BBKwqDppmmCD9WPSRTo9itTp01gnbStEKMvSYgg25mHwkmdR7YIbFrhnzEO9I5jkKsvMjQ/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB3897

On Wed, Jan 03, 2024 at 10:45:53AM +0800, Huang, Ying wrote:
> 
> > The minimum functionality is everything receiving a default weight of 1,
> > such that weighted interleave's behavior defaults to round-robin
> > interleave. This gets the system off the ground.
> 
> I don't think that we need to implement all functionalities now.  But,
> we may need to consider more especially if it may impact the user space
> interface.  The default base weight is something like that.  If we
> change the default base weight from "1" to "16" later, users may be
> surprised.  So, I think it's better to discuss it now.
>

This is a hill I don't particularly care to die on.  I think the weights
are likely to end up being set at boot and rebalanced as (rare) hotplug
events occur.

So if people think the default weight should be 3,16,24 or 123, i don't
think it's going to matter.

> 
> We can use a wrapper function to hide the logic.
>

Done.  I'll push a new set tomorrow.

> > I think it also allows MPOL_F_GWEIGHT to be eliminated.
> 
> Do we need a way to distinguish whether to copy the global weights to
> local weights when the memory policy is created?  That is, when the
> global weights are changed later, will the changes be used?  One
> possible solution is
> 
> - If no weights are specified in set_mempolicy2(), the global weights
>   will be used always.
> 
> - If at least one weight is specified in set_mempolicy2(), it will be
>   used, and the other weights in global weights will be copied to the
>   local weights.  That is, changes to the global weights will not be
>   used.
> 

What's confusing about that is that if a user sets a weight to 0,
they'll get a non-0 weight - always.

In my opinion, if we want to make '0' mean 'use system default', then
it should mean 'ALWAYS use system default for this node'.

"Use the system default at the time the syscall was called, and do not
update to use a new system default if that default is changed" is
confusing.

If you say use a global value, use the global value. Simple.

> --
> Best Regards,
> Huang, Ying

