Return-Path: <linux-fsdevel+bounces-59295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B9B37017
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 18:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574433A9A8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 16:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966B82FE04F;
	Tue, 26 Aug 2025 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ahGyhWWF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B51260586;
	Tue, 26 Aug 2025 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225329; cv=fail; b=ov5KXH+LdEq6JszYqbPouBXxKIh65lleZ2osYJMMKmMpCQclgtxrFvtAtgCLLy6R7/UjCk0aP8nhdhyUxUQt3jzVUmigKyT6PzrLIS9Spu1eoFoBLDzTVkOOoQGHnuINR66pfwp/wW3HM7iw4hvBxcYw4hPFMNqBBKas53Mnt5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225329; c=relaxed/simple;
	bh=WK2DXXdYVj8OY142BmwpLMdLzv7nQAkfCAI8xwI5LKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IBIv3mjCO90WS72R3HwD5dPgJGoaCOz9mbZRfmz9csLZQCClnev/Mc7O1Zmukkvi9/PigGp9X0yfIJl0c3PcI+7x/9E0uI4512rGDycYEvqYbcoBuZor29YnBgX6aNBZxMAD6+77pIOaTzvv5TIFa6bUW937/CT3xdrvvybX0cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ahGyhWWF; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQyOJkTOx5KximjAmsMFieRgYXljszP5+gB0oNKi9Ff7fKyHsVjI0aZbv37j0SA++HKTIZvFkX7PAPiTYI5YovvXBFAdR4ZqQQFkKjeLo1JFvRdg809eTAwHB3ot0eNC17l7W632XD2Butp5Xh2D1e8W8fR31ede48aGE+2gXqNzJXrJ9+h1z3QZqlnWOV0keDDYuo47W3KfwFldX6HXWm862YzsDhUXmUDO19r6EOxJLIJTCEoLis4u82OxQkNIQ81lWG3npanwGu9utcGKBnSkSc1aVGRhi62ToilRm7YmP7UJbRJbRLKxi99WHbYDS6Zic3zwumnOZbAoOe249A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk9BlGJyD9SrnfuGGwo03L8Bzk/w8lPeOIoHbKAnTGM=;
 b=fzxprK9I5sDIud0oOj6qH6PTUWWQFT6CLMcwi68b2AplZ/4poGcI0Uw5InlEOPmGmW66Qo9ace8LJQeW+46j85ElqfNWyXFo9RoOqRh0Aj2yGHVrrh4Epqe4IY1IK1kVPCUmX6f/mKCXnw9GeO+A5nA12L7qaTpuCCd99hnQa/36b28z5lnWtM/N/DiJ2QPGAuqpPCWrJtnqnEjFrQ+DMbuwpv9abStuJjBFZbFzI0L2sYNlq4r9pAUIROjKKI9kSzcDShbUVTZhwU57n9d/UUJPQpUJ7/QZtwS0obDQrEEtNBgrRZGBC02Qlk3fAsWcxvtJ0rWkqyTewyTUbEt0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk9BlGJyD9SrnfuGGwo03L8Bzk/w8lPeOIoHbKAnTGM=;
 b=ahGyhWWFQ2379mbUcFJFCKioIylh8JYw4sZX1RKGoimTSmnW+jZwdBBOQZsv7hSlZz5zig8hTFt8qN/u0XWyjbLXdiXwleuQmAHrEduzL2oQiFjHNIfeSRSdNwxIxzVgnP0LXxvPeOntpipVWRhD5LVtt1eKw7MKHVO9yrka6gV8NJtoTMGsvrrd/WUcos+EMbv894Ybu1W74jSHcjuuhRetuWaYlpEHUF63y5hTwphj2ttFceJLuFO1oDsyqqk1fjt+7bO2smDddMp0RSDHIQmaqhVymhpKanRZph+gPUJP3rpxB16bloSwfaDhhGEPp5joQ6V5MAqr4ilO+iYQUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 16:22:05 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 16:22:05 +0000
Date: Tue, 26 Aug 2025 13:22:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com,
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
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
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
Subject: Re: [PATCH v3 00/30] Live Update Orchestrator
Message-ID: <20250826162203.GE2130239@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <mafs0ms7mxly1.fsf@kernel.org>
 <CA+CK2bBoLi9tYWHSFyDEHWd_cwvS_hR4q2HMmg-C+SJpQDNs=g@mail.gmail.com>
 <20250826142406.GE1970008@nvidia.com>
 <CA+CK2bBrCd8t_BUeE-sVPGjsJwmtk3mCSVhTMGbseTi_Wk+4yQ@mail.gmail.com>
 <20250826151327.GA2130239@nvidia.com>
 <CA+CK2bAbqMb0ZYvsC9tsf6w5myfUyqo3N4fUP3CwVA_kUDQteg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAbqMb0ZYvsC9tsf6w5myfUyqo3N4fUP3CwVA_kUDQteg@mail.gmail.com>
X-ClientProxiedBy: MN0PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:208:530::24) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f0af37-1cce-4091-26ed-08dde4bcb224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0e1cbFPDcFuomRotUSQvBpuNTgIadllUT+3R7FWkyNGh8m7HwG9HNZWlSFW+?=
 =?us-ascii?Q?H/rhTa8V3nB/oBoqNQRcw27s4hp5Z6nlJ2cytL+30RwNYHastjujFSyspmKd?=
 =?us-ascii?Q?KZotjdbbSxV6Ezqu3s3gt3af6fbZKm784BxTCKw9FbzSL/OPMHvVmX6KiF3q?=
 =?us-ascii?Q?14YSgpul0QmHXg0OFPramfSd97s9D4LRH/2UV6tKlOhUZWc9/0UUAv9FfPYH?=
 =?us-ascii?Q?ZZ0TtO8U9LPKZQX+5ObRQeiWlk4MOKoQ52rhwcUsN9Fq80xoxfB3uSBDT4mz?=
 =?us-ascii?Q?Wnnp270LxV9qxs9+/Sl1FBz/WRcqVzqQW+aGMLUflYjGrBH1NVPzIX5gwE1Q?=
 =?us-ascii?Q?47i5wiTI4XhfoikW1jbNBI19FvhktDVRm0OwfoljwS6tSe4Re6Qrf228IJSY?=
 =?us-ascii?Q?Sq4uH+GuTeJj+H+pSvvLkugJGBKieKsHjR51VeBwHpiBlpUm2JmIiT1UwkTf?=
 =?us-ascii?Q?Uzh70Dmom1CSAxRgWB8u2YjshDY9D5OCIYITtc1OKZ8tq/Ri4GNQgZlRcAe9?=
 =?us-ascii?Q?nPwRcsuNKkp/66G4GyHq31ZoXug5QhikvCrI5rkI2mefMsVFrWZAs5W72J02?=
 =?us-ascii?Q?QKZZPW3IYfZl0lJwdkXxxxxF6FH76jfiJpY9YwTV5f1hHY+K5FGQ3dxuujZL?=
 =?us-ascii?Q?cS0565uFD6lxtWC/iGoRIhPCDWF0DXUqEqngOK6OXfvE0c9TlLav2A/QtCp+?=
 =?us-ascii?Q?AG76sz6piRRfbUGLhYKB8q0iREMRnoNnZGUHD42HWjb1n89qGKeMJt8/B7Nf?=
 =?us-ascii?Q?w/pWCctbVdfXL+/Qfps6AOZXx/2PMDKbWp3bEPYKQ1DZ73xZSY2X1d53ilwO?=
 =?us-ascii?Q?cHdBYp2d3L746Z7r2gn1UUbmx22ASdt/vEFlH+0tg6Z7+kltNKs6/oAzBfra?=
 =?us-ascii?Q?ViOklZXPyDSu9CTEocU+Y1pi8JAlDmoKeniSaTLdSa4jc+1UtM8STPJM4Ek0?=
 =?us-ascii?Q?5nEfLqKi+ojarKcPZJ8XjAY4hoh9B2U7qrYxM68P1V+Bwb22MSQrApoRSfQZ?=
 =?us-ascii?Q?+A9ZAKpVGQrs2AGwu3d1twds+8ooScgWVwVgjR1Z4JIT2sOxivYwyOoePGNa?=
 =?us-ascii?Q?yljlhejjBbXUUK5TzrzO4iLsSMiwh0ZM05hUJsB+prdpf+CnMUcnAqB1/Te/?=
 =?us-ascii?Q?IN2iO6wCHu8QsK2V66gRXev3bT5kI0etCl31XU7HrSb0xggzlZ/3WVFm5AUe?=
 =?us-ascii?Q?/fDIJCIibRGI5iaM/56IJq7YGlS/VVwXLSw8NwIpcv8CfHQHdGQoeE/smJCA?=
 =?us-ascii?Q?QVaC5tsSWX50d9GNOTJ8jFuUOH4IVsUroq+k6LGdO8TafIEE7CtmyXNOWOMA?=
 =?us-ascii?Q?9AMgRzhn1b6L+ULhMUnO+rNSxjKqzB52DMXcqcgDHIZeDlls7wpUVEck+Gea?=
 =?us-ascii?Q?QIWQKrEi6dDG9Aj8l3VrmLI3V5GtNcmtFs/gs4PpUKaRNir1eFn+GjDN6hXY?=
 =?us-ascii?Q?2rMXa1mC+X0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Qvk2ezBpJSp6c9nUz6P3oF8WcvnNnZZwGFSoaZyN8f/EB0d6LtBwIsFlxm3?=
 =?us-ascii?Q?6NHBirDiSzQ6UksMjZoraWIwmNrzkChUKP5PR2elf/mIIOeWQ21Kj9kcMKla?=
 =?us-ascii?Q?LO6eV2TBQ2nS7u1gNqFaqM+3oqpALdponrFIe+1DD6ic4FMftWqboW+TVzCM?=
 =?us-ascii?Q?o8QA+W2ADozjwsdw2STdmkdT6C7y+7lJiKQXA+4r2BHYOQu/90EQPsbw8ih6?=
 =?us-ascii?Q?4wbS0Qgmw/vR/ETv1jkENz36fm6Uxpi2dqVWazQJgh+eoPHsETRgTm/k8QSW?=
 =?us-ascii?Q?Rhcz9zbJb3JnIQ86XKSwPYnCROkW57aFpyo5z8Z7+CfzJVXPoCMUbceIoVvg?=
 =?us-ascii?Q?mUWb/MwKhcjZ/3x6inJ6wZy2rwAPPO5eqGX++sB3tUGtT34G9BzopoFBd1Jz?=
 =?us-ascii?Q?ozUSMe56Z+ubTA6HCoGx8S2PJaCptBybWbXM36oHjBWVfeizXN4sqtT0iLq1?=
 =?us-ascii?Q?JlYTPCpXzjN0a8nHrwtKdoEnAT9kes+Vbl1WuaVZdiwac56hxPdnB2fFSI8E?=
 =?us-ascii?Q?wES/JpZM4WEda+VE5LvQsSuxdYDQJWJ/uZejjuLnKiyq6UphcW04nzsTWNzf?=
 =?us-ascii?Q?dUQaatCl/sFR+ifwYxigDwPfB2k2mG2llKLcomQzu2RYomN8udjG//Mk5pxC?=
 =?us-ascii?Q?3XOvxNs8VFGhBWZ8NE5kKrR3qH8gVaFHJNG67Scg0M5WA1ddSoHtJyG/JIYQ?=
 =?us-ascii?Q?MwLgFqLHohTl7ulFDphJikmveQ305VAAYZCbF2pW5ktwNEEF9wmrQZnJ1Nkk?=
 =?us-ascii?Q?2dBFZ9ubVpXsWxWikjW7iU4QzaH25Kltpnb5mnf1i0lw0b6YjgAnLFCWP5aZ?=
 =?us-ascii?Q?EjCKM4cT6EqucUOIWWl7hLsltGL1YLO238uw6iVA4HDIQRv872+T0YGEzB6H?=
 =?us-ascii?Q?3nacnFY5ZZxZO4iI/wd8q0zWYvSxcLIyimNv/iCyaBKU6YrTe14OzpncQgeB?=
 =?us-ascii?Q?gFhygQhzLRHcjNg8GLU0gPKJLmUqDzaJb9X56vz4zknGFQ30FyM5GJ2WfxPm?=
 =?us-ascii?Q?f/fUhj5Joq1Kf9kEHzEvMfY8AOQqKKYz3jHS4rv9NS7iA8YljaFLidnNwJgD?=
 =?us-ascii?Q?+4V72Hf8N09nk9Jul6usOjuap2jLZ4c2cBUf5QFqdKef+1y8WyzrgKFBpYWH?=
 =?us-ascii?Q?e2UAaoeCVoIY7g3WcyGg3EAtV2w3YNoi0I374M10V4IT5tkFEUn638ZRWiBO?=
 =?us-ascii?Q?DBi6hICzjOcL67sjcntpIIPuf4PxLdXaUnF5gTFHu5Bm0OYn1d8nEjSwm/Fj?=
 =?us-ascii?Q?E+mPyJAbdx10n6swDG+OeLqYpOIaiyDIqgvMvl2Op4bAxRLjLT11BUPLFj/0?=
 =?us-ascii?Q?zWfRhVEjt8qdbVODyITrqbcU7IflBLbxrxkHURMo0uagmCN2q5qBuSn+TsYR?=
 =?us-ascii?Q?jUDZu0cRsQOLxea4+xoEsbw3jGKO95mOaoCKKbuyFwPM0nG6l4zupM1ZaDUI?=
 =?us-ascii?Q?Ab+iS4R74turAMjK2NIgpTlucco627J2NoPVL7KbpVBLBnspgCzT8X1493RY?=
 =?us-ascii?Q?78onBvEtfymNpK5F9/3Fi8rVUt3eJZPxVD5Df0i5Plg8tJ9JamFJ0x/AWRfJ?=
 =?us-ascii?Q?F07tRceycmO3U4T3BYD1pgO1+cYq5nXa7kNTp+0g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f0af37-1cce-4091-26ed-08dde4bcb224
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 16:22:05.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dc9q8x7Yu8Bz4ZI66FjBNQO2Vx0UL4jKbMe3ZYzcvMDTo1BIdOWPNlQe2I4cwV9u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734

On Tue, Aug 26, 2025 at 04:10:31PM +0000, Pasha Tatashin wrote:
> 
> > I think in the calls the idea was it was reasonable to start without
> > sessions fds at all, but in this case we shouldn't be mucking with
> > pids or current.
> 
> The existing interface, with the addition of passing a pidfd, provides
> the necessary flexibility without being invasive. The change would be
> localized to the new code that performs the FD retrieval and wouldn't
> involve spoofing current or making widespread changes.
> For example, to handle cgroup charging for a memfd, the flow inside
> memfd_luo_retrieve() would look something like this:
> 
> task = get_pid_task(target_pid, PIDTYPE_PID);
> mm = get_task_mm(task);
>     // ...
>     folio = kho_restore_folio(phys);
>     // Charge to the target mm, not 'current->mm'
>     mem_cgroup_charge(folio, mm, ...);
> mmput(mm);
> put_task_struct(task);

Execpt it doesn't work like that in all places, iommufd for example
uses GFP_KERNEL_ACCOUNT which relies on current.

How you fix that when current is the wrong cgroup, I have no idea if
it is even possible.

Jason

