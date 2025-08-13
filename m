Return-Path: <linux-fsdevel+bounces-57787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 584A1B25429
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 801237AE8BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 20:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F742D0C80;
	Wed, 13 Aug 2025 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nE7T7xkD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393F82F99A1;
	Wed, 13 Aug 2025 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115435; cv=fail; b=fUKM8ERgJ7hWt5TS+XB+xw03DYRA9rBGoFCTe1iJwqH+ArA2UofRTqz9TkznYfleV3B+QQIrcLOha6SCs0USCzswO86r+1Jy7BYh7DGQT0+4LdQ7NLnuulBpW0gv0znLZ6NYKiQabM2ipHeY0dHNYUvqZLs0Qw+MuRjALZGFOGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115435; c=relaxed/simple;
	bh=Rlx9lcYe9Y41rXVuLrFfEJcEqImUmECNhRh+R7TreOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bCVzjcRt1uBCMBmvv/82X/nwW2wBmFCG8JS3pUDeODR23eJpqel7TzffhoIJrBf20mE7jlfnqgcCrHCQSulgNCu4pXT5716Z1DuQhKETGHQBZs+Xrw9s4J4vTj0F9E12yZ4OHpLe0rZGOV8CGLUsgT9zkJw+7ZaWto/9rUNgqNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nE7T7xkD; arc=fail smtp.client-ip=40.107.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVTRz4MSk/pDYQ8oDZRCfkfqfu+4+EE+FS4nvpXbTtl3XYMcy+onqIn3BAXwmCZ1igPLMB9oZBVsAL4+9FcDzakuhifLK8Ue76FiPdY3toIZbkEqHw8AGk0DsTyH8YqexfeYuZf0DA4pu3JaZEt41Al71/kMbQJNBbwBhHn8uNVvm+UjxDbaT50KFTcvwRkFR2THarIHpe2teP+Dod/xz/oQsleQ+ioR4hBUiXg95rXlfjy9puhCvMS0QNJX8JSgFt1Tz+44C29ZFfoBuoSpwu/pwbq1jCksOWhRFiVz0G0nHL5ihp1dtI+ZZsCIQh2HCCmtJEpNegAmDcgMa7+V8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygQDr4roWgudk8nQEzkXKix/0BnXKDIV9LJ4KsjY050=;
 b=ckZvPUvezQ8IPQOLS6dlo2brOK6e8PhnwGANu/2fjowwEs+hEB4aI3XO0cN0OosEpriLmSKF6pNqifFBmSeM5pgL2T8XTUBFyf5mx8EQPMsVPsVyl25cbOOJV3Ipa/faL5IbQviZs0yhEKY/fVzODLeHtkGG0deHPAg+0lbfLDIAa1HRad5CTyWJsOyB7XWw/TDnJMPAt5+lZuz7Z3IGo6Ae2boSO1CDlWrtV3EBniqmTkf+67yosASVBvgyLAEtlC7gCRoXjxuEhomvORR2ikeG6nU4aX9j9gM8Vb7Q+nxyBPO5TC4O21ci+6PKYq8F9Gmduefg5lY2s+XrVqwhSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygQDr4roWgudk8nQEzkXKix/0BnXKDIV9LJ4KsjY050=;
 b=nE7T7xkDutknfrKMAITHeXpczz2CYSKOG/axwO5lRLo2S4S0S0V5rvvpoAJ2Pxu1D2/z5AsBHZ2PwgBK3+zn+S/5rAwrX3ybUrcrXLin9CNCUmEk9CMQBKdmKjXt+FKKMtQUKsrmMVpKy/sMaXgy+5eqiUAnxlIi6grW3CV1COpO0Mv4tuGsTFeJiKIusdtaLCC61LvWYJ7utqJaEFfosUZqS1rLn9C57U3WV75x2JwmazN2l2udhEMbTOifarV4boPngk9NJYV6VmOtpBAxDH/agI3zswCfhVnXUWLqr7nXVV9CEI3i5U4J+xHzTq/AsRbree83zuR+H7CNGzn6iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Wed, 13 Aug
 2025 20:03:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 20:03:50 +0000
Date: Wed, 13 Aug 2025 17:03:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, jasonmiu@google.com,
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <20250813200348.GB699432@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250813063407.GA3182745.vipinsh@google.com>
 <2025081310-custodian-ashamed-3104@gregkh>
 <mafs01ppfxwe8.fsf@kernel.org>
 <2025081351-tinsel-sprinkler-af77@gregkh>
 <20250813124140.GA699432@nvidia.com>
 <2025081334-rotten-visible-517a@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025081334-rotten-visible-517a@gregkh>
X-ClientProxiedBy: MN2PR19CA0061.namprd19.prod.outlook.com
 (2603:10b6:208:19b::38) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: c58f83b5-e901-4359-a491-08dddaa48547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?olH2JO4DRW0tLzjCnQ+4CqGHWDFsBVp7lkJpWmpl3tF7aggUqO2mcokgvDB0?=
 =?us-ascii?Q?NdN87dzJcTpRVBb62TxwhYiC4qYynGDA2RxfTZ2ZXnDyse2QqlZS2ctfRwWn?=
 =?us-ascii?Q?8LCA9jaJE8AQQs7EP37kahFxOXCwoX+6L55Wd4oOXcL9CcXWq09mZhuWaujV?=
 =?us-ascii?Q?pmYEA0SZuwixX7WAB0iL9ADWzqjG++YZYY5LXugmzWLngMJmKabnQgOnXRQq?=
 =?us-ascii?Q?BdrzFp+9m+n9P+Vgd/bwcrTKnKTH60AuDVdVgSvRHhH7Cth6XqV9u/dOf4KG?=
 =?us-ascii?Q?iISk+tOn4k8kxRl6w7bvUEBO4+V0GltAn0fZpRuAXd8Jqz6Zgs6ODJGJ3by4?=
 =?us-ascii?Q?DCtBOb74Jhk77kh1CZ1XdiBOniNa0umyWLi/GMJzCT1brLiaoZnp7uG24T8c?=
 =?us-ascii?Q?o7KDZlB5yQY1uJeDWsF/aeTg0q2sNS5843UaXUoUhrQW9s9XdCeVWVkTdxtX?=
 =?us-ascii?Q?CvZ05+7GWI/W0pQtrORJRFKVFVajMrXoCCUUHziJjHHZuibQnhLfF1uue7BB?=
 =?us-ascii?Q?eCzbL93zbQPUlYffs/k1pPVs3Lpz083e4VuZAo8pJtDnmUV+04u/det4IWrx?=
 =?us-ascii?Q?B8GfLtc2mCh9wy8VV3NsxzYX5eKHHphvukyYYy5+u001TBYzoj1HIp0tPt+Z?=
 =?us-ascii?Q?hAfBhlVWEo4cXH5tq4paBidbEY7tqXybN+YN7dCkswhleBMvQC+dJGYEx7iw?=
 =?us-ascii?Q?d8Vu+CdtNselT63oG74++wqo0DYuhf5wDoxc/RnAZodKpz7ZiR6+qbBjc5RI?=
 =?us-ascii?Q?HsWyUUttbJ2BxCOQkcD7HTlR5i3lzBEGqAPi0XrojHxWPY3+qLegkDhAQdxb?=
 =?us-ascii?Q?4VWePfWeJELZw91rFTOWAlKIKqqa/IfVAQvG8HZki5YFIiVo967SNYs4OGlJ?=
 =?us-ascii?Q?RJEnuCBlme2keVESwjU94uEZHm/em+zxemtcwb4xDfxPNzG5RG8q/TFS3c0U?=
 =?us-ascii?Q?vHhvc3dSnRTkjbj8mMM+duhRpxDsA43WoLm52fWPQJeuzvGvJJg8ZAy5YFiZ?=
 =?us-ascii?Q?KV2lYSomg7bkQmZKhJc4n1Ud5RUIK32s9jMdmqx0ZMfpn4xP1Kjauh2DYN4g?=
 =?us-ascii?Q?I1WHhXjl9PGqKz1JJ14ICtXkl54CCPTfGvyVjX7jhhX7OuRvxC53jUGWDEWx?=
 =?us-ascii?Q?3vtvxQ5goXzwSpk4gXmMQGOxJ/IzPcm6WNxY6k2RVsK7MXLDKVFMTWsQYUPz?=
 =?us-ascii?Q?5jQBZbKNKqTm0DT49iPfLfQJkRRPiY7LHCkUX2y+sLqJES/Qj29qeWaRTI6k?=
 =?us-ascii?Q?HeDnZZeELOi16dgFr18laHbKQrAIv2hzt9fWRSGV1OsrwZV+i8ZCmq5qJLpZ?=
 =?us-ascii?Q?Tsp5V+mvG5D1d9ELq3tRg0upXOw+StKeqM1M9pepy//TbAWrGFNIK8UE91gY?=
 =?us-ascii?Q?kf0uO6M3eVsCAmLOeCQ+zZy4MVm9wqIHF31AIxLjAY0CIGQkuQ4SFgVLCw6u?=
 =?us-ascii?Q?n693nphjIzY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RSxNvVkyO69AjoB3mZlRwB7KysPD9cUhxmRttOXXbfOJI93zHuBAZZacJjq7?=
 =?us-ascii?Q?c/RZYIPm6k0/CcApi2XXJ22Ejl39FdGS8WMAas/Mp/pxYzaSgcHN3eHAbitG?=
 =?us-ascii?Q?2txZQ/YCvB2Mhb1HoT3Scf6gR8BxpESvNv4aQKJPJbq1x2w74KDltlEvzYx0?=
 =?us-ascii?Q?aJAfOK6kjkBYQdbEprAd5JTxo2qHr2AvU+OA+WtN+Yoni5L51Jkz9p5JK+6R?=
 =?us-ascii?Q?7ub5UY5Cazn1pgDbHDQPTcVDm5S7i5ZTyCHxA7QGcjvw7InX/HCoFPArjHQl?=
 =?us-ascii?Q?cN0HbKg43HAOVnJCechph0VGo88qqjredlKegr6lxt8DtOZUMh1ewi/LAm4m?=
 =?us-ascii?Q?MoC9S0VQTE5+Q48Ey979OT0F/YCJgbENjg4wcaDx5D/sB0kbTaRgv9Zn1DHG?=
 =?us-ascii?Q?nBUgBJkETXGn3U36MJRYy60hVODY8GWlUKxUrFsb6Rtm30DlFvCJeD06dbLA?=
 =?us-ascii?Q?jSYsB4E07bAOxb7vHWurZe8WYMtQ1eMCu5PJfpySuvoRKj5ma4KZne6pN0bO?=
 =?us-ascii?Q?8GlolM4OXgeulMmco8Fi5oh4wEjyc4Oyx+gAWOHckU9LQCwn5vFeDBWHD39Q?=
 =?us-ascii?Q?jd3Heh07LFkG5sNmMMZBb/p/rH3N53q22AfFmRddB1+PSbh7o53j1omTFn/O?=
 =?us-ascii?Q?vjJF4CLmMcbP21o5OSurUAjzeyzCq5IlmPbyvZfbDSmYcJrGeKIwppfGS9Zf?=
 =?us-ascii?Q?VofGi8wzOvLLtEVJDMuXMeN5oQfj+7aX6JbYeXAMoNEMy89/E2vr0+pnlmxp?=
 =?us-ascii?Q?e44NC7tZ/MbB0iM+TA7VrnhderjQQgJr+S7iRL/+qQaWxKge0Soxehb5GkKB?=
 =?us-ascii?Q?HBJO+JSIP0fua8K7WNCFyxP2FVyjNiuImV7g4C/T4VBuyfPhaUflYrrVsPwp?=
 =?us-ascii?Q?mI95c7q8U/05uR1V+VZhMpyhTfqjKGB4n35MVviDOH3NVtf39qiIZKTgtm4q?=
 =?us-ascii?Q?ubcL3U/xetG3UejSJeFiHrC/kls4jAF5bRCR2/G6ebuOu5/YUuE9tWnWeQeM?=
 =?us-ascii?Q?lVF2373XqhUI3tzchZEF+l7AD9mHA5D7SoeVqaLlC4Lq1yjw2q4xsbjFJqmg?=
 =?us-ascii?Q?F9jnpqt7KfJX7MeXqXEST/CSrjs85losUQY0/LnWrobttkkJx7dVWDDmE5sZ?=
 =?us-ascii?Q?mAlkYj4iJfFxw8UPB8s+VBhzk210UalgUzhavlUQXQEqpAkZj1m+s3ElMS4S?=
 =?us-ascii?Q?FNODoMnJh8k1cFhcexMrZ5QP7opnmDs4Wb1ThQ81sxH1ikh8gMBwO61LvkIG?=
 =?us-ascii?Q?0dtqbJA00AXzUkdODJ6c2co3dgb9L092WsWBeLvpKh0WAHw2/6LSmIF9zb6+?=
 =?us-ascii?Q?IfdIMYOmSRaAKTXnH0PyaEtC9jzt/39WZqxeLlP5+FT57rCeuZys2IGn2DrX?=
 =?us-ascii?Q?QUfyLTt4jDu83Yy8axyp2orZqYEX1MJC8AH5i2U1Ekj2dmPsOhoiGDunWM8v?=
 =?us-ascii?Q?8rCIOEuqfAQNS52F9UrSQLfXt1BKM5PIC5LFvfRo/8g+PBiY4EeIGzMm5pz2?=
 =?us-ascii?Q?DFRG8oqTWveNDanO7jTPQOUcaz/+Cwyo18F/PIaFr+4cf3DvxXkQ7lS9uE8J?=
 =?us-ascii?Q?e+XOD8kNUHwXoaJEzfc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58f83b5-e901-4359-a491-08dddaa48547
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 20:03:50.4091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GVS4isXm1wITcAUidWIRlHX4soynELxl9GScd4vXJwUaqHMrCJWAC4vzfajMjE/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132

On Wed, Aug 13, 2025 at 03:00:08PM +0200, Greg KH wrote:
> > In this case if kho_unpreserve_folio() fails in this call chain it
> > means some error unwind is wrongly happening out of sequence, and we
> > are now forced to leak memory. Unwind is not something that userspace
> > should be controlling, so of course we want a WARN_ON here.
> 
> "should be" is the key here.  And it's not obvious from this patch if
> that's true or not, which is why I mentioned it.
> 
> I will keep bringing this up, given the HUGE number of CVEs I keep
> assigning each week for when userspace hits WARN_ON() calls until that
> flow starts to die out either because we don't keep adding new calls, OR
> we finally fix them all.  Both would be good...

WARN or not, userspace triggering permanently leaking kernel memory is
a CVE worthy bug in of itself.

So even if userspace triggers this I'd rather have the warn than the
difficult to find leak.

I don't know what your CVEs are, but I get a decent number of
userspace hits a WARN bug from with syzkaller, and they are all bugs
in the kernel. Bugs that should probably get CVEs even without the
crash on WARN issue anyhow. The WARN made them discoverable cheaply.

The most recent was a userspace triggerable arthimetic overflow
corrupted a datastructure and a WARN caught it, syzkaller found it,
and we fixed it before it became a splashy exploit with a web
site.

Removing bug catching to reduce CVEs because we don't find the bugs
anymore seems like the wrong direction to me.

Jason

