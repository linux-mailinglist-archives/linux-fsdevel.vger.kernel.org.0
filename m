Return-Path: <linux-fsdevel+bounces-57898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8069B26829
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D00566884
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 13:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7503A2FCBE1;
	Thu, 14 Aug 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l+XoEblV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC01E9B2A;
	Thu, 14 Aug 2025 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179363; cv=fail; b=kxVnnTb/XLRabKhGSXHjwJMomWwU7nKYDapPxh/mzsiRINxPmb+5IGtperglwfSqKTX92mdtfWyyDKB4MhypALsoLEvMov0cNuPsp1Ziq/2VkutBI/VktrxhbjDTaECU2SZ8j8Zz3rOUWli977aPWRLTAvIZTmQnJkKw46MMkkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179363; c=relaxed/simple;
	bh=0fqLoyDJLpjW10Nwqs0M4QPwUMc3fvQ9avvjueT5Q0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lI/uzJG7pGW4Bwqfs9A8heEXkeBKFblJNu69/pNm3sJmybXCi47trd9GQpNx1R2Uoz0WJaEaKexDlUN7A3X8QKT/Noz9+AZY7cQxS6FnSbOmVh5DfquxecYDr9JjjXRqtheJMme0LxNZoVz3D+859wwNd09nKP8hM4RAlST9J7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l+XoEblV; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHvQaS4/9nzicodu9HpAKZfee35JO13t9ramBUIvRXBIT6Ru4jgaUDdaakalRlkwZ2KwJdGY5xZ0AUzOE1SmbPnt/XejLzGWnjfYPdilxiRQ0Pz1Qe8TLv3RSQohn3WcROfSQ2Bfkntg4Xn4r+mwfCWW6YsS9Z5rYruaWfU48sa4rU+mH7bxmiyBCxiaGnW0oi3M2CU82rq3s1LXMXrgsD5OrdKEru5ovQJBr1nZ1zQZz9FH0gQaJrtPULSiMCTSRh8zM2EXr7OcKxYCVFYcscelrdbmap38gXGpvB9MzCCWEk2ThT9LpPZNbkpx2HahX1P3fBWNwFDjv6aYPHPH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqmoVPhcyiGlfQ2STdBHMfbirQT5BpD8Nh67k+N+aKw=;
 b=ea7V2zfVDTOk2BsMDBBh9nq63jGGRLfa0Jwh5WeSeL5Cp5OYGCxS3WyNFOGjPpEqkQTeXRBzI/MJKnJmlJHXAYfsaqMj3qIitWyBiNyekSBpYbtd4B27whPOA65ipON3zeFCfThpfSJDtbLg9lb2J8sXW4p+1IOedC/EkC8DDXZ7L6/w13QMhgevWmrp0vdYpa8llqUPZ0yBIVzq2o2NcGz+WdBv6hu30KMcHEEZV2HL0nRRUTMjlN4ZkFsj/5zFB2DkcURFqQBtuo846ycMhKl8Zz28ceZEZ+jBTpHymzaQcPOG3CzhcpgMtZ8Ri+Re8AUI0YapWVuMyxnikF7qgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqmoVPhcyiGlfQ2STdBHMfbirQT5BpD8Nh67k+N+aKw=;
 b=l+XoEblVG6KTH5a6RNma6dnpL9ENtvQNIEM9aN9ar+vxnquvmdJKq/oKwEBws8byhohEVwaGE03r3Dt4g1NdBQNYzXjBVBBfDDOrah7YqnhGFXB0hsCWo2tYKucqSM6ywblHOf6NMlbJB7iu/IPmD6mjwQGY2Pyunm+IYRA6vnixEougQVx4GJrCt7XGUrBWkh+0CqSyEcfi/TmeyTAtFtzRfYYDf809EWAk6cUJmPi3Qlxp84Aw/sspl0RH2I3lDEAORBcxYErt9mhm69Nlb6931OR1f9eiDxQEvM9ew6tsSEZZp3sVipV+gsT8toKF3t4b66/sseDvydVcSa1Z6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Thu, 14 Aug
 2025 13:49:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.012; Thu, 14 Aug 2025
 13:49:19 +0000
Date: Thu, 14 Aug 2025 10:49:17 -0300
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
Subject: Re: [PATCH v3 16/30] liveupdate: luo_ioctl: add userpsace interface
Message-ID: <20250814134917.GE802098@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-17-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807014442.3829950-17-pasha.tatashin@soleen.com>
X-ClientProxiedBy: YT3PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 2528fbdd-1513-4c5e-eaeb-08dddb395d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h4o4EUIL6jNJi94sJUT8sZRCqzk+a027Po6lGbnVi1XUcDgferYFzXcYPHza?=
 =?us-ascii?Q?0ZWF42j0RhBK4EwfzKS6vyLGgXsxjEyJOukhlVQDUEFxkvXIaqwKaDPEMW6t?=
 =?us-ascii?Q?KNUZaOi0TV6FdsX2ycdXv5tVPzg1q9gWonZ+zEwT4pPLe7HH5uOrs3OI2uSf?=
 =?us-ascii?Q?JMHFjoWYjyppA9kSWCPJ2goN57fZiVrfhjFfgoSHVM4yKVoc4AdbrKcu8M39?=
 =?us-ascii?Q?fQCXQAQn+Gdgy6gF6vIaK8Fc1KRG5gJONUzWIunlQJue4C9fU4bpxtJ8je8P?=
 =?us-ascii?Q?5AhSckVNzgJO4QKMt+BSRG73QMctSgoHv8D5xgcLlrLw9YcGet3IY5JfMHn8?=
 =?us-ascii?Q?mCtrCBRdGTgQqSdNZHHQuLe95EpMJLWnYlyfWXXZmszhoQwNre1yRtzcdDSP?=
 =?us-ascii?Q?3l6d3L0YoJO9ajxmN3oYcMRB0V08fEnLLKC+tUIg2xwC8nEW1OqUJvO9OKAp?=
 =?us-ascii?Q?ZahiO1/tBPrzPsgWyxmCejZKsTz4k1Il3Gc1Krs9opwI0Xt9vBUOQOvQW8x4?=
 =?us-ascii?Q?q68cZurNykeAPPw4UMy4TNCf+Z2Kk7xXTNMK5ZgfVcuc+NJfxDjcdFsNAo2d?=
 =?us-ascii?Q?XBReCoedxDHqqdmPEsil/8qAkza+YZUk1ZawcDLjkU3UJuwflAX+Co4z/e6i?=
 =?us-ascii?Q?EJPRQHNjAkHnd9p50raPidEXejCUberBc1rJLSihg6ekhkLri0N+KCFqRovH?=
 =?us-ascii?Q?9v/gj7ZGw2EpufnNN82MZSB+TB1kZWPo1Y5NXWUQj4kAo4aAE4B+oehiP/Si?=
 =?us-ascii?Q?2+fF6CwqU7RYOrQjsyn19rq9PZVbKTNcmjFbCTVreaAESccSleL6gFQ2lLGg?=
 =?us-ascii?Q?tOyARG4pTKMPqQq6MrtWtfOdAlq8UkFpfDYCNAPguLmVlKWiPulM+HkgmX7E?=
 =?us-ascii?Q?Fhu0vRayoodnvrlDrJOQazeCsvWdmeDRdbkFXmBP8OqzPlwjkxbprTYlDWYK?=
 =?us-ascii?Q?8SU4FOYyXR3R069D32MlRELmJnVQ1JuBvpJ2XHoHkUJsLHtxUuRo4nrZEEfw?=
 =?us-ascii?Q?VjGsijNlYvMEAvAZ1sXo028caKyxt8RsGrZ1xlqxxpXfwXcFMQPJiluQ2Uzl?=
 =?us-ascii?Q?vBqjjry8w548VpfRgpmOGp9opQKHhj2rKLXLKwpplWF6HwRRAskWw0N4yS7D?=
 =?us-ascii?Q?yODpAsjbML8t7KFI8P2u66rcLRPKiaFU+b4lgJ/1ArM39EqM6IIv5FlCjmLV?=
 =?us-ascii?Q?3ao/Ad7Uf1WV+hXEObyXcUPbvulUQyYfpyZWB0vlS/RIX1VeP8OZiq/Ab/8V?=
 =?us-ascii?Q?k4mrKZChywPC3CMGcwJfFy+6en5qHwJ6T/Z2B4sKS26guDI5jr3+b7Mwt4gW?=
 =?us-ascii?Q?4r1LGEdNa4t3CPvxRXzZnigT1Ow4lKW2m+wWsRycpPT6eJe0tx3aLnCqoW50?=
 =?us-ascii?Q?1e+m3sNZZZz/O7Vg0yVa3v7LZf/gwLbo2CHLUh8k0afDJ9CZYLmC5YQKOAKh?=
 =?us-ascii?Q?u96OoMSdPaE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tD4giBDiuTeRstLrh8/v6HO2B/+bCa1Me/AOCJsBCXHW9HcIunHJBLwSPuQc?=
 =?us-ascii?Q?PXrz6n57/STA6YuINrXa9bUgh8i5g6zeEisF0GD/UPnU70ayulfKu9tCcbeB?=
 =?us-ascii?Q?1auWvZkCoEGvWqW0C6ghhKaCjfWeFfQp5gV+d/MbmPXJnmeioqCTDKFtyDgL?=
 =?us-ascii?Q?9k9EK++T5d8xRteQGek1RiAlkvIXR1fzK4XCbEHI8m0ceAyd1FaBsTTzajpH?=
 =?us-ascii?Q?qEcgKnDvYEeYNfft47UPCL1nKuuvLpdY8vXdVX1+HBnHUq8K/QsUtHHLMGV+?=
 =?us-ascii?Q?kaKPkCTQa6XlMBcwR0bsqXDA3h+uYJ5QelsXElpnNM7H4hszk27Rcnm+yT02?=
 =?us-ascii?Q?kXzFD1JzzgbjYgMBm6PJfROPYMa7SH9ix0eT+kGgcTU5HjYvuDx9H+dJMHGB?=
 =?us-ascii?Q?zGWxYhL0dWwArQA7tXqhYmW9Kthp/8h6qWF+ZOxxNXtpgQe8cXPq+ciGn9Np?=
 =?us-ascii?Q?n6EBl3Zds7MdK3bm1UIiEbZMQYs6axHr144wwzH9a5D1U7yqrY0wWj4TOmNW?=
 =?us-ascii?Q?Hf3bZ9o3udp5nD7YuFAtP9GMaSxzq0h/g1M3Epbxk+QQ5s/cvLHVK9URSk8J?=
 =?us-ascii?Q?ZlY4p1JXrgg31IpXS8yOvRq8BGULiG9fUINP+NzT/gmcG0qoPEFScwrdibGe?=
 =?us-ascii?Q?IPv5GgO5GOtranm8UJGVtL8rA4b+eeQvuAKbdu2r9ZNf/VjanLWvSNXDIeMs?=
 =?us-ascii?Q?dHPZWYlbMVP10toYxnxrRxkIfFJOvvEZq7FtT7ziglGkS9mI6D6bvfTH/cGw?=
 =?us-ascii?Q?UNLMYliv9SXv7xjxORXNbQDbrSP5AFyHd1PTOnzd/R+atQaz7zCaghGHD2Kv?=
 =?us-ascii?Q?TsofBQvlqBk4V5mu8mJiPW+PgRiiLcpR4sNniuqIRlaT0OcXKHBvNs4POpjL?=
 =?us-ascii?Q?Vg/92R/70phZjpPqIPXRgQUEJLuqnoVhy6js8LIVwo703lA3nIONuWMTHYny?=
 =?us-ascii?Q?BQxkHvzWMDzm8CDyoYMfb7fW0pxBrwpjaUZbZteMIvi5QQ7rpVm4fmYDdd6X?=
 =?us-ascii?Q?5qHFuDGVmgyDtb9AQxcWzhHErtBE9P35/oXzSTfF3MEh41iBHm+sBM6CZOn0?=
 =?us-ascii?Q?QPk/xaeUht/VzdZxPd/GmdamYBq/5pBE3UD7sio31v4aU1xsvCh01Z3ReHqY?=
 =?us-ascii?Q?YnpUtrrlJp2NB4/raRdIGx3/UEo0U2wYG6aXA9xrpi3FwUINA8bzzN4RWYYv?=
 =?us-ascii?Q?aFJeVs+pzvoW2CatEx/ZzcDFCC/ej34m/fq0wK1dNmm+lTMuZ8czvkfAcnWY?=
 =?us-ascii?Q?HSpOzLall0tv68a6tppAIXcpc8/eTyOqMpoILpHgZ/XsEVcAyWN+MVAaLoNL?=
 =?us-ascii?Q?SFCYyhuDFybNmjyBvqmI/iOB5opHLyICJtvjoYnztV0EEMAH/Y1zg9U2PxxZ?=
 =?us-ascii?Q?H+Aw+W+h9CsG+CW/LBRyTRkSLs0f1Ny6a9Ryqz4maJkYYYPb4aMTvVv4w+cu?=
 =?us-ascii?Q?SJnB+zlnTbmTkgb/2h4MCxjmFnXIWZnsQI/C79Vsdsg86mne8FvN2JMtmo4e?=
 =?us-ascii?Q?gL3heLfiLHB0yiV8zdwyhdD6w82H8IL3apseES56IDacelgWs9l2pmNISgw/?=
 =?us-ascii?Q?yV6OU1rwPZKfdx+4rck=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2528fbdd-1513-4c5e-eaeb-08dddb395d9f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:49:18.9325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdxNoDMiV0WXqVDji+VlVeeSPo6nYmqdw1CGOnPScmXm99plWFs7S0QDxXYC09FJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509

On Thu, Aug 07, 2025 at 01:44:22AM +0000, Pasha Tatashin wrote:
> +/**
> + * DOC: General ioctl format
> + *
> + * The ioctl interface follows a general format to allow for extensibility. Each
> + * ioctl is passed in a structure pointer as the argument providing the size of
> + * the structure in the first u32. The kernel checks that any structure space
> + * beyond what it understands is 0. This allows userspace to use the backward
> + * compatible portion while consistently using the newer, larger, structures.
> + *
> + * ioctls use a standard meaning for common errnos:
> + *
> + *  - ENOTTY: The IOCTL number itself is not supported at all
> + *  - E2BIG: The IOCTL number is supported, but the provided structure has
> + *    non-zero in a part the kernel does not understand.
> + *  - EOPNOTSUPP: The IOCTL number is supported, and the structure is
> + *    understood, however a known field has a value the kernel does not
> + *    understand or support.
> + *  - EINVAL: Everything about the IOCTL was understood, but a field is not
> + *    correct.
> + *  - ENOENT: An ID or IOVA provided does not exist.
                    ^^^^^^^^^

Maybe this should be 'token' ?

> + *  - ENOMEM: Out of memory.
> + *  - EOVERFLOW: Mathematics overflowed.
> + *
> + * As well as additional errnos, within specific ioctls.
> + */

Ah if you copy the comment make sure to faithfully follow it in the
implementation :)

> +struct liveupdate_ioctl_fd_unpreserve {
> +       __u32           size;
> +       __aligned_u64   token;
> +};

It is best to explicitly pad, so add a __u32 reserved between size and
token

Then you need to also check that the reserved is 0 when parsing it,
return -EOPNOTSUPP otherwise.

> +static atomic_t luo_device_in_use = ATOMIC_INIT(0);

I suggest you bundle this together into one struct with the misc_dev
and the other globals and largely pretend it is not global, eg refer
to it through container_of, etc

Following practices like this make it harder to abuse the globals.

> +struct luo_ucmd {
> +	void __user *ubuffer;
> +	u32 user_size;
> +	void *cmd;
> +};
> +
> +static int luo_ioctl_fd_preserve(struct luo_ucmd *ucmd)
> +{
> +	struct liveupdate_ioctl_fd_preserve *argp = ucmd->cmd;
> +	int ret;
> +
> +	ret = luo_register_file(argp->token, argp->fd);
> +	if (!ret)
> +		return ret;
> +
> +	if (copy_to_user(ucmd->ubuffer, argp, ucmd->user_size))
> +		return -EFAULT;

This will overflow memory, ucmd->user_size may be > sizeof(*argp)

The respond function is an important part of this scheme:

static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
                                       size_t cmd_len)
{
        if (copy_to_user(ucmd->ubuffer, ucmd->cmd,
                         min_t(size_t, ucmd->user_size, cmd_len)))
                return -EFAULT;

The min (sizeof(*argp) in this case) can't be skipped!

> +static int luo_ioctl_fd_restore(struct luo_ucmd *ucmd)
> +{
> +	struct liveupdate_ioctl_fd_restore *argp = ucmd->cmd;
> +	struct file *file;
> +	int ret;
> +
> +	argp->fd = get_unused_fd_flags(O_CLOEXEC);
> +	if (argp->fd < 0) {
> +		pr_err("Failed to allocate new fd: %d\n", argp->fd);

No need

> +		return argp->fd;
> +	}
> +
> +	ret = luo_retrieve_file(argp->token, &file);
> +	if (ret < 0) {
> +		put_unused_fd(argp->fd);
> +
> +		return ret;
> +	}
> +
> +	fd_install(argp->fd, file);
> +
> +	if (copy_to_user(ucmd->ubuffer, argp, ucmd->user_size))
> +		return -EFAULT;

Wrong order, fd_install must be last right before return 0. Failing
system calls should not leave behind installed FDs.

> +static int luo_ioctl_set_event(struct luo_ucmd *ucmd)
> +{
> +	struct liveupdate_ioctl_set_event *argp = ucmd->cmd;
> +	int ret;
> +
> +	switch (argp->event) {
> +	case LIVEUPDATE_PREPARE:
> +		ret = luo_prepare();
> +		break;
> +	case LIVEUPDATE_FINISH:
> +		ret = luo_finish();
> +		break;
> +	case LIVEUPDATE_CANCEL:
> +		ret = luo_cancel();
> +		break;
> +	default:
> +		ret = -EINVAL;

EOPNOTSUPP

> +union ucmd_buffer {
> +	struct liveupdate_ioctl_fd_preserve	preserve;
> +	struct liveupdate_ioctl_fd_unpreserve	unpreserve;
> +	struct liveupdate_ioctl_fd_restore	restore;
> +	struct liveupdate_ioctl_get_state	state;
> +	struct liveupdate_ioctl_set_event	event;
> +};

I discourage the column alignment. Also sort by name.

> +static const struct luo_ioctl_op luo_ioctl_ops[] = {
> +	IOCTL_OP(LIVEUPDATE_IOCTL_FD_PRESERVE, luo_ioctl_fd_preserve,
> +		 struct liveupdate_ioctl_fd_preserve, token),
> +	IOCTL_OP(LIVEUPDATE_IOCTL_FD_UNPRESERVE, luo_ioctl_fd_unpreserve,
> +		 struct liveupdate_ioctl_fd_unpreserve, token),
> +	IOCTL_OP(LIVEUPDATE_IOCTL_FD_RESTORE, luo_ioctl_fd_restore,
> +		 struct liveupdate_ioctl_fd_restore, token),
> +	IOCTL_OP(LIVEUPDATE_IOCTL_GET_STATE, luo_ioctl_get_state,
> +		 struct liveupdate_ioctl_get_state, state),
> +	IOCTL_OP(LIVEUPDATE_IOCTL_SET_EVENT, luo_ioctl_set_event,
> +		 struct liveupdate_ioctl_set_event, event),

Sort by name

Jason

