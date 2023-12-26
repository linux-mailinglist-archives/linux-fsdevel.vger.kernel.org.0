Return-Path: <linux-fsdevel+bounces-6959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7831081EFD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 16:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5B92826DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD224597E;
	Wed, 27 Dec 2023 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="QeRV4XPN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104F45023;
	Wed, 27 Dec 2023 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6N4n3ocroZ+MxoF6yg7wk4Wu12tWEx84vUk5dKaSi3h7ugyrv3V39qUAlSzPn8wmLqu8iSh4+5h3xJ/p3OLyTntzBMJWA3qffKyJDkbFR/CZ2GQMIrkdpjTGPp4qNpXozC0hI1i8MynfCSdkUJjDxzDsyuOBN/auU/3viJhKBc834hdkd/RMnAIVhFt9WFufkxt72cDsQi6WignkvC3Ef8hbXNUM5n5wA2ZD+wN+niCHNx3wiK051fWYO2BxEjzQOI9h+9Utpdy+aKSaTTmmAoZVTG/ftUTipQigbL0AEriPkjSrneNihqleDIkqAFMOvfA7/WwhhsM3sQZ8mLd1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7c+ZDrcYBZYaF0YDc4SVzPMo14+F8R6PQwF9FDMOYI=;
 b=Xkcov3mVRBNSsUUdshhEpiUc0SX7BIlwjhjY/rVNSvb771nN8Ivejj2vEMPVS1R0WJRLXN8cIZvJgSXmZayEeD8bo9NWgbHzzEnvDw/zg9dO0ve4Wale1YXjHn+FJVXvAgeUKGmMZ9H4cfP4KRlNgrJDRay4J7GARuGziYAgkIdMJLTO5KFew6c4zGD7ZwLtMBCyOkXN2x6MFWQDygve9xgpJVH20HA4tyeBiW/zMzT6W/IZSKo3Cjaolfeg4gMYl3DbLJXGO+XMyPKzwhmTHnlnQFZ3363PeLtaZcu73S3MxHMfUlhzPPTnOFZSMmUADRhEqTte3ldl1PTzgYA9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7c+ZDrcYBZYaF0YDc4SVzPMo14+F8R6PQwF9FDMOYI=;
 b=QeRV4XPNbxMHPFQx3CWuFnrowY96j3OnA+ogb3Vo1ieeruIASIUFYb4qySXoVZnRJhAnQZknmsA/wMj6YzGWerBOsbojwV63/XgkO/Mn3nPx6+8WJMOSSRDB9QmCg85yBjyoqpynD3E7npmK8Labbqv95zOqsPT9IggpVjaP38Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB5887.namprd17.prod.outlook.com (2603:10b6:a03:437::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Wed, 27 Dec
 2023 15:45:31 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 15:45:30 +0000
Date: Tue, 26 Dec 2023 02:05:35 -0500
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
Subject: Re: [PATCH v5 03/11] mm/mempolicy: refactor sanitize_mpol_flags for
 reuse
Message-ID: <ZYp7P1fH8nvkr4o0@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
 <20231223181101.1954-4-gregory.price@memverge.com>
 <87y1dgdoou.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1dgdoou.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BY5PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::20) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ee7986-22bd-4740-83f6-08dc06f2daf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z7iRoLlDQHW8QsvViGXOuribyd7tL+WO3nFhnKt7wYyljtPEshswoldPuDP165/kF4WJ8hMWTuMqYFWZPiLrDn6jpj8YNDB2/7gfD1LpxCA/+xPrkXjTMgFeUQWiEEQ5wHGwwoar2+CMM0dQJbH4ZQi72UZ5Pbd/tgCsV1mSAufhVYW9StpWHPfjkC2h2vfnzfrw8abDqP8Zktx+nG6kFB3j7Vei3teGNj78lrDutl2ILAJpBHrArcdWeePxQhHg1ygfPaynuaGBGKqczVA6p6xuTZUPNHa8On73IKEyk4OfRWJ+PjwMFX3EbbhqN4GBmNPkcuPkhQjHoYDAvvB5OK9P3+64jl0Xuz1twrgGrsaAWSh0pahOJEh3+NNlEMpCRl9bxl3cyHl6uLzC6DSSxU8VGz4Fmuw8+fD8vCHFuCijCvvq6xjyZbp9gqSf4g9pAFSkjGm3HrsZAHo8m4lUH3ERDvUygvwAMGYlXLyvrh4VEqHY5bkdDDiFZeiIbBw9rqlbh+5JLj8+0ntfM1Gw5SfpbMwZEak6Lc2L2n/hNRkyzCLQjTyGD3fiYq8GsX8C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39840400004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(316002)(8676002)(8936002)(2616005)(478600001)(36756003)(6486002)(86362001)(6512007)(26005)(6506007)(38100700002)(41300700001)(66556008)(66946007)(66476007)(5660300002)(44832011)(2906002)(7406005)(7416002)(4744005)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RF1izXHkoN0LH7PuhMf0ZpsHeEyT4M6Sxie7kW8oRWPE5GwJ1IsnQQPW/tka?=
 =?us-ascii?Q?EUfxauIXiHueXtQUcEah3V2ystSAJCT8A4mGiLK7JeWstyHG17apfG+H/Hd4?=
 =?us-ascii?Q?xq1f/rWzpU8OGOy0D21UPMoipLZX4mSIYSTDK10+V2TcPW+3nSnsLu5HIo0M?=
 =?us-ascii?Q?PMsrlULXYOkvIWoR7tYNTcPiSM6KYng+nW7o3nnb3GkdaE11AeXlLdbb1eLt?=
 =?us-ascii?Q?eSx64hklaLiGzA/yhnlbLJe2mnkBGa8MVza48nWs8/jd+9e65HRdzeqLP2cB?=
 =?us-ascii?Q?y2rkO5iPg7N71e/j/on1L0VKmRBLYtEiUjwOBY0Z62p9mLVc+W2wXKEHUwpd?=
 =?us-ascii?Q?/g9fozMDwXQbOHsQ3oKxQ0YjHgKzockH1tW2rHaxAYiJl+aa5j37YLbSSBo5?=
 =?us-ascii?Q?XmDT7tCwUOkoVsW9p0AN4qKSGDbuTdj69qgP2TbbkLOWDSid/1rHq741oG+8?=
 =?us-ascii?Q?2cqwxbFbk/0M+5Q1Er3jBoKszaMHv4Dk/Mq7I+EmYLwuDImnNC5v+Xc+6srT?=
 =?us-ascii?Q?gYJ9hK9Az/Fst3Gc3pDw+fG32eJ+fTUYeVqcHM451vngziqxhhTFXEfDx+Mg?=
 =?us-ascii?Q?z+4aoLMCovjLA9RZSRvre1vknjwlKxNz0fl1zQtrI8+x5nEL6aNLEKE3MLra?=
 =?us-ascii?Q?wtHWgohrXixjBOBZa3kfkl3fT5oiRhParAZOJ665QaPjn6sci9pzRVGzSYAs?=
 =?us-ascii?Q?i/7kV8ctTDo9q6zaSmpdvTGVvfcSiQvEl195lqcsGbKGV3NdA6T1x5g71tzh?=
 =?us-ascii?Q?H+AaIQXYIoDeiY0FTOoBUaLYqcbSMODKZlESeDdiARLfXlxOjJToMosLV9Wh?=
 =?us-ascii?Q?4ywk0iUaJogMPt/fDPsZonWnyJ/glPZaDcl86NbulhAgE1Jggsoz/jzUl0VK?=
 =?us-ascii?Q?DbYWeW+oN5dtlaaeDNWSBcTa8kuHiBh8v6ztoX6SkLIeoDKs0SSUHmeS6F6K?=
 =?us-ascii?Q?xNpqWf5frpTjzrTGc372p1XXFOfVYLwiL0igIa+jO2VNjeh+JtfFnqeT4PhF?=
 =?us-ascii?Q?N7oxHVKw8Nsqh8A+eAvSmZXckJeUKUEftuXRWUDxlis4/SUb/j7TyEWbSi8b?=
 =?us-ascii?Q?LbgkzDT84e6/yrNTG+oFSaOFQnTwUtVRMsSuCO+1KI2zUHUUsHg+wdERB8eF?=
 =?us-ascii?Q?Bwv+KmRhc0uZouTKP+aqPnTCo0bqhRT/ROSl79tK5/638XMvGbScBnu8OQyV?=
 =?us-ascii?Q?0DwVi5bi1U6JmzfHZ1w5cYKUxPq6ls1+sLYoSlahjwYeVDKz4nQCOFhsQT4w?=
 =?us-ascii?Q?KBW5yKoMSklhVePGJ+jdCeEF2m27735YrLSfM59l/64t0S3n3DxvkhmMhCs3?=
 =?us-ascii?Q?yFv2/tCCuSC/NQ0KGrjRb60pxKyho7ldC6EA1IRRsagLVpHJO4eZfvo/4P+x?=
 =?us-ascii?Q?SA7cRBIB+GP4UWVrxzoeFEJc7ogbAy6LPaMvAHu0i7zc8GCYgirzD2zIQ9KT?=
 =?us-ascii?Q?0+of7ClQetHwZYWnj89CawLgi08htLupOlXmd3xoCm3l0LJj10TNwJFxwP4b?=
 =?us-ascii?Q?sUWAZkZRctRm728UOqV4ygeKijljcPToCWNkOiu4gTcDb8StwqnaQPjttUz+?=
 =?us-ascii?Q?cZeE+e2O+9TPCT4/lGIKzN4DK7bLSksXZNoa7+whrZSmgBNnlHlYrdwsZNPp?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ee7986-22bd-4740-83f6-08dc06f2daf7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 15:45:30.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8azqdO2O8UyZQft5RZLqL7A+jbELrkMIr3tcj+bfmj45sss5YkiWVjQbl4/etMqOKJP5FRYgJ1zQPg+Zgqf3pQEEijMDOPfO4r2WYkvWq2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5887

On Wed, Dec 27, 2023 at 04:39:29PM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > + * fields and return just the mode in mode_arg and flags in flags.
> > + */
> > +static inline int sanitize_mpol_flags(int *mode_arg, unsigned short *flags)
> > +{
> > +	unsigned short mode = (*mode_arg & ~MPOL_MODE_FLAGS);
> > +
> > +	*flags = *mode_arg & MPOL_MODE_FLAGS;
> > +	*mode_arg = mode;
> 
> It appears that it's unnecessary to introduce a local variable to split
> mode/flags.  Just reuse the original code?
> 

ack

~Gregory

