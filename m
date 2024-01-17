Return-Path: <linux-fsdevel+bounces-8134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B5982FFD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 06:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35CF5B24B64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 05:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A41749C;
	Wed, 17 Jan 2024 05:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="sa2rKhAf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2162E6FB9;
	Wed, 17 Jan 2024 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705469199; cv=fail; b=KCyNHQqoAaAOpSHbiFIgUFeGyq954I9ANujWK/XpxJgXLuoCG7cURrHJuN7USPK1o8afzDfSgmwuuKuQMUQsN+YqRQZdZFZxQkKHcoFFOQfSqWP7SkHqZpwqKOFriMPMKG/c5tjPcxBu2n5/i7FtELOoo7aqX/Hzp6Uprd6wOO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705469199; c=relaxed/simple;
	bh=rzjBYrPoTm35euRfFcgGGo9lAsBWhaY6t1WpD+TnTXA=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=GfRr6FOmUKQyWYUyijLT7aqC4orhzfbTG+GOaHTd+HpK0ICjKueY8KQ/i8k1S8e64HEzGQT4CDzL2GDtu4a8kieJPWUpORRBZXvXFtNYD9xFrzPHhCOLyQnSmxD9yzaMFyVKc01AZKMbfR+ELFdB50bEUeP3tokdKa36cBu9puE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=sa2rKhAf; arc=fail smtp.client-ip=40.107.101.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAMTzL9aJkZemzhr5cyBCqMa5ZMjJC95CUtqvN8AsuS5mBi0y7zau20rHZmomy2z4IzqSQPMb7EWePViBJcM/wDQ3HOGfl1NUPKXm8ZbdhVhSbjaerykZFS6ATfp/kvKRLtNkuJe4QAOH8qbrW3kDv0pwAE65K9QuswivMILfeFsexOe5Py8nq+/uYg9q0LzlTzehpowZnZQyd83amwSkDPpha9LCYa0HDEhKRF3WKYSlUgVxyoAFHK70YMSJXShsHUP2BCoYeNTvsR1LoK2dZAvlehVtGOQG5W41WvZEmXKa/jWjm+4yirJJKxADe6CEtd+bABU6s8JFV4+VvpYow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxLc7vwXB9DzWQ5rRlwGTHtyleOkBH3StC1nqcr43OQ=;
 b=lfFJWaTDTutZae6eN/nqIdSvjYWf36QyPOx40oinn7Xrm1JnBn63QFIyss1fyvR/26c7yKjw9YerDe1GUEyEWp+ARHiEWkn7W0qHJ94qRmZETQCXRupQ+ooD2l2WB3tmJesZJaQuXbIVAwgyDlbF14/+Yz0EAqO1AYi7h8xzb38X+g36snIMGPsJmegoTb5TbIZSgeBXYtbbLMybK1XqPlDZx+rwVgt9c5pvuPXYuI5NtoTPMd8DLVYUbg68RSHZYwrDo7dvFVCOCuWeTIOSOl6TSavhCacdhRea8MgrUx5+KEf54Ghjt8H5KMaf2wc6on65AC2aZbdNHU1j1Sk/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxLc7vwXB9DzWQ5rRlwGTHtyleOkBH3StC1nqcr43OQ=;
 b=sa2rKhAfQy6iy0KAjHe3uc+hwS4keleFIGwjteL220HWAvY/x1WR9jWw2rVoNBbKin6vXVbSuwUGsIbDn7dYC5Bt9HZSjd70i/iq01bVTy+Mq1bM5oOO8BxciLrdqTwhhZtm1hj21Gz39Os3VH5kZ7muexJiinNU3HhqT17ApUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SN7PR17MB6514.namprd17.prod.outlook.com (2603:10b6:806:323::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Wed, 17 Jan
 2024 05:26:36 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7181.027; Wed, 17 Jan 2024
 05:26:36 +0000
Date: Wed, 17 Jan 2024 00:26:20 -0500
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
Subject: Re: [PATCH 2/3] mm/mempolicy: refactor a read-once mechanism into a
 function for re-use
Message-ID: <Zadk/BR4gFG07BVE@memverge.com>
References: <20240112210834.8035-1-gregory.price@memverge.com>
 <20240112210834.8035-3-gregory.price@memverge.com>
 <87h6jf1bfx.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6jf1bfx.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: PH8PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:510:23c::25) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SN7PR17MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: ff886a70-4f24-4281-6298-08dc171cdfda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IIHFvejNoU3tMsphhLKQFpJSdrqVzj4qI1OG7isFim2fYUhXuGqwHn79jkfiePeFuArdzmi4N3LkGqNeKV+qW9pR4DO58ch+TjWKduzhe/LTX8CI/vgZETLHSgTu9dlPIRV+SFMydpuBOlVgaU+dXHcE6bAMA9mp22Xhd0fWYffeIVOb68ux3jnkttMyEJCL5eQyl7OqkugHyl0k2nAKo31GTJBFe2D8NyHuz0eiDo5ycbjcUrGvIlzjnfd+iBtrLSakg28FmjUwmTxzoYkk/UflQ/q/LeGs1AM+AwFPE21ENKxWYFlfnTz5Nw6vGyJNJkG4JIcAf8hkIKxoNnAUMlZ47xDl67XHILMaDzFxWa2u3Z1HwN4F0Ys8xxRE6YySovDXTRZ9LlMA73EreoIQTr3sG0Sq5CvdnVFUFUjU7b5J9AO/RiOpU2wFyTDN+6fYOpKKy/KTLyxg6OjBvm5MzYwJGj1CgQqfEiG8UbWGp2fU7t28I9q5Dg9TqTsrceMYmyCxlEV661a32S/b+KMVBQ4SPvmUOx9KryaxSX7VH6CX6rAAQBx8vfWCdcHO6DBz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39840400004)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(8936002)(8676002)(7416002)(4744005)(66476007)(5660300002)(66556008)(2906002)(6486002)(26005)(2616005)(36756003)(86362001)(6916009)(66946007)(316002)(44832011)(478600001)(6666004)(6506007)(6512007)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vm76eHIBCSAvX6RFUelF+rDdh4siq+RBnoXsa78kWbEIRDYXYnUItUxWHI5J?=
 =?us-ascii?Q?L/t8q8G67sBTD2H03PNJBAdW6B9TmT7YjpA6Suwp0k6FlANEy77I6ydFYr3x?=
 =?us-ascii?Q?dH+X399j5lAs45nii8NUnd8qcY7pJp5ErfSXB1WFIMNAZE8wJWTOmHTtHqMf?=
 =?us-ascii?Q?7wGHDBUBvtfrvvolFkQTwsI0zM3HWGCh0uP8PmIbiUGbDMAmxu58Datttevd?=
 =?us-ascii?Q?DNHm0A2CBGbaiK0zOxL2a24JPN9vs08O96dsVitN0h6ZIEDJ4Xs40gZnPG8r?=
 =?us-ascii?Q?rZxkqzGhcZ17g7Kf+GIBKT41TSlUZXL0n2TZLH+E1TJ7KqvOFmMBamriKib+?=
 =?us-ascii?Q?OAJL4CwusvTpmD9crl06GMfJWUcTXsbRf9sMaMm6/1GWN9Jz0O41M/SFrlHm?=
 =?us-ascii?Q?tUXTx8/3AthJd/MJq5PIBer5qvYYcdo1yd68YRAJ3+UTe8NNxYOs3+qAyzyb?=
 =?us-ascii?Q?ytU/KW7AfDUcJDHfpeZ7axmkGsLpaQKqZM3bEVtMnkicuMbdjl5iywBIEQF8?=
 =?us-ascii?Q?HrO1LA4y6YJMIo3QhNGJX+GObeJtVv0jZ+rjzo+eG53v8QT591hkG6w85EQr?=
 =?us-ascii?Q?Wt3Wg75926FjoM3wUKH5x8zkaF3mZvFQ7fy9LI0CobZVpDBfIth0TwiendsF?=
 =?us-ascii?Q?+FHs/6Rxupa2Gu+Sr/CHrnkWMF7kRow/17EjEGKkQAcHH0U1BPx42ogCKpTn?=
 =?us-ascii?Q?RoVzN4CZBJ2XxitM2F4VmZChmNnDP/g5nzCpmejH6mk/ligcb2xkd1lIQZOc?=
 =?us-ascii?Q?/gonZBk9ecuWPlxnzmXcUJrA1XRK9RdrV7JY4SdykBywpK+kw46HH3dTgYQq?=
 =?us-ascii?Q?E7DRLx2hr+xXPZnUjLTrWhrDd3eoDOxaai3kvT7V1tLEVVprbTj0YY8pZj01?=
 =?us-ascii?Q?wEdME1Qz2IA/NpZ/NAckpMiZH4hDEuvvn5zt6WladKRbKB3MTTgSDwI+s9xW?=
 =?us-ascii?Q?51w8Z6tODh1MRr/HKp+0jfM2ybkt/NnWKdvq1Hwyd1S2LIYtBZwWrHAiujF1?=
 =?us-ascii?Q?OZOGXh+0o1dmnTi/boXMl3Rbe4LYrNhkgyYVO+nO4tXYjnBTKYpbfHOrCsQu?=
 =?us-ascii?Q?/17NhuLvejRPqdKFMHBTrzvf+8PzNLvugqqr9QWBCtl299wiJAS/PJ6r7ZZf?=
 =?us-ascii?Q?ODxy1FfeqwbwMckcYsFSlDF/S7Foe++/nHQItbVOukps8h6VFZF8rFu8L0FS?=
 =?us-ascii?Q?9ag8vDy4JOJ8TL0qYB3jaWeyGhiIOGioIfsYhZ0pQ2zc2m5kPvn1r9YPImiH?=
 =?us-ascii?Q?WK/Lj8/lkYr//Cq3ViEk4GBFXpb1sr7r6N8cjcCRFaVwVmYTTFeOwLcCyUKk?=
 =?us-ascii?Q?w2E8EAHqawIdnRBzL/pQa3bTxqiamPoM+FuKjYXhiz5Z8lYAfdm+XZ5pxJwK?=
 =?us-ascii?Q?nX5A30MOyhbIQvoH3CJg6UXeb35i+yamZNOAK27BowpY9nodXnl5dYDZIqzo?=
 =?us-ascii?Q?weB+demjCDQxBszdD+ktD8BUcNWwXsbon4Tou3AkytQHv4qHL2w4+VNcBFxw?=
 =?us-ascii?Q?NPu1yKYEmX2L09JfeE1NDbp8I7JFbhDcS/v0Tt/mP32JVgfABOhRO4eFY0VJ?=
 =?us-ascii?Q?tNX/8RHryMiqAk+BI1ahhjgh9NllTuTfn6IWe7P8ckLdjROZc9Am0ndZ66k8?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff886a70-4f24-4281-6298-08dc171cdfda
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 05:26:36.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISoJKJEbzdl+5CzTYLUK4Efs+TEdRZH34jKf42svSildHgbC94HIf5EarEikz2dDqjogT4SZO9IFpBxREQgKCAmKrl5oLspPkT4E4WXXrdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR17MB6514

On Mon, Jan 15, 2024 at 12:13:06PM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> >  
> > +static unsigned int read_once_policy_nodemask(struct mempolicy *pol,
> > +					      nodemask_t *mask)
> 
> It may be more useful if we define this as memcpy_once().  That can be
> used not only for nodemask, but also other data structure.
>

Seemed better to do this is an entirely separate patch line to avoid
scope creep on reviews and such.

> > +	barrier();
> > +	__builtin_memcpy(mask, &pol->nodes, sizeof(nodemask_t));
> 
> We don't use __builtin_memcpy() in kernel itself directly.  Although it
> is used in kernel tools.  So, I think it's better to use memcpy() here.
> 

ack.

~Gregory

