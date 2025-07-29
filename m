Return-Path: <linux-fsdevel+bounces-56285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6479DB15537
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 00:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF24548256
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 22:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C604283FE5;
	Tue, 29 Jul 2025 22:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ELsXPOhx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6202315533F;
	Tue, 29 Jul 2025 22:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753827723; cv=fail; b=eiC9889trFtPQvShpGehcLhi3FJYzSzvqDFvKgBH6VAHGqKv7qThPzcVUrC9a+xrN0YyqTjiTpDlj9z6g5145w+mZE86kwg+GqXmYwv3yaE2CJ+/Ry+pujv9OKttTxXBze0N4L9bgk3g08IoeDe02zyem+/uhyvbGCd9KxpVVMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753827723; c=relaxed/simple;
	bh=M7BmPF2SZZyDPWaNJwp3ow9oVqM3K77HGCYyMz76MrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mu6YPb2ZPqyuJefp5e5ALSIKfPqXvdfD+OI9AaNfPIiNE6tDUKKHiUD49t8XtmhJruHpJiuelw8F12cWjJu/Zz3nNDZWuNFQngISc2sCqRYhuRuFePvItqILiAHu14Usrbh/0TLAAwNpxWdouQ1v+34v/Pj7/U+9BrrRsWRRhkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ELsXPOhx; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqElfRx+uLQjUrtqmL0QznmVnl/FEVk7A6Ir4FFqgfZ2uof81OSkBblvmjy7xIJvSd4TZ2EyUiGvHo10ldlQX/WFKQGcX6uSde81OEtAskjbXmjIhVTobQV8L8282sHRE5qLDxdtrq/o/iiNa+rtbZUNmSQzGWatyxIg75i6o/idlhfdibdotTj0OudDLaQHen/On6dMD7f25PMY3ptbmoI9vJ2eVGE+0cQoQ6h1/7rC6JsF53GprPFx8ED1rrijlEDRGGjRsJ0L5+fQ5VYGmCHd+G6UMrRxPeTxwHomxIpgdmI/BJ5BCXWoxejOl8495Kh70zBujRM3dhCqn7kXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+QwxI/me2SDEfTj4NU5e9TDuw76oaCv3+1B24Z0n6c=;
 b=PkkFxNQh+KuAQosUoC5AWRkx9I3J/Skn/xBqmYD1+QraEurSNLhSHRKTwX1sxth4V98noZ3M4M61aYKAD89uiMRBenvm5eI7EDuBQ3r56majwuUQwnyk2utAeRprw/umhtiuvhvg2foyA1sYbqW/K7qU7S7Q5iN1H+957LS94sdvG+B3AVj0DbnqwH4RU9wURbi2SOub3P4GjwKaxMy+TbcLQjz8dZAMnPr42T8//vgXm5fLktkmT/fVGJDBLB+B3U89Qjo9Wsesx7kx0oLTWQEf0t0RWqpcSTsgIwEasGbENmhbspfru3je0ypvhHsRJlwvhYVyy74LR0BXUWaTvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+QwxI/me2SDEfTj4NU5e9TDuw76oaCv3+1B24Z0n6c=;
 b=ELsXPOhxXur1xS5Iwn+k7Dyc0VVz8vTImcJCedyisej4b0unvnWJIWLqd1TyUDk/nUWnWGsqgRgyeuA52G5SVDPsOc8JvDUDpMdf0lqp4ahrAD/oJaCWrgg40FMZ3JUFrpaDjycOaZs5JVSA+SGs1bzxFhrWDYXE/7V8LMENhNBw8GfG8+IUye7YqXy1F7z0DsgEhTcxkAfRBfUbBOQGmJXwlyr6aClk1qOmGlPbUYrTReysoOeWF0yn6VCVbRR7acJAP2WWfrQJZxwxPRoLV7d/eIXxcteb6QAgqXzlUdcvVU5S5vanHQhQLm4TF67Ure8WG9YAGE/hSpg6KQQXBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 22:21:59 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8964.024; Tue, 29 Jul 2025
 22:21:59 +0000
Date: Tue, 29 Jul 2025 19:21:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com,
	corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com, myungjoo.ham@samsung.com,
	yesanishhere@gmail.com, Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com,
	ira.weiny@intel.com, andriy.shevchenko@linux.intel.com,
	leon@kernel.org, lukas@wunner.de, bhelgaas@google.com,
	wagi@kernel.org, djeffery@redhat.com, stuart.w.hayes@gmail.com,
	ptyadav@amazon.de, lennart@poettering.net, brauner@kernel.org,
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com
Subject: Re: [PATCH v2 31/32] libluo: introduce luoctl
Message-ID: <20250729222157.GT36037@nvidia.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-32-pasha.tatashin@soleen.com>
 <20250729161450.GM36037@nvidia.com>
 <877bzqkc38.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bzqkc38.ffs@tglx>
X-ClientProxiedBy: YT4PR01CA0190.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b17ecf4-c401-4a66-48e4-08ddceee5566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vr7nfVJxxkDouchKPRZgbsc6YGzLhz3ZCt+ugcwK1BkfOiwkDeWwUi4zBtR2?=
 =?us-ascii?Q?8KN59N9U0Eq57MZiPSyP1pyEeYGxXXvgEyQjHU3qGLwBpxGOZC+X+xLAcXAd?=
 =?us-ascii?Q?fR3BwjusaFCYLTBPU5bhYVvHR+OAhR1RxYlz8g4R3z+gb+QWJAd17OqGkMtn?=
 =?us-ascii?Q?4GK7OwYEMAVDiR8ebIT+6BBz9eM9vKj35QnvSl55y0/nsO2Y132f+sJQ9sfT?=
 =?us-ascii?Q?bSVXgv6kXHQyUZC2tV3U9EyLpmV76lJHUyBUJ3O3Hrf0IdQJpBLpNBH66WYa?=
 =?us-ascii?Q?7ZKL/x1fLKzMlVn2x4bVbiGexrWPoEIIoojGaX+JL4SBsOXDtPPI9SFA7yCX?=
 =?us-ascii?Q?Smb5KgttL+S0litr2T2ekWHXEJMlANwoY3yeFAY/4UbGricZc9YbdUo8og3l?=
 =?us-ascii?Q?mxye1cxQtSdL8mayOhS+poW2KwoJucath8cN5qtaEdaC752w0WwRp2Qdq+ti?=
 =?us-ascii?Q?9AQfw+n3X+ZFDKChltJUjmiEupm7lfQ6rvJEKU0XrKKIfc2eIKKOvYeM/nmj?=
 =?us-ascii?Q?1QEh2jRVhxOGyVySEynkU4MTVMjecXIpvGTB9mUZHKFcY+R4YxXi6UEpWHfy?=
 =?us-ascii?Q?aBDYIxtsUVugggWbQD5iX2OmfReHcbyXXWA8AxznEkVS2Xg3HMP1snTQ9P6O?=
 =?us-ascii?Q?aX4cda97QboZcuxOHDDftimhns520d9/i0mn+zo8C14PADkGG1k73A/RJ8Kw?=
 =?us-ascii?Q?vG8JZU1GFapFYVr6jk6fh3V4OwgnoCajxYiJBaS2I+6/FVLJmfMpeNm2R9Te?=
 =?us-ascii?Q?v8nBB1PwphFj31eKQVZFmFqlpBqKwLB5Boe/z62t6NMQ0UkAfU0AeeFytrBN?=
 =?us-ascii?Q?yIhx+C3ZkcSV88Y5f759CrF/Z9do0aoByASARXdKEsL0jXJOoWZU45cdPjMt?=
 =?us-ascii?Q?irmsegnG/EiZAb6d9M6Id0CyvQzIV+5vkT2PtyzBvAX3qBbGxiDkydlacs5z?=
 =?us-ascii?Q?UoFtPgZmbZnTAC2gHTpX/oHG/9hvnxy/mMuna10gjkosNLB3NJVVara6YZkk?=
 =?us-ascii?Q?nKxzsKeoTGUsPqCk+C+Flfhop3TYUwqBtkubQMaAVIzxKRL5j3JMcwqiH1VR?=
 =?us-ascii?Q?2VVN/D8KwH9t72XPUNTAg316XhCZ9dSZ4XwPi8jI3uwFY+LmgWHXYgg8odIR?=
 =?us-ascii?Q?7i/0Y1jPEyvAAKuJUNlI7BbiCUdq0+sA35XDCbRC/2Pkk6HCYDir7ZnVA4ef?=
 =?us-ascii?Q?Y+zOlzU4XYsYjC/MYe/5njJbzlTAwxB/rcTtxGTsIh74zo9Ln0AybKJA4b7z?=
 =?us-ascii?Q?LuOj976s6FwFuAjAZnDRdRZH6TRXjWZJ1FTRrXUZZEsel6JI6HR5bUpdoPsX?=
 =?us-ascii?Q?74IqVc8bQVB0ppgsvFv6XJGYTftakefthCatk4JN0hvfsyzk87x8ewgne9lK?=
 =?us-ascii?Q?C0vhVd1z+HjAbdH7A9o310cpyMMhVSiHKeS7lglTglsay7GXuxT1UqmHy9J2?=
 =?us-ascii?Q?cxNnmktBmMI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oITAfg+KlOLFkysRmWtSbrCBg+lh32jb7PLMLy/z114PaGXOXKe2wZTzJdBT?=
 =?us-ascii?Q?zPgXNlt1HpPfuzhaJ+DruX7WbWGvNcyS9xYSWkRjiEGko1H/BF4JzA/9PKNn?=
 =?us-ascii?Q?K/6NDaKlf8ot68T4tde+ZDHeFE48TMWZ4ldLj6Wi2UyCkmpdA8Ve0KLTgkSN?=
 =?us-ascii?Q?M2lCLl9y8PrwN+Lqth6snSygYf0awWcLhSZvXO4fnOnqkriFMfm9l1BoT6y+?=
 =?us-ascii?Q?jQ+ncbycGDFgqYWB02X6PfXcCgcwY1h3yzLWkOR9KfWo0zkha6cjFHGkRszt?=
 =?us-ascii?Q?jcodvqlvNYbnweuBdsam9I9ST0zYis/Ow13t7Q2FWYTHHkLk4t1PwXixwVpT?=
 =?us-ascii?Q?7iA4+uEfw4FMTsvNadJLcaYJrTgR4sZl1+61L1cDcPT441+0dxdoRzRdI76L?=
 =?us-ascii?Q?1S00szkBJbWVVdxeQh/3kzzlCurR5e8DdhO/ShreJQELRymhYxJx9JqfEqKV?=
 =?us-ascii?Q?d97iBitsZ9XhHJl0HSxm2M8Z9INPANJw047L6ODXKq0+T+cPGyIKSQcsoHtC?=
 =?us-ascii?Q?5peJq1NbS2R1Ku5fn1O7lWyXb476HDAuVobG6wrK44VBqMiavXeyzBTEyJY1?=
 =?us-ascii?Q?AyW85xnaGeajph86I7+Xck9oAMwX9cQ9vYJf1zVF3VXeZSAZJssalcggEElc?=
 =?us-ascii?Q?B3liMr6GUj+XMb/VfyBOVSAeZo2crknzrG/NWPh+y5u3lECOjmRO7Q0naPDV?=
 =?us-ascii?Q?ndhDjhDMwl8vA8xC/I66tp3icKnU9jMEERc8LW57bhZ2M6a/iC9wXQDv2P70?=
 =?us-ascii?Q?sd2Q98Hb3/7YGf0OqYQbhTyb/6aMOjbnGL+m1izD2VSb8RVHGWPk6ceCDYP+?=
 =?us-ascii?Q?z6x6hA6v2OTN9SyHAhEWM7VxLfJrLXo+6ES2/WdpjKmRD/hwxc4TP0kUs4yC?=
 =?us-ascii?Q?kBV6amjo9tOAlflTPH4SrIwEa1u08fHSZgJnn3FxysOjon8Of6YeplvZICTW?=
 =?us-ascii?Q?6c68WtYJyEe6BjEZjTsDaF6UtMV3w9bpUVT8Ft4b/6Ebk6w3TR5QXO8ECbKk?=
 =?us-ascii?Q?aBasP4E0COAL/xusVOxW/rs40ItFiIhnA+4mc6mffu5zdQvuDsI1UWTm1TtS?=
 =?us-ascii?Q?ejeq0OODO70o3R2jwZE9+uNyJRfL16TXURebv/+8ttyErUQ+EJpnYXdqDzfH?=
 =?us-ascii?Q?bLYjQ0JAimNaD2FFHeuFgtRh1eYFXtZb1Op7T6VcflehLEE9aR97Q/kZj1mQ?=
 =?us-ascii?Q?ngHKmGDcVkPib3hiP+dqYzWHGL6otRuGe7MTqRpOrZUGLLnCzfJovwPAn3G/?=
 =?us-ascii?Q?93+miq1IyHIlKHOGOXaQeLQSwAtfemHJIPWT5/9YQuICcz45FnDOtBUFLlo9?=
 =?us-ascii?Q?cT5UOU5prm9lJYEWIskVgJdriP5TQ+kTGPzuJqfj56BjdN7yHVf2f1Ua+B9/?=
 =?us-ascii?Q?xpoBVmrOW4iSiuuUPz0QefmTMpOxvslGnrEiEnLNy98AiObNmG6rkX4t3fox?=
 =?us-ascii?Q?GLXs7cS7O/FYAVuUhzOE7nodZsriRTtIpkcKlSNNoFMeAyr6eyZCUwwYwxY8?=
 =?us-ascii?Q?AOmeqt/jutURTErMmiK7XCdJ1IWH0Q3FYD8egJgy6ctCkVgbId4wsFN4XYO+?=
 =?us-ascii?Q?YuxIICn3AZzHRg0O1Zc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b17ecf4-c401-4a66-48e4-08ddceee5566
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 22:21:58.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HUiQQpMQZD3ImjcEjbf85uWJfNXDb5F+M4F8nXpeeDlDL6F8zoL/3Rz81dB5Zjw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581

On Tue, Jul 29, 2025 at 09:53:47PM +0200, Thomas Gleixner wrote:
> On Tue, Jul 29 2025 at 13:14, Jason Gunthorpe wrote:
> > On Wed, Jul 23, 2025 at 02:46:44PM +0000, Pasha Tatashin wrote:
> >> From: Pratyush Yadav <ptyadav@amazon.de>
> >>  tools/lib/luo/Makefile       |   6 +-
> >>  tools/lib/luo/cli/.gitignore |   1 +
> >>  tools/lib/luo/cli/Makefile   |  18 ++++
> >>  tools/lib/luo/cli/luoctl.c   | 178 +++++++++++++++++++++++++++++++++++
> >>  4 files changed, 202 insertions(+), 1 deletion(-)
> >>  create mode 100644 tools/lib/luo/cli/.gitignore
> >>  create mode 100644 tools/lib/luo/cli/Makefile
> >>  create mode 100644 tools/lib/luo/cli/luoctl.c
> >
> > In the calls I thought the plan had changed to put libluo in its own
> > repository?
> >
> > There is nothing tightly linked to the kernel here, I think it would
> > be easier on everyone to not add ordinary libraries to the kernel
> > tree.
> 
> As this is an evolving mechanism, having the corresponding library in
> the kernel similar to what we do with perf and other things makes a lot
> of sense.

If we did this everywhere we'd have hundreds of libraries in the
kernel tree and I would feel bad for all the distros that have to deal
with packaging such a thing :(

It is great for development but I'm not sure mono-repo directions are
so good for the overall ecosystem.

I understood perf had a special reason to be in the kernel tree? I
don't think there is any special here beyond it is new.

Jason

