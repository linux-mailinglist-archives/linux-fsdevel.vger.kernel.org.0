Return-Path: <linux-fsdevel+bounces-56266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0F6B15212
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 19:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BAA166BA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 17:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F7C298994;
	Tue, 29 Jul 2025 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EI7+7agl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD36220F4C;
	Tue, 29 Jul 2025 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810098; cv=fail; b=OvT8WIIVDsOXeISI80WstuwgOR7s9QfyWsAEHEuCydD3Jw01nB66gKSOzKtidYu4uSaHR/B9pOMUSYuiYYNo7dqUSy2vM3XeSEwDEWtfeuE46Q7SqsoYWiq/kVGcud3ea4yFmVeT6gykNG5uwNApMtgIxN0Uu9NqbybV/d8LfJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810098; c=relaxed/simple;
	bh=EBSbn+EgimgEZSuvZuxUfTYC/ICAnAzJkmIwPmsU+hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J0Ek1+ozXuPMqHtJP9N5eoSCKZC/2ngPVswmLCxTOa/DGIWte/FYx/eIRO+lV2NLHsrQIEIyteR3y9AXIYIJmC2uqDGgZKt69kTXnTrYTH0GLwBwtMkRleFD6jhXLaRbjC0UMgZ9HZVqLzRuQh5mv3cO1axv+CVrCCfCbqYOnYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EI7+7agl; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkmqxIVHOMtm/ijeIeAXoEPIfwOJkf1YDUZVA1Tb6gCDl2dd7g3gGs5bUTIdAqt0HIM4Sti4Dtb/e2HFn0P57KqC4LCOzMejgUk90XVJHdz6t0EQoS2XVBwBWZC8J197+UViRR4j2p5VnrZ8sKh4xHExgAyd+Gc0KgHLB2aSxfticfcF15A55NYp4nsSB4Yu1zfShzptY5urUM8wCHzAwQjfjD7M9bJV9hzS2R+tyzQFZneYiOuNuOFmbSt11D1RT/lF57hvbOGI0K4t81CmCWl8QvRT/CRD9LoJvWEXaNbvB+VtbfdryqHBXFV8cIWwbKQMuXUHXFDiJGIHlc9gWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCvwTvNajtxikJKCE7yL5gU9gVhFU/uvpLuFGCooEWU=;
 b=vwohi0e+PAnu0O3N6RSlObLOoU3ghN7gXqjg8SBuDjH8ITqe8VvCTAyYYYaLtzUsjMQYkvkRoo74usqhrMUzBg98F4XmX+npsAng4qzmOtonMxFbLmr6dnPI1ElqMvwS1GUMokTG9gddMTplisavKFb0PVUCIQUoJPCD1M4fvgc5Zhxuis9+kD1Foy0od2WmG34/sBdct/DtK/9xoaFCtmRJSrmRrKqCItQmElTHRLHb+s02haw/pBzPmGX7TaVWWIMQs7GO7Ag8eVw/uMEDjGANDV0zGOZgBFBmaFHhCYxu9POf+nfoc768MID/6hAZo5zMbJ64Fj2OsZTlWPR6qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCvwTvNajtxikJKCE7yL5gU9gVhFU/uvpLuFGCooEWU=;
 b=EI7+7aglILKLkdCSQ06kIa76OsvTuFyd98+aq+Goc5lKAEZdz2jhjYewfz3KkEDmtTpjffm/cPiwfXE1Uk2yu8EXN71WsYmfbonnWstf6ngopI5IRIY3Qorla6L4fG2EDA8Ax/K8LKINSEsqTJ9M0S9D+OqOSlcP+h+42GReuvkl3k8vjCc+85Vn2gTs+7HoApEAovdxgRAXyz45PygnrcaQOse6OlNYyWX6zvyRZZh0wya+k2VR2/s7qPgdLx8ejh7Bo6HQ+Iwf3wi5HE+lOINwQksL0d8M02bqOf8rDzalhB1ROje1QczRxCt3vYmmQQ5kgXUkquno6d85ueZFiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 17:28:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8964.024; Tue, 29 Jul 2025
 17:28:13 +0000
Date: Tue, 29 Jul 2025 14:28:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
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
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v2 10/32] liveupdate: luo_core: Live Update Orchestrator
Message-ID: <20250729172812.GP36037@nvidia.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-11-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723144649.1696299-11-pasha.tatashin@soleen.com>
X-ClientProxiedBy: YT3PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ae4e6f-d27e-421b-27a1-08ddcec54bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A5WOMUUUZY4bLoHqF8XmCW4RaM5ndoee+vQgQxMWbjHb68ryMzlQzrun1KvR?=
 =?us-ascii?Q?5LaWdSPuEKZJEaSge352eJqS6FMdwt4uaP7aHWYJ6QrP0o94LbLdTHQHu3rd?=
 =?us-ascii?Q?9YHQaUIH7QYi45r3z3w9W2oHPiWBjnlU1r6sufGBCD/+blDYw3SbzB81190I?=
 =?us-ascii?Q?z2a4UjzCiPUzwBU1Akbao+RvdmlJpDvz3dnhFIXnOfnR9Vsv0jJKlarw1ezd?=
 =?us-ascii?Q?72IRejw6C5wEMX1wGrJXJk/CZ7nyEA+B1HmcdbyXpbyeKTutt5cCpgV2fhzZ?=
 =?us-ascii?Q?t0TaylvOM/5kv4he1n1yOrAqYlDudqg73BMO1SlcyWuOzZxOQPvfIdNQhsI3?=
 =?us-ascii?Q?HleMb3d8nIESetGTpv5ngR4WYJE86uCdu59LNwz3kjTFm9ifVWFqopvIF9V1?=
 =?us-ascii?Q?n1SuClWBIJ2Tbp27A1qGjuZtLzu+ADy+faeksfrnY2HfDdAeZTdyLH/Yn8/y?=
 =?us-ascii?Q?7t7HeR/Xqcy0eBdkA2SCCEyqhq/xrOtAyS50FfWfoIwgvcB/JSZ6eV0Pizdc?=
 =?us-ascii?Q?NyvDti24xZ8eTcVKHfjQu/j+aHIzh7j+OyurgpB0jla0XgZbTuwOyJl8VRRz?=
 =?us-ascii?Q?i9Ee5fHFsqlOgv9SEw44fEa6NmZW3A4aeriQgrxY4jXvVwgx5dYcCI+yabhb?=
 =?us-ascii?Q?Z6dterFQfzv5Yg0D6X/DoLOaHPfzGgBPEqQHhXa9NOoy2Hb/7iWI1ZKNpF2o?=
 =?us-ascii?Q?8ndZanW/IBdLWSVxk/XeuSFXf6dVHIjAGpDiHmqphda44QMBKIb+/oolGg4r?=
 =?us-ascii?Q?7n5H9AQLmcvxmRmX1jYJhp2howB4WveJpAiR89heeUHisvoXn2bkLhvL1T3G?=
 =?us-ascii?Q?bmFNRCShOXRpMfWzg6z760uwQDLqoLKjFyymMt4HwvbIUVahR9plswO+Hbey?=
 =?us-ascii?Q?ROizXylranKddpOCrvHPxc6zNjZTT2f0HmOtwmKCRPQzYgXn5tXyN2UqvpUa?=
 =?us-ascii?Q?+7E7yCmt8yqQq7mgXiYuufaCgxai5FdjtKGucEFzGnDnXFO84QRSzvJtnqVv?=
 =?us-ascii?Q?CUGiMUOGehL13NsLtzDanpo81HNLM2dd58TEawPdh3oo2+r0EWlKADW1D71d?=
 =?us-ascii?Q?jxM2GBHnlqe1+wA57ZV4cUgo8npiG/3PYFXu7dlymu9wYPs59cTwgZew/tF9?=
 =?us-ascii?Q?CZVVxx8rPtZ7Dms6JoaRwI9ZPY/djtCt1zb+dQ5+BiSONht8lVZO7KwJaPMr?=
 =?us-ascii?Q?d5B33yrqkSfq6jhaIo++eIUuDl2eg1Q3eAhC+o1SvsfePVJBaL2pR1vat8n7?=
 =?us-ascii?Q?lk0af1Kf+2XLIDxRfvkoCcSEGGb0hG8roANxG5MQvvueFH+VeV2LOthF3XdU?=
 =?us-ascii?Q?FTYv7ZZ5rlk0ZKFPzqQSdJuJZhEDAIddYDO57rSHBCGn9rgrFbTZQoXfgRTo?=
 =?us-ascii?Q?IS/JxbyXi1P6XCm1X9wOaZA6FggFT0+MQguLj6t/w49o3ViELDFsWCrz2IDR?=
 =?us-ascii?Q?8mf0n2eCBNk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fIOlaEEIkMoFPCf9BDk0I4noFNlJKgIeTk6wlJcu4sBcquRunvHiUAeNyyq6?=
 =?us-ascii?Q?CfiUkDUgAybkT/xpUPFDQsiNoTYuOoQbJinkF4vsjZCKR4T6AGgCoDC9CvEb?=
 =?us-ascii?Q?odLxJdgHM5tOiEpUfhOKjELyR+STxzMUfhcBQRg9y58Ix4oqldaBZ9Tleq2S?=
 =?us-ascii?Q?J51pyj0hxXEL7BCOC4JuxJwFq6Z37+qwRKD70APRJIFaemsmV2eTdgb6imD8?=
 =?us-ascii?Q?sggJl+Xr+lOeGMbmX8IeN7Iu4gXa2uDmt6cm3TQUqLqmjN2W/WDZzIKMNuyE?=
 =?us-ascii?Q?dv9NiPWy/8j8IgKD8htHxnos50nTBC4+33tC2DkrE7Abq51Nwutwqs9TE4Bd?=
 =?us-ascii?Q?xZdkvC1ieB8kLoezV+ofH7pP26dWmQk8jvfQgGEoETXDmR15Lml4BnflGLuW?=
 =?us-ascii?Q?2aZhx2ubOKDym7xKKZo0FIBKSiRZYHkHLn/dglv09IP7teaVHtWA3jV0wklz?=
 =?us-ascii?Q?pjk8YoWDJMfEjSeB31okjzBa8w0/2PJTqEnySJZX6g2FADqgjYSxejcbcgEU?=
 =?us-ascii?Q?QyZsWxclUxl1hxchPC2QrjhSDirkg+tm0OTjR7fZm6zQsTArmRiVyz+DrP6G?=
 =?us-ascii?Q?0xq8Y0ClJWbbQPwpf4tsvZVvHy6LkisCpIA7oV8kBTWW779sWloU38nMVboU?=
 =?us-ascii?Q?it+FWTOUulOlBnlTRgWK8f/yeqS1VjcUbXOlMYo1PGIXiLeZbWfCgd7YbkSe?=
 =?us-ascii?Q?NZLQZKKuHgTfG+szuR7yjeWgfuagS2yoysd9KveF48kikkDbBIR/FdiStMJ+?=
 =?us-ascii?Q?pS3ZQazGBIq8hZDleWHB01O+GrrBRAhDMh2MbOCKoWS10uWA6KuwkpZJS8Ky?=
 =?us-ascii?Q?V3NngdQu5Bl6+D3WjsFcxxM3V4lYhfOrGPeP0v6fzcJ84n60yIhcI84IHQs5?=
 =?us-ascii?Q?CuAZIPWvbhIbebPbMFPKpqbza11BDhPxMfXagQbDQYSa2X4FqjiGuBXMnzSr?=
 =?us-ascii?Q?Vc8oXAYPMNuR1XLN2HB04hUEk9+oBrojf4gbp/j1jnu5wSCenCwtKF13srHo?=
 =?us-ascii?Q?NYbW7Yj0Zigbq8XMznA0Ka5kflUtMeeuV3Zk5lIzc6hVlDA0rsfcw59CJupW?=
 =?us-ascii?Q?J9j90VVYy1/8mY1iT9Zd4TKocvDrSYlS5KNLveVSKKvcdIaw0tjkVCv+fovb?=
 =?us-ascii?Q?8aQE63ndLWZRfkssudjE0jnjDWmYzd5zLnTksvB+V5CltQKRHwiwsdB/R+JP?=
 =?us-ascii?Q?454YFqlN3b08AT5vKOLNNnvvCnRApzvLC3VMtAG4nOPo3K7QkWt5HUy7DJgh?=
 =?us-ascii?Q?ONeziLkSVXRJv2t0BarQ71kKdaQVgtcBepYIuefxP7YfB0y317l9u8o6EO9S?=
 =?us-ascii?Q?ib1qHrmp3GsNucmuyBxnF4hj9LfAe9tDzU3Rdylhdqdm5sX6wjMMKghFjnX7?=
 =?us-ascii?Q?kU3sAwmCic3kDYb7gtiMAWkohmKo88DuoruO5gt7L2W3x4TbMFGYCJifNT1E?=
 =?us-ascii?Q?U6mBQOreiwNlCbplC52f81b6QRYmo5boMyXoZq+XO/OEx225eA4yFrgo8Cxm?=
 =?us-ascii?Q?gM8Jyfs9x4nXMBScTcruVdPszl1pNH39JAHuyby0HF9mHQ8s6Y4ZjZX6q60f?=
 =?us-ascii?Q?C6AY7sqyIHur4rd0Tjw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ae4e6f-d27e-421b-27a1-08ddcec54bba
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 17:28:13.3810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0o/u9SsfeOPGSAIAEadZmauuYEHx+gPELpq0G/WqO4a5TwiHIbw7fgN9QNKrCt1J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230

On Wed, Jul 23, 2025 at 02:46:23PM +0000, Pasha Tatashin wrote:
> Introduce LUO, a mechanism intended to facilitate kernel updates while
> keeping designated devices operational across the transition (e.g., via
> kexec). The primary use case is updating hypervisors with minimal
> disruption to running virtual machines. For userspace side of hypervisor
> update we have copyless migration. LUO is for updating the kernel.
> 
> This initial patch lays the groundwork for the LUO subsystem.
> 
> Further functionality, including the implementation of state transition
> logic, integration with KHO, and hooks for subsystems and file
> descriptors, will be added in subsequent patches.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/liveupdate.h       | 140 ++++++++++++++
>  kernel/liveupdate/Kconfig        |  27 +++
>  kernel/liveupdate/Makefile       |   1 +
>  kernel/liveupdate/luo_core.c     | 301 +++++++++++++++++++++++++++++++
>  kernel/liveupdate/luo_internal.h |  21 +++
>  5 files changed, 490 insertions(+)
>  create mode 100644 include/linux/liveupdate.h
>  create mode 100644 kernel/liveupdate/luo_core.c
>  create mode 100644 kernel/liveupdate/luo_internal.h
> 
> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> new file mode 100644
> index 000000000000..da8f05c81e51
> --- /dev/null
> +++ b/include/linux/liveupdate.h
> @@ -0,0 +1,140 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (c) 2025, Google LLC.
> + * Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +#ifndef _LINUX_LIVEUPDATE_H
> +#define _LINUX_LIVEUPDATE_H
> +
> +#include <linux/bug.h>
> +#include <linux/types.h>
> +#include <linux/list.h>
> +
> +/**
> + * enum liveupdate_event - Events that trigger live update callbacks.
> + * @LIVEUPDATE_PREPARE: PREPARE should happen *before* the blackout window.
> + *                      Subsystems should prepare for an upcoming reboot by
> + *                      serializing their states. However, it must be considered
> + *                      that user applications, e.g. virtual machines are still
> + *                      running during this phase.
> + * @LIVEUPDATE_FREEZE:  FREEZE sent from the reboot() syscall, when the current
> + *                      kernel is on its way out. This is the final opportunity
> + *                      for subsystems to save any state that must persist
> + *                      across the reboot. Callbacks for this event should be as
> + *                      fast as possible since they are on the critical path of
> + *                      rebooting into the next kernel.
> + * @LIVEUPDATE_FINISH:  FINISH is sent in the newly booted kernel after a
> + *                      successful live update and normally *after* the blackout
> + *                      window. Subsystems should perform any final cleanup
> + *                      during this phase. This phase also provides an
> + *                      opportunity to clean up devices that were preserved but
> + *                      never explicitly reclaimed during the live update
> + *                      process. State restoration should have already occurred
> + *                      before this event. Callbacks for this event must not
> + *                      fail. The completion of this call transitions the
> + *                      machine from ``updated`` to ``normal`` state.
> + * @LIVEUPDATE_CANCEL:  CANCEL the live update and go back to normal state. This
> + *                      event is user initiated, or is done automatically when
> + *                      LIVEUPDATE_PREPARE or LIVEUPDATE_FREEZE stage fails.
> + *                      Subsystems should revert any actions taken during the
> + *                      corresponding prepare event. Callbacks for this event
> + *                      must not fail.
> + *
> + * These events represent the different stages and actions within the live
> + * update process that subsystems (like device drivers and bus drivers)
> + * need to be aware of to correctly serialize and restore their state.
> + *
> + */
> +enum liveupdate_event {
> +	LIVEUPDATE_PREPARE,
> +	LIVEUPDATE_FREEZE,
> +	LIVEUPDATE_FINISH,
> +	LIVEUPDATE_CANCEL,
> +};

I saw a later patch moves these hunks, that is poor patch planning.

Ideally an ioctl subsystem should start out with the first patch
introducing the basic cdev, file open, ioctl dispatch, ioctl uapi
header and related simple infrastructure.

Then you'd go basically ioctl by ioctl adding the new ioctls and
explaining what they do in the patch commit messages.

> +/**
> + * liveupdate_state_updated - Check if the system is in the live update
> + * 'updated' state.
> + *
> + * This function checks if the live update orchestrator is in the
> + * ``LIVEUPDATE_STATE_UPDATED`` state. This state indicates that the system has
> + * successfully rebooted into a new kernel as part of a live update, and the
> + * preserved devices are expected to be in the process of being reclaimed.
> + *
> + * This is typically used by subsystems during early boot of the new kernel
> + * to determine if they need to attempt to restore state from a previous
> + * live update.
> + *
> + * @return true if the system is in the ``LIVEUPDATE_STATE_UPDATED`` state,
> + * false otherwise.
> + */
> +bool liveupdate_state_updated(void)
> +{
> +	return is_current_luo_state(LIVEUPDATE_STATE_UPDATED);
> +}
> +EXPORT_SYMBOL_GPL(liveupdate_state_updated);

Unless there are existing in tree users there should not be exports.

I'm also not really sure why there is global state, I would expect the
fd and session objects to record what kind of things they are, not
having weird globals.

Like liveupdate_register_subsystem() stuff, it already has a lock,
&luo_subsystem_list_mutex, if you want to block mutation of the list
then, IMHO, it makes more sense to stick a specific variable
'luo_subsystems_list_immutable' under that lock and make it very
obvious.

Stuff like luo_files_startup() feels clunky to me:

+       ret = liveupdate_register_subsystem(&luo_file_subsys);
+       if (ret) {
+               pr_warn("Failed to register luo_file subsystem [%d]\n", ret);
+               return ret;
+       }
+
+       if (liveupdate_state_updated()) {

Thats going to be a standard pattern - I would expect that
liveupdate_register_subsystem() would do the check for updated and
then arrange to call back something like
liveupdate_subsystem.ops.post_update()

And then post_update() would get the info that is currently under
liveupdate_get_subsystem_data() as arguments instead of having to make
more functions calls.

Maybe even the fdt_node_check_compatible() can be hoisted.

That would remove a bunch more liveupdate_state_updated() calls.

etc.

Jason

