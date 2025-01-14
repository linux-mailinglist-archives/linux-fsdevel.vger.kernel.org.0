Return-Path: <linux-fsdevel+bounces-39109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F85A0FECB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 03:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4EE3A61AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 02:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC392309A1;
	Tue, 14 Jan 2025 02:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkhQDtni"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D691FA147;
	Tue, 14 Jan 2025 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821697; cv=fail; b=kXIkcCrXZ7u/GrO2Jf5v0YIv0eH6BOHpvLqxfQiMdK55my49CVcZJOm1M4I4doyW32pUSjjqs6RkjDWjKuELu3TVY6BXlwODNtTKqJxUp0+aMH/wzzHQnomHabFIydtzjm9Y8NHZTxgq4nZpcINE+8bEnj+NF9e6gdILuV2xXMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821697; c=relaxed/simple;
	bh=Wv0eNMq1SZL6KRGGiCSzoaU1QLtUArYu46JrDZv8h+g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=btTTfdAiH15JC5wTzUvfOHOy8d+ihjIn4UfR8nXs10fp32EmKAys1P+gBHkMgpOndLpp5xJ+dQGFUQIVgkbGvF0M5YR+uhDBKGO884rzQSUuW910QgG9g26PgW7ro+nkjt+b/qTLs9Cgv23kfPYHTZ4SVMHJ9UM3BgvXSI9B6S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkhQDtni; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736821696; x=1768357696;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Wv0eNMq1SZL6KRGGiCSzoaU1QLtUArYu46JrDZv8h+g=;
  b=nkhQDtniSFHo4PhpJx6PwmsdWS3kehhVVgHrC+4ghzVq8UKsZHUxthJ/
   XdXzoXcUMkFO8YUYJ/qB6L+Px6aR1bh6Y0xFSozq98Qyw1kpo0pfaTZvz
   OjfaLSU39OG3JT+tl8N5cvJgX9DDU/T5QVHfdJjeqh4b6SHfIuBvOGXdL
   q3pxYV5MZ1sjJsqv/XVBYgNpT74qi3lRFRAvuD5nmkf+2PY57G0T5KSAA
   ZYzQhtsBsOt6xpcb5tTTAaTncW355JY9AU/6ewV2ma8SF9kmO2uVcCjIs
   GJ5wEpt557yZdJOB7dGmwF31sYfy4lG9bU9AwlrRhbEd5cKjBjztzQ1eq
   w==;
X-CSE-ConnectionGUID: IS34vVwRQxWO6XMbAy4eUg==
X-CSE-MsgGUID: BYBvTdchTMCkLLMUf2gWxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="59591569"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="59591569"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 18:28:15 -0800
X-CSE-ConnectionGUID: 68kyRKXqRlyvlm1FIWdiXQ==
X-CSE-MsgGUID: v/wJQ8hVSFmDCOGvJxeWMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="105181599"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 18:28:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 18:28:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 18:28:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 18:28:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgqzECwGgzP+xdzHy8sBtJBYEJnerRY9jQLTshPwpSKxPGSV2KZSF2KHcrJBy/828QyMDVxqKCDqdpd+dyhAzuUWWYqOF0YiYIqk8JlYkHKLfsSAQAMBR6bcPWk77uc1TWQpcb/hv70nvunCiPVjILIzDb/RcvbV/HZM7UwVTfRDbeXkCosbvsnXmHDXN/QWW5j5kIsXeRR9F5Enw2rCSfy3Y87I5J30dNbkBGlxb5qFQ/koZFrUG+8KlkiuEBzIlkrKYRM9RHKsVTBYhRNxKHSaHD5+dQVmxd5r8a+5/Mvd1cbe1Js3HLzUyZF7G/bqWVQ+6dxM+lpRjNPbzTjhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhjSnyR1IZsnJrNiXGxuO4EXeaEJAvcornQ1z6sUL6k=;
 b=bM7TuARhYsIk8eKi6cXsr92TM7TJdP3I6FDivJVeMFQWDm4gUgmCnqq4gFBDj7JiCIKW+VFWJZWJ+yMifwsg4GpdZtYylR0upT++Fzqmfatzb9AHH1RrmWjRPlA1mEVApFm1McaaTkhs0G6R68zkcbB0/OzwelLv8IKLDIiczjK96+OO3BZ6zCjiT+z5Tl91srO5mKQrbhEJxcILha5p0sXI6+fglZMP3Ad8kq0xUUL9xqJ/qTIaUt0fkTY/NT6j+F1Pzfvdn11CyZiJnBrLo7Pr60Wzkad96sOoT56BCenYn1hAuOJlyVkTAPBbpHARps2o6GV8EosnLrN/z6BcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Tue, 14 Jan
 2025 02:28:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8335.011; Tue, 14 Jan 2025
 02:28:11 +0000
Date: Mon, 13 Jan 2025 18:28:07 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <akpm@linux-foundation.org>,
	<dan.j.williams@intel.com>, <linux-mm@kvack.org>
CC: <alison.schofield@intel.com>, Alistair Popple <apopple@nvidia.com>,
	<lina@asahilina.net>, <zhang.lyra@gmail.com>,
	<gerald.schaefer@linux.ibm.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <logang@deltatee.com>, <bhelgaas@google.com>,
	<jack@suse.cz>, <jgg@ziepe.ca>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <willy@infradead.org>, <djwong@kernel.org>,
	<tytso@mit.edu>, <linmiaohe@huawei.com>, <david@redhat.com>,
	<peterx@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <loongarch@lists.linux.dev>
Subject: Re: [PATCH v6 19/26] proc/task_mmu: Mark devdax and fsdax pages as
 always unpinned
Message-ID: <6785cbb7125bf_20fa29418@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <d7a6c9822ddc945daaf4f9db34d3f2b1c0454447.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d7a6c9822ddc945daaf4f9db34d3f2b1c0454447.1736488799.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0136.namprd04.prod.outlook.com
 (2603:10b6:303:84::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e3f87ab-278b-4394-2fb0-08dd34431763
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9a2Dr3teFxhVAX8NIFoGiMDHIvvOgWGE2mwGGUo1K7+CyA0+7Ltt5YTCBQdQ?=
 =?us-ascii?Q?7Krq9SRxaljox+gqdL4STV9mI1OnkGUgmekdq00zluhD/uVVXyN1ZK1/g+rx?=
 =?us-ascii?Q?qme3119qeHP0cOi/vZELleUYkIyqcgCDpvdkXLZ/uqLAfCdPkPykg36UBVP1?=
 =?us-ascii?Q?aXqCchZ4yqP4QSj2SUm6BMTcGIhUEU5mvxp0aNRv4dDn1jDHjHA1pM5Kdig8?=
 =?us-ascii?Q?naq1rhLCZ+fxfbNrtBVf1aBF4Lm7i8M/2SJO5mw2cO3FDLZgQ02mxrvRcMbO?=
 =?us-ascii?Q?l6fc77CHdNYNjYsTO3DC2B/k7ReLxaAVVGEq1ERDQ6lceIr17eteslJbIRt9?=
 =?us-ascii?Q?hMhJQHhMFANAt9rVBv/QlUYM5zbA21scna27L20efaKUhpf3Ovcbb4aJird0?=
 =?us-ascii?Q?pgIx8hCR8EWk9kM2FU3taoy4kXLo7Q75mDt7I6UdWqTJb9MZIjKj37l6eKjx?=
 =?us-ascii?Q?jnWTen1yLaVMXwMHS7UsnJTWYNTnQovtYyuUkxF2jx695pXo3kUO2luwjeIg?=
 =?us-ascii?Q?zFQx1usiC46GcCp7kbZee5Db4QawJ0Ymvf7pfoEhsq8Xz2b5Wfdv7rGgMIHP?=
 =?us-ascii?Q?kFHNMUvdJwgvdseeG+vaZB34lqmMJYh0Ht5Z0MMschoR8OytrAHHsJPGGGgk?=
 =?us-ascii?Q?ePIvVHyBNxs2o9WoB6k1zqO5pGRy1dH3An/hWZkMH8tlWHU37d4ztl8IeUC7?=
 =?us-ascii?Q?I9b6RnX/VKO6vOYpn9K/CG3p1j9UC5d9tqCteu6Qx31Yt6RserJ3/izvEhyQ?=
 =?us-ascii?Q?cViZi1yv3Ug0ejMU78HnqZZW1KymIps+IZHIU0xWkyEIqGEMQU1YzVy/d+gm?=
 =?us-ascii?Q?AWSEUZYiF70D8uIB4Wlq1QIwOgI/H0hSqgRRVivOhixbRl70+8l3Le3L6dXx?=
 =?us-ascii?Q?SXe3m8GbV5uEI+SewORmy3qPc8psP9hmyp0CRGrgJiMz362WFCmQm86VCyzE?=
 =?us-ascii?Q?IjXxe18Nqk9s3BbGTJfIi/IOK0HP6YN4QVHwUq9IfJF2CRQbp26iRI7UsCQv?=
 =?us-ascii?Q?jSY+0adzS9g7fdf8bkaImMmiHxsc0KBfTWHfoTJ6zuFoheExCNmgyPM3hQ31?=
 =?us-ascii?Q?j4luebRi42vkQofpFKcsSd1qN1lWFJpQ784YqFZk5tHibYajK5VZdUrpHbC/?=
 =?us-ascii?Q?N2gggM1QwEj4Z6dvBmrC+D6LDuLuyYeZJnxS8vx1RPuQ2cXgCaASqOdiTEdV?=
 =?us-ascii?Q?VlSfu18KhvX6HDEWd9QK7yy96TzCSHDIVHSlaI39Lgpx2vZfu2YZtJ0OLQOS?=
 =?us-ascii?Q?30sqBkbhMCdUGX59M58ipF2iu8YafWpxwWLFeYcAGWwb67OehC6vWzLw/yu0?=
 =?us-ascii?Q?a03uEDAO4ZhgUmYdy7Cg/HO+9TnSA93RzgiEJWLn1Q/LBfrjJ4Nxj2EBHTX2?=
 =?us-ascii?Q?hDhVnmeeqD8wxlG6z38smgL+iDO7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OkqN5w9XfoH7RRpizoupWQkXrXLArFhGNV2rk+9fVEQDlS35AvnONEWAHB9N?=
 =?us-ascii?Q?ZKZ/7skenXak4ZhGuwcum3LSfaz/2dtS3+Sxjnj//qz09TiI8gnEquMQUfZN?=
 =?us-ascii?Q?brovTRy31BYHAe2aRBIAZQlwV3vUdaOCux3bOBAMS4CadVfjQT8hbb1o6ba0?=
 =?us-ascii?Q?CAC2tSVZOtqTIjxJSmcT7k5EquE6GId5Z+vMzsPYJGyNUOkGCG48hKPrpdDP?=
 =?us-ascii?Q?kFux+6LEBz7j66wOHfYEBmJmxYu0QndYMDLxjbib4PtYjjJCQWcBMMz2QC29?=
 =?us-ascii?Q?GApJHXMs7CmNiVYIkOm3c9i4mWpFQxXWR1drt43bB5ptqPl/+EANPg7ByRGb?=
 =?us-ascii?Q?LQxfuMvA16FAOOfhR8zlktJbtebHGIfyjVefs4MpeTcIPMW2Rct39PpTddhJ?=
 =?us-ascii?Q?tmi46SUNm0MIv45F862wzPapRpdqsyFiAVBV6dRW5pBNLYrQl3wjQq3f/q9J?=
 =?us-ascii?Q?Aan3OLds6JdxFGdeNrhQcLCA35aTgcq+hocqbXKC6YEr1+Oiw7JGqISH7xNx?=
 =?us-ascii?Q?fULairKdjhNSU3ZS21fxMBe5hdRq0yErjA7XNPKl0sJltD1K7V+hg21DAnim?=
 =?us-ascii?Q?T2zRFGWJD2wkDOxVhcaM1m2ONQCwLX1JJcFplElSV8tHsXNyf6waDcI24NZ/?=
 =?us-ascii?Q?e0YhyW/HT14HVEKYMTc2R6qMRDox/0pmikns03xR/gkYpcTC2CuuUNfOmaTM?=
 =?us-ascii?Q?LEq/mO4iLHXdQltGad/AyV4+4R+DnBL+kXFjts42mfyc94DUVOw3xHAVWRSc?=
 =?us-ascii?Q?NQ9U94HIrP9gfeQk7CTFNvX9ibCCvCDROtXgORa7RIMNR0rN21ee0m06DNLw?=
 =?us-ascii?Q?equH/fau+dnXo9DgUu1JhfoQhy4yAQ4nBkFQYMGjDeWeqhtvUkavXbghZYk8?=
 =?us-ascii?Q?BOV1FA7jcUWEQj6U0Dt1zfNYC4ljESr70i78bCKR5u9T+y2cZs+APhStCn/u?=
 =?us-ascii?Q?cfynCZ2FU6pb2Yr3icHPBGUKKDXnN7kQ304tT5N5vltN2XfSTktPDp2MIoq5?=
 =?us-ascii?Q?Ac0/FWTC4laJsJZjzRYzEwMjW9HgN9lDpKQhjIP5sXxCl86UqeDDVmDs64Bm?=
 =?us-ascii?Q?sB/JGuyC2sx/Le1Iv5O4bYqlBb0hbCoN3T3UcLkDvWNrYpWMVkhAiW/VlUF5?=
 =?us-ascii?Q?5CZNWJOYCzsFcMhrRYjKVb6HXBxCF7saWm1GqjYx7uIYCV9oJVCLxWb31clS?=
 =?us-ascii?Q?wIJRW+L8rTLQWuCrE1GAI4QeOzXcSEwuAsjpWYAy39E7s7EZcfpWR8JZGsM8?=
 =?us-ascii?Q?cym3CtUPXgE92FgRvByrC9Hqv9qx+V+11aaHOqbx1N/tETisUl+iilLNEYXt?=
 =?us-ascii?Q?X429nStHbmyf3w00QkUlSJfEmgzRWVwEPLpFAItnu8xGsB9EpKnoFHrI2FU9?=
 =?us-ascii?Q?87lIZ20B44vbQzh+4rnTdc7n5BO4DnBSlg9ZQQB6N4BdppNzyC3cN1yFjoQz?=
 =?us-ascii?Q?NX3lZoww4B1HXXjpoIWHa8g9ej0ZCGFKSnJEy8F2+Dl+mVLdWOP1xTkY2AqK?=
 =?us-ascii?Q?phhIBzd4RvBpzKDyW+UiswIzgZdWerjbGCygmX45748P/nJWrVRZacMKfECN?=
 =?us-ascii?Q?vSWeU5z02AbuiP5oYv9+T+ZlRZMvjOqyFyHj0eC0xkU/OfqSKODm8NiGONOH?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3f87ab-278b-4394-2fb0-08dd34431763
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 02:28:11.7514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVMgWRv3QuQ2yMNokqabdUfMS5Z7OCslAcA2PZsp2J1pLBBlVYsybMzRE6HN/zeGrDuFij2wWCvZ2dYSRSpgIth0hAGLbvYyWYQ6ds90TTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7540
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> The procfs mmu files such as smaps and pagemap currently ignore devdax and
> fsdax pages because these pages are considered special. A future change
> will start treating these as normal pages, meaning they can be exposed via
> smaps and pagemap.
> 
> The only difference is that devdax and fsdax pages can never be pinned for
> DMA via FOLL_LONGTERM, so add an explicit check in pte_is_pinned() to
> reflect that.

I don't understand this patch.

pin_user_pages() is also used for Direct-I/O page pinning, so the
comment about FOLL_LONGTERM is wrong, and I otherwise do not understand
what goes wrong if the only pte_is_pinned() user correctly detects the
pin state?

