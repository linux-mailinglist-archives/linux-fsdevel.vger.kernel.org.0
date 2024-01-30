Return-Path: <linux-fsdevel+bounces-9544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B33848428A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 17:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F317289BD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 16:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAF61272BD;
	Tue, 30 Jan 2024 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="PCkNHK7V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445B386AEB;
	Tue, 30 Jan 2024 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630482; cv=fail; b=EdvvStV7IuM5eYKuqSCvyz/ONdiMqQY+UtIUFOk9pM5LwPqHVwZW1n9CuT0iBOqhu1FPV4XCaRBXRrD8eeyoRepuKjY28Q9WrY6wtCaeQePAfF8DUNhlgAEmrkb72vLik2+aSyapt94PJ8i4TTy5zG+NNIs0tAyemWBD7vFA1yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630482; c=relaxed/simple;
	bh=fOPk6y5HAlSvG3prrygjWoH2aeZv9uqWOWdpvM+D5OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VAUQgRmgeThUdaV/SlUS0W0h0VUpJb/yZ3xCAbnaqCMY6wOBiObri6CPTY1Wjk9cPbkLRq35Qrm4+1wurz91YKjx+qxckmbDic/7V8TJUKTtK+mSZW7wEUNRQ6NwcCAE8knisCXDZswaL0DGnV612y/4Lo2i+CSRgntB12YyEis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=PCkNHK7V; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H33mTFA6Y9HKqDaLvOJv82Y0ObYCzJeXyG+MlTTFeUXV3CjpksmCq13pecMrW5A0UJE1zov2E60t8gUPTP4Hezh5801ThGnBUjESZDx6KiyQOdWNrNhU9xi7E0jbS2+eAh6T8+rQcgu6AC9dBJxwKxH2MkcofkXAC2AvgLxBK3LCL8GfI5wYYlNDSORRCtI+ISs05848VdDEWlwgwoo0zJNHBhQUFsQCE69hrRP/bgRQAW9AcUGXDPEWcqXdlNwqOblGZvvyq4pFBPmQIkJXE8kmT2QhQfx8JAPaXQWOny8h3CcnRzzaUWpCJwv+YTW2VBGiVNxOhfceILcOCTwF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jUElSWu+KsiSo6u5p3dXkMBEktbyZPMRQkyS2WfUrY=;
 b=CfeOG1Uqydx7QwPh9G/1GymrBB3se0Naqs/DjOprUaDpPGLAlxTZVd83Axs0uWkC1+xE16AXWto/7pFGAC90x+y5wjIYqSUe+1KHgSaT3syCNum5Pwe6epaHCr3S1CDt/R4Kh9Qlc0K2r+FrotkNwVY/ajugKpNDP3RciErO7gpEBXYW79BZ+8V7OAnKQdyvza1F4PYWRYmizDuxReK/owPp77S0Oj3jAT2wH30H3mVOjdjPk/5CG63QPogGOMRtCBaDwUkUlsYa/hyAUJgFc1RSQc5dB5eCfZF03dQk4obPFIsiSrireoYSr8/nKzmMZS7ktrewAf1diXprO7XK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jUElSWu+KsiSo6u5p3dXkMBEktbyZPMRQkyS2WfUrY=;
 b=PCkNHK7VSBTlZyXB32qDK3Byfjw6c49Wy3oUMLsrsznZ6QOIBAB/TAPYDqqA71+MTvDC//qPqn9ctQhtnNOydpj9jDxeB7rWNV9hgG9QkrGz7tm6z8De9eAU/zHKSXSMPQOsbmSF/tbLMwEPQMH/rLyiXg/lxl7SwXQ91CGfwyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM6PR17MB3739.namprd17.prod.outlook.com (2603:10b6:5:256::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 16:01:17 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 16:01:17 +0000
Date: Tue, 30 Jan 2024 11:01:12 -0500
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
Message-ID: <ZbkdSFWNuoHuDtll@memverge.com>
References: <20240125184345.47074-1-gregory.price@memverge.com>
 <20240125184345.47074-5-gregory.price@memverge.com>
 <87sf2klez8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZbPf6d2cQykdl3Eb@memverge.com>
 <877cjsk0yd.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZbfI3+nhgQlNKMPG@memverge.com>
 <ZbfqVHA9+38/j3Mq@memverge.com>
 <875xzbika0.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZbhuJTBp68e8eLRv@memverge.com>
 <871q9ziel5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q9ziel5.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR03CA0367.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::12) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM6PR17MB3739:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d8323d-0182-41a4-1515-08dc21acb117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HALUlA9xAa2lwX0E1fD0e6DHPglS2NrC2ROp97bPmdu52wjmCXIxqjBG5iJDiFg43wMRbzXtW0vRW9gB7Rz58cWVzD0EctfxrS0wZaXn0qSTbQwpfxCvviqvsVTJhtzIEp0scZLkUiFf8S1LvATYstjeNI/cfyX6TWGichLKw797vS6XReImG5vjuillTUp1uA0cUkCkMtb87rQL/jaG9jn6Q0nYGzHaa4u/Iv29p7IYUkjWDkUs0PQMTj+65gIxyKl5MEwU8br0hqYgKGEhr0ZMEy6LhNIHbsH/lIpjohOxXttbA7zWjX6BYv/2Xrt2TriNM0ughQ5KnXAHKQTuRjI5kTVt++mYzXmXT12UJmUhuOEsqwx+2sQJ4g5UavNoXLIK14cbNijnQ23pCFQDDyLuNAbVVlPiLDnkYUVAR5wFmrevlTxJnGTt1btY5LPLyIkpKrLg7AZxLsO4NqfKiD7im8C5gPXZgtuqOj0kNRan1Ax0eOq5wz4FIb7sif4z/+OAM7SMbwBya0g5MTuE4dMTSK42XtjhGIU7UAF8noU8d4KYuVyBjmgB4qSiRqBj0jdsHfrVPZzsMbeb/LUAnHLx7Ve+cpNK1uu0HMl3TKs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39840400004)(396003)(366004)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(2616005)(6666004)(6506007)(478600001)(26005)(4326008)(8936002)(4744005)(2906002)(7416002)(44832011)(5660300002)(66946007)(66476007)(6486002)(66556008)(316002)(8676002)(38100700002)(6916009)(86362001)(6512007)(36756003)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T1mOio2Jk2nHZ1YMohF/ttVyPygV4EsRULDKs2TRZ/uoYceFvH2LVPFKv0A0?=
 =?us-ascii?Q?ukeM0+1oNSRa1bqH0vnfWmeH85aNT86MU/KlUzFGeUsAnnAwt1IvY73wi5Ca?=
 =?us-ascii?Q?2LnD8Kt6s5CWq8QLAX/PPFOArlR9PLSZ7vMCYCodYILW5DAO0BER1z7OhYxz?=
 =?us-ascii?Q?20xggUcsjWO6lWwvmTtko3HVq6NtBtPAUMgTfmZR2qFEPLATpgG/36wEq2s0?=
 =?us-ascii?Q?OOMYQBqHXziamusRwxaTk+o+k0L9qP9ScXSKjppdP74HrmEM6uBv1avtAbhe?=
 =?us-ascii?Q?8VZdHRmojb35dbXd4B8RmAW69KgoG9L7BNKcudKXUIG/1D5H4nC5m3rWnBDU?=
 =?us-ascii?Q?76ZsNvcMKlzYrDwi6PZSE9lvrccd1AcOcY3EOlwmg5Sk8bxT5b/G4crt4KHh?=
 =?us-ascii?Q?OSaKZQiOsNcnUXjyb0q4ksQGUI/i9vZkDbHnALuqoTpf64tL2lLpLSn0ZlY3?=
 =?us-ascii?Q?I0CSdLLBWZW1dJIZxwJ2yy4EehqiYy3Ylhoz+2BkmsT7C/CfuR4SHNvHnw90?=
 =?us-ascii?Q?/0cL6WlC6FWzsmmU0eXnO5bDWSWNIixBjvkIH9y9t9JixTXRtp+JB3wcUa65?=
 =?us-ascii?Q?iyA79EhlKeGBSPdcHUguFV65nk32F5SRxhEZoslZIkUlp2SfCzfuXZ1DYhtT?=
 =?us-ascii?Q?5FMKhelIbVORFG/0xqJAltJdncrNCbop0DjmLKl+4X2mWLJzKoguHitEx7bG?=
 =?us-ascii?Q?g9FvTMgUIG8JhDWCVLPJransK/kplmWJjLBDTAccXulN/SbctvFbLVibgioc?=
 =?us-ascii?Q?iQh22E3WLwyOx1aqb659WVAywIfUaevMg/MjpzYMSyaVV1iNFqJlYBYKZxAX?=
 =?us-ascii?Q?wRUAQ0BB61R8irgqy5DGBMe+cXbCQPT/7FeKJoWFGilguNmxjAee+hrzcyp2?=
 =?us-ascii?Q?/lM6RW+QMwRM3eubbLZ5iqSEpozvz1ulbLRflFnrtrNfJWFpiMiQEfFVBs/H?=
 =?us-ascii?Q?irSLIZRx4qouTXfLOn7CLJ1pscZ2TeVRTvOiTZ8+90NHRNd4wmLtQfwjEzOD?=
 =?us-ascii?Q?jWNRDnqTDdmrFzSkIpdYKcvBbuTCD0edn++R6JdgCHm+idZUGhOs7QQ3Qdyp?=
 =?us-ascii?Q?ACH7MP/n3vcPQY9NXPYVfOHoxpXnjdGMJiMl4ZodOgDirsvStqQ1ELZeeyNT?=
 =?us-ascii?Q?njSePnKy1TebVWQYISeJK3gPVxdukxwZIQbkP7EdxtE//sUCCe8iDWZ7Oj72?=
 =?us-ascii?Q?Va3/l2Djx/VkcPbZytd0K4rIdaCLvILrSLstue6slWqqe8/O1a5WaqO6sso/?=
 =?us-ascii?Q?JTYG7UA0/1BtyeRYmtnGO5IQrq2lKye0JMdKZruBAr8b1ehQkjdiULEJMz4X?=
 =?us-ascii?Q?Cc/19wHFZ69BGb0EPkHoZT2xA0wvmtuOKvANVog7SO/WOH/bJQYn97kt2NPa?=
 =?us-ascii?Q?zTUD71ZpOESQDWYsA0CnsjB2k7fkU08ZeI20men/bwtkjMErEGAEs06sQQtE?=
 =?us-ascii?Q?nmEvP19sy5M6KNfXz2cB90QVoMXcIpsSdP4R28CuYDm+MFpCpv+MnxBDLBCl?=
 =?us-ascii?Q?zlWrBEGJLsJ6rKy+bbU7N98UYf0i6+Jd030vVH/Wq3i9c2SQlO3WgHPdpKA4?=
 =?us-ascii?Q?5pXnIBnTmNYlU22CUL1N689M09mFKDco9lhu5fArsikuMJP5TdYX8YqmNpfL?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d8323d-0182-41a4-1515-08dc21acb117
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 16:01:17.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNjqhtuVvyxPopGgRVZJtSt7WpQvYqHs9D6Dj/eeEbpcuddi+O4Dpue3J/z+ahQDM7krL7JL3VRMb7jxkaqOy3eGgkBf+kv07qg6UJmH6bA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB3739

On Tue, Jan 30, 2024 at 01:18:30PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > For normal interleave, this isn't an issue because it always proceeds to
> > the next node. The same is not true of weighted interleave, which may
> > have a hanging weight in task->il_weight.
> 
> So, I added a check as follows,
> 
> node_isset(current->il_prev, policy->nodes)
> 
> If prev node is removed from nodemask, allocation will proceed to the
> next node.  Otherwise, it's safe to use current->il_weight.  
> 

Funny enough I have this on one of my branches and dropped it, but after
digging through everything - this should be sufficient.

I'll just add il_weight next to il_prev and have a new set of patches
out today. Code is already there, just needs one last cleanup pass.

~Gregory

