Return-Path: <linux-fsdevel+bounces-73319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5984D1588E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 23:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D44F301E68E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 22:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1352134B400;
	Mon, 12 Jan 2026 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1xcVnnv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BFD328638;
	Mon, 12 Jan 2026 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768255832; cv=fail; b=rNaf1ozQYvqGS9pv0SM5DADsoKSdoV+VfbjWTnjolWfnzvIWlwcQ0m7wtlIl9nfZTVdW6AnRY/cPAvcdE7sjbVnXDfQ1/tThmwyn9fG2w+fqUOgBqlg8NmBW59nVTiRmqddj0N6/miXXYm6unZyE3SP5pmp5aucYH6etBl8ACbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768255832; c=relaxed/simple;
	bh=CW4A2L9jZaWIvBk+vAkrg6YlIFskOAs1lZ5v5N1WEJY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=g8VU7oYCuA8ONmAlpJYBDo69OgkZaOKnBfGftVLiUALUAYAn1oklfPISGMHg5uPrNFaVH4DjnsF894hK8EQ1tI7iaE0Zon1Xipy2MlsZuykoD4/Af2JeK7KV6TGFltL/sOEz94d8JJ6o4ND/qaF/RGkvhlZ4sZFjm2XUVyDd384=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1xcVnnv; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768255831; x=1799791831;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=CW4A2L9jZaWIvBk+vAkrg6YlIFskOAs1lZ5v5N1WEJY=;
  b=m1xcVnnv1NVvwZEMY2m02COwObTcIUXXj6mc/GDqyKEcZyZWMF3bDIXT
   LUNW1OcmtEIxrUaUkzM4mY2tqDB7JfdVZvhvvc7fyZZzUTVNEBkTyeYao
   XTUDj5ifjERhBN6BvRbY6kEYqjx/U/jJ9j7AUs+XY6A1q67VWJZyox6IW
   hEL9uTdIcy72jm+VXwya6yrI7eq5ydjU7wrXtLm316S4nfkOb5X3NPUj1
   BhMtaH544KF/0Tq6iEn0IKA4i3ehxGC53CzLDhfxOyrTg1z3ge6UQFDBV
   7D4NChbzh1IvGqXT3az1FQeIJ+pfveKnWOiq9wEVdlXF/5+jL9inllRo6
   Q==;
X-CSE-ConnectionGUID: G0pVT170RtO2tvAlio1orw==
X-CSE-MsgGUID: vSiHv+GuTYixNCeVy2XZUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="80179412"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="80179412"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 14:10:29 -0800
X-CSE-ConnectionGUID: e5XfchMwRK+acFph30hQvA==
X-CSE-MsgGUID: GCgXN4mWQ9yQ2Ls5pJnYBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204223485"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 14:10:28 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 14:10:27 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 14:10:27 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 14:10:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoMTEnHKf3F5f8O+3HmaNqhJTteCHAsqdb/7+J4qvvB5wXJfQUqmaJ7vS/3d2rJJ6x9kMmteJgA2ju8gI/glzxw6COI+0PgOJqXHmZOKC0R1xtj7Vb5hAAd5eosZYhFtdozAZ/GLVpCVZqLuCIiNcd+WdNzafMiTbWDAyoJySvAOg/+FE7+YJzOct8JsvOZG0f/gSVhzTNM+OrptwneyXn6xasjhRvCUttpReVXGMO7rpohTgZvJ2weVfh3efeBZzqLPpLMgxqi1nM7MSgzroL9yoYajc9/AFPcrI5k+3pnt1tQeYOKskeGoRrGCOn1u690o6YxBe8fVCwWv1KYJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCbj5c5f740Ka5XLTL61HGEgfedUVMziDqsLKLRm5MY=;
 b=O4MFJ7CoeO1IX5fPCo2/ZMeddxv7iEdM5JB11uvDTTiWTAdG4PIptRq5Br08E4RD57J3VdY3XJS1ws8rQA9U83QktOAK305sssJDBikypieCfh+UBQZe+oTI/iTLdzg04zEph3e0+6BFcwg4l/dc3FrKKRRLITB1ShVWSmhsBBiqVutmNkU5E8ScHUhBUwfOSBIZSBZorWDZM6XKOqf69Yj4TXtsavlgQa+3/lZ6mPDhzeKOLcLoWloxtQzTnLhzuvGn/MeKFSJdvELsI2ELUJyunyARgwdN4Y0BqNOnMHDZ4EqvRQuXMttOjYEwPwpTt5+8LUFcbbnn2breZ5jY1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 22:10:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 22:10:24 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 12 Jan 2026 14:10:24 -0800
To: Balbir Singh <balbirs@nvidia.com>, <dan.j.williams@intel.com>, Yury Norov
	<ynorov@nvidia.com>, Gregory Price <gourry@gourry.net>
CC: <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<kernel-team@meta.com>, <longman@redhat.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <corbet@lwn.net>,
	<gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <akpm@linux-foundation.org>, <vbabka@suse.cz>,
	<surenb@google.com>, <mhocko@suse.com>, <jackmanb@google.com>,
	<ziy@nvidia.com>, <david@kernel.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <rppt@kernel.org>, <axelrasmussen@google.com>,
	<yuanchu@google.com>, <weixugc@google.com>, <yury.norov@gmail.com>,
	<linux@rasmusvillemoes.dk>, <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<chrisl@kernel.org>, <kasong@tencent.com>, <shikemeng@huaweicloud.com>,
	<nphamcs@gmail.com>, <bhe@redhat.com>, <baohua@kernel.org>,
	<yosry.ahmed@linux.dev>, <chengming.zhou@linux.dev>,
	<roman.gushchin@linux.dev>, <muchun.song@linux.dev>, <osalvador@suse.de>,
	<matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
	<byungchul@sk.com>, <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<cl@gentwo.org>, <harry.yoo@oracle.com>, <zhengqi.arch@bytedance.com>
Message-ID: <696571507b075_20718100d4@dwillia2-mobl4.notmuch>
In-Reply-To: <e635e534-5aa6-485a-bd5c-7a0bc69f14f2@nvidia.com>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <6604d787-1744-4acf-80c0-e428fee1677e@nvidia.com>
 <aWUHAboKw28XepWr@gourry-fedora-PF4VCD3F>
 <aWUs8Fx2CG07F81e@yury>
 <696566a1e228d_2071810076@dwillia2-mobl4.notmuch>
 <e635e534-5aa6-485a-bd5c-7a0bc69f14f2@nvidia.com>
Subject: Re: [RFC PATCH v3 0/8] mm,numa: N_PRIVATE node isolation for
 device-managed memory
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a24c8b2-07eb-4e54-cf0d-08de522762a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHpRQ2tpYmZLNkdzSkpBVU9QRmRwcFZKZlh3aUwvNmNqMXRvMS9GeFVOUWoy?=
 =?utf-8?B?Smc4S2IyejZCRU1jR0hPL0ZXa2tDQXk3YitwWVlSRVFKNEhnSG52bnllaE80?=
 =?utf-8?B?TzlsYnFvUXpYL0kxMm1NR2ljc2JnaWFILzE1TjJoNWNuVzNTYmtQUlpleE4w?=
 =?utf-8?B?cXhaQlFiWXJhWnhPSmZYcnZPdCsrcXFKcjNHdUNsOGtZQzF3WVFEbFQwMHFQ?=
 =?utf-8?B?UCtrSTJ3cHk2SDc2VUtSRlpZK1hvZnlkNzRaRW9SRkZlR2lJbFRyNTlwZlkw?=
 =?utf-8?B?bEV5dmorNzBiSFI4ZDdJS2VrZjhjNElOcUhnSkxvWGp0VUpQQW1McVNJL3p3?=
 =?utf-8?B?WHVjSW95bGh2NVhyVHJ5azhYMEUraE1sd3VqWWViZk1JS3A2SUhVeCtZbS9a?=
 =?utf-8?B?YlRWUjNYZldvYVN1VDlEenJ4czdsTUw4K21uWE1TQ2Fvd0FVUlo2bkZlNk1n?=
 =?utf-8?B?ZTdudG5tSzEvUUFFVDlVampKVVJpYzMzY0VDUWpieWtkNFN3RmF2TTNrUGJQ?=
 =?utf-8?B?dzZBTlBjNHpTQ0NqVkN2TnBIOVcraHBtYTdZMWZmODhERm5VQTA0am5xcmx1?=
 =?utf-8?B?cW1OY1VOc2VWRkdlU3M2c2Rnd3VDQ3hxMTJpVVpMVDlzdkhjM0dBRUp4dzhz?=
 =?utf-8?B?cVJHUzNEMXovZ0JyOU13TzJmRHdyL3RQTW5EZUdmeUZzcDErRGt2SjRmenha?=
 =?utf-8?B?NGlFUXdXOUxuRW5DUG5CbWMyRGVnTDR1UDVSbHR2aEJuSzFYNk5KMjRGT0xO?=
 =?utf-8?B?ZmNBdkEvdTVRNGJEOFVMc3ZjOCtaWWZIOGZjdkgrUXMrRWxBb1JZbFJSN2Rv?=
 =?utf-8?B?NHl4SmwwSHhLWlMxMFFpYUx0S1BKL0dwamNhbkoxMEFlcnRVcDZXQ010V3po?=
 =?utf-8?B?K0pNRWlaRFhFRzZha0dpZW1nNnlNSm1pT3ROaHE3dHU3ckRoeFVham5HbEYz?=
 =?utf-8?B?NVNHZ0pNTDlYMEtqRFNCbFE3ZTdTQXJrakMzdkowN1o1dS90QXFDbmVWa2VC?=
 =?utf-8?B?Yk5uRE9lbGwxdTlmZ0Nmam9SY2pJY2RBSVpGNkhCd2M3MndTczlodkZ1N2RD?=
 =?utf-8?B?eUFBZHlNcEdQNE16OGVUbmdjTWFsc0hGSDUrdnNodjlMTTNreER1bnROajQ4?=
 =?utf-8?B?VWJ3d25aQU8yYWFPT25OaGNudEtPSkVIQzlkU09rVzBnenQ1a2hpVkYzM1ZF?=
 =?utf-8?B?SFRzVWVCNThTVmlYWk9RUlhzM2Z3NDA1Rnl3dXhUNEpqU0lucklCY2tLREdQ?=
 =?utf-8?B?OHVOM0IzeWlIUzFHT2pDVjV2M2FJUElZU2kxRC82ZUJ3ZDhVbC9SdUdVWjlP?=
 =?utf-8?B?SWxVTWszYklRRzQ2OTlTQUhDVUtzbk9iWWVHNVJ0akw4ME1TczFqNWtyTjRY?=
 =?utf-8?B?ZTVidFJkUXZndmM0cytrNm94bjdGMHBBSU1iWkVldlRJRTY3TlVLWHZCbVR0?=
 =?utf-8?B?dGZjTTdkT3ZnVWtQMlpiSk5aKzVOdURTNm5mYVg3MS9DRGdVdTEwcC9MN0lN?=
 =?utf-8?B?dmlwSk1hYUtOMDZtNXNtTXorQVc1WVN5aG02OFV0ODRuRkFHb3UvODg5RDVh?=
 =?utf-8?B?SVRaTTAycmtRckVsK0x1QVpQV3NyTUMvay83NG1Ud0hDTnhDZFU5Q2hFdnc2?=
 =?utf-8?B?bDBiN1lhSmhVV0tDbzBldWJJMU1hcGpGTi8yY0pidlgzSnc3RjFFV3pZVTBi?=
 =?utf-8?B?MDVVYUVpTHF3STMweDJ0Z0tHdXlJWGhHaEZ5TWdVQU5nZDNNT1NsN0thQ20y?=
 =?utf-8?B?ck92N3VDalNNVXVQT3hVRDBGSTJXeDg5UEdoV08vOTg3Q3poQWtNRHI2ZzFI?=
 =?utf-8?B?S29NdTQxaldETW9FNHVQbzFvUE1QbTJqbmY0RXlxejFhWHBKS2dVUm83dVVy?=
 =?utf-8?B?MUJwU1ZUL2RLYlB0MkpQbHJwLytpT2NFb21nbVlFUUNZbExvSXdNb2VEdnNL?=
 =?utf-8?Q?KBVvYgwMKYJ7Bk0nujFUdHGQNjOau8Cf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWJ6ZDZ6MGpRSm5UWDdncWlrMTRaTUhPVW4wdHc3MDZiVzNNS05KZThjSXV2?=
 =?utf-8?B?NEk2aEpVMVZiQTlUd3NnTFZxNzh3QnpRY0ZvWmpaZElQdWJxRk9rM3A5azlC?=
 =?utf-8?B?Z1Y3K2lQK0ZvUXpYRE9DWHVXeFVFY2pmWnhGcFg2VktKMUJOdFlKOVg0RnF4?=
 =?utf-8?B?QzR2SmY3U2p6TVZMOHBKZndKdUZGcjdNckpuc1hHVHNvbStGdHlGdjFYc0pQ?=
 =?utf-8?B?UHNxaHpxZmZWbElqSkxQWjU0SThOL2p0eEdiaUJTZkNFb3dzQkJtVmdMMWdC?=
 =?utf-8?B?NTFncDliTldhWUQ1TkswaWVzOEVvNDVheWV0YSthbHZ2aDJBTHJ0UG1WdTZY?=
 =?utf-8?B?RHhheVpldkVvMndLUDM1eWx6Rm02OGI3WjV0Rk9oNzZFRFdHbnRuRExCV3hr?=
 =?utf-8?B?cThGZEtyTUZrcFdFNUI1ajNSTWhUK09jOTRQSDRtVUZxTDJEaUFVTHpKYnlM?=
 =?utf-8?B?MjJzRksyczJETndsQ3NMNjNTbFM0WDhoVC9vRlN3bng1OEorTGJZZUMyaXVp?=
 =?utf-8?B?N280SGtaU1hucmZFS213UHhPUzNOa1dyektGRXM4dzkxZStIYldEaUFvKzdp?=
 =?utf-8?B?Y0FtZi92NitxZXBDVHNrd1liQkRaTG9Ec2RiY1BNRmlGVENQU0tNZWQxYWh1?=
 =?utf-8?B?Sm9TMWdOSTVwSGVnbnZoQWlvdnQwUEZjNXdDdlFkbGl1aEovQmxpT0Fndlhz?=
 =?utf-8?B?UEllQk5wbzNTN3IzWnFubnVLZDVFZlJVWUIrNzhlTXNFTzQ5WGIxNFQwdGEw?=
 =?utf-8?B?VGlXWGlTeEdBUUpjOW1sa1B5MW1UeFlVL2phMDk0NkJ3bXJWQjZjWlFiMUNG?=
 =?utf-8?B?Vkxsc3lxUzRZeXNTemJrb01OdlB0R0lsYVIrSmZwNEZjTGg5MlZxZkMrQ09X?=
 =?utf-8?B?K3ZucFpyVVBNVDBVYllKc0pQQ2srUEtrdGNIaG5EQzhLZFJZMzNISU14ZGI2?=
 =?utf-8?B?OG1yV2drM2hYQVA1YzFYSFJrbHVIRHc0ck8zV042UFlGZTVOblBGWXBIMnlu?=
 =?utf-8?B?Q0dNV1dNZ2NRbmxOSHVXQjRsWDlqYXZITm51RU0reGZjQnFjMzc2blBEeGF3?=
 =?utf-8?B?ZzZQemZqUU41Ukc0NHdMcU9GN1JNeitzKzlSdVlqbTRIZmpPYlMrRnQxYTh5?=
 =?utf-8?B?a3FDZjE3VTA4UUR2N25PR0Z1aTFKdlVKYThRbHZlWW1uWWRYUm9vUUNEOTho?=
 =?utf-8?B?VEJ1d0hORmRJbzlxTmQzblpzKzJIN1lSWVlXcXozZEtNbkpobmxrQ1RSVTVB?=
 =?utf-8?B?TFI5SDl6bk1kMENQTTZRWlpDTzNBRitqZDVaeWg4NGpDNkRpUEYzamttZzFt?=
 =?utf-8?B?VTB1VDNLNFZaRWtiS0Uxb0orQXlQYWhicUJUN2NzUDRMVlVrV29BUkZXYzNu?=
 =?utf-8?B?WXBhRG4xMUNVNkpJNzBJdHVERldxUHFkbVg4Z1FFZHdNMWdhT1pHY0VHSHEx?=
 =?utf-8?B?eHlUU280SE5YaGI2YjRNNGdnRStwbUtFWHhUN1Q0SXFFOHEvZmlKaUJFbEhu?=
 =?utf-8?B?elJianZBa2VtYXZwT3RMVyswdmdCZDdOK3J3MndZcEVHUjFjT2c0cjVxVnJX?=
 =?utf-8?B?UXRLQ0VvUGdZZ2xzZ2FwWHc0WmZUeC9tYkZOclhmQWxMVy9HZldWYWtiMW1C?=
 =?utf-8?B?eDNqQTVqYlM4YVo3NTdYYTloaXd5OGFPYUNMbmREOXRkbUFvWDJWVFlHa2lI?=
 =?utf-8?B?WUw2VDhBNDk4RXBZU255OEM4WklGRU5zR09wU284a1dHMEJWZ3VQa2RGR0xE?=
 =?utf-8?B?OXpFeVkyb0sxS20wN3UwamY4ZHFpa09rb01DWEFpaW5yT2R1V084SHh0YWcx?=
 =?utf-8?B?R0lpVlZJa2NrbXExNXdaZWNyTktIYjdnL3lzb1hEMlRuMFlXbnVtZTlSWjlj?=
 =?utf-8?B?amtrNVR3THdqbXVDR1BFQXRqa1pQeFppVGZ4MTdZMmlpNGd1b2MxTE5FQVJx?=
 =?utf-8?B?RXpnQ0k1TjhoME9pcnJhYWJ2c3BteGFPeTNjTVlTZThYMk83MU9PZlhTa3Vx?=
 =?utf-8?B?YmgyRWhtdktJbzAralpGdEcyYVFQWVdjM3laSnBUQmRiSHduQlJ6VUx5Sms1?=
 =?utf-8?B?VHAvMlNuaW56RDhnNytLWmpxeFBFakYwQzJzU3l5Rm16YmlBd3RYMEhsVGJ5?=
 =?utf-8?B?Ry92Mkd2MnBub2VEVEFmdUlYS2dJeTJjYzJGczVNN0RmcEdrUkdRc1JuMmVo?=
 =?utf-8?B?SW5yaUJCVUIvS0o4ZXBtdGVHbU9rN0FYZHlFeWZmRWYrUUdEN083eE8zRTVC?=
 =?utf-8?B?cUlDb2xoVTRkSGIzeDNOa043LzgvVmtsejNObTFyUUtwZXIyMEpVSjFKMTgy?=
 =?utf-8?B?WTlxVXRRcklYUlF4WG1pTlg0UzNaUWZtWTRUcTM3YXBvMnhXTzY3cjZWYzkz?=
 =?utf-8?Q?xdBzWPtsjWWOaJf4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a24c8b2-07eb-4e54-cf0d-08de522762a0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 22:10:24.6262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUhBTss02GwF8eMMxlfyTF7xUquIYEj9IFXR7znqibBsLCheRcQjkcXA0WzZHe0jFZEBonMXahQNkorl3rKs3DLGkTknViPnzJcM1AtUYqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6020
X-OriginatorOrg: intel.com

Balbir Singh wrote:
[..]
> > I agree with Gregory the name does not matter as much as the
> > documentation explaining what the name means. I am ok if others do not
> > sign onto the rationale for why not include _MEMORY, but lets capture
> > something that tries to clarify that this is a unique node state that
> > can have "all of the above" memory types relative to the existing
> > _MEMORY states.
> > 
> 
> To me, N_ is a common prefix, we do have N_HIGH_MEMORY, N_NORMAL_MEMORY.
> N_PRIVATE does not tell me if it's CPU or memory related.

True that confusion about whether N_PRIVATE can apply to CPUs is there.
How about split the difference and call this:

    N_MEM_PRIVATE

To make it both distinct from _MEMORY and _HIGH_MEMORY which describe
ZONE limitations and distinct from N_CPU.

