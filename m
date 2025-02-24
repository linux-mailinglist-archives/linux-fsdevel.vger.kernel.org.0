Return-Path: <linux-fsdevel+bounces-42510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C09A42EB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFAD189AB0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16901A2391;
	Mon, 24 Feb 2025 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W16teRbb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A3921345;
	Mon, 24 Feb 2025 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431467; cv=fail; b=R65+ig/+L1Gg4X0v7y7HwJPO78WbPsbiupwkkOfZVCHFvM33QGTJfpulPzl26li5IF/tXo6YPM3bGW6OcAbe8i0GveJOsYjiDJNZGtUvLTsth2IYNxshAS9qbgpH+RZCnU4GuTrRZc9dDK5D6pITK0pY9xBASCPVZ0Ai0YQS9Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431467; c=relaxed/simple;
	bh=/goQoqfh/T2WL2wyLNjWmHTNzyP4kvChgpVeGdrYY8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tjZl+VEIh7VRoEn2bM+WRtaEU0Jm7VeWrynl5B+sMD84rQmx/HFXfBx0XtK5CWuxMPSPAZJoBrl4kBoMrriR82STNHkW+H5awmvDLrLY8kCV1it+KNDfpARIhLANsYVCAuXZnkiILZUQoIs0A0CQnKqvkDUzBI0XRNep34kGcv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W16teRbb; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTtPuj4V7pt5Zb/vEXeAT4Z1z4g9pU2d3q+hy/sFVCuScDjh6uFL7Lv42yzYqhDK40pVpYeVPAJBmj7/DxZ17MFSwX1Eap1MpHxW21Nwqr0dkTrohwKMk9w8auoo/eQxqTBndo854mUfGY7Vy0cvMSDFLub614p+6JnT8F1rPip5JrsOizjhUngZ0XfLG8pS6t0VwPPXK2GmZpIZdbfndEGrVfOXKeNs6siHyCnQxq0IkcRg150KODuDEDbfMhHe/vRLZImQ/dKWWxcM19vVmqqnmCfqZm+XHCpsSCwjUSdyXIF+39xusBPT8yoeOVu29f5udAUtXw3HKjbwEof+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGKU3qNHSF6uE5BDkqBmoyTnLrXBshnjLOLUTqlEK1E=;
 b=SZwfYKs3JY1OySRi/zjIBm55kGHLwy3hsqk3NSK5fm/zvwE5QVp6vw/ovrHB1/JoaqllAxzniRm+JIXiVbVFr+umu5Yh/chWDLFVA6uwRl6bDbpcNIGyC4Eqpl3oHNd6OhXHyQNwqk4djY9l4DKhgRzQwjD5VlWP3Ow65FuOG0D3uTUacbxPSW6Tq2anfoW9Eakn3gZE5r4xgmLL2L3DjF7n27FGApYnrzE2ORey4n1Q8KENpBn+CDs9LljvdYDhTYLXqkxJ1SN/FmyzmLi4OCQsISoTOBgQ+ypKAfXEFFE9FDhKDGA9HbODnmUbsYWN/g/TH56zzd1tD0gh462qOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGKU3qNHSF6uE5BDkqBmoyTnLrXBshnjLOLUTqlEK1E=;
 b=W16teRbbgDsxq+EtY6tExH7qNL9/aPsG1SByfQ63iO0ZqgkOaoGGQhuCil4Rz1wT16b/8enmS6DhU460l9VPNZm1P7U1TPjN/qzK923J5g9hhSjBEyMaY3Z6BzNLplOhWuyXJNuLxSFh4If01Er8kAapOftK/VTUdhditb61xulVJibqRpBteEYsFujRtL6IAXlKrsHpSwSoQPON1O4B17fOCqBkP0jylEvGw4gDqkHj6aX9ZZGrl8fxeTUNyxafFerzyzcUt4JKEYemcp0Gb5dQOkr+yy22oLq8CRsk2LWJSTRe1D+JzOmEEQYXwW2t2qUxPzo39bKMHI54IADKkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 21:11:00 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 21:11:00 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 16/20] fs/proc/page: remove per-page mapcount
 dependency for /proc/kpagecount (CONFIG_NO_PAGE_MAPCOUNT)
Date: Mon, 24 Feb 2025 16:10:57 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <9010E213-9FC5-4900-B971-D032CB879F2E@nvidia.com>
In-Reply-To: <8a5e94a2-8cd7-45f5-a2be-525242c0cd16@redhat.com>
References: <20250224165603.1434404-1-david@redhat.com>
 <20250224165603.1434404-17-david@redhat.com>
 <D80YSXJPTL7M.2GZLUFXVP2ZCC@nvidia.com>
 <8a5e94a2-8cd7-45f5-a2be-525242c0cd16@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:91::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e21f74-85a1-4bcd-6cc9-08dd5517bd20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mVPnwIronN1gc93fmfXBFiZzS2Jnfh6uxzP1/SAn7fEeuzKOb2RXK6ryagNX?=
 =?us-ascii?Q?9HKaUf85+weqKgcxSETzM4pzyg8XWT4ldb8cgbTB1ioFvhEl2FoScx32HnVT?=
 =?us-ascii?Q?8XQh1AYShAFRjuuY7SzG+IcjLB350IwcjEe+OA3D8DEc0EIgAdzUwrldJMZZ?=
 =?us-ascii?Q?bdqSR14Bn5v3BIgzzcqzwa793CmbAtSH7Ck9B9o2ceC7RUUzPfFZ8WQZI0FZ?=
 =?us-ascii?Q?olSbsoE+4ucUfKxhOUQ5onDW7/8Uvg8oVTFZ9kbKHLOdFmpzRPpr7sVAcdmN?=
 =?us-ascii?Q?Jmr1bYBsF9+/5x1fheQY1rmK7TAq3Vr4/WHRNzVBD+CEm7XBOsnpYYvfEYjF?=
 =?us-ascii?Q?UtSGXGtG955pakkSGtFqNOmsa9K/H+MlA7ucRrzST+Z/qLTOOsYGB37z33PI?=
 =?us-ascii?Q?Oh6YirQAzU2CfmNhYtIqsBDfSoXUnP+lFseQRJIPUWNzGitXAKcnH41jJOvS?=
 =?us-ascii?Q?GC09fASSZSmrKSjeMfbtlGuQmJ+gkQ0aunN8ZZWzAYt8V8ymUqxkhB6mSXhd?=
 =?us-ascii?Q?kz8RhhOAJSBpwXZSxw08ts6qVwVwe2XuiolougTchDgI5fXZrR1zCFpAioVw?=
 =?us-ascii?Q?CvqHhkFrmNJRYHaIE0qfEamtt72h6DHW6xKwJ5arYeR11fEp1Z9UGkQELc9P?=
 =?us-ascii?Q?IqmQCpkKkjvE6DdQ04+6x4P40JcsruVzoLrGtxV1oKDO7XFU6ikW+VuUlZ8U?=
 =?us-ascii?Q?2bAjAH5yNnbv5bgmZPsgPrBpIZEEi/ghakjBc9kDd1Zs5NRDlNoVfA0p+a9U?=
 =?us-ascii?Q?TWtT7NyM31fVELluee1kf9Px1UXo1FrPrFAIk2XipUpGykzo4diWYr/lF+TC?=
 =?us-ascii?Q?e64Wz5LXwKLjZ0+CfwcqO3XLB+ovtjIAdOhnOif20dQA5F6I/sO201iDgMU0?=
 =?us-ascii?Q?RogRwnhdiDH5g+CCVK7swgrslkmSfeE/K2i/ZodnWdIN9pK2nKBNQVFnmYHz?=
 =?us-ascii?Q?lUt0LMSifZV0L+Smx0x/PXrcFEQ4Jd/taglw/D9DxupyNlE+/4q0LY+bJ4AY?=
 =?us-ascii?Q?W998nzvUQxd4TJP4hnKtoi7E4ilkuNQaPIP8DV4bSiPerBGAUJBQlRR1ZPdN?=
 =?us-ascii?Q?Rr6mIGLjpviLzyMN5GP3J6bvTWgTK7HnOwchhHHBOMT5Gx/4S+KvPn9Itx5w?=
 =?us-ascii?Q?Q/ZDrAv97yGxJLXsVlJUOtSESgp3UEN5M4Q18vfXi1Wp9TFntganJOhtJNou?=
 =?us-ascii?Q?i+YTiVfwpoAGuijG+2gbOo9I+dBJgeX5UAgAmHF0HilxHP4oqFzWlyk0Tuq0?=
 =?us-ascii?Q?W3ovvDrC68gqgwsHh3vJ0HkZu0tISnBuBQZCJmLv8xE80Y6Qg6PngjcWJP54?=
 =?us-ascii?Q?s2UdZItQI/13DtRgYZhjRXq4ZcJCtaSBWg5yvDwBG+wH+k5MchkhoRmB+zKB?=
 =?us-ascii?Q?lfQwmhev9+65WQ9RMNxF9M3yVHcU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?18iAwvrNiOxdeUw5zLkUhVeaXqhECG7uywkH5q5GWHx/8JSC5PoUiKgBZS4F?=
 =?us-ascii?Q?rZP9B/T56fwnXJTEuD/yDWepm5zqqu3fLWewElDxJihsLBqwVCl0shIiqffL?=
 =?us-ascii?Q?LYq9WuABxcBP61h8ysgnjqeliGXnnGBMNC475ghVg2dy4buFSyE+iCx1FG4L?=
 =?us-ascii?Q?codUdRsjz2wPJ5+yL9Qt7Vc8mzd2n/bRr9kFzH8UH1wrBswOAVVe4uUS52Ew?=
 =?us-ascii?Q?Kd5WX8hH3ob/f+M5gKRgd7uxcQ4fzaW9KonYSjA7TyePUP/mO718HxJO3S/v?=
 =?us-ascii?Q?kNXa+KTw+TSJXPbJrRl2/SZ7tQXx0abgehY/e1wDuuU0GO9cLGXssJKCXCju?=
 =?us-ascii?Q?HNUOA4gjncUNtpG1vK4S7W6nppGeX+2rDS/rnwVu/xXdsieu7VuKhgpsqfUA?=
 =?us-ascii?Q?ZcWMleUz7V3fgITxEtxGhI3rxZaNfJF9ALdf/4yr+a9eDLLnvWe7Fa5Gs0mt?=
 =?us-ascii?Q?giMgo9uD11aZePn6Kjbk9WsJNSraRyBAm3CpozWEUTRBhSa9UWOPflv/ZdOM?=
 =?us-ascii?Q?LGXPAFASJORq3622+3xqydkFZWQj0MrIGIFphgsMnj5zMBCqLwwKlNQADM31?=
 =?us-ascii?Q?Y/oBzU+0kw54/Ur75a+9WFWCF+VXI12P3yU7uM5vVykAnznaeSDfG+4BzdRE?=
 =?us-ascii?Q?qwQUXhBBREbVKkSb8ioKwT2eIb8L9FLgtikQS6cLGAXjVEOGLu2uFSS98CBd?=
 =?us-ascii?Q?L7lIZlUhAgSR36ZEXVAeNbGC+tFrpRgCvrP7pzAMlC5Qqdr1cKTx7sD0JdwI?=
 =?us-ascii?Q?7TT4sMPYKHVeJWKndsll2XzFMHHYk8x0iQ8KwmK5D2K/vxKHAnJhYanWzvKY?=
 =?us-ascii?Q?hAldV00yL/RgkC9Ej2Ggc3anv4bRM2LLSsL0Awxqian9zTxJwNcdBr452BY5?=
 =?us-ascii?Q?4dEDEOWUEcU/vIDfaglVt61/bI3j1v/Q20P68IINTgGqcQ35qrS+G//D9VAy?=
 =?us-ascii?Q?Wl1Lzvib24DZWb58ubZSy4JngYffeee+Voqk/qtb5vsqjLIxP53kOE16HrAN?=
 =?us-ascii?Q?HZmRCbWLqpMqqBov3lHgTAs3BjusOj/kxHYqW0Ae5TuM7BuXUaVDCXjhZ8BV?=
 =?us-ascii?Q?gIt3DVDV8YTUgHO7nloK1QVToEiXG+N0EmfeponZgaLXE12dFKXVZ/s4ioKv?=
 =?us-ascii?Q?I1QD7k6clLVskJG8O29TkUtgtd9ArOh7Hy9hL08JuPMdMuxf96VCDOvWGTWZ?=
 =?us-ascii?Q?fzMEY2xkAb9mgaXYY7CXqsiHMtF7x2w7oUvaW5EC2vnOlicvF5yuav7lUh1Y?=
 =?us-ascii?Q?KOzlbeuxlV34tEpHdfRy4dO9b4eRtHJ/TUVOK1X/5fsUOVYXypTaq87G/EM7?=
 =?us-ascii?Q?GHKaiIxYd1q23z0M5ykO0OMYUiiItmwUvNl5vc+KviEBdAROIwIP2Wr4ARfE?=
 =?us-ascii?Q?nQVVylYLhMV/T8HT9PRNunoarkH+VE7NwRpGFVOvzibkgY7ZRw1okTd+S4XS?=
 =?us-ascii?Q?gh4KKyPsOKmKemRLedMPKTcYkckowJeiTSVjsIrp+vzue18+PzX/FlMzTrzG?=
 =?us-ascii?Q?yew1yZ4YoxjMhjkyusCNv3XaVIUx7l/AsUhj91fcPLwclVvDSvVfQ3iKMIAK?=
 =?us-ascii?Q?Ahr5DpjPkOmxNSSmV8hU+KvcIM0DxaPGF+RgJDHp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e21f74-85a1-4bcd-6cc9-08dd5517bd20
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:11:00.3366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTOKo61qK3Q4t7+AywPcmAjer/0+GNX7WH5k9GOS0SnSw2yyKcshLOBGXFl448DN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6163

On 24 Feb 2025, at 16:02, David Hildenbrand wrote:

> On 24.02.25 21:40, Zi Yan wrote:
>> On Mon Feb 24, 2025 at 11:55 AM EST, David Hildenbrand wrote:
>>> Let's implement an alternative when per-page mapcounts in large folio=
s
>>> are no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.
>>>
>>> For large folios, we'll return the per-page average mapcount within t=
he
>>> folio, except when the average is 0 but the folio is mapped: then we
>>> return 1.
>>>
>>> For hugetlb folios and for large folios that are fully mapped
>>> into all address spaces, there is no change.
>>>
>>> As an alternative, we could simply return 0 for non-hugetlb large fol=
ios,
>>> or disable this legacy interface with CONFIG_NO_PAGE_MAPCOUNT.
>>>
>>> But the information exposed by this interface can still be valuable, =
and
>>> frequently we deal with fully-mapped large folios where the average
>>> corresponds to the actual page mapcount. So we'll leave it like this =
for
>>> now and document the new behavior.
>>>
>>> Note: this interface is likely not very relevant for performance. If
>>> ever required, we could try doing a rather expensive rmap walk to col=
lect
>>> precisely how often this folio page is mapped.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   Documentation/admin-guide/mm/pagemap.rst |  7 +++++-
>>>   fs/proc/internal.h                       | 31 +++++++++++++++++++++=
+++
>>>   fs/proc/page.c                           | 19 ++++++++++++---
>>>   3 files changed, 53 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation=
/admin-guide/mm/pagemap.rst
>>> index caba0f52dd36c..49590306c61a0 100644
>>> --- a/Documentation/admin-guide/mm/pagemap.rst
>>> +++ b/Documentation/admin-guide/mm/pagemap.rst
>>> @@ -42,7 +42,12 @@ There are four components to pagemap:
>>>      skip over unmapped regions.
>>>     * ``/proc/kpagecount``.  This file contains a 64-bit count of the=
 number of
>>> -   times each page is mapped, indexed by PFN.
>>> +   times each page is mapped, indexed by PFN. Some kernel configurat=
ions do
>>> +   not track the precise number of times a page part of a larger all=
ocation
>>> +   (e.g., THP) is mapped. In these configurations, the average numbe=
r of
>>> +   mappings per page in this larger allocation is returned instead. =
However,
>>> +   if any page of the large allocation is mapped, the returned value=
 will
>>> +   be at least 1.
>>>    The page-types tool in the tools/mm directory can be used to query=
 the
>>>   number of times a page is mapped.
>>> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
>>> index 1695509370b88..16aa1fd260771 100644
>>> --- a/fs/proc/internal.h
>>> +++ b/fs/proc/internal.h
>>> @@ -174,6 +174,37 @@ static inline int folio_precise_page_mapcount(st=
ruct folio *folio,
>>>   	return mapcount;
>>>   }
>>>  +/**
>>> + * folio_average_page_mapcount() - Average number of mappings per pa=
ge in this
>>> + *				   folio
>>> + * @folio: The folio.
>>> + *
>>> + * The average number of present user page table entries that refere=
nce each
>>> + * page in this folio as tracked via the RMAP: either referenced dir=
ectly
>>> + * (PTE) or as part of a larger area that covers this page (e.g., PM=
D).
>>> + *
>>> + * Returns: The average number of mappings per page in this folio. 0=
 for
>>> + * folios that are not mapped to user space or are not tracked via t=
he RMAP
>>> + * (e.g., shared zeropage).
>>> + */
>>> +static inline int folio_average_page_mapcount(struct folio *folio)
>>> +{
>>> +	int mapcount, entire_mapcount;
>>> +	unsigned int adjust;
>>> +
>>> +	if (!folio_test_large(folio))
>>> +		return atomic_read(&folio->_mapcount) + 1;
>>> +
>>> +	mapcount =3D folio_large_mapcount(folio);
>>> +	entire_mapcount =3D folio_entire_mapcount(folio);
>>> +	if (mapcount <=3D entire_mapcount)
>>> +		return entire_mapcount;
>>> +	mapcount -=3D entire_mapcount;
>>> +
>>> +	adjust =3D folio_large_nr_pages(folio) / 2;
>
> Thanks for the review!
>
>>
>> Is there any reason for choosing this adjust number? A comment might b=
e
>> helpful in case people want to change it later, either with some reaso=
ning
>> or just saying it is chosen empirically.
>
> We're dividing by folio_large_nr_pages(folio) (shifting by folio_large_=
order(folio)), so this is not a magic number at all.
>
> So this should be "ordinary" rounding.

I thought the rounding would be (mapcount + 511) / 512. But
that means if one subpage is mapped, the average will be 1.
Your rounding means if at least half of the subpages is mapped,
the average will be 1. Others might think 1/3 is mapped,
the average will be 1. That is why I think adjust looks like
a magic number.

>
> Assume nr_pages =3D 512.
>
> With 255 we want to round down, with 256 we want to round up.
>
> 255 / 512 =3D 0 :)
> 256 / 512 =3D 0 :(
>
> Compared to:
>
> (255 + (512 / 2)) / 512 =3D (255 + 256) / 512 =3D 0 :)
> (256 + (512 / 2)) / 512 =3D (256 + 256) / 512 =3D 1 :)
>
>>
>>> +	return ((mapcount + adjust) >> folio_large_order(folio)) +
>>> +		entire_mapcount;
>>> +}
>>>   /*
>>>    * array.c
>>>    */
>>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>>> index a55f5acefa974..4d3290cc69667 100644
>>> --- a/fs/proc/page.c
>>> +++ b/fs/proc/page.c
>>> @@ -67,9 +67,22 @@ static ssize_t kpagecount_read(struct file *file, =
char __user *buf,
>>>   		 * memmaps that were actually initialized.
>>>   		 */
>>>   		page =3D pfn_to_online_page(pfn);
>>> -		if (page)
>>> -			mapcount =3D folio_precise_page_mapcount(page_folio(page),
>>> -							       page);
>>> +		if (page) {
>>> +			struct folio *folio =3D page_folio(page);
>>> +
>>> +			if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT)) {
>>> +				mapcount =3D folio_precise_page_mapcount(folio, page);
>>> +			} else {
>>> +				/*
>>> +				 * Indicate the per-page average, but at least "1" for
>>> +				 * mapped folios.
>>> +				 */
>>> +				mapcount =3D folio_average_page_mapcount(folio);
>>> +				if (!mapcount && folio_test_large(folio) &&
>>> +				    folio_mapped(folio))
>>> +					mapcount =3D 1;
>>
>> This should be part of folio_average_page_mapcount() right?
>
> No, that's not desired.
>
>> Otherwise, the comment on folio_average_page_mapcount() is not correct=
,
>> since it can return 0 when a folio is mapped to user space.
>
> It's misleading. I'll clarify the comment, probably simply saying:
>
> Returns: The average number of mappings per page in this folio.

Got it.

Best Regards,
Yan, Zi

