Return-Path: <linux-fsdevel+bounces-6517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D48C4818F93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 19:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6AEB2646E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 18:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6363C487;
	Tue, 19 Dec 2023 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="FRSvzLwn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B43D0AF;
	Tue, 19 Dec 2023 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfZLQ25tcDLfIbu/WDL1YirY/4rhnaB2TkWLYFbWPMgQs8MNg3xW7E98u61jNjlAuIcXlHMkddAihlg5ll/HHT35EollQUNUvmrXEc5K2Ov3NlkG602myADiysfG98hVjiIlYtCEGeQfpj3PsZdxoZuqrmxfrDBRMQ90ENdidTCdgQmdzxltaiDG3QpZMvqkbJNzF+4XCGQtLaSnlbFTCWZXE/NLDB9xc9xdUReJGmrfn2JudH5LGv28OblqGV90B2U+wgtUiQTSUNa2vvovP3L5jGxbrupqvKyoKQFLPHo41qxdCCq+KfHzkV1NsOEU6bsSHYj3ev7B8sUvKRZ7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUyI2VDb/fe4eeFGzNtDjuNo1rOq3zzyjKsi1xSNbes=;
 b=NASpKb1j1xx5m3bVz/9z3jkVC2z02FbrghLmdzcVs7Ut47TKp0N625N01Uj4GRghXqoIzUOH+TyC2TbOdlyP+5blPP4mj8yoVZXJcHfMjgtfjRiIol6hgpNTCx20/0Tcu8EFdKCVsNKTHULFzbsF+0uGkIXaAU+vEda9WhUINfybnGs66wUcgUHIfvP6GLg3ExR5FEId/5XkWYV/AlHMRgLstJGLVmyWb9l8H2uR3yLSXM8h3PsKPK02q21DgB7iyZSCH9Pqo7SFKHdq12jpss9yy39HIEz5nlvxezzXnEUB5ijCPgMrvFo1HvmkGBih8UcNXutoXyBmhFWavCw2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUyI2VDb/fe4eeFGzNtDjuNo1rOq3zzyjKsi1xSNbes=;
 b=FRSvzLwnK4+395Xc9fvJeHoknUe0lSC0VdPEHXZ5FuhlaL0ocXY8brD+QZH1LJY6R41bAwWAOjY4tGvJ5/13kkDjTcE1MX0A40k1KMdEpGGop+Q9TkrmXmedZ8BREWuVijxxLYWaWWk8wM7uKLAjH2VGW4OOie1fT56fcBdIJ9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BLAPR17MB4097.namprd17.prod.outlook.com (2603:10b6:208:27a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 18:13:01 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 18:13:01 +0000
Date: Tue, 19 Dec 2023 13:12:56 -0500
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
Subject: Re: [PATCH v4 11/11] mm/mempolicy: extend set_mempolicy2 and mbind2
 to support weighted interleave
Message-ID: <ZYHdKLkvtDXjhoxS@memverge.com>
References: <20231218194631.21667-1-gregory.price@memverge.com>
 <20231218194631.21667-12-gregory.price@memverge.com>
 <87sf3ynb4x.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf3ynb4x.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BYAPR11CA0100.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::41) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BLAPR17MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b449ce-8feb-47b7-72e4-08dc00be234f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cx+sh2OtrZ+JhfV7geFzxqmqvxgimegWwk4LWQMsW7fKJPM+yvu1qN1RvoMjA9nMz9xZ/PXU+eqypAhzQdcTtOUZM5MnS9ZBv0w4TynYN/7RxR3W6CJty1v1d1Dpme5z+0DPVWUIix7bZmgeTZev5nGi+7hdIIXEGuhM321lMPnEeiuAhKFDtFGorCo6tcWrYrdKDXC6qDf2p4iVRp6NCJ0hbVBlvVPqFapXEGyQGT5qKos9l1Er03bHw/uWy8E8h78K2tnPZcjfANgR9BYNj5+gGSqN66oarf3EoUwvG3jW5nB0W9FR2ttC83hAeA2LU08FfubZjxvoGkEQfn3sjEYDvm3TO2oyoxt7w4zchX80kHpu/IW6BlbzHHAnMjblekgHz8uSEbmRE7XEdKpU50SOQkX/m9Hhnii4zJSrRpGMmdlqdvWqJQjHnkDtRmUUoTm5qR1BDpWJrI4CNIOzalz0B/1KKeByhfdkiTk6TJCC1HGrivutb8jiBtTbQBOxj7f4Fhg1uw4NlpiSz3TLCuflR9zAfatYZhFSvsjPGTqiwykg+/x6J25zCgYs/U5/f8qTUxjzwio0NmtHGFSWIHafSMOCY15tU58moaO1Uyo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39840400004)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(478600001)(4326008)(26005)(38100700002)(7416002)(44832011)(7406005)(41300700001)(8936002)(2616005)(5660300002)(6512007)(6486002)(2906002)(66556008)(66946007)(6666004)(6506007)(8676002)(316002)(66476007)(6916009)(36756003)(86362001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NE0NS/OrKO6wLtoGUi5gWxIJctDnhZZW/5pXKlJ7godQoFYXe1gSHB1c8AYy?=
 =?us-ascii?Q?0l3Kfb29LI4Hcl+n0v1MRTKXDldz7dopi2w4TfXCp8/FVgJCsomR+eZNilz8?=
 =?us-ascii?Q?8kgFE9HLEPteJdZzVFDMMH5ymGAJ7YoMJg+VFQsqrgQJZ4gdrk0Hhw5bhyKA?=
 =?us-ascii?Q?KaCbPjatfIepNDD7PA2gumcIhnQ/Pw1/JntdO4p3nUB/Lr48zdU0Br0+ecg8?=
 =?us-ascii?Q?YR8tiXuq+Na5i/jocfhMDFSnJ/mrTzC7Yol0J0PfDzMvizBFvqhI99aHKlo5?=
 =?us-ascii?Q?LXfQUajgxnB1ucZIWGdEM5OSypJD3mG5dasQG+a+eUWisPINeh7IEwvwNZ3P?=
 =?us-ascii?Q?pH+0aUoNtUIggYcoRxFW1eUW9DVfqKvsE1DUhNW6wluVT8wM9NHEmvH98r4u?=
 =?us-ascii?Q?L8y1gHk79b5rzVqyVJ8RYanteKLS/94ZJ/21F/XslmY5D6oArj73P2i1kw4w?=
 =?us-ascii?Q?LN/Kq529mQrCbhcOyL0RJJ+HSWUxYx7DQP43bMuY8dMmQX+aBFYAG/JT+DKX?=
 =?us-ascii?Q?3B9QANq3trej4k1znya//w+wpxaumryne3q4gXlE17XrfVGBl+IHH6Yak1oc?=
 =?us-ascii?Q?+XxJwNH7tsgtcieHBPTR0DYHKzrnX/K1e/lI+8/mnRyGdcmu3LdjIs+WqEdU?=
 =?us-ascii?Q?6VzECs6+HbK2t9vjUOaMf4uVJK+gSau5etWHATfA0LhLJEYoQRRG1BIZA7ex?=
 =?us-ascii?Q?kfaAyec0GzKeXEklGjli4zJEFLVjSqNn7LJrxokk7xNIJLSJs3EKxc28fG/J?=
 =?us-ascii?Q?fKfksj+isFBGGMYUsjxubeeXLTr/KwJfH0oRFuuMBwqiPomAAq0lGQ8rBe5S?=
 =?us-ascii?Q?+BJqsYpRjgD8eqBR9ntdyqk6GeRLoiBgMSJQFPoO6O3M8+5RUtNLIzPiMGzD?=
 =?us-ascii?Q?X4WxLemsc9rLRgWoFiQWiPTl0/+7SLqWofnYXYiBbUJ9pxchf5JvZDstXZlM?=
 =?us-ascii?Q?YRM3C1YEph5mRkYDcjjUpGkDiZ8na6pUBpwRBsKygFUmXNCdgkFM8fTpHzeu?=
 =?us-ascii?Q?sqTsEXTOgR0Og3xICIYFIW+WsqfT65UtqfFSXX0sGHccXUQoRm4h75CHoevl?=
 =?us-ascii?Q?UYQ9STeEx8PT/yt+Vtc7dwylQYdA5wADtiQuLrSsdpauQXs9kpiZ0rD3AxoD?=
 =?us-ascii?Q?Y+dQmiGTsgx3a07j30bnpPs1proW99KpF4cGarpu6kc/eawIBVnp4bJqciiu?=
 =?us-ascii?Q?tEtNRv1apD4vEiSka2tUvTeA8TD5S1NlYZD6SvHiiXqUMu0+76CXIzW6pcIh?=
 =?us-ascii?Q?ZeWLU7gv7ERGMm/wmNxxWIXJU1egMqm0NQjJEEvUqzB29+UAjpU12+6uIBTH?=
 =?us-ascii?Q?ogeYJ9Hp0aviuCaGDsQXVtZw0RCFS7wq5WxrO99YubrWmPQ1QlvAAoto+iT8?=
 =?us-ascii?Q?Y0K5+Fq9xHSfEWKQe2sECLG8yRdsu2WO3vCXAuAwJJsv9GkNMitoJcS8/nZv?=
 =?us-ascii?Q?98TeesG/S6yxV6IbOjNUKZwPueAwxOhqoqQ9tbJWvbrNMWHzH0atoogGtnpb?=
 =?us-ascii?Q?QvWNQJkMnlb9yXrweS7EZa06hhaxPQhnqOgKyqGfYKDk7NLzyQJt7VipCnYT?=
 =?us-ascii?Q?dUokvCd68aUNYbn9YCkcbqYR4E6pv6zVv5MP7QYuZaxGS/KyOgErQCUUuK2B?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b449ce-8feb-47b7-72e4-08dc00be234f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 18:13:01.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CklZPXhUz7R+o68ZhunltuRUnzY2fy5LqvufsVJSTd1F3JDvl7Xm34DVReXCq6GMYUsqKMepGFZR4/ZVSzvhUJy+9wv49638jMkJpodtnxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR17MB4097

On Tue, Dec 19, 2023 at 11:07:10AM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> > index ec1402dae35b..16fedf966166 100644
> > --- a/include/uapi/linux/mempolicy.h
> > +++ b/include/uapi/linux/mempolicy.h
> > @@ -33,6 +33,7 @@ struct mpol_args {
> >  	__u16 mode_flags;
> >  	__s32 home_node;	/* mbind2: policy home node */
> >  	__aligned_u64 pol_nodes;
> > +	__aligned_u64 il_weights; /* size: pol_maxnodes * sizeof(char) */
> >  	__u64 pol_maxnodes;
> >  	__s32 policy_node;	/* get_mempolicy: policy node info */
> >  };
> 
> You break the ABI you introduced earlier in the patchset.  Although they
> are done within a patchset, I don't think that it's a good idea.  I
> suggest to finalize the ABI in the first place.  Otherwise, people check
> git log will be confused by ABI broken.  This makes it easier to be
> reviewed too.
> 

This is a result of fixing alignment/holes (suggested by Arnd) and my
not dropping policy_node, which I'd originally planned to do.

I figured that whenever we decided to move forward, mempolicy2 and
mbind2 syscalls would end up squashed into a single commit for the
purpose of ensuring the feature goes in as a whole.  I can fix this
though.

~Gregory

